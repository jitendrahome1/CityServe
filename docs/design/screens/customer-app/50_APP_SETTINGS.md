# Screen 50: App Settings

## Overview

- **Screen ID**: 50
- **Screen Name**: App Settings
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 21 (Profile Dashboard) → Tap "Settings"
  - From: Bottom navigation → "More" tab → "Settings"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  Settings                               │ Header
├─────────────────────────────────────────┤
│                                         │
│  ───── Account ─────                    │
│                                         │
│  👤 Edit Profile                    →   │ Menu Item
│  💳 Payment Methods                 →   │
│  📍 Saved Addresses                 →   │
│  🔔 Notifications                   →   │
│                                         │
│  ───── Preferences ─────                │
│                                         │
│  🌐 Language                        →   │
│     English (India)                     │ Current Value
│                                         │
│  🎨 Theme                           →   │
│     System Default                      │
│                                         │
│  🔊 Sound & Vibration               →   │
│                                         │
│  ───── Support ─────                    │
│                                         │
│  ❓ Help Center                     →   │
│  💬 Contact Support                 →   │
│  📋 FAQs                            →   │
│  📞 Emergency Helpline              →   │
│     +91 1800-XXX-XXXX                   │
│                                         │
│  ───── Legal ─────                      │
│                                         │
│  📜 Terms of Service                →   │
│  🔒 Privacy Policy                  →   │
│  ⚖️  User Agreement                 →   │
│  📊 Data & Privacy                  →   │
│                                         │
│  ───── About ─────                      │
│                                         │
│  ℹ️  About UrbanNest                →   │
│  📱 App Version: 1.2.3                  │
│  🔄 Check for Updates               →   │
│  ⭐ Rate Us                         →   │
│  📤 Share App                       →   │
│                                         │
│  ───── Data & Cache ─────               │
│                                         │
│  🗑️  Clear Cache                    →   │
│     Cache size: 45 MB                   │
│                                         │
│  📥 Download Data                   →   │
│     Export your data (GDPR)             │
│                                         │
│  ───── Account Actions ─────            │
│                                         │
│  🚪 Logout                          →   │
│  🗑️  Delete Account                 →   │
│                                         │
│  ───────────────────────────────        │
│  Made with ❤️ in India                  │
│  © 2025 UrbanNest. All rights reserved. │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Account Section
- Edit Profile (Screen 46)
- Payment Methods (Screen 48)
- Saved Addresses (Screen 47)
- Notifications (Screen 49)

### 2. Preferences
- **Language**: Change app language
  - English (India)
  - हिन्दी (Hindi)
  - বাংলা (Bengali)
  - தமிழ் (Tamil)
  - తెలుగు (Telugu)
  - मराठी (Marathi)
- **Theme**: Light, Dark, System Default
- **Sound & Vibration**: Toggle sound effects and haptics

### 3. Support
- Help Center (Screen 43)
- Contact Support (Screen 44)
- FAQs
- Emergency Helpline (always visible)

### 4. Legal
- Terms of Service
- Privacy Policy
- User Agreement
- Data & Privacy settings

### 5. About
- About UrbanNest (company info)
- App version display
- Check for updates
- Rate app (App Store/Play Store)
- Share app with friends

### 6. Data & Cache
- Clear cache (with size display)
- Download user data (GDPR compliance)

### 7. Account Actions
- Logout (with confirmation)
- Delete Account (with multi-step confirmation)

### 8. Footer
- Made with love in India
- Copyright notice

## Component Breakdown

