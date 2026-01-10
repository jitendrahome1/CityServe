/**
 * Data Transfer Objects (DTOs) for Home Screen API
 *
 * DTOs are used to shape the response data sent to clients.
 * They provide a clean interface and hide internal implementation details.
 */
import { City, ServiceCategory, Service, PromotionalBanner, AppConfig } from '../../types';
/**
 * City DTO - Simplified city information for home screen
 */
export interface CityDTO {
    id: string;
    name: string;
    displayName: string;
    currencySymbol: string;
}
/**
 * Service Category DTO - Optimized for grid display
 */
export interface CategoryDTO {
    id: string;
    name: string;
    displayName: string;
    type: 'personal' | 'home' | 'business';
    icon: string;
    imageUrl?: string;
    sortOrder: number;
    color?: string;
    isPopular: boolean;
}
/**
 * Service DTO - Compact service information for home screen
 */
export interface ServiceDTO {
    id: string;
    categoryId: string;
    name: string;
    shortDescription: string;
    basePrice: number;
    priceRange: {
        min: number;
        max: number;
    };
    duration: number;
    rating: number;
    reviewCount: number;
    imageUrl?: string;
    tags: string[];
}
/**
 * Banner DTO - Promotional banner for home screen
 */
export interface BannerDTO {
    id: string;
    title: string;
    subtitle?: string;
    imageUrl: string;
    type: string;
    action: {
        type: string;
        target: string;
    };
}
/**
 * Trust Indicator DTO - Social proof metrics
 */
export interface TrustIndicatorDTO {
    totalServicesCompleted: number;
    averageRating: number;
    verifiedProfessionals: number;
    cities: number;
}
/**
 * Home Screen Response DTO - Complete home screen data
 */
export interface HomeScreenResponseDTO {
    city: CityDTO;
    categories: {
        personal: CategoryDTO[];
        home: CategoryDTO[];
    };
    popularServices: ServiceDTO[];
    trendingServices: ServiceDTO[];
    banners: BannerDTO[];
    trustIndicators: TrustIndicatorDTO;
}
/**
 * Mapper: City Entity → City DTO
 */
export declare const toCityDTO: (city: City) => CityDTO;
/**
 * Mapper: ServiceCategory Entity → Category DTO
 */
export declare const toCategoryDTO: (category: ServiceCategory) => CategoryDTO;
/**
 * Mapper: Service Entity → Service DTO
 */
export declare const toServiceDTO: (service: Service) => ServiceDTO;
/**
 * Mapper: PromotionalBanner Entity → Banner DTO
 */
export declare const toBannerDTO: (banner: PromotionalBanner) => BannerDTO;
/**
 * Mapper: AppConfig → Trust Indicator DTO
 */
export declare const toTrustIndicatorDTO: (config: AppConfig) => TrustIndicatorDTO;
//# sourceMappingURL=home.dto.d.ts.map