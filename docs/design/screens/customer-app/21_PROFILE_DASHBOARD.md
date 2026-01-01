# Profile Dashboard

## Overview
- **Screen ID**: 21
- **Screen Name**: Profile Dashboard
- **User Flow**: View and manage user profile, settings, and account information
- **Navigation**:
  - Entry: From Bottom Tab Bar "Profile" tab
  - Exit: To various settings screens, support, about
  - Back: Bottom tab navigation

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  Profile                     [Edit]      │ ← Navigation Bar
├──────────────────────────────────────────┤
│                                          │
│  ┌────────────────────────────────────┐ │
│  │                                    │ │ ← Profile Header Card
│  │    [Photo]   Rahul Sharma          │ │
│  │              +91 98765 43210       │ │
│  │              rahul@email.com       │ │
│  │                                    │ │
│  │    📍 Bangalore                    │ │
│  │                                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Account Stats                        │ ← Section Header
│  ┌────────────────────────────────────┐ │
│  │  ┌──────┐  ┌──────┐  ┌──────┐    │ │
│  │  │  12  │  │  8   │  │ ₹9K  │    │ │ ← Stat Cards
│  │  │Total │  │Active│  │Spent │    │ │
│  │  │Bookings  │Bookings  │Total │    │ │
│  │  └──────┘  └──────┘  └──────┘    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🎁 Offers & Rewards                     │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  💰 Wallet Balance: ₹150           │ │
│  │                          [Add]     │ │
│  │  ─────────────────────────         │ │
│  │  🎟️ 2 Active Coupons               │ │
│  │                      [View All]    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ⚙️ Settings                             │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  📍 Saved Addresses           →    │ │
│  │  💳 Payment Methods           →    │ │
│  │  🔔 Notifications             →    │ │
│  │  🌐 Language (English)        →    │ │
│  │  🌓 Dark Mode                 ⚫   │ │ (toggle)
│  └────────────────────────────────────┘ │
│                                          │
│  ℹ️ Support & Legal                     │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  💬 Help & Support            →    │ │
│  │  📄 Terms & Conditions        →    │ │
│  │  🔒 Privacy Policy            →    │ │
│  │  ℹ️ About UrbanNest           →    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  🚪 Sign Out                       │ │ ← Sign Out Button
│  └────────────────────────────────────┘ │
│                                          │
│         Version 1.0.0 (Build 123)       │ ← App Version
│                                          │
├──────────────────────────────────────────┤
│  🏠   📋   📅   👤                       │ ← Bottom Tab Bar
│ Home Services Bookings Profile          │
│                        (selected)        │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt (status bar + notch)
- **Safe Area Bottom**: 49pt (tab bar) + 34pt (home indicator) = 83pt
- **Content Width**: 358pt (16pt padding each side)

### Navigation Bar
- **Height**: 56pt
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Title**: Inter SemiBold 20pt, #1E1E1E / #E0E0E0, left-aligned
- **Edit Button**: Inter Medium 16pt, #0D7377, right-aligned
- **Padding**: 16pt horizontal
- **Border Bottom**: 1pt solid #E0E0E0 / #3A3A3A

### Profile Header Card
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border Radius**: 16pt
- **Shadow**: 0 4px 12px rgba(0,0,0,0.08)
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 20pt
- **Margin**: 16pt horizontal, 20pt top, 20pt bottom

#### Profile Photo
- **Size**: 80x80pt
- **Border Radius**: 40pt (circular)
- **Border**: 3pt solid #0D7377
- **Position**: Center aligned
- **Placeholder**: Initials on colored background if no photo
- **Camera Icon**: 24x24pt camera.fill overlay (bottom-right)

#### User Info
- **Name**: Inter Bold 22pt, #1E1E1E / #E0E0E0
- **Phone**: SF Pro Regular 15pt, #666666 / #A0A0A0
- **Email**: SF Pro Regular 15pt, #666666 / #A0A0A0
- **Icon Spacing**: 8pt between icon and text
- **Line Spacing**: 6pt between fields
- **Alignment**: Center
- **Margin Top**: 16pt from photo

