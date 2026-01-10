/**
 * Standardized API Response Handler
 *
 * Provides consistent response format across all API endpoints.
 * Ensures clients receive predictable response structures.
 */

import { Response } from 'express';
import { ApiResponse } from '../types';

/**
 * Send a successful response
 *
 * @param res - Express response object
 * @param data - Response payload
 * @param statusCode - HTTP status code (default: 200)
 */
export const sendSuccess = <T>(
  res: Response,
  data: T,
  statusCode: number = 200
): void => {
  const response: ApiResponse<T> = {
    success: true,
    data,
    timestamp: new Date().toISOString(),
  };

  res.status(statusCode).json(response);
};

/**
 * Send an error response
 *
 * @param res - Express response object
 * @param code - Error code (from ErrorCode enum)
 * @param message - Human-readable error message
 * @param statusCode - HTTP status code (default: 400)
 * @param details - Optional additional error details
 */
export const sendError = (
  res: Response,
  code: string,
  message: string,
  statusCode: number = 400,
  details?: unknown
): void => {
  const response: ApiResponse<never> = {
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

/**
 * Send a 404 Not Found response
 *
 * @param res - Express response object
 * @param resource - Name of the resource that wasn't found
 */
export const sendNotFound = (res: Response, resource: string): void => {
  sendError(
    res,
    'RESOURCE_NOT_FOUND',
    `${resource} not found`,
    404
  );
};

/**
 * Send a 500 Internal Server Error response
 *
 * @param res - Express response object
 * @param error - Error object (logged server-side, sanitized for client)
 */
export const sendInternalError = (res: Response, error: Error): void => {
  // Log full error server-side for debugging
  console.error('Internal Server Error:', error);

  // Send sanitized error to client (don't expose internal details)
  sendError(
    res,
    'INTERNAL_SERVER_ERROR',
    'An unexpected error occurred. Please try again later.',
    500,
    // In development, include stack trace; in production, omit
    process.env.NODE_ENV === 'development' ? { stack: error.stack } : undefined
  );
};
