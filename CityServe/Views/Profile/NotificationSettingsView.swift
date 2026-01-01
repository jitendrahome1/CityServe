//
//  NotificationSettingsView.swift
//  CityServe
//
//  Notification Preferences
//

import SwiftUI

struct NotificationSettingsView: View {

    @StateObject private var viewModel = ProfileViewModel()
    @State private var showSaveSuccess = false

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    // Header
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Manage your notifications")
                            .font(.body)
                            .foregroundColor(.textSecondary)
                    }

                    // General Notifications
                    generalSection

                    Divider()

                    // Push Notifications
                    pushSection

                    Divider()

                    // Email Notifications
                    emailSection

                    Divider()

                    // SMS Notifications
                    smsSection

                    // Info Notice
                    infoNotice

                    Spacer(minLength: Spacing.xl)
                }
                .padding(Spacing.screenPadding)
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveSettings()
                }
                .fontWeight(.semibold)
            }
        }
        .alert("Settings Saved", isPresented: $showSaveSuccess) {
            Button("OK") {}
        } message: {
            Text("Your notification preferences have been updated")
        }
    }

    // MARK: - Subviews

    private var generalSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("General")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            Toggle(isOn: $viewModel.notificationsEnabled) {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Enable Notifications")
                        .font(.bodyLarge)
                        .foregroundColor(.textPrimary)

                    Text("Receive updates about your bookings")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }
            }
            .tint(.primary)
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
        }
    }

    private var pushSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Push Notifications")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            VStack(spacing: Spacing.sm) {
                Toggle(isOn: $viewModel.pushNotifications) {
                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text("Push Notifications")
                            .font(.bodyLarge)
                            .foregroundColor(.textPrimary)

                        Text("Get instant updates on your device")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    }
                }
                .tint(.primary)
                .padding(Spacing.md)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusMd)
                .disabled(!viewModel.notificationsEnabled)
                .opacity(viewModel.notificationsEnabled ? 1.0 : 0.5)

                // Push notification types
                if viewModel.pushNotifications && viewModel.notificationsEnabled {
                    VStack(spacing: Spacing.xs) {
                        NotificationTypeRow(
                            title: "Booking Confirmations",
                            description: "When your booking is confirmed",
                            isEnabled: .constant(true)
                        )

                        NotificationTypeRow(
                            title: "Provider Updates",
                            description: "When provider is assigned or en route",
                            isEnabled: .constant(true)
                        )

                        NotificationTypeRow(
                            title: "Service Reminders",
                            description: "Reminder before scheduled service",
                            isEnabled: .constant(true)
                        )

                        NotificationTypeRow(
                            title: "Promotional Offers",
                            description: "Special discounts and offers",
                            isEnabled: .constant(false)
                        )
                    }
                    .padding(.leading, Spacing.md)
                }
            }
        }
    }

    private var emailSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Email Notifications")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            Toggle(isOn: $viewModel.emailNotifications) {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Email Notifications")
                        .font(.bodyLarge)
                        .foregroundColor(.textPrimary)

                    Text("Receive booking confirmations and receipts via email")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }
            }
            .tint(.primary)
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .disabled(!viewModel.notificationsEnabled)
            .opacity(viewModel.notificationsEnabled ? 1.0 : 0.5)
        }
    }

    private var smsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("SMS Notifications")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            Toggle(isOn: $viewModel.smsNotifications) {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("SMS Notifications")
                        .font(.bodyLarge)
                        .foregroundColor(.textPrimary)

                    Text("Receive text messages for important updates")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }
            }
            .tint(.primary)
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .disabled(!viewModel.notificationsEnabled)
            .opacity(viewModel.notificationsEnabled ? 1.0 : 0.5)
        }
    }

    private var infoNotice: some View {
        HStack(alignment: .top, spacing: Spacing.sm) {
            Image(systemName: "info.circle")
                .font(.system(size: Spacing.iconSM))
                .foregroundColor(.info)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("Important Updates")
                    .font(.bodySmall)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Text("You'll always receive critical updates about your active bookings, even if notifications are disabled")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)
            }
        }
        .padding(Spacing.md)
        .background(Color.info.opacity(0.05))
        .cornerRadius(Spacing.radiusMd)
    }

    // MARK: - Actions

    private func saveSettings() {
        Task {
            let success = await viewModel.updateNotificationSettings()
            if success {
                showSaveSuccess = true
            }
        }
    }
}

// MARK: - Notification Type Row

struct NotificationTypeRow: View {
    let title: String
    let description: String
    @Binding var isEnabled: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.textPrimary)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            Image(systemName: isEnabled ? "checkmark.circle.fill" : "circle")
                .font(.h5)
                .foregroundColor(isEnabled ? .primary : .textTertiary)
        }
        .padding(Spacing.sm)
        .background(Color.surface.opacity(0.5))
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        NotificationSettingsView()
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        NotificationSettingsView()
    }
    .preferredColorScheme(.dark)
}
