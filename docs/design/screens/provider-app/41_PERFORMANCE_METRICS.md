# Screen 41: Performance Metrics

## Overview

- **Screen ID**: 41
- **Screen Name**: Performance Metrics
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 23 (Provider Dashboard) → Tap "Performance" card
  - From: Screen 48 (Provider App Settings) → Tap "My Performance"
  - From: Screen 42 (Customer Reviews) → Tap "View Metrics"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Performance                  ⓘ  ⋮   │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │         ⭐ 4.8                  │    │ Overall Rating Card
│  │      Overall Rating             │    │
│  │                                 │    │
│  │  ★★★★★ 🔥                       │    │ Stars + Badge
│  │  Based on 127 reviews           │    │
│  │                                 │    │
│  │  [View All Reviews →]           │    │
│  └────────────────────────────────┘    │
│                                         │
│  Time Period: [Last 30 Days ▼]         │ Filter
│                                         │
│  ───── Key Metrics ─────                │
│                                         │
│  ┌─────────────┬─────────────┐         │
│  │ 🎯 156      │ ✅ 98.7%    │         │ Metric Cards
│  │ Jobs        │ Completion  │         │
│  │ Completed   │ Rate        │         │
│  │ ↑ 12% ⬆️    │ ↑ 2.1% ⬆️   │         │
│  └─────────────┴─────────────┘         │
│                                         │
│  ┌─────────────┬─────────────┐         │
│  │ ⚡ 96.2%    │ ❌ 1.3%     │         │
│  │ Acceptance  │ Cancellation│         │
│  │ Rate        │ Rate        │         │
│  │ ↓ 0.8% ⬇️   │ ↓ 0.5% ⬇️   │         │
│  └─────────────┴─────────────┘         │
│                                         │
│  ┌─────────────┬─────────────┐         │
│  │ ⏱️ 42 mins  │ 💯 4.2/5    │         │
│  │ Avg Service │ Punctuality │         │
│  │ Time        │ Score       │         │
│  │ ↓ 5 mins⬇️  │ → 0.0 →     │         │
│  └─────────────┴─────────────┘         │
│                                         │
│  ───── Performance Trends ─────         │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ [Rating ▼] [Last 30 Days ▼]    │    │ Chart Controls
│  │                                 │    │
│  │       📊 Line Chart             │    │ Performance Chart
│  │                                 │    │
│  │   5.0 ┤         ╱─╲             │    │
│  │   4.5 ┤    ╱──╯   ╲            │    │
│  │   4.0 ┤───╯         ╲──         │    │
│  │   3.5 ┤                ╲        │    │
│  │   3.0 ┴─────────────────╲──     │    │
│  │       W1  W2  W3  W4  W5        │    │
│  │                                 │    │
│  │  ● Rating  ● Jobs  ● Earnings   │    │ Legend
│  └────────────────────────────────┘    │
│                                         │
│  ───── Category Breakdown ─────         │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Quality of Work         4.9 ⭐ │    │ Category Rating
│  │ ████████████████████░  98%     │    │
│  │                                 │    │
│  │ Punctuality             4.8 ⭐ │    │
│  │ ████████████████████   96%     │    │
│  │                                 │    │
│  │ Professionalism         4.7 ⭐ │    │
│  │ ███████████████████░   94%     │    │
│  │                                 │    │
│  │ Communication           4.6 ⭐ │    │
│  │ ███████████████████    92%     │    │
│  │                                 │    │
│  │ Value for Money         4.8 ⭐ │    │
│  │ ████████████████████   96%     │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Achievement Badges ─────         │
│                                         │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐      │
│  │ 🏆  │ │ ⚡  │ │ 💯  │ │ 🌟  │      │ Badge Grid
│  │ Top │ │Fast │ │High │ │5-Star│     │
│  │ Pro │ │ Pro │ │ Pro │ │ Pro │      │
│  └─────┘ └─────┘ └─────┘ └─────┘      │
│  Earned: Dec 2025                       │
│                                         │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐      │
│  │ 🎯  │ │ 🔥  │ │ 👑  │ │ 📈  │      │
│  │100+ │ │Hot  │ │Relia│ │Rising│     │
│  │Jobs │ │ Str │ │ ble │ │Star │      │
│  └─────┘ └─────┘ └─────┘ └─────┘      │
│                                         │
│  ───── Improvement Tips ─────           │
│                                         │
│  💡 Opportunities to Improve            │
│                                         │
│  • Respond to job requests faster to   │
│    improve acceptance rate             │
│                                         │
│  • Improve communication score by      │
│    updating customers more frequently  │
│                                         │
│  • Complete 10 more jobs this month    │
│    to earn "Top Pro" badge            │
│                                         │
│  [View Detailed Insights →]            │
│                                         │
└─────────────────────────────────────────┘

