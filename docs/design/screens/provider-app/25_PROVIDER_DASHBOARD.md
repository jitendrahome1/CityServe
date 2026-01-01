# Provider Dashboard

## Overview
- **Screen ID**: 25
- **Screen Name**: Provider Dashboard
- **User Flow**: Main hub for active providers to manage jobs and view earnings
- **Navigation**:
  - Entry: After activation, app launch (for active providers), bottom tab
  - Exit: To Job Requests, Active Jobs, Earnings, Profile
  - Back: None (root screen)

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  UrbanNest              🔔  👤           │ ← Nav Bar
├──────────────────────────────────────────┤
│                                          │
│  Good morning, Rajesh! 👋                │ ← Greeting
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  🟢 Online                          │ │ ← Availability Toggle
│  │                              [OFF] │ │   (Currently ON)
│  │                                    │ │
│  │  You're ready to accept jobs       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Today's Summary                      │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  ┌──────┐  ┌──────┐  ┌──────┐    │ │
│  │  │  3   │  │  1   │  │ ₹850 │    │ │ ← Stat Cards
│  │  │Jobs  │  │Active│  │Earned│    │ │
│  │  │Done  │  │      │  │Today │    │ │
│  │  └──────┘  └──────┘  └──────┘    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💼 New Job Requests (2)                 │ ← Section Header
│  ┌────────────────────────────────────┐ │
│  │  🔧 AC Repair & Service             │ │ ← Job Card 1
│  │                                    │ │
│  │  📍 Koramangala                    │ │
│  │  📅 Today • 2:00 PM - 3:30 PM      │ │
│  │  💰 ₹650                           │ │
│  │                                    │ │
│  │  ⏰ Respond in 8 minutes            │ │ ← Countdown
│  │                                    │ │
│  │  ┌──────────┐  ┌──────────┐       │ │
│  │  │ Decline  │  │  Accept  │       │ │ ← Action Buttons
│  │  └──────────┘  └──────────┘       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  💡 Electrical Work                 │ │ ← Job Card 2
│  │                                    │ │
│  │  📍 Indiranagar                    │ │
│  │  📅 Tomorrow • 10:00 AM            │ │
│  │  💰 ₹450                           │ │
│  │                                    │ │
│  │  ⏰ Respond in 12 minutes           │ │
│  │                                    │ │
│  │  ┌──────────┐  ┌──────────┐       │ │
│  │  │ Decline  │  │  Accept  │       │ │
│  │  └──────────┘  └──────────┘       │ │
│  └────────────────────────────────────┘ │
│                                          │
│         View All Requests (5)           │ ← View All Link
│                                          │
│  🔥 Active Jobs (1)                      │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  🚿 Plumbing Service                │ │ ← Active Job Card
│  │  Starting in 45 minutes             │ │
│  │                                    │ │
│  │  📍 HSR Layout • #BK789012         │ │
│  │  👤 Amit Kumar                     │ │
│  │                                    │ │
│  │  ┌────────────────────────────────││ │
│  │  │  View Details & Navigate    → ││ │ ← View CTA
│  │  └────────────────────────────────││ │
│  └────────────────────────────────────┘ │
│                                          │
│  📈 Quick Stats                          │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  This Week                         │ │ ← Weekly Stats
│  │  • 12 jobs completed               │ │
│  │  • ₹8,450 earned                   │ │
│  │  • ⭐ 4.8 avg rating                │ │
│  │                                    │ │
│  │  [View Detailed Analytics]         │ │
│  └────────────────────────────────────┘ │
│                                          │
├──────────────────────────────────────────┤
│  🏠   💼   💰   👤                       │ ← Bottom Tab Bar
│ Home  Jobs Earnings Profile             │
│(selected)                                │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt
- **Safe Area Bottom**: 49pt (tab bar) + 34pt = 83pt
- **Content Width**: 358pt (16pt padding)

