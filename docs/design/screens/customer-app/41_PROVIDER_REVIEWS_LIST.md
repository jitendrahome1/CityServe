# Screen 41: Provider Reviews List

## Overview

- **Screen ID**: 41
- **Screen Name**: Provider Reviews List
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 07 (Service Detail) → Tap "See all reviews"
  - From: Provider profile card → Tap rating/reviews

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ←  Reviews (456)                       │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │    👤                           │    │ Provider Card
│  │    John Doe                     │    │
│  │    ⭐ 4.8 (456 reviews)         │    │
│  │    Electrician • 8 years exp    │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Rating Summary ─────             │
│                                         │
│  ⭐⭐⭐⭐⭐ 5.0  ████████████ 320 (70%) │ Distribution
│  ⭐⭐⭐⭐   4.0  ██████       95 (21%)  │
│  ⭐⭐⭐     3.0  ██           23 (5%)   │
│  ⭐⭐       2.0  █            14 (3%)   │
│  ⭐         1.0  █             4 (1%)   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ All ▼  │ Most Recent ▼  | 🔍     │   │ Filter Bar
│  └─────────────────────────────────┘   │
│                                         │
│  [All] [5⭐] [4⭐] [3⭐] [≤2⭐]          │ Quick Filters
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👤 Sarah M.        ⭐⭐⭐⭐⭐     │   │ Review Card
│  │  Verified Customer • 2 days ago  │   │
│  │                                  │   │
│  │  Excellent service! Very         │   │
│  │  professional and punctual.      │   │
│  │  Fixed the wiring issue quickly. │   │
│  │                                  │   │
│  │  ┌────┬────┬────┐               │   │ Photos
│  │  │📷  │📷  │📷  │               │   │
│  │  └────┴────┴────┘               │   │
│  │                                  │   │
│  │  🏷️ Professional | Punctual      │   │ Tags
│  │                                  │   │
│  │  👍 Helpful (24)  | 💬 Reply     │   │ Actions
│  │                                  │   │
│  │  💬 Provider Reply:              │   │ Reply
│  │  Thank you for the kind words!   │   │
│  │  - John Doe, 2 days ago          │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👤 Mike T.         ⭐⭐⭐⭐      │   │ Review Card
│  │  Verified Customer • 1 week ago  │   │
│  │                                  │   │
│  │  Good work overall. Arrived on   │   │
│  │  time and completed the job.     │   │
│  │  Would recommend.                │   │
│  │                                  │   │
│  │  🏷️ Quality Work | Skilled       │   │
│  │                                  │   │
│  │  👍 Helpful (12)  | 💬 Reply     │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  👤 Priya K.        ⭐⭐⭐⭐⭐     │   │
│  │  Verified Customer • 2 weeks ago │   │
│  │                                  │   │
│  │  Fantastic experience! Highly    │   │
│  │  skilled and friendly. The work  │   │
│  │  was done perfectly.             │   │
│  │                                  │   │
│  │  ┌────┬────┐                     │   │
│  │  │📷  │📷  │                     │   │
│  │  └────┴────┘                     │   │
│  │                                  │   │
│  │  🏷️ Friendly | Quality Work      │   │
│  │                                  │   │
│  │  👍 Helpful (45)  | 💬 Reply     │   │
│  └─────────────────────────────────┘   │
│                                         │
│  [Load More Reviews]                    │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Provider Summary Card
- Profile photo, name, overall rating
- Total review count
- Service type and experience
- Compact header display

### 2. Rating Distribution
- Visual breakdown of all ratings (5⭐ to 1⭐)
- Horizontal bar charts showing percentage
- Count for each rating level
- Overall rating calculation

### 3. Filter & Sort
- Filter by rating (All, 5⭐, 4⭐, 3⭐, ≤2⭐)
- Sort options:
  - Most Recent (default)
  - Highest Rating
  - Lowest Rating
  - Most Helpful
- Search reviews (keyword search)

### 4. Review Cards
- Customer name (or anonymous)
- Verified customer badge
- Star rating and date
- Review text
- Photos (if uploaded)
- Quick tags
- Helpful votes count
- Reply button
- Provider responses (if any)