```swift
struct AppSettingsView: View {
    @StateObject private var viewModel = AppSettingsViewModel()
    @State private var showLogoutConfirmation = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Account Section
                SettingsSection(title: "Account") {
                    SettingsRow(icon: "person", title: "Edit Profile", destination: .editProfile)
                    SettingsRow(icon: "creditcard", title: "Payment Methods", destination: .paymentMethods)
                    SettingsRow(icon: "mappin.circle", title: "Saved Addresses", destination: .savedAddresses)
                    SettingsRow(icon: "bell", title: "Notifications", destination: .notifications)
                }

                // Preferences Section
                SettingsSection(title: "Preferences") {
                    SettingsPickerRow(
                        icon: "globe",
                        title: "Language",
                        value: viewModel.language.displayName,
                        destination: .language
                    )

                    SettingsPickerRow(
                        icon: "paintbrush",
                        title: "Theme",
                        value: viewModel.theme.displayName,
                        destination: .theme
                    )

                    SettingsRow(
                        icon: "speaker.wave.2",
                        title: "Sound & Vibration",
                        destination: .soundSettings
                    )
                }

                // Support Section
                SettingsSection(title: "Support") {
                    SettingsRow(icon: "questionmark.circle", title: "Help Center", destination: .helpCenter)
                    SettingsRow(icon: "message", title: "Contact Support", destination: .contactSupport)
                    SettingsRow(icon: "list.bullet", title: "FAQs", destination: .faqs)
                    SettingsInfoRow(
                        icon: "phone",
                        title: "Emergency Helpline",
                        value: "+91 1800-XXX-XXXX",
                        action: { viewModel.callHelpline() }
                    )
                }

                // Legal Section
                SettingsSection(title: "Legal") {
                    SettingsRow(icon: "doc.plaintext", title: "Terms of Service", destination: .terms)
                    SettingsRow(icon: "lock.shield", title: "Privacy Policy", destination: .privacy)
                    SettingsRow(icon: "doc.text.fill", title: "User Agreement", destination: .userAgreement)
                    SettingsRow(icon: "hand.raised", title: "Data & Privacy", destination: .dataPrivacy)
                }

                // About Section
                SettingsSection(title: "About") {
                    SettingsRow(icon: "info.circle", title: "About UrbanNest", destination: .about)
                    SettingsInfoRow(icon: "number", title: "App Version", value: viewModel.appVersion)
                    SettingsRow(icon: "arrow.down.circle", title: "Check for Updates", destination: .checkUpdates)
                    SettingsRow(icon: "star.fill", title: "Rate Us", destination: .rateApp)
                    SettingsRow(icon: "square.and.arrow.up", title: "Share App", destination: .shareApp)
                }

                // Data & Cache Section
                SettingsSection(title: "Data & Cache") {
                    SettingsActionRow(
                        icon: "trash",
                        title: "Clear Cache",
                        subtitle: "Cache size: \(viewModel.cacheSize)",
                        action: { viewModel.clearCache() }
                    )

                    SettingsActionRow(
                        icon: "arrow.down.doc",
                        title: "Download Data",
                        subtitle: "Export your data (GDPR)",
                        action: { viewModel.downloadData() }
                    )
                }

                // Account Actions Section
                SettingsSection(title: "Account Actions") {
                    SettingsActionRow(
                        icon: "rectangle.portrait.and.arrow.right",
                        title: "Logout",
                        action: { showLogoutConfirmation = true },
                        isDestructive: false
                    )

                    SettingsActionRow(
                        icon: "trash",
                        title: "Delete Account",
                        action: { showDeleteConfirmation = true },
                        isDestructive: true
                    )
                }

                // Footer
                VStack(spacing: 8) {
                    Divider()
                    Text("Made with ❤️ in India")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                    Text("© 2025 UrbanNest. All rights reserved.")
                        .font(.custom("Inter-Regular", size: 10))
                        .foregroundColor(Color("TextTertiary"))
                }
                .padding(.vertical, 24)
            }
        }
        .navigationTitle("Settings")
        .alert("Logout", isPresented: $showLogoutConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Logout", role: .destructive) {
                viewModel.logout()
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
        .alert("Delete Account", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.showDeleteAccountFlow()
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
    }
}

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.custom("Inter-SemiBold", size: 13))
                .foregroundColor(Color("TextSecondary"))
                .textCase(.uppercase)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)

            content

            Divider()
                .padding(.top, 8)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let destination: SettingsDestination

    var body: some View {
        NavigationLink(destination: destination.view) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color("PrimaryTeal"))
                    .frame(width: 24)

                Text(title)
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SettingsPickerRow: View {
    let icon: String
    let title: String
    let value: String
    let destination: SettingsDestination

    var body: some View {
        NavigationLink(destination: destination.view) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color("PrimaryTeal"))
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.custom("Inter-Regular", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    Text(value)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SettingsInfoRow: View {
    let icon: String
    let title: String
    let value: String
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(action != nil ? Color("PrimaryTeal") : Color("TextTertiary"))
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.custom("Inter-Regular", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    Text(value)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(action == nil)
    }
}

struct SettingsActionRow: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    let action: () -> Void
    var isDestructive: Bool = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(isDestructive ? Color("ErrorRed") : Color("PrimaryTeal"))
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.custom("Inter-Regular", size: 15))
                        .foregroundColor(isDestructive ? Color("ErrorRed") : Color("TextPrimary"))

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
    }
}

enum SettingsDestination {
    case editProfile
    case paymentMethods
    case savedAddresses
    case notifications
    case language
    case theme
    case soundSettings
    case helpCenter
    case contactSupport
    case faqs
    case terms
    case privacy
    case userAgreement
    case dataPrivacy
    case about
    case checkUpdates
    case rateApp
    case shareApp

    @ViewBuilder
    var view: some View {
        switch self {
        case .editProfile: EditCustomerProfileView()
        case .paymentMethods: PaymentMethodsView()
        case .savedAddresses: SavedAddressesView()
        case .notifications: NotificationSettingsView()
        case .language: LanguageSettingsView()
        case .theme: ThemeSettingsView()
        case .soundSettings: SoundSettingsView()
        case .helpCenter: HelpCenterView()
        case .contactSupport: ContactSupportView()
        case .faqs: FAQsView()
        case .terms: TermsOfServiceView()
        case .privacy: PrivacyPolicyView()
        case .userAgreement: UserAgreementView()
        case .dataPrivacy: DataPrivacyView()
        case .about: AboutView()
        case .checkUpdates: CheckUpdatesView()
        case .rateApp: RateAppView()
        case .shareApp: ShareAppView()
        }
    }
}

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case hindi = "hi"
    case bengali = "bn"
    case tamil = "ta"
    case telugu = "te"
    case marathi = "mr"

    var displayName: String {
        switch self {
        case .english: return "English (India)"
        case .hindi: return "हिन्दी (Hindi)"
        case .bengali: return "বাংলা (Bengali)"
        case .tamil: return "தமிழ் (Tamil)"
        case .telugu: return "తెలుగు (Telugu)"
        case .marathi: return "मराठी (Marathi)"
        }
    }
}

enum AppTheme: String, CaseIterable {
    case light = "light"
    case dark = "dark"
    case system = "system"

    var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System Default"
        }
    }
}
```

