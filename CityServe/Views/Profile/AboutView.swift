//
//  AboutView.swift
//  CityServe
//
//  About UrbanNest with company info, legal documents, and contact
//  Design Spec: 51_ABOUT_LEGAL.md
//

import SwiftUI
import Combine

struct AboutView: View {

    @StateObject private var viewModel = AboutViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Logo & Tagline
                VStack(spacing: Spacing.md) {
                    // App Logo (placeholder)
                    ZStack {
                        Circle()
                            .fill(Color.primary.opacity(0.1))
                            .frame(width: 120, height: 120)

                        Text("UN")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.primary)
                    }

                    Text("Trusted services, delivered smartly")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, Spacing.lg)
                .padding(.bottom, Spacing.md)

                Divider()
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.lg)

                // Company Info
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Company Info")
                        .font(.h5)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    Text("UrbanNest is India's leading platform for on-demand home services. We connect you with verified, skilled professionals for all your home service needs.")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)

                    VStack(spacing: Spacing.xs) {
                        InfoRow(label: "Founded", value: "2025")
                        InfoRow(label: "Headquarters", value: "New Delhi, India")
                        InfoRow(label: "Services", value: "50+ categories")
                        InfoRow(label: "Cities", value: "15+ cities across India")
                        InfoRow(label: "Active Providers", value: "10,000+")
                        InfoRow(label: "Total Bookings", value: "1M+")
                    }
                    .padding(.top, Spacing.xs)
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.lg)

                Divider()
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.md)

                // Legal Documents
                VStack(alignment: .leading, spacing: 0) {
                    Text("Legal Documents")
                        .font(.h5)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, Spacing.screenPadding)
                        .padding(.bottom, Spacing.md)

                    LegalDocumentRow(
                        icon: "doc.plaintext",
                        title: "Terms of Service",
                        onTap: {
                            Haptics.light()
                            viewModel.openDocument(.terms)
                        }
                    )

                    LegalDocumentRow(
                        icon: "lock.shield",
                        title: "Privacy Policy",
                        onTap: {
                            Haptics.light()
                            viewModel.openDocument(.privacy)
                        }
                    )

                    LegalDocumentRow(
                        icon: "doc.text.fill",
                        title: "User Agreement",
                        onTap: {
                            Haptics.light()
                            viewModel.openDocument(.userAgreement)
                        }
                    )

                    LegalDocumentRow(
                        icon: "arrow.counterclockwise",
                        title: "Cancellation & Refund Policy",
                        onTap: {
                            Haptics.light()
                            viewModel.openDocument(.cancellationPolicy)
                        }
                    )

                    LegalDocumentRow(
                        icon: "shield.checkered",
                        title: "Safety Guidelines",
                        onTap: {
                            Haptics.light()
                            viewModel.openDocument(.safetyGuidelines)
                        }
                    )

                    LegalDocumentRow(
                        icon: "accessibility",
                        title: "Accessibility Statement",
                        onTap: {
                            Haptics.light()
                            viewModel.openDocument(.accessibility)
                        }
                    )
                }
                .padding(.bottom, Spacing.lg)

                Divider()
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.md)

                // Connect With Us
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("Connect With Us")
                        .font(.h5)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    ContactInfoRow(
                        icon: "globe",
                        title: "Website",
                        value: "www.urbannest.in",
                        action: {
                            Haptics.medium()
                            viewModel.openWebsite()
                        }
                    )

                    ContactInfoRow(
                        icon: "envelope.fill",
                        title: "Email",
                        value: "support@urbannest.in",
                        action: {
                            Haptics.medium()
                            viewModel.sendEmail()
                        }
                    )

                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Social Media")
                            .font(.label)
                            .foregroundColor(.textSecondary)

                        HStack(spacing: Spacing.md) {
                            SocialMediaButton(
                                platform: .facebook,
                                action: {
                                    Haptics.light()
                                    viewModel.openSocial(.facebook)
                                }
                            )

                            SocialMediaButton(
                                platform: .twitter,
                                action: {
                                    Haptics.light()
                                    viewModel.openSocial(.twitter)
                                }
                            )

                            SocialMediaButton(
                                platform: .instagram,
                                action: {
                                    Haptics.light()
                                    viewModel.openSocial(.instagram)
                                }
                            )

                            SocialMediaButton(
                                platform: .youtube,
                                action: {
                                    Haptics.light()
                                    viewModel.openSocial(.youtube)
                                }
                            )

                            SocialMediaButton(
                                platform: .linkedin,
                                action: {
                                    Haptics.light()
                                    viewModel.openSocial(.linkedin)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.lg)

                Divider()
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.md)

                // App Information
                VStack(alignment: .leading, spacing: Spacing.md) {
                    Text("App Information")
                        .font(.h5)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    VStack(spacing: Spacing.xs) {
                        InfoRow(
                            label: "Version",
                            value: "\(viewModel.appVersion) (Build \(viewModel.buildNumber))"
                        )
                        InfoRow(label: "Last Updated", value: viewModel.lastUpdated)

                        Button(action: {
                            Haptics.light()
                            viewModel.showReleaseNotes()
                        }) {
                            HStack {
                                Text("Release Notes")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .font(.system(size: Spacing.iconXS))
                                    .foregroundColor(.textTertiary)
                            }
                            .padding(.vertical, Spacing.xxs)
                        }
                    }

                    Divider()
                        .padding(.vertical, Spacing.xs)

                    VStack(spacing: Spacing.xs) {
                        InfoRow(label: "Device", value: viewModel.deviceName)
                        InfoRow(label: "OS", value: viewModel.osVersion)
                        InfoRow(label: "Language", value: viewModel.appLanguage)
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.lg)

                Divider()
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.md)

                // Acknowledgements
                VStack(alignment: .leading, spacing: 0) {
                    Text("Acknowledgements")
                        .font(.h5)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, Spacing.screenPadding)
                        .padding(.bottom, Spacing.md)

                    LegalDocumentRow(
                        icon: "doc.on.doc",
                        title: "Open Source Licenses",
                        onTap: {
                            Haptics.light()
                            viewModel.openLicenses()
                        }
                    )

                    LegalDocumentRow(
                        icon: "person.3.fill",
                        title: "Credits & Contributors",
                        onTap: {
                            Haptics.light()
                            viewModel.openCredits()
                        }
                    )
                }
                .padding(.bottom, Spacing.lg)

                // Footer
                VStack(spacing: Spacing.xs) {
                    Divider()
                        .padding(.horizontal, Spacing.screenPadding)

                    Text("Made with ❤️ in India")
                        .font(.caption)
                        .foregroundColor(.textTertiary)

                    Text("© 2025 UrbanNest Technologies Pvt Ltd")
                        .font(.caption)
                        .foregroundColor(.textTertiary)

                    Text("All rights reserved.")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
                .padding(.vertical, Spacing.lg)
            }
        }
        .background(Color.background)
        .navigationTitle("About UrbanNest")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showReleaseNotesSheet) {
            ReleaseNotesView(releaseNotes: viewModel.releaseNotes)
        }
    }
}

