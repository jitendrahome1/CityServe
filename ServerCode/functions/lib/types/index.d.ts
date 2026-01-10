/**
 * Core Type Definitions for CityServe Backend
 *
 * These types mirror the Firestore data model and ensure type safety
 * across the entire backend codebase.
 */
import { Timestamp } from 'firebase-admin/firestore';
/**
 * City Entity
 * Represents a serviceable city in the platform
 */
export interface City {
    id: string;
    name: string;
    displayName: string;
    isActive: boolean;
    coordinates: {
        latitude: number;
        longitude: number;
    };
    timezone: string;
    currency: string;
    currencySymbol: string;
    serviceRadius: number;
    createdAt: Timestamp;
    updatedAt: Timestamp;
}
/**
 * Service Category Entity
 * Organizes services into categories (Personal, Home, etc.)
 */
export interface ServiceCategory {
    id: string;
    name: string;
    displayName: string;
    type: 'personal' | 'home' | 'business';
    icon: string;
    imageUrl?: string;
    description: string;
    sortOrder: number;
    isActive: boolean;
    isPopular: boolean;
    availableCities: string[];
    metadata: {
        color?: string;
        tags?: string[];
    };
    createdAt: Timestamp;
    updatedAt: Timestamp;
}
/**
 * Service Entity
 * Individual services within categories
 */
export interface Service {
    id: string;
    categoryId: string;
    name: string;
    displayName: string;
    shortDescription: string;
    longDescription: string;
    basePrice: number;
    priceRange: {
        min: number;
        max: number;
    };
    duration: number;
    rating: number;
    reviewCount: number;
    isPopular: boolean;
    isTrending: boolean;
    isActive: boolean;
    availableCities: string[];
    imageUrls: string[];
    tags: string[];
    metadata: {
        warranty?: string;
        includes?: string[];
        excludes?: string[];
    };
    createdAt: Timestamp;
    updatedAt: Timestamp;
}
/**
 * Promotional Banner Entity
 * Marketing banners displayed on home screen
 */
export interface PromotionalBanner {
    id: string;
    title: string;
    subtitle?: string;
    imageUrl: string;
    type: 'plus_membership' | 'custom_package' | 'sponsored' | 'seasonal';
    action: {
        type: 'navigate' | 'deeplink' | 'external';
        target: string;
    };
    displayOrder: number;
    isActive: boolean;
    targetCities: string[];
    targetUsers?: {
        type: 'all' | 'new' | 'premium';
    };
    validFrom: Timestamp;
    validUntil: Timestamp;
    impressions: number;
    clicks: number;
    createdAt: Timestamp;
    updatedAt: Timestamp;
}
/**
 * App Configuration Entity
 * Global app settings, trust indicators, feature flags
 */
export interface AppConfig {
    id: 'global';
    trustIndicators: {
        totalServicesCompleted: number;
        averageRating: number;
        verifiedProfessionals: number;
        cities: number;
    };
    features: {
        plusMembershipEnabled: boolean;
        customPackageEnabled: boolean;
        chatSupportEnabled: boolean;
    };
    constants: {
        minOrderValue: number;
        platformFeePercentage: number;
        defaultServiceRadius: number;
    };
    version: string;
    updatedAt: Timestamp;
}
/**
 * User Preferences Entity
 * Stored in users/{userId}/preferences/settings
 */
export interface UserPreferences {
    selectedCity: string;
    recentSearches: string[];
    favoriteCategories: string[];
    lastUpdated: Timestamp;
}
/**
 * Query Parameters for Home Screen API
 */
export interface HomeScreenQuery {
    cityId: string;
    userId?: string;
    limit?: number;
}
/**
 * Firestore Collection Names
 * Centralized to avoid hardcoding throughout the codebase
 */
export declare const COLLECTIONS: {
    readonly CITIES: "cities";
    readonly SERVICE_CATEGORIES: "service_categories";
    readonly SERVICES: "services";
    readonly PROMOTIONAL_BANNERS: "promotional_banners";
    readonly APP_CONFIG: "app_config";
    readonly USERS: "users";
    readonly USER_PREFERENCES: "preferences";
};
/**
 * API Response Status
 */
export type ResponseStatus = 'success' | 'error';
/**
 * Generic API Response Wrapper
 */
export interface ApiResponse<T> {
    success: boolean;
    data?: T;
    error?: {
        code: string;
        message: string;
        details?: unknown;
    };
    timestamp: string;
}
/**
 * Error Codes
 */
export declare enum ErrorCode {
    INVALID_CITY = "INVALID_CITY",
    CITY_NOT_FOUND = "CITY_NOT_FOUND",
    NO_SERVICES_AVAILABLE = "NO_SERVICES_AVAILABLE",
    INVALID_PARAMETERS = "INVALID_PARAMETERS",
    INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR",
    UNAUTHORIZED = "UNAUTHORIZED",
    RESOURCE_NOT_FOUND = "RESOURCE_NOT_FOUND"
}
//# sourceMappingURL=index.d.ts.map