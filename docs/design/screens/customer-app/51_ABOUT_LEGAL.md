# Screen 51: About & Legal

## Overview

- **Screen ID**: 51
- **Screen Name**: About & Legal
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 50 (App Settings) → Tap "About UrbanNest"
  - From: Footer links → "About" / "Terms" / "Privacy"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← About UrbanNest                      │ Header
├─────────────────────────────────────────┤
│                                         │
│           ┌──────────┐                  │
│           │          │                  │ App Logo
│           │UrbanNest │                  │
│           │          │                  │
│           └──────────┘                  │
│                                         │
│         Trusted services,               │ Tagline
│        delivered smartly                │
│                                         │
│  ───── Company Info ─────               │
│                                         │
│  UrbanNest is India's leading platform  │ Description
│  for on-demand home services. We        │
│  connect you with verified, skilled     │
│  professionals for all your home        │
│  service needs.                         │
│                                         │
│  Founded: 2025                          │ Company Details
│  Headquarters: New Delhi, India         │
│  Services: 50+ categories               │
│  Cities: 15+ cities across India        │
│                                         │
│  ───── Legal Documents ─────            │
│                                         │
│  📜 Terms of Service                →   │ Document Links
│  🔒 Privacy Policy                  →   │
│  ⚖️  User Agreement                 →   │
│  📋 Cancellation & Refund Policy    →   │
│  🛡️  Safety Guidelines              →   │
│  ♿ Accessibility Statement          →   │
│                                         │
│  ───── Connect With Us ─────            │
│                                         │
│  🌐 Website                         →   │ Social Links
│     www.urbannest.in                    │
│                                         │
│  📧 Email                           →   │
│     support@urbannest.in                │
│                                         │
│  📱 Social Media                        │
│  [📘] [🐦] [📸] [▶️]                    │ Icons
│                                         │
│  ───── App Information ─────            │
│                                         │
│  Version: 1.2.3 (Build 45)              │ Version Info
│  Last Updated: December 15, 2025        │
│  Release Notes                      →   │
│                                         │
│  Device: iPhone 15 Pro                  │ Device Info
│  OS: iOS 18.1                           │
│  Language: English (India)              │
│                                         │
│  ───── Acknowledgements ─────           │
│                                         │
│  📦 Open Source Licenses            →   │
│  👏 Credits & Contributors          →   │
│                                         │
│  ───────────────────────────────        │
│  Made with ❤️ in India                  │ Footer
│  © 2025 UrbanNest Technologies Pvt Ltd  │
│  All rights reserved.                   │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. App Logo & Branding
- UrbanNest logo (large, centered)
- Tagline: "Trusted services, delivered smartly"
- Brand colors and visual identity

### 2. Company Information
- Mission statement
- Company history
- Key statistics:
  - Founded year
  - Headquarters location
  - Number of services
  - Number of cities
  - Total providers
  - Total bookings

### 3. Legal Documents
- **Terms of Service**: User agreement terms
- **Privacy Policy**: Data collection and usage
- **User Agreement**: Platform rules
- **Cancellation & Refund Policy**: Booking policies
- **Safety Guidelines**: User and provider safety
- **Accessibility Statement**: Inclusivity commitment

### 4. Connect With Us
- Website link
- Support email
- Social media links:
  - Facebook
  - Twitter
  - Instagram
  - YouTube
  - LinkedIn
- Customer support phone

### 5. App Information
- App version number
- Build number
- Last updated date
- Release notes link
- Device information
- OS version
- Language setting

### 6. Acknowledgements
- Open source licenses
- Third-party credits
- Contributors

### 7. Footer
- Copyright notice
- Company legal name
- Made with love tagline

## Component Breakdown

