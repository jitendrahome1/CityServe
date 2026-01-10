"use strict";
/**
 * Core Type Definitions for CityServe Backend
 *
 * These types mirror the Firestore data model and ensure type safety
 * across the entire backend codebase.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.ErrorCode = exports.COLLECTIONS = void 0;
/**
 * Firestore Collection Names
 * Centralized to avoid hardcoding throughout the codebase
 */
exports.COLLECTIONS = {
    CITIES: 'cities',
    SERVICE_CATEGORIES: 'service_categories',
    SERVICES: 'services',
    PROMOTIONAL_BANNERS: 'promotional_banners',
    APP_CONFIG: 'app_config',
    USERS: 'users',
    USER_PREFERENCES: 'preferences',
};
/**
 * Error Codes
 */
var ErrorCode;
(function (ErrorCode) {
    ErrorCode["INVALID_CITY"] = "INVALID_CITY";
    ErrorCode["CITY_NOT_FOUND"] = "CITY_NOT_FOUND";
    ErrorCode["NO_SERVICES_AVAILABLE"] = "NO_SERVICES_AVAILABLE";
    ErrorCode["INVALID_PARAMETERS"] = "INVALID_PARAMETERS";
    ErrorCode["INTERNAL_SERVER_ERROR"] = "INTERNAL_SERVER_ERROR";
    ErrorCode["UNAUTHORIZED"] = "UNAUTHORIZED";
    ErrorCode["RESOURCE_NOT_FOUND"] = "RESOURCE_NOT_FOUND";
})(ErrorCode || (exports.ErrorCode = ErrorCode = {}));
//# sourceMappingURL=index.js.map