"use strict";
/**
 * Input Validation Utilities
 *
 * Validates request parameters and ensures data integrity.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.sanitizeString = exports.validateHomeScreenQuery = exports.isValidUserId = exports.isValidCityId = exports.isPositiveNumber = exports.isNonEmptyString = void 0;
const error_handler_1 = require("./error.handler");
/**
 * Validate that a string is not empty
 */
const isNonEmptyString = (value) => {
    return typeof value === 'string' && value.trim().length > 0;
};
exports.isNonEmptyString = isNonEmptyString;
/**
 * Validate that a value is a positive number
 */
const isPositiveNumber = (value) => {
    return typeof value === 'number' && value > 0 && !isNaN(value);
};
exports.isPositiveNumber = isPositiveNumber;
/**
 * Validate city ID format
 * City IDs should be lowercase alphanumeric with optional underscores
 */
const isValidCityId = (cityId) => {
    if (!(0, exports.isNonEmptyString)(cityId)) {
        return false;
    }
    // Allow lowercase letters, numbers, and underscores
    return /^[a-z0-9_]+$/.test(cityId);
};
exports.isValidCityId = isValidCityId;
/**
 * Validate user ID format (Firebase UID)
 */
const isValidUserId = (userId) => {
    if (!(0, exports.isNonEmptyString)(userId)) {
        return false;
    }
    // Firebase UIDs are 28 characters alphanumeric
    return /^[a-zA-Z0-9]{20,}$/.test(userId);
};
exports.isValidUserId = isValidUserId;
/**
 * Validate Home Screen Query Parameters
 * Ensures all required parameters are present and valid
 */
const validateHomeScreenQuery = (query) => {
    const errors = [];
    // Validate cityId (required)
    if (!query.cityId) {
        errors.push('cityId is required');
    }
    else if (!(0, exports.isValidCityId)(query.cityId)) {
        errors.push('cityId must be lowercase alphanumeric (with optional underscores)');
    }
    // Validate userId (optional)
    if (query.userId && !(0, exports.isValidUserId)(query.userId)) {
        errors.push('userId must be a valid Firebase UID');
    }
    // Validate limit (optional)
    if (query.limit !== undefined) {
        const limit = Number(query.limit);
        if (!(0, exports.isPositiveNumber)(limit) || limit > 100) {
            errors.push('limit must be a positive number between 1 and 100');
        }
    }
    if (errors.length > 0) {
        throw new error_handler_1.ValidationError('Invalid query parameters', { errors });
    }
    return {
        cityId: query.cityId,
        ...(query.userId && { userId: query.userId }),
        ...(query.limit && { limit: Number(query.limit) }),
    };
};
exports.validateHomeScreenQuery = validateHomeScreenQuery;
/**
 * Sanitize user input to prevent injection attacks
 */
const sanitizeString = (input) => {
    return input.trim().replace(/[<>]/g, '');
};
exports.sanitizeString = sanitizeString;
//# sourceMappingURL=validators.js.map