## Interactions

### Navigation
1. **Tap Row**: Navigates to corresponding screen
2. **Tap Action Row**: Executes action (e.g., logout, clear cache)

### Language Change
1. **Tap Language**: Shows language picker
2. **Select Language**: Applies immediately, restarts app

### Theme Change
1. **Tap Theme**: Shows theme picker
2. **Select Theme**: Applies immediately

### Logout
1. **Tap Logout**: Shows confirmation alert
2. **Confirm**: Logs out, returns to login screen

### Delete Account
1. **Tap Delete**: Shows first confirmation
2. **Confirm**: Shows second screen with password verification
3. **Enter Password**: Validates
4. **Final Confirm**: Deletes account, returns to onboarding

### Clear Cache
1. **Tap Clear Cache**: Shows confirmation
2. **Confirm**: Clears app cache, shows success toast

### Download Data
1. **Tap Download Data**: Initiates data export
2. **Processing**: Shows progress indicator
3. **Complete**: Email sent with download link

## States

### Default State
- All settings loaded from preferences
- Cache size calculated
- App version displayed

### Loading State
```swift
ProgressView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
```

### Logout State
```swift
viewModel.isLoggingOut = true
// Show loading overlay
// Disable all interactions
```

## API Integration

### Get App Settings
```
GET /customers/{customerId}/app-settings

Response:
{
  "success": true,
  "data": {
    "language": "en",
    "theme": "system",
    "sound": true,
    "vibration": true,
    "appVersion": "1.2.3",
    "cacheSize": "45 MB"
  }
}
```

### Update App Settings
```
PUT /customers/{customerId}/app-settings

Request:
{
  "language": "hi",
  "theme": "dark"
}

Response:
{
  "success": true,
  "message": "Settings updated"
}
```

### Logout
```
POST /auth/logout

Request:
{
  "deviceId": "unique_device_id"
}

Response:
{
  "success": true,
  "message": "Logged out successfully"
}
```

### Delete Account
```
DELETE /customers/{customerId}/account

Request:
{
  "password": "current_password",
  "reason": "optional_reason"
}

Response:
{
  "success": true,
  "message": "Account deleted successfully"
}
```

### Download User Data
```
POST /customers/{customerId}/download-data

Response:
{
  "success": true,
  "data": {
    "downloadUrl": "https://storage.../data_export.zip",
    "expiresAt": "2026-01-07T10:00:00Z"
  },
  "message": "Data export ready. Link sent to your email."
}
```

## Navigation

### Entry Points
- **From Screen 21** (Profile Dashboard): Tap "Settings"
- **From Bottom Navigation**: "More" → "Settings"

### Exit Points
- Each row navigates to respective screen
- Logout returns to login screen
- Delete account returns to onboarding

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Language settings")
.accessibilityValue("English (India)")
.accessibilityHint("Double tap to change language")
```

### Touch Targets
- All rows: 44pt minimum height
- Icons: 24x24pt
- Chevrons: Tap area extends to full row

## Analytics Events

### Settings Viewed
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "app_settings"
])
```

### Setting Changed
```swift
Analytics.logEvent("setting_changed", parameters: [
    "setting": "language",
    "value": "hindi"
])
```

### Logout
```swift
Analytics.logEvent("user_logout", parameters: [
    "source": "settings"
])
```

### Account Deleted
```swift
Analytics.logEvent("account_deleted", parameters: [
    "reason": deletionReason
])
```

## Testing Checklist

- [ ] All navigation links work
- [ ] Language change applies correctly
- [ ] Theme change applies correctly
- [ ] Logout confirmation shows
- [ ] Logout works correctly
- [ ] Delete account multi-step confirmation
- [ ] Clear cache works
- [ ] Cache size displays correctly
- [ ] Download data initiates export
- [ ] Help phone number calls correctly
- [ ] App version displays correctly
- [ ] Footer displays correctly

## Design Notes

### Platform-Specific

**iOS**:
- Native navigation
- Native alerts
- System font scaling

**Android**:
- Material design
- Material dialogs
- Theme switching

**Web**:
- Responsive layout
- Browser-based navigation

### Edge Cases
- Handle logout failure
- Handle account deletion failure
- Cache clear failure

### Future Enhancements
- Two-factor authentication
- Biometric login settings
- Auto-update toggle
- Developer mode (hidden)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
