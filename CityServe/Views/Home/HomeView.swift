//
//  HomeView.swift
//  CityServe
//
//  Main Home Screen - Service Discovery
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

                ScrollView {
                    VStack(spacing: 20) {
                        // Greeting Section
                        greetingSection

                        // Search Bar
                        searchBar

                        // Popular Services
                        if !viewModel.isLoading && !viewModel.popularServices.isEmpty {
                            popularServicesSection
                                .padding(.top, 8)
                        }

                        // All Categories
                        if !viewModel.categories.isEmpty {
                            categoriesSection
                                .padding(.top, 8)
                        }

                        // Promotional Carousel
                        promoCarousel
                            .padding(.top, 8)

                        Spacer(minLength: Spacing.xl)
                    }
                    .padding(.top, 12)
                }
                .refreshable {
                    await viewModel.refreshData()
                }

                // Loading overlay
                if viewModel.isLoading && viewModel.categories.isEmpty {
                    LoadingView(
                        message: Strings.Home.loading,
                        style: .spinner
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.categories.isEmpty {
                    viewModel.loadInitialData()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    citySelectorButton
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: Spacing.sm) {
                        searchButton
                        notificationButton
                    }
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

    // MARK: - Subviews

    private var greetingSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(greetingText)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.textPrimary)

            Text(Strings.Home.subtitle)
                .font(.system(size: 15))
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
        .padding(.top, Spacing.xs)
    }

    private var searchBar: some View {
        NavigationLink(destination: SearchView()) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.textSecondary)

                Text(Strings.Home.searchPlaceholder)
                    .font(.system(size: 15))
                    .foregroundColor(.textTertiary)

                Spacer()
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var popularServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text(Strings.Home.popular)
                    .font(.h3)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.bold)

                Spacer()

                NavigationLink(destination: ServiceCategoriesView()) {
                    HStack(spacing: 4) {
                        Text(Strings.Common.seeAll)
                            .font(.bodySmall)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal, Spacing.screenPadding)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    ForEach(viewModel.popularServices.prefix(6)) { service in
                        NavigationLink(destination: ServiceDetailView(service: service)) {
                            ServiceCard(
                                service: ServiceCardModel(
                                    id: service.id,
                                    name: service.name,
                                    icon: service.icon,
                                    imageURL: service.imageURL,
                                    shortDescription: service.shortDescription,
                                    basePrice: service.basePrice,
                                    maxPrice: service.priceRange?.max,
                                    rating: service.rating,
                                    reviewCount: service.reviewCount
                                ),
                                style: .vertical
                            )
                            .frame(width: 180, height: 240)
                        }
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.vertical, 2)
            }
        }
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text(Strings.Home.categories)
                    .font(.h3)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.bold)

                Spacer()
            }
            .padding(.horizontal, Spacing.screenPadding)

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm)
            ], spacing: Spacing.sm) {
                ForEach(viewModel.categories.prefix(8)) { category in
                    NavigationLink(destination: CategoryDetailView(category: category)) {
                        CompactCategoryCard(category: category)
                    }
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var promoCarousel: some View {
        VStack(spacing: Spacing.xs) {
            // Promo Carousel with TabView
            TabView(selection: $viewModel.selectedPromoIndex) {
                ForEach(Array(viewModel.promoBanners.enumerated()), id: \.element.id) { index, promo in
                    PromoCard(promo: promo)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 140)
            .padding(.horizontal, Spacing.screenPadding)

            // Custom Page Indicator
            if viewModel.promoBanners.count > 1 {
                HStack(spacing: Spacing.xs) {
                    ForEach(0..<viewModel.promoBanners.count, id: \.self) { index in
                        Capsule()
                            .fill(index == viewModel.selectedPromoIndex ? Color.primary : Color.divider)
                            .frame(
                                width: index == viewModel.selectedPromoIndex ? 20 : 6,
                                height: 6
                            )
                            .animation(.easeInOut(duration: 0.3), value: viewModel.selectedPromoIndex)
                    }
                }
            }
        }
    }

    private var citySelectorButton: some View {
        Button(action: {
            showCitySelector = true
        }) {
            HStack(spacing: Spacing.xxs) {
                Text(viewModel.selectedCity)
                    .font(.h5)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)

                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }

    private var searchButton: some View {
        NavigationLink(destination: SearchView()) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: Spacing.iconMD))
                .foregroundColor(.textPrimary)
        }
    }

    private var notificationButton: some View {
        Button(action: {
            showNotifications = true
        }) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell.fill")
                    .font(.system(size: Spacing.iconMD))
                    .foregroundColor(.textPrimary)

                // Notification badge
                Circle()
                    .fill(Color.error)
                    .frame(width: 8, height: 8)
                    .offset(x: 2, y: -2)
            }
        }
    }

    // MARK: - Computed Properties

    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5..<12:
            return Strings.Home.greetingMorning(userName)
        case 12..<17:
            return Strings.Home.greetingAfternoon(userName)
        case 17..<21:
            return Strings.Home.greetingEvening(userName)
        default:
            return Strings.Home.greetingDefault(userName)
        }
    }

    private var userName: String {
        authViewModel.currentUser?.fullName.components(separatedBy: " ").first ?? "User"
    }
}

