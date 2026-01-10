"use strict";
/**
 * Standardized API Response Handler
 *
 * Provides consistent response format across all API endpoints.
 * Ensures clients receive predictable response structures.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendInternalError = exports.sendNotFound = exports.sendError = exports.sendSuccess = void 0;
/**
 * Send a successful response
 *
 * @param res - Express response object
 * @param data - Response payload
 * @param statusCode - HTTP status code (default: 200)
 */
const sendSuccess = (res, data, statusCode = 200) => {
    const response = {
        success: true,
        data,
        timestamp: new Date().toISOString(),
    };
    res.status(statusCode).json(response);
};
exports.sendSuccess = sendSuccess;
/**
 * Send an error response
 *
 * @param res - Express response object
 * @param code - Error code (from ErrorCode enum)
 * @param message - Human-readable error message
 * @param statusCode - HTTP status code (default: 400)
 * @param details - Optional additional error details
 */
const sendError = (res, code, message, statusCode = 400, details) => {
    const response = {
        success: false,
        error: details
            ? {
                code,
                message,
                details,
            }
            : {
                code,
                message,
            },
        timestamp: new Date().toISOString(),
    };
    res.status(statusCode).json(response);
};
exports.sendError = sendError;
/**
 * Send a 404 Not Found response
 *
 * @param res - Express response object
 * @param resource - Name of the resource that wasn't found
 */
const sendNotFound = (res, resource) => {
    (0, exports.sendError)(res, 'RESOURCE_NOT_FOUND', `${resource} not found`, 404);
};
exports.sendNotFound = sendNotFound;
/**
 * Send a 500 Internal Server Error response
 *
 * @param res - Express response object
 * @param error - Error object (logged server-side, sanitized for client)
 */
const sendInternalError = (res, error) => {
    // Log full error server-side for debugging
    console.error('Internal Server Error:', error);
    // Send sanitized error to client (don't expose internal details)
    (0, exports.sendError)(res, 'INTERNAL_SERVER_ERROR', 'An unexpected error occurred. Please try again later.', 500, 
    // In development, include stack trace; in production, omit
    process.env.NODE_ENV === 'development' ? { stack: error.stack } : undefined);
};
exports.sendInternalError = sendInternalError;
//# sourceMappingURL=response.handler.js.map