DETAIL INFO MODAL:

┌─────────────────────────────────────────┐
│        Performance Info            ✕    │
├─────────────────────────────────────────┤
│                                         │
│  How Ratings Work                       │
│                                         │
│  Your overall rating is calculated from │
│  customer reviews after each completed  │
│  service. Customers rate you on 5       │
│  categories:                            │
│                                         │
│  ⭐ Quality of Work (1-5 stars)         │
│     The quality and thoroughness of     │
│     your service                        │
│                                         │
│  ⏰ Punctuality (1-5 stars)             │
│     Arriving on time for appointments   │
│                                         │
│  🤝 Professionalism (1-5 stars)         │
│     Your conduct and behavior           │
│                                         │
│  💬 Communication (1-5 stars)           │
│     Clarity and responsiveness          │
│                                         │
│  💰 Value for Money (1-5 stars)         │
│     Worth of service relative to cost   │
│                                         │
│  Performance Metrics                    │
│                                         │
│  • Completion Rate: % of accepted jobs  │
│    you successfully completed          │
│                                         │
│  • Acceptance Rate: % of job requests   │
│    you accepted within 5 minutes       │
│                                         │
│  • Cancellation Rate: % of accepted     │
│    jobs you cancelled                  │
│                                         │
│  • Avg Service Time: Average duration   │
│    to complete a job                   │
│                                         │
│  Tips to Improve                        │
│                                         │
│  ✓ Accept jobs quickly (within 1 min)  │
│  ✓ Arrive on time or early             │
│  ✓ Communicate proactively             │
│  ✓ Complete all checklist items        │
│  ✓ Upload quality before/after photos  │
│  ✓ Ask for reviews from happy customers│
│                                         │
│  [Got it]                               │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Overall Rating Display
- Large star rating (e.g., 4.8/5.0)
- Visual star representation (★★★★★)
- Total review count
- Performance badge/emoji (e.g., 🔥 for top performers)
- Link to full reviews (Screen 42)

### 2. Key Metrics Grid
- **Jobs Completed**: Total count with period comparison
- **Completion Rate**: % of accepted jobs completed
- **Acceptance Rate**: % of job requests accepted
- **Cancellation Rate**: % of jobs cancelled
- **Avg Service Time**: Mean duration per job
- **Punctuality Score**: On-time arrival rating
- Each metric shows trend indicator (↑ increase, ↓ decrease, → no change)

### 3. Performance Trends Chart
- Line chart showing performance over time
- Switchable metrics: Rating, Jobs, Earnings
- Time period selector: 7 days, 30 days, 90 days, 12 months
- Interactive tooltips on data points
- Color-coded legend

### 4. Category Breakdown
- 5 rating categories with individual scores
- Progress bars showing percentage
- Visual comparison between categories
- Identify strengths and weaknesses

### 5. Achievement Badges
- Earned badges displayed prominently
- Locked/upcoming badges shown in grayscale
- Badge descriptions on tap
- Earned date display
- Examples:
  - 🏆 Top Pro (Top 10% in city)
  - ⚡ Fast Pro (< 2 min acceptance time)
  - 💯 High Pro (> 98% completion rate)
  - 🌟 5-Star Pro (5.0 rating for 30 days)
  - 🎯 100+ Jobs (Completed 100 jobs)
  - 🔥 Hot Streak (10 consecutive 5-star reviews)

### 6. Improvement Tips
- AI-generated personalized suggestions
- Actionable recommendations
- Based on weakest metrics
- Link to detailed insights/training

