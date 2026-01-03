//
//  FirebaseAuthService.swift
//  CityServe
//
//  Firebase Authentication Service
//  Handles phone authentication, user session management
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class FirebaseAuthService: ObservableObject {

    // MARK: - Singleton

    static let shared = FirebaseAuthService()

    // MARK: - Published Properties

    @Published var currentUser: FirebaseAuth.User?
    @Published var isAuthenticated = false

    // MARK: - Private Properties

    private var authStateHandle: AuthStateDidChangeListenerHandle?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    private init() {
        setupAuthStateListener()
    }

    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // MARK: - Auth State Listener

    private func setupAuthStateListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.currentUser = user
                self?.isAuthenticated = user != nil
                print("🔐 Auth state changed: \(user != nil ? "Authenticated" : "Not authenticated")")
            }
        }
    }

    // MARK: - Phone Authentication

    /// Send OTP to phone number
    /// - Parameter phoneNumber: Phone number in format: +91XXXXXXXXXX
    /// - Returns: Verification ID for OTP verification
    func sendOTP(to phoneNumber: String) async throws -> String {
        print("📱 Sending OTP to: \(phoneNumber)")

        return try await withCheckedThrowingContinuation { continuation in
            PhoneAuthProvider.provider().verifyPhoneNumber(
                phoneNumber,
                uiDelegate: nil
            ) { verificationID, error in
                if let error = error {
                    print("❌ OTP send failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }

                guard let verificationID = verificationID else {
                    let error = NSError(
                        domain: "FirebaseAuth",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "No verification ID received"]
                    )
                    continuation.resume(throwing: error)
                    return
                }

                print("✅ OTP sent successfully")
                continuation.resume(returning: verificationID)
            }
        }
    }

    /// Verify OTP code
    /// - Parameters:
    ///   - verificationID: Verification ID from sendOTP
    ///   - code: 6-digit OTP code
    /// - Returns: AuthDataResult with user information
    func verifyOTP(verificationID: String, code: String) async throws -> AuthDataResult {
        print("🔑 Verifying OTP code...")

        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: code
        )

        do {
            let result = try await Auth.auth().signIn(with: credential)
            print("✅ OTP verified successfully")
            print("👤 User ID: \(result.user.uid)")
            print("📱 Phone: \(result.user.phoneNumber ?? "N/A")")

            return result
        } catch {
            print("❌ OTP verification failed: \(error.localizedDescription)")
            throw error
        }
    }

    /// Sign in with credential (used for linking accounts)
    func signIn(with credential: AuthCredential) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(with: credential)
    }

    /// Sign out current user
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            print("👋 User signed out successfully")
        } catch {
            print("❌ Sign out failed: \(error.localizedDescription)")
            throw error
        }
    }

    /// Delete current user account
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(
                domain: "FirebaseAuth",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
            )
        }

        try await user.delete()
        print("🗑️ User account deleted")
    }

    /// Get current user's ID token for API authentication
    func getIDToken(forceRefresh: Bool = false) async throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw NSError(
                domain: "FirebaseAuth",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
            )
        }

        return try await user.getIDToken(forcingRefresh: forceRefresh)
    }

    // MARK: - Additional Auth Methods

    /// Link email/password to existing phone auth account
    func linkEmail(email: String, password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(
                domain: "FirebaseAuth",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
            )
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        _ = try await user.link(with: credential)
        print("✅ Email linked to account")
    }

    /// Update user profile
    func updateProfile(displayName: String?, photoURL: URL?) async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(
                domain: "FirebaseAuth",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
            )
        }

        let changeRequest = user.createProfileChangeRequest()
        if let displayName = displayName {
            changeRequest.displayName = displayName
        }
        if let photoURL = photoURL {
            changeRequest.photoURL = photoURL
        }

        try await changeRequest.commitChanges()
        print("✅ Profile updated")
    }

    /// Reload current user data
    func reloadUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(
                domain: "FirebaseAuth",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
            )
        }

        try await user.reload()
    }

    // MARK: - Helper Methods

    /// Check if user is authenticated
    var isUserAuthenticated: Bool {
        return Auth.auth().currentUser != nil
    }

    /// Get current user ID
    var currentUserID: String? {
        return Auth.auth().currentUser?.uid
    }

    /// Get current phone number
    var currentPhoneNumber: String? {
        return Auth.auth().currentUser?.phoneNumber
    }
}

// MARK: - Auth Error Extension

extension FirebaseAuthService {

    /// Convert Firebase Auth error to user-friendly message
    func getUserFriendlyError(_ error: Error) -> String {
        let nsError = error as NSError

        switch nsError.code {
        case AuthErrorCode.invalidPhoneNumber.rawValue:
            return "Invalid phone number format. Please check and try again."

        case AuthErrorCode.quotaExceeded.rawValue:
            return "SMS quota exceeded. Please try again later."

        case AuthErrorCode.invalidVerificationCode.rawValue:
            return "Invalid verification code. Please check and try again."

        case AuthErrorCode.sessionExpired.rawValue:
            return "Verification session expired. Please request a new code."

        case AuthErrorCode.tooManyRequests.rawValue:
            return "Too many attempts. Please try again later."

        case AuthErrorCode.networkError.rawValue:
            return "Network error. Please check your connection and try again."

        case AuthErrorCode.userDisabled.rawValue:
            return "This account has been disabled. Please contact support."

        default:
            return error.localizedDescription
        }
    }
}
