//
//  FirebaseAuthService.swift
//  CityServe
//
//  Firebase Authentication Service
//  Handles phone authentication, user session management
//

import Foundation
// import FirebaseAuth // TODO: Enable when Firebase is configured
import Combine

// MARK: - Mock Types (TODO: Remove when Firebase is enabled)

/// Mock user for Firebase Auth when not configured
struct MockFirebaseUser {
    let uid: String
    let phoneNumber: String?
}

/// Mock auth result when Firebase is not configured
struct MockAuthDataResult {
    let user: MockFirebaseUser
}

@MainActor
class FirebaseAuthService: ObservableObject {

    // MARK: - Singleton

    static let shared = FirebaseAuthService()

    // MARK: - Published Properties

    @Published var currentUser: MockFirebaseUser? // FirebaseAuth.User? // TODO: Enable when Firebase is configured
    @Published var isAuthenticated = false

    // MARK: - Private Properties

    // private var authStateHandle: AuthStateDidChangeListenerHandle? // TODO: Enable when Firebase is configured
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    private init() {
        setupAuthStateListener()
    }

    deinit {
        // TODO: Enable when Firebase is configured
        // if let handle = authStateHandle {
        //     Auth.auth().removeStateDidChangeListener(handle)
        // }
    }

    // MARK: - Auth State Listener

    private func setupAuthStateListener() {
        // TODO: Enable when Firebase is configured
        // authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
        //     Task { @MainActor in
        //         self?.currentUser = user
        //         self?.isAuthenticated = user != nil
        //         print("🔐 Auth state changed: \(user != nil ? "Authenticated" : "Not authenticated")")
        //     }
        // }
    }

    // MARK: - Phone Authentication

    /// Send OTP to phone number
    /// - Parameter phoneNumber: Phone number in format: +91XXXXXXXXXX
    /// - Returns: Verification ID for OTP verification
    func sendOTP(to phoneNumber: String) async throws -> String {
        print("📱 Sending OTP to: \(phoneNumber)")

        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )

