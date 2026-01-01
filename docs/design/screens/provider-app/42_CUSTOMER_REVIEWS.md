# Screen 42: Customer Reviews

## Overview

- **Screen ID**: 42
- **Screen Name**: Customer Reviews
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 41 (Performance Metrics) → Tap "View All Reviews"
  - From: Screen 23 (Provider Dashboard) → Tap "Reviews" section
  - From: Screen 35 (Service Completed Success) → Tap "View Your Reviews"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Customer Reviews            🔍 ⋮    │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │    ⭐ 4.8 / 5.0                 │    │ Rating Summary Card
│  │    127 Total Reviews            │    │
│  │                                 │    │
│  │  ★★★★★ 85 (67%)  ████████░░    │    │ Rating Distribution
│  │  ★★★★☆ 28 (22%)  ████░░░░░░    │    │
│  │  ★★★☆☆ 10 (8%)   ██░░░░░░░░    │    │
│  │  ★★☆☆☆  3 (2%)   ░░░░░░░░░░    │    │
│  │  ★☆☆☆☆  1 (1%)   ░░░░░░░░░░    │    │
│  │                                 │    │
│  │  [View Rating Breakdown →]      │    │
│  └────────────────────────────────┘    │
│                                         │
│  Filters: [All ▼] [5⭐] [4⭐] [3⭐] [≤2⭐]│ Filter Pills
│  Sort by: [Most Recent ▼]              │ Sort Dropdown
│                                         │
│  ───────── This Week (3) ─────────      │ Date Section
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★★★ 5.0                       │    │ Review Card
│  │                                 │    │
│  │ "Excellent work! Very punctual  │    │
│  │  and professional. Highly       │    │
│  │  recommend!"                    │    │
│  │                                 │    │
│  │ Sarah K.                        │    │
│  │ AC Repair • Dec 29, 2025        │    │
│  │                                 │    │
│  │ Quality: ★★★★★ Punctual: ★★★★★ │    │ Category Ratings
│  │                                 │    │
│  │ 👍 3  Helpful review             │    │ Helpful votes
│  │                                 │    │
│  │ [💬 Reply]    [⚠️ Report]        │    │ Actions
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★★★ 5.0                       │    │
│  │                                 │    │
│  │ "Great service, done in 30 mins!"│   │
│  │                                 │    │
│  │ Rahul M.                        │    │
│  │ Plumbing • Dec 28, 2025         │    │
│  │                                 │    │
│  │ [💬 Reply]    [⚠️ Report]        │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★★☆ 4.0                       │    │ Lower Rating Card
│  │                                 │    │
│  │ "Good work but arrived 15 mins  │    │
│  │  late. Otherwise satisfied."    │    │
│  │                                 │    │
│  │ Priya S.                        │    │
│  │ Electrical • Dec 27, 2025       │    │
│  │                                 │    │
│  │ Quality: ★★★★★ Punctual: ★★★☆☆ │    │
│  │                                 │    │
│  │ 💬 Your Reply (Dec 27):         │    │ Your Reply
│  │ "Thank you for your feedback.   │    │
│  │  Sorry for the delay due to     │    │
│  │  traffic. Will improve!"        │    │
│  │                                 │    │
│  │ [⚠️ Report]                      │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───────── Last Week (8) ─────────      │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★★★ 5.0                       │    │
│  │ "Amazing! Fixed the issue..."   │    │
│  │ Amit P. • Cleaning • Dec 22     │    │
│  │ [💬 Reply]    [⚠️ Report]        │    │
│  └────────────────────────────────┘    │
│                                         │
│  [Load More Reviews]                    │
│                                         │
└─────────────────────────────────────────┘

REPLY TO REVIEW MODAL:

┌─────────────────────────────────────────┐
│         Reply to Review            ✕    │
├─────────────────────────────────────────┤
│                                         │
│  ★★★★☆ 4.0                              │
│                                         │
│  "Good work but arrived 15 mins late.   │
│   Otherwise satisfied."                 │
│                                         │
│  — Priya S., Dec 27, 2025               │
│                                         │
│  ─────────────────────────────────      │
│                                         │
│  Your Reply                             │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Thank you for your feedback.    │    │ Text Area
│  │ Sorry for the delay due to      │    │
│  │ traffic. Will improve!          │    │
│  │                                 │    │
│  │                                 │    │
│  │                                 │    │
│  └────────────────────────────────┘    │
│  0 / 500 characters                     │
│                                         │
│  💡 Tips for responding:                │
│  • Thank the customer                   │
│  • Address their concerns               │
│  • Be professional and courteous        │
│  • Keep it brief and to the point       │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Post Reply                  │   │ Primary Button
│  └─────────────────────────────────┘   │
│                                         │
│  Note: Your reply will be publicly      │
│  visible to all customers               │
│                                         │
└─────────────────────────────────────────┘