// MARK: - Info Row

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.textSecondary)

            Spacer()

            Text(value)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
        }
    }
}

// MARK: - Legal Document Row

struct LegalDocumentRow: View {
    let icon: String
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
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
        .accessibilityLabel(title)
        .accessibilityHint("Double tap to open \(title) document")
    }
}

// MARK: - Contact Info Row

struct ContactInfoRow: View {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.primary)

                Text(title)
                    .font(.label)
                    .foregroundColor(.textSecondary)
            }

            Button(action: action) {
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
                    .underline()
            }
        }
        .accessibilityLabel("\(title): \(value)")
        .accessibilityHint("Double tap to open \(title)")
    }
}

// MARK: - Social Media Button

struct SocialMediaButton: View {
    let platform: SocialPlatform
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(platform.color.opacity(0.1))
                    .frame(width: 44, height: 44)

                Image(systemName: platform.iconName)
                    .font(.system(size: Spacing.iconMD))
                    .foregroundColor(platform.color)
            }
        }
        .accessibilityLabel(platform.displayName)
        .accessibilityHint("Double tap to open \(platform.displayName)")
    }
}

// MARK: - Release Notes View

struct ReleaseNotesView: View {
    let releaseNotes: ReleaseNotes
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Current Version
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        HStack {
                            VStack(alignment: .leading, spacing: Spacing.xxs) {
                                Text("Version \(releaseNotes.version)")
                                    .font(.h4)
                                    .fontWeight(.bold)
                                    .foregroundColor(.textPrimary)

                                Text("Build \(releaseNotes.buildNumber)")
                                    .font(.caption)
                                    .foregroundColor(.textSecondary)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: Spacing.xxs) {
                                Text(releaseNotes.releaseDate.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundColor(.textSecondary)
                            }
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            Text("What's New")
                                .font(.h5)
                                .fontWeight(.semibold)
                                .foregroundColor(.textPrimary)

                            ForEach(releaseNotes.changelog, id: \.self) { change in
                                HStack(alignment: .top, spacing: Spacing.xs) {
                                    Text("•")
                                        .foregroundColor(.textSecondary)
                                    Text(change)
                                        .font(.body)
                                        .foregroundColor(.textSecondary)
                                }
                            }
                        }
                    }
                    .padding(Spacing.md)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusLg)

                    // Previous Versions
                    if !releaseNotes.previousVersions.isEmpty {
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            Text("Previous Versions")
                                .font(.h5)
                                .fontWeight(.semibold)
                                .foregroundColor(.textPrimary)

                            ForEach(releaseNotes.previousVersions) { version in
                                VStack(alignment: .leading, spacing: Spacing.xs) {
                                    HStack {
                                        Text("Version \(version.version)")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.textPrimary)

                                        Spacer()

                                        Text(version.releaseDate.formatted(date: .abbreviated, time: .omitted))
                                            .font(.caption)
                                            .foregroundColor(.textSecondary)
                                    }

                                    ForEach(version.changes, id: \.self) { change in
                                        HStack(alignment: .top, spacing: Spacing.xs) {
                                            Text("•")
                                                .foregroundColor(.textSecondary)
                                            Text(change)
                                                .font(.bodySmall)
                                                .foregroundColor(.textSecondary)
                                        }
                                    }
                                }
                                .padding(Spacing.md)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusLg)
                            }
                        }
                    }
                }
                .padding(Spacing.screenPadding)
            }
            .background(Color.background)
            .navigationTitle("Release Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textPrimary)
                    }
                }
            }
        }
    }
}

