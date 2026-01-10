"use strict";
/**
 * Firebase Admin SDK Initialization
 *
 * Centralized Firebase Admin initialization to be used across all modules.
 * Initialized once and exported for reuse.
 */
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.auth = exports.FieldValue = exports.Timestamp = exports.db = void 0;
const admin = __importStar(require("firebase-admin"));
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
exports.db = admin.firestore();
// Configure Firestore settings for optimal performance
exports.db.settings({
    ignoreUndefinedProperties: true, // Ignore undefined values in write operations
});
// Export Timestamp for date/time handling
exports.Timestamp = admin.firestore.Timestamp;
// Export FieldValue for server-side operations
exports.FieldValue = admin.firestore.FieldValue;
// Export Auth instance for future authentication needs
exports.auth = admin.auth();
exports.default = admin;
//# sourceMappingURL=firebase.admin.js.map