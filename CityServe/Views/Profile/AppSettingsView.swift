//
//  AppSettingsView.swift
//  CityServe
//
//  Unified app settings hub for account, preferences, support, and legal
//  Design Spec: 50_APP_SETTINGS.md
//

import SwiftUI
import Combine

struct AppSettingsView: View {

    @StateObject private var viewModel = AppSettingsViewModel()
    @State private var showLogoutConfirmation = false
    @State private var showDeleteConfirmation = false
    @State private var showClearCacheConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Account Section
                SettingsSection(title: "Account") {
                    SettingsRow(icon: "person", title: "Edit Profile", action: {
                        Haptics.light()
                        // TODO: Navigate to EditProfile
                    })
                    SettingsRow(icon: "creditcard", title: "Payment Methods", action: {
                        Haptics.light()
                        viewModel.navigateToPaymentMethods = true
                    })
                    SettingsRow(icon: "mappin.circle", title: "Saved Addresses", action: {
                        Haptics.light()
                        // TODO: Navigate to Saved Addresses
                    })
                    SettingsRow(icon: "bell", title: "Notifications", action: {
                        Haptics.light()
                        // TODO: Navigate to Notifications
                    })
                }

                // Preferences Section
                SettingsSection(title: "Preferences") {
                    SettingsPickerRow(
                        icon: "globe",
                        title: "Language",
                        value: viewModel.language.displayName,
                        action: {
                            Haptics.light()
                            // TODO: Navigate to Language Picker
                        }
                    )

                    SettingsPickerRow(
                        icon: "paintbrush",
                        title: "Theme",
                        value: viewModel.theme.displayName,
                        action: {
                            Haptics.light()
                            // TODO: Navigate to Theme Picker
                        }
                    )

                    SettingsRow(icon: "speaker.wave.2", title: "Sound & Vibration", action: {
                        Haptics.light()
                        // TODO: Navigate to Sound Settings
                    })
                }

                // Support Section
                SettingsSection(title: "Support") {
                    SettingsRow(icon: "questionmark.circle", title: "Help Center", action: {
                        Haptics.light()
                        viewModel.navigateToHelpCenter = true
                    })
                    SettingsRow(icon: "message", title: "Contact Support", action: {
                        Haptics.light()
                        // TODO: Navigate to Contact Support
                    })
                    SettingsRow(icon: "list.bullet", title: "FAQs", action: {
                        Haptics.light()
                        // TODO: Navigate to FAQs
                    })
                    SettingsInfoRow(
                        icon: "phone",
                        title: "Emergency Helpline",
                        value: viewModel.helplineNumber,
                        action: {
                            Haptics.medium()
                            viewModel.callHelpline()
                        }
                    )
                }

                // Legal Section
                SettingsSection(title: "Legal") {
                    SettingsRow(icon: "doc.plaintext", title: "Terms of Service", action: {
                        Haptics.light()
                        // TODO: Navigate to Terms
                    })
                    SettingsRow(icon: "lock.shield", title: "Privacy Policy", action: {
                        Haptics.light()
                        // TODO: Navigate to Privacy
                    })
                    SettingsRow(icon: "doc.text.fill", title: "User Agreement", action: {
                        Haptics.light()
                        // TODO: Navigate to User Agreement
                    })
                    SettingsRow(icon: "hand.raised", title: "Data & Privacy", action: {
                        Haptics.light()
                        // TODO: Navigate to Data Privacy
                    })
                }

                // About Section
                SettingsSection(title: "About") {
                    SettingsRow(icon: "info.circle", title: "About UrbanNest", action: {
                        Haptics.light()
                        // TODO: Navigate to About
                    })
                    SettingsInfoRow(icon: "number", title: "App Version", value: viewModel.appVersion)
                    SettingsRow(icon: "arrow.down.circle", title: "Check for Updates", action: {
                        Haptics.medium()
                        viewModel.checkForUpdates()
                    })
                    SettingsRow(icon: "star.fill", title: "Rate Us", action: {
                        Haptics.medium()
                        viewModel.rateApp()
                    })
                    SettingsRow(icon: "square.and.arrow.up", title: "Share App", action: {
                        Haptics.medium()
                        viewModel.shareApp()
                    })
                }

                // Data & Cache Section
                SettingsSection(title: "Data & Cache") {
                    SettingsActionRow(
                        icon: "trash",
                        title: "Clear Cache",
                        subtitle: "Cache size: \(viewModel.cacheSize)",
                        action: {
                            Haptics.light()
                            showClearCacheConfirmation = true
                        }
                    )

                    SettingsActionRow(
                        icon: "arrow.down.doc",
                        title: "Download Data",
                        subtitle: "Export your data (GDPR)",
                        action: {
                            Haptics.medium()
                            viewModel.downloadData()
                        }
                    )
                }

                // Account Actions Section
                SettingsSection(title: "Account Actions") {
                    SettingsActionRow(
                        icon: "rectangle.portrait.and.arrow.right",
                        title: "Logout",
                        action: {
                            Haptics.medium()
                            showLogoutConfirmation = true
                        },
                        isDestructive: false
                    )

                    SettingsActionRow(
                        icon: "trash",
                        title: "Delete Account",
                        action: {
                            Haptics.heavy()
                            showDeleteConfirmation = true
                        },
                        isDestructive: true
                    )
                }