```swift
struct AboutLegalView: View {
    @StateObject private var viewModel = AboutViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Logo & Tagline
                VStack(spacing: 16) {
                    Image("app_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)

                    Text("Trusted services, delivered smartly")
                        .font(.custom("Inter-Medium", size: 16))
                        .foregroundColor(Color("TextSecondary"))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 24)

                Divider()

                // Company Info
                VStack(alignment: .leading, spacing: 16) {
                    Text("Company Info")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))

                    Text("UrbanNest is India's leading platform for on-demand home services. We connect you with verified, skilled professionals for all your home service needs.")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                        .lineSpacing(4)

                    VStack(alignment: .leading, spacing: 8) {
                        InfoRow(label: "Founded", value: "2025")
                        InfoRow(label: "Headquarters", value: "New Delhi, India")
                        InfoRow(label: "Services", value: "50+ categories")
                        InfoRow(label: "Cities", value: "15+ cities across India")
                        InfoRow(label: "Active Providers", value: "10,000+")
                        InfoRow(label: "Total Bookings", value: "1M+")
                    }
                }
                .padding(.horizontal, 16)

                Divider()

                // Legal Documents
                VStack(alignment: .leading, spacing: 12) {
                    Text("Legal Documents")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))
                        .padding(.horizontal, 16)

                    LegalDocumentRow(
                        icon: "doc.plaintext",
                        title: "Terms of Service",
                        onTap: { viewModel.openDocument(.terms) }
                    )

                    LegalDocumentRow(
                        icon: "lock.shield",
                        title: "Privacy Policy",
                        onTap: { viewModel.openDocument(.privacy) }
                    )

                    LegalDocumentRow(
                        icon: "doc.text.fill",
                        title: "User Agreement",
                        onTap: { viewModel.openDocument(.userAgreement) }
                    )

                    LegalDocumentRow(
                        icon: "arrow.counterclockwise",
                        title: "Cancellation & Refund Policy",
                        onTap: { viewModel.openDocument(.cancellationPolicy) }
                    )

                    LegalDocumentRow(
                        icon: "shield.checkered",
                        title: "Safety Guidelines",
                        onTap: { viewModel.openDocument(.safetyGuidelines) }
                    )

                    LegalDocumentRow(
                        icon: "accessibility",
                        title: "Accessibility Statement",
                        onTap: { viewModel.openDocument(.accessibility) }
                    )
                }

                Divider()

                // Connect With Us
                VStack(alignment: .leading, spacing: 16) {
                    Text("Connect With Us")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))

                    ContactInfoRow(
                        icon: "globe",
                        title: "Website",
                        value: "www.urbannest.in",
                        action: { viewModel.openWebsite() }
                    )

                    ContactInfoRow(
                        icon: "envelope.fill",
                        title: "Email",
                        value: "support@urbannest.in",
                        action: { viewModel.sendEmail() }
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Social Media")
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("TextSecondary"))

                        HStack(spacing: 16) {
                            SocialMediaButton(icon: "facebook", platform: .facebook, action: { viewModel.openSocial(.facebook) })
                            SocialMediaButton(icon: "twitter", platform: .twitter, action: { viewModel.openSocial(.twitter) })
                            SocialMediaButton(icon: "instagram", platform: .instagram, action: { viewModel.openSocial(.instagram) })
                            SocialMediaButton(icon: "youtube", platform: .youtube, action: { viewModel.openSocial(.youtube) })
                            SocialMediaButton(icon: "linkedin", platform: .linkedin, action: { viewModel.openSocial(.linkedin) })
                        }
                    }
                }
                .padding(.horizontal, 16)

                Divider()

                // App Information
                VStack(alignment: .leading, spacing: 16) {
                    Text("App Information")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))

                    VStack(alignment: .leading, spacing: 8) {
                        InfoRow(label: "Version", value: "\(viewModel.appVersion) (Build \(viewModel.buildNumber))")
                        InfoRow(label: "Last Updated", value: viewModel.lastUpdated)

                        Button(action: { viewModel.showReleaseNotes() }) {
                            HStack {
                                Text("Release Notes")
                                    .font(.custom("Inter-Medium", size: 14))
                                    .foregroundColor(Color("PrimaryTeal"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("TextTertiary"))
                            }
                        }
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        InfoRow(label: "Device", value: viewModel.deviceName)
                        InfoRow(label: "OS", value: viewModel.osVersion)
                        InfoRow(label: "Language", value: viewModel.appLanguage)
                    }
                }
                .padding(.horizontal, 16)

                Divider()

                // Acknowledgements
                VStack(alignment: .leading, spacing: 12) {
                    Text("Acknowledgements")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))
                        .padding(.horizontal, 16)

                    LegalDocumentRow(
                        icon: "doc.on.doc",
                        title: "Open Source Licenses",
                        onTap: { viewModel.openLicenses() }
                    )

                    LegalDocumentRow(
                        icon: "person.3.fill",
                        title: "Credits & Contributors",
                        onTap: { viewModel.openCredits() }
                    )
                }

                // Footer
                VStack(spacing: 8) {
                    Divider()

                    Text("Made with ❤️ in India")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))

                    Text("© 2025 UrbanNest Technologies Pvt Ltd")
                        .font(.custom("Inter-Regular", size: 11))
                        .foregroundColor(Color("TextTertiary"))

                    Text("All rights reserved.")
                        .font(.custom("Inter-Regular", size: 10))
                        .foregroundColor(Color("TextTertiary"))
                }
                .padding(.vertical, 24)
            }
        }
        .navigationTitle("About UrbanNest")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))

            Spacer()

            Text(value)
                .font(.custom("Inter-SemiBold", size: 14))
                .foregroundColor(Color("TextPrimary"))
        }
    }
}

struct LegalDocumentRow: View {
    let icon: String
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
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

struct ContactInfoRow: View {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(Color("PrimaryTeal"))

                Text(title)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("TextSecondary"))
            }

            Button(action: action) {
                Text(value)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("PrimaryTeal"))
                    .underline()
            }
        }
    }
}

struct SocialMediaButton: View {
    let icon: String
    let platform: SocialPlatform
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "\(icon).circle.fill")
                .font(.system(size: 36))
                .foregroundColor(platform.color)
        }
    }
}

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
}
```

