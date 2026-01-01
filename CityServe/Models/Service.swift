//
//  Service.swift
//  CityServe
//
//  Data Models for Services and Categories
//

import Foundation

// MARK: - Service Category

struct ServiceCategory: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let icon: String // SF Symbol name
    let description: String
    let imageURL: String?
    let serviceCount: Int
    let isActive: Bool
    let sortOrder: Int

    // Computed property for icon color
    var iconColor: String {
        switch name.lowercased() {
        case "ac repair", "electrical": return "primary"
        case "plumbing": return "info"
        case "cleaning": return "success"
        case "salon", "beauty": return "secondary"
        case "painting": return "warning"
        default: return "primary"
        }
    }
}

// MARK: - Service

struct Service: Codable, Identifiable, Hashable {
    let id: String
    let categoryId: String
    let name: String
    let shortDescription: String
    let longDescription: String
    let icon: String? // SF Symbol name
    let imageURL: String?
    let basePrice: Double
    let priceRange: PriceRange?
    let duration: Int // minutes
    let rating: Double
    let reviewCount: Int
    let isPopular: Bool
    let isActive: Bool
    let tags: [String]
    let inclusions: [String]
    let exclusions: [String]
    let faqs: [FAQ]
    let createdAt: Date
    let updatedAt: Date

    // Formatted price
    var formattedPrice: String {
        if let range = priceRange {
            return "₹\(Int(range.min)) - ₹\(Int(range.max))"
        } else {
            return "₹\(Int(basePrice))"
        }
    }

    // Formatted duration
    var formattedDuration: String {
        let hours = duration / 60
        let minutes = duration % 60

        if hours > 0 && minutes > 0 {
            return "\(hours)h \(minutes)m"
        } else if hours > 0 {
            return "\(hours) hour\(hours > 1 ? "s" : "")"
        } else {
            return "\(minutes) min"
        }
    }

    // Star rating (0-5)
    var starRating: Int {
        Int(round(rating))
    }
}

// MARK: - Price Range

struct PriceRange: Codable, Hashable {
    let min: Double
    let max: Double
}

// MARK: - FAQ

struct FAQ: Codable, Identifiable, Hashable {
    let id: String
    let question: String
    let answer: String
}

// MARK: - Service Review

struct ServiceReview: Codable, Identifiable {
    let id: String
    let serviceId: String
    let userId: String
    let userName: String
    let userPhotoURL: String?
    let rating: Double
    let comment: String
    let images: [String]?
    let createdAt: Date

    // Formatted date
    var formattedDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: createdAt, relativeTo: Date())
    }
}

// MARK: - Search Filters

struct ServiceFilters: Hashable {
    var categoryId: String?
    var priceRange: PriceRange?
    var minRating: Double?
    var sortBy: SortOption = .recommended

    // Location Filters
    var useCurrentLocation: Bool = true
    var distanceKm: Double = 5.0

    // Availability Filters
    var availableToday: Bool = false
    var availableThisWeek: Bool = false
    var preferredTimeSlot: TimeSlotOption?

    // Provider Preferences
    var verifiedOnly: Bool = false
    var topRatedOnly: Bool = false
    var experiencedOnly: Bool = false
    var fastResponseOnly: Bool = false

    // Service Type Filters
    var residentialServices: Bool = false
    var commercialServices: Bool = false
    var emergencyServices: Bool = false

    // Additional Filters
    var offersAvailable: Bool = false
    var freeCancellation: Bool = false
    var sameDayService: Bool = false
    var warrantyIncluded: Bool = false

    enum SortOption: String, CaseIterable {
        case recommended = "Recommended"
        case priceLowToHigh = "Price: Low to High"
        case priceHighToLow = "Price: High to Low"
        case rating = "Highest Rated"
        case popular = "Most Popular"
    }
}

// MARK: - Time Slot Option

enum TimeSlotOption: String, Hashable, CaseIterable {
    case morning = "morning"
    case afternoon = "afternoon"
    case evening = "evening"
    case night = "night"

    var displayName: String {
        switch self {
        case .morning: return "Morning (6 AM - 12 PM)"
        case .afternoon: return "Afternoon (12 PM - 6 PM)"
        case .evening: return "Evening (6 PM - 10 PM)"
        case .night: return "Night (10 PM - 6 AM)"
        }
    }
}

// MARK: - Mock Data

extension ServiceCategory {
    static let mockCategories: [ServiceCategory] = [
        ServiceCategory(
            id: "1",
            name: "AC Repair",
            icon: "air.conditioner.horizontal",
            description: "AC installation, repair & servicing",
            imageURL: nil,
            serviceCount: 12,
            isActive: true,
            sortOrder: 1
        ),
        ServiceCategory(
            id: "2",
            name: "Plumbing",
            icon: "drop.fill",
            description: "Tap repair, pipe fitting & more",
            imageURL: nil,
            serviceCount: 18,
            isActive: true,
            sortOrder: 2
        ),
        ServiceCategory(
            id: "3",
            name: "Electrical",
            icon: "bolt.fill",
            description: "Wiring, switch repair & installation",
            imageURL: nil,
            serviceCount: 15,
            isActive: true,
            sortOrder: 3
        ),
        ServiceCategory(
            id: "4",
            name: "Salon at Home",
            icon: "scissors",
            description: "Haircut, styling & grooming",
            imageURL: nil,
            serviceCount: 24,
            isActive: true,
            sortOrder: 4
        ),
        ServiceCategory(
            id: "5",
            name: "Cleaning",
            icon: "sparkles",
            description: "Home cleaning & deep cleaning",
            imageURL: nil,
            serviceCount: 8,
            isActive: true,
            sortOrder: 5
        ),
        ServiceCategory(
            id: "6",
            name: "Painting",
            icon: "paintbrush.fill",
            description: "Interior & exterior painting",
            imageURL: nil,
            serviceCount: 6,
            isActive: true,
            sortOrder: 6
        )
    ]
}

