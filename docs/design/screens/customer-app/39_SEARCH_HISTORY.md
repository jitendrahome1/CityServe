# Screen 39: Search History

## Overview

- **Screen ID**: 39
- **Screen Name**: Search History
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 03 (Home) → Tap search bar (before typing)
  - From: Screen 37 (Search Results) → Tap back while in search

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ 🔍 Search services...           Clear  │ Search Bar
├─────────────────────────────────────────┤
│                                         │
│  ───── Recent Searches ─────            │
│                                         │
│  🕐 electrician                     ✕   │ History Item
│     2 days ago                          │
│                                         │
│  🕐 plumber near me                 ✕   │
│     1 week ago                          │
│                                         │
│  🕐 AC repair                       ✕   │
│     2 weeks ago                         │
│                                         │
│  🕐 house cleaning                  ✕   │
│     3 weeks ago                         │
│                                         │
│  🕐 painting service                ✕   │
│     1 month ago                         │
│                                         │
│  [Clear All History]                    │
│                                         │
│  ───── Popular Searches ─────           │
│                                         │
│  ┌────┬────┬────┬────┐                 │
│  │⚡  │🔧  │🧹  │🎨  │                 │ Quick Icons
│  │Elec│Plum│Clea│Pain│                 │
│  └────┴────┴────┴────┘                 │
│                                         │
│  ┌────┬────┬────┬────┐                 │
│  │❄️  │🪛  │🚿  │🪟  │                 │
│  │ AC │Carp│Bath│Wind│                 │
│  └────┴────┴────┴────┘                 │
│                                         │
│  ───── Trending Now ─────               │
│                                         │
│  🔥 #1  AC Repair & Servicing           │ Trending Item
│       🔥 High demand • 2,456 bookings   │
│                                         │
│  🔥 #2  Deep Home Cleaning              │
│       ↑ 35% increase this week          │
│                                         │
│  🔥 #3  Electrical Wiring               │
│       ⚡ Fast service • 128 providers   │
│                                         │
│  🔥 #4  Bathroom Renovation             │
│       New • Starting ₹ 5,000            │
│                                         │
│  ───── Suggested For You ─────          │
│                                         │
│  Based on your previous bookings:       │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ⚡ Electrical Maintenance        │    │ Suggestion Card
│  │ Last booked: 3 months ago       │    │
│  │ [Book Again]                    │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🧹 Monthly Cleaning Service     │    │
│  │ Save 20% with subscription      │    │
│  │ [View Plans]                    │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Browse Categories ─────          │
│                                         │
│  🏠 Home Services                   →   │ Category Link
│  🛠️  Repair & Maintenance            →   │
│  🎨 Renovation & Painting           →   │
│  🧹 Cleaning Services               →   │
│  [View All Categories]                  │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Recent Searches
- Last 10 searches
- Timestamp display (2 days ago, 1 week ago)
- Quick re-search on tap
- Remove individual items (X button)
- Clear all history option

### 2. Popular Searches
- Quick-access service icons
- 8 most popular services
- Visual grid layout
- One-tap search