### 7. Time Period Filter
- Last 7 days
- Last 30 days (default)
- Last 90 days
- Last 12 months
- All time

## Component Breakdown

### 1. Header (Navigation Bar)
```swift
struct PerformanceMetricsHeader: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingInfo: Bool
    @Binding var showingMenu: Bool

    var body: some View {
        HStack {
            // Back Button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            Text("Performance")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            // Info Button
            Button(action: { showingInfo = true }) {
                Image(systemName: "info.circle")
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
    let badge: PerformanceBadge?
    let onViewReviews: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Rating Number
            HStack(alignment: .firstTextBaseline, spacing: 4) {
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

                if let badge = badge {
                    Text(badge.emoji)
                        .font(.system(size: 28))
                }
            }

            Text("Based on \(totalReviews) reviews")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextTertiary"))

            // View Reviews CTA
            Button(action: onViewReviews) {
                HStack(spacing: 6) {
                    Text("View All Reviews")
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
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("SecondaryOrange").opacity(0.3), lineWidth: 1)
        )
    }
}

struct PerformanceBadge {
    let emoji: String
    let name: String
    let description: String
}
```

### 3. Metric Card
```swift
struct MetricCard: View {
    let icon: String
    let value: String
    let label: String
    let trend: TrendIndicator?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Text(icon)
                    .font(.system(size: 24))
                Text(value)
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(Color("TextPrimary"))
            }

            Text(label)
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))
                .lineLimit(2)

            if let trend = trend {
                HStack(spacing: 4) {
                    Image(systemName: trend.icon)
                        .font(.system(size: 10))
                        .foregroundColor(trend.color)

                    Text(trend.text)
                        .font(.custom("Inter-Medium", size: 11))
                        .foregroundColor(trend.color)

                    Text(trend.direction == .up ? "⬆️" : trend.direction == .down ? "⬇️" : "→")
                        .font(.system(size: 10))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

struct TrendIndicator {
    enum Direction {
        case up, down, neutral
    }

    let value: Double
    let direction: Direction
    let text: String
    let icon: String
    let color: Color

    init(value: Double) {
        self.value = value
        if value > 0 {
            direction = .up
            text = "+\(String(format: "%.1f%%", abs(value)))"
            icon = "arrow.up.right"
            color = Color("SuccessGreen")
        } else if value < 0 {
            direction = .down
            text = "-\(String(format: "%.1f%%", abs(value)))"
            icon = "arrow.down.right"
            color = Color("ErrorRed")
        } else {
            direction = .neutral
            text = "0.0%"
            icon = "arrow.right"
            color = Color("TextTertiary")
        }
    }
}
```

### 4. Performance Trends Chart
```swift
struct PerformanceTrendsChart: View {
    @Binding var selectedMetric: ChartMetric
    @Binding var selectedPeriod: ChartPeriod
    let chartData: [ChartDataPoint]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Controls
            HStack {
                Menu {
                    ForEach(ChartMetric.allCases, id: \.self) { metric in
                        Button(action: { selectedMetric = metric }) {
                            HStack {
                                Text(metric.rawValue)
                                if selectedMetric == metric {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedMetric.rawValue)
                            .font(.custom("Inter-Medium", size: 14))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color("PrimaryTeal").opacity(0.1))
                    .cornerRadius(6)
                }

                Spacer()

                Menu {
                    ForEach(ChartPeriod.allCases, id: \.self) { period in
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
                        Text(selectedPeriod.rawValue)
                            .font(.custom("Inter-Medium", size: 14))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(Color("TextSecondary"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color("BackgroundSecondary"))
                    .cornerRadius(6)
                }
            }

            // Chart (Using Charts framework iOS 16+)
            Chart(chartData) { dataPoint in
                LineMark(
                    x: .value("Period", dataPoint.label),
                    y: .value(selectedMetric.rawValue, dataPoint.value)
                )
                .foregroundStyle(Color("PrimaryTeal"))
                .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))

                PointMark(
                    x: .value("Period", dataPoint.label),
                    y: .value(selectedMetric.rawValue, dataPoint.value)
                )
                .foregroundStyle(Color("PrimaryTeal"))
                .symbolSize(50)
            }
            .frame(height: 200)
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

            // Legend
            HStack(spacing: 16) {
                ForEach(ChartMetric.allCases, id: \.self) { metric in
                    HStack(spacing: 6) {
                        Circle()
                            .fill(metric == selectedMetric ? Color("PrimaryTeal") : Color("TextTertiary").opacity(0.3))
                            .frame(width: 8, height: 8)

                        Text(metric.rawValue)
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(metric == selectedMetric ? Color("TextPrimary") : Color("TextTertiary"))
                    }
                }
            }
        }
        .padding(16)
        .background(Color("BackgroundSecondary"))
        .cornerRadius(12)
    }
}

enum ChartMetric: String, CaseIterable {
    case rating = "Rating"
    case jobs = "Jobs"
    case earnings = "Earnings"
}

enum ChartPeriod: String, CaseIterable {
    case week = "Last 7 Days"
    case month = "Last 30 Days"
    case quarter = "Last 90 Days"
    case year = "Last 12 Months"
}

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}
```

