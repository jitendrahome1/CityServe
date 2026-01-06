//
//  SearchHistoryView.swift
//  CityServe
//
//  Search history, suggestions, trending services, and quick access
//  Design Spec: 39_SEARCH_HISTORY.md
//

import SwiftUI
import Combine

struct SearchHistoryView: View {

    @StateObject private var viewModel = SearchHistoryViewModel()
    @Binding var searchQuery: String
    var onSearch: (String) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // Recent Searches
                if !viewModel.recentSearches.isEmpty {
                    recentSearchesSection
                }

                // Popular Searches
                popularSearchesSection

                // Trending Now
                trendingServicesSection

                // Suggested For You
                if !viewModel.suggestions.isEmpty {
                    suggestionsSection
                }

                // Browse Categories
                browseCategoriesSection
            }
            .padding(Spacing.screenPadding)
        }
        .background(Color.background)
        .onAppear {
            viewModel.loadData()
        }
    }

    // MARK: - Sections

    private var recentSearchesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text("Recent Searches")
                    .font(.h5)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()

                Button(action: {
                    Haptics.light()
                    viewModel.clearAllHistory()
                }) {
                    Text("Clear")
                        .font(.bodySmall)
                        .fontWeight(.medium)
                        .foregroundColor(.error)
                }
                .accessibilityLabel("Clear all search history")
                .accessibilityHint("Delete all recent searches")
            }

            ForEach(viewModel.recentSearches) { search in
                SearchHistoryRow(
                    search: search,
                    onTap: {
                        Haptics.light()
                        searchQuery = search.query
                        onSearch(search.query)
                    },
                    onDelete: {
                        Haptics.light()
                        viewModel.deleteSearch(search)
                    }
                )
            }
        }
    }

    private var popularSearchesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Popular Searches")
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: Spacing.md), count: 4),
                spacing: Spacing.md
            ) {
                ForEach(viewModel.popularSearches) { service in
                    PopularSearchButton(
                        service: service,
                        onTap: {
                            Haptics.medium()
                            searchQuery = service.name
                            onSearch(service.name)
                        }
                    )
                }
            }
        }
    }

    private var trendingServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Trending Now")
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            ForEach(Array(viewModel.trendingServices.enumerated()), id: \.element.id) { index, service in
                TrendingServiceRow(
                    service: service,
                    rank: index + 1,
                    onTap: {
                        Haptics.medium()
                        searchQuery = service.name
                        onSearch(service.name)
                    }
                )
            }
        }
    }

    private var suggestionsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Suggested For You")
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            Text("Based on your previous bookings:")
                .font(.caption)
                .foregroundColor(.textSecondary)

            ForEach(viewModel.suggestions) { suggestion in
                SuggestionCard(
                    suggestion: suggestion,
                    onAction: {
                        Haptics.medium()
                        // TODO: Handle book again or view plans
                    }
                )
            }
        }
    }

    private var browseCategoriesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Browse Categories")
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            VStack(spacing: 0) {
                ForEach(viewModel.topCategories) { category in
                    CategoryLinkRow(
                        category: category,
                        onTap: {
                            Haptics.light()
                            // TODO: Navigate to category
                        }
                    )
                }
            }

            Button(action: {
                Haptics.medium()
                // TODO: Navigate to all categories
            }) {
                Text("View All Categories")
                    .font(.button)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(Spacing.radiusLg)
            }
            .accessibilityLabel("View all service categories")
            .accessibilityHint("Browse all available service categories")
        }
    }
}

// MARK: - Search History Row

struct SearchHistoryRow: View {
    let search: SearchHistoryItem
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.md) {
                Image(systemName: "clock")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.textTertiary)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(search.query)
                        .font(.body)
                        .foregroundColor(.textPrimary)

                    Text(search.timestamp.timeAgoDisplay)
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }

                Spacer()

                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(.textTertiary)
                }
                .accessibilityLabel("Delete")
                .accessibilityHint("Remove this search from history")
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical, Spacing.xs)
        }
        .accessibilityLabel("Recent search: \(search.query), \(search.timestamp.timeAgoDisplay)")
        .accessibilityHint("Double tap to search again")
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Popular Search Button

