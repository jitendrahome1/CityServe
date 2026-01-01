# Screen 37: Search Results

## Overview

- **Screen ID**: 37
- **Screen Name**: Search Results
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 03 (Home) → Tap search bar, enter query
  - From: Screen 39 (Search History) → Tap previous search

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  🔍 electrician           ⋮          │ Search Bar
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │ [All] [Services] [Providers]    │    │ Tabs
│  └────────────────────────────────┘    │
│                                         │
│  Filters: [📍 Near Me] [💰 Price] [⭐]  │ Filter Pills
│  Sort: [Recommended ▼]                  │ Sort Dropdown
│                                         │
│  128 results found                      │ Result Count
│                                         │
│  ───── Services (45) ─────              │ Section
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ⚡ Electrical Repair             │    │ Service Card
│  │                                 │    │
│  │ Basic electrical repairs &      │    │
│  │ installations                   │    │
│  │                                 │    │
│  │ ₹ 300 - ₹ 1,500                 │    │
│  │ ⭐ 4.8 (2,345 reviews)           │    │
│  │                                 │    │
│  │ 156 providers nearby            │    │
│  │                                 │    │
│  │ [View Details]                  │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ⚡ Wiring & Installation         │    │
│  │                                 │    │
│  │ Complete wiring solutions for   │    │
│  │ homes and offices               │    │
│  │                                 │    │
│  │ ₹ 500 - ₹ 5,000                 │    │
│  │ ⭐ 4.7 (892 reviews)             │    │
│  │                                 │    │
│  │ 89 providers nearby             │    │
│  │                                 │    │
│  │ [View Details]                  │    │
│  └────────────────────────────────┘    │
│                                         │
│  [Show More Services]                   │
│                                         │
│  ───── Top Providers (83) ─────         │ Section
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 👤  John Doe              ⭐ 4.9│    │ Provider Card
│  │     Electrician                 │    │
│  │                                 │    │
│  │ ✓ Verified • 10+ years exp      │    │
│  │ 156 jobs • ₹ 300 - ₹ 1,500      │    │
│  │                                 │    │
│  │ 📍 2.3 km away                   │    │
│  │ ⏰ Available today               │    │
│  │                                 │    │
│  │ [Book Now]                      │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 👤  Raj Kumar             ⭐ 4.8│    │
│  │     Licensed Electrician        │    │
│  │                                 │    │
│  │ ✓ Verified • 8 years exp        │    │
│  │ 89 jobs • ₹ 250 - ₹ 2,000       │    │
│  │                                 │    │
│  │ 📍 3.1 km away                   │    │
│  │ ⏰ Available tomorrow            │    │
│  │                                 │    │
│  │ [Book Now]                      │    │
│  └────────────────────────────────┘    │
│                                         │
│  [Load More Results]                    │
│                                         │
└─────────────────────────────────────────┘

NO RESULTS STATE:

┌─────────────────────────────────────────┐
│                                         │
│          🔍 (Illustration)              │
│                                         │
│      No Results Found                   │
│                                         │
│   We couldn't find any matches for      │
│   "plombr" (typo example)               │
│                                         │
│   Did you mean: "plumber"?              │
│   [Search "plumber"]                    │
│                                         │
│   Suggestions:                          │
│   • Check your spelling                 │
│   • Try different keywords              │
│   • Use filters to broaden search       │
│   • Browse popular services             │
│                                         │
│   Popular Searches:                     │
│   [Electrician] [Plumber] [Cleaner]     │
│   [Painter] [AC Repair]                 │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Search Bar
- Active search query displayed
- Edit search inline
- Clear search (X button)
- Voice search icon
- Search suggestions as you type

### 2. Result Tabs
- **All**: Mixed results (services + providers)
- **Services**: Service categories only
- **Providers**: Individual providers only

### 3. Filter & Sort
- **Filters**:
  - Near Me (location-based)
  - Price range
  - Rating (minimum stars)
  - Availability (today, this week, anytime)
  - Verified providers only
- **Sort**:
  - Recommended (default)
  - Distance (nearest first)
  - Rating (highest first)
  - Price (low to high / high to low)
  - Most Popular

### 4. Search Results
- **Service Cards**:
  - Service name and icon
  - Brief description
  - Price range
  - Average rating and review count
  - Number of available providers
  - "View Details" CTA

- **Provider Cards**:
  - Profile photo, name, rating
  - Specialization/title
  - Verification badge
  - Years of experience
  - Jobs completed, price range
  - Distance from user
  - Availability status
  - "Book Now" CTA

### 5. Smart Features
- Spell check and suggestions
- Related searches
- Popular alternatives
- Recently searched (personalized)

### 6. Infinite Scroll
- Load more results on scroll
- Skeleton loading states
- "No more results" indicator

## Component Breakdown

