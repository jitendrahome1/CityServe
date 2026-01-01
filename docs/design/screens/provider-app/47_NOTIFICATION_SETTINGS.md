# Screen 47: Notification Settings

## Overview

- **Screen ID**: 47
- **Screen Name**: Notification Settings
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 48 (Provider App Settings) → Tap "Notifications"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Notification Settings                │ Header
├─────────────────────────────────────────┤
│                                         │
│  Manage how you receive notifications   │
│                                         │
│  ───── Push Notifications ─────         │
│                                         │
│  Enable Push Notifications    [●○]      │ Master Toggle
│  ⓘ Turn off to disable all push alerts  │
│                                         │
│  Job Notifications                      │
│  ┌────────────────────────────────┐    │
│  │ New Job Requests         [●○]   │    │ Toggle
│  │ When customers book services    │    │
│  │                                 │    │
│  │ Job Accepted             [●○]   │    │
│  │ Confirmation when you accept    │    │
│  │                                 │    │
│  │ Job Cancelled            [●○]   │    │
│  │ Customer cancellations          │    │
│  │                                 │    │
│  │ Job Reminders            [●○]   │    │
│  │ 1 hour before job starts        │    │
│  └────────────────────────────────┘    │
│                                         │
│  Booking Updates                        │
│  ┌────────────────────────────────┐    │
│  │ Customer Messages        [●○]   │    │
│  │ Chat messages from customers    │    │
│  │                                 │    │
│  │ Booking Changes          [●○]   │    │
│  │ Reschedule or modifications     │    │
│  │                                 │    │
│  │ Service Completion       [●○]   │    │
│  │ When job is marked complete     │    │
│  └────────────────────────────────┘    │
│                                         │
│  Payment Notifications                  │
│  ┌────────────────────────────────┐    │
│  │ Payment Received         [●○]   │    │
│  │ Customer payment confirmed      │    │
│  │                                 │    │
│  │ Payout Processed         [●○]   │    │
│  │ Earnings transferred to bank    │    │
│  │                                 │    │
│  │ Payment Issues           [●○]   │    │
│  │ Failed or pending payments      │    │
│  └────────────────────────────────┘    │
│                                         │
│  Performance & Reviews                  │
│  ┌────────────────────────────────┐    │
│  │ New Reviews              [●○]   │    │
│  │ Customer review posted          │    │
│  │                                 │    │
│  │ Rating Milestones        [●○]   │    │
│  │ Achievement unlocked            │    │
│  │                                 │    │
│  │ Performance Reports      [●○]   │    │
│  │ Weekly/monthly summaries        │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── SMS Notifications ─────          │
│                                         │
│  Enable SMS Notifications [●○]          │ Master Toggle
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Critical Alerts          [●○]   │    │
│  │ Urgent job requests, cancels    │    │
│  │                                 │    │
│  │ Payment Updates          [●○]   │    │
│  │ Payment confirmations           │    │
│  │                                 │    │
│  │ Document Expiry          [●○]   │    │
│  │ License/cert expiring soon      │    │
│  └────────────────────────────────┘    │
│                                         │
│  ⓘ SMS charges may apply based on plan  │
│                                         │
│  ───── Email Notifications ─────        │
│                                         │
│  Enable Email Notifications [●○]        │ Master Toggle
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Daily Summary            [●○]   │    │
│  │ Daily job and earnings recap    │    │
│  │                                 │    │
│  │ Weekly Reports           [●○]   │    │
│  │ Performance and earnings        │    │
│  │                                 │    │
│  │ Promotional Offers       [●○]   │    │
│  │ Special deals and updates       │    │
│  │                                 │    │
│  │ Policy Updates           [●○]   │    │
│  │ Terms and platform changes      │    │
│  └────────────────────────────────┘    │
│                                         │
│  Email Address                          │
│  john.doe@example.com                   │
│  [Change Email]                         │
│                                         │
│  ───── Do Not Disturb ─────             │
│                                         │
│  Quiet Hours                [●○]        │ Toggle
│                                         │
│  From:  [10:00 PM ▼]                    │ Time Pickers
│  To:    [07:00 AM ▼]                    │
│                                         │
│  ⓘ Critical alerts will still notify    │
│                                         │
│  ───── Sound & Vibration ─────          │
│                                         │
│  Notification Sound                     │
│  ┌────────────────────────────────┐    │
│  │ Default ▼                       │    │ Dropdown
│  └────────────────────────────────┘    │
│  [Play Sound]                           │
│                                         │
│  Vibration                  [●○]        │ Toggle
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Push Notifications
- Master toggle to enable/disable all push
- Granular control per notification type
- Categories: Jobs, Bookings, Payments, Performance

