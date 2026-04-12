# 🚀 App Store Production Deployment Guide (ELI5)

Welcome to the beginner-friendly guide for setting up your automated App Store deployments! 

Right now, your GitHub Action builds the app and sends it to Firebase. We're going to teach it to **also** send the exact same `prod` build directly to the App Store (which automatically puts it into TestFlight for testing, and makes it ready to submit for review).

> [!IMPORTANT]
> **Prerequisite:** This guide assumes your `.github/workflows/deploy.yml` file is configured with the App Store Connect upload step.

To do this, GitHub needs "keys" to the App Store so it can upload the app securely on your behalf. We will use two pieces of information:
1. Your Apple ID Email
2. An "App-Specific Password" (a special, one-time password just for GitHub, so you don't use your real password)

Here is exactly how to set this up step-by-step:

---

## Step 1: Create an App-Specific Password

Apple requires a special "App-Specific Password" whenever third-party tools (like GitHub Actions) want to interact with your developer account.

1. Open your web browser and go to [appleid.apple.com](https://appleid.apple.com/).
2. **Sign In** with the Apple ID you use for your Apple Developer account.
3. Once logged in, click on **App-Specific Passwords** (usually found in the "Sign-In and Security" menu on the left side).
4. Click the **Generate an app-specific password** button (or the `+` icon).
5. Give it a name you'll remember, like `GitHub CI Upload` or `Bizzie Prod Deploy`.
6. Click **Create**.
7. Apple will generate a password that looks something like this: `abcd-efgh-ijkl-mnop`.
8. **Copy this password** exactly as it is. **DO NOT close this window yet**, you will need it for the next step. (If you lose it, you can just revoke it and make a new one).

---

## Step 2: Add the Secrets to GitHub

Now we need to tell GitHub what your Apple email and that new password are. We put them in "Secrets" so nobody else can see them, not even developers looking at the code.

1. Go to your Bizzie repository on **GitHub.com**.
2. Near the top of the repository page, click on the **Settings** tab (the gear icon).
3. On the left sidebar, scroll down and click on **Secrets and variables**, then click on **Actions**.
4. You will see a list of your existing "Repository secrets".
5. Click the green **New repository secret** button.
6. For the **Name**, type exactly this (all capital letters, underscores):
   `APP_STORE_EMAIL`
7. For the **Secret**, type your Apple ID email address (e.g., `[EMAIL_ADDRESS]`).
8. Click **Add secret**.
9. Click the green **New repository secret** button again.
10. For the **Name**, type exactly this:
    `APP_STORE_APP_SPECIFIC_PASSWORD`
11. For the **Secret**, **paste the App-Specific Password** you copied in Step 1 (e.g., `abcd-efgh-ijkl-mnop`).
12. Click **Add secret**.

*Great! GitHub now has the permissions it needs.*

---

## Step 3: Check App Store Connect (Optional Verification)
Before we run the action, make sure your App is set up in App Store Connect.
- Our CI script assumes that you have already created the app placeholder in your [App Store Connect Account](https://appstoreconnect.apple.com/).
- The "Bundle ID" used in the `prod` app (`com.bizzie.app` or whatever it is) must match the Bundle ID of the app created in App Store Connect.

---

## Step 4: Run the Deployment!

Now that everything is ready, you can deploy the app manually from GitHub:

1. Go to your Bizzie repository on **GitHub.com**.
2. Click on the **Actions** tab at the top.
3. On the left sidebar, look under "Workflows" and click on **Manual Deployment**.
4. On the right side, you'll see a small button that says **Run workflow ▾**. Click it.
5. A little menu will pop up asking "Which environment to deploy?". 
6. Click the dropdown and select **prod**.
7. Click the green **Run workflow** button.

### What happens next?
- GitHub will start a new job. 
- It will build the iOS app (`.ipa` file) exactly like it did before.
- First, it will upload that `prod` build to **Firebase App Distribution** (just like before).
- Then, it will use your new Secrets to talk to Apple and upload the same `prod` build straight to **App Store Connect**.

### How to see it:
1. Wait for the GitHub Action to show a green checkmark indicating it finished (this usually takes 20-40 minutes).
2. Go to [App Store Connect](https://appstoreconnect.apple.com/) and click on **My Apps**, then click on **Bizzie**.
3. Go to the **TestFlight** tab at the top.
4. You should see your new build there! Note: Apple usually says "Processing" for about 10-15 minutes before you can actually install it via TestFlight or submit it to the App Store.

**You are all set! 🎉 Enjoy your automated App Store deployments!**
