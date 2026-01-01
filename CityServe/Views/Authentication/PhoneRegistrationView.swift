//
//  PhoneRegistrationView.swift
//  CityServe
//
//  Phone Number Registration
//

import SwiftUI

struct PhoneRegistrationView: View {

    @StateObject private var viewModel = AuthViewModel()
    @State private var phoneInput = ""
    @State private var navigateToOTP = false
    @FocusState private var isPhoneFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: Spacing.xl) {
                        // Header illustration
                        headerView

                        // Title and description
                        VStack(spacing: Spacing.sm) {
                            Text("Enter Your Phone Number")
                                .font(.h2)
                                .foregroundColor(.textPrimary)
                                .multilineTextAlignment(.center)

                            Text("We'll send you a verification code")
                                .font(.body)
                                .foregroundColor(.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, Spacing.xl)

                        // Phone input
                        VStack(spacing: Spacing.lg) {
                            // Country code + Phone number
                            HStack(spacing: Spacing.sm) {
                                // Country code (fixed)
                                HStack(spacing: Spacing.xxs) {
                                    Text("🇮🇳")
                                        .font(.h3)

                                    Text("+91")
                                        .font(.h4)
                                        .foregroundColor(.textPrimary)
                                }
                                .padding(Spacing.md)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusMd)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Spacing.radiusMd)
                                        .stroke(Color.divider, lineWidth: 1)
                                )

                                // Phone number field
                                TextField("98765 43210", text: $phoneInput)
                                    .font(.h4)
                                    .foregroundColor(.textPrimary)
                                    .keyboardType(.phonePad)
                                    .focused($isPhoneFocused)
                                    .padding(Spacing.md)
                                    .background(Color.surface)
                                    .cornerRadius(Spacing.radiusMd)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: Spacing.radiusMd)
                                            .stroke(
                                                isPhoneFocused ? Color.primary : Color.divider,
                                                lineWidth: isPhoneFocused ? 2 : 1
                                            )
                                    )
                                    .onChange(of: phoneInput) { oldValue, newValue in
                                        // Only allow digits, limit to 10
                                        let filtered = newValue.filter { $0.isNumber }
                                        phoneInput = String(filtered.prefix(10))
                                        viewModel.phoneNumber = phoneInput
                                    }
                            }

                            // Error message
                            if let error = viewModel.errorMessage {
                                ErrorBanner(message: error) {
                                    viewModel.errorMessage = nil
                                }
                            }
                        }
                        .padding(.horizontal, Spacing.screenPadding)

                        // Terms and privacy
                        Text("By continuing, you agree to our [Terms of Service](https://urbanest.com/terms) and [Privacy Policy](https://urbanest.com/privacy)")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Spacing.xl)

                        Spacer()
                    }
                    .padding(.top, Spacing.xxl)
                }

                // Bottom button
                VStack {
                    Spacer()

                    PrimaryButton(
                        "Send OTP",
                        isDisabled: !isPhoneValid,
                        isLoading: viewModel.isLoading,
                        action: {
                            sendOTP()
                        }
                    )
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.xl)
                }
            }
            .onAppear {
                // Auto-focus phone field
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isPhoneFocused = true
                }
            }
            .navigationDestination(isPresented: $navigateToOTP) {
                OTPVerificationView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        VStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 120, height: 120)

                Image(systemName: "phone.fill")
                    .font(.displaySmall)
                    .foregroundColor(.primary)
            }
        }
        .padding(.top, Spacing.lg)
    }

    // MARK: - Computed Properties

    private var isPhoneValid: Bool {
        viewModel.validatePhoneNumber(phoneInput)
    }

    // MARK: - Actions

    private func sendOTP() {
        Task {
            await viewModel.sendOTP()

            if viewModel.errorMessage == nil {
                navigateToOTP = true
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PhoneRegistrationView()
}

#Preview("Dark Mode") {
    PhoneRegistrationView()
        .preferredColorScheme(.dark)
}

#Preview("With Error") {
    PhoneRegistrationView()
}
