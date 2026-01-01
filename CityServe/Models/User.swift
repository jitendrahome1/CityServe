//
//  User.swift
//  CityServe
//
//  User Model
//

import Foundation

/// User model representing customer or provider
struct User: Codable, Identifiable {
    let id: String
    var fullName: String
    var email: String?
    var phoneNumber: String
    var photoURL: String?
    var userType: UserType
    var city: String?
    var addresses: [Address]
    var createdAt: Date
    var updatedAt: Date

    enum UserType: String, Codable {
        case customer
        case provider
        case admin
    }
}

/// Address model
struct Address: Codable, Identifiable, Hashable {
    let id: String
    var label: String // "Home", "Office", "Other"
    var fullAddress: String
    var city: String
    var isDefault: Bool

    static func empty() -> Address {
        Address(
            id: UUID().uuidString,
            label: "Home",
            fullAddress: "",
            city: "",
            isDefault: true
        )
    }
}

/// Phone verification model
struct PhoneVerification: Codable {
    let verificationId: String
    let phoneNumber: String
    let expiresAt: Date
}

/// Registration request
struct RegistrationRequest: Codable {
    let phoneNumber: String
    let fullName: String
    let email: String?
    let city: String
}