### Navigation Bar
- **Height**: 56pt
- **Background**: White / Dark (#2A2A2A)
- **Logo**: "UrbanNest" Inter Bold 18pt, #0D7377
- **Bell Icon**: 24x24pt, #666666, badge if notifications
- **Profile Icon**: 32x32pt circular photo
- **Padding**: 16pt horizontal

### Greeting
- **Typography**: Inter SemiBold 22pt, #1E1E1E / #E0E0E0
- **Icon**: 32x32pt emoji
- **Margin**: 24pt top, 20pt bottom
- **Padding**: 0 16pt

### Availability Toggle Card
- **Background**: Based on status
  - Online: #E8F7E8 / #1E3D1E (dark)
  - Offline: #F5F5F5 / #2A2A2A
- **Border Radius**: 12pt
- **Border**: 1pt solid (green if online, gray if offline)
- **Padding**: 16pt
- **Margin**: 0 16pt 20pt 16pt

#### Toggle Content
- **Status Indicator**: 12x12pt circle.fill
  - Online: #28C76F
  - Offline: #999999
- **Status Text**: Inter SemiBold 17pt, #28C76F or #999999
- **Toggle Switch**:
  - iOS native UISwitch
  - Tint: #28C76F
  - Right-aligned
- **Description**: SF Pro Regular 13pt, #666666, 4pt top margin

### Today's Summary Card
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 20pt 16pt

#### Stat Cards (Grid of 3)
- **Layout**: Horizontal, equal width, 12pt gap
- **Individual Card**:
  - Background: #F5F5F5 / #1E1E1E
  - Border Radius: 8pt
  - Padding: 12pt vertical

  **Value**:
  - Typography: Inter Bold 28pt
  - Color: #0D7377

  **Label**:
  - Typography: SF Pro Regular 12pt
  - Color: #666666 / #A0A0A0
  - Multi-line, center aligned
  - Margin Top: 4pt

### Section Headers
- **Typography**: Inter SemiBold 18pt
- **Color**: #1E1E1E / #E0E0E0
- **Icon**: 24x24pt emoji, 8pt gap
- **Badge**: Count in parentheses, SF Pro Medium 16pt, #0D7377
- **Margin**: 28pt top, 12pt bottom
- **Padding**: 0 16pt

### Job Request Card
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Left Border**: 4pt solid #0D7377 (accent)
- **Padding**: 16pt
- **Margin**: 0 16pt 16pt 16pt
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)

#### Job Card Content
- **Service Icon**: 28x28pt emoji
- **Service Name**: Inter SemiBold 17pt, #1E1E1E
- **Location**: 14x14pt mappin + SF Pro Regular 14pt, #666666
- **Date/Time**: 14x14pt calendar/clock + SF Pro Regular 14pt, #666666
- **Price**: Inter Bold 20pt, #0D7377, "₹" symbol
- **Line Spacing**: 8pt between rows

#### Countdown Timer
- **Background**: #FFF4E6 / #3D2E1E (warning tint)
- **Border Radius**: 6pt
- **Padding**: 8pt
- **Icon**: 14x14pt clock.fill, #FF6B35
- **Text**: Inter Medium 13pt, #FF6B35
- **Margin**: 12pt top

#### Action Buttons
- **Height**: 44pt
- **Border Radius**: 8pt
- **Gap**: 12pt
- **Layout**: Two equal-width buttons