### 5. Helpful Votes
- Thumbs up counter
- Tap to mark as helpful
- Single vote per user
- Shows total helpful count

### 6. Provider Replies
- Displayed below review
- Provider name and date
- Expandable for long replies
- Distinct styling (lighter background)

### 7. Photos in Reviews
- Thumbnail grid (max 3 visible)
- Tap to view full size
- Before/after comparison
- Gallery viewer

### 8. Pagination
- Load 10 reviews initially
- "Load More" button
- Infinite scroll option
- Loading skeleton states

## Component Breakdown

```swift
struct ProviderReviewsListView: View {
    @StateObject private var viewModel = ReviewsViewModel()
    let providerId: String

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Provider Card
                ProviderSummaryCard(provider: viewModel.provider)
                    .padding(16)

                // Rating Distribution
                RatingDistributionView(distribution: viewModel.ratingDistribution)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)

                Divider()

                // Filter & Sort Bar
                HStack(spacing: 12) {
                    // Filter Dropdown
                    Menu {
                        ForEach(RatingFilter.allCases, id: \.self) { filter in
                            Button(filter.displayName) {
                                viewModel.selectedFilter = filter
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.selectedFilter.displayName)
                                .font(.custom("Inter-Medium", size: 14))
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(Color("TextPrimary"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color("BackgroundSecondary"))
                        .cornerRadius(8)
                    }

                    // Sort Dropdown
                    Menu {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Button(option.displayName) {
                                viewModel.sortOption = option
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.sortOption.displayName)
                                .font(.custom("Inter-Medium", size: 14))
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(Color("TextPrimary"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color("BackgroundSecondary"))
                        .cornerRadius(8)
                    }

                    Spacer()

                    // Search Button
                    Button(action: { viewModel.showSearch.toggle() }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16))
                            .foregroundColor(Color("TextSecondary"))
                            .frame(width: 36, height: 36)
                            .background(Color("BackgroundSecondary"))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                // Quick Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(QuickFilter.allCases, id: \.self) { filter in
                            FilterPill(
                                title: filter.displayName,
                                isSelected: viewModel.quickFilter == filter,
                                onTap: { viewModel.quickFilter = filter }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 8)

                Divider()

                // Reviews List
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.filteredReviews) { review in
                        ReviewCard(
                            review: review,
                            onHelpful: {
                                viewModel.markHelpful(review)
                            },
                            onReply: {
                                // Navigate to reply/report
                            },
                            onPhotoTap: { index in
                                viewModel.selectedPhoto = review.photos[index]
                                viewModel.showPhotoViewer = true
                            }
                        )
                        .padding(.horizontal, 16)

                        if review.id != viewModel.filteredReviews.last?.id {
                            Divider()
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.vertical, 16)

                // Load More
                if viewModel.hasMoreReviews {
                    Button(action: { viewModel.loadMoreReviews() }) {
                        if viewModel.isLoadingMore {
                            ProgressView()
                                .frame(height: 48)
                        } else {
                            Text("Load More Reviews")
                                .font(.custom("Inter-SemiBold", size: 14))
                                .foregroundColor(Color("PrimaryTeal"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color("PrimaryTeal").opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
            }
        }
        .navigationTitle("Reviews (\(viewModel.totalReviewCount))")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showPhotoViewer) {
            if let photo = viewModel.selectedPhoto {
                PhotoViewerSheet(photoURL: photo)
            }
        }
        .onAppear {
            viewModel.loadReviews(providerId: providerId)
        }
    }
}

struct ProviderSummaryCard: View {
    let provider: Provider

    var body: some View {
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

                    Text("(\(provider.totalReviews) reviews)")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }

                Text("\(provider.serviceName) • \(provider.experienceYears) years exp")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextSecondary"))
            }

            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
    }
}

struct RatingDistributionView: View {
    let distribution: RatingDistribution

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rating Summary")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            VStack(spacing: 6) {
                ForEach([5, 4, 3, 2, 1], id: \.self) { rating in
                    RatingDistributionRow(
                        rating: rating,
                        count: distribution.count(for: rating),
                        percentage: distribution.percentage(for: rating),
                        total: distribution.totalReviews
                    )
                }
            }
        }
    }
}

struct RatingDistributionRow: View {
    let rating: Int
    let count: Int
    let percentage: Double
    let total: Int

    var body: some View {
        HStack(spacing: 8) {
            // Stars
            HStack(spacing: 2) {
                ForEach(0..<rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Color("SecondaryOrange"))
                }
            }
            .frame(width: 60, alignment: .leading)

            Text(String(format: "%.1f", Double(rating)))
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))
                .frame(width: 30, alignment: .leading)

            // Bar Chart
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color("BackgroundSecondary"))
                        .frame(height: 8)
                        .cornerRadius(4)

                    Rectangle()
                        .fill(Color("SecondaryOrange"))
                        .frame(width: geometry.size.width * (percentage / 100), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)

            Text("\(count)")
                .font(.custom("Inter-Medium", size: 12))
                .foregroundColor(Color("TextPrimary"))
                .frame(width: 40, alignment: .trailing)

            Text("(\(Int(percentage))%)")
                .font(.custom("Inter-Regular", size: 11))
                .foregroundColor(Color("TextTertiary"))
                .frame(width: 45, alignment: .trailing)
        }
    }
}

struct ReviewCard: View {
    let review: Review
    let onHelpful: () -> Void
    let onReply: () -> Void
    let onPhotoTap: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                // Customer Avatar
                if let photoURL = review.customerPhotoURL {
                    AsyncImage(url: URL(string: photoURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Circle()
                            .fill(Color("BackgroundSecondary"))
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color("BackgroundSecondary"))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text(review.customerName.prefix(1).uppercased())
                                .font(.custom("Inter-SemiBold", size: 16))
                                .foregroundColor(Color("TextSecondary"))
                        )
                }

                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 8) {
                        Text(review.customerName)
                            .font(.custom("Inter-SemiBold", size: 15))
                            .foregroundColor(Color("TextPrimary"))

                        if review.isVerified {
                            HStack(spacing: 2) {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("SuccessGreen"))
                                Text("Verified")
                                    .font(.custom("Inter-Medium", size: 10))
                                    .foregroundColor(Color("SuccessGreen"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color("SuccessGreen").opacity(0.1))
                            .cornerRadius(4)
                        }
                    }

                    Text(review.timestamp.timeAgoDisplay)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }

                Spacer()

                // Star Rating
                HStack(spacing: 2) {
                    ForEach(0..<review.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundColor(Color("SecondaryOrange"))
                    }
                    ForEach(0..<(5 - review.rating), id: \.self) { _ in
                        Image(systemName: "star")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextTertiary"))
                    }
                }
            }

            // Review Text
            if let reviewText = review.reviewText, !reviewText.isEmpty {
                Text(reviewText)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextPrimary"))
                    .lineSpacing(4)
            }

            // Photos
            if !review.photos.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Array(review.photos.enumerated()), id: \.offset) { index, photoURL in
                            Button(action: { onPhotoTap(index) }) {
                                AsyncImage(url: URL(string: photoURL)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color("BackgroundSecondary"))
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                }
            }

            // Tags
            if !review.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(review.tags, id: \.self) { tag in
                            HStack(spacing: 4) {
                                Image(systemName: "tag.fill")
                                    .font(.system(size: 10))
                                Text(tag)
                                    .font(.custom("Inter-Medium", size: 12))
                            }
                            .foregroundColor(Color("PrimaryTeal"))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color("PrimaryTeal").opacity(0.1))
                            .cornerRadius(6)
                        }
                    }
                }
            }

            // Actions
            HStack(spacing: 16) {
                Button(action: onHelpful) {
                    HStack(spacing: 4) {
                        Image(systemName: review.isHelpful ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.system(size: 14))
                        Text("Helpful (\(review.helpfulCount))")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(review.isHelpful ? Color("PrimaryTeal") : Color("TextSecondary"))
                }

                Button(action: onReply) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.right")
                            .font(.system(size: 14))
                        Text("Reply")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("TextSecondary"))
                }

                Spacer()
            }

            // Provider Reply
            if let reply = review.providerReply {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "bubble.left.fill")
                            .font(.system(size: 12))
                            .foregroundColor(Color("PrimaryTeal"))

                        Text("Provider Reply:")
                            .font(.custom("Inter-SemiBold", size: 13))
                            .foregroundColor(Color("PrimaryTeal"))
                    }

                    Text(reply.text)
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextPrimary"))
                        .lineSpacing(3)

                    Text("- \(reply.providerName), \(reply.timestamp.timeAgoDisplay)")
                        .font(.custom("Inter-Regular", size: 11))
                        .foregroundColor(Color("TextTertiary"))
                }
                .padding(12)
                .background(Color("BackgroundSecondary"))
                .cornerRadius(8)
            }
        }
    }
}

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.custom("Inter-Medium", size: 13))
                .foregroundColor(isSelected ? .white : Color("TextSecondary"))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color("PrimaryTeal") : Color("BackgroundSecondary"))
                .cornerRadius(16)
        }
    }
}

struct RatingDistribution {
    let fiveStar: Int
    let fourStar: Int
    let threeStar: Int
    let twoStar: Int
    let oneStar: Int

    var totalReviews: Int {
        fiveStar + fourStar + threeStar + twoStar + oneStar
    }

    func count(for rating: Int) -> Int {
        switch rating {
        case 5: return fiveStar
        case 4: return fourStar
        case 3: return threeStar
        case 2: return twoStar
        case 1: return oneStar
        default: return 0
        }
    }

    func percentage(for rating: Int) -> Double {
        guard totalReviews > 0 else { return 0 }
        return (Double(count(for: rating)) / Double(totalReviews)) * 100
    }
}

struct Review: Identifiable {
    let id: String
    let customerId: String
    let customerName: String
    let customerPhotoURL: String?
    let rating: Int
    let reviewText: String?
    let photos: [String]
    let tags: [String]
    let timestamp: Date
    let isVerified: Bool
    let helpfulCount: Int
    var isHelpful: Bool
    let providerReply: ProviderReply?
}

struct ProviderReply {
    let text: String
    let providerName: String
    let timestamp: Date
}

enum RatingFilter: CaseIterable {
    case all
    case fiveStar
    case fourStar
    case threeStar
    case twoStarOrLess

    var displayName: String {
        switch self {
        case .all: return "All Ratings"
        case .fiveStar: return "5 Stars"
        case .fourStar: return "4 Stars"
        case .threeStar: return "3 Stars"
        case .twoStarOrLess: return "2 Stars or Less"
        }
    }
}

enum SortOption: CaseIterable {
    case mostRecent
    case highestRating
    case lowestRating
    case mostHelpful

    var displayName: String {
        switch self {
        case .mostRecent: return "Most Recent"
        case .highestRating: return "Highest Rating"
        case .lowestRating: return "Lowest Rating"
        case .mostHelpful: return "Most Helpful"
        }
    }
}

enum QuickFilter: CaseIterable {
    case all
    case fiveStar
    case fourStar
    case threeStar
    case twoStarOrLess

    var displayName: String {
        switch self {
        case .all: return "All"
        case .fiveStar: return "5⭐"
        case .fourStar: return "4⭐"
        case .threeStar: return "3⭐"
        case .twoStarOrLess: return "≤2⭐"
        }
    }
}
```

