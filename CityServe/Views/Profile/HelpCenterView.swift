//
//  HelpCenterView.swift
//  CityServe
//
//  Help Center with FAQs and Support Options
//

import SwiftUI

struct HelpCenterView: View {
    @StateObject private var viewModel = HelpCenterViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // Search Bar
                searchBar

                // Quick Actions
                quickActions

                Divider()
                    .padding(.horizontal, Spacing.md)

                // Popular Topics
                popularTopicsSection

                Divider()
                    .padding(.horizontal, Spacing.md)

                // Frequently Asked Questions
                faqSection

                Divider()
                    .padding(.horizontal, Spacing.md)

                // Need More Help Section
                needMoreHelpSection

                Divider()
                    .padding(.horizontal, Spacing.md)

                // App Info
                appInfoSection
            }
            .padding(.vertical, Spacing.md)
        }
        .navigationTitle("Help Center")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.showSettings() }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .sheet(isPresented: $viewModel.showingChat) {
            ChatInterfaceView()
        }
        .sheet(isPresented: $viewModel.showingContactForm) {
            ContactSupportView()
        }
        .sheet(isPresented: $viewModel.showingAllFAQs) {
            AllFAQsView(faqs: viewModel.allFAQs)
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    LoadingView(message: "Loading help center...", style: .spinner)
                }
            }
        }
    }

    // MARK: - Search Bar

    private var searchBar: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.textTertiary)
                .font(.system(size: Spacing.iconSM))

            TextField("How can we help you?", text: $viewModel.searchText)
                .font(.body)
                .foregroundColor(.textPrimary)
                .onChange(of: viewModel.searchText) { newValue in
                    viewModel.searchArticles(query: newValue)
                }

            if !viewModel.searchText.isEmpty {
                Button(action: { viewModel.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.textTertiary)
                        .font(.system(size: Spacing.iconSM))
                }
            }
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Quick Actions

    private var quickActions: some View {
        HStack(spacing: Spacing.md) {
            QuickActionButton(
                icon: "phone.fill",
                title: "Call",
                color: .success,
                action: { viewModel.callSupport() }
            )

            QuickActionButton(
                icon: "message.fill",
                title: "Chat",
                color: .primary,
                action: { viewModel.openChat() }
            )

            QuickActionButton(
                icon: "envelope.fill",
                title: "Email",
                color: .secondary,
                action: { viewModel.emailSupport() }
            )

            QuickActionButton(
                icon: "questionmark.circle.fill",
                title: "FAQ",
                color: .textSecondary,
                action: { viewModel.scrollToFAQ() }
            )
        }
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Popular Topics

    private var popularTopicsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Popular Topics")
                .font(.h3)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.md)

            ForEach(viewModel.popularTopics) { topic in
                TopicCard(topic: topic) {
                    // Navigate to topic articles
                    print("Navigate to topic: \(topic.title)")
                }
                .padding(.horizontal, Spacing.md)
            }
        }
    }

    // MARK: - FAQ Section

    private var faqSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Frequently Asked")
                .font(.h3)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.md)

            ForEach(viewModel.topFAQs) { faq in
                HelpFAQItem(
                    faq: faq,
                    isExpanded: viewModel.expandedFAQId == faq.id,
                    onTap: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.toggleFAQ(faq.id)
                        }
                    },
                    onHelpful: { isHelpful in
                        viewModel.markFAQHelpful(faq.id, helpful: isHelpful)
                    }
                )
                .padding(.horizontal, Spacing.md)
            }

            Button(action: { viewModel.showAllFAQs() }) {
                Text("View All FAQs")
                    .font(.buttonSmall)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding(.horizontal, Spacing.md)
        }
    }

    // MARK: - Need More Help

    private var needMoreHelpSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Need More Help?")
                .font(.h3)
                .foregroundColor(.textPrimary)

            Text("Still can't find what you're looking for?")
                .font(.body)
                .foregroundColor(.textSecondary)

            // Contact Support Button
            Button(action: { viewModel.openContactSupport() }) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "message.fill")
                        .font(.system(size: Spacing.iconSM))
                    Text("Contact Support")
                        .font(.button)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.primary)
                .cornerRadius(10)
            }

            // Call Button
            if let contact = viewModel.supportContact {
                Button(action: { viewModel.callSupport() }) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "phone.fill")
                            .font(.system(size: Spacing.iconSM))
                        Text("Call: \(contact.phone)")
                            .font(.h5)
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.white)
                    .cornerRadius(Spacing.radiusLg)
                    .overlay(
                        RoundedRectangle(cornerRadius: Spacing.radiusLg)
                            .stroke(Color.primary, lineWidth: 1.5)
                    )
                }

                // Operating Hours
                HStack(spacing: Spacing.xs) {
                    Image(systemName: contact.isCurrentlyOpen ? "clock.fill" : "clock")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(contact.isCurrentlyOpen ? .success : .textTertiary)
                    Text(contact.operatingHours)
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                    if contact.isCurrentlyOpen {
                        Text("• Open Now")
                            .font(.caption)
                            .foregroundColor(.success)
                    }
                }
            }
        }
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - App Info

    private var appInfoSection: some View {
        VStack(spacing: Spacing.xs) {
            Text("App Version: \(viewModel.appVersion)")
                .font(.caption)
                .foregroundColor(.textTertiary)

            HStack(spacing: Spacing.md) {
                Button("Terms of Service") {
                    viewModel.openTerms()
                }
                .font(.caption)
                .foregroundColor(.primary)

                Text("|")
                    .foregroundColor(.textTertiary)

                Button("Privacy Policy") {
                    viewModel.openPrivacy()
                }
                .font(.caption)
                .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.md)
    }
}