### 1. Search Bar Header
```swift
struct SearchResultsHeader: View {
    @Binding var searchQuery: String
    @Environment(\.dismiss) var dismiss
    @State private var showingFilters = false

    var body: some View {
        HStack(spacing: 12) {
            // Back Button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            // Search Bar
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundColor(Color("TextTertiary"))

                TextField("Search services or providers", text: $searchQuery)
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                if !searchQuery.isEmpty {
                    Button(action: { searchQuery = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color("TextTertiary"))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color("BackgroundSecondary"))
            .cornerRadius(10)

            // Filter Button
            Button(action: { showingFilters = true }) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 18))
                    .foregroundColor(Color("PrimaryTeal"))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
```

### 2. Result Tabs
```swift
struct SearchResultTabs: View {
    @Binding var selectedTab: SearchTab
    let resultCounts: SearchResultCounts

    var body: some View {
        HStack(spacing: 0) {
            ForEach(SearchTab.allCases, id: \.self) { tab in
                Button(action: { selectedTab = tab }) {
                    VStack(spacing: 6) {
                        HStack(spacing: 4) {
                            Text(tab.title)
                                .font(.custom("Inter-SemiBold", size: 14))

                            if let count = resultCounts.count(for: tab) {
                                Text("(\(count))")
                                    .font(.custom("Inter-Regular", size: 12))
                            }
                        }
                        .foregroundColor(selectedTab == tab ? Color("PrimaryTeal") : Color("TextSecondary"))

                        Rectangle()
                            .fill(selectedTab == tab ? Color("PrimaryTeal") : Color.clear)
                            .frame(height: 2)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
    }
}

enum SearchTab: String, CaseIterable {
    case all = "All"
    case services = "Services"
    case providers = "Providers"

    var title: String { rawValue }
}

struct SearchResultCounts {
    let all: Int
    let services: Int
    let providers: Int

    func count(for tab: SearchTab) -> Int? {
        switch tab {
        case .all: return all > 0 ? all : nil
        case .services: return services > 0 ? services : nil
        case .providers: return providers > 0 ? providers : nil
        }
    }
}
```

### 3. Filter Pills & Sort
```swift
struct FilterSortBar: View {
    @Binding var activeFilters: [SearchFilter]
    @Binding var sortOption: SortOption
    let onFilterTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Filter Pills
            if !activeFilters.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(activeFilters, id: \.id) { filter in
                            FilterPill(
                                filter: filter,
                                onRemove: { removeFilter(filter) }
                            )
                        }

                        Button(action: { activeFilters.removeAll() }) {
                            Text("Clear All")
                                .font(.custom("Inter-SemiBold", size: 12))
                                .foregroundColor(Color("ErrorRed"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color("ErrorRed").opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }

            // Sort Dropdown
            HStack {
                Text("Sort:")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                Menu {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Button(action: { sortOption = option }) {
                            HStack {
                                Text(option.displayName)
                                if sortOption == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(sortOption.displayName)
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("PrimaryTeal"))

                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(Color("PrimaryTeal"))
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
        .background(Color.white)
    }

    func removeFilter(_ filter: SearchFilter) {
        activeFilters.removeAll { $0.id == filter.id }
    }
}

struct FilterPill: View {
    let filter: SearchFilter
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 6) {
            Text(filter.icon)
                .font(.system(size: 12))

            Text(filter.displayName)
                .font(.custom("Inter-Medium", size: 12))

            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.system(size: 10))
            }
        }
        .foregroundColor(Color("PrimaryTeal"))
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color("PrimaryTeal").opacity(0.1))
        .cornerRadius(16)
    }
}

struct SearchFilter: Identifiable {
    let id = UUID()
    let icon: String
    let displayName: String
    let type: FilterType

    enum FilterType {
        case location, price, rating, availability, verified
    }
}

enum SortOption: String, CaseIterable {
    case recommended, distance, rating, priceLow, priceHigh, popular

    var displayName: String {
        switch self {
        case .recommended: return "Recommended"
        case .distance: return "Nearest First"
        case .rating: return "Highest Rated"
        case .priceLow: return "Price: Low to High"
        case .priceHigh: return "Price: High to Low"
        case .popular: return "Most Popular"
        }
    }
}
```

### 4. Service Result Card
```swift
struct ServiceResultCard: View {
    let service: ServiceResult
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(service.icon)
                        .font(.system(size: 32))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(service.name)
                            .font(.custom("Inter-SemiBold", size: 16))
                            .foregroundColor(Color("TextPrimary"))

                        Text(service.description)
                            .font(.custom("Inter-Regular", size: 13))
                            .foregroundColor(Color("TextSecondary"))
                            .lineLimit(2)
                    }

                    Spacer()
                }

                Divider()

                // Pricing & Rating
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("₹ \(service.minPrice.formatted()) - ₹ \(service.maxPrice.formatted())")
                            .font(.custom("Inter-Bold", size: 15))
                            .foregroundColor(Color("PrimaryTeal"))

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("SecondaryOrange"))

                            Text(String(format: "%.1f", service.rating))
                                .font(.custom("Inter-SemiBold", size: 13))
                                .foregroundColor(Color("TextPrimary"))

                            Text("(\(service.reviewCount.formatted()) reviews)")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }

                    Spacer()
                }

                // Provider Count
                HStack(spacing: 4) {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("TextTertiary"))

                    Text("\(service.providerCount) providers nearby")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))
                }

                // CTA
                Text("View Details")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color("PrimaryTeal"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color("PrimaryTeal").opacity(0.1))
                    .cornerRadius(8)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("BorderLight"), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ServiceResult: Identifiable {
    let id: String
    let icon: String
    let name: String
    let description: String
    let minPrice: Double
    let maxPrice: Double
    let rating: Double
    let reviewCount: Int
    let providerCount: Int
}
```

