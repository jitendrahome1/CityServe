/**
 * Input Validation Utilities
 *
 * Validates request parameters and ensures data integrity.
 */

import { ValidationError } from './error.handler';
import { HomeScreenQuery } from '../types';

/**
 * Validate that a string is not empty
 */
export const isNonEmptyString = (value: unknown): value is string => {
  return typeof value === 'string' && value.trim().length > 0;
};

/**
 * Validate that a value is a positive number
 */
export const isPositiveNumber = (value: unknown): value is number => {
  return typeof value === 'number' && value > 0 && !isNaN(value);
};

/**
 * Validate city ID format
 * City IDs should be lowercase alphanumeric with optional underscores
 */
export const isValidCityId = (cityId: unknown): cityId is string => {
  if (!isNonEmptyString(cityId)) {
    return false;
  }
  // Allow lowercase letters, numbers, and underscores
  return /^[a-z0-9_]+$/.test(cityId);
};

/**
 * Validate user ID format (Firebase UID)
 */
export const isValidUserId = (userId: unknown): userId is string => {
  if (!isNonEmptyString(userId)) {
    return false;
  }
  // Firebase UIDs are 28 characters alphanumeric
  return /^[a-zA-Z0-9]{20,}$/.test(userId);
};

/**
 * Validate Home Screen Query Parameters
 * Ensures all required parameters are present and valid
 */
export const validateHomeScreenQuery = (query: Partial<HomeScreenQuery>): HomeScreenQuery => {
  const errors: string[] = [];

  // Validate cityId (required)
  if (!query.cityId) {
    errors.push('cityId is required');
  } else if (!isValidCityId(query.cityId)) {
    errors.push('cityId must be lowercase alphanumeric (with optional underscores)');
  }

  // Validate userId (optional)
  if (query.userId && !isValidUserId(query.userId)) {
    errors.push('userId must be a valid Firebase UID');
  }

  // Validate limit (optional)
  if (query.limit !== undefined) {
    const limit = Number(query.limit);
    if (!isPositiveNumber(limit) || limit > 100) {
      errors.push('limit must be a positive number between 1 and 100');
    }
  }

  if (errors.length > 0) {
    throw new ValidationError('Invalid query parameters', { errors });
  }

  return {
    cityId: query.cityId as string,
    ...(query.userId && { userId: query.userId }),
    ...(query.limit && { limit: Number(query.limit) }),
  };
};

/**
 * Sanitize user input to prevent injection attacks
 */
export const sanitizeString = (input: string): string => {
  return input.trim().replace(/[<>]/g, '');
};