REPORT REVIEW MODAL:

┌─────────────────────────────────────────┐
│         Report Review              ✕    │
├─────────────────────────────────────────┤
│                                         │
│  Why are you reporting this review?     │
│                                         │
│  ○ Inappropriate language               │
│  ○ False or misleading information      │
│  ○ Spam or advertisement                │
│  ○ Personal attack or harassment        │
│  ○ Not related to the service           │
│  ○ Other (please specify)               │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Additional details (optional)   │    │ Text Area
│  │                                 │    │
│  │                                 │    │
│  └────────────────────────────────┘    │
│                                         │
│  ⚠️ Abuse of reporting may result in    │
│     account suspension                  │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Submit Report               │   │ Primary Button
│  └─────────────────────────────────┘   │
│                                         │
│  [Cancel]                               │
│                                         │
└─────────────────────────────────────────┘

EMPTY STATE (NO REVIEWS):

┌─────────────────────────────────────────┐
│                                         │
│          ⭐ (Illustration)               │
│                                         │
│      No Reviews Yet                     │
│                                         │
│   Complete your first job to receive    │
│   reviews from customers                │
│                                         │
│   Great reviews help you:               │
│   • Get more job requests               │
│   • Earn higher ratings                 │
│   • Build customer trust                │
│   • Unlock achievement badges           │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │      Find Jobs                   │  │
│   └─────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Rating Summary Card
- Overall rating (e.g., 4.8 / 5.0)
- Total review count
- Star rating distribution (5⭐ to 1⭐)
- Visual progress bars showing percentage
- Link to detailed rating breakdown (Screen 43)

### 2. Filter & Sort Options
- **Filter by Rating**:
  - All (default)
  - 5 Stars only
  - 4 Stars only
  - 3 Stars only
  - 2 Stars or below
- **Sort by**:
  - Most Recent (default)
  - Highest Rating
  - Lowest Rating
  - Most Helpful

### 3. Review Cards
- Star rating (visual + numeric)
- Review text
- Customer name (first name + last initial)
- Service category
- Review date
- Category-specific ratings (Quality, Punctuality, etc.)
- Helpful votes count
- Reply button
- Report button

### 4. Provider Replies
- Reply to individual reviews
- Edit/delete own replies (within 24 hours)
- Publicly visible to all customers
- Character limit: 500
- Professional response tips

### 5. Review Actions
- **Reply**: Open reply modal, post public response
- **Report**: Report inappropriate/false reviews
- **Mark Helpful**: Customers can mark provider replies as helpful (not provider themselves)

### 6. Date Grouping
- This Week
- Last Week
- This Month
- Earlier (by month)

### 7. Search Reviews
- Search by customer name
- Search by keywords in review text
- Search by service category

## Component Breakdown

### 1. Header (Navigation Bar)
```swift
struct CustomerReviewsHeader: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingSearch: Bool
    @Binding var showingMenu: Bool

    var body: some View {
        HStack {
            // Back Button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            Text("Customer Reviews")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            // Search Button
            Button(action: { showingSearch = true }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            // Menu Button
            Button(action: { showingMenu = true }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
```

