//
//  ProfileSetupView.swift
//  CityServe
//
//  Profile Setup for New Users
//

import SwiftUI

struct ProfileSetupView: View {

    @ObservedObject var viewModel: AuthViewModel
    @State private var navigateToHome = false

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Header
                    headerView

                    // Title
                    VStack(spacing: Spacing.sm) {
                        Text(Strings.Auth.profileTitle)
                            .font(.h2)
                            .foregroundColor(.textPrimary)

                        Text(Strings.Auth.profileSubtitle)
                            .font(.body)
                            .foregroundColor(.textSecondary)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.xl)

                    // Form fields
                    VStack(spacing: Spacing.formFieldGap) {
                        // Full Name
                        StandardTextField(
                            label: Strings.Auth.nameLabel,
                            placeholder: Strings.Auth.namePlaceholder,
                            text: $viewModel.fullName,
                            leadingIcon: "person",
                            textContentType: .name,
                            autocapitalization: .words
                        )

                        // Email (Optional)
                        StandardTextField(
                            label: Strings.Auth.emailLabel,
                            placeholder: Strings.Auth.emailPlaceholder,
                            text: $viewModel.email,
                            leadingIcon: "envelope",
                            helpText: Strings.Auth.emailHelp,
                            keyboardType: .emailAddress,
                            textContentType: .emailAddress,
                            autocapitalization: .never
                        )

                        // City Selection
                        VStack(alignment: .leading, spacing: Spacing.labelInputGap) {
                            Text(Strings.Auth.cityLabel)
                                .font(.label)
                                .foregroundColor(.textSecondary)

                            Menu {
                                ForEach(viewModel.availableCities, id: \.self) { city in
                                    Button(action: {
                                        viewModel.selectedCity = city
                                    }) {
                                        HStack {
                                            Text(city)
                                            if viewModel.selectedCity == city {
                                                Spacer()
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.primary)
                                            }
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "location.fill")
                                        .font(.system(size: Spacing.iconMD))
                                        .foregroundColor(viewModel.selectedCity.isEmpty ? .textSecondary : .primary)

                                    Text(viewModel.selectedCity.isEmpty ? Strings.Auth.cityPlaceholder : viewModel.selectedCity)
                                        .font(.input)
                                        .foregroundColor(viewModel.selectedCity.isEmpty ? .textTertiary : .textPrimary)

                                    Spacer()

                                    Image(systemName: "chevron.down")
                                        .font(.buttonSmall)
                                        .foregroundColor(.textSecondary)
                                }
                                .padding(Spacing.md)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusLg)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                                        .stroke(
                                            viewModel.selectedCity.isEmpty ? Color.divider : Color.primary,
                                            lineWidth: viewModel.selectedCity.isEmpty ? 1 : 2
                                        )
                                )
                            }
                        }

                        // Error message
                        if let error = viewModel.errorMessage {
                            HStack(spacing: Spacing.sm) {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.system(size: Spacing.iconMD))
                                    .foregroundColor(.error)

                                Text(error)
                                    .font(.bodySmall)
                                    .foregroundColor(.error)

                                Spacer()

                                Button(action: {
                                    viewModel.errorMessage = nil
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: Spacing.iconXS))
                                        .foregroundColor(.error)
                                }
                            }
                            .padding(Spacing.md)
                            .background(Color.error.opacity(0.1))
                            .cornerRadius(Spacing.radiusLg)
                        }
                    }
                    .padding(.horizontal, Spacing.screenPadding)

                    // Privacy note
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: Spacing.iconSM))
                            .foregroundColor(.primary)

                        Text(Strings.Auth.privacy)
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, Spacing.xl)

                    Spacer()
                }
                .padding(.top, Spacing.xxl)
            }

            // Bottom button
            VStack {
                Spacer()

                PrimaryButton(
                    Strings.Auth.complete,
                    isDisabled: !isFormValid,
                    isLoading: viewModel.isLoading,
                    action: {
                        completeSetup()
                    }
                )
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.xl)
            }

            // Loading overlay
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                LoadingView(
                    message: Strings.Auth.settingUp,
                    style: .spinner
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToHome) {
            MainTabView()
                .environmentObject(viewModel)
                .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        VStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 120, height: 120)

                // Profile icon placeholder
                Image(systemName: "person.crop.circle.fill")
                    .font(.displayLarge)
                    .foregroundColor(.primary)
            }

            // Photo upload option
            Button(action: {
                // TODO: Implement photo picker
                print("Upload photo")
            }) {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "camera.fill")
                        .font(.system(size: Spacing.iconXS))

                    Text(Strings.Auth.addPhoto)
                        .font(.bodySmall)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
                .background(Color.primary.opacity(0.1))
                .cornerRadius(Spacing.radiusPill)
            }
        }
        .padding(.top, Spacing.lg)
    }

    // MARK: - Computed Properties

    private var isFormValid: Bool {
        !viewModel.fullName.isEmpty && !viewModel.selectedCity.isEmpty
    }

    // MARK: - Actions

    private func completeSetup() {
        Task {
            let success = await viewModel.completeRegistration()

            if success {
                // Celebrate!
                Haptics.success()

                // Navigate to home
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigateToHome = true
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ProfileSetupView(viewModel: AuthViewModel())
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        ProfileSetupView(viewModel: AuthViewModel())
    }
    .preferredColorScheme(.dark)
}
