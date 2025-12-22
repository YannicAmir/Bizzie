#!/bin/bash

# Name of the resource we're copying
PLIST_FILE="GoogleService-Info.plist"

# Get the environment based on the build configuration
# Assuming schemes/configs are named like "Debug-dev", "Release-qa", "Release-prod", "Debug" (default to prod)
# We can also rely on FLUTTER_FLAVOR if set, or parse configuration.

# Default environment
ENVIRONMENT="prod"

if [[ "$CONFIGURATION" == *"-dev"* ]]; then
  ENVIRONMENT="dev"
elif [[ "$CONFIGURATION" == *"-qa"* ]]; then
  ENVIRONMENT="qa"
elif [[ "$CONFIGURATION" == *"-prod"* ]]; then
  ENVIRONMENT="prod"
fi

# If using Flutter flavors, it might be safer to use FLUTTER_FLAVOR (lowercased)
if [ -n "$FLUTTER_FLAVOR" ]; then
    ENVIRONMENT=$(echo "$FLUTTER_FLAVOR" | tr '[:upper:]' '[:lower:]')
fi

echo "🚀 Setup Firebase for environment: $ENVIRONMENT"

# Path to the environment-specific plist
SOURCE_PATH="${PROJECT_DIR}/config/${ENVIRONMENT}/${PLIST_FILE}"
# Path to the destination in the built app bundle
DESTINATION_PATH="${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/${PLIST_FILE}"

echo "📂 Source: $SOURCE_PATH"
echo "📂 Destination: $DESTINATION_PATH"

if [ -f "$SOURCE_PATH" ]; then
    cp "${SOURCE_PATH}" "${DESTINATION_PATH}"
    echo "✅ Successfully copied ${PLIST_FILE} for ${ENVIRONMENT} environment."

    # --------------------------------------------------------------------------
    # UPDATE GIDClientID IN Info.plist
    # --------------------------------------------------------------------------
    INFO_PLIST_PATH="${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/Info.plist"

    echo "🔧 Updating GIDClientID in Info.plist..."

    # 1. Extract CLIENT_ID from GoogleService-Info.plist
    CLIENT_ID=$(/usr/libexec/PlistBuddy -c "Print :CLIENT_ID" "${SOURCE_PATH}")

    if [ -z "$CLIENT_ID" ]; then
        echo "⚠️ WARNING: CLIENT_ID not found in ${SOURCE_PATH}. Google Sign-In may fail."
    else
        echo "Found CLIENT_ID: $CLIENT_ID"

        # 2. Add/Update GIDClientID in the App's Info.plist
        # Try to delete if exists to ensure we don't error on 'Add' and don't skip if 'Set' fails on missing
        /usr/libexec/PlistBuddy -c "Delete :GIDClientID" "${INFO_PLIST_PATH}" 2>/dev/null || true
        /usr/libexec/PlistBuddy -c "Add :GIDClientID string ${CLIENT_ID}" "${INFO_PLIST_PATH}"

        echo "✅ Successfully updated GIDClientID in Info.plist"
    fi

else
    echo "❌ ERROR: ${PLIST_FILE} not found at ${SOURCE_PATH}"
    echo "Please download the ${PLIST_FILE} from Firebase Console for package id suffix '.${ENVIRONMENT}' (or standard for prod)"
    echo "and place it in ios/config/${ENVIRONMENT}/"
    exit 1
fi