#### Location
- **Icon**: 16x16pt mappin.circle.fill, #0D7377
- **Text**: Inter Medium 14pt, #0D7377
- **Margin Top**: 12pt
- **Alignment**: Center

### Section Headers
- **Typography**: Inter SemiBold 16pt
- **Color**: #1E1E1E / #E0E0E0
- **Icon**: 20x20pt emoji before text, 8pt gap
- **Margin**: 28pt top, 12pt bottom
- **Padding**: 0 16pt

### Account Stats Section
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 20pt 16pt

#### Stat Cards (Grid of 3)
- **Layout**: Horizontal, equal width, 12pt gap
- **Individual Card**:
  - **Background**: #F5F5F5 / #1E1E1E
  - **Border Radius**: 8pt
  - **Padding**: 12pt vertical
  - **Alignment**: Center

  **Value**:
  - Typography: Inter Bold 24pt
  - Color: #0D7377

  **Label**:
  - Typography: SF Pro Regular 12pt
  - Color: #666666 / #A0A0A0
  - Margin Top: 4pt

### Offers & Rewards Section
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 20pt 16pt

#### Wallet Balance Row
- **Icon**: 24x24pt wallet emoji/icon
- **Label**: Inter Medium 15pt, #1E1E1E
- **Amount**: Inter Bold 18pt, #0D7377
- **Add Button**:
  - Height: 32pt
  - Border Radius: 6pt
  - Background: #0D7377
  - Text: Inter Medium 13pt, White
  - Padding: 8pt horizontal

#### Coupons Row
- **Icon**: 20x20pt ticket emoji
- **Label**: SF Pro Regular 14pt, #666666
- **Count**: Inter Medium 14pt, #0D7377
- **View All Button**:
  - Text: Inter Medium 13pt, #0D7377
  - Underline: None
- **Divider**: 1pt solid #E0E0E0, 12pt margin vertical

### Settings Section (List)
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Margin**: 0 16pt 20pt 16pt

#### List Item
- **Height**: 56pt
- **Padding**: 16pt horizontal
- **Border Bottom**: 1pt solid #E0E0E0 / #3A3A3A (except last)
- **Icon**: 20x20pt, #666666, left-aligned
- **Label**: Inter Regular 15pt, #1E1E1E / #E0E0E0
- **Value**: SF Pro Regular 14pt, #999999 (e.g., language name)
- **Arrow/Toggle**: 20x20pt chevron.right or Toggle, right-aligned
- **Active State**: Background #F5F5F5 / #2A2A2A on tap

#### Toggle Switch (Dark Mode)
- **iOS Native**: UISwitch
- **Tint Color**: #0D7377 (on state)
- **Size**: Standard iOS (51x31pt)

### Support & Legal Section
- **Same styling as Settings Section**
- **Items**: Help & Support, Terms, Privacy, About

### Sign Out Button
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: Transparent
- **Border**: 1.5pt solid #EA5455
- **Icon**: 20x20pt rectangle.portrait.and.arrow.right, #EA5455
- **Text**: Inter Medium 16pt, #EA5455
- **Margin**: 16pt horizontal, 20pt top, 24pt bottom
- **Active State**: Background #FFF5F5 / #3D1E1E (dark mode)

### App Version
- **Typography**: SF Pro Regular 12pt
- **Color**: #999999
- **Alignment**: Center
- **Margin**: 16pt bottom

## Components Used

### Existing Components
1. **BottomTabBar**
2. **CustomNavigationBar**
3. **Toggle Switch** (iOS native)

### New Components Needed
1. **ProfileHeaderCard** (photo + user info)
2. **StatCard** (stat display widget)
3. **SettingsListItem** (navigable row)
4. **WalletBalanceCard** (wallet + coupons)
5. **SectionContainer** (white card container)

## Interactions

