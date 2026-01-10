"use strict";
/**
 * Home Controller Layer
 *
 * Handles HTTP requests and responses for the Home Screen API.
 * Acts as the entry point for the home module.
 *
 * Responsibilities:
 * - Parse and validate request parameters
 * - Call service layer with validated data
 * - Handle errors and send appropriate responses
 * - Set response headers (caching, CORS, etc.)
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.HomeController = void 0;
const home_service_1 = require("./home.service");
const validators_1 = require("../../common/validators");
const response_handler_1 = require("../../common/response.handler");
const error_handler_1 = require("../../common/error.handler");
/**
 * Controller class for Home Screen endpoints
 */
class HomeController {
    constructor() {
        /**
         * GET /api/v1/home/screen
         *
         * Fetch complete home screen data for a city
         *
         * Query Parameters:
         * - cityId (required): string - City identifier (e.g., "delhi", "mumbai")
         * - userId (optional): string - User ID for personalization
         * - limit (optional): number - Limit for popular services (default: 10, max: 100)
         *
         * Response:
         * - 200: Success with home screen data
         * - 400: Invalid parameters
         * - 404: City not found
         * - 500: Internal server error
         *
         * Example:
         * GET /api/v1/home/screen?cityId=delhi&userId=abc123&limit=10
         */
        this.getHomeScreen = async (req, res) => {
            try {
                // Step 1: Validate query parameters
                const query = (0, validators_1.validateHomeScreenQuery)({
                    cityId: req.query.cityId,
                    userId: req.query.userId,
                    limit: req.query.limit ? Number(req.query.limit) : undefined,
                });
                // Step 2: Fetch data from service layer
                const data = await this.service.getHomeScreenData(query);
                // Step 3: Set caching headers for optimal performance
                // Home screen data changes infrequently, safe to cache
                res.setHeader('Cache-Control', 'public, max-age=300'); // 5 minutes
                res.setHeader('Vary', 'Accept-Encoding'); // Enable compression
                // Step 4: Send successful response
                (0, response_handler_1.sendSuccess)(res, data, 200);
            }
            catch (error) {
                // Step 5: Handle errors appropriately
                this.handleError(error, res);
            }
        };
        /**
         * GET /api/v1/home/cities
         *
         * Fetch list of all active cities (for city selector)
         *
         * Future enhancement: Not implemented in this phase
         * Placeholder for future city listing endpoint
         */
        this.getCities = async (_req, res) => {
            (0, response_handler_1.sendError)(res, 'NOT_IMPLEMENTED', 'City listing endpoint not yet implemented', 501);
        };
        this.service = new home_service_1.HomeService();
    }
    /**
     * Error handling helper
     * Routes errors to appropriate response handlers
     *
     * @param error - Error object (can be AppError or unknown)
     * @param res - Express response object
     */
    handleError(error, res) {
        // Log error for debugging
        (0, error_handler_1.logError)('HomeController', error);
        if ((0, error_handler_1.isAppError)(error)) {
            // Known application errors with defined codes and messages
            (0, response_handler_1.sendError)(res, error.code, error.message, error.statusCode, error.details);
        }
        else if (error instanceof Error) {
            // Generic JavaScript errors
            (0, response_handler_1.sendInternalError)(res, error);
        }
        else {
            // Unknown error type
            (0, response_handler_1.sendInternalError)(res, new Error('An unknown error occurred'));
        }
    }
}
exports.HomeController = HomeController;
//# sourceMappingURL=home.controller.js.map