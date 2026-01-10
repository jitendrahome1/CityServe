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
import { Request, Response } from 'express';
/**
 * Controller class for Home Screen endpoints
 */
export declare class HomeController {
    private service;
    constructor();
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
    getHomeScreen: (req: Request, res: Response) => Promise<void>;
    /**
     * GET /api/v1/home/cities
     *
     * Fetch list of all active cities (for city selector)
     *
     * Future enhancement: Not implemented in this phase
     * Placeholder for future city listing endpoint
     */
    getCities: (_req: Request, res: Response) => Promise<void>;
    /**
     * Error handling helper
     * Routes errors to appropriate response handlers
     *
     * @param error - Error object (can be AppError or unknown)
     * @param res - Express response object
     */
    private handleError;
}
//# sourceMappingURL=home.controller.d.ts.map