// MARK: - Data Models

enum LegalDocument {
    case terms
    case privacy
    case userAgreement
    case cancellationPolicy
    case safetyGuidelines
    case accessibility

    var url: URL {
        switch self {
        case .terms: return URL(string: "https://urbannest.in/terms")!
        case .privacy: return URL(string: "https://urbannest.in/privacy")!
        case .userAgreement: return URL(string: "https://urbannest.in/user-agreement")!
        case .cancellationPolicy: return URL(string: "https://urbannest.in/cancellation-policy")!
        case .safetyGuidelines: return URL(string: "https://urbannest.in/safety")!
        case .accessibility: return URL(string: "https://urbannest.in/accessibility")!
        }
    }

    var title: String {
        switch self {
        case .terms: return "Terms of Service"
        case .privacy: return "Privacy Policy"
        case .userAgreement: return "User Agreement"
        case .cancellationPolicy: return "Cancellation & Refund Policy"
        case .safetyGuidelines: return "Safety Guidelines"
        case .accessibility: return "Accessibility Statement"
        }
    }
}

enum SocialPlatform {
    case facebook
    case twitter
    case instagram
    case youtube
    case linkedin

    var color: Color {
        switch self {
        case .facebook: return Color.blue
        case .twitter: return Color.cyan
        case .instagram: return Color.purple
        case .youtube: return Color.red
        case .linkedin: return Color.blue
        }
    }

    var url: URL {
        switch self {
        case .facebook: return URL(string: "https://facebook.com/urbannest")!
        case .twitter: return URL(string: "https://twitter.com/urbannest")!
        case .instagram: return URL(string: "https://instagram.com/urbannest")!
        case .youtube: return URL(string: "https://youtube.com/@urbannest")!
        case .linkedin: return URL(string: "https://linkedin.com/company/urbannest")!
        }
    }

