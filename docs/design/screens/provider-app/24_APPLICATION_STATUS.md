# Application Status

## Overview
- **Screen ID**: 24
- **Screen Name**: Application Status
- **User Flow**: Track provider application verification progress
- **Navigation**:
  - Entry: After registration, from notifications, app launch (for pending applications)
  - Exit: To Document Upload, Training, Provider Dashboard
  - Back: None (root screen for pending providers)

## Application States

1. **Documents Pending** - Registration complete, documents not uploaded
2. **Under Review** - Documents submitted, admin reviewing
3. **Additional Info Required** - Admin needs clarification
4. **Approved** - Application approved, training pending
5. **Training Scheduled** - Training session booked
6. **Active** - Fully onboarded, can accept jobs
7. **Rejected** - Application rejected
8. **Suspended** - Temporarily suspended

## ASCII Wireframe

### State 1: Documents Pending
```
┌──────────────────────────────────────────┐
│  Application Status                      │ ← Nav Bar
├──────────────────────────────────────────┤
│                                          │
│         ⏳                               │ ← Status Icon
│                                          │
│  Documents Pending                       │ ← Status Title
│                                          │
│  Application ID: #APP12345               │ ← App ID
│  Submitted: Dec 20, 2024                 │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Complete Your Application         │ │ ← Info Card
│  │                                    │ │
│  │  Upload the required documents to  │ │
│  │  proceed with verification.        │ │
│  │                                    │ │
│  │  ⏰ Complete within 7 days          │ │ ← Urgency
│  │     (5 days remaining)             │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Application Progress                 │ ← Section
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  ✅ Registration Complete           │ │ ← Progress Steps
│  │     Dec 20, 10:30 AM               │ │
│  │                                    │ │
│  │  ⏳ Documents Upload                │ │
│  │     Pending                        │ │
│  │                                    │ │
│  │  ⏹️ Verification                    │ │
│  │     Not started                    │ │
│  │                                    │ │
│  │  ⏹️ Training                        │ │
│  │     Not started                    │ │
│  │                                    │ │
│  │  ⏹️ Activation                      │ │
│  │     Not started                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Upload Documents Now              │ │ ← Primary CTA
│  └────────────────────────────────────┘ │
│                                          │
│  Need help? Contact Support             │ ← Support Link
│                                          │
└──────────────────────────────────────────┘
```

### State 2: Under Review
```
┌──────────────────────────────────────────┐
│  Application Status                      │
├──────────────────────────────────────────┤
│                                          │
│         🔍                               │ ← Reviewing Icon
│                                          │
│  Under Review                            │
│                                          │
│  Application ID: #APP12345               │
│  Submitted: Dec 20, 2024                 │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Your Application is Being Reviewed │ │
│  │                                    │ │
│  │  Our team is verifying your        │ │
│  │  documents and details.            │ │
│  │                                    │ │
│  │  ⏰ Expected completion: 2-3 days   │ │
│  │     (Started 1 day ago)            │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Application Progress                 │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  ✅ Registration Complete           │ │
│  │     Dec 20, 10:30 AM               │ │
│  │                                    │ │
│  │  ✅ Documents Uploaded              │ │
│  │     Dec 20, 2:15 PM                │ │
│  │     • Aadhaar Card                 │ │
│  │     • PAN Card                     │ │
│  │     • Profile Photo                │ │
│  │                                    │ │
│  │  🔍 Verification In Progress        │ │
│  │     Started Dec 21, 9:00 AM        │ │
│  │     Verifying identity & documents  │ │
│  │                                    │ │
│  │  ⏹️ Training                        │ │
│  │     Not started                    │ │
│  │                                    │ │
│  │  ⏹️ Activation                      │ │
│  │     Not started                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💬 You'll be notified once the         │ ← Notification Info
│     review is complete                   │
│                                          │
│  📱 Turn on notifications                │ ← Enable Notifications
│                                          │
└──────────────────────────────────────────┘
```