### 5. Category Breakdown Row
```swift
struct CategoryRatingRow: View {
    let category: String
    let rating: Double
    let percentage: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(category)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                HStack(spacing: 4) {
                    Text(String(format: "%.1f", rating))
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("TextPrimary"))

                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("SecondaryOrange"))
                }
            }

            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("BackgroundSecondary"))
                        .frame(height: 8)

                    // Fill
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [Color("PrimaryTeal"), Color("PrimaryTeal").opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * (percentage / 100), height: 8)
                }
            }
            .frame(height: 8)

            Text("\(Int(percentage))%")
                .font(.custom("Inter-Regular", size: 11))
                .foregroundColor(Color("TextTertiary"))
        }
        .padding(.vertical, 8)
    }
}
```

### 6. Achievement Badge
```swift
struct AchievementBadgeView: View {
    let badge: Badge
    let isEarned: Bool

    var body: some View {
        VStack(spacing: 8) {
            // Badge Icon/Emoji
            ZStack {
                Circle()
                    .fill(isEarned ? Color("SecondaryOrange").opacity(0.15) : Color("DisabledGray").opacity(0.1))
                    .frame(width: 60, height: 60)

                Text(badge.emoji)
                    .font(.system(size: 32))
                    .grayscale(isEarned ? 0 : 1)
                    .opacity(isEarned ? 1 : 0.5)
            }

            // Badge Name
            Text(badge.name)
                .font(.custom("Inter-SemiBold", size: 11))
                .foregroundColor(isEarned ? Color("TextPrimary") : Color("TextTertiary"))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 70)

            if isEarned, let earnedDate = badge.earnedDate {
                Text(earnedDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.custom("Inter-Regular", size: 9))
                    .foregroundColor(Color("TextTertiary"))
            }
        }
        .frame(width: 80, height: 100)
        .onTapGesture {
            // Show badge detail modal
        }
    }
}

struct Badge: Identifiable {
    let id = UUID()
    let emoji: String
    let name: String
    let description: String
    let criterion: String
    var earnedDate: Date?
    var isEarned: Bool { earnedDate != nil }
}
```

## Interactions

### 1. View Reviews
- **Trigger**: Tap "View All Reviews" button in overall rating card
- **Action**: Navigate to Screen 42 (Customer Reviews)
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 2. Change Time Period
- **Trigger**: Tap time period dropdown (e.g., "Last 30 Days")
- **Action**: Show period selector menu
- **Visual**: Dropdown menu with checkmark on selected
- **Haptic**: Light impact
- **Result**: Refresh all metrics for selected period

### 3. View Performance Info
- **Trigger**: Tap info icon (ⓘ) in header
- **Action**: Show info modal explaining how ratings work
- **Visual**: Modal slides up from bottom
- **Haptic**: Medium impact

### 4. Switch Chart Metric
- **Trigger**: Tap chart metric dropdown (Rating/Jobs/Earnings)
- **Action**: Update chart to show selected metric
- **Visual**: Animated chart transition
- **Haptic**: Light impact