### 2. Rating Summary Card
```swift
struct RatingSummaryCard: View {
    let overallRating: Double
    let totalReviews: Int
    let distribution: [RatingDistribution]
    let onViewBreakdown: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Overall Rating
            HStack(spacing: 8) {
                Image(systemName: "star.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color("SecondaryOrange"))

                Text(String(format: "%.1f", overallRating))
                    .font(.custom("Inter-Bold", size: 36))
                    .foregroundColor(Color("TextPrimary"))

                Text("/ 5.0")
                    .font(.custom("Inter-Regular", size: 18))
                    .foregroundColor(Color("TextTertiary"))
            }

            Text("\(totalReviews) Total Reviews")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))

            Divider()
                .padding(.vertical, 4)

            // Distribution
            VStack(spacing: 8) {
                ForEach(distribution.sorted(by: { $0.stars > $1.stars })) { item in
                    RatingDistributionRow(item: item)
                }
            }

            // View Breakdown Link
            Button(action: onViewBreakdown) {
                HStack(spacing: 6) {
                    Text("View Rating Breakdown")
                        .font(.custom("Inter-SemiBold", size: 14))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                }
                .foregroundColor(Color("PrimaryTeal"))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color("PrimaryTeal").opacity(0.1))
                .cornerRadius(20)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
    }
}

struct RatingDistribution: Identifiable {
    let id = UUID()
    let stars: Int
    let count: Int
    let percentage: Double
}

struct RatingDistributionRow: View {
    let item: RatingDistribution

    var body: some View {
        HStack(spacing: 12) {
            // Stars
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= item.stars ? "star.fill" : "star")
                        .font(.system(size: 12))
                        .foregroundColor(index <= item.stars ? Color("SecondaryOrange") : Color("TextTertiary"))
                }
            }
            .frame(width: 80, alignment: .leading)

            // Count & Percentage
            Text("\(item.count)")
                .font(.custom("Inter-Medium", size: 12))
                .foregroundColor(Color("TextSecondary"))
                .frame(width: 30, alignment: .trailing)

            Text("(\(Int(item.percentage))%)")
                .font(.custom("Inter-Regular", size: 11))
                .foregroundColor(Color("TextTertiary"))
                .frame(width: 40, alignment: .leading)

            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("BackgroundSecondary"))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("SecondaryOrange"))
                        .frame(width: geometry.size.width * (item.percentage / 100), height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}
```

### 3. Filter & Sort Bar
```swift
struct ReviewFilterSortBar: View {
    @Binding var selectedFilter: RatingFilter
    @Binding var selectedSort: SortOption

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Filter Pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(RatingFilter.allCases, id: \.self) { filter in
                        Button(action: { selectedFilter = filter }) {
                            HStack(spacing: 6) {
                                if filter != .all {
                                    Text(filter.icon)
                                        .font(.system(size: 12))
                                }
                                Text(filter.displayName)
                                    .font(.custom("Inter-Medium", size: 14))
                            }
                            .foregroundColor(selectedFilter == filter ? Color("PrimaryTeal") : Color("TextSecondary"))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(selectedFilter == filter ? Color("PrimaryTeal").opacity(0.1) : Color("BackgroundSecondary"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(selectedFilter == filter ? Color("PrimaryTeal") : Color.clear, lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }

            // Sort Dropdown
            HStack {
                Text("Sort by:")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                Menu {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Button(action: { selectedSort = option }) {
                            HStack {
                                Text(option.rawValue)
                                if selectedSort == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedSort.rawValue)
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
    }
}

enum RatingFilter: CaseIterable {
    case all, fiveStar, fourStar, threeStar, lowRating

    var displayName: String {
        switch self {
        case .all: return "All"
        case .fiveStar: return "5⭐"
        case .fourStar: return "4⭐"
        case .threeStar: return "3⭐"
        case .lowRating: return "≤2⭐"
        }
    }

    var icon: String {
        switch self {
        case .all: return ""
        case .fiveStar: return "★★★★★"
        case .fourStar: return "★★★★"
        case .threeStar: return "★★★"
        case .lowRating: return "★★"
        }
    }
}

enum SortOption: String, CaseIterable {
    case mostRecent = "Most Recent"
    case highestRating = "Highest Rating"
    case lowestRating = "Lowest Rating"
    case mostHelpful = "Most Helpful"
}
```

