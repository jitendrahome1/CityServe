//
//  AuthViewModel.swift
//  CityServe
//
//  Authentication State Management
//  Integrated with Firebase Authentication
//

import Foundation
import SwiftUI
import Combine
// import FirebaseAuth // TODO: Enable when Firebase is configured

@MainActor
class AuthViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Phone verification
    @Published var phoneNumber = ""
    @Published var verificationId: String?
    @Published var otpCode = ""

    // Registration
    @Published var fullName = ""
    @Published var email = ""
    @Published var selectedCity = ""

    // MARK: - Services

    private let authService = FirebaseAuthService.shared
    private let firestoreService = FirestoreService.shared
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Available Cities

    let availableCities = [
        "Delhi",
        "Mumbai",
        "Bangalore",
        "Hyderabad",
        "Chennai",
        "Pune",
        "Kolkata",
        "Ahmedabad"
    ]

    // MARK: - Initialization

    init() {
        setupAuthStateListener()
    }

    // MARK: - Auth State Listener

    private func setupAuthStateListener() {
        authService.$isAuthenticated
            .sink { [weak self] isAuth in
                self?.isAuthenticated = isAuth
            }
            .store(in: &cancellables)

        authService.$currentUser
            .sink { [weak self] firebaseUser in
                guard let self = self, let firebaseUser = firebaseUser else { return }

                // Fetch user from Firestore when Firebase auth state changes
                Task {
                    await self.fetchUserFromFirestore(uid: firebaseUser.uid)
                }
            }
            .store(in: &cancellables)
    }

    private func fetchUserFromFirestore(uid: String) async {
        do {
            let user = try await firestoreService.fetchUser(id: uid)
            self.currentUser = user
            print("✅ User loaded from Firestore: \(user.fullName)")
        } catch {
            print("⚠️ User not found in Firestore (might be new user)")
        }
    }

    // MARK: - Phone Number Validation

    func validatePhoneNumber(_ phone: String) -> Bool {
        // Remove spaces and special characters
        let cleaned = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        // Check if it's a valid 10-digit Indian phone number
        if cleaned.count == 10 {
            // Check if it starts with 6, 7, 8, or 9
            if let firstDigit = cleaned.first, ["6", "7", "8", "9"].contains(String(firstDigit)) {
                return true
            }
        }

        return false
    }

    func formatPhoneNumber(_ phone: String) -> String {
        let cleaned = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let mask = "XXX XXX XXXX"
        var result = ""
        var index = cleaned.startIndex

        for ch in mask where index < cleaned.endIndex {
            if ch == "X" {
                result.append(cleaned[index])
                index = cleaned.index(after: index)
            } else {
                result.append(ch)
            }
        }

        return result
    }

    // MARK: - Send OTP

    func sendOTP() async {
        guard validatePhoneNumber(phoneNumber) else {
            errorMessage = "Please enter a valid 10-digit phone number"
            return
        }

        isLoading = true
        errorMessage = nil

        // TODO: Enable Firebase when configured
        // For now, simulate OTP sending for testing
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        verificationId = "mock_verification_id_123"
        isLoading = false
        print("✅ Mock OTP sent (Firebase disabled for testing)")

        /* Firebase code - Enable when Firebase is configured
        do {
            // Format phone number for Firebase (+91XXXXXXXXXX)
            let formattedPhone = "+91\(phoneNumber.replacingOccurrences(of: " ", with: ""))"

            // Send OTP via Firebase
            let verificationID = try await authService.sendOTP(to: formattedPhone)

            verificationId = verificationID
            isLoading = false

            print("✅ OTP sent to \(formattedPhone)")

        } catch {
            isLoading = false
            errorMessage = authService.getUserFriendlyError(error)
            print("❌ Error sending OTP: \(error)")
        }
        */
    }

    // MARK: - Verify OTP

    func verifyOTP() async -> Bool {
        guard let verificationId = verificationId else {
            errorMessage = "Verification session expired. Please try again."
            return false
        }

        guard otpCode.count == 6 else {
            errorMessage = "Please enter a valid 6-digit code"
            return false
        }

        isLoading = true
        errorMessage = nil

        // TODO: Enable Firebase when configured
        // For now, simulate OTP verification for testing
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        isLoading = false
        print("✅ Mock OTP verified (Firebase disabled for testing)")

        // Simulate new user for testing (returns true = needs profile setup)
        return true

        /* Firebase code - Enable when Firebase is configured
        do {
            // Verify OTP with Firebase
            let result = try await authService.verifyOTP(
                verificationID: verificationId,
                code: otpCode
            )

            let uid = result.user.uid

            // Check if user exists in Firestore
            let userExists = try await firestoreService.documentExists(
                collection: "users",
                id: uid
            )

            isLoading = false

            // Return true if new user (needs registration), false if existing user
            return !userExists

        } catch {
            isLoading = false
            errorMessage = authService.getUserFriendlyError(error)
            print("❌ Error verifying OTP: \(error)")
            return false
        }
        */
    }

    // MARK: - Complete Registration

    func completeRegistration() async -> Bool {
        guard !fullName.isEmpty else {
            errorMessage = "Please enter your full name"
            return false
        }

        guard !selectedCity.isEmpty else {
            errorMessage = "Please select your city"
            return false
        }

        // Validate email if provided
        if !email.isEmpty && !isValidEmail(email) {
            errorMessage = "Please enter a valid email address"
            return false
        }

        isLoading = true
        errorMessage = nil

        // TODO: Enable Firebase when configured
        // For now, create mock user for testing
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

        let user = User(
            id: "mock_user_\(UUID().uuidString.prefix(8))",
            fullName: fullName,
            email: email.isEmpty ? nil : email,
            phoneNumber: "+91\(phoneNumber)",
            photoURL: nil,
            userType: .customer,
            city: selectedCity,
            addresses: [],
            createdAt: Date(),
            updatedAt: Date()
        )

        currentUser = user
        isAuthenticated = true
        isLoading = false

        print("✅ Mock registration completed for: \(fullName) (Firebase disabled)")
        return true

        /* Firebase code - Enable when Firebase is configured
        guard let firebaseUser = authService.currentUser else {
            errorMessage = "Authentication session expired. Please try again."
            return false
        }

        do {
            // Create user in Firestore
            let user = User(
                id: firebaseUser.uid,
                fullName: fullName,
                email: email.isEmpty ? nil : email,
                phoneNumber: firebaseUser.phoneNumber ?? phoneNumber,
                photoURL: nil,
                userType: .customer,
                city: selectedCity,
                addresses: [],
                createdAt: Date(),
                updatedAt: Date()
            )

            // Save to Firestore
            try await firestoreService.saveUser(user)

            // Update Firebase profile
            try await authService.updateProfile(
                displayName: fullName,
                photoURL: nil
            )

            currentUser = user
            isAuthenticated = true
            isLoading = false

            print("✅ Registration completed for: \(fullName)")
            return true

        } catch {
            isLoading = false
            errorMessage = "Failed to complete registration. Please try again."
            print("❌ Error completing registration: \(error)")
            return false
        }
    }

    // MARK: - Login (Existing User)

    func login() async -> Bool {
        guard let firebaseUser = authService.currentUser else {
            errorMessage = "Authentication session expired. Please try again."
            return false
        }

        isLoading = true
        errorMessage = nil

        do {
            // Fetch user from Firestore
            let user = try await firestoreService.fetchUser(id: firebaseUser.uid)

            currentUser = user
            isAuthenticated = true
            isLoading = false

            print("✅ User logged in: \(user.fullName)")
            return true

        } catch {
            isLoading = false
            errorMessage = "Failed to login. Please try again."
            print("❌ Error logging in: \(error)")
            return false
        }
    }

    // MARK: - Sign Out

    func signOut() {
        do {
            try authService.signOut()
            currentUser = nil
            isAuthenticated = false
            resetForm()
            print("✅ User signed out successfully")
        } catch {
            errorMessage = "Failed to sign out. Please try again."
            print("❌ Error signing out: \(error)")
        }
    }

    // MARK: - Helper Methods

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func resetForm() {
        phoneNumber = ""
        verificationId = nil
        otpCode = ""
        fullName = ""
        email = ""
        selectedCity = ""
        errorMessage = nil
    }

    // MARK: - Resend OTP

    func resendOTP() async {
        await sendOTP()
    }
}