### Edit Profile Button
- **Action**: Navigate to Edit Profile screen
- **Screen Content**:
  - Change profile photo (camera/gallery)
  - Edit name
  - Edit email
  - Change phone (with OTP verification)
  - Save button
- **Haptic**: Light impact
- **Animation**: Push transition

### Profile Photo Tap
- **Action**: View full-size photo or change photo
- **Options**:
  - Take Photo
  - Choose from Gallery
  - Remove Photo (if exists)
  - Cancel
- **Haptic**: Medium impact
- **Permission**: Camera, Photo Library

### Stat Card Tap
- **Total Bookings**: Navigate to Order History (All tab)
- **Active Bookings**: Navigate to Active Bookings tab
- **Total Spent**: Show spending breakdown modal
- **Haptic**: Light impact

### Add Money to Wallet
- **Action**: Navigate to Add Money screen
- **Screen Content**:
  - Amount input (₹100, ₹500, ₹1000, Custom)
  - Payment method selection
  - Proceed to payment
- **Cashback**: Show "Get 10% cashback" message
- **Haptic**: Medium impact

### View All Coupons
- **Action**: Navigate to Coupons screen
- **Screen Content**:
  - List of active coupons
  - Expired coupons section
  - Apply coupon code input
  - Coupon terms & conditions
- **Haptic**: Light impact

### Saved Addresses Tap
- **Action**: Navigate to Manage Addresses screen
- **Screen Content**:
  - List of saved addresses
  - Add new address
  - Edit/Delete options (swipe actions)
  - Set default address
- **Haptic**: Light impact

### Payment Methods Tap
- **Action**: Navigate to Manage Payment Methods screen
- **Screen Content**:
  - Saved cards/UPI
  - Add new payment method
  - Delete options
  - Set default
- **Haptic**: Light impact

### Notifications Settings Tap
- **Action**: Navigate to Notification Preferences screen
- **Screen Content**:
  - Push notifications toggle
  - Booking updates
  - Promotional offers
  - SMS notifications
  - Email notifications
- **Haptic**: Light impact

### Language Tap
- **Action**: Show language selection bottom sheet
- **Languages**:
  - English (selected by default)
  - Hindi
  - Tamil
  - Telugu
  - Kannada
  - Bengali
- **Selection**: Updates app language
- **Restart**: May require app restart
- **Haptic**: Light impact

### Dark Mode Toggle
- **Action**: Toggle dark mode on/off
- **Immediate**: UI updates instantly
- **Persistence**: Save preference
- **Animation**: Smooth transition (0.3s)
- **Haptic**: Light impact

### Help & Support Tap
- **Action**: Navigate to Help Center
- **Screen Content**:
  - FAQs (categorized)
  - Contact Support (Call, Chat, Email)
  - Raise a Ticket
  - Common Issues
- **Haptic**: Light impact

### Terms & Conditions Tap
- **Action**: Open Terms & Conditions (WebView or native)
- **Content**: Full legal terms
- **Action**: Back to close
- **Haptic**: Light impact

### Privacy Policy Tap
- **Action**: Open Privacy Policy (WebView or native)
- **Content**: Full privacy policy
- **Haptic**: Light impact

### About UrbanNest Tap
- **Action**: Navigate to About screen
- **Screen Content**:
  - App description
  - Version info
  - Company info
  - Contact details
  - Social media links
  - Rate us on App Store
- **Haptic**: Light impact

### Sign Out Button Tap
- **Action**: Sign out user
- **Confirmation**: Alert dialog
  - Title: "Sign Out?"
  - Message: "Are you sure you want to sign out?"
  - Buttons: [Cancel, Sign Out (red)]
- **Process**:
  1. Clear user session
  2. Clear cached data (optional)
  3. Unregister push notifications
  4. Navigate to Login screen
- **Analytics**: Log sign_out event
- **Haptic**: Error feedback

### Version Number Long Press
- **Action**: Copy version info to clipboard
- **Feedback**: Toast "Version info copied"
- **Haptic**: Success feedback
- **Easter Egg**: Show developer menu after 5 consecutive taps (debug builds only)