### 4. Review Card
```swift
struct ReviewCard: View {
    let review: Review
    let onReply: () -> Void
    let onReport: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Rating Stars
            HStack(spacing: 6) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= review.rating ? "star.fill" : "star")
                        .font(.system(size: 16))
                        .foregroundColor(index <= review.rating ? Color("SecondaryOrange") : Color("TextTertiary"))
                }

                Text(String(format: "%.1f", Double(review.rating)))
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()
            }

            // Review Text
            Text(review.text)
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextPrimary"))
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            // Customer Info
            HStack(spacing: 8) {
                Text(review.customerName)
                    .font(.custom("Inter-SemiBold", size: 13))
                    .foregroundColor(Color("TextSecondary"))

                Text("•")
                    .foregroundColor(Color("TextTertiary"))

                Text(review.serviceCategory)
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextTertiary"))

                Text("•")
                    .foregroundColor(Color("TextTertiary"))

                Text(review.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextTertiary"))
            }

            // Category Ratings (if available)
            if !review.categoryRatings.isEmpty {
                Divider()
                    .padding(.vertical, 4)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(review.categoryRatings, id: \.category) { item in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.category)
                                    .font(.custom("Inter-Regular", size: 11))
                                    .foregroundColor(Color("TextTertiary"))

                                HStack(spacing: 2) {
                                    ForEach(1...5, id: \.self) { index in
                                        Image(systemName: index <= item.rating ? "star.fill" : "star")
                                            .font(.system(size: 10))
                                            .foregroundColor(index <= item.rating ? Color("SecondaryOrange") : Color("TextTertiary"))
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Helpful Votes (if any)
            if review.helpfulVotes > 0 {
                HStack(spacing: 6) {
                    Image(systemName: "hand.thumbsup")
                        .font(.system(size: 12))
                        .foregroundColor(Color("TextTertiary"))

                    Text("\(review.helpfulVotes) Helpful review")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }
            }

            // Provider Reply (if exists)
            if let reply = review.providerReply {
                Divider()
                    .padding(.vertical, 4)

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 6) {
                        Image(systemName: "bubble.left.fill")
                            .font(.system(size: 12))
                            .foregroundColor(Color("PrimaryTeal"))

                        Text("Your Reply (\(reply.date.formatted(date: .abbreviated, time: .omitted))):")
                            .font(.custom("Inter-SemiBold", size: 12))
                            .foregroundColor(Color("PrimaryTeal"))
                    }

                    Text(reply.text)
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))
                        .padding(12)
                        .background(Color("PrimaryTeal").opacity(0.05))
                        .cornerRadius(8)
                }
            }

            Divider()
                .padding(.vertical, 4)

            // Actions
            HStack(spacing: 16) {
                if review.providerReply == nil {
                    Button(action: onReply) {
                        HStack(spacing: 6) {
                            Image(systemName: "bubble.left")
                            Text("Reply")
                        }
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("PrimaryTeal"))
                    }
                }

                Spacer()

                Button(action: onReport) {
                    HStack(spacing: 6) {
                        Image(systemName: "exclamationmark.triangle")
                        Text("Report")
                    }
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("ErrorRed"))
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
    }
}

struct Review: Identifiable {
    let id: String
    let rating: Int
    let text: String
    let customerName: String
    let serviceCategory: String
    let date: Date
    let categoryRatings: [CategoryRating]
    let helpfulVotes: Int
    var providerReply: Reply?
}

struct CategoryRating {
    let category: String
    let rating: Int
}

struct Reply {
    let text: String
    let date: Date
}
```

