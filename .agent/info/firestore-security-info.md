# Firestore Security Rules Guide

This guide explains how to update your Firestore Security Rules to allow public access to the `daily_brands` collection, ensuring your onboarding flow works correctly.

## Your Goal
You want to allow the app to **READ** from the `daily_brands` collection without the user being logged in, while keeping everything else locked down.

## Instructions

1.  **Open Firebase Console**: Go to [console.firebase.google.com](https://console.firebase.google.com/).
2.  **Navigate to Rules**: Project Overview -> Build -> Firestore Database -> Rules tab.
3.  **Update the Code**: Match your current rules with the updated version below.

### Your Current Rules:
```groovy
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

### The Updated Rules (Copy & Paste this):
Add the `daily_brands` block inside the main `documents` match block.

```groovy
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    
    // --- NEW RULE START ---
    // Allow public read access to daily_brands so the onboarding screen can load data.
    // We explicitly deny write access (only admin/backend can write).
    match /daily_brands/{document=**} {
      allow read: if true;
      allow write: if false; 
    }
    // --- NEW RULE END ---

    // --- NEW RULE START: Users Collection ---
    // Allow authenticated users to read and write their OWN document in the users collection.
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    // --- NEW RULE END ---

    // Your existing default rule (Deny All)
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

4.  **Publish**: Click the **Publish** button.
5.  **Restart App**: Hot Restart your Flutter app to retry the connection.
