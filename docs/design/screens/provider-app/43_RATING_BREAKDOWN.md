# Screen 43: Rating Breakdown

## Overview

- **Screen ID**: 43
- **Screen Name**: Rating Breakdown
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 41 (Performance Metrics) → Tap rating category
  - From: Screen 42 (Customer Reviews) → Tap "View Rating Breakdown"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Rating Breakdown            🔍 ⋮    │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │         ⭐ 4.8                  │    │ Overall Rating
│  │      Overall Rating             │    │
│  │                                 │    │
│  │  ★★★★★ (127 reviews)            │    │
│  │                                 │    │
│  │  Time Period: [Last 30 Days ▼]  │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Rating Distribution ─────        │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★★★ 5 Stars                  │    │ Distribution Card
│  │ ████████████████░░░░░░░░  67%  │    │
│  │ 85 reviews                      │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★★☆ 4 Stars                  │    │
│  │ ████░░░░░░░░░░░░░░░░░░░░  22%  │    │
│  │ 28 reviews                      │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★★☆☆ 3 Stars                  │    │
│  │ ██░░░░░░░░░░░░░░░░░░░░░░   8%  │    │
│  │ 10 reviews                      │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★★☆☆☆ 2 Stars                  │    │
│  │ ░░░░░░░░░░░░░░░░░░░░░░░░   2%  │    │
│  │ 3 reviews                       │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ★☆☆☆☆ 1 Star                   │    │
│  │ ░░░░░░░░░░░░░░░░░░░░░░░░   1%  │    │
│  │ 1 review                        │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Category Breakdown ─────         │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Quality of Work         4.9 ⭐ │    │ Category Card
│  │ ████████████████████░  98%     │    │
│  │                                 │    │
│  │ ★★★★★ 102  ★★★★☆ 20            │    │ Mini Distribution
│  │ ★★★☆☆   3  ★★☆☆☆  2            │    │
│  │                                 │    │
│  │ Top Keywords:                   │    │
│  │ [Excellent] [Professional]      │    │ Keyword Tags
│  │ [Thorough] [Skilled]            │    │
│  │                                 │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Punctuality             4.8 ⭐ │    │
│  │ ████████████████████   96%     │    │
│  │                                 │    │
│  │ ★★★★★ 95  ★★★★☆ 22             │    │
│  │ ★★★☆☆  7  ★★☆☆☆  3             │    │
│  │                                 │    │
│  │ Top Keywords:                   │    │
│  │ [On Time] [Early] [Punctual]    │    │
│  │                                 │    │
│  │ ⚠️ 8% late arrivals (10 reviews)│    │ Warning
│  │ Avg delay: 12 minutes           │    │
│  │                                 │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Professionalism         4.7 ⭐ │    │
│  │ ███████████████████░   94%     │    │
│  │                                 │    │
│  │ Top Keywords:                   │    │
│  │ [Polite] [Respectful] [Friendly]│    │
│  │                                 │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Communication           4.6 ⭐ │    │
│  │ ███████████████████    92%     │    │
│  │                                 │    │
│  │ 💡 Improvement Opportunity      │    │ Tip Banner
│  │ 15 customers mentioned slow     │    │
│  │ responses. Try responding       │    │
│  │ within 5 minutes!               │    │
│  │                                 │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Value for Money         4.8 ⭐ │    │
│  │ ████████████████████   96%     │    │
│  │                                 │    │
│  │ Top Keywords:                   │    │
│  │ [Worth It] [Fair Price] [Quality]│   │
│  │                                 │    │
│  │ [View Reviews →]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Rating Trends ─────              │
│                                         │
│  ┌────────────────────────────────┐    │
│  │       📊 Rating Over Time       │    │ Trend Chart
│  │                                 │    │
│  │   5.0 ┤         ╱─╲             │    │
│  │   4.5 ┤    ╱──╯   ╲            │    │
│  │   4.0 ┤───╯         ╲──         │    │
│  │   3.5 ┴─────────────────        │    │
│  │       W1  W2  W3  W4  W5        │    │
│  │                                 │    │
│  │  Current: 4.8 ⭐ ↑ +0.3 (vs prev)│   │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Keywords Analysis ─────          │
│                                         │
│  Positive Keywords (Most Mentioned)     │
│  ┌─────────────────────────────────┐   │
│  │ [Excellent (42)] [Professional (38)]│ Keyword Cloud
│  │ [Punctual (35)] [Quality (32)]  │   │
│  │ [Thorough (28)] [Skilled (25)]  │   │
│  │ [Polite (24)] [Clean (22)]      │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Areas for Improvement (8 mentions)     │
│  ┌─────────────────────────────────┐   │
│  │ [Slow Response (5)] [Late (3)]  │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ───── Comparison ─────                 │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Your Rating vs City Average     │    │ Comparison Card
│  │                                 │    │
│  │ You:          4.8 ⭐             │    │
│  │ City Avg:     4.3 ⭐             │    │
│  │ Difference:  +0.5 ⬆️             │    │
│  │                                 │    │
│  │ 🎉 You're in the Top 15% in Delhi!│  │
│  └────────────────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Overall Rating Summary
- Large rating display (e.g., 4.8 / 5.0)
- Star visualization
- Total review count
- Time period filter (Last 7/30/90 days, All time)

