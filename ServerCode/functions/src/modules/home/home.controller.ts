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
import { HomeService } from './home.service';
import { validateHomeScreenQuery } from '../../common/validators';
import { sendSuccess, sendError, sendInternalError } from '../../common/response.handler';
import { isAppError, logError } from '../../common/error.handler';

/**
 * Controller class for Home Screen endpoints
 */
export class HomeController {
  private service: HomeService;

  constructor() {
    this.service = new HomeService();
  }

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
  getHomeScreen = async (req: Request, res: Response): Promise<void> => {
    try {
      // Step 1: Validate query parameters
      const query = validateHomeScreenQuery({
        cityId: req.query.cityId as string,
        userId: req.query.userId as string | undefined,
        limit: req.query.limit ? Number(req.query.limit) : undefined,
      });

      // Step 2: Fetch data from service layer
      const data = await this.service.getHomeScreenData(query);

      // Step 3: Set caching headers for optimal performance
      // Home screen data changes infrequently, safe to cache
      res.setHeader('Cache-Control', 'public, max-age=300'); // 5 minutes
      res.setHeader('Vary', 'Accept-Encoding'); // Enable compression

      // Step 4: Send successful response
      sendSuccess(res, data, 200);
    } catch (error) {
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
  getCities = async (_req: Request, res: Response): Promise<void> => {
    sendError(res, 'NOT_IMPLEMENTED', 'City listing endpoint not yet implemented', 501);
  };

  /**
   * Error handling helper
   * Routes errors to appropriate response handlers
   *
   * @param error - Error object (can be AppError or unknown)
   * @param res - Express response object
   */
  private handleError(error: unknown, res: Response): void {
    // Log error for debugging
    logError('HomeController', error);

    if (isAppError(error)) {
      // Known application errors with defined codes and messages
      sendError(res, error.code, error.message, error.statusCode, error.details);
    } else if (error instanceof Error) {
      // Generic JavaScript errors
      sendInternalError(res, error);
    } else {
      // Unknown error type
      sendInternalError(res, new Error('An unknown error occurred'));
    }
  }
}
