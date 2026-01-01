//
//  OnboardingView.swift
//  CityServe
//
//  Onboarding Flow - Feature Introduction
//

import SwiftUI

struct OnboardingView: View {

    @State private var currentPage = 0
    @State private var navigateToAuth = false

    private let pages = [
        OnboardingPage(
            icon: "house.fill",
            title: "Book Home Services",
            description: "From AC repair to house cleaning, book trusted professionals for all your home needs",
            color: Color.primary
        ),
        OnboardingPage(
            icon: "calendar.badge.clock",
            title: "Schedule at Your Convenience",
            description: "Choose your preferred date and time. Our experts will arrive on schedule, guaranteed",
            color: Color.secondary
        ),
        OnboardingPage(
            icon: "checkmark.seal.fill",
            title: "Verified Professionals",
            description: "All service providers are background-verified and highly rated by customers like you",
            color: Color.success
        )
    ]

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    Button(action: {
                        navigateToAuth = true
                    }) {
                        Text("Skip")
                            .font(.button)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.trailing, Spacing.screenPadding)
                    .padding(.top, Spacing.md)
                }

                // Onboarding pages
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)

                // Page indicator
                HStack(spacing: Spacing.xs) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.primary : Color.textTertiary)
                            .frame(width: 8, height: 8)
                            .scaleEffect(currentPage == index ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: currentPage)
                    }
                }
                .padding(.bottom, Spacing.lg)

                // Continue/Get Started button
                PrimaryButton(
                    currentPage == pages.count - 1 ? "Get Started" : "Continue",
                    icon: currentPage == pages.count - 1 ? nil : "arrow.right"
                ) {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        navigateToAuth = true
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.xl)
            }
        }
        .fullScreenCover(isPresented: $navigateToAuth) {
            PhoneRegistrationView()
        }
    }
}

// MARK: - Onboarding Page Model

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
    let color: Color
}

// MARK: - Onboarding Page View

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: Spacing.xl) {
            Spacer()

            // Icon
            ZStack {
                Circle()
                    .fill(page.color.opacity(0.1))
                    .frame(width: 160, height: 160)

                Image(systemName: page.icon)
                    .font(.displayLarge)
                    .foregroundColor(page.color)
            }
            .padding(.bottom, Spacing.lg)

            // Title
            Text(page.title)
                .font(.h2)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xl)

            // Description
            Text(page.description)
                .font(.bodyLarge)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xl)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingView()
}

#Preview("Dark Mode") {
    OnboardingView()
        .preferredColorScheme(.dark)
}