## Interactions

### Filter & Sort
1. **Tap Filter Dropdown**: Shows menu with rating filters
2. **Tap Sort Dropdown**: Shows menu with sort options
3. **Tap Quick Filter Pill**: Instantly filters reviews
4. **Tap Search Icon**: Opens search sheet for keyword search

### Review Card Actions
1. **Tap Helpful Button**:
   - Increments helpful count
   - Button changes to filled state
   - Haptic feedback
   - API call to record vote

2. **Tap Reply Button**:
   - Opens action sheet
   - Options: "Report Review", "Cancel"
   - Admin reviews reports

3. **Tap Photo Thumbnail**:
   - Opens full-screen photo viewer
   - Swipeable gallery
   - Pinch to zoom
   - Share/download options

4. **Tap Provider Reply**:
   - No action (read-only)
   - Could expand if truncated

### Load More
1. **Tap Load More**: Fetches next 10 reviews
2. **Shows Loading**: Progress indicator
3. **Appends to List**: Smooth scroll
4. **Hides Button**: When all reviews loaded

## States

### Default State
- Provider card with summary
- Rating distribution chart
- Reviews list (10 items)
- Load more button if applicable

### Loading State
```swift
struct ReviewsLoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<3, id: \.self) { _ in
                ReviewCardSkeleton()
            }
        }
        .padding(16)
    }
}
```