## Interactions

### Legal Documents
1. **Tap Document**: Opens web view with full document
2. **Scroll**: View full terms/policy
3. **Close**: Returns to About screen

### Contact Actions
1. **Tap Website**: Opens Safari/browser
2. **Tap Email**: Opens email composer with support@urbannest.in
3. **Tap Social Icon**: Opens social media app or web browser

### Release Notes
1. **Tap Release Notes**: Shows version changelog in modal
2. **Version History**: Shows last 5 versions with changes

## States

### Default State
- All information displayed
- Links active
- Device info populated

### Loading State (on open)
```swift
ProgressView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
```

### Web View State
```swift
struct LegalDocumentWebView: View {
    let document: LegalDocument

    var body: some View {
        WebView(url: document.url)
            .navigationTitle(document.title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
```

## API Integration

### Get Company Info
```
GET /about/company-info

Response:
{
  "success": true,
  "data": {
    "founded": "2025",
    "headquarters": "New Delhi, India",
    "services": 50,
    "cities": 15,
    "activeProviders": 10000,
    "totalBookings": 1000000,
    "tagline": "Trusted services, delivered smartly",
    "mission": "We connect you with verified, skilled professionals...",
    "socialMedia": {
      "facebook": "https://facebook.com/urbannest",
      "twitter": "https://twitter.com/urbannest",
      "instagram": "https://instagram.com/urbannest",
      "youtube": "https://youtube.com/@urbannest",
      "linkedin": "https://linkedin.com/company/urbannest"
    }
  }
}
```

### Get Release Notes
```
GET /about/release-notes?version=1.2.3

Response:
{
  "success": true,
  "data": {
    "version": "1.2.3",
    "buildNumber": "45",
    "releaseDate": "2025-12-15",
    "changelog": [
      "Improved booking performance",
      "Fixed payment gateway issues",
      "Added new service categories",
      "Enhanced search functionality"
    ],
    "previousVersions": [
      {
        "version": "1.2.2",
        "releaseDate": "2025-12-01",
        "changes": ["Bug fixes", "Performance improvements"]
      }
    ]
  }
}
```

## Navigation

### Entry Points
- **From Screen 50** (App Settings): "About UrbanNest"
- **From Footer**: "About" link
- **From Onboarding**: "Learn More"

### Exit Points
- **Back Button**: Return to Settings
- **Legal Documents**: Web view (in-app)
- **External Links**: Safari/Browser

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Terms of Service")
.accessibilityHint("Double tap to open terms of service document")

.accessibilityLabel("Website: www.urbannest.in")
.accessibilityHint("Double tap to open website in browser")
```

### Touch Targets
- All links: 44pt minimum height
- Social icons: 44x44pt

### Dynamic Type
- All text scales with system font size
- Logo remains fixed size

## Analytics Events

### Screen View
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "about_legal"
])
```

### Legal Document Opened
```swift
Analytics.logEvent("legal_document_opened", parameters: [
    "document": "terms_of_service"
])
```

### Social Link Tapped
```swift
Analytics.logEvent("social_link_tapped", parameters: [
    "platform": "instagram"
])
```

## Testing Checklist

- [ ] Company info loads correctly
- [ ] Logo displays correctly
- [ ] All legal documents open
- [ ] Terms of Service displays
- [ ] Privacy Policy displays
- [ ] Website link works
- [ ] Email link works
- [ ] Social media links work
- [ ] App version displays correctly
- [ ] Build number displays correctly
- [ ] Device info displays correctly
- [ ] Release notes open
- [ ] Open source licenses display
- [ ] Credits display correctly
- [ ] Footer displays correctly

## Design Notes

### Platform-Specific

**iOS**:
- Safari View Controller for links
- Mail composer for email
- Native share sheet

**Android**:
- Chrome Custom Tabs for links
- Email intent
- Android share sheet

**Web**:
- Open links in new tab
- Mailto links for email

### Legal Compliance
- GDPR: Privacy policy, data export
- CCPA: Privacy rights, do not sell
- India: IT Act compliance

### Edge Cases
- Handle missing social media URLs
- Offline document viewing (cached)
- Large changelog display

### Future Enhancements
- In-app changelog viewer
- Interactive company timeline
- Team members page
- Press kit/media resources

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web

---

**🎉 CUSTOMER APP COMPLETE! All 15 screens (37-51) done!**