### 5. Tap Chart Data Point
- **Trigger**: Tap on a data point in the chart
- **Action**: Show tooltip with exact value and date
- **Visual**: Tooltip popup above point
- **Haptic**: Light impact

### 6. View Badge Details
- **Trigger**: Tap on an achievement badge
- **Action**: Show badge detail modal
- **Visual**: Modal with badge criteria, description, progress
- **Haptic**: Medium impact
- **Content**:
  - Badge name and emoji
  - Description of what it represents
  - How to earn it (if not earned)
  - Date earned (if earned)
  - Progress bar (if partially complete)

### 7. View Detailed Insights
- **Trigger**: Tap "View Detailed Insights" link under improvement tips
- **Action**: Navigate to detailed analytics view (future screen)
- **Visual**: Slide-right transition
- **Haptic**: Light impact

### 8. Pull to Refresh
- **Trigger**: Pull down on scroll view
- **Action**: Refresh all performance metrics
- **Visual**: Standard iOS refresh control
- **Haptic**: None

## States

### 1. Default State (With Data)
- Overall rating card at top
- Time period filter showing "Last 30 Days"
- 6 metric cards in 2x3 grid
- Performance trends chart
- Category breakdown with 5 categories
- Achievement badges (earned and locked)
- Improvement tips

### 2. Loading State
- Skeleton shimmer for rating card
- Skeleton cards for metrics (6 placeholders)
- Skeleton chart area
- Skeleton category rows

### 3. No Data State (New Provider)
```
┌─────────────────────────────────────────┐
│                                         │
│          📊 (Illustration)              │
│                                         │
│      Start Building Your Performance!   │
│                                         │
│   Complete your first job to see your   │
│   performance metrics and ratings here  │
│                                         │
│   What you'll see:                      │
│   • Overall rating from customers       │
│   • Completion and acceptance rates     │
│   • Performance trends over time        │
│   • Achievement badges you can earn     │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │      Find Jobs                   │  │
│   └─────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

### 4. Low Rating Warning State
If rating < 3.5, show banner:
```
┌─────────────────────────────────────────┐
│ ⚠️ Your rating is below platform avg    │
│    Take action to improve your score    │
│    [View Tips →]                        │
└─────────────────────────────────────────┘
```

### 5. High Performer State
If rating ≥ 4.8 and top 10% in city:
```
┌─────────────────────────────────────────┐
│ 🎉 You're in the Top 10% in Delhi!      │
│    Keep up the excellent work           │
│    [Share Achievement →]                │
└─────────────────────────────────────────┘
```

## API Integration

### 1. Get Performance Metrics
```
GET /providers/{providerId}/performance

Query Parameters:
- period: "7d" | "30d" | "90d" | "12m" | "all"

Headers:
- Authorization: Bearer {firebase_id_token}