### State 3: Additional Info Required
```
┌──────────────────────────────────────────┐
│  Application Status                      │
├──────────────────────────────────────────┤
│                                          │
│         ⚠️                               │ ← Warning Icon
│                                          │
│  Action Required                         │
│                                          │
│  Application ID: #APP12345               │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  ⚠️ Additional Information Needed   │ │ ← Alert Card
│  │                                    │ │
│  │  Message from Admin:               │ │
│  │  "PAN card image is unclear. Please│ │
│  │  upload a clearer photo showing all │ │
│  │  details."                          │ │
│  │                                    │ │
│  │  Requested: Dec 21, 2024           │ │
│  │  ⏰ Respond within 48 hours         │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Re-upload PAN Card                │ │ ← Action CTA
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Reply to Admin                    │ │ ← Secondary CTA
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### State 4: Approved - Training Pending
```
┌──────────────────────────────────────────┐
│  Application Status                      │
├──────────────────────────────────────────┤
│                                          │
│         🎉                               │ ← Success Icon
│                                          │
│  Application Approved!                   │
│                                          │
│  Application ID: #APP12345               │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Congratulations! 🎊                │ │ ← Success Card
│  │                                    │ │
│  │  Your application has been approved!│ │
│  │  Complete the training to start    │ │
│  │  accepting jobs.                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📋 Next Steps                           │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  1. Attend Onboarding Training     │ │ ← Training Info
│  │     • Duration: 2 hours            │ │
│  │     • Online (Video call)          │ │
│  │     • Certificate provided         │ │
│  │                                    │ │
│  │  2. Learn Our Platform             │ │
│  │     • How to accept jobs           │ │
│  │     • Customer communication       │ │
│  │     • Quality standards            │ │
│  │                                    │ │
│  │  3. Start Earning!                 │ │
│  │     • Average: ₹30,000/month       │ │
│  │     • Flexible timings             │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📅 Available Training Slots             │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Tomorrow, Dec 22                  │ │ ← Slot 1
│  │  10:00 AM - 12:00 PM               │ │
│  │              [Book Now]            │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Friday, Dec 23                    │ │ ← Slot 2
│  │  3:00 PM - 5:00 PM                 │ │
│  │              [Book Now]            │ │
│  └────────────────────────────────────┘ │
│                                          │
│         View All Slots                   │ ← More Slots
│                                          │
└──────────────────────────────────────────┘
```

### State 5: Training Scheduled
```
┌──────────────────────────────────────────┐
│  Application Status                      │
├──────────────────────────────────────────┤
│                                          │
│         📚                               │ ← Training Icon
│                                          │
│  Training Scheduled                      │
│                                          │
│  Application ID: #APP12345               │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Your Training Session              │ │ ← Training Card
│  │                                    │ │
│  │  📅 Date: Tomorrow, Dec 22          │ │
│  │  ⏰ Time: 10:00 AM - 12:00 PM       │ │
│  │  🔗 Mode: Online (Zoom)             │ │
│  │                                    │ │
│  │  Meeting Link will be shared 1 hour│ │
│  │  before the session via SMS.       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📝 Things to Prepare                    │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  ✅ Good internet connection        │ │
│  │  ✅ Quiet environment               │ │
│  │  ✅ Pen and paper for notes         │ │
│  │  ✅ Questions (if any)              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ⏰ Reminder Set                         │ ← Reminder Status
│  You'll be notified 1 hour before       │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Add to Calendar                   │ │ ← Calendar CTA
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Reschedule                        │ │ ← Reschedule Option
│  └────────────────────────────────────┘ │
│                                          │
│  Need help? Call us: 1800-123-4567      │
│                                          │
└──────────────────────────────────────────┘
```

### State 6: Active (Fully Onboarded)
```
┌──────────────────────────────────────────┐
│  Application Status                      │
├──────────────────────────────────────────┤
│                                          │
│         ✅                               │ ← Success Icon
│                                          │
│  You're All Set!                         │
│                                          │
│  Provider ID: #PRV12345                  │
│  Member Since: Dec 22, 2024              │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  🎊 Welcome to UrbanNest!           │ │ ← Welcome Card
│  │                                    │ │
│  │  You can now start accepting jobs  │ │
│  │  and earning money!                │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Your Profile                         │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Status: Active ✅                  │ │
│  │  Services: AC Repair, Electrical   │ │
│  │  Work Areas: 3 locations           │ │
│  │  Rating: ⭐ New (No reviews yet)    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🚀 Quick Actions                        │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  👁️ View Available Jobs             │ │ ← Quick Action 1
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  ⚙️ Complete Profile                │ │ ← Quick Action 2
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  📚 View Training Materials         │ │ ← Quick Action 3
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Go to Dashboard                   │ │ ← Primary CTA
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### State 7: Rejected
```
┌──────────────────────────────────────────┐
│  Application Status                      │
├──────────────────────────────────────────┤
│                                          │
│         ❌                               │ ← Rejection Icon
│                                          │
│  Application Not Approved                │
│                                          │
│  Application ID: #APP12345               │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  We're Sorry                        │ │ ← Rejection Card
│  │                                    │ │
│  │  Unfortunately, we cannot approve  │ │
│  │  your application at this time.    │ │
│  │                                    │ │
│  │  Reason:                           │ │
│  │  "Documents provided do not meet   │ │
│  │  our verification standards. PAN   │ │
│  │  and Aadhaar names do not match."  │ │
│  │                                    │ │
│  │  Reviewed: Dec 22, 2024            │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💬 What You Can Do                      │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  • Fix the issues mentioned above  │ │
│  │  • Reapply after 30 days           │ │
│  │  • Contact support for clarification│ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Contact Support                   │ │ ← Support CTA
│  └────────────────────────────────────┘ │
│                                          │
│  Reapply available: Jan 22, 2025        │ ← Reapply Date
│                                          │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt
- **Safe Area Bottom**: 34pt
- **Content Width**: 358pt (16pt padding)

### Navigation Bar
- **Height**: 56pt
- **Background**: White / Dark (#2A2A2A)
- **Title**: Inter SemiBold 18pt, "Application Status"
- **No Back Button**: This is root for pending providers
- **Padding**: 16pt horizontal

### Status Icon
- **Size**: 100x100pt
- **Margin**: 40pt top, 24pt bottom
- **Alignment**: Center
- **Colors**:
  - Pending: #FFC107 (warning)
  - Review: #0D7377 (primary)
  - Action Required: #FF6B35 (warning)
  - Approved: #28C76F (success)
  - Rejected: #EA5455 (error)

### Status Title
- **Typography**: Inter Bold 28pt
- **Color**: Based on status
- **Margin**: 24pt bottom
- **Alignment**: Center

### Application Info
- **App ID**: SF Pro Mono Medium 14pt, #666666
- **Submitted Date**: SF Pro Regular 13pt, #999999
- **Margin**: 8pt bottom
- **Alignment**: Center

### Info/Alert Cards
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid (color based on state)
- **Padding**: 20pt
- **Margin**: 24pt horizontal, 20pt bottom
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)

#### Card Colors
- **Pending**: Border #FFC107, Background tint
- **Success**: Border #28C76F, Background tint
- **Warning**: Border #FF6B35, Background tint
- **Error**: Border #EA5455, Background tint

### Progress Timeline
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Padding**: 20pt
- **Margin**: 16pt horizontal

#### Timeline Item
- **Icon**: 24x24pt left-aligned
  - Complete: ✅ #28C76F
  - In Progress: 🔍 #0D7377
  - Pending: ⏹️ #E0E0E0
- **Title**: Inter SemiBold 16pt, #1E1E1E
- **Timestamp**: SF Pro Regular 13pt, #666666
- **Details**: SF Pro Regular 12pt, #999999, italic
- **Connector Line**: 2pt vertical, #E0E0E0, between items
- **Margin**: 16pt bottom between items

### Training Slot Card
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 8pt
- **Border**: 1pt solid #E0E0E0
- **Padding**: 16pt
- **Margin**: 12pt bottom
- **Layout**: Date + Time + Button

#### Slot Content
- **Date**: Inter Medium 15pt, #1E1E1E
- **Time**: SF Pro Regular 14pt, #666666
- **Button**:
  - Height: 36pt
  - Border Radius**: 6pt
  - Background: #0D7377
  - Text: Inter Medium 14pt, White

### Primary CTA Button
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: #0D7377 (gradient)
- **Text**: Inter SemiBold 16pt, White
- **Shadow**: 0 4px 12px rgba(13,115,119,0.3)
- **Margin**: 16pt horizontal, 20pt top

### Secondary Button
- **Height**: 52pt
- **Border Radius**: 12pt
- **Background**: Transparent
- **Border**: 1.5pt solid #E0E0E0
- **Text**: Inter Medium 15pt, #666666
- **Margin**: 16pt horizontal, 12pt top

### Support Link
- **Typography**: Inter Medium 14pt, #0D7377
- **Icon**: 16x16pt phone or message icon
- **Margin**: 20pt top
- **Alignment**: Center

## Components Used

### Existing Components
1. **CustomNavigationBar**
2. **PrimaryButton**
3. **SecondaryButton**

### New Components Needed
1. **StatusHeader** (icon + title + app ID)
2. **InfoCard** (colored border card)
3. **ProgressTimeline** (vertical timeline)
4. **TrainingSlotCard** (bookable slot)
5. **QuickActionCard** (action button)

## Interactions

### Refresh (Pull to Refresh)
- **Action**: Reload application status
- **API**: Fetch latest status from backend
- **Updates**: Status, progress, messages
- **Haptic**: Light impact

### Upload Documents (Documents Pending)
- **Action**: Navigate to Document Upload screen
- **Data**: Pass application ID
- **Haptic**: Medium impact

### Re-upload Document (Action Required)
- **Action**: Navigate to Document Upload, specific document
- **Pre-select**: The requested document type
- **Haptic**: Medium impact

### Reply to Admin
- **Action**: Open message compose sheet
- **Content**: Text area for reply
- **Attachments**: Option to attach images
- **Submit**: Send to admin
- **Notification**: Admin notified

### Book Training Slot
- **Action**: Book selected training slot
- **Confirmation**: "Book training for [date] at [time]?" alert
- **API**: Reserve slot
- **Success**: Update status to "Training Scheduled"
- **Calendar**: Add to device calendar
- **Reminder**: Schedule notification
- **Haptic**: Success feedback

### View All Slots
- **Action**: Navigate to full training calendar
- **Display**: Month view with available slots
- **Filter**: By date range
- **Book**: From calendar view

### Reschedule Training
- **Action**: Cancel current booking, show available slots
- **Confirmation**: "Reschedule training session?" alert
- **Limit**: Max 2 reschedules allowed
- **Haptic**: Medium impact

### Add to Calendar
- **Action**: Add training session to device calendar
- **Event Details**:
  - Title: "UrbanNest Provider Training"
  - Date/Time: From booking
  - Location: "Online (Zoom)"
  - Notes: Meeting link placeholder
- **Permission**: Calendar access
- **Success**: Toast "Added to calendar"

### Enable Notifications
- **Action**: Request notification permissions
- **iOS**: System permission dialog
- **Success**: Update preference
- **Reminder**: Set up notifications

### Contact Support
- **Action**: Show support options
- **Options**:
  - Call Support
  - WhatsApp
  - Email
  - Live Chat
- **Context**: Pass application ID

### Go to Dashboard (Active State)
- **Action**: Navigate to Provider Dashboard
- **Replace**: Set as new root (can't go back)
- **Onboarding**: Show quick tutorial (first time)
- **Haptic**: Medium impact

### View Available Jobs
- **Action**: Navigate to Job Requests screen
- **Filter**: Show jobs matching provider's services
- **Badge**: Show count of available jobs

## Real-time Updates

### Firebase Listeners
```javascript
// Listen for status changes
applicationRef.onSnapshot(snapshot => {
  const newStatus = snapshot.data().status
  if (newStatus !== currentStatus) {
    updateUI(newStatus)
    showNotification(newStatus)
  }
})