## States

### Default State (Logged In)
- **Profile**: User photo, name, phone, email displayed
- **Stats**: Loaded from backend
- **Wallet**: Current balance displayed
- **Coupons**: Active coupon count
- **All Sections**: Visible and interactive

### Loading State (Initial)
- **Profile Header**: Skeleton loader
- **Stats**: Shimmer placeholders
- **Other Sections**: Skeleton rows
- **Duration**: While fetching user data

### Incomplete Profile
- **Missing Photo**: Show placeholder with "Add Photo" text
- **Missing Email**: Show "Add Email" placeholder
- **Banner**: "Complete your profile for better experience"
- **CTA**: "Complete Profile" button

### Empty Wallet
- **Balance**: ₹0
- **Message**: "Add money to get 10% cashback"
- **CTA**: "Add Money" button highlighted

### No Active Coupons
- **Count**: 0 Active Coupons
- **Message**: "Check available offers"
- **CTA**: "Browse Offers"

### Network Error
- **Show**: Error banner at top
- **Message**: "Unable to load profile. Tap to retry."
- **Retry**: Tap banner to reload
- **Offline Icon**: WiFi slash icon

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Card Border**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Text Tertiary**: #666666
- **Stat Card BG**: #1E1E1E (darker)
- **Dividers**: #3A3A3A
- **Profile Border**: #14A0A5 (lighter teal)

## Accessibility

### VoiceOver Labels
- **Profile Photo**: "Profile picture of [Name]. Double tap to change."
- **Name**: "[Name], heading"
- **Phone**: "Phone number [number]"
- **Email**: "Email [email]"
- **Stat Card**: "[Value] [Label]. Double tap to view details."
- **Wallet**: "Wallet balance ₹150. Double tap to add money."
- **Coupons**: "2 active coupons. Double tap to view all."
- **Settings Item**: "[Setting name]. [Current value]. Double tap to change."
- **Dark Mode**: "Dark mode, toggle button, currently [on/off]. Double tap to toggle."
- **Sign Out**: "Sign out, button. Double tap to sign out of your account."

### VoiceOver Hints
- **Edit Button**: "Double tap to edit your profile information"
- **Settings Item**: "Double tap to open [setting name] settings"
- **Sign Out**: "Double tap to sign out. Confirmation required."

### VoiceOver Groups
- Group profile header as single element
- Group each stat card separately
- Group each settings section

### Dynamic Type Support
- All text scales from -2 to +3
- Card heights adjust dynamically
- Stat cards stack vertically on largest text size
- Minimum button touch target: 44x44pt

### Color Contrast
- All text meets WCAG AA (4.5:1 minimum)
- Sign out button text clearly visible
- Toggle switch has clear on/off states

### Reduced Motion
- Disable dark mode transition animation
- Use fade instead of slide for navigation
- Static skeleton loaders (no shimmer)

## Analytics Events

### Screen View
```json
{
  "screen_name": "profile_dashboard",
  "profile_complete_percentage": 85,
  "wallet_balance": 150,
  "active_coupons": 2,
  "total_bookings": 12
}
```

### Edit Profile
```json
{
  "event": "edit_profile_opened",
  "source": "profile_dashboard"
}
```

### Stat Card Tapped
```json
{
  "event": "profile_stat_tapped",
  "stat_type": "total_bookings", // or active_bookings, total_spent
  "stat_value": 12
}
```

### Settings Opened
```json
{
  "event": "settings_item_opened",
  "setting_name": "saved_addresses", // or payment_methods, notifications, etc.
  "source": "profile_dashboard"
}
```

### Dark Mode Toggled
```json
{
  "event": "dark_mode_toggled",
  "enabled": true,
  "source": "profile_dashboard"
}
```

### Language Changed
```json
{
  "event": "language_changed",
  "from_language": "en",
  "to_language": "hi"
}
```

### Sign Out
```json
{
  "event": "sign_out",
  "total_bookings": 12,
  "wallet_balance": 150,
  "session_duration_minutes": 45
}
```

