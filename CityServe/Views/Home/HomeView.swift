//
//  HomeView.swift
//  CityServe
//
//  Main Home Screen - Urban Company Design Pattern
//  Redesigned to match UC's layout and visual hierarchy
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showCitySelector = false
    @State private var showNotifications = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: Spacing.md) {
                        // 1. Location + Search Bar (inline at top)
                        locationAndSearchSection

                        // 2. Plus Membership Banner
                        plusMembershipBanner

                        // 3. Custom Package Banner
                        customPackageBanner

                        // 4. Personal Services Section
                        personalServicesSection

                        // 5. Home Services Section
                        homeServicesSection

                        // 6. Trending Services Section
                        trendingServicesSection

                        // 7. Sponsored Ad Section (optional)
                        if viewModel.sponsoredAd != nil {
                            sponsoredAdSection
                        }

                        // 8. Quick Access Buttons
                        quickAccessButtons

                        Spacer(minLength: Spacing.xxl)
                    }
                }
                .refreshable {
                    await viewModel.refreshData()
                }

                // Loading overlay
                if viewModel.isLoading && viewModel.categories.isEmpty {
                    LoadingView(
                        message: "Loading services...",
                        style: .spinner
                    )
                }
            }
            .navigationBarHidden(true) // Custom header, no navigation bar
            .onAppear {
                if viewModel.categories.isEmpty {
                    viewModel.loadInitialData()
                }
            }
            .sheet(isPresented: $showCitySelector) {
                CitySelectorSheet(
                    selectedCity: $viewModel.selectedCity,
                    cities: viewModel.availableCities,
                    onSelect: { city in
                        viewModel.changeCity(city)
                        showCitySelector = false
                    }
                )
            }
        }
    }

    // MARK: - 1. Location & Search Section

    private var locationAndSearchSection: some View {
        VStack(spacing: Spacing.sm) {
            // Location row
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .font(.title3)
                    .foregroundColor(.primary)

                Button(action: { showCitySelector = true }) {
                    HStack(spacing: Spacing.xxs) {
                        Text(truncatedAddress)
                            .font(.body)
                            .foregroundColor(.textPrimary)
                            .fontWeight(.medium)
                            .lineLimit(1)

                        Image(systemName: "chevron.down")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()

                // Notification bell
                Button(action: { showNotifications = true }) {
                    Image(systemName: "bell")
                        .font(.title3)
                        .foregroundColor(.textPrimary)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.top, Spacing.md)

            // Search bar
            NavigationLink(destination: SearchView()) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.textSecondary)

                    Text("Search for services and packages")
                        .font(.body)
                        .foregroundColor(.textTertiary)

                    Spacer()
                }
                .padding(Spacing.md)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusLg)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .stroke(Color.divider, lineWidth: 1)
                )
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    // MARK: - 2. Plus Membership Banner

    private var plusMembershipBanner: some View {
        NavigationLink(destination: PlusMembershipView()) {
            HStack(spacing: Spacing.md) {
                // Plus icon with gradient background
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.secondary, Color.warning],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 40, height: 40)

                    Image(systemName: "star.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                }

                // Text content
                Text("plus")
                    .font(.h4)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("Save 15% on every service")
                    .font(.body)
                    .foregroundColor(.textSecondary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.textTertiary)
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(Color.divider, lineWidth: 1)
            )
        }
        .padding(.horizontal, Spacing.screenPadding)
    }

    // MARK: - 3. Custom Package Banner

    private var customPackageBanner: some View {
        NavigationLink(destination: Text("Custom Package Builder")) {
            ZStack(alignment: .leading) {
                // Purple gradient background
                LinearGradient(
                    colors: [Color.primary, Color.primaryDark],
                    startPoint: .leading,
                    endPoint: .trailing
                )

                HStack {
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Let's make a package just")
                            .font(.h4)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("for you, \(userName)!")
                            .font(.h4)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        HStack(spacing: Spacing.xxs) {
                            Text("Salon for women")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.9))

                            Image(systemName: "arrow.right")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding(.top, Spacing.xs)
                    }

                    Spacer()

                    // Placeholder for person image
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.3))
                }
                .padding(Spacing.md)
            }
            .frame(height: 120)
            .cornerRadius(Spacing.radiusLg)
        }
        .padding(.horizontal, Spacing.screenPadding)
    }

    // MARK: - 4. Personal Services Section

    private var personalServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Personal Services")
                .font(.h3)
                .fontWeight(.bold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            LazyVGrid(columns: gridColumns, spacing: Spacing.md) {
                ForEach(viewModel.personalServiceCategories.prefix(5)) { category in
                    NavigationLink(destination: CategoryDetailView(category: category)) {
                        CategoryGridCard(
                            category: CategoryCardModel(from: category),
                            action: nil
                        )
                    }
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    // MARK: - 5. Home Services Section

    private var homeServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Home Services")
                .font(.h3)
                .fontWeight(.bold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            LazyVGrid(columns: gridColumns, spacing: Spacing.md) {
                ForEach(viewModel.homeServiceCategories.prefix(5)) { category in
                    NavigationLink(destination: CategoryDetailView(category: category)) {
                        CategoryGridCard(
                            category: CategoryCardModel(from: category),
                            action: nil
                        )
                    }
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    // MARK: - 6. Trending Services Section

    private var trendingServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text("Trending Services")
                    .font(.h3)
                    .fontWeight(.bold)
                    .foregroundColor(.textPrimary)

                Spacer()

                NavigationLink(destination: Text("All Trending Services")) {
                    Text("Explore All Trending Services")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: Spacing.md) {
                    ForEach(viewModel.trendingServices.prefix(6)) { service in
                        NavigationLink(destination: ServiceDetailView(service: service)) {
                            TrendingServiceCard(service: service)
                        }
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
            }
        }
    }

    // MARK: - 7. Sponsored Ad Section

    private var sponsoredAdSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("SPONSORED")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.textTertiary)
                .padding(.horizontal, Spacing.screenPadding)

            ZStack(alignment: .bottomLeading) {
                // Ad background with gradient
                LinearGradient(
                    colors: [Color.secondary.opacity(0.3), Color.secondary],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Content overlay
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Two's better")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("than one.")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Buy one Flatbread Pizza, get another for ₹99")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))

                    PrimaryButton("Order Now", size: .medium) {
                        // Handle ad tap
                    }
                    .frame(width: 120)
                }
                .padding(Spacing.md)
            }
            .frame(height: 180)
            .cornerRadius(Spacing.radiusLg)
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    // MARK: - 8. Quick Access Buttons

    private var quickAccessButtons: some View {
        VStack(spacing: Spacing.xs) {
            Divider()
                .padding(.horizontal, Spacing.screenPadding)

            // First row
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: Spacing.md) {
                QuickAccessButton(icon: "building.2", title: "Shake Shack", action: {})
                QuickAccessButton(icon: "cart", title: "Rapid Grocery", action: {})
                QuickAccessButton(icon: "tag", title: "Offers", action: {})
                QuickAccessButton(icon: "sparkle", title: "New", action: {})
            }
            .padding(.horizontal, Spacing.screenPadding)

            // Second row
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: Spacing.md) {
                QuickAccessButton(icon: "ticket", title: "Only on Skip", action: {})
                QuickAccessButton(icon: "fork.knife", title: "Fast Food", action: {})
                QuickAccessButton(icon: "questionmark.circle", title: "Help", action: {})
                QuickAccessButton(icon: "creditcard", title: "Wallet", action: {})
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.bottom, Spacing.md)
        }
    }

    // MARK: - Helper Properties

    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: Spacing.md), count: 5)
    }

    private var userName: String {
        authViewModel.currentUser?.fullName.components(separatedBy: " ").first ?? "User"
    }

    private var truncatedAddress: String {
        guard let address = authViewModel.currentUser?.addresses.first(where: { $0.isDefault }) else {
            return viewModel.selectedCity
        }
        return address.fullAddress.components(separatedBy: ",").prefix(2).joined(separator: ", ")
    }
}