                // Footer
                footerView
            }
        }
        .background(Color.background)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .alert("Logout", isPresented: $showLogoutConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Logout", role: .destructive) {
                Haptics.medium()
                viewModel.logout()
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
        .alert("Delete Account", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                Haptics.heavy()
                viewModel.deleteAccount()
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.")
        }
        .alert("Clear Cache", isPresented: $showClearCacheConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                Haptics.medium()
                viewModel.clearCache()
            }
        } message: {
            Text("This will clear \(viewModel.cacheSize) of cached data. The app may need to download some data again.")
        }
        .navigationDestination(isPresented: $viewModel.navigateToPaymentMethods) {
            PaymentMethodsView()
        }
        .navigationDestination(isPresented: $viewModel.navigateToHelpCenter) {
            HelpCenterView()
        }
    }

    // MARK: - Subviews

    private var footerView: some View {
        VStack(spacing: Spacing.xs) {
            Divider()
                .padding(.top, Spacing.lg)

            Text("Made with ❤️ in India")
                .font(.caption)
                .foregroundColor(.textTertiary)

            Text("© 2025 UrbanNest. All rights reserved.")
                .font(.caption)
                .foregroundColor(.textTertiary)
        }
        .padding(.vertical, Spacing.lg)
    }
}

// MARK: - Settings Section

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
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.textSecondary)
                .textCase(.uppercase)
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.top, Spacing.md)
                .padding(.bottom, Spacing.xs)

            content

            Divider()
                .padding(.top, Spacing.xs)
        }
    }
}

// MARK: - Settings Row

struct SettingsRow: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.primary)
                    .frame(width: 24)

                Text(title)
                    .font(.body)
                    .foregroundColor(.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: Spacing.iconXS))
                    .foregroundColor(.textTertiary)
            }
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.screenPadding)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Settings Picker Row

struct SettingsPickerRow: View {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.primary)
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.textPrimary)

                    Text(value)
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: Spacing.iconXS))
                    .foregroundColor(.textTertiary)
            }
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.screenPadding)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Settings Info Row

struct SettingsInfoRow: View {
    let icon: String
    let title: String
    let value: String
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(action != nil ? Color.primary : Color.textTertiary)
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.textPrimary)

                    Text(value)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }

                Spacer()

                if action != nil {
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(.primary)
                }
            }
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.screenPadding)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(action == nil)
    }
}

// MARK: - Settings Action Row

struct SettingsActionRow: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    let action: () -> Void
    var isDestructive: Bool = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(isDestructive ? Color.error : Color.primary)
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(title)
                        .font(.body)
                        .foregroundColor(isDestructive ? Color.error : Color.textPrimary)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: Spacing.iconXS))
                    .foregroundColor(.textTertiary)
            }
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.screenPadding)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Data Models

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

// MARK: - View Model

class AppSettingsViewModel: ObservableObject {

    @Published var language: AppLanguage = .english
    @Published var theme: AppTheme = .system
    @Published var cacheSize: String = "45 MB"
    @Published var appVersion: String = "1.0.0"
    @Published var helplineNumber: String = "+91 1800-XXX-XXXX"

    @Published var navigateToPaymentMethods: Bool = false
    @Published var navigateToHelpCenter: Bool = false

    init() {
        loadSettings()
        calculateCacheSize()
        getAppVersion()
    }

    private func loadSettings() {
        // TODO: Load from UserDefaults or Firebase
        language = .english
        theme = .system
    }

    private func calculateCacheSize() {
        // TODO: Calculate actual cache size
        cacheSize = "45 MB"
    }

    private func getAppVersion() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            appVersion = "\(version) (\(build))"
        } else {
            appVersion = "1.0.0"
        }
    }

    func clearCache() {
        // TODO: Implement cache clearing
        print("Clearing cache...")
        cacheSize = "0 MB"
    }

    func downloadData() {
        // TODO: Implement GDPR data export
        print("Downloading user data...")
    }

    func logout() {
        // TODO: Implement logout
        print("Logging out...")
    }

    func deleteAccount() {
        // TODO: Implement account deletion
        print("Deleting account...")
    }

    func callHelpline() {
        if let url = URL(string: "tel://\(helplineNumber.replacingOccurrences(of: " ", with: ""))") {
            UIApplication.shared.open(url)
        }
    }

    func checkForUpdates() {
        // TODO: Check App Store for updates
        print("Checking for updates...")
    }

    func rateApp() {
        // TODO: Open App Store rating page
        print("Opening App Store...")
    }

    func shareApp() {
        // TODO: Show share sheet
        print("Sharing app...")
    }
}

// MARK: - Preview

#Preview("App Settings - Light") {
    NavigationStack {
        AppSettingsView()
    }
}

#Preview("App Settings - Dark") {
    NavigationStack {
        AppSettingsView()
    }
    .preferredColorScheme(.dark)
}
