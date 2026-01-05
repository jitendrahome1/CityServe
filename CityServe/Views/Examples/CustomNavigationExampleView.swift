//
//  CustomNavigationExampleView.swift
//  CityServe
//
//  Example integration of Custom Navigation System
//  This demonstrates how to use the custom navigation in your app
//

import SwiftUI

/// Example view showing custom navigation integration
/// Usage: Replace NavigationStack with CustomNavigationStack in your root view
struct CustomNavigationExampleView: View {
    var body: some View {
        CustomNavigationStack {
            ExampleHomeView()
        }
    }
}

// MARK: - Example Home View

struct ExampleHomeView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    @State private var showSearch = false

    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar
            CustomNavigationBar(
                title: "UrbanNest",
                showBackButton: false,
                trailingActions: [
                    NavigationAction(icon: "magnifyingglass", action: {
                        navigator.push(ExampleSearchView(), transition: .fade)
                    }),
                    NavigationAction(icon: "bell", action: {
                        navigator.push(ExampleNotificationsView(), transition: .slideUp)
                    })
                ],
                style: .gradient
            )

            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Header
                    headerSection

                    // Service Categories
                    categoriesSection

                    // Popular Services
                    popularServicesSection

                    // Featured Providers
                    featuredProvidersSection
                }
                .padding(.bottom, Spacing.xxl)
            }
        }
        .background(Color.background.ignoresSafeArea())
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Welcome back!")
                .font(.bodyLarge)
                .foregroundColor(.textSecondary)

            Text("What service do you need?")
                .font(.h2)
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
        .padding(.top, Spacing.lg)
    }

    // MARK: - Categories Section

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text("Categories")
                    .font(.h4)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()

                CustomNavigationLink("See All", transition: .slide) {
                    ExampleCategoriesListView()
                }
                .font(.bodySmall)
                .foregroundColor(.primary)
            }
            .padding(.horizontal, Spacing.screenPadding)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    CategoryCardButton(
                        icon: "house.fill",
                        title: "Home",
                        color: .blue,
                        destination: ExampleCategoryDetailView(category: "Home Services")
                    )

                    CategoryCardButton(
                        icon: "wrench.and.screwdriver.fill",
                        title: "Repair",
                        color: .orange,
                        destination: ExampleCategoryDetailView(category: "Repair Services")
                    )

                    CategoryCardButton(
                        icon: "paintbrush.fill",
                        title: "Painting",
                        color: .purple,
                        destination: ExampleCategoryDetailView(category: "Painting")
                    )

                    CategoryCardButton(
                        icon: "sparkles",
                        title: "Cleaning",
                        color: .green,
                        destination: ExampleCategoryDetailView(category: "Cleaning")
                    )
                }
                .padding(.horizontal, Spacing.screenPadding)
            }
        }
    }

    // MARK: - Popular Services Section

    private var popularServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Popular Services")
                .font(.h4)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            VStack(spacing: Spacing.md) {
                CustomNavigationCard(
                    imageName: "wind",
                    title: "AC Repair & Service",
                    subtitle: "Starting at ₹299",
                    badge: "Popular",
                    transition: .slide
                ) {
                    ExampleServiceDetailView(serviceName: "AC Repair")
                }

                CustomNavigationCard(
                    imageName: "drop.fill",
                    title: "Plumbing Services",
                    subtitle: "Starting at ₹199",
                    transition: .scale
                ) {
                    ExampleServiceDetailView(serviceName: "Plumbing")
                }

                CustomNavigationCard(
                    imageName: "bolt.fill",
                    title: "Electrician",
                    subtitle: "Starting at ₹149",
                    badge: "24/7",
                    transition: .fade
                ) {
                    ExampleServiceDetailView(serviceName: "Electrician")
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    // MARK: - Featured Providers Section

    private var featuredProvidersSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Top Rated Providers")
                .font(.h4)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    ForEach(0..<5, id: \.self) { index in
                        ProviderCard(
                            name: "Provider \(index + 1)",
                            rating: 4.5 + Double(index) * 0.1,
                            services: 120 + index * 10
                        )
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
            }
        }
    }
}

// MARK: - Category Card Button

struct CategoryCardButton<Destination: View>: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let icon: String
    let title: String
    let color: Color
    let destination: Destination

    var body: some View {
        Button(action: {
            navigator.push(destination, transition: .scale)
        }) {
            VStack(spacing: Spacing.sm) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.15))
                        .frame(width: 64, height: 64)

                    Image(systemName: icon)
                        .font(.system(size: 28))
                        .foregroundColor(color)
                }

                Text(title)
                    .font(.bodySmall)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimary)
            }
            .frame(width: 90)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Provider Card

