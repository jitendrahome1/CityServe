# Screen 49: Notification Settings

## Overview

- **Screen ID**: 49
- **Screen Name**: Notification Settings
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 50 (App Settings) → Tap "Notifications"
  - From: Screen 21 (Profile Dashboard) → "Notification Settings"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← Notification Settings                │ Header
├─────────────────────────────────────────┤
│                                         │
│  Manage how you receive notifications  │ Description
│  from UrbanNest                         │
│                                         │
│  ───── Push Notifications ─────         │
│                                         │
│  Enable Push Notifications    [ON]     │ Master Toggle
│                                         │
│  Booking Updates              [ON]     │ Category Toggle
│  Status changes, confirmations          │ Subtitle
│                                         │
│  Payment & Billing            [ON]     │
│  Payment receipts, refunds              │
│                                         │
│  Promotions & Offers          [OFF]    │
│  Deals, discounts, new services         │
│                                         │
│  Service Reminders            [ON]     │
│  Upcoming appointments, follow-ups      │
│                                         │
│  Provider Updates             [ON]     │
│  Messages from your provider            │
│                                         │
│  Reviews & Ratings            [ON]     │
│  Reminders to review services           │
│                                         │
│  ───── Email Notifications ─────        │
│                                         │
│  Enable Email Notifications   [ON]     │ Master Toggle
│                                         │
│  Booking Confirmations        [ON]     │
│  Invoices & Receipts          [ON]     │
│  Weekly Summary               [ON]     │
│  Promotional Emails           [OFF]    │
│  Newsletter                   [OFF]    │
│                                         │
│  ───── SMS Notifications ─────          │
│                                         │
│  Enable SMS Notifications     [ON]     │ Master Toggle
│                                         │
│  Booking Confirmations        [ON]     │
│  OTP & Verification           [ON]     │ (Always ON)
│  Service Reminders            [ON]     │
│  Payment Updates              [ON]     │
│                                         │
│  ───── Do Not Disturb ─────             │
│                                         │
│  Enable Do Not Disturb        [OFF]    │ Toggle
│                                         │
│  From:  [09:00 PM]  To:  [08:00 AM]    │ Time Picker
│                                         │
│  💡 You'll still receive urgent         │ Info
│     notifications during DND            │
│                                         │
│  ───── In-App Preferences ─────         │
│                                         │
│  Sound                        [ON]     │
│  Vibration                    [ON]     │
│  Badge Count                  [ON]     │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Push Notifications
- **Master Toggle**: Enable/disable all push notifications
- **Category-specific Toggles**:
  - Booking Updates
  - Payment & Billing
  - Promotions & Offers
  - Service Reminders
  - Provider Updates
  - Reviews & Ratings
- Subtitle descriptions for each category
- Disabled if master toggle is OFF

### 2. Email Notifications
- **Master Toggle**: Enable/disable all email notifications
- **Email Categories**:
  - Booking Confirmations
  - Invoices & Receipts
  - Weekly Summary
  - Promotional Emails
  - Newsletter
- Email address display (from profile)

### 3. SMS Notifications
- **Master Toggle**: Enable/disable SMS notifications
- **SMS Categories**:
  - Booking Confirmations
  - OTP & Verification (always ON, cannot disable)
  - Service Reminders
  - Payment Updates
- Phone number display (from profile)

### 4. Do Not Disturb (DND)
- Enable/disable DND mode
- Start time picker
- End time picker
- Urgent notifications exception (e.g., booking cancellations)
- Visual indicator during DND hours

### 5. In-App Preferences
- Sound: Enable/disable notification sounds
- Vibration: Enable/disable haptic feedback
- Badge Count: Show/hide unread count on app icon

### 6. System Permission Check
- Check if app notifications are allowed in device settings
- Show alert if disabled
- Button to open device settings

## Component Breakdown

