//
//  SearchView.swift
//  CityServe
//
//  Service Search with Filters
//

import SwiftUI

struct SearchView: View {

    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isSearchFocused: Bool
    @State private var showFilters = false

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Search Bar
                searchBar

                // Quick Filters / Recent Searches
                if viewModel.searchText.isEmpty {
                    quickFiltersSection
                } else {
                    // Search Results
                    searchResults
                }
            }
        }
        .navigationTitle("Search Services")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showFilters) {
            AdvancedFiltersView(
                filters: $viewModel.filters,
                onApply: {
                    viewModel.applyFilters()
                }
            )
        }
        .onAppear {
            isSearchFocused = true
        }
    }

    // MARK: - Subviews

    private var searchBar: some View {
        VStack(spacing: Spacing.sm) {
            HStack(spacing: Spacing.sm) {
                // Search Input
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: Spacing.iconMD))
                        .foregroundColor(.textSecondary)

                    TextField("Search for services...", text: $viewModel.searchText)
                        .font(.input)
                        .focused($isSearchFocused)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onChange(of: viewModel.searchText) { _, _ in
                            viewModel.performSearch()
                        }

                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.clearSearch()
                            isSearchFocused = true
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: Spacing.iconSM))
                                .foregroundColor(.textTertiary)
                        }
                    }
                }
                .padding(Spacing.md)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusMd)

                // Filter Button
                Button(action: {
                    showFilters = true
                }) {
                    ZStack {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textPrimary)

                        if hasActiveFilters {
                            Circle()
                                .fill(Color.primary)
                                .frame(width: 8, height: 8)
                                .offset(x: 10, y: -10)
                        }
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusMd)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.top, Spacing.sm)

            // Active Filters Chips
            if hasActiveFilters {
                activeFiltersChips
            }
        }
        .padding(.bottom, Spacing.sm)
        .background(Color.background)
    }

    private var activeFiltersChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                if let priceRange = viewModel.filters.priceRange {
                    FilterChip(
                        text: "₹\(Int(priceRange.min)) - ₹\(Int(priceRange.max))",
                        onRemove: {
                            viewModel.filters.priceRange = nil
                            viewModel.applyFilters()
                        }
                    )
                }

                if let minRating = viewModel.filters.minRating {
                    FilterChip(
                        text: "\(Int(minRating))+ ⭐",
                        onRemove: {
                            viewModel.filters.minRating = nil
                            viewModel.applyFilters()
                        }
                    )
                }

                Button(action: {
                    viewModel.clearFilters()
                }) {
                    Text("Clear All")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.error)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.vertical, Spacing.xxs)
                        .background(Color.error.opacity(0.1))
                        .cornerRadius(Spacing.radiusPill)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var quickFiltersSection: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // Popular Categories
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Popular Categories")
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: Spacing.sm),
                        GridItem(.flexible(), spacing: Spacing.sm)
                    ], spacing: Spacing.sm) {
                        ForEach(viewModel.categories.prefix(6)) { category in
                            Button(action: {
                                viewModel.searchText = category.name
                                viewModel.performSearch()
                            }) {
                                HStack(spacing: Spacing.xs) {
                                    Image(systemName: category.icon)
                                        .font(.system(size: Spacing.iconSM))

                                    Text(category.name)
                                        .font(.bodySmall)
                                        .lineLimit(1)
                                }
                                .foregroundColor(.textPrimary)
                                .padding(.horizontal, Spacing.sm)
                                .padding(.vertical, Spacing.xs)
                                .frame(maxWidth: .infinity)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusMd)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Spacing.radiusMd)
                                        .stroke(Color.divider, lineWidth: 1)
                                )
                            }
                        }
                    }
                }

                // Popular Services
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Popular Services")
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    ForEach(viewModel.popularServices.prefix(5)) { service in
                        NavigationLink(destination: ServiceDetailView(service: service)) {
                            SearchResultCard(service: service)
                        }
                    }
                }

                Spacer()
            }
            .padding(Spacing.screenPadding)
        }
    }

    private var searchResults: some View {
        Group {
            if viewModel.isLoading {
                LoadingView(message: "Searching...", style: .spinner)
            } else if viewModel.filteredServices.isEmpty {
                emptySearchResults
            } else {
                ScrollView {
                    LazyVStack(spacing: Spacing.md) {
                        // Results count
                        HStack {
                            Text("\(viewModel.filteredServices.count) results found")
                                .font(.bodySmall)
                                .foregroundColor(.textSecondary)

                            Spacer()

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
                                    Text("Sort")
                                        .font(.bodySmall)
                                        .fontWeight(.medium)

                                    Image(systemName: "chevron.down")
                                        .font(.system(size: Spacing.iconXS))
                                }
                                .foregroundColor(.textPrimary)
                            }
                        }
                        .padding(.horizontal, Spacing.screenPadding)

                        // Results
                        ForEach(viewModel.filteredServices) { service in
                            NavigationLink(destination: ServiceDetailView(service: service)) {
                                SearchResultCard(service: service)
                            }
                        }
                    }
                    .padding(Spacing.screenPadding)
                }
            }
        }
    }

    private var emptySearchResults: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            EmptyStateView(
                icon: "magnifyingglass",
                title: "No results found",
                description: "Try searching with different keywords or adjust your filters."
            )

            if hasActiveFilters {
                SecondaryButton(
                    "Clear Filters",
                    icon: "xmark.circle",
                    size: .medium,
                    action: {
                        viewModel.clearFilters()
                    }
                )
                .padding(.horizontal, Spacing.screenPadding)
            }

            Spacer()
        }
    }

    // MARK: - Computed Properties

    private var hasActiveFilters: Bool {
        viewModel.filters.priceRange != nil || viewModel.filters.minRating != nil
    }
}

// MARK: - Search Result Card

struct SearchResultCard: View {
    let service: Service

    var body: some View {
        HStack(spacing: Spacing.md) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 60, height: 60)

                if let icon = service.icon {
                    Image(systemName: icon)
                        .font(.h2)
                        .foregroundColor(.primary)
                }
            }

            // Details
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(service.name)
                    .font(.bodyLarge)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)

                Text(service.shortDescription)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
                    .lineLimit(2)

                HStack(spacing: Spacing.sm) {
                    // Rating
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "star.fill")
                            .font(.system(size: Spacing.iconXS))
                            .foregroundColor(.warning)

                        Text(String(format: "%.1f", service.rating))
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }

                    Text("•")
                        .font(.caption)
                        .foregroundColor(.textTertiary)

                    // Duration
                    Text(service.formattedDuration)
                        .font(.caption)
                        .foregroundColor(.textSecondary)

                    Spacer()

                    // Price
                    Text(service.formattedPrice)
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
            }

            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundColor(.textTertiary)
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - Filter Chip

struct FilterChip: View {
    let text: String
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: Spacing.xxs) {
            Text(text)
                .font(.caption)
                .fontWeight(.medium)

            Button(action: {
                Haptics.light()
                onRemove()
            }) {
                Image(systemName: "xmark")
                    .font(.caption)
            }
        }
        .foregroundColor(.primary)
        .padding(.horizontal, Spacing.sm)
        .padding(.vertical, Spacing.xxs)
        .background(Color.primary.opacity(0.1))
        .cornerRadius(Spacing.radiusPill)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SearchView()
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        SearchView()
    }
    .preferredColorScheme(.dark)
}