struct PopularSearchButton: View {
    let service: PopularService
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: Spacing.xs) {
                Text(service.icon)
                    .font(.system(size: 32))

                Text(service.shortName)
                    .font(.tag)
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(Color.divider, lineWidth: 1)
            )
        }
        .accessibilityLabel("Search for \(service.name)")
        .accessibilityHint("Quick search shortcut")
    }
}

// MARK: - Trending Service Row

struct TrendingServiceRow: View {
    let service: TrendingService
    let rank: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.md) {
                // Rank Badge
                ZStack {
                    Circle()
                        .fill(rankColor)
                        .frame(width: 32, height: 32)

                    Text("#\(rank)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(service.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                        .lineLimit(1)

                    HStack(spacing: Spacing.xxs) {
                        Text(service.trendIndicator.icon)
                            .font(.caption)

                        Text(service.trendIndicator.text)
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: Spacing.iconXS))
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
        .accessibilityLabel("Trending: \(service.name), ranked number \(rank), \(service.trendIndicator.text)")
        .accessibilityHint("Search for this trending service")
        .buttonStyle(PlainButtonStyle())
    }

    private var rankColor: Color {
        switch rank {
        case 1: return Color.secondary
        case 2: return Color.warning
        case 3: return Color.primary
        default: return Color.textTertiary
        }
    }
}

// MARK: - Suggestion Card

struct SuggestionCard: View {
    let suggestion: SearchSuggestion
    let onAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.md) {
                Text(suggestion.icon)
                    .font(.system(size: 24))

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(suggestion.name)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    Text(suggestion.subtitle)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }

                Spacer()
            }

            Button(action: onAction) {
                Text(suggestion.actionText)
                    .font(.buttonSmall)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.sm)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(Spacing.radiusLg)
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(Color.divider, lineWidth: 1)
        )
        .accessibilityLabel("\(suggestion.name), \(suggestion.subtitle)")
        .accessibilityHint("Double tap for \(suggestion.actionText)")
    }
}

// MARK: - Category Link Row

struct CategoryLinkRow: View {
    let category: SearchCategory
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 0) {
                HStack(spacing: Spacing.md) {
                    Text(category.icon)
                        .font(.system(size: Spacing.iconSM))

                    Text(category.name)
                        .font(.body)
                        .foregroundColor(.textPrimary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(.textTertiary)
                }
                .padding(.vertical, Spacing.md)

                Divider()
            }
        }
        .accessibilityLabel("\(category.name) category")
        .accessibilityHint("View services in this category")
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Data Models

struct SearchHistoryItem: Identifiable {
    let id = UUID()
    let query: String
    let timestamp: Date
}

struct PopularService: Identifiable {
    let id = UUID()
    let name: String
    let shortName: String
    let icon: String
}

struct TrendingService: Identifiable {
    let id = UUID()
    let name: String
    let trendIndicator: TrendIndicator
}

struct TrendIndicator {
    let icon: String
    let text: String
}

struct SearchSuggestion: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let subtitle: String
    let actionText: String
}

struct SearchCategory: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
}

// MARK: - Date Extension

extension Date {
    var timeAgoDisplay: String {
        let calendar = Calendar.current
        let now = Date()

        let components = calendar.dateComponents([.minute, .hour, .day, .weekOfYear, .month], from: self, to: now)

        if let month = components.month, month > 0 {
            return month == 1 ? "1 month ago" : "\(month) months ago"
        } else if let week = components.weekOfYear, week > 0 {
            return week == 1 ? "1 week ago" : "\(week) weeks ago"
        } else if let day = components.day, day > 0 {
            return day == 1 ? "1 day ago" : "\(day) days ago"
        } else if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        } else if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        } else {
            return "Just now"
        }
    }
}

// MARK: - View Model

class SearchHistoryViewModel: ObservableObject {

    @Published var recentSearches: [SearchHistoryItem] = []
    @Published var popularSearches: [PopularService] = []
    @Published var trendingServices: [TrendingService] = []
    @Published var suggestions: [SearchSuggestion] = []
    @Published var topCategories: [SearchCategory] = []

    func loadData() {
        loadRecentSearches()
        loadPopularSearches()
        loadTrendingServices()
        loadSuggestions()
        loadTopCategories()
    }

