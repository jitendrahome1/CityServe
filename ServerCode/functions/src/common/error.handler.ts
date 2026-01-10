/**
 * Custom Error Classes and Error Handling Utilities
 *
 * Provides type-safe error handling throughout the application.
 */

import { ErrorCode } from '../types';

/**
 * Base Application Error
 * All custom errors extend this class
 */
export class AppError extends Error {
  constructor(
    public code: ErrorCode | string,
    public message: string,
    public statusCode: number = 400,
    public details?: unknown
  ) {
    super(message);
    this.name = 'AppError';
    Error.captureStackTrace(this, this.constructor);
  }
}

/**
 * Validation Error
 * Thrown when request validation fails
 */
export class ValidationError extends AppError {
  constructor(message: string, details?: unknown) {
    super(ErrorCode.INVALID_PARAMETERS, message, 400, details);
    this.name = 'ValidationError';
  }
}

/**
 * Not Found Error
 * Thrown when a requested resource doesn't exist
 */
export class NotFoundError extends AppError {
  constructor(resource: string) {
    super(ErrorCode.RESOURCE_NOT_FOUND, `${resource} not found`, 404);
    this.name = 'NotFoundError';
  }
}

/**
 * Check if error is an AppError instance
 */
export const isAppError = (error: unknown): error is AppError => {
  return error instanceof AppError;
};

/**
 * Safe error logging
 * Logs errors with context for debugging
 */
export const logError = (context: string, error: unknown): void => {
  if (isAppError(error)) {
    console.error(`[${context}] AppError:`, {
      code: error.code,
      message: error.message,
      statusCode: error.statusCode,
      details: error.details,
      stack: error.stack,
    });
  } else if (error instanceof Error) {
    console.error(`[${context}] Error:`, {
      name: error.name,
      message: error.message,
      stack: error.stack,
    });
  } else {
    console.error(`[${context}] Unknown Error:`, error);
  }
};
