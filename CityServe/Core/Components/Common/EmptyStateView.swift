//
//  EmptyStateView.swift
//  CityServe
//
//  Empty State Component
//  Design System Component
//

import SwiftUI

/// Empty state view with icon, title, description, and optional action
/// Usage: Empty lists, no search results, no data states
struct EmptyStateView: View {

    // MARK: - Properties

    let icon: String
    let title: String
    let description: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    // MARK: - Body

    @State private var isVisible = false

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            // Icon
            Image(systemName: icon)
                .font(.system(size: 64, weight: .light))
                .foregroundColor(.textTertiary)
                .padding(.bottom, Spacing.sm)

            // Title
            Text(title)
                .font(.h3)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)

            // Description
            Text(description)
                .font(.body)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xl)

            // Optional Action Button
            if let actionTitle = actionTitle, let action = action {
                PrimaryButton(
                    actionTitle,
                    fullWidth: false,
                    size: .medium,
                    action: action
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

// MARK: - Common Empty States

extension EmptyStateView {

    /// No bookings empty state
    static func noBookings(action: @escaping () -> Void) -> EmptyStateView {
        EmptyStateView(
            icon: "calendar.badge.exclamationmark",
            title: "No Bookings Yet",
            description: "You haven't made any bookings. Explore services and book your first service!",
            actionTitle: "Explore Services",
            action: action
        )
    }

    /// No search results
    static func noSearchResults(searchQuery: String) -> EmptyStateView {
        EmptyStateView(
            icon: "magnifyingglass",
            title: "No Results Found",
            description: "We couldn't find any services matching '\(searchQuery)'. Try a different search term."
        )
    }

    /// No services available
    static func noServices(action: @escaping () -> Void) -> EmptyStateView {
        EmptyStateView(
            icon: "wrench.and.screwdriver",
            title: "No Services Available",
            description: "Services are not yet available in your area. We'll notify you when they arrive.",
            actionTitle: "Change City",
            action: action
        )
    }

    /// No notifications
    static var noNotifications: EmptyStateView {
        EmptyStateView(
            icon: "bell.slash",
            title: "No Notifications",
            description: "You're all caught up! We'll notify you when something important happens."
        )
    }

    /// No favorites
    static func noFavorites(action: @escaping () -> Void) -> EmptyStateView {
        EmptyStateView(
            icon: "heart.slash",
            title: "No Favorites Yet",
            description: "Save your favorite services for quick access later.",
            actionTitle: "Browse Services",
            action: action
        )
    }

    /// Connection error
    static func connectionError(retry: @escaping () -> Void) -> EmptyStateView {
        EmptyStateView(
            icon: "wifi.slash",
            title: "No Internet Connection",
            description: "Please check your connection and try again.",
            actionTitle: "Retry",
            action: retry
        )
    }
}

// MARK: - Preview

#Preview("Empty State Examples") {
    ScrollView {
        VStack(spacing: Spacing.xxl) {
            EmptyStateView.noBookings {
                print("Explore tapped")
            }
            .frame(height: 400)

            Divider()

            EmptyStateView.noSearchResults(searchQuery: "plumbing")
                .frame(height: 400)

            Divider()

            EmptyStateView.noNotifications
                .frame(height: 400)

            Divider()

            EmptyStateView(
                icon: "star.slash",
                title: "No Ratings Yet",
                description: "Complete a service to leave your first rating.",
                actionTitle: "View Bookings",
                action: { print("Action") }
            )
            .frame(height: 400)
        }
    }
}

#Preview("Empty State Dark Mode") {
    EmptyStateView.noBookings {
        print("Explore tapped")
    }
    .preferredColorScheme(.dark)
}
