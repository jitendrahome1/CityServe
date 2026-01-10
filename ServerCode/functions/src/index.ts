/**
 * CityServe Cloud Functions Entry Point
 *
 * Initializes Express app, configures middleware, defines routes,
 * and exports Cloud Functions for Firebase deployment.
 *
 * Region: asia-south1 (India) for optimal latency
 */

import * as functions from 'firebase-functions';
import express, { Request, Response, NextFunction } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { HomeController } from './modules/home/home.controller';
import { sendError } from './common/response.handler';

// Initialize Express app
const app = express();

// ============================================================================
// MIDDLEWARE CONFIGURATION
// ============================================================================

/**
 * Security middleware (helmet)
 * Sets various HTTP headers for security
 */
app.use(helmet());

/**
 * CORS middleware
 * Allow cross-origin requests from client apps
 * In production, restrict to specific origins
 */
const corsOptions = {
  origin:
    process.env.NODE_ENV === 'production'
      ? ['https://cityserve-app.web.app', 'https://cityserve-app.firebaseapp.com']
      : '*', // Allow all origins in development
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));

/**
 * JSON body parser
 * Parse incoming request bodies in JSON format
 */
app.use(express.json());

/**
 * URL-encoded body parser
 * Parse URL-encoded request bodies
 */
app.use(express.urlencoded({ extended: true }));

/**
 * Request logging middleware
 * Logs all incoming requests for debugging
 */
app.use((req: Request, _res: Response, next: NextFunction) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`, {
    query: req.query,
    ip: req.ip,
    userAgent: req.get('user-agent'),
  });
  next();
});

// ============================================================================
// ROUTE DEFINITIONS
// ============================================================================

// Initialize controllers
const homeController = new HomeController();

/**
 * Health check endpoint
 * Used to verify that the API is running
 */
app.get('/health', (_req: Request, res: Response) => {
  res.status(200).json({
    status: 'healthy',
    service: 'CityServe API',
    version: '1.0.0',
    timestamp: new Date().toISOString(),
  });
});

/**
 * API v1 Routes
 * Prefix all API routes with /api/v1 for versioning
 */
const apiV1 = express.Router();

// Home Screen routes
apiV1.get('/home/screen', homeController.getHomeScreen);
apiV1.get('/home/cities', homeController.getCities); // Future: City listing

// Mount API v1 router
app.use('/api/v1', apiV1);

/**
 * 404 Not Found handler
 * Catch all unmatched routes
 */
app.use((req: Request, res: Response) => {
  sendError(res, 'ROUTE_NOT_FOUND', `Route ${req.method} ${req.path} not found`, 404);
});

/**
 * Global error handler
 * Catches any unhandled errors in the request pipeline
 */
app.use((err: Error, _req: Request, res: Response, _next: NextFunction) => {
  console.error('Unhandled error:', err);
  sendError(res, 'INTERNAL_SERVER_ERROR', 'An unexpected error occurred', 500, {
    message: err.message,
    stack: process.env.NODE_ENV === 'development' ? err.stack : undefined,
  });
});

// ============================================================================
// CLOUD FUNCTIONS EXPORTS
// ============================================================================

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
export const api = functions
  .region('asia-south1') // India region for low latency
  .runWith({
    memory: '256MB', // Sufficient for read-heavy operations
    timeoutSeconds: 60,
    minInstances: 0, // Scale to zero when idle (cost optimization)
    maxInstances: 100, // Scale up to handle traffic spikes
  })
  .https.onRequest(app);

// ============================================================================
// SCHEDULED FUNCTIONS (Future Enhancements)
// ============================================================================

/**
 * Example: Update trending services nightly
 * Analyzes booking patterns and updates isTrending flags
 *
 * Commented out - not in scope for Phase 1
 */
// export const updateTrendingServices = functions
//   .region('asia-south1')
//   .pubsub.schedule('0 2 * * *') // 2 AM daily (IST)
//   .timeZone('Asia/Kolkata')
//   .onRun(async (context) => {
//     // Implementation here
//     console.log('Updating trending services...');
//   });

// ============================================================================
// EXPORTS FOR TESTING
// ============================================================================

/**
 * Export Express app for unit testing
 * Allows testing routes without deploying to Firebase
 */
export { app };