### 2. Rating Distribution
- Breakdown by star rating (5⭐ to 1⭐)
- Percentage and count for each level
- Visual progress bars
- Direct link to view reviews for each rating level

### 3. Category Breakdown
- Detailed view of 5 rating categories:
  - Quality of Work
  - Punctuality
  - Professionalism
  - Communication
  - Value for Money
- Individual rating, percentage, mini distribution
- Top keywords from reviews
- Warnings/tips for categories needing improvement

### 4. Rating Trends Chart
- Line chart showing rating changes over time
- Current vs previous period comparison
- Trend indicator (↑ improving, ↓ declining, → stable)

### 5. Keywords Analysis
- **Positive Keywords**: Most frequently mentioned praise
- **Improvement Areas**: Keywords indicating concerns
- Word count for each keyword
- Color-coded sentiment (green for positive, orange for improvement)

### 6. Comparison with City Average
- Provider's rating vs city average
- Percentile ranking
- Celebration banner if top 10/15/20%

### 7. Actionable Insights
- AI-generated improvement suggestions
- Based on lowest-rated categories
- Specific, actionable recommendations

## Component Breakdown

### 1. Header (Navigation Bar)
```swift
struct RatingBreakdownHeader: View {
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

            Text("Rating Breakdown")
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

### 2. Overall Rating Card
```swift
struct OverallRatingCard: View {
    let rating: Double
    let totalReviews: Int
    @Binding var selectedPeriod: TimePeriod

    var body: some View {
        VStack(spacing: 16) {
            // Rating
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.system(size: 32))
                    .foregroundColor(Color("SecondaryOrange"))

                Text(String(format: "%.1f", rating))
                    .font(.custom("Inter-Bold", size: 48))
                    .foregroundColor(Color("TextPrimary"))
            }

