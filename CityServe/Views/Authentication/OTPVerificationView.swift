//
//  OTPVerificationView.swift
//  CityServe
//
//  OTP Verification Screen
//

import SwiftUI

struct OTPVerificationView: View {

    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToProfile = false
    @State private var navigateToHome = false
    @State private var timeRemaining = 30
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Header
                    headerView

                    // Title and description
                    VStack(spacing: Spacing.sm) {
                        Text("Verify Your Number")
                            .font(.h2)
                            .foregroundColor(.textPrimary)

                        Text("Enter the 6-digit code sent to")
                            .font(.body)
                            .foregroundColor(.textSecondary)

                        HStack(spacing: Spacing.xxs) {
                            Text("+91 \(viewModel.phoneNumber)")
                                .font(.bodyLarge)
                                .foregroundColor(.textPrimary)
                                .fontWeight(.semibold)

                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.h4)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.xl)

                    // OTP Input
                    VStack(spacing: Spacing.lg) {
                        OTPTextField(
                            otpCode: $viewModel.otpCode,
                            errorMessage: viewModel.errorMessage,
                            onComplete: { code in
                                verifyOTP()
                            }
                        )

                        // Resend section
                        HStack(spacing: Spacing.xxs) {
                            if timeRemaining > 0 {
                                Text("Resend code in")
                                    .font(.bodySmall)
                                    .foregroundColor(.textSecondary)

                                Text("\(timeRemaining)s")
                                    .font(.bodySmall)
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                            } else {
                                Text("Didn't receive the code?")
                                    .font(.bodySmall)
                                    .foregroundColor(.textSecondary)

                                Button(action: {
                                    resendOTP()
                                }) {
                                    Text("Resend")
                                        .font(.bodySmall)
                                        .foregroundColor(.primary)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.screenPadding)

                    Spacer()
                }
                .padding(.top, Spacing.xxl)
            }

            // Loading overlay
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                LoadingView(
                    message: "Verifying code...",
                    style: .spinner
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "chevron.left")
                            .font(.button)
                        Text("Back")
                            .font(.body)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .navigationDestination(isPresented: $navigateToProfile) {
            ProfileSetupView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $navigateToHome) {
            MainTabView()
                .environmentObject(viewModel)
                .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        ZStack {
            Circle()
                .fill(Color.success.opacity(0.1))
                .frame(width: 120, height: 120)

            Image(systemName: "message.fill")
                .font(.displaySmall)
                .foregroundColor(.success)
        }
        .padding(.top, Spacing.lg)
    }

    // MARK: - Actions

    private func verifyOTP() {
        Task {
            let isNewUser = await viewModel.verifyOTP()

            if viewModel.errorMessage == nil {
                if isNewUser {
                    // Navigate to profile setup
                    navigateToProfile = true
                } else {
                    // Existing user, login and go to home
                    await viewModel.login()
                    navigateToHome = true
                }
            }
        }
    }

    private func resendOTP() {
        Task {
            await viewModel.resendOTP()

            if viewModel.errorMessage == nil {
                // Reset timer
                timeRemaining = 30
                startTimer()

                // Show success feedback
                Haptics.success()
            }
        }
    }

    // MARK: - Timer

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        OTPVerificationView(viewModel: AuthViewModel())
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        OTPVerificationView(viewModel: AuthViewModel())
    }
    .preferredColorScheme(.dark)
}