### Wallet Action
```json
{
  "event": "add_money_initiated",
  "current_balance": 150,
  "source": "profile_dashboard"
}
```

### Coupons Viewed
```json
{
  "event": "coupons_viewed",
  "active_coupons_count": 2,
  "source": "profile_dashboard"
}
```

## SwiftUI Implementation

### View Structure
```swift
struct ProfileDashboardView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showEditProfile = false
    @State private var showLanguagePicker = false
    @State private var showSignOutAlert = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Profile Header
                    ProfileHeaderCard(
                        user: viewModel.user,
                        onPhotoTap: changeProfilePhoto,
                        onEditTap: { showEditProfile = true }
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 20)

                    // Account Stats
                    SectionHeader(icon: "📊", title: "Account Stats")

                    AccountStatsSection(
                        totalBookings: viewModel.totalBookings,
                        activeBookings: viewModel.activeBookings,
                        totalSpent: viewModel.totalSpent,
                        onStatTap: handleStatTap
                    )

                    // Offers & Rewards
                    SectionHeader(icon: "🎁", title: "Offers & Rewards")

                    WalletAndCouponsCard(
                        walletBalance: viewModel.walletBalance,
                        activeCoupons: viewModel.activeCoupons,
                        onAddMoney: navigateToAddMoney,
                        onViewCoupons: navigateToCoupons
                    )

                    // Settings
                    SectionHeader(icon: "⚙️", title: "Settings")

                    SectionContainer {
                        VStack(spacing: 0) {
                            SettingsListItem(
                                icon: "mappin.circle",
                                title: "Saved Addresses",
                                action: { navigate(to: .savedAddresses) }
                            )

                            SettingsListItem(
                                icon: "creditcard",
                                title: "Payment Methods",
                                action: { navigate(to: .paymentMethods) }
                            )

                            SettingsListItem(
                                icon: "bell",
                                title: "Notifications",
                                action: { navigate(to: .notifications) }
                            )

                            SettingsListItem(
                                icon: "globe",
                                title: "Language",
                                value: viewModel.currentLanguage,
                                action: { showLanguagePicker = true }
                            )

                            SettingsListItem(
                                icon: "moon",
                                title: "Dark Mode",
                                trailing: .toggle(
                                    isOn: $isDarkMode,
                                    onChange: { toggleDarkMode($0) }
                                ),
                                showDivider: false
                            )
                        }
                    }

                    // Support & Legal
                    SectionHeader(icon: "ℹ️", title: "Support & Legal")

                    SectionContainer {
                        VStack(spacing: 0) {
                            SettingsListItem(
                                icon: "questionmark.circle",
                                title: "Help & Support",
                                action: { navigate(to: .helpCenter) }
                            )

                            SettingsListItem(
                                icon: "doc.text",
                                title: "Terms & Conditions",
                                action: { navigate(to: .terms) }
                            )

                            SettingsListItem(
                                icon: "lock.shield",
                                title: "Privacy Policy",
                                action: { navigate(to: .privacy) }
                            )

                            SettingsListItem(
                                icon: "info.circle",
                                title: "About UrbanNest",
                                action: { navigate(to: .about) },
                                showDivider: false
                            )
                        }
                    }

                    // Sign Out
                    Button(action: { showSignOutAlert = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 20))

                            Text("Sign Out")
                                .font(.custom("Inter-Medium", size: 16))
                        }
                        .foregroundColor(.error)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.error, lineWidth: 1.5)
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 24)

                    // App Version
                    Text("Version \(viewModel.appVersion)")
                        .font(.system(size: 12))
                        .foregroundColor(.textTertiary)
                        .padding(.bottom, 16)
                        .onLongPressGesture {
                            copyVersionInfo()
                        }
                }
            }
            .background(Color.gray100.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Profile")
                        .font(.custom("Inter-SemiBold", size: 20))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showEditProfile = true
                    }
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(.primary)
                }
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(user: viewModel.user) { updatedUser in
                    viewModel.updateUser(updatedUser)
                    showEditProfile = false
                }
            }
            .sheet(isPresented: $showLanguagePicker) {
                LanguagePickerSheet(
                    currentLanguage: viewModel.currentLanguage,
                    onSelect: { language in
                        viewModel.changeLanguage(to: language)
                        showLanguagePicker = false
                    }
                )
            }
            .alert("Sign Out?", isPresented: $showSignOutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    signOut()
                }
            } message: {
                Text("Are you sure you want to sign out?")
            }
            .onAppear {
                loadProfileData()

                Analytics.logScreenView("profile_dashboard", parameters: [
                    "profile_complete_percentage": viewModel.profileCompletionPercentage,
                    "wallet_balance": viewModel.walletBalance,
                    "total_bookings": viewModel.totalBookings
                ])
            }
        }
    }

    // MARK: - Actions

    private func loadProfileData() {
        Task {
            await viewModel.loadUserProfile()
            await viewModel.loadAccountStats()
        }
    }

    private func changeProfilePhoto() {
        HapticFeedback.medium()

        let picker = ProfilePhotoPicker { image in
            Task {
                await viewModel.updateProfilePhoto(image)
            }
        }
        presentImagePicker(picker)
    }

    private func handleStatTap(_ statType: StatType) {
        HapticFeedback.light()

        Analytics.logEvent("profile_stat_tapped", parameters: [
            "stat_type": statType.rawValue,
            "stat_value": statType.getValue(from: viewModel)
        ])

        switch statType {
        case .totalBookings:
            navigationController?.push(OrderHistoryView())
        case .activeBookings:
            tabBarController?.selectedIndex = 2 // Bookings tab
        case .totalSpent:
            presentSpendingBreakdownModal()
        }
    }

    private func navigateToAddMoney() {
        HapticFeedback.medium()

        Analytics.logEvent("add_money_initiated", parameters: [
            "current_balance": viewModel.walletBalance,
            "source": "profile_dashboard"
        ])

        navigationController?.push(AddMoneyView())
    }

    private func navigateToCoupons() {
        HapticFeedback.light()

        Analytics.logEvent("coupons_viewed", parameters: [
            "active_coupons_count": viewModel.activeCoupons,
            "source": "profile_dashboard"
        ])

        navigationController?.push(CouponsView())
    }

    private func navigate(to destination: ProfileDestination) {
        HapticFeedback.light()

        Analytics.logEvent("settings_item_opened", parameters: [
            "setting_name": destination.rawValue,
            "source": "profile_dashboard"
        ])

        let view = destination.createView()
        navigationController?.push(view)
    }

    private func toggleDarkMode(_ enabled: Bool) {
        isDarkMode = enabled
        HapticFeedback.light()

        Analytics.logEvent("dark_mode_toggled", parameters: [
            "enabled": enabled,
            "source": "profile_dashboard"
        ])

        // Apply dark mode
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = enabled ? .dark : .light
    }

    private func signOut() {
        HapticFeedback.error()

        Analytics.logEvent("sign_out", parameters: [
            "total_bookings": viewModel.totalBookings,
            "wallet_balance": viewModel.walletBalance
        ])

        Task {
            await viewModel.signOut()

            // Navigate to login
            navigationController?.setViewControllers([LoginView()], animated: true)
        }
    }

    private func copyVersionInfo() {
        UIPasteboard.general.string = "UrbanNest \(viewModel.appVersion)"
        HapticFeedback.success()
        ToastManager.show("Version info copied")
    }

    private func presentSpendingBreakdownModal() {
        let modal = SpendingBreakdownSheet(
            totalSpent: viewModel.totalSpent,
            breakdown: viewModel.spendingBreakdown
        )
        presentSheet(modal)
    }
}
```

