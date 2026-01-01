//
//  ProfileViewModel.swift
//  CityServe
//
//  User Profile Management
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ProfileViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var user: User?

    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    @Published var selectedCity: String = ""

    @Published var addresses: [Address] = []

    @Published var notificationsEnabled: Bool = true
    @Published var emailNotifications: Bool = true
    @Published var smsNotifications: Bool = false
    @Published var pushNotifications: Bool = true

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    let availableCities = ["Delhi", "Mumbai", "Bangalore", "Pune", "Hyderabad", "Chennai", "Kolkata"]

    // MARK: - Computed Properties

    var hasChanges: Bool {
        guard let user = user else { return false }

        return fullName != user.fullName ||
               email != (user.email ?? "") ||
               selectedCity != (user.city ?? "")
    }

    // MARK: - Initialization

    init(user: User? = nil) {
        self.user = user
        loadUserData()
    }

    // MARK: - Data Loading

    func loadUserData() {
        guard let user = user else { return }

        fullName = user.fullName
        email = user.email ?? ""
        phoneNumber = user.phoneNumber
        selectedCity = user.city ?? ""
        addresses = user.addresses
    }

    func setUser(_ user: User) {
        self.user = user
        loadUserData()
    }

    // MARK: - Profile Update

    func updateProfile() async -> Bool {
        guard hasChanges else {
            errorMessage = "No changes to save"
            return false
        }

        isLoading = true
        errorMessage = nil
        successMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)

            // Validate
            guard !fullName.isEmpty else {
                errorMessage = "Name cannot be empty"
                isLoading = false
                return false
            }

            // Update user object
            if var updatedUser = user {
                updatedUser.fullName = fullName
                updatedUser.email = email.isEmpty ? nil : email
                updatedUser.city = selectedCity.isEmpty ? nil : selectedCity
                updatedUser.updatedAt = Date()

                user = updatedUser
                successMessage = "Profile updated successfully"
                isLoading = false
                Haptics.success()
                return true
            }

            isLoading = false
            return false
        } catch {
            errorMessage = "Failed to update profile"
            isLoading = false
            Haptics.error()
            return false
        }
    }

    // MARK: - Address Management

    func addAddress(_ address: Address) {
        addresses.append(address)

        // If this is set as default, remove default from others
        if address.isDefault {
            for i in 0..<addresses.count - 1 {
                addresses[i].isDefault = false
            }
        }

        saveAddresses()
        Haptics.success()
    }

    func updateAddress(_ address: Address) {
        if let index = addresses.firstIndex(where: { $0.id == address.id }) {
            addresses[index] = address

            // If this is set as default, remove default from others
            if address.isDefault {
                for i in 0..<addresses.count {
                    if addresses[i].id != address.id {
                        addresses[i].isDefault = false
                    }
                }
            }

            saveAddresses()
            Haptics.success()
        }
    }

    func deleteAddress(_ addressId: String) {
        addresses.removeAll { $0.id == addressId }
        saveAddresses()
        Haptics.medium()
    }

    func setDefaultAddress(_ addressId: String) {
        for i in 0..<addresses.count {
            addresses[i].isDefault = (addresses[i].id == addressId)
        }
        saveAddresses()
        Haptics.light()
    }

    private func saveAddresses() {
        // In real app, this would sync with backend
        Task {
            isLoading = true
            try await Task.sleep(nanoseconds: 500_000_000)
            isLoading = false
        }
    }

    // MARK: - Notification Settings

    func updateNotificationSettings() async -> Bool {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)

            // In real app, this would update backend and configure FCM

            isLoading = false
            Haptics.success()
            return true
        } catch {
            errorMessage = "Failed to update settings"
            isLoading = false
            Haptics.error()
            return false
        }
    }

    // MARK: - Logout

    func logout() {
        user = nil
        fullName = ""
        email = ""
        phoneNumber = ""
        selectedCity = ""
        addresses = []
        Haptics.medium()
    }
}
