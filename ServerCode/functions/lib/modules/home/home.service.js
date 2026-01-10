"use strict";
/**
 * Home Service Layer
 *
 * Contains business logic for the Home Screen module.
 * Orchestrates repository calls and applies business rules.
 *
 * Responsibilities:
 * - Coordinate multiple data sources
 * - Apply business logic and transformations
 * - Handle caching strategies
 * - Aggregate data from multiple repositories
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.HomeService = void 0;
const home_repository_1 = require("./home.repository");
const home_dto_1 = require("./home.dto");
const error_handler_1 = require("../../common/error.handler");
/**
 * Service class for Home Screen business logic
 */
class HomeService {
    constructor() {
        this.repository = new home_repository_1.HomeRepository();
    }
    /**
     * Fetch complete home screen data
     *
     * Business Logic:
     * 1. Validate city exists and is active
     * 2. Fetch all required data in parallel for performance
     * 3. Group categories by type (personal, home)
     * 4. Filter out inactive or unavailable data
     * 5. Transform entities to DTOs (hide internal details)
     * 6. Record analytics (banner impressions)
     *
     * @param query - Query parameters (cityId, optional userId)
     * @returns Complete home screen data
     */
    async getHomeScreenData(query) {
        // Step 1: Validate city exists and is active
        const city = await this.repository.getCityById(query.cityId);
        if (!city.isActive) {
            throw new error_handler_1.ValidationError(`City ${query.cityId} is not currently serviceable`);
        }
        // Step 2: Fetch all data in parallel for optimal performance
        // Using Promise.all reduces total response time significantly
        const [categories, popularServices, trendingServices, banners, appConfig] = await Promise.all([
            this.repository.getCategoriesByCity(query.cityId),
            this.repository.getPopularServices(query.cityId, query.limit || 10),
            this.repository.getTrendingServices(query.cityId, 6),
            this.repository.getBannersByCity(query.cityId),
            this.repository.getAppConfig(),
        ]);
        // Step 3: Group categories by type for easier client rendering
        const groupedCategories = this.groupCategoriesByType(categories);
        // Step 4: Transform to DTOs (Data Transfer Objects)
        // DTOs provide a clean, consistent API interface
        const response = {
            city: (0, home_dto_1.toCityDTO)(city),
            categories: {
                personal: groupedCategories.personal.map(home_dto_1.toCategoryDTO),
                home: groupedCategories.home.map(home_dto_1.toCategoryDTO),
            },
            popularServices: popularServices.map(home_dto_1.toServiceDTO),
            trendingServices: trendingServices.map(home_dto_1.toServiceDTO),
            banners: banners.map(home_dto_1.toBannerDTO),
            trustIndicators: (0, home_dto_1.toTrustIndicatorDTO)(appConfig),
        };
        // Step 5: Record analytics (fire-and-forget, don't wait)
        this.recordBannerImpressions(banners.map((b) => b.id));
        return response;
    }
    /**
     * Group categories by type (personal, home, business)
     * Separates categories for different sections of the home screen
     *
     * @param categories - Array of categories
     * @returns Grouped categories
     */
    groupCategoriesByType(categories) {
        const personal = categories.filter((cat) => cat.type === 'personal');
        const home = categories.filter((cat) => cat.type === 'home');
        return { personal, home };
    }
    /**
     * Record banner impressions for analytics
     * Fire-and-forget: Don't wait for completion, don't block response
     *
     * @param bannerIds - Array of banner IDs to record impressions for
     */
    recordBannerImpressions(bannerIds) {
        // Record impressions asynchronously without awaiting
        // Failures here shouldn't affect the API response
        Promise.all(bannerIds.map((id) => this.repository.incrementBannerImpressions(id).catch((error) => {
            console.error(`Failed to record impression for banner ${id}:`, error);
        })));
    }
    /**
     * Get personalized city recommendation
     * If user has a preferred city in their settings, suggest it
     * Otherwise, return null (use request parameter or default)
     *
     * @param userId - User identifier
     * @returns Recommended city ID or null
     */
    async getRecommendedCity(userId) {
        try {
            const preferences = await this.repository.getUserPreferences(userId);
            return preferences?.selectedCity || null;
        }
        catch (error) {
            // If user preferences not found, return null (not an error)
            console.log(`No preferences found for user ${userId}`);
            return null;
        }
    }
}
exports.HomeService = HomeService;
//# sourceMappingURL=home.service.js.map