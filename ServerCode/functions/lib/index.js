"use strict";
/**
 * CityServe Cloud Functions Entry Point
 *
 * Initializes Express app, configures middleware, defines routes,
 * and exports Cloud Functions for Firebase deployment.
 *
 * Region: asia-south1 (India) for optimal latency
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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.app = exports.api = void 0;
const functions = __importStar(require("firebase-functions"));
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const helmet_1 = __importDefault(require("helmet"));
const home_controller_1 = require("./modules/home/home.controller");
const response_handler_1 = require("./common/response.handler");
// Initialize Express app
const app = (0, express_1.default)();
exports.app = app;
// ============================================================================
// MIDDLEWARE CONFIGURATION
// ============================================================================
/**
 * Security middleware (helmet)
 * Sets various HTTP headers for security
 */
app.use((0, helmet_1.default)());
/**
 * CORS middleware
 * Allow cross-origin requests from client apps
 * In production, restrict to specific origins
 */
const corsOptions = {
    origin: process.env.NODE_ENV === 'production'
        ? ['https://cityserve-app.web.app', 'https://cityserve-app.firebaseapp.com']
        : '*', // Allow all origins in development
    optionsSuccessStatus: 200,
};
app.use((0, cors_1.default)(corsOptions));
/**
 * JSON body parser
 * Parse incoming request bodies in JSON format
 */
app.use(express_1.default.json());
/**
 * URL-encoded body parser
 * Parse URL-encoded request bodies
 */
app.use(express_1.default.urlencoded({ extended: true }));
/**
 * Request logging middleware
 * Logs all incoming requests for debugging
 */
app.use((req, _res, next) => {
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
const homeController = new home_controller_1.HomeController();
/**
 * Health check endpoint
 * Used to verify that the API is running
 */
app.get('/health', (_req, res) => {
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
const apiV1 = express_1.default.Router();
// Home Screen routes
apiV1.get('/home/screen', homeController.getHomeScreen);
apiV1.get('/home/cities', homeController.getCities); // Future: City listing
// Mount API v1 router
app.use('/api/v1', apiV1);
/**
 * 404 Not Found handler
 * Catch all unmatched routes
 */
app.use((req, res) => {
    (0, response_handler_1.sendError)(res, 'ROUTE_NOT_FOUND', `Route ${req.method} ${req.path} not found`, 404);
});
/**
 * Global error handler
 * Catches any unhandled errors in the request pipeline
 */
app.use((err, _req, res, _next) => {
    console.error('Unhandled error:', err);
    (0, response_handler_1.sendError)(res, 'INTERNAL_SERVER_ERROR', 'An unexpected error occurred', 500, {
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
exports.api = functions
    .region('asia-south1') // India region for low latency
    .runWith({
    memory: '256MB', // Sufficient for read-heavy operations
    timeoutSeconds: 60,
    minInstances: 0, // Scale to zero when idle (cost optimization)
    maxInstances: 100, // Scale up to handle traffic spikes
})
    .https.onRequest(app);
//# sourceMappingURL=index.js.map