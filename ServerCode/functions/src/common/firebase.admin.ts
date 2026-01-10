/**
 * Firebase Admin SDK Initialization
 *
 * Centralized Firebase Admin initialization to be used across all modules.
 * Initialized once and exported for reuse.
 */

import * as admin from 'firebase-admin';

// Initialize Firebase Admin SDK
// Uses default credentials when deployed to Firebase
// For local development, set GOOGLE_APPLICATION_CREDENTIALS environment variable
if (!admin.apps.length) {
  admin.initializeApp({
    // Configuration is automatically picked up from Firebase environment
    // No need to explicitly provide credentials in production
  });
}

// Export Firestore instance
export const db = admin.firestore();

// Configure Firestore settings for optimal performance
db.settings({
  ignoreUndefinedProperties: true, // Ignore undefined values in write operations
});

// Export Timestamp for date/time handling
export const Timestamp = admin.firestore.Timestamp;

// Export FieldValue for server-side operations
export const FieldValue = admin.firestore.FieldValue;

// Export Auth instance for future authentication needs
export const auth = admin.auth();

export default admin;
