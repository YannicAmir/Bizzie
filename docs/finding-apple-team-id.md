# Finding Your Apple Team ID for FreeRASP

To configure FreeRASP for iOS, you need to provide your **Apple Team ID**. This is a 10-character alphanumeric string associated with your Apple Developer account.

## Method 1: Apple Developer Portal (Web)

This is the most direct way to find your ID:

1.  Go to [developer.apple.com](https://developer.apple.com/) and sign in.
2.  Click on **Account** in the top navigation bar.
3.  On the sidebar, click on **Membership**.
4.  Your **Team ID** will be listed under "Membership Information".

## Method 2: Keychain Access (macOS)

If you have your developer certificates installed on your Mac:

1.  Open **Keychain Access** app.
2.  Search for your **Apple Development** or **iPhone Developer** certificate.
3.  Double-click the certificate to open it.
4.  Look for the **Organizational Unit** field under the "Subject" section. That 10-character code is your Team ID.

## Method 3: Xcode

1.  In your project, open the `ios/Runner.xcworkspace` in Xcode.
2.  Select the **Runner** project in the left navigator.
3.  Go to the **Signing & Capabilities** tab.
4.  Under the **Team** dropdown, you should see your team name.
5.  If you click on it or check the project settings, the ID is often visible or implicitly used here. (Method 1 is more reliable for the exact string).

---

### Provide the Team ID

Please provide the **10-character Team ID** so I can update the `SecurityService` configuration.