**Decline Button**:
- Background: White / Dark (#3A3A3A)
- Border: 1pt solid #E0E0E0 / #3A3A3A
- Text: Inter Medium 15pt, #666666

**Accept Button**:
- Background: #0D7377
- Text: Inter Medium 15pt, White
- Icon: 16x16pt checkmark.circle

### Active Job Card
- **Background**: #E8F7F8 / #1E3D3D (primary tint)
- **Border Radius**: 12pt
- **Border**: 1pt solid #0D7377
- **Padding**: 16pt
- **Margin**: 0 16pt 20pt 16pt

#### Active Job Content
- **Service**: Inter SemiBold 17pt, #1E1E1E
- **Time Info**: Inter Medium 15pt, #FF6B35 (urgency)
- **Location**: SF Pro Regular 14pt, #666666
- **Booking ID**: SF Pro Mono 12pt, #999999
- **Customer**: Inter Regular 14pt, #666666

**View Details Button**:
- Height: 48pt
- Border Radius: 8pt
- Background: #0D7377
- Text: Inter Medium 15pt, White
- Arrow: 16x16pt chevron.right
- Margin: 12pt top

### Quick Stats Card
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Padding**: 16pt
- **Margin**: 0 16pt 24pt 16pt

#### Stats List
- **Bullet**: "•" character, #0D7377
- **Typography**: SF Pro Regular 15pt, #1E1E1E
- **Line Spacing**: 8pt between items
- **Highlight**: Numbers/values in Inter Medium, #0D7377

**View Analytics Button**:
- Height: 44pt
- Border Radius**: 8pt
- Background: Transparent
- Border: 1pt solid #E0E0E0
- Text: Inter Medium 14pt, #666666
- Margin: 16pt top

### View All Link
- **Typography**: Inter Medium 15pt, #0D7377
- **Underline**: None
- **Margin**: 0 16pt 24pt 16pt
- **Alignment**: Center
- **Active**: Opacity 0.7

### Bottom Tab Bar
- **Height**: 49pt + safe area
- **Background**: White / Dark (#2A2A2A)
- **Border Top**: 1pt solid #E0E0E0
- **Icons**: 24x24pt
- **Labels**: SF Pro Regular 10pt
- **Selected**: #0D7377
- **Unselected**: #999999

## Components Used

### Existing Components
1. **CustomNavigationBar**
2. **BottomTabBar**
3. **Toggle Switch** (native)

### New Components Needed
1. **AvailabilityToggleCard** (online/offline)
2. **StatCard** (dashboard stat)
3. **JobRequestCard** (job with countdown)
4. **ActiveJobCard** (current job)
5. **QuickStatsCard** (weekly stats)

## Interactions

### Availability Toggle
- **Action**: Toggle online/offline status
- **Immediate**: Update status in database
- **Visual**:
  - Card background changes
  - Status text/icon updates
  - Toggle animates
- **Online**: Can receive new job requests
- **Offline**: No new requests, existing jobs unaffected
- **Haptic**: Light impact
- **Analytics**: Log status change

### Notification Bell Tap
- **Action**: Navigate to Notifications screen
- **Badge**: Show unread count
- **Clear**: Mark as read on view
- **Haptic**: Light impact

### Profile Photo Tap
- **Action**: Navigate to Profile screen
- **Haptic**: Light impact

### Stat Card Tap
- **Jobs Done**: Navigate to Completed Jobs list
- **Active**: Navigate to Active Jobs screen
- **Earned Today**: Show today's earnings breakdown
- **Haptic**: Light impact

### Accept Job Request
- **Action**: Accept the job
- **Confirmation**: "Accept this job?" alert with details
- **Process**:
  1. Mark job as accepted
  2. Notify customer
  3. Move to Active Jobs
  4. Remove from requests
  5. Start countdown to job time
- **Success**: Toast "Job accepted"
- **Haptic**: Success feedback
- **Navigate**: To Active Jobs or show job details
- **Analytics**: Log job_accepted

### Decline Job Request
- **Action**: Decline the job
- **Confirmation**: "Decline this job?" alert
- **Optional**: Reason selection (Too far, Busy, etc.)
- **Process**:
  1. Remove from provider's requests
  2. Offer to next available provider
  3. Update stats (declined count)
- **Success**: Card removes with animation
- **Haptic**: Error feedback
- **Impact**: Too many declines affect rating
- **Analytics**: Log job_declined

### View Job Details (from request card)
- **Action**: Navigate to Job Detail screen
- **Data**: Full job details
- **Actions**: Accept/Decline from detail screen
- **Haptic**: Medium impact

### View All Requests
- **Action**: Navigate to Job Requests screen
- **Filter**: Show all pending requests
- **Sort**: By time, distance, or price
- **Haptic**: Light impact

### Active Job Card Tap
- **Action**: Navigate to Active Job Detail
- **Features**:
  - Customer info
  - Navigation to location
  - Start job button
  - Contact customer
- **Haptic**: Medium impact

### View Detailed Analytics
- **Action**: Navigate to Analytics/Earnings screen
- **Display**: Charts, breakdown, trends
- **Filters**: Daily, weekly, monthly
- **Haptic**: Light impact

### Pull to Refresh
- **Action**: Refresh dashboard data
- **Updates**:
  - Today's stats
  - New job requests
  - Active jobs
- **Haptic**: Light impact on release

### Real-time Updates
- **New Job Request**: Auto-adds to list, badge count updates
- **Job Accepted by Another**: Remove from list
- **Job Cancelled**: Remove and notify
- **Countdown**: Updates every second

## States

### Default State (Online, Has Jobs)
- **Availability**: Online
- **Stats**: Populated
- **Job Requests**: 2+ cards
- **Active Jobs**: 1+ cards
- **All Sections**: Visible

### Offline State
- **Availability**: Offline, gray theme
- **Stats**: Yesterday's data
- **Job Requests**: Hidden or grayed out
- **Message**: "Turn online to receive jobs"

### No New Requests
- **Empty State**:
  - Icon: Job search illustration
  - Text: "No new job requests"
  - Subtext: "We'll notify you when jobs are available"
- **Alternative**: Show "Searching for jobs..." if recently went online

### No Active Jobs
- **Empty State**: Hide section or show completed jobs

### New Provider (First Day)
- **Welcome Banner**: "Welcome! Here's how to get started"
- **Tutorial**: Highlight key features
- **Tips**: "Accept jobs quickly to build reputation"

### High Demand
- **Banner**: "🔥 High demand! More jobs available"
- **Highlight**: Urgent jobs with higher pay

### Low Rating Alert
- **Banner**: "⚠️ Your rating is low. Maintain quality to receive more jobs."
- **CTA**: "View Feedback"

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Border**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Online Card**: #1E3D1E (darker green tint)
- **Active Job Card**: #1E3D3D (darker teal tint)

## Accessibility

### VoiceOver Labels
- **Availability Toggle**: "Availability status, online, toggle button, double tap to go offline"
- **Stat Card**: "[Value] [label]. Double tap to view details."
- **Job Card**: "[Service] job request. Location [location]. Scheduled for [time]. Pays ₹[amount]. Respond within [countdown]. Double tap to view details."
- **Accept Button**: "Accept job, button"
- **Decline Button**: "Decline job, button"

### VoiceOver Hints
- **Job Card**: "Double tap to view full job details"
- **Accept**: "Double tap to accept this job"
- **Toggle**: "Double tap to change availability status"

### Dynamic Type
- All text scales appropriately
- Card heights adjust
- Stat cards stack on largest text size
- Buttons maintain 44pt height

### Color Contrast
- All text meets WCAG AA
- Status indicators clearly visible
- Action buttons distinguishable

## Analytics Events

### Screen View
```json
{
  "screen_name": "provider_dashboard",
  "provider_id": "PRV12345",
  "availability_status": "online",
  "pending_requests_count": 5,
  "active_jobs_count": 1,
  "today_earnings": 850
}
```

### Availability Changed
```json
{
  "event": "availability_status_changed",
  "provider_id": "PRV12345",
  "new_status": "online", // or offline
  "previous_status": "offline",
  "time_of_day": "morning"
}
```

### Job Accepted
```json
{
  "event": "job_accepted",
  "provider_id": "PRV12345",
  "job_id": "JOB789",
  "service_type": "ac_repair",
  "job_amount": 650,
  "response_time_seconds": 45,
  "distance_km": 3.2
}
```

### Job Declined
```json
{
  "event": "job_declined",
  "provider_id": "PRV12345",
  "job_id": "JOB790",
  "reason": "too_far", // or busy, low_price, etc.
  "distance_km": 8.5
}
```

## SwiftUI Implementation

### View Structure
```swift
struct ProviderDashboardView: View {
    @StateObject private var viewModel = ProviderDashboardViewModel()
    @State private var isOnline: Bool = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Greeting
                    Text("Good \(viewModel.timeOfDay), \(viewModel.providerName)! 👋")
                        .font(.custom("Inter-SemiBold", size: 22))
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 20)

                    // Availability Toggle
                    AvailabilityToggleCard(
                        isOnline: $isOnline,
                        onChange: toggleAvailability
                    )

                    // Today's Summary
                    SectionHeader(icon: "📊", title: "Today's Summary")

                    TodayStatsCard(
                        jobsDone: viewModel.todayJobsDone,
                        activeJobs: viewModel.activeJobsCount,
                        earnedToday: viewModel.todayEarnings,
                        onStatTap: handleStatTap
                    )

                    // New Job Requests
                    if !viewModel.jobRequests.isEmpty {
                        HStack {
                            SectionHeader(icon: "💼", title: "New Job Requests")
                            Text("(\(viewModel.jobRequests.count))")
                                .font(.custom("Inter-Medium", size: 16))
                                .foregroundColor(.primary)
                        }

                        ForEach(viewModel.jobRequests.prefix(2)) { job in
                            JobRequestCard(
                                job: job,
                                onAccept: { acceptJob(job) },
                                onDecline: { declineJob(job) },
                                onTap: { viewJobDetails(job) }
                            )
                        }

                        if viewModel.jobRequests.count > 2 {
                            Button(action: viewAllRequests) {
                                Text("View All Requests (\(viewModel.jobRequests.count))")
                                    .font(.custom("Inter-Medium", size: 15))
                                    .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 24)
                        }
                    }

                    // Active Jobs
                    if !viewModel.activeJobs.isEmpty {
                        SectionHeader(icon: "🔥", title: "Active Jobs (\(viewModel.activeJobs.count))")

                        ForEach(viewModel.activeJobs) { job in
                            ActiveJobCard(
                                job: job,
                                onTap: { viewActiveJob(job) }
                            )
                        }
                    }

                    // Quick Stats
                    SectionHeader(icon: "📈", title: "Quick Stats")

                    QuickStatsCard(
                        weeklyJobs: viewModel.weeklyJobsCompleted,
                        weeklyEarnings: viewModel.weeklyEarnings,
                        avgRating: viewModel.averageRating,
                        onViewAnalytics: viewAnalytics
                    )

                    Spacer(minLength: 20)
                }
            }
            .background(Color.gray100.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("UrbanNest")
                        .font(.custom("Inter-Bold", size: 18))
                        .foregroundColor(.primary)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        NotificationButton(
                            unreadCount: viewModel.unreadNotifications,
                            onTap: openNotifications
                        )

                        ProfileButton(
                            photoURL: viewModel.profilePhotoURL,
                            onTap: openProfile
                        )
                    }
                }
            }
            .refreshable {
                await viewModel.refreshDashboard()
            }
            .onAppear {
                loadDashboard()
                viewModel.startRealtimeUpdates()

                Analytics.logScreenView("provider_dashboard", parameters: [
                    "availability_status": isOnline ? "online" : "offline",
                    "pending_requests_count": viewModel.jobRequests.count
                ])
            }
            .onDisappear {
                viewModel.stopRealtimeUpdates()
            }
        }
    }

    // MARK: - Actions

    private func loadDashboard() {
        Task {
            await viewModel.loadDashboardData()
            isOnline = viewModel.availabilityStatus == .online
        }
    }

    private func toggleAvailability(_ online: Bool) {
        Task {
            await viewModel.updateAvailability(online: online)
            HapticFeedback.light()

            Analytics.logEvent("availability_status_changed", parameters: [
                "new_status": online ? "online" : "offline"
            ])
        }
    }

    private func acceptJob(_ job: Job) {
        AlertManager.show(
            title: "Accept Job?",
            message: "Accept \(job.service.name) at \(job.location)?",
            primaryButton: "Accept",
            primaryAction: {
                Task {
                    let success = await viewModel.acceptJob(job)
                    if success {
                        HapticFeedback.success()
                        ToastManager.show("Job accepted!")
                    }
                }
            },
            secondaryButton: "Cancel"
        )
    }

    private func declineJob(_ job: Job) {
        // Show decline reason sheet
        let declineSheet = DeclineReasonSheet(
            job: job,
            onDecline: { reason in
                Task {
                    await viewModel.declineJob(job, reason: reason)
                }
            }
        )
        presentSheet(declineSheet)
    }

    private func viewJobDetails(_ job: Job) {
        navigationController?.push(
            JobDetailView(jobId: job.id, source: .dashboard)
        )
    }

    private func viewAllRequests() {
        // Switch to Jobs tab
        tabBarController?.selectedIndex = 1
    }

    private func viewActiveJob(_ job: Job) {
        navigationController?.push(
            ActiveJobDetailView(jobId: job.id)
        )
    }

    private func viewAnalytics() {
        navigationController?.push(AnalyticsView())
    }

    private func openNotifications() {
        navigationController?.push(NotificationsView())
    }

    private func openProfile() {
        tabBarController?.selectedIndex = 3 // Profile tab
    }

    private func handleStatTap(_ statType: StatType) {
        // Navigate based on stat type
    }
}
```

### ViewModel
```swift
class ProviderDashboardViewModel: ObservableObject {
    @Published var providerName: String = ""
    @Published var availabilityStatus: AvailabilityStatus = .offline
    @Published var todayJobsDone: Int = 0
    @Published var activeJobsCount: Int = 0
    @Published var todayEarnings: Double = 0
    @Published var jobRequests: [Job] = []
    @Published var activeJobs: [Job] = []
    @Published var weeklyJobsCompleted: Int = 0
    @Published var weeklyEarnings: Double = 0
    @Published var averageRating: Double = 0
    @Published var unreadNotifications: Int = 0
    @Published var profilePhotoURL: String?
    @Published var isLoading: Bool = false

    var timeOfDay: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "morning" }
        else if hour < 17 { return "afternoon" }
        else { return "evening" }
    }

    private let dashboardService: DashboardService
    private var requestsListener: ListenerRegistration?
    private var activeJobsListener: ListenerRegistration?

    init() {
        self.dashboardService = DashboardService()
    }

    func loadDashboardData() async {
        isLoading = true

        do {
            let dashboard = try await dashboardService.getDashboardData()

            providerName = dashboard.providerName
            availabilityStatus = dashboard.availability
            todayJobsDone = dashboard.todayJobsDone
            activeJobsCount = dashboard.activeJobs.count
            todayEarnings = dashboard.todayEarnings
            weeklyJobsCompleted = dashboard.weeklyStats.jobsCompleted
            weeklyEarnings = dashboard.weeklyStats.earnings
            averageRating = dashboard.rating
            unreadNotifications = dashboard.unreadNotifications
            profilePhotoURL = dashboard.profilePhotoURL

            isLoading = false
        } catch {
            print("Error loading dashboard: \(error)")
            isLoading = false
        }
    }

    func startRealtimeUpdates() {
        // Listen for new job requests
        requestsListener = dashboardService.observeJobRequests { [weak self] requests in
            self?.jobRequests = requests.sorted { $0.expiresAt < $1.expiresAt }

            // Show notification for new requests
            if let newest = requests.first, newest.isNew {
                self?.showNewJobNotification(newest)
            }
        }

        // Listen for active jobs updates
        activeJobsListener = dashboardService.observeActiveJobs { [weak self] jobs in
            self?.activeJobs = jobs.sorted { $0.scheduledTime < $1.scheduledTime }
        }
    }

    func stopRealtimeUpdates() {
        requestsListener?.remove()
        activeJobsListener?.remove()
    }

    func updateAvailability(online: Bool) async {
        let newStatus: AvailabilityStatus = online ? .online : .offline

        do {
            try await dashboardService.updateAvailability(status: newStatus)
            availabilityStatus = newStatus

            ToastManager.show(online ? "You're now online" : "You're now offline")
        } catch {
            ToastManager.show("Failed to update status", type: .error)
        }
    }

    func acceptJob(_ job: Job) async -> Bool {
        do {
            try await dashboardService.acceptJob(job.id)

            // Remove from requests, add to active
            jobRequests.removeAll { $0.id == job.id }
            activeJobs.append(job)
            activeJobsCount += 1

            Analytics.logEvent("job_accepted", parameters: [
                "job_id": job.id,
                "service_type": job.service.category.rawValue,
                "job_amount": job.amount
            ])

            return true
        } catch {
            ToastManager.show("Failed to accept job", type: .error)
            return false
        }
    }

    func declineJob(_ job: Job, reason: DeclineReason) async {
        do {
            try await dashboardService.declineJob(job.id, reason: reason)

            jobRequests.removeAll { $0.id == job.id }

            Analytics.logEvent("job_declined", parameters: [
                "job_id": job.id,
                "reason": reason.rawValue
            ])
        } catch {
            ToastManager.show("Failed to decline job", type: .error)
        }
    }

    func refreshDashboard() async {
        await loadDashboardData()
    }

    private func showNewJobNotification(_ job: Job) {
        NotificationManager.showLocal(
            title: "New Job Request!",
            body: "\(job.service.name) at \(job.location) - ₹\(Int(job.amount))"
        )
    }

    deinit {
        stopRealtimeUpdates()
    }
}

enum AvailabilityStatus: String {
    case online
    case offline
}
```

## Testing Checklist

### Functional
- ✅ Load dashboard data
- ✅ Toggle availability works
- ✅ Accept job works
- ✅ Decline job works
- ✅ Real-time job requests appear
- ✅ Countdown timers update
- ✅ Navigate to job details
- ✅ Pull to refresh works
- ✅ Stats tap navigation
- ✅ Notifications work

### Edge Cases
- ✅ No job requests
- ✅ No active jobs
- ✅ New provider (first day)
- ✅ Offline state
- ✅ Network error
- ✅ Job expires during view
- ✅ Multiple simultaneous requests

### Visual
- ✅ Light mode
- ✅ Dark mode
- ✅ Dynamic Type
- ✅ VoiceOver
- ✅ All card states
- ✅ Empty states