// MARK: - Quick Action Button

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: Spacing.iconMD))
                    .foregroundColor(color)
                    .frame(width: 56, height: 56)
                    .background(color.opacity(0.1))
                    .clipShape(Circle())

                Text(title)
                    .font(.caption)
                    .foregroundColor(.textPrimary)
            }
            .frame(maxWidth: .infinity)
        }
        .accessibilityLabel("\(title) support")
        .accessibilityHint("Double tap to \(title.lowercased()) customer support")
    }
}

// MARK: - Topic Card

struct TopicCard: View {
    let topic: HelpTopic
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.sm) {
                Text(topic.icon)
                    .font(.h3)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(topic.title)
                        .font(.h5)
                        .foregroundColor(.textPrimary)

                    Text("\(topic.articleCount) articles")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.textTertiary)
            }
            .padding(Spacing.md)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.divider, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel("\(topic.title) topic")
        .accessibilityHint("Double tap to view \(topic.articleCount) articles")
    }
}

// MARK: - Help FAQ Item

struct HelpFAQItem: View {
    let faq: HelpFAQ
    let isExpanded: Bool
    let onTap: () -> Void
    let onHelpful: (Bool) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Question Button
            Button(action: onTap) {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.primary)

                    Text(faq.question)
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.body)
                        .foregroundColor(.textTertiary)
                }
                .padding(.vertical, 14)
            }
            .buttonStyle(PlainButtonStyle())

            // Answer (Expandable)
            if isExpanded {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(faq.answer)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(4)
                        .padding(.bottom, Spacing.xs)

                    // Was this helpful?
                    HStack(spacing: Spacing.xs) {
                        Text("Was this helpful?")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)

                        Button(action: { onHelpful(true) }) {
                            HStack(spacing: Spacing.xxs) {
                                Image(systemName: "hand.thumbsup.fill")
                                    .font(.system(size: Spacing.iconXS))
                                Text("Yes")
                                    .font(.caption)
                            }
                            .foregroundColor(faq.wasHelpful == true ? .success : .textTertiary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                faq.wasHelpful == true ?
                                    Color.success.opacity(0.1) :
                                    Color.surface
                            )
                            .cornerRadius(6)
                        }

                        Button(action: { onHelpful(false) }) {
                            HStack(spacing: Spacing.xxs) {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .font(.system(size: Spacing.iconXS))
                                Text("No")
                                    .font(.caption)
                            }
                            .foregroundColor(faq.wasHelpful == false ? .error : .textTertiary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                faq.wasHelpful == false ?
                                    Color.error.opacity(0.1) :
                                    Color.surface
                            )
                            .cornerRadius(6)
                        }
                    }
                }
                .padding(.bottom, Spacing.sm)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }

            Divider()
        }
        .accessibilityLabel(faq.question)
        .accessibilityHint(isExpanded ? "Double tap to collapse answer" : "Double tap to expand answer")
    }
}

// MARK: - All FAQs View

struct AllFAQsView: View {
    let faqs: [HelpFAQ]
    @Environment(\.dismiss) private var dismiss
    @State private var expandedFAQId: String?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(faqs) { faq in
                        HelpFAQItem(
                            faq: faq,
                            isExpanded: expandedFAQId == faq.id,
                            onTap: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    expandedFAQId = (expandedFAQId == faq.id) ? nil : faq.id
                                }
                            },
                            onHelpful: { _ in }
                        )
                        .padding(.horizontal, Spacing.md)
                    }
                }
                .padding(.vertical, Spacing.md)
            }
            .navigationTitle("All FAQs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HelpCenterView()
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        HelpCenterView()
    }
    .preferredColorScheme(.dark)
}