extension Service {
    static let mockServices: [Service] = [
        Service(
            id: "1",
            categoryId: "1",
            name: "AC Repair & Service",
            shortDescription: "Complete AC maintenance and repair",
            longDescription: "Professional AC repair and servicing by experienced technicians. Includes gas check, filter cleaning, and performance optimization.",
            icon: "air.conditioner.horizontal",
            imageURL: nil,
            basePrice: 499,
            priceRange: PriceRange(min: 499, max: 1999),
            duration: 60,
            rating: 4.8,
            reviewCount: 1234,
            isPopular: true,
            isActive: true,
            tags: ["Popular", "Same Day"],
            inclusions: ["Gas check", "Filter cleaning", "Performance test"],
            exclusions: ["Gas refill", "Spare parts"],
            faqs: [
                FAQ(id: "1", question: "How long does it take?", answer: "Usually 45-60 minutes"),
                FAQ(id: "2", question: "Do you provide warranty?", answer: "Yes, 30 days warranty on service")
            ],
            createdAt: Date(),
            updatedAt: Date()
        ),
        Service(
            id: "2",
            categoryId: "2",
            name: "Tap Repair",
            shortDescription: "Fix leaking taps and faucets",
            longDescription: "Expert plumbing service for tap repairs, leakage fixing, and faucet installation.",
            icon: "drop.fill",
            imageURL: nil,
            basePrice: 299,
            priceRange: PriceRange(min: 299, max: 799),
            duration: 30,
            rating: 4.6,
            reviewCount: 856,
            isPopular: true,
            isActive: true,
            tags: ["Quick Fix", "Emergency"],
            inclusions: ["Inspection", "Basic repair", "Leak fixing"],
            exclusions: ["Spare parts", "Pipe replacement"],
            faqs: [],
            createdAt: Date(),
            updatedAt: Date()
        ),
        Service(
            id: "3",
            categoryId: "3",
            name: "Electrical Wiring",
            shortDescription: "Wiring and switch installation",
            longDescription: "Complete electrical wiring services including switch installation, light fitting, and circuit repair.",
            icon: "bolt.fill",
            imageURL: nil,
            basePrice: 399,
            priceRange: PriceRange(min: 399, max: 1499),
            duration: 90,
            rating: 4.7,
            reviewCount: 652,
            isPopular: false,
            isActive: true,
            tags: ["Certified"],
            inclusions: ["Safety check", "Installation", "Testing"],
            exclusions: ["Materials", "Heavy equipment"],
            faqs: [],
            createdAt: Date(),
            updatedAt: Date()
        ),
        Service(
            id: "4",
            categoryId: "4",
            name: "Men's Haircut at Home",
            shortDescription: "Professional haircut at your doorstep",
            longDescription: "Get a fresh haircut from experienced barbers in the comfort of your home.",
            icon: "scissors",
            imageURL: nil,
            basePrice: 299,
            priceRange: nil,
            duration: 45,
            rating: 4.9,
            reviewCount: 2145,
            isPopular: true,
            isActive: true,
            tags: ["Popular", "Same Day"],
            inclusions: ["Haircut", "Hair wash", "Styling"],
            exclusions: ["Hair coloring", "Spa treatment"],
            faqs: [],
            createdAt: Date(),
            updatedAt: Date()
        ),
        Service(
            id: "5",
            categoryId: "5",
            name: "Home Deep Cleaning",
            shortDescription: "Comprehensive home cleaning service",
            longDescription: "Deep cleaning of your entire home including kitchen, bathrooms, and all rooms.",
            icon: "sparkles",
            imageURL: nil,
            basePrice: 1999,
            priceRange: PriceRange(min: 1999, max: 4999),
            duration: 240,
            rating: 4.8,
            reviewCount: 987,
            isPopular: true,
            isActive: true,
            tags: ["Popular", "Verified"],
            inclusions: ["All rooms", "Kitchen", "Bathrooms", "Eco-friendly products"],
            exclusions: ["Laundry", "Utensil cleaning"],
            faqs: [],
            createdAt: Date(),
            updatedAt: Date()
        ),
        Service(
            id: "6",
            categoryId: "6",
            name: "Interior Wall Painting",
            shortDescription: "Professional wall painting service",
            longDescription: "Expert painters for interior walls with premium quality paints and finishing.",
            icon: "paintbrush.fill",
            imageURL: nil,
            basePrice: 2999,
            priceRange: PriceRange(min: 2999, max: 9999),
            duration: 480,
            rating: 4.5,
            reviewCount: 456,
            isPopular: false,
            isActive: true,
            tags: ["Premium"],
            inclusions: ["Surface preparation", "2 coats", "Cleanup"],
            exclusions: ["Paint cost", "Furniture moving"],
            faqs: [],
            createdAt: Date(),
            updatedAt: Date()
        )
    ]
}
