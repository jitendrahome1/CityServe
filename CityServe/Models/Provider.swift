//
//  Provider.swift
//  CityServe
//
//  Provider/Professional Data Model
//

import Foundation

// MARK: - Provider

struct Provider: Codable, Identifiable {
    let id: String
    let fullName: String
    let phoneNumber: String
    let email: String?
    let photoURL: String?
    let bio: String?
    let city: String
    let serviceCategories: [String] // Category IDs
    let rating: Double
    let reviewCount: Int
    let completedJobs: Int
    let experienceYears: Int
    let isVerified: Bool
    let isActive: Bool
    let availability: Availability
    let documents: ProviderDocuments
    let certifications: [String]
    let joinedAt: Date

    // Formatted rating
    var formattedRating: String {
        String(format: "%.1f", rating)
    }

    // Experience text
    var experienceText: String {
        "\(experienceYears) year\(experienceYears > 1 ? "s" : "") experience"
    }

    // Jobs completed text
    var jobsCompletedText: String {
        if completedJobs >= 1000 {
            return "\(completedJobs / 1000)k+ jobs"
        } else {
            return "\(completedJobs) jobs"
        }
    }
}

// MARK: - Availability

struct Availability: Codable {
    let isAvailableNow: Bool
    let workingHours: WorkingHours
    let workingDays: [String] // ["Monday", "Tuesday", ...]
}

struct WorkingHours: Codable {
    let start: String // "09:00"
    let end: String // "18:00"
}

// MARK: - Provider Documents

struct ProviderDocuments: Codable {
    let aadhaarNumber: String? // Masked
    let panNumber: String? // Masked
    let photoIdURL: String?
    let addressProofURL: String?
    let policeClearanceURL: String?
    let isVerified: Bool
}

// MARK: - Provider Review

struct ProviderReview: Codable, Identifiable {
    let id: String
    let providerId: String
    let userId: String
    let userName: String
    let userPhotoURL: String?
    let rating: Double
    let comment: String
    let serviceId: String
    let serviceName: String
    let images: [String]?
    let createdAt: Date

    // Formatted date
    var formattedDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: createdAt, relativeTo: Date())
    }
}

// MARK: - Mock Data

extension Provider {
    static let mockProviders: [Provider] = [
        Provider(
            id: "P1",
            fullName: "Rajesh Kumar",
            phoneNumber: "9876543210",
            email: "rajesh.kumar@example.com",
            photoURL: nil,
            bio: "Expert AC technician with 8 years of experience. Specialized in all brands.",
            city: "Delhi",
            serviceCategories: ["1", "3"], // AC Repair, Electrical
            rating: 4.8,
            reviewCount: 234,
            completedJobs: 1456,
            experienceYears: 8,
            isVerified: true,
            isActive: true,
            availability: Availability(
                isAvailableNow: true,
                workingHours: WorkingHours(start: "09:00", end: "19:00"),
                workingDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            ),
            documents: ProviderDocuments(
                aadhaarNumber: "****-****-1234",
                panNumber: "****56789A",
                photoIdURL: nil,
                addressProofURL: nil,
                policeClearanceURL: nil,
                isVerified: true
            ),
            certifications: ["HVAC Certified", "Electrical Safety"],
            joinedAt: Date().addingTimeInterval(-365 * 24 * 60 * 60 * 2) // 2 years ago
        ),
        Provider(
            id: "P2",
            fullName: "Amit Sharma",
            phoneNumber: "9765432109",
            email: nil,
            photoURL: nil,
            bio: "Professional plumber serving Delhi NCR. Quick and reliable service.",
            city: "Delhi",
            serviceCategories: ["2"], // Plumbing
            rating: 4.6,
            reviewCount: 156,
            completedJobs: 876,
            experienceYears: 5,
            isVerified: true,
            isActive: true,
            availability: Availability(
                isAvailableNow: false,
                workingHours: WorkingHours(start: "08:00", end: "20:00"),
                workingDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
            ),
            documents: ProviderDocuments(
                aadhaarNumber: "****-****-5678",
                panNumber: nil,
                photoIdURL: nil,
                addressProofURL: nil,
                policeClearanceURL: nil,
                isVerified: true
            ),
            certifications: ["Licensed Plumber"],
            joinedAt: Date().addingTimeInterval(-365 * 24 * 60 * 60) // 1 year ago
        ),
        Provider(
            id: "P3",
            fullName: "Vikram Singh",
            phoneNumber: "9654321098",
            email: "vikram.singh@example.com",
            photoURL: nil,
            bio: "Certified barber with expertise in modern hairstyles. 10+ years experience.",
            city: "Delhi",
            serviceCategories: ["4"], // Salon
            rating: 4.9,
            reviewCount: 543,
            completedJobs: 2341,
            experienceYears: 10,
            isVerified: true,
            isActive: true,
            availability: Availability(
                isAvailableNow: true,
                workingHours: WorkingHours(start: "10:00", end: "21:00"),
                workingDays: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
            ),
            documents: ProviderDocuments(
                aadhaarNumber: "****-****-9012",
                panNumber: "****12345B",
                photoIdURL: nil,
                addressProofURL: nil,
                policeClearanceURL: nil,
                isVerified: true
            ),
            certifications: ["Professional Hairstylist", "Beauty & Wellness Certified"],
            joinedAt: Date().addingTimeInterval(-365 * 24 * 60 * 60 * 3) // 3 years ago
        )
    ]
}

extension ProviderReview {
    static let mockReviews: [ProviderReview] = [
        ProviderReview(
            id: "R1",
            providerId: "P1",
            userId: "U1",
            userName: "Priya Sharma",
            userPhotoURL: nil,
            rating: 5.0,
            comment: "Excellent service! Very professional and fixed my AC in no time. Highly recommended.",
            serviceId: "1",
            serviceName: "AC Repair & Service",
            images: nil,
            createdAt: Date().addingTimeInterval(-7 * 24 * 60 * 60) // 7 days ago
        ),
        ProviderReview(
            id: "R2",
            providerId: "P1",
            userId: "U2",
            userName: "Rohit Verma",
            userPhotoURL: nil,
            rating: 4.5,
            comment: "Good work. Came on time and completed the job efficiently.",
            serviceId: "1",
            serviceName: "AC Repair & Service",
            images: nil,
            createdAt: Date().addingTimeInterval(-14 * 24 * 60 * 60) // 14 days ago
        ),
        ProviderReview(
            id: "R3",
            providerId: "P3",
            userId: "U3",
            userName: "Anjali Gupta",
            userPhotoURL: nil,
            rating: 5.0,
            comment: "Best haircut I've ever had! Very skilled and patient. Will book again.",
            serviceId: "4",
            serviceName: "Men's Haircut at Home",
            images: nil,
            createdAt: Date().addingTimeInterval(-3 * 24 * 60 * 60) // 3 days ago
        )
    ]
}
