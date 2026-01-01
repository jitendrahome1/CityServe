//
//  EditProfileView.swift
//  CityServe
//
//  Edit User Profile Information
//

import SwiftUI

struct EditProfileView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showSuccessAlert = false

    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Profile Photo
                    profilePhotoSection

                    // Personal Information
                    personalInfoSection

                    // Contact Information
                    contactInfoSection

                    // City Selection
                    citySection

                    // Error/Success Messages
                    if let error = viewModel.errorMessage {
                        ErrorBanner(message: error)
                    }

                    if let success = viewModel.successMessage {
                        SuccessBanner(message: success)
                    }

                    Spacer(minLength: Spacing.xl)
                }
                .padding(Spacing.screenPadding)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveProfile()
                }) {
                    Text("Save")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .disabled(!viewModel.hasChanges || viewModel.isLoading)
            }
        }
        .onAppear {
            if let user = authViewModel.currentUser {
                viewModel.setUser(user)
            }
        }
        .alert("Profile Updated", isPresented: $showSuccessAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your profile has been updated successfully")
        }
    }

    // MARK: - Subviews

    private var profilePhotoSection: some View {
        VStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.primary, Color.primaryDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)

                Text(viewModel.fullName.prefix(1))
                    .font(.custom("Inter-Bold", size: 40))
                    .foregroundColor(.white)

                // Edit button
                Button(action: {
                    // Open photo picker
                }) {
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.body)
                                .foregroundColor(.white)
                        )
                }
                .offset(x: 35, y: 35)
            }

            Text("Change Photo")
                .font(.bodySmall)
                .foregroundColor(.primary)
        }
        .padding(.vertical, Spacing.md)
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Personal Information")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            StandardTextField(
                label: "Full Name *",
                placeholder: "Enter your full name",
                text: $viewModel.fullName,
                leadingIcon: "person"
            )
        }
    }

    private var contactInfoSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Contact Information")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            // Phone Number (readonly)
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Phone Number")
                    .font(.label)
                    .foregroundColor(.textPrimary)

                HStack(spacing: Spacing.sm) {
                    Image(systemName: "phone")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.textSecondary)

                    Text(viewModel.phoneNumber)
                        .font(.input)
                        .foregroundColor(.textSecondary)

                    Spacer()

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.success)
                }
                .padding(Spacing.md)
                .background(Color.surface.opacity(0.5))
                .cornerRadius(Spacing.radiusMd)

                Text("Phone number cannot be changed")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
                    .padding(.horizontal, Spacing.sm)
            }

            StandardTextField(
                label: "Email Address (Optional)",
                placeholder: "you@example.com",
                text: $viewModel.email,
                leadingIcon: "envelope"
            )
        }
    }

    private var citySection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Location")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("City *")
                    .font(.label)
                    .foregroundColor(.textPrimary)

                Menu {
                    ForEach(viewModel.availableCities, id: \.self) { city in
                        Button(city) {
                            viewModel.selectedCity = city
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.system(size: Spacing.iconSM))
                            .foregroundColor(.textSecondary)

                        Text(viewModel.selectedCity.isEmpty ? "Select city" : viewModel.selectedCity)
                            .font(.input)
                            .foregroundColor(viewModel.selectedCity.isEmpty ? .textTertiary : .textPrimary)

                        Spacer()

                        Image(systemName: "chevron.down")
                            .font(.body)
                            .foregroundColor(.textSecondary)
                    }
                    .padding(Spacing.md)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusMd)
                }
            }
        }
    }

    // MARK: - Actions

    private func saveProfile() {
        Task {
            let success = await viewModel.updateProfile()
            if success {
                // Update auth view model
                if let updatedUser = viewModel.user {
                    authViewModel.currentUser = updatedUser
                }
                showSuccessAlert = true
            }
        }
    }
}

// MARK: - Success Banner

struct SuccessBanner: View {
    let message: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: Spacing.iconSM))
                .foregroundColor(.success)

            Text(message)
                .font(.bodySmall)
                .foregroundColor(.success)
                .lineLimit(2)

            Spacer()
        }
        .padding(Spacing.md)
        .background(Color.success.opacity(0.1))
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - Preview

#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )

    return NavigationStack {
        EditProfileView()
            .environmentObject(authViewModel)
    }
}