            Text("Overall Rating")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color("TextSecondary"))

            // Star Visualization
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= Int(rating.rounded()) ? "star.fill" : "star")
                        .foregroundColor(Color("SecondaryOrange"))
                        .font(.system(size: 24))
                }
            }

            Text("(\(totalReviews) reviews)")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextTertiary"))

            Divider()
                .padding(.vertical, 4)

            // Time Period Selector
            Menu {
                ForEach(TimePeriod.allCases, id: \.self) { period in
                    Button(action: { selectedPeriod = period }) {
                        HStack {
                            Text(period.rawValue)
                            if selectedPeriod == period {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text("Time Period:")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))

                    Text(selectedPeriod.rawValue)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("PrimaryTeal"))

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(Color("PrimaryTeal"))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            LinearGradient(
                colors: [Color("SecondaryOrange").opacity(0.1), Color("SecondaryOrange").opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}
```

### 3. Rating Distribution Card
```swift
struct RatingDistributionCard: View {
    let stars: Int
    let count: Int
    let percentage: Double
    let totalReviews: Int
    let onViewReviews: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                // Stars
                HStack(spacing: 4) {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= stars ? "star.fill" : "star")
                            .font(.system(size: 16))
                            .foregroundColor(index <= stars ? Color("SecondaryOrange") : Color("TextTertiary"))
                    }
                }

                Text("\(stars) Star\(stars == 1 ? "" : "s")")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                Text("\(Int(percentage))%")
                    .font(.custom("Inter-Bold", size: 16))
                    .foregroundColor(Color("TextPrimary"))
            }

            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("BackgroundSecondary"))
                        .frame(height: 12)

                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                colors: starGradientColors(stars: stars),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * (percentage / 100), height: 12)
                }
            }
            .frame(height: 12)

            // Review Count
            HStack {
                Text("\(count) review\(count == 1 ? "" : "s")")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextTertiary"))

                Spacer()

                Button(action: onViewReviews) {
                    HStack(spacing: 4) {
                        Text("View Reviews")
                            .font(.custom("Inter-SemiBold", size: 13))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
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
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }

    func starGradientColors(stars: Int) -> [Color] {
        switch stars {
        case 5:
            return [Color("SuccessGreen"), Color("SuccessGreen").opacity(0.7)]
        case 4:
            return [Color("PrimaryTeal"), Color("PrimaryTeal").opacity(0.7)]
        case 3:
            return [Color("WarningYellow"), Color("WarningYellow").opacity(0.7)]
        case 2:
            return [Color("SecondaryOrange"), Color("SecondaryOrange").opacity(0.7)]
        case 1:
            return [Color("ErrorRed"), Color("ErrorRed").opacity(0.7)]
        default:
            return [Color("TextTertiary"), Color("TextTertiary").opacity(0.7)]
        }
    }
}
```

### 4. Category Breakdown Card
```swift
struct CategoryBreakdownCard: View {
    let category: CategoryRatingData
    let onViewReviews: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header
            HStack {
                Text(category.name)
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                HStack(spacing: 4) {
                    Text(String(format: "%.1f", category.rating))
                        .font(.custom("Inter-Bold", size: 18))
                        .foregroundColor(Color("TextPrimary"))

                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SecondaryOrange"))
                }
            }

            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color("BackgroundSecondary"))
                        .frame(height: 10)

                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                colors: [Color("PrimaryTeal"), Color("PrimaryTeal").opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * (category.percentage / 100), height: 10)
                }
            }
            .frame(height: 10)

            Text("\(Int(category.percentage))%")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextTertiary"))

            // Mini Distribution
            if !category.distribution.isEmpty {
                Divider()
                    .padding(.vertical, 4)

                VStack(alignment: .leading, spacing: 6) {
                    ForEach(0..<min(2, category.distribution.count / 2 + category.distribution.count % 2), id: \.self) { rowIndex in
                        HStack(spacing: 16) {
                            ForEach(0..<2, id: \.self) { colIndex in
                                let index = rowIndex * 2 + colIndex
                                if index < category.distribution.count {
                                    HStack(spacing: 4) {
                                        HStack(spacing: 2) {
                                            ForEach(1...5, id: \.self) { starIndex in
                                                Image(systemName: starIndex <= category.distribution[index].stars ? "star.fill" : "star")
                                                    .font(.system(size: 8))
                                                    .foregroundColor(starIndex <= category.distribution[index].stars ? Color("SecondaryOrange") : Color("TextTertiary"))
                                            }
                                        }

                                        Text("\(category.distribution[index].count)")
                                            .font(.custom("Inter-Medium", size: 11))
                                            .foregroundColor(Color("TextSecondary"))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                }
            }

            // Keywords
            if !category.topKeywords.isEmpty {
                Divider()
                    .padding(.vertical, 4)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Top Keywords:")
                        .font(.custom("Inter-Medium", size: 12))
                        .foregroundColor(Color("TextSecondary"))

                    FlowLayout(spacing: 8) {
                        ForEach(category.topKeywords, id: \.text) { keyword in
                            Text(keyword.text)
                                .font(.custom("Inter-Medium", size: 12))
                                .foregroundColor(Color("PrimaryTeal"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color("PrimaryTeal").opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                }
            }

            // Improvement Tip (if needed)
            if let tip = category.improvementTip {
                Divider()
                    .padding(.vertical, 4)

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color("WarningYellow"))

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Improvement Opportunity")
                            .font(.custom("Inter-SemiBold", size: 12))
                            .foregroundColor(Color("TextPrimary"))

                        Text(tip)
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextSecondary"))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(10)
                .background(Color("WarningYellow").opacity(0.1))
                .cornerRadius(8)
            }

            // Warning (if applicable, e.g., for Punctuality)
            if let warning = category.warning {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color("ErrorRed"))

                    VStack(alignment: .leading, spacing: 2) {
                        Text(warning.title)
                            .font(.custom("Inter-SemiBold", size: 12))
                            .foregroundColor(Color("ErrorRed"))

                        Text(warning.description)
                            .font(.custom("Inter-Regular", size: 11))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
                .padding(10)
                .background(Color("ErrorRed").opacity(0.1))
                .cornerRadius(8)
            }

            // View Reviews Link
            Button(action: onViewReviews) {
                HStack(spacing: 4) {
                    Text("View Reviews")
                        .font(.custom("Inter-SemiBold", size: 13))
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10))
                }
                .foregroundColor(Color("PrimaryTeal"))
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

struct CategoryRatingData {
    let name: String
    let rating: Double
    let percentage: Double
    let distribution: [MiniDistribution]
    let topKeywords: [Keyword]
    var improvementTip: String?
    var warning: WarningInfo?
}

struct MiniDistribution {
    let stars: Int
    let count: Int
}

struct Keyword {
    let text: String
    let count: Int
}

struct WarningInfo {
    let title: String
    let description: String
}

// FlowLayout for keyword tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: ProposedViewSize(result.frames[index].size))
        }
    }

    struct FlowResult {
        var frames: [CGRect] = []
        var size: CGSize = .zero

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                frames.append(CGRect(origin: CGPoint(x: currentX, y: currentY), size: size))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }

            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}
```

### 5. Rating Trends Chart
```swift
struct RatingTrendsChart: View {
    let trendData: [TrendDataPoint]
    let currentRating: Double
    let change: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("📊 Rating Over Time")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            // Chart (Using Charts framework iOS 16+)
            Chart(trendData) { dataPoint in
                LineMark(
                    x: .value("Period", dataPoint.label),
                    y: .value("Rating", dataPoint.value)
                )
                .foregroundStyle(Color("PrimaryTeal"))
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))

                PointMark(
                    x: .value("Period", dataPoint.label),
                    y: .value("Rating", dataPoint.value)
                )
                .foregroundStyle(Color("PrimaryTeal"))
                .symbolSize(50)
            }
            .frame(height: 150)
            .chartYScale(domain: 3.5...5.0)
            .chartXAxis {
                AxisMarks(position: .bottom) { value in
                    AxisValueLabel()
                        .font(.custom("Inter-Regular", size: 10))
                        .foregroundStyle(Color("TextTertiary"))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisValueLabel()
                        .font(.custom("Inter-Regular", size: 10))
                        .foregroundStyle(Color("TextTertiary"))
                }
            }

            // Current Rating & Change
            HStack {
                Text("Current:")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                HStack(spacing: 4) {
                    Text(String(format: "%.1f", currentRating))
                        .font(.custom("Inter-Bold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color("SecondaryOrange"))
                }

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: change >= 0 ? "arrow.up" : "arrow.down")
                        .font(.system(size: 12))
                        .foregroundColor(change >= 0 ? Color("SuccessGreen") : Color("ErrorRed"))

                    Text(String(format: "%+.1f", change))
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(change >= 0 ? Color("SuccessGreen") : Color("ErrorRed"))

                    Text("(vs prev)")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }
            }
        }
        .padding(16)
        .background(Color("BackgroundSecondary"))
        .cornerRadius(12)
    }
}