    var iconName: String {
        switch self {
        case .facebook: return "f.circle.fill"
        case .twitter: return "bird.circle.fill"
        case .instagram: return "camera.circle.fill"
        case .youtube: return "play.circle.fill"
        case .linkedin: return "link.circle.fill"
        }
    }

    var displayName: String {
        switch self {
        case .facebook: return "Facebook"
        case .twitter: return "Twitter"
        case .instagram: return "Instagram"
        case .youtube: return "YouTube"
        case .linkedin: return "LinkedIn"
        }
    }
}

struct ReleaseNotes: Identifiable {
    let id = UUID()
    let version: String
    let buildNumber: String
    let releaseDate: Date
    let changelog: [String]
    let previousVersions: [PreviousVersion]
}

struct PreviousVersion: Identifiable {
    let id = UUID()
    let version: String
    let releaseDate: Date
    let changes: [String]
}

// MARK: - View Model

class AboutViewModel: ObservableObject {

    @Published var appVersion: String = "1.0.0"
    @Published var buildNumber: String = "1"
    @Published var lastUpdated: String = "December 31, 2025"
    @Published var deviceName: String = "iPhone"
    @Published var osVersion: String = "iOS 17.0"
    @Published var appLanguage: String = "English (India)"

    @Published var showReleaseNotesSheet = false
    @Published var releaseNotes: ReleaseNotes = ReleaseNotes(
        version: "1.0.0",
        buildNumber: "1",
        releaseDate: Date(),
        changelog: [],
        previousVersions: []
    )

    init() {
        loadAppInfo()
        loadDeviceInfo()
        loadReleaseNotes()
    }

    private func loadAppInfo() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        }

        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            buildNumber = build
        }
    }

    private func loadDeviceInfo() {
        deviceName = UIDevice.current.model
        osVersion = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"

        // Get language
        if let languageCode = Locale.current.language.languageCode?.identifier {
            appLanguage = Locale.current.localizedString(forLanguageCode: languageCode) ?? "English"
        }
    }

    private func loadReleaseNotes() {
        // TODO: Load from API or local file
        releaseNotes = ReleaseNotes(
            version: appVersion,
            buildNumber: buildNumber,
            releaseDate: Date(),
            changelog: [
                "Initial release of UrbanNest",
                "Browse and book 50+ home services",
                "Find verified professionals",
                "Track your bookings in real-time",
                "Secure payments with multiple options"
            ],
            previousVersions: []
        )
    }

    func openDocument(_ document: LegalDocument) {
        // TODO: Open document in web view or Safari
        UIApplication.shared.open(document.url)
    }

    func openWebsite() {
        if let url = URL(string: "https://urbannest.in") {
            UIApplication.shared.open(url)
        }
    }

    func sendEmail() {
        if let url = URL(string: "mailto:support@urbannest.in") {
            UIApplication.shared.open(url)
        }
    }

    func openSocial(_ platform: SocialPlatform) {
        UIApplication.shared.open(platform.url)
    }

    func showReleaseNotes() {
        showReleaseNotesSheet = true
    }

    func openLicenses() {
        // TODO: Navigate to open source licenses
        print("Opening licenses...")
    }

    func openCredits() {
        // TODO: Navigate to credits page
        print("Opening credits...")
    }
}

// MARK: - Preview

#Preview("About - Light") {
    NavigationStack {
        AboutView()
    }
}

#Preview("About - Dark") {
    NavigationStack {
        AboutView()
    }
    .preferredColorScheme(.dark)
}

#Preview("Release Notes") {
    ReleaseNotesView(
        releaseNotes: ReleaseNotes(
            version: "1.0.0",
            buildNumber: "1",
            releaseDate: Date(),
            changelog: [
                "Initial release of UrbanNest",
                "Browse and book 50+ home services",
                "Find verified professionals",
                "Track your bookings in real-time"
            ],
            previousVersions: [
                PreviousVersion(
                    version: "0.9.0",
                    releaseDate: Date().addingTimeInterval(-30 * 24 * 60 * 60),
                    changes: ["Beta release", "Bug fixes"]
                )
            ]
        )
    )
}