### ViewModel
```swift
class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var totalBookings: Int = 0
    @Published var activeBookings: Int = 0
    @Published var totalSpent: Double = 0
    @Published var walletBalance: Double = 0
    @Published var activeCoupons: Int = 0
    @Published var currentLanguage: String = "English"
    @Published var isLoading: Bool = false

    var profileCompletionPercentage: Int {
        calculateProfileCompletion()
    }

    var appVersion: String {
        "\(Bundle.main.appVersion) (Build \(Bundle.main.buildNumber))"
    }

    var spendingBreakdown: [SpendingCategory] {
        // Calculate spending by category
        []
    }

    private let userService: UserService
    private let walletService: WalletService
    private let bookingService: BookingService

    init() {
        self.userService = UserService()
        self.walletService = WalletService()
        self.bookingService = BookingService()
    }

    func loadUserProfile() async {
        isLoading = true
        do {
            user = try await userService.getCurrentUser()
            walletBalance = try await walletService.getBalance()
            activeCoupons = try await walletService.getActiveCouponsCount()
            isLoading = false
        } catch {
            print("Error loading profile: \(error)")
            isLoading = false
        }
    }

    func loadAccountStats() async {
        do {
            let stats = try await bookingService.getUserStats()
            totalBookings = stats.totalBookings
            activeBookings = stats.activeBookings
            totalSpent = stats.totalSpent
        } catch {
            print("Error loading stats: \(error)")
        }
    }

    func updateUser(_ updatedUser: User) {
        user = updatedUser
        Task {
            try await userService.updateUser(updatedUser)
        }
    }

    func updateProfilePhoto(_ image: UIImage) async {
        do {
            let photoURL = try await userService.uploadProfilePhoto(image)
            user?.photoURL = photoURL
            ToastManager.show("Profile photo updated")
        } catch {
            ToastManager.show("Failed to update photo", type: .error)
        }
    }

    func changeLanguage(to language: String) {
        currentLanguage = language

        Analytics.logEvent("language_changed", parameters: [
            "to_language": language
        ])

        // Update app language
        LocalizationManager.shared.setLanguage(language)

        // May require app restart
        showRestartAlert()
    }

    func signOut() async {
        do {
            try await userService.signOut()

            // Clear local data
            UserDefaults.standard.removeObject(forKey: "userId")

            // Unregister push notifications
            await PushNotificationManager.shared.unregister()
        } catch {
            ToastManager.show("Failed to sign out", type: .error)
        }
    }

    private func calculateProfileCompletion() -> Int {
        guard let user = user else { return 0 }

        var score = 0
        let totalFields = 5

        if user.name != nil { score += 1 }
        if user.email != nil { score += 1 }
        if user.phone != nil { score += 1 }
        if user.photoURL != nil { score += 1 }
        if user.addresses?.count ?? 0 > 0 { score += 1 }

        return Int((Double(score) / Double(totalFields)) * 100)
    }

    private func showRestartAlert() {
        AlertManager.show(
            title: "Restart Required",
            message: "Please restart the app to apply language changes.",
            primaryButton: "OK"
        )
    }
}

enum StatType: String {
    case totalBookings
    case activeBookings
    case totalSpent

    func getValue(from viewModel: ProfileViewModel) -> Any {
        switch self {
        case .totalBookings:
            return viewModel.totalBookings
        case .activeBookings:
            return viewModel.activeBookings
        case .totalSpent:
            return viewModel.totalSpent
        }
    }
}

enum ProfileDestination: String {
    case savedAddresses
    case paymentMethods
    case notifications
    case helpCenter
    case terms
    case privacy
    case about

    func createView() -> some View {
        switch self {
        case .savedAddresses:
            return AnyView(SavedAddressesView())
        case .paymentMethods:
            return AnyView(PaymentMethodsView())
        case .notifications:
            return AnyView(NotificationSettingsView())
        case .helpCenter:
            return AnyView(HelpCenterView())
        case .terms:
            return AnyView(TermsConditionsView())
        case .privacy:
            return AnyView(PrivacyPolicyView())
        case .about:
            return AnyView(AboutView())
        }
    }
}
```

