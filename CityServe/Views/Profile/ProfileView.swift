//
//  ProfileView.swift
//  CityServe
//
//  User Profile Dashboard
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel: ProfileViewModel
    @State private var showLogoutAlert = false

    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: Spacing.xl) {
                        // Profile Header
                        profileHeader

                        // Menu Options
                        menuSection

                        // App Settings
                        settingsSection

                        // Logout Button
                        logoutButton

                        // App Version
                        appVersionFooter

                        Spacer(minLength: Spacing.xl)
                    }
                    .padding(Spacing.screenPadding)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                if let user = authViewModel.currentUser {
                    viewModel.setUser(user)
                }
            }
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Logout", role: .destructive) {
                    logout()
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }

    // MARK: - Subviews

    private var profileHeader: some View {
        VStack(spacing: Spacing.md) {
            // Avatar
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

                if let user = authViewModel.currentUser {
                    Text(user.fullName.prefix(1))
                        .font(.custom("Inter-Bold", size: 40))
                        .foregroundColor(.white)
                }

                // Edit button
                Circle()
                    .fill(Color.surface)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "camera.fill")
                            .font(.body)
                            .foregroundColor(.primary)
                    )
                    .offset(x: 35, y: 35)
            }

            // Name and contact
            VStack(spacing: Spacing.xxs) {
                Text(authViewModel.currentUser?.fullName ?? "User")
                    .font(.h3)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.bold)

                if let email = authViewModel.currentUser?.email {
                    Text(email)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }

                Text(authViewModel.currentUser?.phoneNumber ?? "")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            // Edit Profile Button
            NavigationLink(destination: EditProfileView()) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "pencil")
                        .font(.body)

                    Text("Edit Profile")
                        .font(.bodySmall)
                        .fontWeight(.medium)
                }
                .foregroundColor(.primary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
                .background(Color.primary.opacity(0.1))
                .cornerRadius(Spacing.radiusPill)
            }
        }
        .padding(.vertical, Spacing.lg)
    }

    private var menuSection: some View {
        VStack(spacing: Spacing.sm) {
            NavigationLink(destination: SavedAddressesView()) {
                MenuRow(
                    icon: "location.fill",
                    iconColor: .primary,
                    title: "Saved Addresses",
                    subtitle: "\(authViewModel.currentUser?.addresses.count ?? 0) addresses"
                )
            }

            NavigationLink(destination: OrdersView()) {
                MenuRow(
                    icon: "clock.arrow.circlepath",
                    iconColor: .info,
                    title: "My Bookings",
                    subtitle: "View all bookings"
                )
            }

            NavigationLink(destination: Text("Payment Methods")) {
                MenuRow(
                    icon: "creditcard",
                    iconColor: .success,
                    title: "Payment Methods",
                    subtitle: "Manage payment options"
                )
            }

            NavigationLink(destination: Text("Wallet & Offers")) {
                MenuRow(
                    icon: "gift",
                    iconColor: .secondary,
                    title: "Wallet & Offers",
                    subtitle: "View available offers"
                )
            }
        }
    }

    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Settings")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)
                .padding(.horizontal, Spacing.sm)

            VStack(spacing: Spacing.sm) {
                NavigationLink(destination: NotificationSettingsView()) {
                    MenuRow(
                        icon: "bell.fill",
                        iconColor: .warning,
                        title: "Notifications",
                        subtitle: "Manage notification preferences"
                    )
                }

                NavigationLink(destination: Text("Privacy & Security")) {
                    MenuRow(
                        icon: "lock.shield.fill",
                        iconColor: .primary,
                        title: "Privacy & Security",
                        subtitle: "Manage your privacy settings"
                    )
                }

                NavigationLink(destination: HelpCenterView()) {
                    MenuRow(
                        icon: "questionmark.circle.fill",
                        iconColor: .info,
                        title: "Help & Support",
                        subtitle: "FAQs and contact us"
                    )
                }

                NavigationLink(destination: Text("About")) {
                    MenuRow(
                        icon: "info.circle.fill",
                        iconColor: .textSecondary,
                        title: "About UrbanNest",
                        subtitle: "Terms, privacy policy"
                    )
                }
            }
        }
    }

    private var logoutButton: some View {
        Button(action: {
            showLogoutAlert = true
        }) {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.h5)

                Text("Logout")
                    .font(.bodyLarge)
                    .fontWeight(.semibold)

                Spacer()
            }
            .foregroundColor(.error)
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
        }
    }

    private var appVersionFooter: some View {
        VStack(spacing: Spacing.xs) {
            Text("UrbanNest")
                .font(.caption)
                .foregroundColor(.textTertiary)

            Text("Version 1.0.0 (Build 1)")
                .font(.caption)
                .foregroundColor(.textTertiary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Spacing.md)
    }

    // MARK: - Actions

    private func logout() {
        authViewModel.signOut()
        Haptics.medium()
    }
}

// MARK: - Menu Row

struct MenuRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: Spacing.md) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.h5)
                    .foregroundColor(iconColor)
            }

            // Text
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .font(.bodyLarge)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimary)

                Text(subtitle)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            // Chevron
            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundColor(.textTertiary)
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
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
        addresses: [
            Address(
                id: "1",
                label: "Home",
                fullAddress: "123, MG Road, Connaught Place, New Delhi - 110001",
                city: "Delhi",
                isDefault: true
            )
        ],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return ProfileView()
        .environmentObject(authViewModel)
}
