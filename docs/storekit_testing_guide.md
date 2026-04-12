# StoreKit Testing: Subscription Lifecycle & Restore Purchases

This guide explains the best practice workflows for simulating subscription events and the mechanism behind "Restore Purchases."

## 1. What is "Restore Purchases"?

### Purpose
The "Restore Purchases" button is a mandatory requirement for any iOS app that offers non-consumable in-app purchases or subscriptions. It allows users to regain access to content they've already paid for without being charged again.

### Common Scenarios
- **New Device**: User gets a new iPhone and installs your app.
- **Reinstall**: User deletes the app and re-installs it later.
- **Lost Sync**: The local app receipt somehow becomes out of sync with the App Store.

### How it Works (with RevenueCat)
1. **Trigger**: User taps the "Restore" button.
2. **Receipt Access**: The app reads the encrypted **App Store Receipt** stored on the device.
3. **Sync**: RevenueCat sends this receipt to its backend servers.
4. **Validation**: RevenueCat validates the receipt with Apple and checks for any active entitlements.
5. **Entitlement Grant**: If a valid subscription is found, RevenueCat updates the local `CustomerInfo`, and your app unlocks the content.

---

## 2. Best Practices: Simulating Lifecycle Stages

To test these scenarios, use the **StoreKit Transaction Manager** in Xcode while the app is running.

### Scenario A: Initial Purchase & Usage
1. Open the Paywall.
2. Select a plan and complete the purchase.
3. Verify the transaction appears in Xcode (`Debug` > `StoreKit` > `Manage Transactions`).

### Scenario B: Simulate Lapse (Expiration)
1. In Xcode's Transaction Manager, find the active subscription.
2. Right-click the transaction and select **Expire Transaction**.
3. Re-open the app or trigger a refresh.
4. **Result**: Your app should now treat the user as "Ineligible" for a trial and show the "Continue" button on the Paywall.

### Scenario C: Buying Again (Re-subscription)
1. Ensure the previous transaction is **expired** or **deleted**.
2. Open the Paywall.
3. Purchase the plan again.
4. **Result**: The App Store should process a "renewal" or a "new" transaction depending on whether it was deleted or just expired.

---

## 3. Best Practices: Testing "Restore Purchases"

To manually test if your "Restore" button works exactly like it should in production:

1. **Simulate "Fresh Install" state**:
   - In Xcode's Transaction Manager, **Delete** all existing transactions for your test account.
   - Uninstall the app from the simulator.
2. **Re-purchase**: 
   - Reinstall the app and buy a subscription.
3. **Trigger the "Lost" state**:
   - In Xcode's Transaction Manager, **Delete** the transaction again (this mimics the device not having the record, but the App Store still knowing you own it).
   - Your app will likely show the "Paywall" again because the local receipt looks empty.
4. **Test Restore**:
   - Tap your **Restore** button.
   - **Result**: Even though you "deleted" it locally, the App Store will provide a fresh receipt with the purchase history. RevenueCat will sync it, and your app should unlock automatically.

---

## 4. Key Pro-Tip for Faster Testing
In your `.storekit` file, you can change the **Subscription Renewal Rate**. 
- Set it to **"1 Month every 30 Seconds"** or similar. 
- This allows you to watch the app transition through multiple renewals and eventual lapses in real-time without waiting days.
