#!/bin/bash

# Script to copy the correct GoogleService-Info.plist based on the build configuration
# This script is run as a build phase in Xcode

set -e  # Exit on error

echo "🔥 Firebase Configuration Script"
echo "Configuration: ${CONFIGURATION}"
echo "Environment: ${ENVIRONMENT}"

# Determine which Firebase config file to use based on environment
FIREBASE_SOURCE="${SRCROOT}/CityServe/Firebase/${FIREBASE_CONFIG_FILE}"
FIREBASE_DEST="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

echo "Source: ${FIREBASE_SOURCE}"
echo "Destination: ${FIREBASE_DEST}"

# Check if source file exists
if [ ! -f "${FIREBASE_SOURCE}" ]; then
    echo "❌ ERROR: Firebase config file not found: ${FIREBASE_SOURCE}"
    echo ""
    echo "Please create the Firebase configuration file:"
    echo "1. Go to Firebase Console"
    echo "2. Download GoogleService-Info.plist for your ${ENVIRONMENT} project"
    echo "3. Rename it to ${FIREBASE_CONFIG_FILE}"
    echo "4. Place it in CityServe/Firebase/ directory"
    echo ""
    exit 1
fi

# Copy the file
cp "${FIREBASE_SOURCE}" "${FIREBASE_DEST}"

echo "✅ Successfully copied ${FIREBASE_CONFIG_FILE} to app bundle"
