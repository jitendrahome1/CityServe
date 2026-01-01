//
//  ServiceDetailViewModel.swift
//  CityServe
//
//  Service Detail ViewModel
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ServiceDetailViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var service: Service
    @Published var provider: Provider?
    @Published var reviews: [ServiceReview] = []
    @Published var relatedServices: [Service] = []

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var selectedFAQIndex: Int?
    @Published var showAllReviews = false

    // MARK: - Computed Properties

    var displayedReviews: [ServiceReview] {
        showAllReviews ? reviews : Array(reviews.prefix(3))
    }

    var hasMoreReviews: Bool {
        reviews.count > 3
    }

    var ratingDistribution: [Int: Int] {
        var distribution: [Int: Int] = [5: 0, 4: 0, 3: 0, 2: 0, 1: 0]

        for review in reviews {
            let rating = Int(round(review.rating))
            distribution[rating, default: 0] += 1
        }

        return distribution
    }

    var averageRating: Double {
        service.rating
    }

    // MARK: - Initialization

    init(service: Service) {
        self.service = service
        loadServiceDetails()
    }

    // MARK: - Data Loading

    func loadServiceDetails() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                // Simulate network delay
                try await Task.sleep(nanoseconds: 800_000_000) // 0.8 seconds

                // Load mock reviews
                reviews = generateMockReviews(count: 8)

                // Load related services (same category)
                relatedServices = Service.mockServices.filter {
                    $0.categoryId == service.categoryId && $0.id != service.id
                }

                // Load provider (for now, just pick first mock provider)
                provider = Provider.mockProviders.first

                isLoading = false
            } catch {
                errorMessage = "Failed to load service details."
                isLoading = false
            }
        }
    }

    func refreshData() async {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

            reviews = generateMockReviews(count: 8)
            relatedServices = Service.mockServices.filter {
                $0.categoryId == service.categoryId && $0.id != service.id
            }

            isLoading = false
        } catch {
            errorMessage = "Failed to refresh data."
            isLoading = false
        }
    }

    // MARK: - FAQ Management

    func toggleFAQ(_ index: Int) {
        if selectedFAQIndex == index {
            selectedFAQIndex = nil
        } else {
            selectedFAQIndex = index
        }
    }

    // MARK: - Reviews Management

    func toggleShowAllReviews() {
        showAllReviews.toggle()
    }

    // MARK: - Mock Data Generation

    private func generateMockReviews(count: Int) -> [ServiceReview] {
        let names = ["Rahul Sharma", "Priya Singh", "Amit Kumar", "Sneha Gupta", "Vikram Verma", "Anjali Mehta", "Rohan Kapoor", "Neha Reddy"]
        let comments = [
            "Excellent service! Very professional and completed the job perfectly.",
            "Great experience. The professional was skilled and courteous.",
            "Satisfactory service. Got the job done as expected.",
            "Amazing work! Highly recommend this service.",
            "Good value for money. Will book again.",
            "Professional and on-time. Very satisfied with the service.",
            "Could have been better, but overall okay.",
            "Outstanding service! Exceeded my expectations."
        ]

        var mockReviews: [ServiceReview] = []

        for i in 0..<min(count, names.count) {
            let review = ServiceReview(
                id: "SR\(i + 1)",
                serviceId: service.id,
                userId: "U\(i + 1)",
                userName: names[i],
                userPhotoURL: nil,
                rating: Double([4.0, 4.5, 5.0, 3.5, 4.0, 5.0, 3.0, 5.0][i]),
                comment: comments[i],
                images: nil,
                createdAt: Date().addingTimeInterval(-Double(i + 1) * 7 * 24 * 60 * 60) // i+1 weeks ago
            )
            mockReviews.append(review)
        }

        return mockReviews
    }
}