### 5. Provider Result Card
```swift
struct ProviderResultCard: View {
    let provider: ProviderResult
    let onBook: () -> Void
    let onViewProfile: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                // Profile Photo
                AsyncImage(url: URL(string: provider.photoURL ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Circle()
                        .fill(Color("BackgroundSecondary"))
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("TextTertiary"))
                        )
                }
                .frame(width: 56, height: 56)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(provider.name)
                            .font(.custom("Inter-SemiBold", size: 16))
                            .foregroundColor(Color("TextPrimary"))

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color("SecondaryOrange"))

                            Text(String(format: "%.1f", provider.rating))
                                .font(.custom("Inter-SemiBold", size: 14))
                                .foregroundColor(Color("TextPrimary"))
                        }
                    }

                    Text(provider.specialization)
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()
            }

            // Badges
            HStack(spacing: 8) {
                if provider.isVerified {
                    Badge(icon: "checkmark.shield.fill", text: "Verified", color: Color("SuccessGreen"))
                }

                Badge(icon: "briefcase.fill", text: "\(provider.yearsExperience)+ years exp", color: Color("PrimaryTeal"))
            }

            // Stats
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("SuccessGreen"))

                    Text("\(provider.jobsCompleted) jobs")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))
                }

                Text("•")
                    .foregroundColor(Color("TextTertiary"))

                Text("₹ \(provider.minPrice.formatted()) - ₹ \(provider.maxPrice.formatted())")
                    .font(.custom("Inter-SemiBold", size: 13))
                    .foregroundColor(Color("PrimaryTeal"))
            }

            Divider()

            // Location & Availability
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextTertiary"))

                        Text(String(format: "%.1f km away", provider.distance))
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextSecondary"))
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .font(.system(size: 12))
                            .foregroundColor(provider.availabilityColor)

                        Text(provider.availability)
                            .font(.custom("Inter-Medium", size: 12))
                            .foregroundColor(provider.availabilityColor)
                    }
                }

                Spacer()

                Button(action: onBook) {
                    Text("Book Now")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color("PrimaryTeal"))
                        .cornerRadius(8)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        .onTapGesture {
            onViewProfile()
        }
    }
}

struct Badge: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10))
            Text(text)
                .font(.custom("Inter-Medium", size: 11))
        }
        .foregroundColor(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct ProviderResult: Identifiable {
    let id: String
    let name: String
    let photoURL: String?
    let specialization: String
    let rating: Double
    let isVerified: Bool
    let yearsExperience: Int
    let jobsCompleted: Int
    let minPrice: Double
    let maxPrice: Double
    let distance: Double
    let availability: String

    var availabilityColor: Color {
        if availability.contains("today") {
            return Color("SuccessGreen")
        } else if availability.contains("tomorrow") {
            return Color("WarningYellow")
        } else {
            return Color("TextTertiary")
        }
    }
}
```

## API Integration

```
GET /search

Query Parameters:
- q: "electrician" (search query)
- tab: "all" | "services" | "providers"
- lat: 28.6139
- lng: 77.2090
- filters: {
    "nearMe": true,
    "minPrice": 0,
    "maxPrice": 5000,
    "minRating": 4.0,
    "availability": "today",
    "verifiedOnly": true
  }
- sort: "recommended" | "distance" | "rating" | "price_low" | "price_high"
- page: 1
- limit: 20

Response:
{
  "success": true,
  "data": {
    "query": "electrician",
    "totalResults": 128,
    "counts": {
      "all": 128,
      "services": 45,
      "providers": 83
    },
    "suggestions": ["electrician", "electrical repair", "wiring"],
    "services": [ /* service results */ ],
    "providers": [ /* provider results */ ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 7,
      "hasMore": true
    }
  }
}
```

## Navigation

- From Home (Screen 03) → Search Results
- Tap Service Card → Service Detail (Screen 05)
- Tap Provider Card → Provider Profile
- Tap "Book Now" → Booking Flow (Screen 08)
- Back → Return to Home

## Testing Checklist

- [ ] Search query displays correctly
- [ ] Tabs switch between All/Services/Providers
- [ ] Filters apply correctly
- [ ] Sort options work
- [ ] Service cards navigate to detail
- [ ] Provider cards navigate to profile
- [ ] "Book Now" starts booking flow
- [ ] Infinite scroll loads more results
- [ ] No results state shows suggestions
- [ ] Spell check suggests corrections
- [ ] Recent searches appear

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
