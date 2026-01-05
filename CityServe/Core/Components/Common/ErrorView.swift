//
//  ErrorView.swift
//  CityServe
//
//  Error State Component
//  Design System Component
//

import SwiftUI

/// Error state view with icon, message, and retry action
/// Usage: API errors, failed requests, error states
struct ErrorView: View {

    // MARK: - Properties

    let error: ErrorType
    let retryAction: (() -> Void)?

    enum ErrorType {
        case network
        case server
        case notFound
        case unauthorized
        case custom(title: String, message: String, icon: String)

        var icon: String {
            switch self {
            case .network: return "wifi.exclamationmark"
            case .server: return "exclamationmark.triangle"
            case .notFound: return "questionmark.circle"
            case .unauthorized: return "lock.shield"
            case .custom(_, _, let icon): return icon
            }
        }

        var title: String {
            switch self {
            case .network: return "Connection Error"
            case .server: return "Server Error"
            case .notFound: return "Not Found"
            case .unauthorized: return "Unauthorized"
            case .custom(let title, _, _): return title
            }
        }

        var message: String {
            switch self {
            case .network:
                return "Unable to connect to the server. Please check your internet connection and try again."
            case .server:
                return "Something went wrong on our end. We're working to fix it. Please try again later."
            case .notFound:
                return "The requested resource could not be found. It may have been moved or deleted."
            case .unauthorized:
                return "You don't have permission to access this resource. Please sign in and try again."
            case .custom(_, let message, _):
                return message
            }
        }
    }

    // MARK: - Body

    @State private var isVisible = false

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            // Error Icon
            ZStack {
                Circle()
                    .fill(Color.error.opacity(0.1))
                    .frame(width: 80, height: 80)

                Image(systemName: error.icon)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(.error)
            }
            .padding(.bottom, Spacing.sm)

            // Error Title
            Text(error.title)
                .font(.h3)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)

            // Error Message
            Text(error.message)
                .font(.body)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xl)

            // Retry Button
            if let retryAction = retryAction {
                SecondaryButton(
                    "Try Again",
                    icon: "arrow.clockwise",
                    fullWidth: false,
                    size: .medium,
                    action: retryAction
                )
                .padding(.top, Spacing.md)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .opacity(isVisible ? 1.0 : 0)
        .offset(y: isVisible ? 0 : 20)
        .onAppear {
            withAnimation(Animations.floatingCardAppear) {
                isVisible = true
            }
        }
    }
}

// MARK: - Common Error Views

extension ErrorView {

    /// Network error with retry
    static func networkError(retry: @escaping () -> Void) -> ErrorView {
        ErrorView(error: .network, retryAction: retry)
    }

    /// Server error with retry
    static func serverError(retry: @escaping () -> Void) -> ErrorView {
        ErrorView(error: .server, retryAction: retry)
    }

    /// Not found error (no retry)
    static var notFound: ErrorView {
        ErrorView(error: .notFound, retryAction: nil)
    }

    /// Unauthorized error
    static var unauthorized: ErrorView {
        ErrorView(error: .unauthorized, retryAction: nil)
    }

    /// Custom error
    static func custom(
        title: String,
        message: String,
        icon: String = "exclamationmark.triangle",
        retry: (() -> Void)? = nil
    ) -> ErrorView {
        ErrorView(
            error: .custom(title: title, message: message, icon: icon),
            retryAction: retry
        )
    }
}

// MARK: - Inline Error Banner

/// Small inline error banner for form errors or minor issues
struct ErrorBanner: View {
    let message: String
    var dismissAction: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: Spacing.iconMD))
                .foregroundColor(.error)

            Text(message)
                .font(.bodySmall)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.leading)

            Spacer()

            if let dismissAction = dismissAction {
                Button(action: dismissAction) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.textSecondary)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.error.opacity(0.1))
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(Color.error.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Preview

#Preview("Error View Types") {
    ScrollView {
        VStack(spacing: Spacing.xxl) {
            ErrorView.networkError {
                print("Retry network")
            }
            .frame(height: 400)

            Divider()

            ErrorView.serverError {
                print("Retry server")
            }
            .frame(height: 400)

            Divider()

            ErrorView.notFound
                .frame(height: 400)

            Divider()

            ErrorView.unauthorized
                .frame(height: 400)

            Divider()

            ErrorView.custom(
                title: "Payment Failed",
                message: "Your payment could not be processed. Please check your payment details and try again.",
                icon: "creditcard.trianglebadge.exclamationmark",
                retry: { print("Retry payment") }
            )
            .frame(height: 400)
        }
    }
}

#Preview("Error Banner") {
    VStack(spacing: Spacing.md) {
        ErrorBanner(
            message: "Invalid email format. Please check and try again."
        )

        ErrorBanner(
            message: "Session expired. Please sign in again.",
            dismissAction: {
                print("Dismissed")
            }
        )

        ErrorBanner(
            message: "This is a longer error message that will wrap to multiple lines to show how the banner handles longer text content."
        )
    }
    .padding(Spacing.screenPadding)
}

#Preview("Error View Dark Mode") {
    ErrorView.networkError {
        print("Retry")
    }
    .preferredColorScheme(.dark)
}
