'use strict';
const prisma = require('../../config/db');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY || 'sk_test_mock');

/**
 * Get current subscription details, active plan limits, and invoicing history for a clinic
 */
const getSubscriptionByClinicId = async (clinicId) => {
  // Fetch active subscription & plan limits
  const subscription = await prisma.subscription.findUnique({
    where: { clinicId },
    include: { plan: true }
  });

  // Fetch SaaS Invoices history
  const invoices = await prisma.saasInvoice.findMany({
    where: { clinicId },
    orderBy: { issueDate: 'desc' }
  });

  // Calculate user and patient counts for metrics
  const activeUsersCount = await prisma.user.count({ where: { clinicId } });
  const activePatientsCount = await prisma.patient.count({ where: { clinicId } });

  return {
    subscription,
    invoices,
    usage: {
      users: activeUsersCount,
      patients: activePatientsCount
    }
  };
};

/**
 * Create a Stripe Checkout Session for subscription plans
 */
const createCheckoutSession = async ({ clinicId, planId, successUrl, cancelUrl }) => {
  const clinic = await prisma.clinic.findUnique({ where: { id: clinicId } });
  const plan = await prisma.plan.findUnique({ where: { id: planId } });
  if (!plan) {
    throw Object.assign(new Error('Selected plan not found'), { statusCode: 404 });
  }

  // Developer Mock Mode Fallback if Stripe key is mock/missing
  if (!process.env.STRIPE_SECRET_KEY || process.env.STRIPE_SECRET_KEY === 'sk_test_mock') {
    console.log(`[Stripe Mock] Simulating checkout redirect for clinic ${clinicId} -> plan ${planId}`);
    const mockRedirectUrl = `${successUrl}?mock_checkout=true&clinicId=${clinicId}&planId=${planId}&amount=${plan.price}`;
    return { url: mockRedirectUrl, isMock: true };
  }

  // 1. Create or retrieve Stripe Customer
  let stripeCustomerId = null;
  const existingSub = await prisma.subscription.findUnique({ where: { clinicId } });
  if (existingSub && existingSub.stripeCustomerId) {
    stripeCustomerId = existingSub.stripeCustomerId;
  } else {
    const customer = await stripe.customers.create({
      email: `${clinic.id}@hms-saas.internal`,
      name: clinic.name,
      metadata: { clinicId }
    });
    stripeCustomerId = customer.id;
  }

  // 2. Generate Stripe Product Price dynamically if predefined ID is absent
  let stripePriceId = plan.id; // Fallback mapping
  if (plan.id === 'plan-basic') stripePriceId = process.env.STRIPE_PRICE_BASIC;
  if (plan.id === 'plan-pro') stripePriceId = process.env.STRIPE_PRICE_PRO;
  if (plan.id === 'plan-enterprise') stripePriceId = process.env.STRIPE_PRICE_ENTERPRISE;

  // If price ID is missing, create a temp one for developer convenience
  if (!stripePriceId || !stripePriceId.startsWith('price_')) {
    const product = await stripe.products.create({ name: `${plan.name} Plan` });
    const price = await stripe.prices.create({
      product: product.id,
      unit_amount: Math.round(plan.price * 100),
      currency: 'usd',
      recurring: { interval: 'month' }
    });
    stripePriceId = price.id;
  }

  // 3. Create Checkout Session
  const session = await stripe.checkout.sessions.create({
    customer: stripeCustomerId,
    payment_method_types: ['card'],
    line_items: [{ price: stripePriceId, quantity: 1 }],
    mode: 'subscription',
    success_url: successUrl,
    cancel_url: cancelUrl,
    metadata: {
      clinicId,
      planId
    }
  });

  return { url: session.url, isMock: false };
};

/**
 * Handle subscription creation/renewal in Database
 */
const activateSubscription = async ({ clinicId, planId, stripeCustomerId, stripeSubscriptionId, amountPaid }) => {
  const plan = await prisma.plan.findUnique({ where: { id: planId } });
  if (!plan) return;

  const clinic = await prisma.clinic.findUnique({ where: { id: clinicId } });
  if (!clinic) return;

  const startDate = new Date();
  const endDate = new Date();
  endDate.setMonth(endDate.getMonth() + 1); // 1 Month duration

  // 1. Upsert Subscription table
  await prisma.subscription.upsert({
    where: { clinicId },
    update: {
      planId,
      stripeCustomerId,
      stripeSubscriptionId,
      status: 'active',
      startDate,
      endDate
    },
    create: {
      clinicId,
      planId,
      stripeCustomerId,
      stripeSubscriptionId,
      status: 'active',
      startDate,
      endDate
    }
  });

  // 2. Sync Plan info directly on Clinic record (Legacy Compatibility)
  // Map 'plan-basic' -> Basic, etc.
  const planEnumMapping = {
    'plan-basic': 'Basic',
    'plan-pro': 'Premium', // mapped to legacy enum field Premium
    'plan-enterprise': 'Enterprise'
  };

  await prisma.clinic.update({
    where: { id: clinicId },
    data: {
      plan: planEnumMapping[planId] || 'Basic',
      status: 'Active',
      monthlyFee: plan.price
    }
  });

  // 3. Add SaaS Invoice Record
  await prisma.saasInvoice.create({
    data: {
      clinicId,
      clinicName: clinic.name,
      amount: amountPaid || plan.price,
      issueDate: new Date(),
      status: 'Paid',
      plan: plan.name
    }
  });

  console.log(`[SaaS Subscriptions] Successfully activated ${plan.name} plan for clinic ${clinic.name}`);
};

/**
 * Handle subscription cancellations/payment failures
 */
const deactivateSubscription = async (stripeSubscriptionId) => {
  const subscription = await prisma.subscription.findUnique({
    where: { stripeSubscriptionId }
  });
  if (!subscription) return;

  await prisma.subscription.update({
    where: { stripeSubscriptionId },
    data: { status: 'inactive' }
  });

  await prisma.clinic.update({
    where: { id: subscription.clinicId },
    data: { status: 'Suspended' }
  });

  console.log(`[SaaS Subscriptions] Suspended clinic ${subscription.clinicId} subscription (Stripe ID: ${stripeSubscriptionId})`);
};

module.exports = {
  getSubscriptionByClinicId,
  createCheckoutSession,
  activateSubscription,
  deactivateSubscription
};
