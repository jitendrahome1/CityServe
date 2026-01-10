"use strict";
/**
 * Custom Error Classes and Error Handling Utilities
 *
 * Provides type-safe error handling throughout the application.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.logError = exports.isAppError = exports.NotFoundError = exports.ValidationError = exports.AppError = void 0;
const types_1 = require("../types");
/**
 * Base Application Error
 * All custom errors extend this class
 */
class AppError extends Error {
    constructor(code, message, statusCode = 400, details) {
        super(message);
        this.code = code;
        this.message = message;
        this.statusCode = statusCode;
        this.details = details;
        this.name = 'AppError';
        Error.captureStackTrace(this, this.constructor);
    }
}
exports.AppError = AppError;
/**
 * Validation Error
 * Thrown when request validation fails
 */
class ValidationError extends AppError {
    constructor(message, details) {
        super(types_1.ErrorCode.INVALID_PARAMETERS, message, 400, details);
        this.name = 'ValidationError';
    }
}
exports.ValidationError = ValidationError;
/**
 * Not Found Error
 * Thrown when a requested resource doesn't exist
 */
class NotFoundError extends AppError {
    constructor(resource) {
        super(types_1.ErrorCode.RESOURCE_NOT_FOUND, `${resource} not found`, 404);
        this.name = 'NotFoundError';
    }
}
exports.NotFoundError = NotFoundError;
/**
 * Check if error is an AppError instance
 */
const isAppError = (error) => {
    return error instanceof AppError;
};
exports.isAppError = isAppError;
/**
 * Safe error logging
 * Logs errors with context for debugging
 */
const logError = (context, error) => {
    if ((0, exports.isAppError)(error)) {
        console.error(`[${context}] AppError:`, {
            code: error.code,
            message: error.message,
            statusCode: error.statusCode,
            details: error.details,
            stack: error.stack,
        });
    }
    else if (error instanceof Error) {
        console.error(`[${context}] Error:`, {
            name: error.name,
            message: error.message,
            stack: error.stack,
        });
    }
    else {
        console.error(`[${context}] Unknown Error:`, error);
    }
};
exports.logError = logError;
//# sourceMappingURL=error.handler.js.map