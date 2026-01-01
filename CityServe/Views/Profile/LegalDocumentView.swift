//
//  LegalDocumentView.swift
//  CityServe
//
//  Generic legal document viewer for Terms, Privacy, etc.
//  Design Spec: 51_ABOUT_LEGAL.md (Legal Documents section)
//

import SwiftUI
import Combine

struct LegalDocumentView: View {

    let documentType: LegalDocumentType
    @StateObject private var viewModel: LegalDocumentViewModel
    @Environment(\.dismiss) var dismiss

    init(documentType: LegalDocumentType) {
        self.documentType = documentType
        self._viewModel = StateObject(wrappedValue: LegalDocumentViewModel(documentType: documentType))
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            if viewModel.isLoading {
                LoadingView(
                    message: "Loading document...",
                    style: .spinner
                )
            } else if let error = viewModel.errorMessage {
                ErrorView(
                    error: .server,
                    retryAction: {
                        Task {
                            await viewModel.loadDocument()
                        }
                    }
                )
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        // Last Updated Date
                        if let lastUpdated = viewModel.lastUpdated {
                            HStack {
                                Text("Last Updated:")
                                    .font(.caption)
                                    .foregroundColor(.textSecondary)

                                Text(lastUpdated.formatted(date: .long, time: .omitted))
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.textPrimary)

                                Spacer()
                            }
                            .padding(.horizontal, Spacing.screenPadding)

                            Divider()
                                .padding(.horizontal, Spacing.screenPadding)
                        }

                        // Document Sections
                        ForEach(viewModel.sections) { section in
                            LegalSectionView(section: section)
                        }

                        // Footer Note
                        VStack(spacing: Spacing.md) {
                            Divider()
                                .padding(.horizontal, Spacing.screenPadding)

                            HStack(spacing: Spacing.xs) {
                                Image(systemName: "info.circle")
                                    .font(.system(size: Spacing.iconSM))
                                    .foregroundColor(.info)

                                Text("If you have questions about this document, please contact us at ")
                                    .font(.caption)
                                    .foregroundColor(.textSecondary)
                                +
                                Text("legal@urbannest.in")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, Spacing.screenPadding)
                        }

                        Spacer(minLength: Spacing.xl)
                    }
                    .padding(.top, Spacing.md)
                }
            }
        }
        .navigationTitle(documentType.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDocument()
        }
    }
}

// MARK: - Legal Section View

struct LegalSectionView: View {
    let section: LegalSection

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Section Number & Title
            if let number = section.number {
                Text("\(number). \(section.title)")
                    .font(.h5)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
            } else {
                Text(section.title)
                    .font(.h5)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
            }

            // Content Paragraphs
            ForEach(Array(section.content.enumerated()), id: \.offset) { _, paragraph in
                Text(paragraph)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // Subsections
            if !section.subsections.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    ForEach(section.subsections) { subsection in
                        LegalSubsectionView(subsection: subsection)
                    }
                }
                .padding(.leading, Spacing.md)
            }
        }
        .padding(.horizontal, Spacing.screenPadding)
        .padding(.bottom, Spacing.md)
    }
}

// MARK: - Legal Subsection View

struct LegalSubsectionView: View {
    let subsection: LegalSubsection

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            // Subsection Title
            if !subsection.title.isEmpty {
                Text(subsection.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)
            }

