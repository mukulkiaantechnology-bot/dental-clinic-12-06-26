'use strict';
const billingService = require('./billing.service');
const { success, error } = require('../../utils/response');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY || 'sk_test_mock');

/**
 * GET /billing/subscription
 * Get active plan and invoicing details for clinicowner
 */
const getSubscription = async (req, res, next) => {
  try {
    const clinicId = req.user.clinicId;
    if (!clinicId) {
      return error(res, 'User is not linked to a clinic', 403);
    }
    const details = await billingService.getSubscriptionByClinicId(clinicId);
    return success(res, details, 'Subscription details fetched successfully');
  } catch (err) {
    next(err);
  }
};

/**
 * POST /billing/create-checkout-session
 * Create a Stripe checkout portal URL
 */
const createCheckoutSession = async (req, res, next) => {
  try {
    const { planId } = req.body;
    const clinicId = req.user.clinicId;
    if (!clinicId) {
      return error(res, 'User is not linked to a clinic', 403);
    }
    if (!planId) {
      return error(res, 'Plan ID is required', 400);
    }

    const frontendUrl = process.env.FRONTEND_URL || 'http://localhost:5173';
    const successUrl = `${frontendUrl}/clinic/subscription?payment=success&planId=${planId}`;
    const cancelUrl = `${frontendUrl}/clinic/subscription?payment=cancel`;

    const result = await billingService.createCheckoutSession({
      clinicId,
      planId,
      successUrl,
      cancelUrl
    });

    return success(res, result, 'Checkout portal generated successfully');
  } catch (err) {
    next(err);
  }
};

/**
 * POST /billing/webhook
 * Stripe webhook receiver supporting both real Stripe constructEvent and developer mock callbacks
 */
const handleWebhook = async (req, res, next) => {
  let event = req.body;

  // Real Stripe signature check
  if (process.env.STRIPE_SECRET_KEY && process.env.STRIPE_WEBHOOK_SECRET) {
    const sig = req.headers['stripe-signature'];
    try {
      event = stripe.webhooks.constructEvent(req.rawBody, sig, process.env.STRIPE_WEBHOOK_SECRET);
    } catch (err) {
      console.error(`❌ Stripe Webhook Signature Check Failed: ${err.message}`);
      return res.status(400).send(`Webhook Error: ${err.message}`);
    }
  } else {
    console.log('[Stripe Webhook Mock] Raw body validation skipped. Executing mock event payload.');
  }

  try {
    console.log(`[Stripe Webhook Event] Processing event: ${event.type}`);

    switch (event.type) {
      case 'checkout.session.completed': {
        const session = event.data.object;
        const clinicId = session.metadata?.clinicId;
        const planId = session.metadata?.planId;
        if (clinicId && planId) {
          await billingService.activateSubscription({
            clinicId,
            planId,
            stripeCustomerId: session.customer,
            stripeSubscriptionId: session.subscription,
            amountPaid: session.amount_total ? session.amount_total / 100 : null
          });
        }
        break;
      }
      case 'invoice.paid': {
        const invoice = event.data.object;
        // Search subscription to map clinic
        const subscriptionId = invoice.subscription;
        if (subscriptionId) {
          const prisma = require('../../config/db');
          const sub = await prisma.subscription.findUnique({
            where: { stripeSubscriptionId: subscriptionId }
          });
          if (sub) {
            await billingService.activateSubscription({
              clinicId: sub.clinicId,
              planId: sub.planId,
              stripeCustomerId: invoice.customer,
              stripeSubscriptionId: subscriptionId,
              amountPaid: invoice.amount_paid ? invoice.amount_paid / 100 : null
            });
          }
        }
        break;
      }
      case 'invoice.payment_failed': {
        const invoice = event.data.object;
        if (invoice.subscription) {
          await billingService.deactivateSubscription(invoice.subscription);
        }
        break;
      }
      case 'customer.subscription.deleted': {
        const subscription = event.data.object;
        await billingService.deactivateSubscription(subscription.id);
        break;
      }
      default:
        console.log(`[Stripe Webhook Event] Unhandled event: ${event.type}`);
    }

    return res.json({ received: true });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getSubscription,
  createCheckoutSession,
  handleWebhook
};
