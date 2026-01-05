//
//  CustomNavigationLink.swift
//  CityServe
//
//  Custom Navigation Link with Animated Transitions
//

import SwiftUI

/// Custom navigation link with animated transitions
struct CustomNavigationLink<Label: View, Destination: View>: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    @State private var isPressed = false

    let destination: Destination
    let transition: NavigationTransition
    let label: Label

    init(
        transition: NavigationTransition = .slide,
        @ViewBuilder destination: () -> Destination,
        @ViewBuilder label: () -> Label
    ) {
        self.destination = destination()
        self.transition = transition
        self.label = label()
    }

    var body: some View {
        Button(action: {
            navigator.push(destination, transition: transition)
        }) {
            label
        }
        .buttonStyle(CustomNavigationLinkStyle())
    }
}

// MARK: - Custom Navigation Link Style

struct CustomNavigationLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Convenience Initializers

extension CustomNavigationLink where Label == Text {
    /// Convenience initializer with String label
    init(
        _ title: String,
        transition: NavigationTransition = .slide,
        @ViewBuilder destination: () -> Destination
    ) {
        self.destination = destination()
        self.transition = transition
        self.label = Text(title)
    }
}

extension CustomNavigationLink where Label == HStack<TupleView<(Image, Text)>> {
    /// Convenience initializer with icon and text
    init(
        icon: String,
        title: String,
        transition: NavigationTransition = .slide,
        @ViewBuilder destination: () -> Destination
    ) {
        self.destination = destination()
        self.transition = transition
        self.label = HStack {
            Image(systemName: icon)
            Text(title)
        }
    }
}

// MARK: - Card-style Navigation Link

/// Navigation link styled as a card (used for service cards, etc.)
struct CustomNavigationCard<Destination: View>: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    @State private var isPressed = false

    let destination: Destination
    let transition: NavigationTransition
    let imageName: String?
    let title: String
    let subtitle: String?
    let badge: String?

    init(
        imageName: String? = nil,
        title: String,
        subtitle: String? = nil,
        badge: String? = nil,
        transition: NavigationTransition = .slide,
        @ViewBuilder destination: () -> Destination
    ) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.transition = transition
        self.destination = destination()
    }

    var body: some View {
        Button(action: {
            navigator.push(destination, transition: transition)
        }) {
            HStack(spacing: Spacing.md) {
                // Leading Image
                if let imageName = imageName {
                    Image(systemName: imageName)
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                        .frame(width: 48, height: 48)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(12)
                }

                // Content
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .lineLimit(1)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                // Badge or Chevron
                if let badge = badge {
                    Text(badge)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, Spacing.xs)
                        .padding(.vertical, Spacing.xxs)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(8)
                }

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textTertiary)
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(CustomNavigationCardStyle(isPressed: $isPressed))
    }
}

// MARK: - Card Button Style

struct CustomNavigationCardStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                isPressed = newValue
                if newValue {
                    Haptics.light()
                }
            }
    }
}

// MARK: - Hero Navigation Link (for images/cards)

/// Navigation link with hero animation effect
struct HeroNavigationLink<Label: View, Destination: View>: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    @Namespace private var heroAnimation

    let destination: Destination
    let heroTag: String
    let label: Label

    init(
        heroTag: String,
        @ViewBuilder destination: () -> Destination,
        @ViewBuilder label: () -> Label
    ) {
        self.heroTag = heroTag
        self.destination = destination()
        self.label = label()
    }

    var body: some View {
        Button(action: {
            navigator.push(destination, transition: .hero)
        }) {
            label
                .matchedGeometryEffect(id: heroTag, in: heroAnimation)
        }
        .buttonStyle(CustomNavigationLinkStyle())
    }
}

// MARK: - Preview

#Preview("Navigation Links") {
    CustomNavigationStack {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                Text("Custom Navigation Links")
                    .font(.h2)
                    .padding(.top, Spacing.xl)

                // Simple text link
                CustomNavigationLink("Simple Text Link", transition: .slide) {
                    SampleDestinationView(title: "Slide Transition")
                }
                .padding(.horizontal, Spacing.screenPadding)

                // Card-style links
                CustomNavigationCard(
                    imageName: "house.fill",
                    title: "Home Services",
                    subtitle: "Cleaning, Repair, Maintenance",
                    badge: "20+ services",
                    transition: .slide
                ) {
                    SampleDestinationView(title: "Home Services")
                }
                .padding(.horizontal, Spacing.screenPadding)

                CustomNavigationCard(
                    imageName: "wrench.and.screwdriver.fill",
                    title: "AC Repair",
                    subtitle: "Professional AC repair service",
                    transition: .scale
                ) {
                    SampleDestinationView(title: "AC Repair")
                }
                .padding(.horizontal, Spacing.screenPadding)

                CustomNavigationCard(
                    imageName: "paintbrush.fill",
                    title: "Painting",
                    subtitle: "Interior & exterior painting",
                    badge: "Featured",
                    transition: .fade
                ) {
                    SampleDestinationView(title: "Painting")
                }
                .padding(.horizontal, Spacing.screenPadding)
            }
            .padding(.bottom, Spacing.xl)
        }
        .background(Color.background)
    }
}

// Sample Destination View for Preview
private struct SampleDestinationView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let title: String

    var body: some View {
        CustomNavigationContainer(
            title: title,
            showBackButton: true,
            backAction: { navigator.pop() },
            trailingActions: [
                NavigationAction(icon: "heart", action: {}),
                NavigationAction(icon: "square.and.arrow.up", action: {})
            ]
        ) {
            VStack(spacing: Spacing.lg) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.success)

                Text("You navigated to:")
                    .font(.body)
                    .foregroundColor(.textSecondary)

                Text(title)
                    .font(.h2)
                    .foregroundColor(.textPrimary)

                Button("Go Back") {
                    navigator.pop()
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}