```swift
struct NotificationSettingsView: View {
    @StateObject private var viewModel = NotificationSettingsViewModel()
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true

    var body: some View {
        Form {
            // Description
            Section {
                Text("Manage how you receive notifications from UrbanNest")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))
            }

            // Push Notifications
            Section(header: Text("Push Notifications")) {
                Toggle("Enable Push Notifications", isOn: $viewModel.pushNotificationsEnabled)
                    .tint(Color("PrimaryTeal"))
                    .onChange(of: viewModel.pushNotificationsEnabled) { enabled in
                        if enabled {
                            viewModel.requestPushPermission()
                        }
                    }

                if viewModel.pushNotificationsEnabled {
                    NotificationCategoryToggle(
                        title: "Booking Updates",
                        subtitle: "Status changes, confirmations",
                        isOn: $viewModel.bookingUpdates
                    )

                    NotificationCategoryToggle(
                        title: "Payment & Billing",
                        subtitle: "Payment receipts, refunds",
                        isOn: $viewModel.paymentNotifications
                    )

                    NotificationCategoryToggle(
                        title: "Promotions & Offers",
                        subtitle: "Deals, discounts, new services",
                        isOn: $viewModel.promotionalNotifications
                    )

                    NotificationCategoryToggle(
                        title: "Service Reminders",
                        subtitle: "Upcoming appointments, follow-ups",
                        isOn: $viewModel.serviceReminders
                    )

                    NotificationCategoryToggle(
                        title: "Provider Updates",
                        subtitle: "Messages from your provider",
                        isOn: $viewModel.providerUpdates
                    )

                    NotificationCategoryToggle(
                        title: "Reviews & Ratings",
                        subtitle: "Reminders to review services",
                        isOn: $viewModel.reviewReminders
                    )
                }
            }

            // Email Notifications
            Section(header: Text("Email Notifications"),
                    footer: Text("Sent to: \(viewModel.userEmail)")) {
                Toggle("Enable Email Notifications", isOn: $viewModel.emailNotificationsEnabled)
                    .tint(Color("PrimaryTeal"))

                if viewModel.emailNotificationsEnabled {
                    Toggle("Booking Confirmations", isOn: $viewModel.emailBookingConfirmations)
                        .tint(Color("PrimaryTeal"))

                    Toggle("Invoices & Receipts", isOn: $viewModel.emailInvoices)
                        .tint(Color("PrimaryTeal"))

                    Toggle("Weekly Summary", isOn: $viewModel.emailWeeklySummary)
                        .tint(Color("PrimaryTeal"))

                    Toggle("Promotional Emails", isOn: $viewModel.emailPromotions)
                        .tint(Color("PrimaryTeal"))

                    Toggle("Newsletter", isOn: $viewModel.emailNewsletter)
                        .tint(Color("PrimaryTeal"))
                }
            }

            // SMS Notifications
            Section(header: Text("SMS Notifications"),
                    footer: Text("Sent to: \(viewModel.userPhone)")) {
                Toggle("Enable SMS Notifications", isOn: $viewModel.smsNotificationsEnabled)
                    .tint(Color("PrimaryTeal"))

                if viewModel.smsNotificationsEnabled {
                    Toggle("Booking Confirmations", isOn: $viewModel.smsBookingConfirmations)
                        .tint(Color("PrimaryTeal"))

                    HStack {
                        Toggle("OTP & Verification", isOn: .constant(true))
                            .tint(Color("PrimaryTeal"))
                            .disabled(true)
                            .opacity(0.6)
                    }

                    Toggle("Service Reminders", isOn: $viewModel.smsServiceReminders)
                        .tint(Color("PrimaryTeal"))

                    Toggle("Payment Updates", isOn: $viewModel.smsPaymentUpdates)
                        .tint(Color("PrimaryTeal"))
                }
            }

            // Do Not Disturb
            Section(header: Text("Do Not Disturb"),
                    footer: HStack(spacing: 8) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 12))
                            .foregroundColor(Color("SecondaryOrange"))
                        Text("You'll still receive urgent notifications during DND")
                            .font(.custom("Inter-Regular", size: 12))
                    }) {
                Toggle("Enable Do Not Disturb", isOn: $viewModel.dndEnabled)
                    .tint(Color("PrimaryTeal"))

                if viewModel.dndEnabled {
                    HStack {
                        Text("From:")
                            .font(.custom("Inter-Regular", size: 15))
                        Spacer()
                        DatePicker("", selection: $viewModel.dndStartTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }

                    HStack {
                        Text("To:")
                            .font(.custom("Inter-Regular", size: 15))
                        Spacer()
                        DatePicker("", selection: $viewModel.dndEndTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
            }

            // In-App Preferences
            Section(header: Text("In-App Preferences")) {
                Toggle("Sound", isOn: $viewModel.soundEnabled)
                    .tint(Color("PrimaryTeal"))

                Toggle("Vibration", isOn: $viewModel.vibrationEnabled)
                    .tint(Color("PrimaryTeal"))

                Toggle("Badge Count", isOn: $viewModel.badgeCountEnabled)
                    .tint(Color("PrimaryTeal"))
            }

            // System Permissions Check
            if !viewModel.hasSystemPermission {
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color("ErrorRed"))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Notifications Disabled")
                                .font(.custom("Inter-SemiBold", size: 14))
                                .foregroundColor(Color("ErrorRed"))

                            Text("Enable notifications in device settings")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextSecondary"))
                        }

                        Spacer()

                        Button("Open Settings") {
                            viewModel.openDeviceSettings()
                        }
                        .font(.custom("Inter-Medium", size: 13))
                        .foregroundColor(Color("PrimaryTeal"))
                    }
                }
            }
        }
        .navigationTitle("Notification Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadSettings()
            viewModel.checkSystemPermission()
        }
        .onChange(of: viewModel.bookingUpdates) { _ in viewModel.saveSettings() }
        .onChange(of: viewModel.paymentNotifications) { _ in viewModel.saveSettings() }
        // ... repeat for all settings
    }
}

struct NotificationCategoryToggle: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Text(subtitle)
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color("TextTertiary"))
            }
        }
        .tint(Color("PrimaryTeal"))
    }
}
```