### 5. Reply to Review Modal
```swift
struct ReplyToReviewModal: View {
    let review: Review
    @Environment(\.dismiss) var dismiss
    @State private var replyText = ""
    @StateObject private var viewModel: ReviewsViewModel
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Original Review
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= review.rating ? "star.fill" : "star")
                                    .font(.system(size: 14))
                                    .foregroundColor(index <= review.rating ? Color("SecondaryOrange") : Color("TextTertiary"))
                            }
                        }

                        Text("\"\(review.text)\"")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("TextSecondary"))
                            .italic()

                        Text("— \(review.customerName), \(review.date.formatted(date: .abbreviated, time: .omitted))")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextTertiary"))
                    }
                    .padding(12)
                    .background(Color("BackgroundSecondary"))
                    .cornerRadius(8)

                    Divider()

                    // Reply Text Area
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Reply")
                            .font(.custom("Inter-SemiBold", size: 16))
                            .foregroundColor(Color("TextPrimary"))

                        ZStack(alignment: .topLeading) {
                            if replyText.isEmpty {
                                Text("Write your response here...")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(Color("TextTertiary"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                            }

                            TextEditor(text: $replyText)
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(Color("TextPrimary"))
                                .frame(minHeight: 120)
                                .padding(8)
                                .focused($isTextFieldFocused)
                        }
                        .background(Color("BackgroundSecondary"))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isTextFieldFocused ? Color("PrimaryTeal") : Color("BorderLight"), lineWidth: 1)
                        )

                        HStack {
                            Spacer()
                            Text("\(replyText.count) / 500 characters")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(replyText.count > 500 ? Color("ErrorRed") : Color("TextTertiary"))
                        }
                    }

                    // Tips
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 14))
                                .foregroundColor(Color("WarningYellow"))

                            Text("Tips for responding:")
                                .font(.custom("Inter-SemiBold", size: 13))
                                .foregroundColor(Color("TextPrimary"))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            TipRow(text: "Thank the customer")
                            TipRow(text: "Address their concerns")
                            TipRow(text: "Be professional and courteous")
                            TipRow(text: "Keep it brief and to the point")
                        }
                    }
                    .padding(12)
                    .background(Color("WarningYellow").opacity(0.1))
                    .cornerRadius(8)

                    // Submit Button
                    Button(action: { viewModel.submitReply(reviewId: review.id, text: replyText) }) {
                        HStack {
                            if viewModel.isSubmitting {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                            Text(viewModel.isSubmitting ? "Posting..." : "Post Reply")
                        }
                        .font(.custom("Inter-SemiBold", size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .background(isReplyValid ? Color("PrimaryTeal") : Color("DisabledGray"))
                        .cornerRadius(8)
                    }
                    .disabled(!isReplyValid || viewModel.isSubmitting)

                    // Notice
                    HStack(spacing: 6) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextTertiary"))

                        Text("Your reply will be publicly visible to all customers")
                            .font(.custom("Inter-Regular", size: 11))
                            .foregroundColor(Color("TextTertiary"))
                    }
                    .padding(.top, 8)
                }
                .padding(16)
            }
            .navigationTitle("Reply to Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
            }
        }
        .onAppear {
            isTextFieldFocused = true
        }
    }

    var isReplyValid: Bool {
        !replyText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        replyText.count <= 500
    }
}

struct TipRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            Text("•")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))

            Text(text)
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))
        }
    }
}
```

## Interactions

### 1. Filter Reviews
- **Trigger**: Tap filter pill (All, 5⭐, 4⭐, 3⭐, ≤2⭐)
- **Action**: Filter review list by selected rating
- **Visual**: Active pill highlighted in teal
- **Haptic**: Light impact
- **Result**: List updates to show only matching reviews

### 2. Sort Reviews
- **Trigger**: Tap sort dropdown
- **Action**: Show sort options menu
- **Visual**: Checkmark on selected option
- **Haptic**: Light impact
- **Result**: Reorder review list

### 3. Reply to Review
- **Trigger**: Tap "Reply" button on review card
- **Action**: Open reply modal
- **Visual**: Modal slides up with keyboard
- **Haptic**: Medium impact
- **Steps**:
  1. Type reply (max 500 chars)
  2. View tips for responding
  3. Tap "Post Reply"
  4. Show loading state
  5. Close modal on success
  6. Show reply on review card
- **Validation**: Cannot be empty, max 500 chars

### 4. Report Review
- **Trigger**: Tap "Report" button on review card
- **Action**: Open report modal
- **Visual**: Alert-style modal
- **Haptic**: Warning (heavy impact)
- **Steps**:
  1. Select reason (radio buttons)
  2. Optional: Add details
  3. Tap "Submit Report"
  4. Show confirmation
- **Result**: Review flagged for admin review

### 5. Search Reviews
- **Trigger**: Tap search icon in header
- **Action**: Show search bar
- **Visual**: Search bar slides down, keyboard appears
- **Haptic**: Light impact
- **Search**: By customer name, keywords, service category

### 6. View Rating Breakdown
- **Trigger**: Tap "View Rating Breakdown" link
- **Action**: Navigate to Screen 43 (Rating Breakdown)
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 7. Load More Reviews
- **Trigger**: Scroll to bottom, tap "Load More"
- **Action**: Fetch next page of reviews (pagination)
- **Visual**: Loading indicator
- **Haptic**: None

### 8. Pull to Refresh
- **Trigger**: Pull down on scroll view
- **Action**: Refresh reviews list
- **Visual**: Standard iOS refresh control
- **Haptic**: None

