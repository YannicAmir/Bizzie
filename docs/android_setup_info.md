# Android Environment Setup Guide for Flutter

This guide outlines the steps to configure **Dev**, **QA**, and **Prod** environments for your Android app using Gradle Product Flavors.

## Prerequisites
- Open `android/app/build.gradle.kts` (or `build.gradle` if using Groovy).
- Ensure you have your `main_dev.dart`, `main_qa.dart`, and `main_prod.dart` files ready in `lib/`.

---

## Step 1: Configure Product Flavors in Gradle

1. Open `android/app/build.gradle.kts`.
2. Inside the `android { ... }` block, before `buildTypes`, add the following configuration:

```kotlin
android {
    // ... existing config ...

    flavorDimensions += "env" // Define a dimension named "env"

    productFlavors {
        create("dev") {
            dimension = "env"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "Bizzie Dev")
        }
        create("qa") {
            dimension = "env"
            applicationIdSuffix = ".qa"
            resValue("string", "app_name", "Bizzie QA")
        }
        create("prod") {
            dimension = "env"
            // Start with the main applicationId defined in defaultConfig
            resValue("string", "app_name", "Bizzie")
        }
    }
}
```

**Note**: If you are using Groovy (`build.gradle`), the syntax is slightly different (no `create`, just the name):
```groovy
flavorDimensions "env"
productFlavors {
    dev {
        dimension "env"
        applicationIdSuffix ".dev"
        resValue "string", "app_name", "Bizzie Dev"
    }
    // ... tc.
}
```

---

## Step 2: Update AndroidManifest.xml for App Name

The `app_name` resource value we defined above needs to be used in the Manifest.

1. Open `android/app/src/main/AndroidManifest.xml`.
2. Find the `<application>` tag.
3. Check the `android:label` attribute.
   - **Change it to**: `android:label="@string/app_name"`
   - THIS IS CRITICAL. If it is hardcoded (e.g., "Bizzie"), changing the flavor won't update the icon name.

---

## Step 3: Run the App

You can now run specific flavors using the `--flavor` flag.

### CLI
```bash
# Dev
flutter run --flavor dev -t lib/main_dev.dart

# QA
flutter run --flavor qa -t lib/main_qa.dart

# Prod
flutter run --flavor prod -t lib/main_prod.dart
```

### VS Code (launch.json)
Update your configurations to include the `--flavor` argument (if you haven't already):

```json
{
    "name": "Bizzie Dev",
    "request": "launch",
    "type": "dart",
    "program": "lib/main_dev.dart",
    "args": ["--flavor", "dev"]
}
```

---

## Summary of Results
- **Dev App**: Package `io.getbizzie.bizzieapp.dev`, Name "Bizzie Dev"
- **QA App**: Package `io.getbizzie.bizzieapp.qa`, Name "Bizzie QA"
- **Prod App**: Package `io.getbizzie.bizzieapp`, Name "Bizzie"

You can now install all three on your Android device/emulator simultaneously!
