//
//  AppConfig.swift
//  CityServe
//
//  Created for environment-specific configuration
//  Provides compile-time environment detection and runtime configuration
//

import Foundation

/// Central configuration for the app based on build environment
/// Uses compiler flags set in xcconfig files to determine environment
struct AppConfig {

    // MARK: - Environment Detection

    /// Current build environment
    static var environment: Environment {
        #if DEV
        return .development
        #elseif STAGING
        return .staging
        #elseif PRODUCTION
        return .production
        #else
        return .development // Fallback to development
        #endif
    }

    /// Environment types
    enum Environment: String {
        case development = "Development"
        case staging = "Staging"
        case production = "Production"

        var displayName: String {
            rawValue
        }

        var isDevelopment: Bool {
            self == .development
        }

        var isProduction: Bool {
            self == .production
        }
    }

    // MARK: - API Configuration

    /// Base URL for backend API
    /// For local development, uses Firebase Emulator
    /// For production, uses deployed Cloud Functions
    static var apiBaseURL: String {
        #if DEV
        // Local Firebase Emulator
        return "http://127.0.0.1:5001/demo-no-project/asia-south1/api/api/v1"
        #elseif STAGING
        return "https://staging-api.urbanest.app"
        #elseif PRODUCTION
        return "https://api.urbanest.app"
        #else
        // Default to local emulator for development
        return "http://127.0.0.1:5001/demo-no-project/asia-south1/api/api/v1"
        #endif
    }

    /// Health check endpoint URL
    static var healthCheckURL: String {
        #if DEV
        return "http://127.0.0.1:5001/demo-no-project/asia-south1/api/health"
        #else
        return "\(apiBaseURL)/health"
        #endif
    }

    /// API timeout in seconds
    static var apiTimeout: TimeInterval {
        environment.isDevelopment ? 60 : 30
    }

    // MARK: - Feature Flags

    /// Whether to enable verbose logging
    static var isLoggingEnabled: Bool {
        #if DEV
        return true
        #elseif STAGING
        return true
        #elseif PRODUCTION
        return false
        #else
        return true
        #endif
    }

    /// Whether to enable analytics tracking
    static var isAnalyticsEnabled: Bool {
        #if DEV
        return false
        #elseif STAGING
        return true
        #elseif PRODUCTION
        return true
        #else
        return false
        #endif
    }

    /// Whether to show debug UI elements (like environment badge)
    static var showDebugUI: Bool {
        !environment.isProduction
    }

    /// Whether to enable Firebase Crashlytics
    static var isCrashlyticsEnabled: Bool {
        environment.isProduction
    }

    // MARK: - App Information

    /// App display name (set via xcconfig)
    static var appDisplayName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "UrbanNest"
    }

    /// App version
    static var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }

    /// Build number
    static var buildNumber: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
    }

    /// Full version string
    static var fullVersion: String {
        "\(appVersion) (\(buildNumber))"
    }

    /// Bundle identifier
    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "com.urbanest.app"
    }

    // MARK: - Firebase Configuration

    /// Firebase project ID (read from GoogleService-Info.plist)
    static var firebaseProjectID: String? {
        Bundle.main.object(forInfoDictionaryKey: "FIREBASE_PROJECT_ID") as? String
    }

    // MARK: - Debug Helpers

    /// Print current configuration to console
    static func printConfiguration() {
        guard isLoggingEnabled else { return }

        print("""

        ================================================
        🔧 App Configuration
        ================================================
        Environment:     \(environment.displayName)
        App Name:        \(appDisplayName)
        Version:         \(fullVersion)
        Bundle ID:       \(bundleIdentifier)
        ================================================
        API Base URL:    \(apiBaseURL)
        Logging:         \(isLoggingEnabled ? "✅" : "❌")
        Analytics:       \(isAnalyticsEnabled ? "✅" : "❌")
        Crashlytics:     \(isCrashlyticsEnabled ? "✅" : "❌")
        ================================================

        """)
    }
}

// MARK: - Usage Examples

/*

 // Check current environment
 if AppConfig.environment.isDevelopment {
     print("Running in development mode")
 }

 // Use environment-specific API URL
 let apiURL = URL(string: AppConfig.apiBaseURL)

 // Conditional logging
 if AppConfig.isLoggingEnabled {
     print("Debug: User logged in")
 }

 // Print configuration on app launch
 AppConfig.printConfiguration()

 // Show environment badge in UI (Dev/Staging only)
 if AppConfig.showDebugUI {
     Text(AppConfig.environment.displayName)
         .font(.caption)
         .padding(4)
         .background(Color.orange)
         .foregroundColor(.white)
         .cornerRadius(4)
 }

 */
