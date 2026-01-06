//
//  SplashView.swift
//  CityServe
//
//  Splash Screen - App Launch
//

import SwiftUI

struct SplashView: View {

    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @State private var navigateToOnboarding = false

    var body: some View {
        ZStack {
            // Black background (as per design)
            Color.black
                .ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                // App Logo and Name
                VStack(spacing: Spacing.lg) {
                    // Logo icon (placeholder - replace with actual logo)
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color.primary, Color.primaryLight],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 100, height: 100)

                        Image(systemName: "house.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                    // App Name - "City serve"
                    Text("City serve")
                        .font(.custom("Inter-Bold", size: 34))
                        .foregroundColor(.white)
                        .opacity(logoOpacity)

                    // Tagline with highlighted "Trusted"
                    HStack(spacing: 4) {
                        Text("India's ")
                        Text("Trusted")
                            .foregroundColor(.secondary)  // Orange/red highlight
                        Text(" Choice for")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .opacity(logoOpacity)

                    Text("Quality Services")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .opacity(logoOpacity)
                }

                Spacer()

                // Loading indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                    .opacity(logoOpacity)

                Spacer()
                    .frame(height: Spacing.xxl)
            }
        }
        .onAppear {
            startAnimation()
        }
        .fullScreenCover(isPresented: $navigateToOnboarding) {
            OnboardingView()
        }
    }

    // MARK: - Animations

    private func startAnimation() {
        // Logo scale and fade in
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
            logoScale = 1.0
        }

        withAnimation(.easeOut(duration: 0.6)) {
            logoOpacity = 1.0
        }

        // Navigate after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            navigateToOnboarding = true
        }
    }
}

// MARK: - Preview

#Preview {
    SplashView()
}

#Preview("Dark Mode") {
    SplashView()
        .preferredColorScheme(.dark)
}
