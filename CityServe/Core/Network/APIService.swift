//
//  APIService.swift
//  CityServe
//
//  Network service for API calls
//

import Foundation

enum APIServiceError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case serverError(String)
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let message):
            return "Server error: \(message)"
        case .noData:
            return "No data received from server"
        }
    }
}

actor APIService {

    static let shared = APIService()

    private init() {}

    // MARK: - Home Screen API

    func fetchHomeScreen(cityId: String) async throws -> HomeScreenResponse {
        let endpoint = "\(AppConfig.apiBaseURL)/home/screen"

        guard var urlComponents = URLComponents(string: endpoint) else {
            throw APIServiceError.invalidURL
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "cityId", value: cityId)
        ]

        guard let url = urlComponents.url else {
            throw APIServiceError.invalidURL
        }

        if AppConfig.isLoggingEnabled {
            print("📡 API Request: GET \(url.absoluteString)")
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse {
                if AppConfig.isLoggingEnabled {
                    print("📡 API Response: \(httpResponse.statusCode)")
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    // Try to decode error response
                    if let errorResponse = try? JSONDecoder().decode(APIResponse<HomeScreenResponse>.self, from: data),
                       let error = errorResponse.error {
                        throw APIServiceError.serverError(error.message)
                    }
                    throw APIServiceError.serverError("HTTP \(httpResponse.statusCode)")
                }
            }

            // Decode the response
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys

            let apiResponse = try decoder.decode(APIResponse<HomeScreenResponse>.self, from: data)

            if apiResponse.success, let data = apiResponse.data {
                if AppConfig.isLoggingEnabled {
                    print("✅ API Success: Received home screen data")
                }
                return data
            } else if let error = apiResponse.error {
                throw APIServiceError.serverError(error.message)
            } else {
                throw APIServiceError.noData
            }

        } catch let error as APIServiceError {
            throw error
        } catch let error as DecodingError {
            if AppConfig.isLoggingEnabled {
                print("❌ Decoding Error: \(error)")
            }
            throw APIServiceError.decodingError(error)
        } catch {
            if AppConfig.isLoggingEnabled {
                print("❌ Network Error: \(error)")
            }
            throw APIServiceError.networkError(error)
        }
    }

    // MARK: - Health Check

    func checkHealth() async throws -> Bool {
        guard let url = URL(string: AppConfig.healthCheckURL) else {
            throw APIServiceError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {

                // Try to decode health response
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = json["status"] as? String {
                    return status == "healthy"
                }

                return true
            }

            return false
        } catch {
            if AppConfig.isLoggingEnabled {
                print("❌ Health check failed: \(error)")
            }
            return false
        }
    }
}

// MARK: - Model Mappers

extension HomeScreenResponse {

    /// Convert API DTOs to app models
    func toAppModels() -> (categories: [ServiceCategory], services: [Service]) {
        // Map categories
        var categories: [ServiceCategory] = []

        // Personal services
        categories.append(contentsOf: self.categories.personal.map { dto in
            ServiceCategory(
                id: dto.id,
                name: dto.name,
                icon: dto.icon,
                description: dto.displayName,
                imageURL: dto.imageUrl.isEmpty ? nil : dto.imageUrl,
                serviceCount: 0, // Not available from API yet
                isActive: true,
                sortOrder: dto.sortOrder
            )
        })

        // Home services
        categories.append(contentsOf: self.categories.home.map { dto in
            ServiceCategory(
                id: dto.id,
                name: dto.name,
                icon: dto.icon,
                description: dto.displayName,
                imageURL: dto.imageUrl.isEmpty ? nil : dto.imageUrl,
                serviceCount: 0, // Not available from API yet
                isActive: true,
                sortOrder: dto.sortOrder
            )
        })

        // Map services
        let services = self.popularServices.map { dto in
            Service(
                id: dto.id,
                categoryId: dto.categoryId,
                name: dto.name,
                shortDescription: dto.shortDescription,
                longDescription: dto.shortDescription, // Using short description for now
                icon: nil, // Not available from API
                imageURL: dto.imageUrl.isEmpty ? nil : dto.imageUrl,
                basePrice: dto.basePrice,
                priceRange: dto.priceRange.map { PriceRange(min: $0.min, max: $0.max) },
                duration: dto.duration,
                rating: dto.rating,
                reviewCount: dto.reviewCount,
                isPopular: true, // Popular services endpoint
                isActive: true,
                tags: dto.tags,
                inclusions: [], // Not available from API yet
                exclusions: [], // Not available from API yet
                faqs: [], // Not available from API yet
                createdAt: Date(),
                updatedAt: Date()
            )
        }

        return (categories, services)
    }
}