## States

### 1. Default State (With Reviews)
- Rating summary card at top
- Filter pills and sort dropdown
- Reviews grouped by date sections
- Load more button if more reviews available

### 2. Empty State (No Reviews)
```
Illustration: ⭐
"No Reviews Yet"
Explanation + benefits of reviews
"Find Jobs" CTA
```

### 3. Loading State
- Skeleton shimmer for summary card
- 3-5 skeleton review cards
- Shimmer animation

### 4. Filtered State (No Results)
```
"No reviews match your filters"
"Try selecting different criteria"
[Clear Filters] button
```

### 5. Search Results State
- Search bar visible at top
- Results filtered as user types
- "No results for '[query]'" if empty
- Clear search (X) button

### 6. Reply Posted State
- Review card updated with provider reply
- Reply highlighted in teal box
- "Reply" button hidden (already replied)

### 7. Review Reported State
- Subtle indicator: "Reported • Under review"
- Report button disabled
- Admin notified in backend

## API Integration

### 1. Get Reviews
```
GET /providers/{providerId}/reviews

Query Parameters:
- rating: 1-5 | null (filter by rating)
- sort: "recent" | "highest" | "lowest" | "helpful"
- page: number (pagination)
- limit: number (default: 20)
- search: string | null

Headers:
- Authorization: Bearer {firebase_id_token}

Response:
{
  "success": true,
  "data": {
    "summary": {
      "overallRating": 4.8,
      "totalReviews": 127,
      "distribution": [
        { "stars": 5, "count": 85, "percentage": 67 },
        { "stars": 4, "count": 28, "percentage": 22 },
        { "stars": 3, "count": 10, "percentage": 8 },
        { "stars": 2, "count": 3, "percentage": 2 },
        { "stars": 1, "count": 1, "percentage": 1 }
      ]
    },
    "reviews": [
      {
        "id": "rev_abc123",
        "rating": 5,
        "text": "Excellent work! Very punctual and professional. Highly recommend!",
        "customerName": "Sarah K.",
        "customerInitials": "SK",
        "serviceCategory": "AC Repair",
        "bookingId": "booking_xyz789",
        "createdAt": "2025-12-29T14:30:00Z",
        "categoryRatings": [
          { "category": "Quality", "rating": 5 },
          { "category": "Punctual", "rating": 5 },
          { "category": "Professional", "rating": 5 }
        ],
        "helpfulVotes": 3,
        "providerReply": null,
        "isReported": false
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 7,
      "totalRecords": 127,
      "hasMore": true
    }
  }
}
```

### 2. Reply to Review
```
POST /providers/{providerId}/reviews/{reviewId}/reply

Headers:
- Authorization: Bearer {firebase_id_token}
- Content-Type: application/json

Request:
{
  "text": "Thank you for your feedback. Sorry for the delay due to traffic. Will improve!"
}

Response:
{
  "success": true,
  "data": {
    "reply": {
      "id": "reply_def456",
      "text": "Thank you for your feedback...",
      "createdAt": "2025-12-30T10:15:00Z"
    }
  },
  "message": "Reply posted successfully"
}
```

### 3. Report Review
```
POST /providers/{providerId}/reviews/{reviewId}/report

Request:
{
  "reason": "inappropriate_language", // or "false_info", "spam", "harassment", "unrelated", "other"
  "details": "Additional context..." // optional
}

Response:
{
  "success": true,
  "message": "Review reported successfully. Our team will review it within 24 hours."
}
```

### 4. Search Reviews
```
GET /providers/{providerId}/reviews/search

Query Parameters:
- q: string (search query)
- limit: number

Response:
{
  "success": true,
  "data": {
    "results": [ /* matching reviews */ ],
    "totalResults": 12
  }
}
```

## Navigation

### Entry Points
1. **From Screen 41** (Performance Metrics):
   - Tap "View All Reviews" → Navigate to Customer Reviews

2. **From Screen 23** (Provider Dashboard):
   - Tap "Reviews" section → Navigate to Customer Reviews

3. **From Screen 35** (Service Completed Success):
   - Tap "View Your Reviews" → Navigate to Customer Reviews

### Exit Points
1. **Back Button**: Return to previous screen
2. **View Rating Breakdown**: Navigate to Screen 43 (Rating Breakdown)
3. **Find Jobs** (empty state): Navigate to Screen 24 (Job Requests)

