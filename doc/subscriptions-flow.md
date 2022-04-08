# Subscriptions flow

- User registers and is automatically put on trial subscription
- User can see how many days of trial are remaining
- User is warned that trial is about to expire
- User can request trial prolongation (by email) [OPTIONAL]
- After trial is done, user is redirected automatically to "Subscribe screen"
- User can choose from 2 different subscription levels 
  - Standard - Limits clients to 5
  - Premium - No limits on clients
- User picks payment method
  - Only CC is allowed in version 1.0
  - National payment gateways to be integration in version 1.1 or later
- User completes the payment
- User gets access to the platform
- No trial banner is visible any longer
- User can see the subscription status

# Alternate paths

- User can cancel subscription
  - User should have access to platform till the end of subscription period
  - No successive charges should be made

# Products caching

1. Hard-coded
2. Model-based
3. Models synced from Stripe API
4. Models sync triggered by Webhooks