Response:
{
  "success": true,
  "data": {
    "overallRating": 4.8,
    "totalReviews": 127,
    "performanceBadge": {
      "emoji": "🔥",
      "name": "Hot Pro",
      "description": "Top 10% in your city"
    },
    "metrics": {
      "jobsCompleted": {
        "value": 156,
        "trend": 12.5, // percentage change from previous period
        "label": "Jobs Completed"
      },
      "completionRate": {
        "value": 98.7,
        "trend": 2.1,
        "label": "Completion Rate"
      },
      "acceptanceRate": {
        "value": 96.2,
        "trend": -0.8,
        "label": "Acceptance Rate"
      },
      "cancellationRate": {
        "value": 1.3,
        "trend": -0.5,
        "label": "Cancellation Rate"
      },
      "avgServiceTime": {
        "value": 42, // in minutes
        "trend": -11.9, // negative is good here
        "label": "Avg Service Time"
      },
      "punctualityScore": {
        "value": 4.2,
        "trend": 0.0,
        "label": "Punctuality Score"
      }
    },
    "categoryBreakdown": [
      {
        "category": "Quality of Work",
        "rating": 4.9,
        "percentage": 98
      },
      {
        "category": "Punctuality",
        "rating": 4.8,
        "percentage": 96
      },
      {
        "category": "Professionalism",
        "rating": 4.7,
        "percentage": 94
      },
      {
        "category": "Communication",
        "rating": 4.6,
        "percentage": 92
      },
      {
        "category": "Value for Money",
        "rating": 4.8,
        "percentage": 96
      }
    ],
    "chartData": {
      "rating": [
        { "label": "W1", "value": 4.6 },
        { "label": "W2", "value": 4.7 },
        { "label": "W3", "value": 4.9 },
        { "label": "W4", "value": 4.7 },
        { "label": "W5", "value": 4.8 }
      ],
      "jobs": [
        { "label": "W1", "value": 28 },
        { "label": "W2", "value": 32 },
        { "label": "W3", "value": 35 },
        { "label": "W4", "value": 30 },
        { "label": "W5", "value": 31 }
      ],
      "earnings": [
        { "label": "W1", "value": 8500 },
        { "label": "W2", "value": 9200 },
        { "label": "W3", "value": 10100 },
        { "label": "W4", "value": 8900 },
        { "label": "W5", "value": 9400 }
      ]
    },
    "badges": [
      {
        "id": "top_pro",
        "name": "Top Pro",
        "emoji": "🏆",
        "description": "Top 10% of providers in your city",
        "criterion": "Overall rating ≥ 4.8 AND top 10% completion rate",
        "earnedDate": "2025-12-01T00:00:00Z"
      },
      {
        "id": "fast_pro",
        "name": "Fast Pro",
        "emoji": "⚡",
        "description": "Lightning-fast acceptance times",
        "criterion": "Average acceptance time < 2 minutes",
        "earnedDate": null // Not earned yet
      }
      // ... more badges
    ],
    "improvementTips": [
      {
        "category": "acceptance_rate",
        "tip": "Respond to job requests faster to improve acceptance rate",
        "priority": "medium"
      },
      {
        "category": "communication",
        "tip": "Improve communication score by updating customers more frequently",
        "priority": "low"
      },
      {
        "category": "badges",
        "tip": "Complete 10 more jobs this month to earn 'Top Pro' badge",
        "priority": "high"
      }
    ],
    "rankInfo": {
      "cityRank": 42,
      "totalProviders": 420,
      "percentile": 90
    }
  }
}
```

## Navigation

### Entry Points
1. **From Screen 23** (Provider Dashboard):
   - Tap "Performance" card → Navigate to Performance Metrics

2. **From Screen 48** (Provider App Settings):
   - Tap "My Performance" menu item → Navigate to Performance Metrics

3. **From Screen 42** (Customer Reviews):
   - Tap "View Metrics" link → Navigate to Performance Metrics

### Exit Points
1. **Back Button**: Return to previous screen
2. **View All Reviews**: Navigate to Screen 42 (Customer Reviews)
3. **View Detailed Insights**: Navigate to future analytics screen
4. **Find Jobs** (empty state): Navigate to Screen 24 (Job Requests)

### Deep Links
- `urbannest://provider/performance` → Performance Metrics
- `urbannest://provider/performance/badges` → Performance Metrics scrolled to badges

## Accessibility

### VoiceOver Labels
- "Back to previous screen" (back button)
- "Performance information" (info icon)
- "More options menu" (ellipsis)
- "Overall rating: 4.8 out of 5 stars, based on 127 reviews"
- "View all customer reviews button"
- "Time period filter: Last 30 Days, double-tap to change"
- "Jobs completed: 156, up 12.5% from previous period"
- "Completion rate: 98.7%, up 2.1%"
- "Quality of work rating: 4.9 out of 5 stars, 98%"
- "Achievement badge: Top Pro, earned December 2025"
- "Achievement badge: Fast Pro, locked, not yet earned"

### Dynamic Type
- All text scales with system font size
- Metrics grid reflows to single column for larger text
- Chart maintains readability with scaled labels

### Color Contrast
- All text meets WCAG AA (4.5:1 minimum)
- Chart colors distinguishable for colorblind users
- Trend indicators use icons + color (not just color)

## Analytics Events

### Track Screen View
```javascript
analytics.logEvent('screen_view', {
  screen_name: 'performance_metrics',
  screen_class: 'PerformanceMetricsView',
  user_role: 'provider'
});
```

