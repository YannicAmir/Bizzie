# Force App Upgrade (FAU) Management Guide

This guide explains how to manage and trigger the **Force App Upgrade (FAU)** mode using Firebase Remote Config once the feature is implemented in the Bizzie app.

## Overview

FAU is triggered when the version of the app installed on a user's device is lower than the **Minimum Required Version** defined in Firebase Remote Config.

## 1. Firebase Remote Config Setup

To manage the upgrade, you will interact with the following key in the Firebase Console:

| Key | Type | Description |
| :--- | :--- | :--- |
| `min_app_version` | String | The lowest version number (e.g., `1.1.0`) that is allowed to run without an upgrade. |
| `app_store_link` | String | The URL to the Bizzie app on the Apple App Store. |
| `play_store_link` | String | The URL to the Bizzie app on the Google Play Store. |

### How to Change the Version
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Select your project.
3. Navigate to **Remote Config** (under the "Run" section).
4. Find the `min_app_version` parameter.
5. Update the **Value** to the new requirement (e.g., change `1.0.0` to `1.1.0`).
6. Click **Save** and then **Publish changes**.

> [!IMPORTANT]
> Always verify that the new version is fully available and approved in both the Apple App Store and Google Play Store **before** updating `min_app_version` in Remote Config.

---

## 2. Versioning Logic

The Bizzie app uses **Semantic Versioning (SemVer)** to compare the current app version against the Remote Config requirement.

### Version Components
- **App Version**: Defined in `pubspec.yaml` (e.g., `1.2.3`).
- **Build Number**: The number after the `+` sign (e.g., `1.2.3+45`).

### Comparison Rule
The FAU logic typically ignores the build number and focuses on the semantic version (`major.minor.patch`).

- **Scenario A**: `min_app_version` is `1.1.0`, App is `1.0.9` -> **FAU Triggered**.
- **Scenario B**: `min_app_version` is `1.1.0`, App is `1.1.0` -> **Normal Operation**.
- **Scenario C**: `min_app_version` is `1.1.0`, App is `1.2.0` -> **Normal Operation**.

---

## 3. Best Practices for Release

To ensure a smooth user experience when forcing an upgrade:

1.  **Staged Rollouts**: If you use staged rollouts in the App Store/Play Store, wait until 100% of users have the update available before setting the mandatory minimum version.
2.  **Grace Period**: Provide a few days between releasing a new version and making it mandatory.
3.  **Critical Fixes**: Only use FAU for critical security patches, breaking API changes, or essential feature updates that require a specific app state.
4.  **Testing**: Before publishing a global change, you can use **Firebase Remote Config Conditions** to test the FAU screen on a internal test device by targeting a specific User ID or Device.

## 4. Maintenance & Support

If a user reports being stuck on the FAU screen:
- Verify their internet connection (the app needs to fetch the config).
- Ensure they are actually on an older version.
- Advise them to check for updates in the App Store/Play Store.
