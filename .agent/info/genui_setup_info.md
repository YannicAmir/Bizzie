# GenUI Setup Manual Configuration

## 0. Provider Comparison & Recommendations
Before you start, understand the two options Firebase will present to you.

| Feature | **Gemini Developer API** (Left Card) | **Vertex AI Gemini API** (Right Card) |
| :--- | :--- | :--- |
| **Cost** | **Free** (within rate limits) | **Paid** (Pay-as-you-go) |
| **Billing Plan** | Spark (Free) allowed | Blaze (Pay-as-you-go) **Required** |
| **Use Case** | Prototyping, Development, QA | Production, Enterprise Scale |
| **Limits** | Lower rate limits | High scalability |
| **Data Privacy** | Standard | Enterprise-grade compliance |

**Recommendation:**
*   **For Bizzie Dev / QA**: ALWAYS choose **Gemini Developer API**. It is free and sufficient.
*   **For Bizzie Prod**: Start with **Gemini Developer API**. Upgrade to **Vertex AI** only if you hit rate limits or need enterprise SLAs.

## 1. Verify Project Billing (Conditional)
**Requirement:**
*   **Gemini Developer API (Free)**: You can stay on the **Spark (Free)** plan. **SKIP THIS STEP**.
*   **Vertex AI Gemini API (Paid)**: You MUST be on the **Blaze (Pay as you go)** plan.

**How to Upgrade (If choosing Vertex AI):**
*   Go to the [Firebase Console](https://console.firebase.google.com/).
*   Select your project.
*   Look at the bottom left sidebar.
    *   **If it says "Spark"**: Click **Upgrade** -> Select **Blaze**.
    *   **If it says "Blaze"**: You are all set.

## 2. Enable Vertex AI & Gemini APIs
**Why?** The Flutter SDK communicates with these Google Cloud services. They must be enabled for your project.
*   **Locate the AI Section:**
    *   Look at the left sidebar in the Firebase Console.
    *   Find the **AI** category (usually below Analytics).
    *   Click on **AI Logic**.
*   **Enable the Service:**
    *   You should see a "Get started" or "Enable" button for **Vertex AI in Firebase** (or "Firebase AI Logic").
    *   Click it.
    *   **Provider Selection Modal** (Important):
        *   You will see two cards: "Gemini Developer API" and "Vertex AI Gemini API".
        *   **For Dev & QA**: Select **Gemini Developer API** (Left Card).
            *   **Reason**: It is free to start and sufficient for development/testing.
        *   **For Prod**: You can start with Developer API, but **Vertex AI Gemini API** (Right Card) is recommended for high-scale enterprise usage (requires Blaze plan).
    *   **Billing Check**: If requested by the selected option, confirm billing/upgrade.
    *   **API Check**: It will list APIs to enable (`vertexai.googleapis.com`, etc.). Click **Enable**.
*   **Alternative Path (Extensions):**
    *   If you are following a specific tutorial using the "Multimodal Tasks" extension:
    *   Go to **Build > Extensions**.
    *   Search for "Gemini".
    *   Install "Multimodal Tasks with the Gemini API".
*   **Verification**: When you click **AI Logic** again, it should show a dashboard or "My prompts" interface instead of the landing page.

## 3. Configure Firebase App Check (Recommended)
**Status:** You should see a warning banner in the AI Logic tab: "Register your apps with Firebase App Check".
**Why?** This is critical security. It ensures only *your* app can use your free/paid quota, preventing billing fraud.
*   **Action:** In the table under "Your apps", click **+ Register for App Check** next to your Android and iOS apps.
*   **For Android:**
    1.  Click **+ Register for App Check** next to the Android app.
    2.  Select **Provider: Play Integrity** (recommended) or **Debug**.
    3.  It will ask for a **SHA-256 certificate fingerprint**.
    4.  **How to get it:**
        *   Open your project terminal.
        *   Run: `cd android && ./gradlew signingReport`
        *   Look for the `SHA-256` key under `Variant: debug` (since this is your dev app).
        *   Copy the string (looks like `59:A4:...`) and paste it into the Firebase modal.
    5.  Click **Save**.
*   **For iOS:**
    1.  Click **+ Register for App Check** next to the iOS app.
    2.  Select **Provider: DeviceCheck** or **App Attest**.
    3.  It will ask for a **Private Key** (.p8 file) from Apple (Team ID/Key ID).
    4.  **How to get it:**
        *   Go to [Apple Developer Portal](https://developer.apple.com) > Keys.
        *   Create a Key with "DeviceCheck" enabled.
        *   Download the `.p8` file and upload it to the Firebase modal.
    5.  Click **Save**.
    *   **Wait! Do I need to update Provisioning Profiles?**
        *   **Just for the Key?** No.
        *   **To USE the feature (App Attest Capability)?** YES.
        *   **Guide:** If you are ready to enable the capability in Xcode, strictly follow: [App Attest Setup Guide](apple_app_attest_setup_info.md).
*   **Verification**: The table row should now show a green checkmark or "Registered" status.
