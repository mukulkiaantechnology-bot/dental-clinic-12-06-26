'use strict';
const { Router } = require('express');
const { authenticate } = require('../../middlewares/auth.middleware');
const billingController = require('./billing.controller');

const router = Router();

// Endpoint for clinic owners to retrieve active plan info and subscription status
router.get('/subscription', authenticate, billingController.getSubscription);

// Endpoint for clinic owners to buy/upgrade SaaS subscriptions
router.post('/create-checkout-session', authenticate, billingController.createCheckoutSession);

// Endpoint for Stripe event integration (Public webhook)
router.post('/webhook', billingController.handleWebhook);

module.exports = router;
