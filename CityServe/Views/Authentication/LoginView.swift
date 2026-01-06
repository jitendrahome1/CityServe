//
//  LoginView.swift
//  CityServe
//
//  Login Screen for Returning Users
//  Design Spec: 06_LOGIN.md
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var viewModel: AuthViewModel
    @State private var phoneInput = ""
    @State private var navigateToOTP = false
    @State private var showAccountNotFoundAlert = false
    @FocusState private var isPhoneFocused: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        // Logo
                        logoView
                            .padding(.top, 100)

                        // Title Section
                        titleSection
                            .padding(.top, Spacing.lg)

                        // Phone Input Section
                        phoneInputSection
                            .padding(.top, 48)

                        // Send OTP Button
                        sendOTPButton
                            .padding(.top, Spacing.lg)

                        // OR Divider
                        orDivider
                            .padding(.top, Spacing.xl)

                        // Google Sign In (Optional)
                        googleSignInButton
                            .padding(.top, Spacing.lg)

                        // Create Account Link
                        createAccountLink
                            .padding(.top, Spacing.xl)
                            .padding(.bottom, 40)

                        Spacer(minLength: 20)
                    }
                }
                .scrollDismissesKeyboard(.immediately)
            }
            .navigationBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    isPhoneFocused = true
                }
            }
            .alert("No Account Found", isPresented: $showAccountNotFoundAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Create Account") {
                    navigateToRegistration()
                }
            } message: {
                Text("Would you like to create an account with this number?")
            }
            .navigationDestination(isPresented: $navigateToOTP) {
                OTPVerificationView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Logo View

    private var logoView: some View {
        ZStack {
            Circle()
                .fill(Color.primary.opacity(0.1))
                .frame(width: 80, height: 80)

            Text("UN")
                .font(.custom("Inter-Bold", size: 32))
                .foregroundColor(.primary)
        }
    }

    // MARK: - Title Section

    private var titleSection: some View {
        VStack(spacing: Spacing.xs) {
            Text("Welcome Back!")
                .font(.custom("Inter-Bold", size: 28))
                .foregroundColor(.textPrimary)

            Text("Sign in to continue")
                .font(.bodyLarge)
                .foregroundColor(.textSecondary)
        }
    }

    // MARK: - Phone Input Section

    private var phoneInputSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Mobile Number")
                .font(.label)
                .foregroundColor(.textPrimary)

            // Phone input container
            HStack(spacing: 0) {
                // Country code picker
                HStack(spacing: Spacing.xxs) {
                    Text("🇮🇳")
                        .font(.system(size: Spacing.iconSM))

                    Text("+91")
                        .font(.h5)
                        .foregroundColor(.textPrimary)

                    Image(systemName: "chevron.down")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(.textTertiary)
                }
                .frame(width: 80)
                .padding(.vertical, Spacing.md)

                // Divider
                Rectangle()
                    .fill(Color.divider)
                    .frame(width: 1)
                    .padding(.vertical, Spacing.sm)

                // Phone number field
                TextField("99999 99999", text: $phoneInput)
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .keyboardType(.phonePad)
                    .focused($isPhoneFocused)
                    .padding(.horizontal, Spacing.md)
                    .onChange(of: phoneInput) { oldValue, newValue in
                        // Only allow digits, limit to 10
                        let filtered = newValue.filter { $0.isNumber }
                        phoneInput = String(filtered.prefix(10))

                        // Auto-format with space after 5 digits
                        if filtered.count > 5 {
                            let index = filtered.index(filtered.startIndex, offsetBy: 5)
                            phoneInput = "\(filtered[..<index]) \(filtered[index...])"
                        }

                        viewModel.phoneNumber = filtered
                        viewModel.errorMessage = nil
                    }

                // Valid indicator
                if isPhoneValid {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.success)
                        .padding(.trailing, Spacing.md)
                }
            }
            .frame(height: 56)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(
                        viewModel.errorMessage != nil ? Color.error :
                        isPhoneFocused ? Color.primary : Color.divider,
                        lineWidth: viewModel.errorMessage != nil ? 2 :
                        isPhoneFocused ? 2 : 1
                    )
            )
            .shadow(
                color: isPhoneFocused ? Color.primary.opacity(0.1) : .clear,
                radius: 4, x: 0, y: 0
            )

            // Error message
            if let error = viewModel.errorMessage {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(.error)

                    Text(error)
                        .font(.caption)
                        .foregroundColor(.error)
                }
                .padding(.top, Spacing.xs)
            }
        }
        .padding(.horizontal, Spacing.xl)
    }

    // MARK: - Send OTP Button

    private var sendOTPButton: some View {
        PrimaryButton(
            "Send OTP",
            isDisabled: !isPhoneValid || viewModel.isLoading,
            isLoading: viewModel.isLoading,
            size: .large
        ) {
            sendOTP()
        }
        .padding(.horizontal, Spacing.xl)
    }

    // MARK: - OR Divider

    private var orDivider: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.divider)
                .frame(height: 1)

            Text("OR")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.textTertiary)
                .padding(.horizontal, Spacing.md)
                .background(Color.background)

            Rectangle()
                .fill(Color.divider)
                .frame(height: 1)
        }
        .padding(.horizontal, Spacing.xl)
    }

    // MARK: - Google Sign In Button

    private var googleSignInButton: some View {
        Button(action: {
            // TODO: Implement Google Sign-In
            print("Google Sign-In tapped")
        }) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: "globe")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.textPrimary)

                Text("Continue with Google")
                    .font(.buttonSmall)
                    .foregroundColor(.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(Color.divider, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.04), radius: 2, y: 2)
        }
        .disabled(viewModel.isLoading)
        .padding(.horizontal, Spacing.xl)
    }

    // MARK: - Create Account Link

    private var createAccountLink: some View {
        HStack(spacing: Spacing.xxs) {
            Text("Don't have an account?")
                .font(.body)
                .foregroundColor(.textSecondary)

            Button(action: navigateToRegistration) {
                Text("Create Account")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
        }
    }

    // MARK: - Computed Properties

    private var isPhoneValid: Bool {
        let digits = phoneInput.filter { $0.isNumber }
        return digits.count == 10 && digits.first != "0"
    }

    // MARK: - Actions

    private func sendOTP() {
        guard isPhoneValid else {
            viewModel.errorMessage = "Please enter a valid 10-digit mobile number"
            return
        }

        isPhoneFocused = false

        Task {
            do {
                // Check if account exists first (Login specific)
                let accountExists = try await checkAccountExists()

                guard accountExists else {
                    showAccountNotFoundAlert = true
                    return
                }

                // Send OTP for existing account
                try await viewModel.sendOTP()

                // Navigate to OTP verification
                navigateToOTP = true

            } catch {
                viewModel.errorMessage = error.localizedDescription

                // Shake animation
                withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                    // Trigger shake
                }
            }
        }
    }

    private func checkAccountExists() async throws -> Bool {
        // TODO: Check Firestore for existing account
        // For now, simulate check
        try await Task.sleep(nanoseconds: 500_000_000)

        // Simulated: return true for demo
        return true

        // Real implementation:
        // let phoneNumber = "+91\(phoneInput.filter { $0.isNumber })"
        // let snapshot = try await Firestore.firestore()
        //     .collection("customers")
        //     .whereField("phoneNumber", isEqualTo: phoneNumber)
        //     .getDocuments()
        // return !snapshot.documents.isEmpty
    }

    private func navigateToRegistration() {
        // Navigate back or to registration screen
        dismiss()
    }
}

// MARK: - Preview

#Preview("Login - Light") {
    LoginView()
}

#Preview("Login - Dark") {
    LoginView()
        .preferredColorScheme(.dark)
}

#Preview("Login - With Phone") {
    struct PreviewWrapper: View {
        @State var phone = "98765"
        var body: some View {
            LoginView()
        }
    }
    return PreviewWrapper()
}