    private func loadRecentSearches() {
        // TODO: Load from persistent storage
        recentSearches = [
            SearchHistoryItem(query: "electrician", timestamp: Date().addingTimeInterval(-2 * 24 * 60 * 60)),
            SearchHistoryItem(query: "plumber near me", timestamp: Date().addingTimeInterval(-7 * 24 * 60 * 60)),
            SearchHistoryItem(query: "AC repair", timestamp: Date().addingTimeInterval(-14 * 24 * 60 * 60)),
            SearchHistoryItem(query: "house cleaning", timestamp: Date().addingTimeInterval(-21 * 24 * 60 * 60)),
            SearchHistoryItem(query: "painting service", timestamp: Date().addingTimeInterval(-30 * 24 * 60 * 60))
        ]
    }

    private func loadPopularSearches() {
        popularSearches = [
            PopularService(name: "Electrician", shortName: "Elec", icon: "⚡"),
            PopularService(name: "Plumber", shortName: "Plum", icon: "🔧"),
            PopularService(name: "Cleaning", shortName: "Clean", icon: "🧹"),
            PopularService(name: "Painting", shortName: "Paint", icon: "🎨"),
            PopularService(name: "AC Repair", shortName: "AC", icon: "❄️"),
            PopularService(name: "Carpenter", shortName: "Carp", icon: "🪛"),
            PopularService(name: "Bathroom", shortName: "Bath", icon: "🚿"),
            PopularService(name: "Windows", shortName: "Wind", icon: "🪟")
        ]
    }

    private func loadTrendingServices() {
        trendingServices = [
            TrendingService(
                name: "AC Repair & Servicing",
                trendIndicator: TrendIndicator(icon: "🔥", text: "High demand • 2,456 bookings")
            ),
            TrendingService(
                name: "Deep Home Cleaning",
                trendIndicator: TrendIndicator(icon: "↑", text: "35% increase this week")
            ),
            TrendingService(
                name: "Electrical Wiring",
                trendIndicator: TrendIndicator(icon: "⚡", text: "Fast service • 128 providers")
            ),
            TrendingService(
                name: "Bathroom Renovation",
                trendIndicator: TrendIndicator(icon: "✨", text: "New • Starting ₹5,000")
            )
        ]
    }

    private func loadSuggestions() {
        // TODO: Load personalized suggestions based on booking history
        suggestions = [
            SearchSuggestion(
                icon: "⚡",
                name: "Electrical Maintenance",
                subtitle: "Last booked: 3 months ago",
                actionText: "Book Again"
            ),
            SearchSuggestion(
                icon: "🧹",
                name: "Monthly Cleaning Service",
                subtitle: "Save 20% with subscription",
                actionText: "View Plans"
            )
        ]
    }

    private func loadTopCategories() {
        topCategories = [
            SearchCategory(icon: "🏠", name: "Home Services"),
            SearchCategory(icon: "🛠️", name: "Repair & Maintenance"),
            SearchCategory(icon: "🎨", name: "Renovation & Painting"),
            SearchCategory(icon: "🧹", name: "Cleaning Services")
        ]
    }

    func deleteSearch(_ search: SearchHistoryItem) {
        recentSearches.removeAll { $0.id == search.id }
        // TODO: Remove from persistent storage
    }

    func clearAllHistory() {
        recentSearches.removeAll()
        // TODO: Clear persistent storage
    }
}

// MARK: - Preview

#Preview("Search History - Light") {
    NavigationStack {
        SearchHistoryView(
            searchQuery: .constant(""),
            onSearch: { query in
                print("Search: \(query)")
            }
        )
    }
}

#Preview("Search History - Dark") {
    NavigationStack {
        SearchHistoryView(
            searchQuery: .constant(""),
            onSearch: { query in
                print("Search: \(query)")
            }
        )
    }
    .preferredColorScheme(.dark)
}

#Preview("Search History - Empty") {
    let viewModel = SearchHistoryViewModel()
    viewModel.recentSearches = []
    viewModel.suggestions = []

    return NavigationStack {
        SearchHistoryView(
            searchQuery: .constant(""),
            onSearch: { query in
                print("Search: \(query)")
            }
        )
    }
}