// MARK: - Category Card

struct CategoryCard: View {
    let category: ServiceCategory

    var body: some View {
        VStack(spacing: Spacing.sm) {
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.1))
                    .frame(width: 64, height: 64)

                Image(systemName: category.icon)
                    .font(.h1)
                    .foregroundColor(categoryColor)
            }

            Text(category.name)
                .font(.bodyLarge)
                .foregroundColor(.textPrimary)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)

            Text(Strings.Home.categoryServices(category.serviceCount))
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.lg)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusMd)
                .stroke(Color.divider, lineWidth: 1)
        )
    }

    private var categoryColor: Color {
        switch category.iconColor {
        case "primary": return .primary
        case "secondary": return .secondary
        case "success": return .success
        case "warning": return .warning
        case "info": return .info
        default: return .primary
        }
    }
}

// MARK: - Compact Category Card (4-column grid)

struct CompactCategoryCard: View {
    let category: ServiceCategory

    var body: some View {
        VStack(spacing: Spacing.xs) {
            ZStack {
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .fill(categoryColor.opacity(0.1))
                    .frame(height: 72)

                Image(systemName: category.icon)
                    .font(.system(size: 32))
                    .foregroundColor(categoryColor)
            }

            Text(category.name)
                .font(.caption)
                .foregroundColor(.textPrimary)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var categoryColor: Color {
        switch category.iconColor {
        case "primary": return .primary
        case "secondary": return .secondary
        case "success": return .success
        case "warning": return .warning
        case "info": return .info
        default: return .primary
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
                            .font(.bodyLarge)
                            .foregroundColor(.textPrimary)

                        Spacer()

                        if city == selectedCity {
                            Image(systemName: "checkmark")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .navigationTitle(Strings.Home.selectCity)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Strings.Common.done) {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Promo Card

struct PromoCard: View {
    let promo: PromoBanner

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Gradient
            LinearGradient(
                colors: promo.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(Spacing.radiusLg)

            // Content
            VStack(alignment: .leading, spacing: Spacing.sm) {
                // Icon
                HStack {
                    Image(systemName: promo.icon)
                        .font(.system(size: 32))
                        .foregroundColor(.white)

                    Spacer()

                    // CTA Badge
                    if let ctaText = promo.ctaText {
                        Text(ctaText)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, Spacing.sm)
                            .padding(.vertical, Spacing.xxs)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(Spacing.radiusPill)
                    }
                }

                Spacer()

                // Title
                Text(promo.title)
                    .font(.h4)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)

                // Subtitle
                Text(promo.subtitle)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(Spacing.lg)
        }
        .frame(height: 140)
        .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Promo Banner Model

struct PromoBanner: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let ctaText: String?
    let gradientColors: [Color]
    let promoCode: String?

    static let mockBanners: [PromoBanner] = [
        PromoBanner(
            id: "promo1",
            title: Strings.Promo.first20Title,
            subtitle: Strings.Promo.first20Subtitle,
            icon: "gift.fill",
            ctaText: Strings.Promo.first20Cta,
            gradientColors: [Color.secondary, Color.secondaryLight],
            promoCode: "FIRST20"
        ),
        PromoBanner(
            id: "promo2",
            title: Strings.Promo.acCheckupTitle,
            subtitle: Strings.Promo.acCheckupSubtitle,
            icon: "snowflake",
            ctaText: Strings.Promo.acCheckupCta,
            gradientColors: [Color.info, Color.info.opacity(0.7)],
            promoCode: nil
        ),
        PromoBanner(
            id: "promo3",
            title: Strings.Promo.cleaningTitle,
            subtitle: Strings.Promo.cleaningSubtitle,
            icon: "sparkles",
            ctaText: Strings.Promo.cleaningCta,
            gradientColors: [Color.success, Color.success.opacity(0.7)],
            promoCode: "CLEAN500"
        )
    ]
}

// MARK: - Preview

#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return HomeView()
        .environmentObject(authViewModel)
}

#Preview("Dark Mode") {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )

    return HomeView()
        .environmentObject(authViewModel)
        .preferredColorScheme(.dark)
}