## Interactions

### Master Toggles
1. **Disable Master Toggle**: All category toggles automatically disabled (grayed out)
2. **Enable Master Toggle**: Category toggles become active, retain previous state
3. **First Time Enable (Push)**: Request system permission if not granted

### Category Toggles
1. **Toggle ON**: Saves preference, updates backend
2. **Toggle OFF**: Saves preference, user won't receive this category

### Do Not Disturb
1. **Enable DND**: Time pickers become active
2. **Set Times**: Start and end time selection
3. **During DND Hours**: Non-urgent notifications silenced

### System Permission
1. **Permission Not Granted**: Shows banner with "Open Settings" button
2. **Tap Open Settings**: Opens device Settings app
3. **Return to App**: Re-checks permission status

## States

### Default State
- All toggles reflect saved preferences
- System permission granted
- No warnings shown

### Permission Denied State
```swift
Section {
    HStack {
        Image(systemName: "exclamationmark.triangle.fill")
            .foregroundColor(Color("ErrorRed"))
        VStack(alignment: .leading) {
            Text("Notifications Disabled")
                .font(.custom("Inter-SemiBold", size: 14))
                .foregroundColor(Color("ErrorRed"))
            Text("Enable in device settings")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))
        }
        Spacer()
        Button("Open Settings") { }
    }
}
```

### DND Active State
```swift
// Show indicator if current time is within DND hours
if viewModel.isInDNDPeriod {
    HStack {
        Image(systemName: "moon.fill")
            .foregroundColor(Color("SecondaryOrange"))
        Text("Do Not Disturb is active")
            .font(.custom("Inter-Regular", size: 13))
            .foregroundColor(Color("SecondaryOrange"))
    }
}
```

## API Integration

### Get Notification Preferences
```
GET /customers/{customerId}/notification-preferences

Response:
{
  "success": true,
  "data": {
    "push": {
      "enabled": true,
      "bookingUpdates": true,
      "paymentNotifications": true,
      "promotions": false,
      "serviceReminders": true,
      "providerUpdates": true,
      "reviewReminders": true
    },
    "email": {
      "enabled": true,
      "bookingConfirmations": true,
      "invoices": true,
      "weeklySummary": true,
      "promotions": false,
      "newsletter": false
    },
    "sms": {
      "enabled": true,
      "bookingConfirmations": true,
      "serviceReminders": true,
      "paymentUpdates": true
    },
    "dnd": {
      "enabled": false,
      "startTime": "21:00",
      "endTime": "08:00"
    },
    "inApp": {
      "sound": true,
      "vibration": true,
      "badgeCount": true
    }
  }
}
```