// Listen for admin messages
messagesRef.orderBy('timestamp', 'desc').limit(1).onSnapshot(snapshot => {
  snapshot.docChanges().forEach(change => {
    if (change.type === 'added') {
      showNewMessageBanner(change.doc.data())
    }
  })
})
```

### Push Notifications
- **Status Change**: "Your application status has been updated"
- **Action Required**: "Action needed on your application"
- **Approved**: "Congratulations! Your application is approved"
- **Training Reminder**: "Your training starts in 1 hour"

## States

### Loading State
- **Skeleton**: Shimmer for timeline
- **Duration**: While fetching status

### Error State
- **Icon**: Network error icon
- **Message**: "Unable to load status. Tap to retry."
- **Action**: Retry button

### Countdown Timer (Documents Pending)
- **Display**: "5 days remaining"
- **Update**: Daily
- **Urgency**: Red text when < 2 days

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Border**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Status Icons**: Same

## Accessibility

### VoiceOver Labels
- **Status**: "[Status] application status"
- **Timeline Item**: "[Stage name], [status]. [Details if any]"
- **Training Slot**: "Training session on [date] at [time]. Double tap to book."
- **CTA**: "[Action], button"

### Dynamic Type
- All text scales appropriately
- Timeline layout adjusts
- Minimum button height: 44pt

## Analytics Events

### Screen View
```json
{
  "screen_name": "application_status",
  "application_id": "APP12345",
  "status": "under_review",
  "days_since_submission": 2
}
```

### Training Booked
```json
{
  "event": "training_booked",
  "application_id": "APP12345",
  "training_date": "2024-12-22",
  "training_time": "10:00"
}
```

### Status Changed
```json
{
  "event": "application_status_changed",
  "application_id": "APP12345",
  "from_status": "under_review",
  "to_status": "approved"
}
```

## SwiftUI Implementation

### View Structure
```swift
struct ApplicationStatusView: View {
    @StateObject private var viewModel: ApplicationStatusViewModel

