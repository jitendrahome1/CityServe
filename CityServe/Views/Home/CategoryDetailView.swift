//
//  CategoryDetailView.swift
//  CityServe
//
//  Services in a Specific Category
//

import SwiftUI

struct CategoryDetailView: View {

    let category: ServiceCategory
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showFilters = false

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Category Header
                categoryHeader

                // Filter Bar
                filterBar

                // Services List
                if filteredServices.isEmpty {
                    emptyState
                } else {
                    servicesList
                }
            }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showFilters) {
            FilterSheet(
                filters: $viewModel.filters,
                onApply: {
                    viewModel.applyFilters()
                    showFilters = false
                }
            )
        }
        .onAppear {
            viewModel.selectCategory(category)
        }
    }

    // MARK: - Subviews

    private var categoryHeader: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(categoryColor.opacity(0.1))
                    .frame(width: 56, height: 56)

                Image(systemName: category.icon)
                    .font(.h2)
                    .foregroundColor(categoryColor)
            }

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(category.description)
                    .font(.body)
                    .foregroundColor(.textSecondary)

                Text("\(filteredServices.count) services available")
                    .font(.bodySmall)
                    .foregroundColor(.textTertiary)
            }

            Spacer()
        }
        .padding(Spacing.screenPadding)
        .background(Color.surface)
    }

    private var filterBar: some View {
        HStack(spacing: Spacing.sm) {
            // Sort Menu
            Menu {
                ForEach(ServiceFilters.SortOption.allCases, id: \.self) { option in
                    Button(action: {
                        viewModel.filters.sortBy = option
                        viewModel.applyFilters()
                    }) {
                        HStack {
                            Text(option.rawValue)
                            if viewModel.filters.sortBy == option {
                                Spacer()
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.body)

                    Text("Sort")
                        .font(.bodySmall)
                        .fontWeight(.medium)
                }
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusPill)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusPill)
                        .stroke(Color.divider, lineWidth: 1)
                )
            }

            // Filters Button
            Button(action: {
                showFilters = true
            }) {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.body)

                    Text("Filters")
                        .font(.bodySmall)
                        .fontWeight(.medium)

                    if hasActiveFilters {
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 6, height: 6)
                    }
                }
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusPill)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusPill)
                        .stroke(Color.divider, lineWidth: 1)
                )
            }

            Spacer()

            // Clear Filters
            if hasActiveFilters {
                Button(action: {
                    viewModel.clearFilters()
                }) {
                    Text("Clear")
                        .font(.bodySmall)
                        .foregroundColor(.error)
                        .fontWeight(.medium)
                }
            }
        }
        .padding(.horizontal, Spacing.screenPadding)
        .padding(.vertical, Spacing.sm)
        .background(Color.background)
    }

    private var servicesList: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.md) {
                ForEach(filteredServices) { service in
                    NavigationLink(destination: ServiceDetailView(service: service)
                        .environmentObject(authViewModel)) {
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
                            action: {},
                            style: .horizontal
                        )
                    }
                }
            }
            .padding(Spacing.screenPadding)
        }
    }

    private var emptyState: some View {
        EmptyStateView(
            icon: "magnifyingglass",
            title: "No services found",
            description: "Try adjusting your filters or check back later."
        )
    }

    // MARK: - Computed Properties

    private var filteredServices: [Service] {
        viewModel.displayedServices
    }

    private var hasActiveFilters: Bool {
        viewModel.filters.priceRange != nil || viewModel.filters.minRating != nil
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

// MARK: - Filter Sheet

struct FilterSheet: View {
    @Binding var filters: ServiceFilters
    let onApply: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var minPrice: Double = 0
    @State private var maxPrice: Double = 10000
    @State private var selectedRating: Double = 0

    var body: some View {
        NavigationStack {
            Form {
                Section("Price Range") {
                    HStack {
                        Text("₹\(Int(minPrice))")
                            .font(.bodySmall)
                        Spacer()
                        Text("₹\(Int(maxPrice))")
                            .font(.bodySmall)
                    }

                    VStack(spacing: Spacing.sm) {
                        HStack {
                            Text("Min")
                                .font(.caption)
                            Slider(value: $minPrice, in: 0...10000, step: 100)
                        }

                        HStack {
                            Text("Max")
                                .font(.caption)
                            Slider(value: $maxPrice, in: 0...10000, step: 100)
                        }
                    }
                }

                Section("Minimum Rating") {
                    HStack {
                        ForEach(1...5, id: \.self) { rating in
                            Button(action: {
                                selectedRating = Double(rating)
                            }) {
                                Image(systemName: selectedRating >= Double(rating) ? "star.fill" : "star")
                                    .foregroundColor(selectedRating >= Double(rating) ? .warning : .textTertiary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        applyFilters()
                    }
                    .fontWeight(.semibold)
                }
            }
            .onAppear {
                if let priceRange = filters.priceRange {
                    minPrice = priceRange.min
                    maxPrice = priceRange.max
                }
                selectedRating = filters.minRating ?? 0
            }
        }
    }

    private func applyFilters() {
        if minPrice > 0 || maxPrice < 10000 {
            filters.priceRange = PriceRange(min: minPrice, max: maxPrice)
        } else {
            filters.priceRange = nil
        }

        if selectedRating > 0 {
            filters.minRating = selectedRating
        } else {
            filters.minRating = nil
        }

        onApply()
    }
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

    return NavigationStack {
        CategoryDetailView(category: ServiceCategory.mockCategories[0])
            .environmentObject(authViewModel)
    }
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
    authViewModel.isAuthenticated = true

    return NavigationStack {
        CategoryDetailView(category: ServiceCategory.mockCategories[0])
            .environmentObject(authViewModel)
    }
    .preferredColorScheme(.dark)
}
