/**
 * Input Validation Utilities
 *
 * Validates request parameters and ensures data integrity.
 */
import { HomeScreenQuery } from '../types';
/**
 * Validate that a string is not empty
 */
export declare const isNonEmptyString: (value: unknown) => value is string;
/**
 * Validate that a value is a positive number
 */
export declare const isPositiveNumber: (value: unknown) => value is number;
/**
 * Validate city ID format
 * City IDs should be lowercase alphanumeric with optional underscores
 */
export declare const isValidCityId: (cityId: unknown) => cityId is string;
/**
 * Validate user ID format (Firebase UID)
 */
export declare const isValidUserId: (userId: unknown) => userId is string;
/**
 * Validate Home Screen Query Parameters
 * Ensures all required parameters are present and valid
 */
export declare const validateHomeScreenQuery: (query: Partial<HomeScreenQuery>) => HomeScreenQuery;
/**
 * Sanitize user input to prevent injection attacks
 */
export declare const sanitizeString: (input: string) => string;
//# sourceMappingURL=validators.d.ts.map