// MARK: - Trending Service Card

struct TrendingServiceCard: View {
    let service: Service

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            // Service image placeholder
            ZStack {
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .fill(
                        LinearGradient(
                            colors: [Color.primary.opacity(0.3), Color.secondary.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: service.categoryId == "1" ? "air.conditioner.horizontal" :
                      service.categoryId == "2" ? "drop.fill" :
                      service.categoryId == "3" ? "bolt.fill" : "wrench.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .frame(width: 120, height: 90)

            // Service name
            Text(service.name)
                .font(.bodySmall)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .lineLimit(2)
                .frame(width: 120, alignment: .leading)
        }
    }
}

// MARK: - Quick Access Button

struct QuickAccessButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: Spacing.xs) {
                ZStack {
                    Circle()
                        .fill(Color.surface)
                        .frame(width: 56, height: 56)
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.textPrimary)
                }

                Text(title)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
    }
}

// MARK: - City Selector Sheet

struct CitySelectorSheet: View {
    @Binding var selectedCity: String
    let cities: [String]
    let onSelect: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(cities, id: \.self) { city in
                Button(action: {
                    onSelect(city)
                }) {
                    HStack {
                        Text(city)
                            .font(.body)
                            .foregroundColor(.textPrimary)

                        Spacer()

                        if city == selectedCity {
                            Image(systemName: "checkmark")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .navigationTitle("Select City")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Manvi Sharma",
        email: "manvi@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Pune",
        addresses: [
            Address(
                id: "1",
                label: "Home",
                fullAddress: "Kesnand Rd, opp. Ayurvedic college, Pune - 411001",
                city: "Pune",
                isDefault: true
            )
        ],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return HomeView()
        .environmentObject(authViewModel)
}
