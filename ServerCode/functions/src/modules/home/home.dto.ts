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
  imageUrl?: string; // First image from imageUrls array
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
export const toCityDTO = (city: City): CityDTO => {
  return {
    id: city.id,
    name: city.name,
    displayName: city.displayName,
    currencySymbol: city.currencySymbol,
  };
};

/**
 * Mapper: ServiceCategory Entity → Category DTO
 */
export const toCategoryDTO = (category: ServiceCategory): CategoryDTO => {
  return {
    id: category.id,
    name: category.name,
    displayName: category.displayName,
    type: category.type,
    icon: category.icon,
    imageUrl: category.imageUrl,
    sortOrder: category.sortOrder,
    color: category.metadata.color,
    isPopular: category.isPopular,
  };
};

/**
 * Mapper: Service Entity → Service DTO
 */
export const toServiceDTO = (service: Service): ServiceDTO => {
  return {
    id: service.id,
    categoryId: service.categoryId,
    name: service.name,
    shortDescription: service.shortDescription,
    basePrice: service.basePrice,
    priceRange: service.priceRange,
    duration: service.duration,
    rating: service.rating,
    reviewCount: service.reviewCount,
    imageUrl: service.imageUrls?.[0], // First image
    tags: service.tags,
  };
};

/**
 * Mapper: PromotionalBanner Entity → Banner DTO
 */
export const toBannerDTO = (banner: PromotionalBanner): BannerDTO => {
  return {
    id: banner.id,
    title: banner.title,
    subtitle: banner.subtitle,
    imageUrl: banner.imageUrl,
    type: banner.type,
    action: banner.action,
  };
};

/**
 * Mapper: AppConfig → Trust Indicator DTO
 */
export const toTrustIndicatorDTO = (config: AppConfig): TrustIndicatorDTO => {
  return {
    totalServicesCompleted: config.trustIndicators.totalServicesCompleted,
    averageRating: config.trustIndicators.averageRating,
    verifiedProfessionals: config.trustIndicators.verifiedProfessionals,
    cities: config.trustIndicators.cities,
  };
};