### Track Period Change
```javascript
analytics.logEvent('performance_period_changed', {
  from_period: '30d',
  to_period: '90d'
});
```

### Track Chart Interaction
```javascript
analytics.logEvent('performance_chart_metric_changed', {
  metric: 'earnings', // or 'rating', 'jobs'
  period: '30d'
});
```

### Track Badge View
```javascript
analytics.logEvent('achievement_badge_viewed', {
  badge_id: 'top_pro',
  is_earned: true
});
```

### Track Review Navigation
```javascript
analytics.logEvent('view_reviews_tapped', {
  from_screen: 'performance_metrics',
  total_reviews: 127
});
```

## Testing Checklist

### Functional Tests
- [ ] Load performance metrics correctly
- [ ] Display overall rating accurately
- [ ] Show correct trend indicators (↑↓→)
- [ ] Filter by time period (7d, 30d, 90d, 12m, all)
- [ ] Chart updates when metric/period changes
- [ ] Category breakdown displays correctly
- [ ] Earned badges shown in color
- [ ] Locked badges shown in grayscale
- [ ] Improvement tips displayed
- [ ] Navigate to customer reviews
- [ ] Info modal shows explanation
- [ ] Pull to refresh updates data

### UI/UX Tests
- [ ] Overall rating card prominent
- [ ] Metrics grid layout (2x3)
- [ ] Chart is readable and interactive
- [ ] Progress bars animate smoothly
- [ ] Badge grid aligned properly
- [ ] Empty state displays for new providers
- [ ] Low rating warning appears when rating < 3.5
- [ ] High performer banner for top 10%

### Edge Cases
- [ ] No reviews yet (new provider)
- [ ] Only 1 review (rating may be volatile)
- [ ] 0 jobs completed (show empty state)
- [ ] All metrics at 100% (handle perfectly)
- [ ] All metrics at 0% (handle gracefully)
- [ ] No badges earned (all locked)
- [ ] All badges earned (celebrate!)
- [ ] Chart with single data point
- [ ] Very long category names (truncate)
- [ ] Network error during load

### Accessibility Tests
- [ ] VoiceOver announces all elements
- [ ] Dynamic Type scales correctly
- [ ] Color contrast meets WCAG AA
- [ ] Touch targets minimum 44pt
- [ ] Chart accessible to screen readers

### Performance Tests
- [ ] Screen loads within 1 second
- [ ] Chart renders smoothly (60 FPS)
- [ ] Smooth scrolling with all content
- [ ] No lag when switching metrics/periods
- [ ] No memory leaks

## Design Notes

### Badge Criteria Reference

| Badge | Emoji | Criterion |
|-------|-------|-----------|
| Top Pro | 🏆 | Top 10% in city (rating + completion rate) |
| Fast Pro | ⚡ | Avg acceptance time < 2 min |
| High Pro | 💯 | Completion rate ≥ 98% |
| 5-Star Pro | 🌟 | 5.0 rating for 30+ consecutive days |
| 100+ Jobs | 🎯 | Completed 100+ jobs |
| Hot Streak | 🔥 | 10 consecutive 5-star reviews |
| Reliable Pro | 👑 | Cancellation rate < 1% |
| Rising Star | 📈 | Rating improved by 0.5+ in 30 days |
| Early Bird | 🌅 | 90% punctuality score |
| Customer Favorite | ❤️ | 50+ 5-star reviews |

### Trend Calculation
- Compare current period metrics to previous period of same length
- Example: "Last 30 Days" compares to previous 30 days
- Positive trends (↑) in green for: Rating, Jobs, Completion Rate, Acceptance Rate, Punctuality
- Negative trends (↓) in green for: Cancellation Rate, Service Time
- Display percentage change with 1 decimal precision

### Chart Design
- Use smooth bezier curves (not jagged lines)
- Min 3 data points required for meaningful chart
- Auto-scale Y-axis based on data range
- Show grid lines for easier reading
- Highlight current data point
- Interactive tooltips on touch/hover

### Category Weights
All 5 categories contribute equally to overall rating (20% each):
- Quality of Work: 20%
- Punctuality: 20%
- Professionalism: 20%
- Communication: 20%
- Value for Money: 20%

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
