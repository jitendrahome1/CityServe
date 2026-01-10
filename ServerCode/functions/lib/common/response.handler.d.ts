/**
 * Standardized API Response Handler
 *
 * Provides consistent response format across all API endpoints.
 * Ensures clients receive predictable response structures.
 */
import { Response } from 'express';
/**
 * Send a successful response
 *
 * @param res - Express response object
 * @param data - Response payload
 * @param statusCode - HTTP status code (default: 200)
 */
export declare const sendSuccess: <T>(res: Response, data: T, statusCode?: number) => void;
/**
 * Send an error response
 *
 * @param res - Express response object
 * @param code - Error code (from ErrorCode enum)
 * @param message - Human-readable error message
 * @param statusCode - HTTP status code (default: 400)
 * @param details - Optional additional error details
 */
export declare const sendError: (res: Response, code: string, message: string, statusCode?: number, details?: unknown) => void;
/**
 * Send a 404 Not Found response
 *
 * @param res - Express response object
 * @param resource - Name of the resource that wasn't found
 */
export declare const sendNotFound: (res: Response, resource: string) => void;
/**
 * Send a 500 Internal Server Error response
 *
 * @param res - Express response object
 * @param error - Error object (logged server-side, sanitized for client)
 */
export declare const sendInternalError: (res: Response, error: Error) => void;
//# sourceMappingURL=response.handler.d.ts.map