# Screen 48: Provider App Settings

## Overview

- **Screen ID**: 48
- **Screen Name**: Provider App Settings
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 23 (Provider Dashboard) → Tap "Settings" icon
  - From: Bottom navigation → "Settings" tab

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  Settings                               │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │    👤                           │    │ Profile Card
│  │    John Doe                     │    │
│  │    ⭐ 4.8 • 156 jobs            │    │
│  │    ID: #PRV123456               │    │
│  │                                 │    │
│  │    [Edit Profile]               │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Account ─────                    │
│                                         │
│  👤 Edit Profile                    →   │ Menu Item
│  📋 Manage Services                 →   │
│  📄 Documents & KYC                 →   │
│  🏦 Bank Accounts                   →   │
│  💰 Earnings & Payouts              →   │
│                                         │
│  ───── Work ─────                       │
│                                         │
│  📅 Availability & Schedule         →   │
│  📍 Service Areas                   →   │
│  📊 Performance Metrics             →   │
│  ⭐ Customer Reviews                →   │
│                                         │
│  ───── Preferences ─────                │
│                                         │
│  🔔 Notifications                   →   │
│  🌐 Language                        →   │
│     English (India)                     │
│  🎨 Theme                           →   │
│     System Default                      │
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
│  ⚖️  Provider Agreement              →   │
│  📊 Data & Privacy                  →   │
│                                         │
│  ───── About ─────                      │
│                                         │
│  ℹ️  About UrbanNest                →   │
│  📱 App Version: 1.2.3                  │
│  🔄 Check for Updates               →   │
│  ⭐ Rate Us on App Store            →   │
│  📤 Share App                       →   │
│                                         │
│  ───── Account Actions ─────            │
│                                         │
│  🔄 Switch to Customer Mode         →   │
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

### 1. Profile Summary Card
- Profile photo, name, rating, total jobs
- Provider ID display
- Quick "Edit Profile" access

### 2. Account Section
- Edit Profile (Screen 44)
- Manage Services (Screen 45)
- Documents & KYC (Screen 46)
- Bank Accounts (Screen 39)
- Earnings & Payouts (Screen 36)

### 3. Work Section
- Availability & Schedule (Screen 30)
- Service Areas management
- Performance Metrics (Screen 41)
- Customer Reviews (Screen 42)

### 4. Preferences
- Notifications (Screen 47)
- Language selection
- Theme (Light/Dark/Auto)
- Sound & Vibration

### 5. Support
- Help Center
- Contact Support (chat/email/phone)
- FAQs
- Emergency Helpline

### 6. Legal
- Terms of Service
- Privacy Policy
- Provider Agreement
- Data & Privacy settings

### 7. About
- App version display
- Update checker
- Rate app
- Share app with others

### 8. Account Actions
- Switch to Customer Mode
- Logout
- Delete Account

## Component Breakdown

