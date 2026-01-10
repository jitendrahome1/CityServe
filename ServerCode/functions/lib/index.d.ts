/**
 * CityServe Cloud Functions Entry Point
 *
 * Initializes Express app, configures middleware, defines routes,
 * and exports Cloud Functions for Firebase deployment.
 *
 * Region: asia-south1 (India) for optimal latency
 */
import * as functions from 'firebase-functions';
declare const app: import("express-serve-static-core").Express;
/**
 * Main API Cloud Function
 *
 * Deployed to: asia-south1 (India region)
 * URL: https://asia-south1-PROJECT_ID.cloudfunctions.net/api
 *
 * Environment: Node.js 18
 * Memory: 256MB (can be increased if needed)
 * Timeout: 60s (default)
 *
 * Examples:
 * - GET /api/v1/home/screen?cityId=delhi
 * - GET /api/health
 */
export declare const api: functions.HttpsFunction;
/**
 * Example: Update trending services nightly
 * Analyzes booking patterns and updates isTrending flags
 *
 * Commented out - not in scope for Phase 1
 */
/**
 * Export Express app for unit testing
 * Allows testing routes without deploying to Firebase
 */
export { app };
//# sourceMappingURL=index.d.ts.map