### 3. Trending Now
- Top 4 trending services
- Ranking badges (#1, #2, #3, #4)
- Trend indicators (🔥 High demand, ↑ Increase, ⚡ Fast, New)
- Booking stats or pricing info

### 4. Suggested For You
- Personalized recommendations
- Based on booking history
- "Book Again" quick action
- Subscription offers

### 5. Browse Categories
- Quick links to service categories
- Organized by type
- "View All" expansion

## Component Breakdown

```swift
struct SearchHistoryView: View {
    @StateObject private var viewModel = SearchHistoryViewModel()
    @Binding var searchQuery: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Recent Searches
                if !viewModel.recentSearches.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Recent Searches")
                                .font(.custom("Inter-SemiBold", size: 16))
                                .foregroundColor(Color("TextPrimary"))

                            Spacer()

                            Button("Clear") {
                                viewModel.clearAllHistory()
                            }
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("ErrorRed"))
                        }

                        ForEach(viewModel.recentSearches) { search in
                            SearchHistoryRow(
                                search: search,
                                onTap: {
                                    searchQuery = search.query
                                    viewModel.performSearch(search.query)
                                },
                                onDelete: {
                                    viewModel.deleteSearch(search)
                                }
                            )
                        }
                    }
                }

                // Popular Searches
                VStack(alignment: .leading, spacing: 12) {
                    Text("Popular Searches")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                        ForEach(viewModel.popularSearches) { service in
                            PopularSearchButton(
                                service: service,
                                onTap: {
                                    searchQuery = service.name
                                    viewModel.performSearch(service.name)
                                }
                            )
                        }
                    }
                }

                // Trending Now
                VStack(alignment: .leading, spacing: 12) {
                    Text("Trending Now")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    ForEach(Array(viewModel.trendingServices.enumerated()), id: \.element.id) { index, service in
                        TrendingServiceRow(
                            service: service,
                            rank: index + 1,
                            onTap: {
                                searchQuery = service.name
                                viewModel.performSearch(service.name)
                            }
                        )
                    }
                }

                // Suggested For You
                if !viewModel.suggestions.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Suggested For You")
                            .font(.custom("Inter-SemiBold", size: 16))
                            .foregroundColor(Color("TextPrimary"))

                        Text("Based on your previous bookings:")
                            .font(.custom("Inter-Regular", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        ForEach(viewModel.suggestions) { suggestion in
                            SuggestionCard(
                                suggestion: suggestion,
                                onAction: {
                                    // Handle book again or view plans
                                }
                            )
                        }
                    }
                }

                // Browse Categories
                VStack(alignment: .leading, spacing: 12) {
                    Text("Browse Categories")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    ForEach(viewModel.topCategories) { category in
                        CategoryLinkRow(
                            category: category,
                            onTap: {
                                // Navigate to category
                            }
                        )
                    }

                    Button("View All Categories") {
                        // Navigate to all categories
                    }
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color("PrimaryTeal"))
                }
            }
            .padding(16)
        }
        .background(Color("BackgroundPrimary"))
    }
}

struct SearchHistoryRow: View {
    let search: SearchHistory
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "clock")
                    .font(.system(size: 18))
                    .foregroundColor(Color("TextTertiary"))

                VStack(alignment: .leading, spacing: 2) {
                    Text(search.query)
                        .font(.custom("Inter-Regular", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    Text(search.timestamp.timeAgoDisplay)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }

                Spacer()

                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14))
                        .foregroundColor(Color("TextTertiary"))
                }
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PopularSearchButton: View {
    let service: PopularService
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                Text(service.icon)
                    .font(.system(size: 32))

                Text(service.shortName)
                    .font(.custom("Inter-Medium", size: 12))
                    .foregroundColor(Color("TextPrimary"))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("BorderLight"), lineWidth: 1)
            )
        }
    }
}

struct TrendingServiceRow: View {
    let service: TrendingService
    let rank: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Rank Badge
                ZStack {
                    Circle()
                        .fill(rankColor)
                        .frame(width: 32, height: 32)

                    Text("#\(rank)")
                        .font(.custom("Inter-Bold", size: 12))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(service.name)
                        .font(.custom("Inter-SemiBold", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    HStack(spacing: 6) {
                        Text(service.trendIndicator.icon)
                            .font(.system(size: 12))

                        Text(service.trendIndicator.text)
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BorderLight"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    var rankColor: Color {
        switch rank {
        case 1: return Color("SecondaryOrange")
        case 2: return Color("WarningYellow")
        case 3: return Color("PrimaryTeal")
        default: return Color("TextTertiary")
        }
    }
}

struct SuggestionCard: View {
    let suggestion: Suggestion
    let onAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(suggestion.icon)
                    .font(.system(size: 24))

                VStack(alignment: .leading, spacing: 2) {
                    Text(suggestion.name)
                        .font(.custom("Inter-SemiBold", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    Text(suggestion.subtitle)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()
            }

            Button(action: onAction) {
                Text(suggestion.actionText)
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color("PrimaryTeal"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color("PrimaryTeal").opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
    }
}

struct CategoryLinkRow: View {
    let category: Category
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text(category.icon)
                    .font(.system(size: 20))

                Text(category.name)
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
        Divider()
    }
}

struct SearchHistory: Identifiable {
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

struct Suggestion: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
    let subtitle: String
    let actionText: String
}

struct Category: Identifiable {
    let id = UUID()
    let icon: String
    let name: String
}

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
```

## API Integration

```
GET /search/history

Response:
{
  "success": true,
  "data": {
    "recentSearches": [
      {
        "query": "electrician",
        "timestamp": "2025-12-29T10:30:00Z"
      }
    ],
    "popularSearches": [
      {
        "name": "Electrician",
        "shortName": "Elec",
        "icon": "⚡",
        "searchCount": 25000
      }
    ],
    "trendingServices": [
      {
        "name": "AC Repair & Servicing",
        "trend": {
          "type": "high_demand",
          "icon": "🔥",
          "text": "High demand • 2,456 bookings"
        },
        "rank": 1
      }
    ],
    "suggestions": [
      {
        "name": "Electrical Maintenance",
        "subtitle": "Last booked: 3 months ago",
        "actionText": "Book Again",
        "icon": "⚡"
      }
    ]
  }
}
```

## Navigation

- Tap Recent Search → Search Results (Screen 37)
- Tap Popular/Trending → Search Results
- Tap Suggestion → Service Detail or Booking
- Tap Category → Category List

## Testing Checklist

- [ ] Recent searches display correctly
- [ ] Delete individual history items
- [ ] Clear all history works
- [ ] Popular searches grid loads
- [ ] Trending services show correct rank
- [ ] Suggestions personalized correctly
- [ ] Category links navigate properly
- [ ] Time ago calculations accurate

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web

---

**🎉 Customer App Group 1 Complete! (Screens 37-39)**