    init(applicationId: String) {
        _viewModel = StateObject(wrappedValue: ApplicationStatusViewModel(applicationId: applicationId))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Status Header
                StatusHeader(
                    status: viewModel.application.status,
                    applicationId: viewModel.application.id,
                    submittedDate: viewModel.application.submittedDate
                )

                // Status-specific content
                switch viewModel.application.status {
                case .documentsPending:
                    DocumentsPendingContent(
                        daysRemaining: viewModel.daysUntilDeadline,
                        onUpload: navigateToDocumentUpload
                    )

                case .underReview:
                    UnderReviewContent(
                        expectedDays: viewModel.estimatedReviewDays,
                        startedDate: viewModel.reviewStartDate
                    )

                case .actionRequired:
                    ActionRequiredContent(
                        adminMessage: viewModel.adminMessage,
                        onReupload: reuploadDocument,
                        onReply: replyToAdmin
                    )

                case .approved:
                    ApprovedContent(
                        trainingSlots: viewModel.availableSlots,
                        onBookSlot: bookTrainingSlot,
                        onViewAll: viewAllSlots
                    )

                case .trainingScheduled:
                    TrainingScheduledContent(
                        training: viewModel.scheduledTraining,
                        onAddToCalendar: addToCalendar,
                        onReschedule: rescheduleTraining
                    )

                case .active:
                    ActiveContent(
                        providerId: viewModel.providerId,
                        onGoToDashboard: goToDashboard
                    )

                case .rejected:
                    RejectedContent(
                        reason: viewModel.rejectionReason,
                        reapplyDate: viewModel.reapplyDate,
                        onContactSupport: contactSupport
                    )
                }

                // Progress Timeline
                ProgressTimeline(steps: viewModel.progressSteps)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
            }
        }
        .background(Color.gray100.ignoresSafeArea())
        .navigationBarTitle("Application Status", displayMode: .inline)
        .refreshable {
            await viewModel.refreshStatus()
        }
        .onAppear {
            viewModel.startRealtimeUpdates()

            Analytics.logScreenView("application_status", parameters: [
                "application_id": viewModel.application.id,
                "status": viewModel.application.status.rawValue
            ])
        }
        .onDisappear {
            viewModel.stopRealtimeUpdates()
        }
    }

    // Actions
    private func navigateToDocumentUpload() {
        navigationController?.push(
            DocumentUploadView(applicationId: viewModel.application.id)
        )
    }

    private func bookTrainingSlot(_ slot: TrainingSlot) {
        AlertManager.show(
            title: "Book Training?",
            message: "Book training for \(slot.date.formatted()) at \(slot.time)?",
            primaryButton: "Book",
            primaryAction: {
                Task {
                    await viewModel.bookTraining(slot)
                }
            },
            secondaryButton: "Cancel"
        )
    }

    private func goToDashboard() {
        // Replace root with Provider Dashboard
        navigationController?.setViewControllers([
            ProviderDashboardView()
        ], animated: true)
    }
}
```

### ViewModel
```swift
class ApplicationStatusViewModel: ObservableObject {
    @Published var application: Application
    @Published var progressSteps: [ProgressStep] = []
    @Published var availableSlots: [TrainingSlot] = []
    @Published var isLoading: Bool = false

