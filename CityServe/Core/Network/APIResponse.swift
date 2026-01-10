//
//  APIResponse.swift
//  CityServe
//
//  API Response Models matching backend DTOs
//

import Foundation

// MARK: - Generic API Response

struct APIResponse<T: Codable>: Codable {
    let success: Bool
    let data: T?
    let error: APIError?
    let timestamp: String
}

struct APIError: Codable {
    let code: String
    let message: String
    let details: [String: String]?
}

// MARK: - Home Screen Response

struct HomeScreenResponse: Codable {
    let city: CityDTO
    let categories: CategoriesDTO
    let popularServices: [ServiceDTO]
    let trendingServices: [ServiceDTO]?
    let banners: [BannerDTO]?
    let trustIndicators: TrustIndicatorDTO?
}

struct CityDTO: Codable {
    let id: String
    let name: String
    let displayName: String
    let currencySymbol: String
}

struct CategoriesDTO: Codable {
    let personal: [CategoryDTO]
    let home: [CategoryDTO]
}

struct CategoryDTO: Codable {
    let id: String
    let name: String
    let displayName: String
    let type: String
    let icon: String
    let imageUrl: String
    let sortOrder: Int
    let color: String
    let isPopular: Bool
}

struct ServiceDTO: Codable {
    let id: String
    let categoryId: String
    let name: String
    let shortDescription: String
    let basePrice: Double
    let priceRange: PriceRangeDTO?
    let duration: Int
    let rating: Double
    let reviewCount: Int
    let imageUrl: String
    let tags: [String]
}

struct PriceRangeDTO: Codable {
    let min: Double
    let max: Double
}

struct BannerDTO: Codable {
    let id: String
    let title: String
    let subtitle: String?
    let imageUrl: String
    let type: String
    let action: BannerActionDTO?
}

struct BannerActionDTO: Codable {
    let type: String
    let target: String
}

struct TrustIndicatorDTO: Codable {
    let totalServicesCompleted: Int
    let averageRating: Double
    let verifiedProfessionals: Int
    let cities: Int
}