### Empty State
```swift
struct EmptyReviewsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "star.bubble")
                .font(.system(size: 60))
                .foregroundColor(Color("TextTertiary"))

            Text("No Reviews Yet")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Text("Be the first to review this provider!")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(48)
    }
}
```

### Error State
```swift
struct ReviewsErrorView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(Color("ErrorRed"))

            Text("Failed to Load Reviews")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            Text("Please check your connection and try again")
                .font(.custom("Inter-Regular", size: 13))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)

            Button(action: onRetry) {
                Text("Retry")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 40)
                    .background(Color("PrimaryTeal"))
                    .cornerRadius(8)
            }
        }
        .padding(48)
    }
}
```

### Filtered State (No Results)
```swift
struct NoMatchingReviewsView: View {
    let filterName: String
    let onClearFilter: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .font(.system(size: 48))
                .foregroundColor(Color("TextTertiary"))

            Text("No \(filterName) Reviews")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            Button("Clear Filters") {
                onClearFilter()
            }
            .font(.custom("Inter-SemiBold", size: 14))
            .foregroundColor(Color("PrimaryTeal"))
        }
        .frame(maxWidth: .infinity)
        .padding(48)
    }
}
```

## API Integration

### Get Reviews List
```
GET /providers/{providerId}/reviews

Query Parameters:
- page: int (default: 1)
- limit: int (default: 10, max: 50)
- rating: int (1-5, optional filter)
- sortBy: string ("recent", "highest", "lowest", "helpful")
- search: string (keyword search, optional)

Response:
{
  "success": true,
  "data": {
    "provider": {
      "id": "prv_123",
      "name": "John Doe",
      "photoURL": "https://...",
      "rating": 4.8,
      "totalReviews": 456,
      "serviceName": "Electrician",
      "experienceYears": 8
    },
    "ratingDistribution": {
      "5": 320,
      "4": 95,
      "3": 23,
      "2": 14,
      "1": 4
    },
    "reviews": [
      {
        "id": "rev_001",
        "customerId": "cust_456",
        "customerName": "Sarah M.",
        "customerPhotoURL": "https://...",
        "rating": 5,
        "reviewText": "Excellent service! Very professional...",
        "photos": [
          "https://storage.../review1.jpg",
          "https://storage.../review2.jpg"
        ],
        "tags": ["Professional", "Punctual"],
        "timestamp": "2025-12-29T10:30:00Z",
        "isVerified": true,
        "helpfulCount": 24,
        "isHelpful": false,
        "providerReply": {
          "text": "Thank you for the kind words!",
          "providerName": "John Doe",
          "timestamp": "2025-12-29T14:00:00Z"
        }
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 46,
      "hasMore": true
    }
  }
}
```