    private let applicationId: String
    private let applicationService: ApplicationService
    private var statusListener: ListenerRegistration?

    init(applicationId: String) {
        self.applicationId = applicationId
        self.application = Application.placeholder
        self.applicationService = ApplicationService()

        Task {
            await loadApplicationStatus()
        }
    }

    func loadApplicationStatus() async {
        isLoading = true

        do {
            application = try await applicationService.getApplication(applicationId)
            progressSteps = generateProgressSteps()

            if application.status == .approved {
                availableSlots = try await applicationService.getTrainingSlots()
            }

            isLoading = false
        } catch {
            print("Error loading application: \(error)")
            isLoading = false
        }
    }

    func startRealtimeUpdates() {
        statusListener = applicationService.observeApplication(applicationId) { [weak self] updated in
            self?.application = updated
            self?.progressSteps = self?.generateProgressSteps() ?? []

            // Show notification for status changes
            if updated.status != self?.application.status {
                self?.showStatusChangeNotification(updated.status)
            }
        }
    }

    func stopRealtimeUpdates() {
        statusListener?.remove()
    }

    func bookTraining(_ slot: TrainingSlot) async {
        do {
            try await applicationService.bookTrainingSlot(applicationId, slot: slot)
            application.scheduledTraining = slot
            application.status = .trainingScheduled

            ToastManager.show("Training booked successfully")
            HapticFeedback.success()

            Analytics.logEvent("training_booked", parameters: [
                "application_id": applicationId,
                "training_date": slot.date.formatted()
            ])
        } catch {
            ToastManager.show("Failed to book training", type: .error)
        }
    }

    private func generateProgressSteps() -> [ProgressStep] {
        // Generate timeline based on current status
        []
    }

    deinit {
        stopRealtimeUpdates()
    }
}
```

## Testing Checklist

### Functional
- ✅ Load correct status on entry
- ✅ Real-time status updates work
- ✅ Navigate to upload docs
- ✅ Book training slot
- ✅ Add to calendar
- ✅ Reschedule training
- ✅ Contact support
- ✅ Notifications enabled
- ✅ Go to dashboard (active)

### Edge Cases
- ✅ Network error
- ✅ Status changed during session
- ✅ Training slots full
- ✅ Deadline passed
- ✅ Multiple status updates

### Visual
- ✅ All states render correctly
- ✅ Dark mode
- ✅ Dynamic Type
- ✅ VoiceOver
- ✅ Timeline layout
