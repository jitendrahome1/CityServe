/**
 * Firebase Admin SDK Initialization
 *
 * Centralized Firebase Admin initialization to be used across all modules.
 * Initialized once and exported for reuse.
 */
import * as admin from 'firebase-admin';
export declare const db: admin.firestore.Firestore;
export declare const Timestamp: typeof admin.firestore.Timestamp;
export declare const FieldValue: typeof admin.firestore.FieldValue;
export declare const auth: import("firebase-admin/auth").Auth;
export default admin;
//# sourceMappingURL=firebase.admin.d.ts.map