### Mark Review as Helpful
```
POST /reviews/{reviewId}/helpful

Request:
{
  "customerId": "cust_123"
}

Response:
{
  "success": true,
  "data": {
    "helpfulCount": 25,
    "isHelpful": true
  }
}
```

### Search Reviews
```
GET /providers/{providerId}/reviews/search

Query Parameters:
- q: string (search query)
- page: int
- limit: int

Response:
{
  "success": true,
  "data": {
    "results": [...],
    "totalResults": 12,
    "searchQuery": "punctual"
  }
}
```

## Navigation

### Entry Points
- **From Screen 07** (Service Detail): Tap "⭐ 4.8 (456 reviews)" or "See all reviews" link
- **From Provider Profile**: Tap rating section
- **From Search Results**: Tap provider card rating

### Exit Points
- **Back Button**: Return to previous screen
- **Tap Photo**: Open Photo Viewer (modal)
- **Tap Provider Card**: Navigate to full Provider Profile (future screen)

### Deep Linking
```
urbannest://providers/{providerId}/reviews
urbannest://providers/{providerId}/reviews?rating=5
```

## Accessibility

### VoiceOver Labels
```swift
.accessibilityLabel("Review by \(review.customerName), rated \(review.rating) stars")
.accessibilityHint("Double tap to view full review")
.accessibilityElement(children: .combine)
```