### Deep Links
- `urbannest://provider/reviews` → Customer Reviews List
- `urbannest://provider/reviews/{id}` → Scroll to specific review

## Accessibility

### VoiceOver Labels
- "Back to previous screen" (back button)
- "Search reviews" (search icon)
- "Overall rating: 4.8 out of 5 stars, based on 127 reviews"
- "Rating distribution: 5 stars, 85 reviews, 67%"
- "Filter by all ratings, selected" / "Filter by 5 stars, not selected"
- "Sort by: Most Recent, double-tap to change"
- "Review from Sarah K., 5 stars, AC Repair, December 29"
- "Review text: Excellent work! Very punctual and professional."
- "Reply to review button"
- "Report review button"
- "Your reply: Thank you for your feedback..."

### Dynamic Type
- All text scales with system font size
- Review cards expand vertically for larger text
- Minimum touch targets: 44x44pt

### Color Contrast
- All text meets WCAG AA (4.5:1)
- Star ratings: Orange on white background (high contrast)
- Reply box: Teal background with dark text

## Analytics Events

### Track Screen View
```javascript
analytics.logEvent('screen_view', {
  screen_name: 'customer_reviews',
  screen_class: 'CustomerReviewsView',
  user_role: 'provider'
});
```

### Track Filter Usage
```javascript
analytics.logEvent('reviews_filtered', {
  filter_type: 'rating',
  filter_value: '5_stars'
});
```

### Track Reply
```javascript
analytics.logEvent('review_reply_posted', {
  review_id: 'rev_abc123',
  review_rating: 4,
  reply_length: 85
});
```

### Track Report
```javascript
analytics.logEvent('review_reported', {
  review_id: 'rev_abc123',
  report_reason: 'inappropriate_language'
});
```

## Testing Checklist

### Functional Tests
- [ ] Load reviews correctly
- [ ] Display rating summary with distribution
- [ ] Filter by rating (All, 5⭐, 4⭐, 3⭐, ≤2⭐)
- [ ] Sort by recent, highest, lowest, helpful
- [ ] Reply to review (post and display)
- [ ] Report review (submit and confirm)
- [ ] Search reviews by keyword
- [ ] Load more reviews (pagination)
- [ ] Pull to refresh
- [ ] View rating breakdown navigation
- [ ] Empty state for no reviews
- [ ] Filtered empty state

### UI/UX Tests
- [ ] Rating stars display correctly
- [ ] Progress bars animate smoothly
- [ ] Date sections group reviews
- [ ] Reply modal keyboard appears
- [ ] Character count updates in real-time
- [ ] Replied reviews show provider response
- [ ] Skeleton loading during fetch

### Edge Cases
- [ ] No reviews yet (new provider)
- [ ] Only 1 review
- [ ] All 5-star reviews
- [ ] All 1-star reviews
- [ ] Very long review text (truncate/expand)
- [ ] Reply exceeds 500 characters
- [ ] Network error during reply
- [ ] Already replied to review (hide reply button)
- [ ] Review reported (show indicator)
- [ ] Search with no results

### Accessibility Tests
- [ ] VoiceOver announces all elements
- [ ] Dynamic Type scales correctly
- [ ] Touch targets minimum 44pt
- [ ] Color contrast meets WCAG AA

### Performance Tests
- [ ] List scrolls smoothly with 50+ reviews
- [ ] Reply posts within 2 seconds
- [ ] Search responds instantly
- [ ] No memory leaks on modal open/close

## Design Notes

### Review Moderation
- Customers can review within 7 days of service completion
- Providers can reply anytime, edit within 24 hours
- Reported reviews flagged for admin review (24-48 hours)
- Fake/abusive reviews removed by admin
- Providers cannot delete customer reviews (only report)

### Reply Best Practices
- Respond within 24 hours for best impression
- Thank all reviewers (even negative ones)
- Address concerns professionally
- Avoid defensive or argumentative tone
- Keep replies concise (< 200 chars ideal)
- Never share personal contact info in replies

### Rating Calculation
- Overall rating = Average of all individual ratings
- Category ratings calculated separately
- Weighted by recency (last 30 days count more)
- Minimum 5 reviews required for stable rating display

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