struct TrendDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}
```

### 6. Keywords Analysis Section
```swift
struct KeywordsAnalysisSection: View {
    let positiveKeywords: [Keyword]
    let improvementKeywords: [Keyword]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Positive Keywords
            VStack(alignment: .leading, spacing: 12) {
                Text("Positive Keywords (Most Mentioned)")
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                FlowLayout(spacing: 10) {
                    ForEach(positiveKeywords, id: \.text) { keyword in
                        HStack(spacing: 6) {
                            Text(keyword.text)
                                .font(.custom("Inter-Medium", size: 13))

                            Text("(\(keyword.count))")
                                .font(.custom("Inter-Regular", size: 11))
                        }
                        .foregroundColor(Color("SuccessGreen"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color("SuccessGreen").opacity(0.1))
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color("SuccessGreen").opacity(0.3), lineWidth: 1)
                        )
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

            // Improvement Areas
            if !improvementKeywords.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Areas for Improvement (\(improvementKeywords.reduce(0) { $0 + $1.count }) mentions)")
                        .font(.custom("Inter-SemiBold", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    FlowLayout(spacing: 10) {
                        ForEach(improvementKeywords, id: \.text) { keyword in
                            HStack(spacing: 6) {
                                Text(keyword.text)
                                    .font(.custom("Inter-Medium", size: 13))

                                Text("(\(keyword.count))")
                                    .font(.custom("Inter-Regular", size: 11))
                            }
                            .foregroundColor(Color("WarningYellow"))
                            .padding(.horizontal: 12)
                            .padding(.vertical, 7)
                            .background(Color("WarningYellow").opacity(0.1))
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color("WarningYellow").opacity(0.3), lineWidth: 1)
                            )
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
            }
        }
    }
}
```

### 7. Comparison Card
```swift
struct ComparisonCard: View {
    let yourRating: Double
    let cityAverage: Double
    let percentile: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Your Rating vs City Average")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            // Ratings Comparison
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("You:")
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))

                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", yourRating))
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("PrimaryTeal"))

                        Image(systemName: "star.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color("SecondaryOrange"))
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("City Avg:")
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))

                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", cityAverage))
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("TextSecondary"))

                        Image(systemName: "star.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color("TextTertiary"))
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text("Difference:")
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))

                    HStack(spacing: 4) {
                        Text(String(format: "%+.1f", yourRating - cityAverage))
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(yourRating > cityAverage ? Color("SuccessGreen") : Color("ErrorRed"))

                        Text(yourRating > cityAverage ? "⬆️" : "⬇️")
                            .font(.system(size: 18))
                    }
                }
            }

            Divider()
                .padding(.vertical, 4)

            // Percentile Badge
            if percentile >= 85 {
                HStack(spacing: 8) {
                    Text("🎉")
                        .font(.system(size: 24))

                    Text("You're in the Top \(100 - percentile)% in Delhi!")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("SuccessGreen"))
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color("SuccessGreen").opacity(0.1))
                .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryTeal").opacity(0.3), lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 3)
    }
}
```

## Interactions

### 1. Change Time Period
- **Trigger**: Tap time period dropdown
- **Action**: Show period selector menu
- **Visual**: Menu with checkmark on selected
- **Haptic**: Light impact
- **Result**: Refresh all data for selected period

### 2. View Reviews by Rating Level
- **Trigger**: Tap "View Reviews →" on a distribution card (e.g., 5 Stars)
- **Action**: Navigate to Screen 42 with filter pre-applied
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 3. View Reviews by Category
- **Trigger**: Tap "View Reviews →" on a category card
- **Action**: Navigate to Screen 42, filter by category keyword
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 4. Tap Keyword
- **Trigger**: Tap a keyword tag (e.g., "Excellent")
- **Action**: Navigate to Screen 42, search for that keyword
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 5. View Trend Details
- **Trigger**: Tap on a data point in the trend chart
- **Action**: Show tooltip with exact rating and date
- **Visual**: Tooltip popup above point
- **Haptic**: Light impact

### 6. Search from Header
- **Trigger**: Tap search icon
- **Action**: Navigate to Screen 42 with search active
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 7. Pull to Refresh
- **Trigger**: Pull down on scroll view
- **Action**: Refresh all rating data
- **Visual**: Standard iOS refresh control
- **Haptic**: None

## States

### 1. Default State (With Data)
- Overall rating card
- 5 distribution cards (5⭐ to 1⭐)
- 5 category breakdown cards
- Rating trends chart
- Keywords analysis
- Comparison card

### 2. Loading State
- Skeleton shimmer for all cards
- Chart placeholder with loading animation

### 3. No Data State (New Provider)
```
┌─────────────────────────────────────────┐
│                                         │
│          📊 (Illustration)              │
│                                         │
│      No Rating Data Yet                 │
│                                         │
│   Complete jobs and receive reviews     │
│   to see your detailed rating breakdown │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │      Find Jobs                   │  │
│   └─────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

