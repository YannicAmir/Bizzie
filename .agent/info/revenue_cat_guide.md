# RevenueCat Integration & Testing Guide

This guide explains how the subscription system is "rigged up" in Bizzie and how you can test it across different environments.

---

## 💡 The RevenueCat Hierarchy (Beginner Analogy)

If RevenueCat was a **Nightclub**, here is how the terms would map:

### 🎟️ **Entitlement**: The "VIP Lounge" (The What)
- **Concept**: This is the "benefit" the user is trying to get.
- **Analogy**: You want to enter the **VIP Lounge**. The bouncer doesn't care *how* much you paid or *which* ticket you bought; they only care if you have the "VIP" stamp on your hand.
- **In Bizzie**: Our entitlement is named `plus`. We check if the user has this before showing Premium data.

### 💵 **Product**: The "Box Office Tickets" (The Price)
- **Concept**: These are the physical items registered in App Store Connect.
- **Analogy**: At the door, you can buy a "One Night Pass" for $30 or a "Season Pass" for $200. These are the specific SKUs.
- **In Bizzie**: Our products are `...plus.annual.full` and `...plus.monthly.full`.

### 📦 **Package**: The "Combo Deal" (The Bundle)
- **Concept**: In RevenueCat, a package wraps a physical **Product** (The Price) and gives it a logical name like "Annual".
- **Analogy**: A specific ticket + a free drink. It’s the way the ticket is presented.

### 📜 **Offering**: "Tonight's Specials" (The Menu)
- **Concept**: This is the "menu" of packages you show the user.
- **Analogy**: On a standard night, the board says "Annual or Monthly." On Black Friday, you might swap the board to show a "Discounted Annual" special.
- **In Bizzie**: We fetch the "Current Offering". This lets us change the paywall remotely with one click in the RC Dashboard without updating the app code.

---

## 1. How the Logic Works (The "Wiring")

In this project, we use **RevenueCat (RC)** to handle the complexity of the App Store. Here is the flow from button tap to successful purchase:

### **A. Offerings & Packages**
- **RevenueCat Side**: You define "Packages" in the RC Dashboard (e.g., Annual, Monthly, Discount). These are tied to the actual Apple In-App Purchase IDs you show in your screenshot.
- **App Side**: When the Paywall opens, the `SubscriptionBloc` fetches the "Current Offering" from RC. This offering contains a list of `SubscriptionPackage` objects.

### **B. Tapping a Plan**
When a user selects a plan (Standard Annual, Monthly, or the New Discounted Annual) and taps the button:
1. The view emits a `SubscriptionPurchaseRequested(package)` event.
2. The `SubscriptionBloc` calls the `PurchaseSubscriptionUseCase`.
3. The `SubscriptionRemoteDataSource` find the cached RC package that matches the identifier (e.g., `...plus.annual.discount`) and tells RevenueCat to start the purchase.

---

## 2. Environment-Specific Testing

### **A. Development (Simulator)**
> [!IMPORTANT]
> Apple does not support the actual "App Store" on a simulator. To test "purchases" here, you must use a **StoreKit Configuration File**.

1. **Create File**: In Xcode, go to `File > New > File...` and select **StoreKit Configuration File**.
2. **Add Products**: Add the three products (`annual.full`, `monthly.full`, `annual.discount`) exactly as they appear in App Store Connect.
3. **Link to Scheme**: In Xcode, click your App Scheme (Bizzie) > **Edit Scheme...** > **Run** > **Options** tab. Set "StoreKit Configuration" to the file you just created.
4. **Result**: Tapping "Continue" will show a system dialog that says "Xcode" instead of the real App Store. This is free and instant!

### **B. QA (Physical Device)**
> [!TIP]
> This uses the real Apple Sandbox environment. You need a device and a **Sandbox Identity**.

1. **Sandbox User**: Go to **App Store Connect > Users and Access > Sandbox Testers** and create a test account with a real email you can access.
2. **Sign In**: On your physical iPhone, go to **Settings > App Store > Sandbox Account** and sign in there.
3. **Build & Test**: Run the app (usually via TestFlight or a profile build). When you purchase, you will see a "Sandbox" badge. 
4. **RevenueCat Dashboard**: You can see these transactions in the "Customers" tab. They will have a yellow "Sandbox" tag.