            // Content Items
            ForEach(Array(subsection.content.enumerated()), id: \.offset) { _, item in
                HStack(alignment: .top, spacing: Spacing.xs) {
                    Text("•")
                        .font(.body)
                        .foregroundColor(.textSecondary)

                    Text(item)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

// MARK: - Data Models

enum LegalDocumentType {
    case terms
    case privacy
    case userAgreement
    case cancellationPolicy
    case safetyGuidelines
    case accessibility

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

struct LegalSection: Identifiable {
    let id = UUID()
    let number: Int?
    let title: String
    let content: [String]
    let subsections: [LegalSubsection]

    init(number: Int? = nil, title: String, content: [String], subsections: [LegalSubsection] = []) {
        self.number = number
        self.title = title
        self.content = content
        self.subsections = subsections
    }
}

struct LegalSubsection: Identifiable {
    let id = UUID()
    let title: String
    let content: [String]
}

// MARK: - View Model

class LegalDocumentViewModel: ObservableObject {

    let documentType: LegalDocumentType

    @Published var sections: [LegalSection] = []
    @Published var lastUpdated: Date?
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(documentType: LegalDocumentType) {
        self.documentType = documentType
    }

    @MainActor
    func loadDocument() async {
        isLoading = true
        errorMessage = nil

        // Simulate API call
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s

        // TODO: Load from API or web service
        // For now, use mock data
        loadMockDocument()

        isLoading = false
    }

    private func loadMockDocument() {
        lastUpdated = Date()

        switch documentType {
        case .terms:
            sections = loadTermsOfService()
        case .privacy:
            sections = loadPrivacyPolicy()
        case .userAgreement:
            sections = loadUserAgreement()
        case .cancellationPolicy:
            sections = loadCancellationPolicy()
        case .safetyGuidelines:
            sections = loadSafetyGuidelines()
        case .accessibility:
            sections = loadAccessibilityStatement()
        }
    }

    // MARK: - Mock Data

    private func loadTermsOfService() -> [LegalSection] {
        return [
            LegalSection(
                number: 1,
                title: "Acceptance of Terms",
                content: [
                    "By accessing and using UrbanNest's services, you accept and agree to be bound by the terms and provision of this agreement.",
                    "If you do not agree to abide by the above, please do not use this service."
                ]
            ),
            LegalSection(
                number: 2,
                title: "Service Description",
                content: [
                    "UrbanNest provides an on-demand platform that connects customers with verified service professionals for home services including but not limited to:",
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "Home repair and maintenance",
                            "Cleaning services",
                            "Beauty and wellness services",
                            "Installation and assembly",
                            "Other home and lifestyle services"
                        ]
                    )
                ]
            ),
            LegalSection(
                number: 3,
                title: "User Responsibilities",
                content: [
                    "You agree to provide accurate and complete information when creating your account and booking services.",
                    "You are responsible for maintaining the confidentiality of your account credentials.",
                    "You agree to use the platform only for lawful purposes and in accordance with these Terms."
                ]
            ),
            LegalSection(
                number: 4,
                title: "Booking and Payments",
                content: [
                    "All bookings are subject to availability of service providers.",
                    "Prices displayed are in Indian Rupees (₹) and include applicable taxes unless otherwise stated.",
                    "Payment must be made through the approved payment methods on the platform.",
                    "We reserve the right to refuse or cancel any booking for any reason."
                ]
            ),
            LegalSection(
                number: 5,
                title: "Cancellation and Refunds",
                content: [
                    "Cancellation policies vary by service type and are displayed at the time of booking.",
                    "Refunds, if applicable, will be processed within 7-10 business days.",
                    "Please refer to our Cancellation & Refund Policy for detailed information."
                ]
            ),
            LegalSection(
                number: 6,
                title: "Limitation of Liability",
                content: [
                    "UrbanNest acts as a platform connecting customers with independent service providers.",
                    "We are not liable for the quality, safety, or legality of services provided by third-party professionals.",
                    "Our total liability shall not exceed the amount paid for the specific service in question."
                ]
            ),
            LegalSection(
                number: 7,
                title: "Changes to Terms",
                content: [
                    "We reserve the right to modify these terms at any time.",
                    "Changes will be effective immediately upon posting to the platform.",
                    "Your continued use of the service constitutes acceptance of modified terms."
                ]
            )
        ]
    }

    private func loadPrivacyPolicy() -> [LegalSection] {
        return [
            LegalSection(
                number: 1,
                title: "Information We Collect",
                content: [
                    "We collect information you provide directly to us, including:"
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "Name, email address, and phone number",
                            "Service address and location data",
                            "Payment information",
                            "Service preferences and booking history",
                            "Communications with service providers and support"
                        ]
                    )
                ]
            ),
            LegalSection(
                number: 2,
                title: "How We Use Your Information",
                content: [
                    "We use the information we collect to provide, maintain, and improve our services, including to:"
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "Process bookings and payments",
                            "Connect you with service providers",
                            "Send booking confirmations and updates",
                            "Provide customer support",
                            "Personalize your experience",
                            "Send promotional offers (with your consent)"
                        ]
                    )
                ]
            ),
            LegalSection(
                number: 3,
                title: "Information Sharing",
                content: [
                    "We do not sell your personal information. We may share your information with:"
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "Service providers to complete your bookings",
                            "Payment processors for transactions",
                            "Analytics providers to improve our services",
                            "Law enforcement when required by law"
                        ]
                    )
                ]
            ),
            LegalSection(
                number: 4,
                title: "Data Security",
                content: [
                    "We implement industry-standard security measures to protect your personal information.",
                    "However, no method of transmission over the Internet is 100% secure.",
                    "We cannot guarantee absolute security of your data."
                ]
            ),
            LegalSection(
                number: 5,
                title: "Your Rights",
                content: [
                    "You have the right to access, update, or delete your personal information.",
                    "You can opt-out of marketing communications at any time.",
                    "You can request a copy of your data or permanent deletion of your account."
                ]
            )
        ]
    }

    private func loadUserAgreement() -> [LegalSection] {
        return [
            LegalSection(
                title: "Agreement Overview",
                content: [
                    "This User Agreement governs your use of UrbanNest's platform and services.",
                    "By creating an account, you agree to comply with all terms and conditions outlined in this agreement."
                ]
            ),
            LegalSection(
                title: "Account Usage",
                content: [
                    "Your account is personal to you and may not be shared with others.",
                    "You are responsible for all activities that occur under your account.",
                    "We reserve the right to suspend or terminate accounts that violate our policies."
                ]
            ),
            LegalSection(
                title: "Platform Rules",
                content: [
                    "Users must treat service providers with respect and professionalism.",
                    "Harassment, discrimination, or abusive behavior will not be tolerated.",
                    "False or misleading information is prohibited."
                ]
            )
        ]
    }

    private func loadCancellationPolicy() -> [LegalSection] {
        return [
            LegalSection(
                number: 1,
                title: "Customer Cancellation",
                content: [
                    "You may cancel your booking at any time through the app or by contacting support.",
                    "Cancellation charges apply based on when you cancel:"
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "More than 24 hours before service: Full refund",
                            "12-24 hours before service: 50% refund",
                            "Less than 12 hours before service: No refund",
                            "After provider arrives: No refund"
                        ]
                    )
                ]
            ),
            LegalSection(
                number: 2,
                title: "Provider Cancellation",
                content: [
                    "If a service provider cancels your booking, you will receive a full refund.",
                    "We will help you rebook with another provider at no additional cost."
                ]
            ),
            LegalSection(
                number: 3,
                title: "Refund Processing",
                content: [
                    "Refunds are processed to your original payment method.",
                    "Please allow 7-10 business days for refunds to appear in your account.",
                    "For wallet refunds, the amount is credited instantly."
                ]
            )
        ]
    }

    private func loadSafetyGuidelines() -> [LegalSection] {
        return [
            LegalSection(
                title: "Our Commitment to Safety",
                content: [
                    "UrbanNest is committed to providing a safe platform for all users.",
                    "We verify all service providers through background checks and skill assessments."
                ]
            ),
            LegalSection(
                title: "Safety Tips for Customers",
                content: [
                    "Follow these guidelines to ensure a safe service experience:"
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "Verify the provider's identity when they arrive",
                            "Keep valuable items secured during service",
                            "Stay present during the service when possible",
                            "Report any concerns immediately through the app",
                            "Use in-app communication and payments only"
                        ]
                    )
                ]
            ),
            LegalSection(
                title: "Reporting Issues",
                content: [
                    "If you feel unsafe or experience inappropriate behavior, contact us immediately.",
                    "Use the emergency button in the app for urgent safety concerns.",
                    "All reports are investigated promptly and confidentially."
                ]
            )
        ]
    }

    private func loadAccessibilityStatement() -> [LegalSection] {
        return [
            LegalSection(
                title: "Our Commitment",
                content: [
                    "UrbanNest is committed to ensuring digital accessibility for people with disabilities.",
                    "We are continually improving the user experience for everyone and applying relevant accessibility standards."
                ]
            ),
            LegalSection(
                title: "Accessibility Features",
                content: [
                    "Our platform includes the following accessibility features:"
                ],
                subsections: [
                    LegalSubsection(
                        title: "",
                        content: [
                            "VoiceOver and TalkBack support",
                            "Dynamic text sizing",
                            "High contrast color options",
                            "Keyboard navigation support",
                            "Alternative text for images"
                        ]
                    )
                ]
            ),
            LegalSection(
                title: "Feedback",
                content: [
                    "We welcome feedback on the accessibility of UrbanNest.",
                    "Please contact us at accessibility@urbannest.in with any concerns or suggestions."
                ]
            )
        ]
    }
}

// MARK: - Preview

#Preview("Terms of Service") {
    NavigationStack {
        LegalDocumentView(documentType: .terms)
    }
}

#Preview("Privacy Policy") {
    NavigationStack {
        LegalDocumentView(documentType: .privacy)
    }
}

#Preview("Cancellation Policy") {
    NavigationStack {
        LegalDocumentView(documentType: .cancellationPolicy)
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        LegalDocumentView(documentType: .terms)
    }
    .preferredColorScheme(.dark)
}