### 4. Insufficient Data State
- Show overall rating but message: "Need at least 10 reviews for detailed breakdown"
- Display what data is available
- Encourage completing more jobs

## API Integration

### 1. Get Rating Breakdown
```
GET /providers/{providerId}/rating-breakdown

Query Parameters:
- period: "7d" | "30d" | "90d" | "all"

Headers:
- Authorization: Bearer {firebase_id_token}

Response:
{
  "success": true,
  "data": {
    "overall": {
      "rating": 4.8,
      "totalReviews": 127
    },
    "distribution": [
      { "stars": 5, "count": 85, "percentage": 66.9 },
      { "stars": 4, "count": 28, "percentage": 22.0 },
      { "stars": 3, "count": 10, "percentage": 7.9 },
      { "stars": 2, "count": 3, "percentage": 2.4 },
      { "stars": 1, "count": 1, "percentage": 0.8 }
    ],
    "categories": [
      {
        "name": "Quality of Work",
        "rating": 4.9,
        "percentage": 98,
        "distribution": [
          { "stars": 5, "count": 102 },
          { "stars": 4, "count": 20 },
          { "stars": 3, "count": 3 },
          { "stars": 2, "count": 2 }
        ],
        "topKeywords": [
          { "text": "Excellent", "count": 42 },
          { "text": "Professional", "count": 38 },
          { "text": "Thorough", "count": 28 }
        ],
        "improvementTip": null,
        "warning": null
      },
      {
        "name": "Punctuality",
        "rating": 4.8,
        "percentage": 96,
        "distribution": [
          { "stars": 5, "count": 95 },
          { "stars": 4, "count": 22 },
          { "stars": 3, "count": 7 },
          { "stars": 2, "count": 3 }
        ],
        "topKeywords": [
          { "text": "On Time", "count": 35 },
          { "text": "Early", "count": 28 },
          { "text": "Punctual", "count": 25 }
        ],
        "improvementTip": null,
        "warning": {
          "title": "8% late arrivals (10 reviews)",
          "description": "Avg delay: 12 minutes"
        }
      },
      {
        "name": "Communication",
        "rating": 4.6,
        "percentage": 92,
        "distribution": [
          { "stars": 5, "count": 80 },
          { "stars": 4, "count": 30 },
          { "stars": 3, "count": 12 },
          { "stars": 2, "count": 5 }
        ],
        "topKeywords": [
          { "text": "Responsive", "count": 25 },
          { "text": "Clear", "count": 20 }
        ],
        "improvementTip": "15 customers mentioned slow responses. Try responding within 5 minutes!",
        "warning": null
      }
      // ... other categories
    ],
    "trends": {
      "data": [
        { "label": "W1", "value": 4.6 },
        { "label": "W2", "value": 4.7 },
        { "label": "W3", "value": 4.9 },
        { "label": "W4", "value": 4.7 },
        { "label": "W5", "value": 4.8 }
      ],
      "change": 0.3 // vs previous period
    },
    "keywords": {
      "positive": [
        { "text": "Excellent", "count": 42 },
        { "text": "Professional", "count": 38 },
        { "text": "Punctual", "count": 35 }
        // ... more
      ],
      "improvement": [
        { "text": "Slow Response", "count": 5 },
        { "text": "Late", "count": 3 }
      ]
    },
    "comparison": {
      "yourRating": 4.8,
      "cityAverage": 4.3,
      "difference": 0.5,
      "percentile": 85
    }
  }
}
```