### Touch Targets
- Filter/Sort buttons: 44x44pt minimum
- Helpful button: 44x36pt
- Photo thumbnails: 80x80pt (sufficient)
- Quick filter pills: Height 32pt (acceptable for secondary action)

### Dynamic Type
- All text scales with system font size
- Rating distribution bars remain fixed height
- Review cards expand vertically with text

### Color Contrast
- Review text: #1A1A1A on #FFFFFF (21:1 ratio) ✅
- Tag text: #0D7377 on #E6F7F8 (4.8:1 ratio) ✅
- Helpful button: #6B7280 minimum contrast ✅

## Analytics Events

### Screen View
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "provider_reviews_list",
    "provider_id": providerId,
    "total_reviews": totalReviewCount
])
```

### Filter Applied
```swift
Analytics.logEvent("reviews_filter_applied", parameters: [
    "filter_type": "rating",
    "filter_value": "5_star",
    "provider_id": providerId
])
```

### Sort Changed
```swift
Analytics.logEvent("reviews_sort_changed", parameters: [
    "sort_option": "most_helpful",
    "provider_id": providerId
])
```

### Mark Helpful
```swift
Analytics.logEvent("review_marked_helpful", parameters: [
    "review_id": reviewId,
    "provider_id": providerId,
    "review_rating": rating
])
```

### Photo Viewed
```swift
Analytics.logEvent("review_photo_viewed", parameters: [
    "review_id": reviewId,
    "photo_index": photoIndex,
    "provider_id": providerId
])
```

### Load More
```swift
Analytics.logEvent("reviews_load_more", parameters: [
    "current_page": currentPage,
    "provider_id": providerId
])
```

## Testing Checklist

- [ ] Reviews list loads correctly with pagination
- [ ] Rating distribution chart calculates percentages accurately
- [ ] Filter by rating works (all options)
- [ ] Sort options apply correctly (recent, highest, lowest, helpful)
- [ ] Quick filter pills highlight and filter properly
- [ ] Mark helpful increments count and updates button state
- [ ] Cannot mark helpful more than once per review
- [ ] Provider replies display correctly
- [ ] Photos open in full-screen viewer
- [ ] Photo gallery swipes correctly
- [ ] Load more button fetches next page
- [ ] Empty state shows when no reviews
- [ ] Error state shows on API failure
- [ ] Filtered empty state shows when no matches
- [ ] Search functionality works
- [ ] VoiceOver announces reviews correctly
- [ ] Dynamic Type scales text properly
- [ ] Pull-to-refresh reloads reviews
- [ ] Deep links navigate correctly
- [ ] Back button returns to previous screen

## Design Notes

### Platform-Specific Considerations

**iOS**:
- Use native `Menu` for filter/sort dropdowns
- Pull-to-refresh with native gesture
- Photos open in native photo viewer with pan-to-dismiss
- Haptic feedback on "Helpful" tap

**Android**:
- Use Material DropdownMenu for filters
- Swipe-to-refresh with Material design
- Photos open with Activity transition
- Ripple effect on button taps

**Web**:
- Custom dropdown components (Radix UI)
- Click-based interactions (no gestures)
- Lightbox for photo viewing
- Keyboard navigation support (Tab, Enter, Escape)

### Performance Optimization
- Lazy load reviews (10 at a time)
- Cache images with AsyncImage
- Virtualized list for large review counts
- Debounce search input (300ms delay)

### Edge Cases
- Handle anonymous reviews (no photo, generic avatar)
- Truncate long review text (show "Read more")
- Show placeholder for deleted customer accounts
- Handle reviews without photos/tags gracefully

### Future Enhancements
- Filter by keywords from tags
- Sort by "Most Recent from Verified Customers"
- Translation support for multi-language reviews
- Highlight reviews from mutual friends/connections
- Video reviews support

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
