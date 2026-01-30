# iOS Subscription Setup Guide

This document outlines the manual steps required to set up In-App Purchases (IAP) for iOS and integrate them with RevenueCat.

## 1. App Store Connect Setup

### A. Agreements, Tax, and Banking
- Log in to [App Store Connect](https://appstoreconnect.apple.com/).
- Go to **Agreements, Tax, and Banking**.
- Ensure the **Paid Apps** agreement is signed and your banking/tax information is complete. *You cannot test IAPs without this.*

### B. App Configuration & Subscriptions
- Go to **My Apps** and select your app (**Bizzie**).
- In the left sidebar, scroll down to the **Monetization** section and select **Subscriptions**. 
- Click **Create** to create a **Subscription Group** (you've done this: `Bizzie Plus`).
- **Now, click on your group name (Bizzie Plus) to enter it.** 
- You will see a "Subscriptions" section with a blue **Create** button.
- **You will create THREE products here:**

| Tier | Reference Name | Product ID | Price |
| :--- | :--- | :--- | :--- |
| **1. Annual Full** | `Premium Annual (Full)` | `[bundle_id].plus.annual.full` | $240.00 |
| **2. Monthly Full** | `Premium Monthly (Full)` | `[bundle_id].plus.monthly.full` | $34.95 |
| **3. Annual Discount** | `Premium Annual (Discount)` | `[bundle_id].plus.annual.discount` | $144.00 |

- **Step-by-Step for each subscription:**
    1. Click **Create** in the Subscriptions section.
    2. Enter the **Reference Name** and **Product ID** from the table above.
    3. Click **Create**.
    4. Scroll to **Subscription Prices**, click **Add Subscription Price**, and set the corresponding price.
    5. Repeat for all three.

- **Crucial**: Ensure all three are inside the same **Bizzie Plus** group. This ensures users can't be subscribed to multiple tiers at once.

### C. App Store Connect Shared Secret
- Go to **App Information**.
- Under **App-Specific Shared Secret**, click **Manage**.
- Generate and copy the Shared Secret. *This will be needed in RevenueCat.*

### D. App Store Server Notifications (Real-time updates)
This step ensures that if a user cancels their subscription or gets a refund via Apple, RevenueCat (and your app) finds out immediately.

1.  **Get the URL from RevenueCat**:
    *   In the RevenueCat Dashboard, go to **Apps & providers**.
    *   Click on your iOS app (**Bizzie: Stock Market Companion**).
    *   Scroll down to **Apple Server to Server notification settings**.
    *   Copy the **Apple Server Notification URL**. (It's the long URL starting with `https://api.revenuecat.com/...`).
2.  **Paste into App Store Connect**:
    *   In [App Store Connect](https://appstoreconnect.apple.com/), go to **App Information**.
    *   Scroll down to **App Store Server Notifications** (it's right above the Shared Secret).
    *   Click **Set Up URL** for the **Production Server URL**.
    *   Paste the URL, select **Version 2 Notifications**, and click **Save**.
    *   Do the exact same for the **Sandbox Server URL**.
3.  **Final Check**: Ensure the checkbox **"Track new purchases from server-to-server notifications"** in RevenueCat is **Checked**. (This is your safety net for bad internet connections).

### E. StoreKit 2 & App Store Connect API Key (.p8 file)
This is the "Master Key" that allows RevenueCat to verify subscriptions securely and import products automatically.

1.  **Create the Key in App Store Connect**:
    *   Go to **Users and Access**.
    *   Click the **Integrations** tab at the top.
    *   On the left, select **App Store Connect API** (this is the first option, **NOT** "In-App Purchase").
    *   Click the **+** (plus icon) to create a new key.
    *   **Name**: `RevenueCat_Admin_Key`.
    *   **Access**: Change the role to **App Manager** or **Admin**. (RevenueCat needs this permission to see your app list and products).
    *   Click **Generate**.
2.  **Download the File**:
    *   You will see your new key in the list. Click **Download API Key**.
    *   **Warning**: You can only download this file **ONCE**. Store it safely.
    *   The file will be named something like `AuthKey_ABC123XYZ.p8`.
3.  **Get the IDs from App Store Connect**:
    *   **Issuer ID**: Go to **Users and Access > Integrations**. It is the long string at the top of the page.
    *   **Key ID**: This is the 10-character code in the "Key ID" column next to your new Admin key.
    *   **Vendor Number**: 
        1. Go to the main App Store Connect menu.
        2. Click **Payments and Financial Reports**.
        3. Your **Vendor Number** is in the top-left corner (usually starts with an `8`).
4.  **Upload to RevenueCat**:
    *   In RevenueCat, go to **Apps & providers > [Your App]**.
    *   Scroll to **App Store Connect API**.
    *   Upload the **NEW** `.p8` file.
    *   Paste the **NEW Key ID**, the **Issuer ID**, and the **Vendor Number**.
    *   Click **Save Changes**.

---

## 2. RevenueCat Configuration

### A. Create Project & iOS App
- Log in to the [RevenueCat Dashboard](https://app.revenuecat.com/).
- Create a new Project named **Bizzie**.
- Add an **iOS App**:
    - **App Store Package Name**: Your Bundle ID (e.g., `com.yannicamir.bizzie`).
    - **App Store Connect Shared Secret**: Paste the secret generated in Step 1C.

### B. Finding your API Keys (REVENUECAT_PUBLIC_API_KEY_IOS)
Based on your dashboard (Jan 29, 2026), here are the keys for each environment. You should use **Public SDK Keys** for the Flutter app.

| Environment | RevenueCat App Name | Public SDK Key (appl_...) |
| :--- | :--- | :--- |
| **Dev** | `Bizzie (Dev)` | `dev_api_key` |
| **QA** | `Bizzie (QA)` | `qa_api_key` |
| **Prod** | `Bizzie: Stock Market Companion` | `prod_api_key` |

> [!IMPORTANT]
> **What about "Secret API Keys"?**
> - **Public SDK Keys**: Used in the Flutter app. They only allow non-sensitive actions like making purchases and fetching offerings.
> - **Secret API Keys**: Used ONLY for server-side code (e.g., Cloud Functions). You should generate one if your backend needs to call the RevenueCat REST API directly (e.g., to override a subscription). **NEVER** put a Secret API Key in the Flutter code or Git.

### C. Adding Multiple Flavors (Dev, QA, Prod Bundle IDs)
Since your project uses flavors, you need to tell RevenueCat about all of them so they all "agree" on the same products.

1.  In the RevenueCat sidebar, click **Apps & providers**.
2.  You see your main app (**Bizzie: Stock Market Companion**).
3.  Click the blue **+ Add app config** button in the top right.
4.  **Select App Store** (iOS).
5.  **App name**: Enter `Bizzie (Dev)`.
6.  **App Bundle ID**: Enter `[dev bundle id]` (or whatever your specific dev bundle id is).
7.  **Shared Secret**: Paste the same secret from Step 1C.
8.  **App Store Connect API key**: Click **"Use existing key"** at the top of that section and select your Admin key (`9P22V3V474`). (Since all flavors live under your same Apple account, they all share the same key!)
9.  **Save changes**.
10. **Repeat** these steps for your **QA** bundle ID (e.g., `[qa bundle id]`).

**Pro Tip**: By adding them all to the same **Bizzie** Project in RevenueCat, they will all share the same Entitlements and Offerings automatically!

---
### D. RevenueCat Setup: Step-by-Step (Based on your screenshots)

Looking at your views, here is exactly what you need to click and edit to move from the old setup (Dec 2025) to the new one:

#### Step 1: Import your new Apple Products (Matches Image 0)
*Troubleshooting: If the `Import` button says "No new products available to import", it is usually because the products are stuck in **"Missing Metadata"**. RevenueCat cannot see them until they flip to "Ready to Submit".*

**Solution A: The 2026 "Universal" Dimensions**
`640 x 920` 72 pixels/inch

**Solution B: The "Silent" Blocker (Group Localization)**
Even if your individual products are perfect, the **Subscription Group itself** needs localization.
1. Go back to the **Bizzie Plus** group page.
2. Scroll to the very bottom to the **Localization** section.
3. Click the **+** and add **English (U.S.)**.
4. Give the Group a name (like "Bizzie Plus").
5. **Save.** This is often the actual thing that flips the products to "Ready to Submit."

**Once the status is "Ready to Submit":**
1. Go back to RevenueCat.
2. Go to **Product catalog > Products**.
3. Click the **+ New** button (top right of the Apple app container).
4. **Fill out the "New Product" form for each product using this table:**

| Product | Identifier (Exact Match) | Display Name (Friendly) | Type |
| :--- | :--- | :--- | :--- |
| **1. Annual Full** | [see App Store Connect] | `Bizzie Plus: Annual` | Subscription |
| **2. Monthly Full** | [see App Store Connect] | `Bizzie Plus: Monthly` | Subscription |
| **3. Annual Discount** | [see App Store Connect] | `Bizzie Plus: Special Annual` | Subscription |

5. For each one, click the blue **Create Product** button at the bottom.
6. **Repeat** until all three are in your list. 

*Note: Once these are added, the "Verified" status check will happen automatically the first time you test a purchase in the app.*

#### Step 2: Set up the 'plus' Entitlement
*Note: RevenueCat does not allow you to edit an **Identifier** after it is created. If yours says "Bizzie Plus" and you want "plus", you must delete it and create a new one.*

1. Click the **Entitlements** tab at the top (next to 'Products').
2. If you have an old one (like "Bizzie Plus"), click on it and select **Delete entitlement** at the bottom.
3. Click **+ New Entitlement**.
4. Identifier: `plus`.
5. Once created, click on the name `plus` to enter it.
6. Click **+ Add product** and select all three of your new Apple products. 
   *(This tells RevenueCat: "If they buy ANY of these three, give them 'plus' access")*

#### Step 3: Edit your Offering (Matches Image 1)
1. Click the **Offerings** tab at the top.
2. You see an old offering named **default** (created in Dec 2025). **Click on the word 'default'** to open it.
3. You will see 3 old packages there. **Delete the old packages** using the `...` menu on the right.
4. Now, click **+ New package** 3 times to create the new ones:
   - **Package A**: Identifier: `$rc_annual` | Link it to the `$240 Annual Full` product.
   - **Package B**: Identifier: `$rc_monthly` | Link it to the `$34.95 Monthly Full` product.
   - **Package C**: Identifier: `annual_discount` | Link it to the `$144 Annual Discount` product.

#### Step 4: Set as Current
1. Go back to the main **Offerings** list.
2. Ensure the **blue checkmark** is next to your `default` offering. This tells the app: "Use this menu."

### D. Setting up the Three Tiers (Annual, Monthly, Discount)
To support your three specific offerings across different screens, we will organize them into packages in RevenueCat.

#### Step 1: Create the Products in App Store Connect
(Follow the table in Section 1B above)

#### Step 2: Configure in RevenueCat
1.  **Add Products**: Look at the left sidebar and click on **Product catalog**, then select **Products**. Use the **+ New** button to add your three Product IDs.
2.  **Modify Entitlements**: In the same **Product catalog** menu, click **Entitlements**. Attach **ALL THREE** products to your single `plus` entitlement.
3.  **Offerings & Packages**:
    -   In the **Product catalog** menu, click **Offerings**. 
    -   Open your `default` offering and create three packages:
        -   `$rc_annual`: Linked to the **Annual Full** product.
        -   `$rc_monthly`: Linked to the **Monthly Full** product.
        -   `annual_discount`: Linked to the **Discounted Annual** product.

#### Step 3: Architecture for Multi-Price Support
-   **Full Price Screens**: Fetch the `default` offering and display `$rc_annual` and `$rc_monthly`.
-   **Discount/Promo Screens**: Fetch the `default` offering and specifically display the `annual_discount` package.

### E. Webhook Setup
- Go to **Integrations** in the left sidebar.
- Scroll down periodically or search for **Webhooks**. (It might be under a list of "Available Integrations" if you haven't added it yet).
- Click **+ Add** or **Webhooks**:
    - **Webhook URL**: Your Firebase Function URL (e.g., `https://revenuecatwebhook-xxx-uc.a.run.app`).
    - **Authorization Header**: Set this to match your `REVENUECAT_SECRET_TOKEN` in Firebase Secrets.

---

## 3. Xcode Configuration

### A. Capabilities
- Open `ios/Runner.xcworkspace` in Xcode.
- Select the **Runner** target.
- Go to **Signing & Capabilities**.
- Click **+ Capability** and add **In-App Purchase**.
- Click **+ Capability** and add **Push Notifications**.

### B. StoreKit Configuration (For Simulator Testing)
- In Xcode, go to **File > New > File...**.
- Search for **StoreKit Configuration File**.
- Save it as `Bizzie.storekit` in the `Runner` folder (don't add it to any targets).
- **Pro Tip**: **Check the box** that says "Sync this file with an app in App Store Connect."
    - Select your Team and the Bizzie app.
    - Xcode will automatically pull in your three product IDs so you don't have to type them manually!
- To use this file:
    - Click on your scheme (Bizzie) > **Edit Scheme...**.
    - Select **Run** > **Options**.
    - Set **StoreKit Configuration** to `Bizzie.storekit`.

---

## 4. Testing

### A. Real Device (Sandbox)
- Create a **Sandbox Tester** account in App Store Connect.
- Sign out of iCloud on your test device (or use the separate Sandbox account section in Settings).
- Run the app and complete a purchase.

### B. Simulator
- Use the **StoreKit Configuration File** to simulate successful and failed purchases without needing a real Apple ID.