## Navigation

### Entry Points
1. **From Screen 41** (Performance Metrics):
   - Tap any rating category → Navigate to Rating Breakdown

2. **From Screen 42** (Customer Reviews):
   - Tap "View Rating Breakdown" → Navigate to Rating Breakdown

### Exit Points
1. **Back Button**: Return to previous screen
2. **View Reviews** (on distribution/category cards): Navigate to Screen 42 with filters
3. **Search**: Navigate to Screen 42 with search active

### Deep Links
- `urbannest://provider/rating-breakdown` → Rating Breakdown
- `urbannest://provider/rating-breakdown?category=punctuality` → Scroll to specific category

## Accessibility

### VoiceOver Labels
- "Back to previous screen"
- "Overall rating: 4.8 out of 5 stars, 127 reviews"
- "Time period: Last 30 Days, double-tap to change"
- "5 stars: 85 reviews, 67%, view reviews button"
- "Quality of Work: 4.9 out of 5, 98%"
- "Top keyword: Excellent, mentioned 42 times"
- "Improvement tip: 15 customers mentioned slow responses"
- "Your rating: 4.8, City average: 4.3, You are 0.5 points above average"

### Dynamic Type
- All text scales with system font size
- Charts maintain readability
- Keyword tags reflow

### Color Contrast
- All text meets WCAG AA (4.5:1)
- Progress bars use high-contrast colors
- Chart data points distinguishable