### Component: ProfileHeaderCard
```swift
struct ProfileHeaderCard: View {
    let user: User?
    let onPhotoTap: () -> Void
    let onEditTap: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Profile Photo
            Button(action: onPhotoTap) {
                ZStack(alignment: .bottomTrailing) {
                    if let photoURL = user?.photoURL {
                        AsyncImage(url: URL(string: photoURL)) { image in
                            image.resizable()
                        } placeholder: {
                            InitialsPlaceholder(name: user?.name ?? "")
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    } else {
                        InitialsPlaceholder(name: user?.name ?? "")
                            .frame(width: 80, height: 80)
                    }

                    // Camera Icon
                    Image(systemName: "camera.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .background(Color.primary)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .overlay(
                    Circle()
                        .stroke(Color.primary, lineWidth: 3)
                )
            }

            // User Info
            VStack(spacing: 6) {
                Text(user?.name ?? "User")
                    .font(.custom("Inter-Bold", size: 22))
                    .foregroundColor(.textPrimary)

                if let phone = user?.phone {
                    Text(phone)
                        .font(.system(size: 15))
                        .foregroundColor(.textSecondary)
                }

                if let email = user?.email {
                    Text(email)
                        .font(.system(size: 15))
                        .foregroundColor(.textSecondary)
                }
            }

            // Location
            if let city = user?.city {
                HStack(spacing: 6) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)

                    Text(city)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.primary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }
}

struct InitialsPlaceholder: View {
    let name: String

    var initials: String {
        let components = name.components(separatedBy: " ")
        return components.compactMap { $0.first }.prefix(2).map { String($0) }.joined()
    }

    var body: some View {
        Text(initials)
            .font(.custom("Inter-Bold", size: 32))
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .background(Color.primary)
            .clipShape(Circle())
    }
}
```

