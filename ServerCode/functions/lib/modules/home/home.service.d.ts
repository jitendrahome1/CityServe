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
import { HomeScreenResponseDTO } from './home.dto';
import { HomeScreenQuery } from '../../types';
/**
 * Service class for Home Screen business logic
 */
export declare class HomeService {
    private repository;
    constructor();
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
    getHomeScreenData(query: HomeScreenQuery): Promise<HomeScreenResponseDTO>;
    /**
     * Group categories by type (personal, home, business)
     * Separates categories for different sections of the home screen
     *
     * @param categories - Array of categories
     * @returns Grouped categories
     */
    private groupCategoriesByType;
    /**
     * Record banner impressions for analytics
     * Fire-and-forget: Don't wait for completion, don't block response
     *
     * @param bannerIds - Array of banner IDs to record impressions for
     */
    private recordBannerImpressions;
    /**
     * Get personalized city recommendation
     * If user has a preferred city in their settings, suggest it
     * Otherwise, return null (use request parameter or default)
     *
     * @param userId - User identifier
     * @returns Recommended city ID or null
     */
    getRecommendedCity(userId: string): Promise<string | null>;
}
//# sourceMappingURL=home.service.d.ts.map