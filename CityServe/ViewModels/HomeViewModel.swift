//
//  HomeViewModel.swift
//  CityServe
//
//  Home Screen ViewModel - Service Discovery
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var categories: [ServiceCategory] = []
    @Published var popularServices: [Service] = []
    @Published var allServices: [Service] = []
    @Published var filteredServices: [Service] = []

    // New: Urban Company layout sections
    @Published var personalServiceCategories: [ServiceCategory] = []
    @Published var homeServiceCategories: [ServiceCategory] = []
    @Published var trendingServices: [Service] = []
    @Published var sponsoredAd: SponsoredAd?

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var searchText = ""
    @Published var selectedCategory: ServiceCategory?
    @Published var filters = ServiceFilters()

    @Published var selectedCity = "Delhi"
    let availableCities = ["Delhi", "Mumbai", "Bangalore", "Pune", "Hyderabad"]

    // MARK: - Computed Properties

    var hasSearchResults: Bool {
        !searchText.isEmpty
    }

    var displayedServices: [Service] {
        if hasSearchResults {
            return filteredServices
        } else if let category = selectedCategory {
            return allServices.filter { $0.categoryId == category.id }
        } else {
            return popularServices
        }
    }

    // MARK: - Initialization

    init() {
        loadInitialData()
    }

    // MARK: - Data Loading

    func loadInitialData() {
        // Load data from API
        Task {
            await fetchHomeScreenData()
        }
    }

    private func fetchHomeScreenData() async {
        isLoading = true
        errorMessage = nil

        do {
            // Convert city name to lowercase ID for API (e.g., "Delhi" -> "delhi")
            let cityId = selectedCity.lowercased()

            if AppConfig.isLoggingEnabled {
                print("🏠 Fetching home screen data for city: \(cityId)")
            }

            // Fetch data from API
            let response = try await APIService.shared.fetchHomeScreen(cityId: cityId)

            // Convert API models to app models
            let (apiCategories, apiServices) = response.toAppModels()

            // Update UI on main actor
            categories = apiCategories
            allServices = apiServices
            popularServices = apiServices // All services from popular endpoint

            // Split categories into Personal and Home services
            personalServiceCategories = categories.filter { $0.name.contains("Salon") || $0.name.contains("Spa") || $0.name.contains("Hair") || $0.name.contains("Massage") }

            homeServiceCategories = categories.filter { $0.name.contains("Electrical") || $0.name.contains("Cleaning") || $0.name.contains("Plumbing") || $0.name.contains("Painting") || $0.name.contains("Pest") }

            // Trending services from API (if available)
            if let trending = response.trendingServices, !trending.isEmpty {
                trendingServices = trending.map { dto in
                    Service(
                        id: dto.id,
                        categoryId: dto.categoryId,
                        name: dto.name,
                        shortDescription: dto.shortDescription,
                        longDescription: dto.shortDescription,
                        icon: nil,
                        imageURL: dto.imageUrl.isEmpty ? nil : dto.imageUrl,
                        basePrice: dto.basePrice,
                        priceRange: dto.priceRange.map { PriceRange(min: $0.min, max: $0.max) },
                        duration: dto.duration,
                        rating: dto.rating,
                        reviewCount: dto.reviewCount,
                        isPopular: false,
                        isActive: true,
                        tags: dto.tags,
                        inclusions: [],
                        exclusions: [],
                        faqs: [],
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                }
            } else {
                // Fallback: Filter from popular services
                trendingServices = allServices.filter { $0.rating >= 4.5 && $0.reviewCount > 100 }
            }

            // Mock sponsored ad (not in API yet)
            sponsoredAd = SponsoredAd(
                id: "ad_001",
                title: "Two's better than one.",
                subtitle: "Buy one Flatbread Pizza, get another for ₹99",
                imageURL: "",
                deepLink: "/offers/pizza"
            )

            isLoading = false

            if AppConfig.isLoggingEnabled {
                print("✅ Home screen data loaded successfully")
                print("   - Categories: \(categories.count)")
                print("   - Services: \(allServices.count)")
            }

        } catch {
            errorMessage = error.localizedDescription

            if AppConfig.isLoggingEnabled {
                print("❌ Failed to load home screen data: \(error)")
            }

            // Fallback to mock data on error
            categories = ServiceCategory.mockCategories
            allServices = Service.mockServices
            popularServices = allServices.filter { $0.isPopular }

            personalServiceCategories = categories.filter { category in
                ["Salon for Women", "Spa for Women", "Hair & Skin", "Salon for Men", "Massage for Men"].contains(category.name)
            }

            homeServiceCategories = categories.filter { category in
                ["Electrical", "Cleaning", "Plumbing", "Painting", "Pest Control"].contains(category.name)
            }

            trendingServices = allServices.filter { $0.rating >= 4.5 && $0.reviewCount > 100 }

            sponsoredAd = SponsoredAd(
                id: "ad_001",
                title: "Two's better than one.",
                subtitle: "Buy one Flatbread Pizza, get another for ₹99",
                imageURL: "",
                deepLink: "/offers/pizza"
            )

            isLoading = false
        }
    }

    func refreshData() async {
        await fetchHomeScreenData()
    }

    // MARK: - Search

    func performSearch() {
        guard !searchText.isEmpty else {
            filteredServices = []
            return
        }

        let query = searchText.lowercased()

        filteredServices = allServices.filter { service in
            service.name.lowercased().contains(query) ||
            service.shortDescription.lowercased().contains(query) ||
            service.tags.contains(where: { $0.lowercased().contains(query) })
        }

        // Apply filters if any
        applyFilters()
    }

    func clearSearch() {
        searchText = ""
        filteredServices = []
    }

    // MARK: - Filters

    func applyFilters() {
        var results = hasSearchResults ? filteredServices : allServices

        // Filter by category
        if let categoryId = filters.categoryId {
            results = results.filter { $0.categoryId == categoryId }
        }

        // Filter by price range
        if let priceRange = filters.priceRange {
            results = results.filter { service in
                if let range = service.priceRange {
                    return range.min >= priceRange.min && range.max <= priceRange.max
                } else {
                    return service.basePrice >= priceRange.min && service.basePrice <= priceRange.max
                }
            }
        }

        // Filter by minimum rating
        if let minRating = filters.minRating {
            results = results.filter { $0.rating >= minRating }
        }

        // Sort results
        results = sortServices(results, by: filters.sortBy)

        if hasSearchResults {
            filteredServices = results
        } else {
            filteredServices = results
        }
    }

    func clearFilters() {
        filters = ServiceFilters()
        applyFilters()
    }

    private func sortServices(_ services: [Service], by sortOption: ServiceFilters.SortOption) -> [Service] {
        switch sortOption {
        case .recommended:
            return services.sorted { service1, service2 in
                // Sort by popularity, then rating
                if service1.isPopular != service2.isPopular {
                    return service1.isPopular
                } else {
                    return service1.rating > service2.rating
                }
            }

        case .priceLowToHigh:
            return services.sorted { $0.basePrice < $1.basePrice }

        case .priceHighToLow:
            return services.sorted { $0.basePrice > $1.basePrice }

        case .rating:
            return services.sorted { $0.rating > $1.rating }

        case .popular:
            return services.sorted { service1, service2 in
                if service1.isPopular != service2.isPopular {
                    return service1.isPopular
                } else {
                    return service1.reviewCount > service2.reviewCount
                }
            }
        }
    }

    // MARK: - Category Selection

    func selectCategory(_ category: ServiceCategory) {
        selectedCategory = category
        filters.categoryId = category.id
        applyFilters()
    }

    func clearCategorySelection() {
        selectedCategory = nil
        filters.categoryId = nil
        applyFilters()
    }

    // MARK: - City Selection

    func changeCity(_ newCity: String) {
        selectedCity = newCity
        // Reload services for new city from API
        Task {
            await fetchHomeScreenData()
        }
    }
}

// MARK: - Sponsored Ad Model

struct SponsoredAd: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let imageURL: String
    let deepLink: String
}