### Component: AccountStatsSection
```swift
struct AccountStatsSection: View {
    let totalBookings: Int
    let activeBookings: Int
    let totalSpent: Double
    let onStatTap: (StatType) -> Void

    var body: some View {
        HStack(spacing: 12) {
            StatCard(
                value: "\(totalBookings)",
                label: "Total\nBookings",
                onTap: { onStatTap(.totalBookings) }
            )

            StatCard(
                value: "\(activeBookings)",
                label: "Active\nBookings",
                onTap: { onStatTap(.activeBookings) }
            )

            StatCard(
                value: "₹\(formatCurrency(totalSpent))",
                label: "Total\nSpent",
                onTap: { onStatTap(.totalSpent) }
            )
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray300, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }

    private func formatCurrency(_ amount: Double) -> String {
        if amount >= 1000 {
            return String(format: "%.1fK", amount / 1000)
        }
        return String(format: "%.0f", amount)
    }
}

struct StatCard: View {
    let value: String
    let label: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Text(value)
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(.primary)

                Text(label)
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.gray100)
            .cornerRadius(8)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
```

## Performance Optimization

### Data Loading
- Cache user profile locally
- Lazy load account stats
- Cache profile photo
- Refresh on pull-to-refresh only

### UI Optimization
- Static content (no heavy animations)
- Minimal re-renders
- Fast scrolling (no lazy loading issues)

## Testing Checklist

### Functional
- ✅ Load user profile on screen open
- ✅ Edit profile updates data
- ✅ Change profile photo works
- ✅ Stat cards navigate correctly
- ✅ Wallet navigation works
- ✅ Coupons navigation works
- ✅ All settings navigate correctly
- ✅ Dark mode toggle works
- ✅ Language picker works
- ✅ Sign out confirmation works
- ✅ Version long press copies

### Visual
- ✅ Light mode
- ✅ Dark mode
- ✅ iPhone SE
- ✅ iPhone 14 Pro Max
- ✅ Dynamic Type
- ✅ VoiceOver navigation
- ✅ Profile photo placeholder

### Edge Cases
- ✅ No profile photo
- ✅ Long name
- ✅ Missing email
- ✅ Zero bookings
- ✅ Empty wallet
- ✅ No coupons
- ✅ Network error
