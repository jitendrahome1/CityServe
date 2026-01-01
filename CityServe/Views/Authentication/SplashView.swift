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
            // Background gradient
            LinearGradient(
                colors: [Color.primary, Color.primaryDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: Spacing.xl) {
                Spacer()

                // App Logo
                VStack(spacing: Spacing.md) {
                    // Logo icon (placeholder - replace with actual logo)
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 120, height: 120)

                        Image(systemName: "house.fill")
                            .font(.displayMedium)
                            .foregroundColor(.white)
                    }
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                    // App Name
                    Text("UrbanNest")
                        .font(.custom("Inter-Bold", size: 36))
                        .foregroundColor(.white)
                        .opacity(logoOpacity)

                    // Tagline
                    Text("Trusted services, delivered smartly")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
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