### **C. Preparation for Production**
1. **App Store Connect**: Ensure all In-App Purchases have the status **"Ready to Submit"** or **"Approved"**. 
2. **API Keys**: Ensure your `revenueCatApiKeyIos` in the production environment is set to your **Public SDK Key** (not the secret key).
3. **Entitlements**: In RevenueCat, make sure all three products are attached to your **"plus"** or **"premium"** entitlement. This is what the app checks to determine if the user has paid.

---

## 4. Common Errors & Troubleshooting

### **B. Multi-Flavor Setup (Dev/QA/Prod)**
When using separate RevenueCat "Apps" for different environments (to match `.dev` and `.qa` bundle IDs), you must ensure your Product Catalog is mirrored correctly:

1.  **Project Level**: You only need one **Entitlement** (e.g., `plus`) and one **Offering** (e.g., `default`) per project.
2.  **App Level**: Each environment app (Dev, QA, Prod) must have the products registered in **Product Catalog > Products**.
    - Go to **Product Catalog > Products**.
    - For **Bizzie (Dev)** and **Bizzie (QA)**, click **+ New**.
    - Enter the **exact Product ID** used in your `Bizzie.storekit` file or App Store Connect.
3.  **Offerings Mapping (The "Bridge"):**
    - Go to **Offerings** tab in RevenueCat.
    - Click on the **Offering ID** (e.g., `default`).
    - **Crucial Step**: Click on the **Package ID** itself (e.g., click the text `bizzie_annual` or the box).
    - This opens the **Package Detail** page.
    - Look for the **Products** section at the bottom.
    - Click **+ Attach** (or the blue Attach link).
    - In the list that appears, select the products for **Bizzie (Dev)** and **Bizzie (QA)**.
    - **Result**: You should see 3 Apple icons (one for each app) listed under that single package.

### **C. Error 23: CONFIGURATION_ERROR**
**Message**: *"You have configured the SDK with an App Store API key, but there are no App Store products registered in the RevenueCat dashboard for your offerings."*

This error means RevenueCat found the offering (e.g., your "Current" offering), but it has **0 products** that are valid for the App Store.

**Checklist to Fix**:
1.  **Multiple Apps in RC**: If you have both **"Bizzie"** and **"Bizzie (Dev)"** apps in the RevenueCat project settings, ensure the API key in `.env.dev` matches the app where the products are actually listed. (Based on your screenshots, the products are under the main app, so you might be using the "Dev" key by mistake).
2.  **Product Catalog**: In the RevenueCat Dashboard, go to **Product Catalog > Products**. Ensure the products are listed under the **same app** as the API key you are using.
3.  **Bundle ID vs. Product ID Prefix**: 
    - In your `Bizzie.storekit` (and App Store Connect), you are using `io.getbizzie.bizzieapp.plus.annual.full`. 
    - Note that `io.getbizzie.bizzieapp` is your **PROD** bundle ID. 
    - If you are running the **DEV** flavor (`io.getbizzie.bizzieapp.dev`), ensure that your Project in RevenueCat has the products registered for **both apps**.
    - **Crucial**: Ensure the Product ID in the RevenueCat Dashboard is **exactly** what the store reports. If StoreKit says `io.getbizzie.bizzieapp.plus...` but RC is configured for just `plus...`, it will fail.
4.  **Agreements**: Ensure the **Paid Applications Agreement** is signed in App Store Connect. (You confirmed this is active).
5.  **Simulator Specifics**: If using the simulator, you **must** select the StoreKit Configuration in your Xcode scheme. Without it, the App Store will return 0 products in a simulator environment.
### **D. Shared Credentials (.p8 Keys)**
> [!TIP]
> **Pro Tip**: You only ever need **ONE** `.p8` file for your entire Apple Developer account. 
> 
> - Apple generates these keys at the **Account Level**, not the App Level.
> - You can (and should) reuse the same `.p8` file, Key ID, and Issuer ID for your Dev, QA, and Prod apps in RevenueCat. 
> - Simply upload the same file to all three apps in the RevenueCat dashboard.
