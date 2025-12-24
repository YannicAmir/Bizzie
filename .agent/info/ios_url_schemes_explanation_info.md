# iOS URL Schemes & Roles Explanation

`CFBundleURLTypes` is a configuration key in iOS that defines **URL Schemes** your app allows the system to open. Think of it like defining a "custom website address" for your app (e.g., `myapp://`).

## In the context of Authentication (Google/Apple)

*   **Usage:** When a user logs in via the browser or the Google app, the process needs a way to "jump back" into your app to deliver the success token.
*   **Mechanism:** It tries to open a URL like `com.googleusercontent.apps.123456...://`.
*   **CFBundleURLTypes:** This list tells iOS, "Hey, if anyone tries to open a URL starting with `com.google...`, please wake up **Bizzie** to handle it."

## Roles Explanation (`CFBundleTypeRole`)

The `CFBundleTypeRole` key defines the app's relationship to that URL scheme. There are essentially two main values:

### Editor (Most Common for Auth)

*   **Meaning:** Your app is the **Creator/Owner** of this URL scheme. You have full control over it.
*   **Why use it here?** The `REVERSED_CLIENT_ID` is unique to your specific Firebase project. No other app in the world should be handling authentication callbacks for *your* specific Google Client ID. Therefore, you are the **Editor**.

### Viewer

*   **Meaning:** Your app can *read* or *handle* this file/URL type, but it doesn't own it.
*   **Example:** A PDF reader app might list itself as a `Viewer` for `.pdf` files. It didn't invent PDFs, but it can open them.

## Summary for Bizzie

You use **Editor** because these specific URL schemes (the reversed client IDs) are unique identifiers generated specifically for your app instances (Dev, QA, Prod). You want iOS to know your app is the definitive handler for them.