```swift
struct ProviderSettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingLogoutConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Profile Card
                ProfileSummaryCard(provider: viewModel.provider)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                // Settings Sections
                SettingsSection(title: "Account") {
                    SettingsRow(icon: "person", title: "Edit Profile", destination: .editProfile)
                    SettingsRow(icon: "wrench.and.screwdriver", title: "Manage Services", destination: .manageServices)
                    SettingsRow(icon: "doc.text", title: "Documents & KYC", destination: .documents)
                    SettingsRow(icon: "building.columns", title: "Bank Accounts", destination: .bankAccounts)
                    SettingsRow(icon: "indianrupeesign.circle", title: "Earnings & Payouts", destination: .earnings)
                }

                SettingsSection(title: "Work") {
                    SettingsRow(icon: "calendar", title: "Availability & Schedule", destination: .availability)
                    SettingsRow(icon: "map", title: "Service Areas", destination: .serviceAreas)
                    SettingsRow(icon: "chart.bar", title: "Performance Metrics", destination: .performance)
                    SettingsRow(icon: "star", title: "Customer Reviews", destination: .reviews)
                }

                SettingsSection(title: "Preferences") {
                    SettingsRow(icon: "bell", title: "Notifications", destination: .notifications)
                    SettingsPickerRow(icon: "globe", title: "Language", value: viewModel.language, options: ["English", "Hindi", "Bengali"])
                    SettingsPickerRow(icon: "paintbrush", title: "Theme", value: viewModel.theme, options: ["Light", "Dark", "System"])
                    SettingsRow(icon: "speaker.wave.2", title: "Sound & Vibration", destination: .soundSettings)
                }

                SettingsSection(title: "Support") {
                    SettingsRow(icon: "questionmark.circle", title: "Help Center", destination: .helpCenter)
                    SettingsRow(icon: "message", title: "Contact Support", destination: .contactSupport)
                    SettingsRow(icon: "list.bullet", title: "FAQs", destination: .faqs)
                    SettingsInfoRow(icon: "phone", title: "Emergency Helpline", value: "+91 1800-XXX-XXXX")
                }

                SettingsSection(title: "Legal") {
                    SettingsRow(icon: "doc.plaintext", title: "Terms of Service", destination: .terms)
                    SettingsRow(icon: "lock.shield", title: "Privacy Policy", destination: .privacy)
                    SettingsRow(icon: "doc.text.fill", title: "Provider Agreement", destination: .providerAgreement)
                    SettingsRow(icon: "hand.raised", title: "Data & Privacy", destination: .dataPrivacy)
                }

                SettingsSection(title: "About") {
                    SettingsRow(icon: "info.circle", title: "About UrbanNest", destination: .about)
                    SettingsInfoRow(icon: "number", title: "App Version", value: "1.2.3")
                    SettingsRow(icon: "arrow.down.circle", title: "Check for Updates", destination: .checkUpdates)
                    SettingsRow(icon: "star.fill", title: "Rate Us", destination: .rateApp)
                    SettingsRow(icon: "square.and.arrow.up", title: "Share App", destination: .shareApp)
                }

                SettingsSection(title: "Account Actions") {
                    SettingsActionRow(icon: "arrow.left.arrow.right", title: "Switch to Customer Mode", action: { viewModel.switchMode() })
                    SettingsActionRow(icon: "rectangle.portrait.and.arrow.right", title: "Logout", action: { showingLogoutConfirmation = true }, isDestructive: false)
                    SettingsActionRow(icon: "trash", title: "Delete Account", action: { viewModel.deleteAccount() }, isDestructive: true)
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
        .alert("Logout", isPresented: $showingLogoutConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Logout", role: .destructive) { viewModel.logout() }
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
}

struct ProfileSummaryCard: View {
    let provider: Provider

    var body: some View {
        HStack(spacing: 16) {
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
            .frame(width: 64, height: 64)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(provider.name)
                    .font(.custom("Inter-SemiBold", size: 18))
                    .foregroundColor(Color("TextPrimary"))

                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(Color("SecondaryOrange"))

                        Text(String(format: "%.1f", provider.rating))
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color("TextPrimary"))
                    }

                    Text("•")
                        .foregroundColor(Color("TextTertiary"))

                    Text("\(provider.totalJobs) jobs")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }

                Text("ID: #\(provider.id)")
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color("TextTertiary"))
            }

            Spacer()
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [Color("PrimaryTeal").opacity(0.1), Color("PrimaryTeal").opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
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

struct SettingsActionRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    var isDestructive: Bool = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(isDestructive ? Color("ErrorRed") : Color("PrimaryTeal"))
                    .frame(width: 24)

                Text(title)
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(isDestructive ? Color("ErrorRed") : Color("TextPrimary"))

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
```

## Navigation

- From Dashboard → Settings (Screen 48)
- Settings → Sub-screens (44-47, 36, 39-43)
- Bottom Tab: Settings icon always accessible

## Testing Checklist

- [ ] All menu items navigate correctly
- [ ] Profile card displays correct data
- [ ] Language/theme pickers work
- [ ] Logout confirmation works
- [ ] Switch mode preserves data
- [ ] Version number displays correctly
- [ ] Deep links work (e.g., notification settings)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web

---

**🎉 PROVIDER APP COMPLETE! All 19 screens (30-48) done!**