struct ProviderCard: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let name: String
    let rating: Double
    let services: Int

    var body: some View {
        Button(action: {
            navigator.push(
                ExampleProviderDetailView(providerName: name),
                transition: .hero
            )
        }) {
            VStack(spacing: Spacing.sm) {
                // Provider Image
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.primary, .secondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    )

                // Provider Info
                VStack(spacing: Spacing.xxs) {
                    Text(name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)

                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }

                    Text("\(services) services")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
            }
            .frame(width: 120)
            .padding(.vertical, Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Example Detail Views

struct ExampleSearchView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator

    var body: some View {
        CustomNavigationContainer(
            title: "Search",
            backAction: { navigator.pop() }
        ) {
            VStack {
                Text("Search View")
                    .font(.h2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}

struct ExampleNotificationsView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator

    var body: some View {
        CustomNavigationContainer(
            title: "Notifications",
            backAction: { navigator.pop() }
        ) {
            VStack {
                Text("Notifications View")
                    .font(.h2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}

struct ExampleCategoriesListView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator

    var body: some View {
        CustomNavigationContainer(
            title: "All Categories",
            backAction: { navigator.pop() }
        ) {
            ScrollView {
                VStack(spacing: Spacing.md) {
                    ForEach(["Home", "Repair", "Painting", "Cleaning", "Plumbing", "Electrical"], id: \.self) { category in
                        CustomNavigationCard(
                            imageName: "folder.fill",
                            title: category,
                            subtitle: "20+ services available"
                        ) {
                            ExampleCategoryDetailView(category: category)
                        }
                    }
                }
                .padding(Spacing.screenPadding)
            }
            .background(Color.background)
        }
    }
}

struct ExampleCategoryDetailView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let category: String

    var body: some View {
        CustomNavigationContainer(
            title: category,
            backAction: { navigator.pop() },
            trailingActions: [
                NavigationAction(icon: "heart", action: {}),
                NavigationAction(icon: "square.and.arrow.up", action: {})
            ]
        ) {
            VStack {
                Text("Category: \(category)")
                    .font(.h2)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}

struct ExampleServiceDetailView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let serviceName: String

    var body: some View {
        CustomNavigationContainer(
            title: serviceName,
            backAction: { navigator.pop() },
            trailingActions: [
                NavigationAction(icon: "heart", action: {}),
                NavigationAction(icon: "square.and.arrow.up", action: {})
            ],
            barStyle: .gradient
        ) {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Service Image
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.primary, .secondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 200)
                        .cornerRadius(Spacing.radiusMd)

                    // Service Info
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text(serviceName)
                            .font(.h2)
                            .foregroundColor(.textPrimary)

                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.secondary)
                            Text("4.8 (256 reviews)")
                                .font(.body)
                                .foregroundColor(.textSecondary)
                        }

                        Text("Professional \(serviceName.lowercased()) service at your doorstep.")
                            .font(.body)
                            .foregroundColor(.textSecondary)
                            .padding(.top, Spacing.sm)
                    }

                    // Book Button
                    PrimaryButton("Book Now", size: .large) {
                        navigator.push(
                            ExampleBookingView(serviceName: serviceName),
                            transition: .slideUp
                        )
                    }
                }
                .padding(Spacing.screenPadding)
            }
            .background(Color.background)
        }
    }
}

struct ExampleProviderDetailView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let providerName: String

    var body: some View {
        CustomNavigationContainer(
            title: providerName,
            backAction: { navigator.pop() }
        ) {
            VStack {
                Text("Provider: \(providerName)")
                    .font(.h2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}

struct ExampleBookingView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let serviceName: String

    var body: some View {
        CustomNavigationContainer(
            title: "Book \(serviceName)",
            backAction: { navigator.pop() },
            barStyle: .blur
        ) {
            VStack(spacing: Spacing.xl) {
                Image(systemName: "calendar")
                    .font(.system(size: 60))
                    .foregroundColor(.primary)

                Text("Booking Flow")
                    .font(.h2)

                Text("Select date and time for \(serviceName)")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)

                Spacer()

                PrimaryButton("Confirm Booking", size: .large) {
                    navigator.popToRoot()
                }
                .padding(.horizontal, Spacing.screenPadding)
            }
            .padding(Spacing.xl)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}

// MARK: - Preview

#Preview {
    CustomNavigationExampleView()
}
