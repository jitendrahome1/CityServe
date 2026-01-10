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
export declare class AppError extends Error {
    code: ErrorCode | string;
    message: string;
    statusCode: number;
    details?: unknown | undefined;
    constructor(code: ErrorCode | string, message: string, statusCode?: number, details?: unknown | undefined);
}
/**
 * Validation Error
 * Thrown when request validation fails
 */
export declare class ValidationError extends AppError {
    constructor(message: string, details?: unknown);
}
/**
 * Not Found Error
 * Thrown when a requested resource doesn't exist
 */
export declare class NotFoundError extends AppError {
    constructor(resource: string);
}
/**
 * Check if error is an AppError instance
 */
export declare const isAppError: (error: unknown) => error is AppError;
/**
 * Safe error logging
 * Logs errors with context for debugging
 */
export declare const logError: (context: string, error: unknown) => void;
//# sourceMappingURL=error.handler.d.ts.map