### Update Notification Preferences
```
PUT /customers/{customerId}/notification-preferences

Request:
{
  "push": {
    "enabled": true,
    "bookingUpdates": true,
    "paymentNotifications": true,
    "promotions": false,
    "serviceReminders": true,
    "providerUpdates": true,
    "reviewReminders": true
  },
  "email": { ... },
  "sms": { ... },
  "dnd": { ... },
  "inApp": { ... }
}

Response:
{
  "success": true,
  "message": "Notification preferences updated"
}
```

### Register Device Token (FCM)
```
POST /customers/{customerId}/fcm-token

Request:
{
  "token": "fcm_device_token",
  "platform": "ios",
  "deviceId": "unique_device_id"
}

Response:
{
  "success": true
}
```

## Navigation

### Entry Points
- **From Screen 50** (App Settings): Tap "Notifications"
- **From Screen 21** (Profile): "Notification Settings"
- **From Onboarding**: "Set up Notifications"

### Exit Points
- **Back Button**: Return to previous screen
- **Open Settings**: Opens iOS/Android Settings app

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Enable push notifications")
.accessibilityHint("Double tap to toggle push notifications on or off")

.accessibilityLabel("Do not disturb from 9 PM to 8 AM")
```

### Touch Targets
- All toggle switches: 51x31pt (native iOS)
- Time pickers: 44pt height
- Buttons: 44x44pt minimum

### Dynamic Type
- All text scales with system font size
- Toggles remain fixed size
- Descriptions wrap to multiple lines

## Analytics Events

### Preference Changed
```swift
Analytics.logEvent("notification_preference_changed", parameters: [
    "category": "push_booking_updates",
    "enabled": true
])
```

### DND Enabled
```swift
Analytics.logEvent("dnd_enabled", parameters: [
    "start_time": "21:00",
    "end_time": "08:00"
])
```

### Permission Requested
```swift
Analytics.logEvent("push_permission_requested", parameters: [
    "source": "notification_settings"
])
```

### Permission Status
```swift
Analytics.logEvent("push_permission_status", parameters: [
    "granted": true
])
```

## Testing Checklist

- [ ] Preferences load correctly
- [ ] Master toggles disable/enable categories
- [ ] Push permission request works
- [ ] System permission check works
- [ ] Open device settings works
- [ ] DND time pickers work
- [ ] Time validation (start < end) works
- [ ] Sound toggle works
- [ ] Vibration toggle works
- [ ] Badge count toggle works
- [ ] Preferences save to backend
- [ ] FCM token registration works
- [ ] Email/phone display correctly
- [ ] OTP toggle is always ON and disabled
- [ ] VoiceOver announces toggles correctly

## Design Notes

### Platform-Specific Considerations

**iOS**:
- Native Toggle component
- Request push permission with `UNUserNotificationCenter`
- Open Settings: `UIApplication.openSettingsURLString`
- DND check current time vs. set range

**Android**:
- Material Switch component
- Request notification permission (Android 13+)
- Open Settings: `Settings.ACTION_APPLICATION_DETAILS_SETTINGS`
- DND use AlarmManager for time checks

**Web**:
- Browser notification API
- Email/SMS only (no push on web)
- Custom toggle component

### Validation
- DND start time must be before end time
- If equal, show error: "Start and end time cannot be the same"
- Handle overnight DND (e.g., 10 PM to 6 AM)

### Edge Cases
- User denies permission → Show persistent banner
- User disables in Settings → Re-check on app resume
- Backend save failure → Show error, revert toggle

### Future Enhancements
- Notification preview (test notification)
- Notification history log
- Advanced filtering (by provider, service type)
- Scheduled quiet hours (weekends only)
- Smart notifications (AI-powered timing)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
