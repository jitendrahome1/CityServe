"use strict";
/**
 * Data Transfer Objects (DTOs) for Home Screen API
 *
 * DTOs are used to shape the response data sent to clients.
 * They provide a clean interface and hide internal implementation details.
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.toTrustIndicatorDTO = exports.toBannerDTO = exports.toServiceDTO = exports.toCategoryDTO = exports.toCityDTO = void 0;
/**
 * Mapper: City Entity → City DTO
 */
const toCityDTO = (city) => {
    return {
        id: city.id,
        name: city.name,
        displayName: city.displayName,
        currencySymbol: city.currencySymbol,
    };
};
exports.toCityDTO = toCityDTO;
/**
 * Mapper: ServiceCategory Entity → Category DTO
 */
const toCategoryDTO = (category) => {
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
exports.toCategoryDTO = toCategoryDTO;
/**
 * Mapper: Service Entity → Service DTO
 */
const toServiceDTO = (service) => {
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
exports.toServiceDTO = toServiceDTO;
/**
 * Mapper: PromotionalBanner Entity → Banner DTO
 */
const toBannerDTO = (banner) => {
    return {
        id: banner.id,
        title: banner.title,
        subtitle: banner.subtitle,
        imageUrl: banner.imageUrl,
        type: banner.type,
        action: banner.action,
    };
};
exports.toBannerDTO = toBannerDTO;
/**
 * Mapper: AppConfig → Trust Indicator DTO
 */
const toTrustIndicatorDTO = (config) => {
    return {
        totalServicesCompleted: config.trustIndicators.totalServicesCompleted,
        averageRating: config.trustIndicators.averageRating,
        verifiedProfessionals: config.trustIndicators.verifiedProfessionals,
        cities: config.trustIndicators.cities,
    };
};
exports.toTrustIndicatorDTO = toTrustIndicatorDTO;
//# sourceMappingURL=home.dto.js.map