        // return try await withCheckedThrowingContinuation { continuation in
        //     PhoneAuthProvider.provider().verifyPhoneNumber(
        //         phoneNumber,
        //         uiDelegate: nil
        //     ) { verificationID, error in
        //         if let error = error {
        //             print("❌ OTP send failed: \(error.localizedDescription)")
        //             continuation.resume(throwing: error)
        //             return
        //         }
        //
        //         guard let verificationID = verificationID else {
        //             let error = NSError(
        //                 domain: "FirebaseAuth",
        //                 code: -1,
        //                 userInfo: [NSLocalizedDescriptionKey: "No verification ID received"]
        //             )
        //             continuation.resume(throwing: error)
        //             return
        //         }
        //
        //         print("✅ OTP sent successfully")
        //         continuation.resume(returning: verificationID)
        //     }
        // }
    }

    /// Verify OTP code
    /// - Parameters:
    ///   - verificationID: Verification ID from sendOTP
    ///   - code: 6-digit OTP code
    /// - Returns: AuthDataResult with user information
    func verifyOTP(verificationID: String, code: String) async throws -> MockAuthDataResult { // AuthDataResult
        print("🔑 Verifying OTP code...")

        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )

        // let credential = PhoneAuthProvider.provider().credential(
        //     withVerificationID: verificationID,
        //     verificationCode: code
        // )
        //
        // do {
        //     let result = try await Auth.auth().signIn(with: credential)
        //     print("✅ OTP verified successfully")
        //     print("👤 User ID: \(result.user.uid)")
        //     print("📱 Phone: \(result.user.phoneNumber ?? "N/A")")
        //
        //     return result
        // } catch {
        //     print("❌ OTP verification failed: \(error.localizedDescription)")
        //     throw error
        // }
    }

    /// Sign in with credential (used for linking accounts)
    func signIn(with credential: Any) async throws -> Any { // AuthCredential, AuthDataResult
        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )
        // return try await Auth.auth().signIn(with: credential)
    }

    /// Sign out current user
    func signOut() throws {
        // TODO: Enable when Firebase is configured
        // do {
        //     try Auth.auth().signOut()
        //     print("👋 User signed out successfully")
        // } catch {
        //     print("❌ Sign out failed: \(error.localizedDescription)")
        //     throw error
        // }
    }

    /// Delete current user account
    func deleteAccount() async throws {
        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )
        // guard let user = Auth.auth().currentUser else {
        //     throw NSError(
        //         domain: "FirebaseAuth",
        //         code: -1,
        //         userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
        //     )
        // }
        //
        // try await user.delete()
        // print("🗑️ User account deleted")
    }

    /// Get current user's ID token for API authentication
    func getIDToken(forceRefresh: Bool = false) async throws -> String {
        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )
        // guard let user = Auth.auth().currentUser else {
        //     throw NSError(
        //         domain: "FirebaseAuth",
        //         code: -1,
        //         userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
        //     )
        // }
        //
        // return try await user.getIDToken(forcingRefresh: forceRefresh)
    }

    // MARK: - Additional Auth Methods

    /// Link email/password to existing phone auth account
    func linkEmail(email: String, password: String) async throws {
        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )
        // guard let user = Auth.auth().currentUser else {
        //     throw NSError(
        //         domain: "FirebaseAuth",
        //         code: -1,
        //         userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
        //     )
        // }
        //
        // let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        // _ = try await user.link(with: credential)
        // print("✅ Email linked to account")
    }

    /// Update user profile
    func updateProfile(displayName: String?, photoURL: URL?) async throws {
        // TODO: Enable when Firebase is configured
        // guard let user = Auth.auth().currentUser else {
        //     throw NSError(
        //         domain: "FirebaseAuth",
        //         code: -1,
        //         userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
        //     )
        // }
        //
        // let changeRequest = user.createProfileChangeRequest()
        // if let displayName = displayName {
        //     changeRequest.displayName = displayName
        // }
        // if let photoURL = photoURL {
        //     changeRequest.photoURL = photoURL
        // }
        //
        // try await changeRequest.commitChanges()
        // print("✅ Profile updated")
    }

    /// Reload current user data
    func reloadUser() async throws {
        // TODO: Enable when Firebase is configured
        throw NSError(
            domain: "FirebaseAuth",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "Firebase not configured"]
        )
        // guard let user = Auth.auth().currentUser else {
        //     throw NSError(
        //         domain: "FirebaseAuth",
        //         code: -1,
        //         userInfo: [NSLocalizedDescriptionKey: "No user signed in"]
        //     )
        // }
        //
        // try await user.reload()
    }

    // MARK: - Helper Methods

    /// Check if user is authenticated
    var isUserAuthenticated: Bool {
        // TODO: Enable when Firebase is configured
        return false
        // return Auth.auth().currentUser != nil
    }

    /// Get current user ID
    var currentUserID: String? {
        // TODO: Enable when Firebase is configured
        return nil
        // return Auth.auth().currentUser?.uid
    }

    /// Get current phone number
    var currentPhoneNumber: String? {
        // TODO: Enable when Firebase is configured
        return nil
        // return Auth.auth().currentUser?.phoneNumber
    }
}

// MARK: - Auth Error Extension

extension FirebaseAuthService {

    /// Convert Firebase Auth error to user-friendly message
    func getUserFriendlyError(_ error: Error) -> String {
        // TODO: Enable when Firebase is configured
        return error.localizedDescription

        // let nsError = error as NSError
        //
        // switch nsError.code {
        // case AuthErrorCode.invalidPhoneNumber.rawValue:
        //     return "Invalid phone number format. Please check and try again."
        //
        // case AuthErrorCode.quotaExceeded.rawValue:
        //     return "SMS quota exceeded. Please try again later."
        //
        // case AuthErrorCode.invalidVerificationCode.rawValue:
        //     return "Invalid verification code. Please check and try again."
        //
        // case AuthErrorCode.sessionExpired.rawValue:
        //     return "Verification session expired. Please request a new code."
        //
        // case AuthErrorCode.tooManyRequests.rawValue:
        //     return "Too many attempts. Please try again later."
        //
        // case AuthErrorCode.networkError.rawValue:
        //     return "Network error. Please check your connection and try again."
        //
        // case AuthErrorCode.userDisabled.rawValue:
        //     return "This account has been disabled. Please contact support."
        //
        // default:
        //     return error.localizedDescription
        // }
    }
}