## Analytics Events

### Track Screen View
```javascript
analytics.logEvent('screen_view', {
  screen_name: 'rating_breakdown',
  screen_class: 'RatingBreakdownView',
  user_role: 'provider'
});
```

### Track Period Change
```javascript
analytics.logEvent('rating_breakdown_period_changed', {
  from_period: '30d',
  to_period: '90d'
});
```

### Track Category View
```javascript
analytics.logEvent('rating_category_reviews_viewed', {
  category: 'punctuality',
  category_rating: 4.8
});
```

### Track Keyword Tap
```javascript
analytics.logEvent('rating_keyword_tapped', {
  keyword: 'excellent',
  keyword_count: 42,
  sentiment: 'positive'
});
```

## Testing Checklist

### Functional Tests
- [ ] Load rating breakdown data correctly
- [ ] Display overall rating and distribution
- [ ] Show all 5 categories with details
- [ ] Display rating trends chart
- [ ] Show keywords analysis
- [ ] Display comparison with city average
- [ ] Filter by time period
- [ ] Navigate to reviews from distribution cards
- [ ] Navigate to reviews from category cards
- [ ] Search from keyword tags
- [ ] Pull to refresh updates data

### UI/UX Tests
- [ ] Progress bars fill correctly based on percentages
- [ ] Chart displays data points clearly
- [ ] Keyword tags wrap properly (FlowLayout)
- [ ] Improvement tips appear for relevant categories
- [ ] Warning banners show for issues (e.g., late arrivals)
- [ ] Comparison card highlights top percentile
- [ ] Color coding for sentiment (green/yellow/red)

### Edge Cases
- [ ] No reviews yet (empty state)
- [ ] Less than 10 reviews (insufficient data)
- [ ] All 5-star reviews (100%)
- [ ] All 1-star reviews (0%)
- [ ] No improvement keywords (all positive)
- [ ] Very long category names (truncate)
- [ ] Chart with only 1 data point
- [ ] Network error during load

### Accessibility Tests
- [ ] VoiceOver announces all elements
- [ ] Dynamic Type scales correctly
- [ ] Color contrast meets WCAG AA
- [ ] Touch targets minimum 44pt

### Performance Tests
- [ ] Screen loads within 1.5 seconds
- [ ] Chart renders smoothly
- [ ] Smooth scrolling with all cards
- [ ] No lag when switching periods

## Design Notes

### Rating Calculation Formula
```
Overall Rating = (Sum of all individual ratings) / (Total number of reviews)

Category Rating = (Sum of all ratings for that category) / (Total reviews with that category)

Percentage = (Category Rating / 5.0) * 100
```

### Keyword Extraction
- Extract keywords from review text using NLP
- Count frequency across all reviews
- Sentiment analysis (positive vs improvement areas)
- Exclude common words (the, is, was, etc.)
- Minimum 3 mentions to appear in analysis

### Comparison Logic
- City average calculated from all active providers in the city
- Percentile rank: Provider's position among all providers
- Top 10% = Percentile ≥ 90
- Top 15% = Percentile ≥ 85
- Top 20% = Percentile ≥ 80

### Improvement Tips Generation
- AI-generated based on lowest-rated categories
- Specific, actionable recommendations
- Updated weekly based on recent reviews
- Priority: High (< 4.0), Medium (4.0-4.5), Low (> 4.5)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