### 2. SMS Notifications
- Critical alerts only
- Opt-in/opt-out
- Carrier charges may apply

### 3. Email Notifications
- Daily summaries
- Weekly reports
- Marketing emails (opt-in)
- Policy updates

### 4. Do Not Disturb
- Quiet hours schedule
- Critical alerts bypass DND
- Weekend mode option

### 5. Sound & Vibration
- Custom notification sounds
- Vibration patterns
- Sound preview

## Component Breakdown

```swift
struct NotificationSettingsView: View {
    @StateObject private var viewModel = NotificationSettingsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Push Notifications Section
                NotificationSection(
                    title: "Push Notifications",
                    masterToggle: $viewModel.pushEnabled,
                    settings: viewModel.pushSettings
                )

                // SMS Section
                NotificationSection(
                    title: "SMS Notifications",
                    masterToggle: $viewModel.smsEnabled,
                    settings: viewModel.smsSettings
                )

                // Email Section
                NotificationSection(
                    title: "Email Notifications",
                    masterToggle: $viewModel.emailEnabled,
                    settings: viewModel.emailSettings
                )

                // Do Not Disturb
                DoNotDisturbSection(
                    enabled: $viewModel.dndEnabled,
                    startTime: $viewModel.dndStart,
                    endTime: $viewModel.dndEnd
                )

                // Sound & Vibration
                SoundSettingsSection(
                    sound: $viewModel.notificationSound,
                    vibration: $viewModel.vibrationEnabled
                )
            }
            .padding(16)
        }
        .navigationTitle("Notification Settings")
        .onChange(of: viewModel.pushEnabled) { _ in
            viewModel.saveSettings()
        }
    }
}

struct NotificationToggleRow: View {
    let title: String
    let description: String
    @Binding var isOn: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Toggle(isOn: $isOn) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    Text(description)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))
                }
            }
            .tint(Color("PrimaryTeal"))
        }
        .padding(.vertical, 8)
    }
}
```

## API Integration

```
PUT /providers/{providerId}/notification-settings

Request:
{
  "pushEnabled": true,
  "pushSettings": {
    "newJobRequests": true,
    "jobAccepted": true,
    "jobCancelled": true,
    "jobReminders": true,
    "customerMessages": true,
    "paymentReceived": true,
    "newReviews": true
  },
  "smsEnabled": true,
  "smsSettings": {
    "criticalAlerts": true,
    "paymentUpdates": false
  },
  "emailEnabled": true,
  "emailSettings": {
    "dailySummary": true,
    "weeklyReports": true,
    "promotionalOffers": false
  },
  "dndEnabled": true,
  "dndStart": "22:00",
  "dndEnd": "07:00",
  "notificationSound": "default",
  "vibrationEnabled": true
}

Response:
{
  "success": true,
  "message": "Notification settings updated successfully"
}
```

## Testing Checklist

- [ ] Master toggles disable all sub-toggles
- [ ] Individual toggles work independently
- [ ] DND schedule prevents non-critical notifications
- [ ] Sound preview plays correctly
- [ ] Settings persist after app restart
- [ ] Email/SMS opt-out works correctly
- [ ] Permission prompts show when needed

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
