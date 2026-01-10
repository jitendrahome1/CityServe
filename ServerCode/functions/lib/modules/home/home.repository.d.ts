/**
 * Home Repository Layer
 *
 * Handles all Firestore database operations for the Home Screen module.
 * Encapsulates data access logic and provides a clean interface for the service layer.
 *
 * Design Principles:
 * - Single Responsibility: Only handles data access
 * - No business logic: Pure data fetching/writing
 * - Type-safe: Strongly typed return values
 * - Error propagation: Lets service layer handle errors
 */
import { City, ServiceCategory, Service, PromotionalBanner, AppConfig } from '../../types';
/**
 * Repository class for Home Screen data operations
 */
export declare class HomeRepository {
    /**
     * Fetch city by ID
     *
     * @param cityId - City identifier
     * @returns City document or throws NotFoundError
     */
    getCityById(cityId: string): Promise<City>;
    /**
     * Fetch all active service categories for a city
     * Sorted by sortOrder for consistent UI display
     *
     * @param cityId - City identifier
     * @returns Array of active categories
     */
    getCategoriesByCity(cityId: string): Promise<ServiceCategory[]>;
    /**
     * Fetch popular services for a city
     * Limited to top N services based on rating and popularity
     *
     * @param cityId - City identifier
     * @param limit - Maximum number of services to return
     * @returns Array of popular services
     */
    getPopularServices(cityId: string, limit?: number): Promise<Service[]>;
    /**
     * Fetch trending services for a city
     * Services marked as trending, sorted by rating
     *
     * @param cityId - City identifier
     * @param limit - Maximum number of services to return
     * @returns Array of trending services
     */
    getTrendingServices(cityId: string, limit?: number): Promise<Service[]>;
    /**
     * Fetch active promotional banners for a city
     * Filters by:
     * - Active status
     * - Current time within valid period
     * - City targeting (empty array = all cities)
     * Sorted by displayOrder for consistent positioning
     *
     * @param cityId - City identifier
     * @returns Array of active banners
     */
    getBannersByCity(cityId: string): Promise<PromotionalBanner[]>;
    /**
     * Fetch global app configuration
     * Includes trust indicators, feature flags, and constants
     *
     * @returns App configuration document
     */
    getAppConfig(): Promise<AppConfig>;
    /**
     * Record banner impression (analytics)
     * Increments the impressions counter
     *
     * @param bannerId - Banner identifier
     */
    incrementBannerImpressions(bannerId: string): Promise<void>;
    /**
     * Fetch user preferences (optional, for personalization)
     *
     * @param userId - User identifier
     * @returns User preferences or null if not found
     */
    getUserPreferences(userId: string): Promise<{
        selectedCity: string;
    } | null>;
}
//# sourceMappingURL=home.repository.d.ts.map