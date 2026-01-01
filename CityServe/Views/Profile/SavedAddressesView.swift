//
//  SavedAddressesView.swift
//  CityServe
//
//  Manage Saved Addresses
//

import SwiftUI

struct SavedAddressesView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel: ProfileViewModel
    @State private var showAddAddress = false
    @State private var selectedAddress: Address?
    @State private var showDeleteAlert = false
    @State private var addressToDelete: String?

    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                if viewModel.addresses.isEmpty {
                    emptyState
                } else {
                    addressesList
                }
            }
        }
        .navigationTitle("Saved Addresses")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    selectedAddress = nil
                    showAddAddress = true
                }) {
                    Image(systemName: "plus")
                        .font(.button)
                }
            }
        }
        .sheet(isPresented: $showAddAddress) {
            if let address = selectedAddress {
                EditAddressSheet(address: address, onSave: { updatedAddress in
                    viewModel.updateAddress(updatedAddress)
                    showAddAddress = false
                })
            } else {
                AddAddressView(onSave: { newAddress in
                    viewModel.addAddress(newAddress)
                    showAddAddress = false
                })
            }
        }
        .alert("Delete Address", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if let addressId = addressToDelete {
                    viewModel.deleteAddress(addressId)
                }
            }
        } message: {
            Text("Are you sure you want to delete this address?")
        }
        .onAppear {
            if let user = authViewModel.currentUser {
                viewModel.setUser(user)
            }
        }
    }

    // MARK: - Subviews

    private var emptyState: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            EmptyStateView(
                icon: "mappin.slash",
                title: "No Saved Addresses",
                description: "Add an address to use for your bookings"
            )

            PrimaryButton(
                "Add Address",
                icon: "plus",
                size: .large,
                action: {
                    showAddAddress = true
                }
            )
            .padding(.horizontal, Spacing.screenPadding)

            Spacer()
        }
    }

    private var addressesList: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.md) {
                ForEach(viewModel.addresses) { address in
                    AddressManagementCard(
                        address: address,
                        onEdit: {
                            selectedAddress = address
                            showAddAddress = true
                        },
                        onDelete: {
                            addressToDelete = address.id
                            showDeleteAlert = true
                        },
                        onSetDefault: {
                            viewModel.setDefaultAddress(address.id)
                        }
                    )
                }
            }
            .padding(Spacing.screenPadding)
        }
    }
}

// MARK: - Address Management Card

struct AddressManagementCard: View {
    let address: Address
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onSetDefault: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Header
            HStack {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "location.fill")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text(address.label)
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                }

                Spacer()

                if address.isDefault {
                    Text("DEFAULT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, Spacing.xs)
                        .padding(.vertical, 2)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(4)
                }
            }

            // Address
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(address.fullAddress)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)

                Text(address.city)
                    .font(.bodySmall)
                    .foregroundColor(.textTertiary)
            }

            Divider()

            // Actions
            HStack(spacing: Spacing.lg) {
                if !address.isDefault {
                    Button(action: {
                        onSetDefault()
                    }) {
                        HStack(spacing: Spacing.xxs) {
                            Image(systemName: "checkmark.circle")
                                .font(.body)

                            Text("Set as Default")
                                .font(.bodySmall)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.primary)
                    }
                }

                Spacer()

                Button(action: {
                    onEdit()
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "pencil")
                            .font(.body)

                        Text("Edit")
                            .font(.bodySmall)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.info)
                }

                Button(action: {
                    onDelete()
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "trash")
                            .font(.body)

                        Text("Delete")
                            .font(.bodySmall)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.error)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - Edit Address Sheet

struct EditAddressSheet: View {
    let address: Address
    let onSave: (Address) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var label: String
    @State private var fullAddress: String
    @State private var city: String
    @State private var pincode: String
    @State private var isDefault: Bool

    let addressLabels = ["Home", "Office", "Other"]
    let cities = ["Delhi", "Mumbai", "Bangalore", "Pune", "Hyderabad", "Chennai", "Kolkata"]

    init(address: Address, onSave: @escaping (Address) -> Void) {
        self.address = address
        self.onSave = onSave

        _label = State(initialValue: address.label)
        _fullAddress = State(initialValue: address.fullAddress)
        _city = State(initialValue: address.city)
        _pincode = State(initialValue: "")
        _isDefault = State(initialValue: address.isDefault)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Same form as AddAddressView
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text("Address Label")
                            .font(.label)
                            .foregroundColor(.textPrimary)

                        HStack(spacing: Spacing.sm) {
                            ForEach(addressLabels, id: \.self) { addressLabel in
                                Button(action: {
                                    label = addressLabel
                                    Haptics.light()
                                }) {
                                    Text(addressLabel)
                                        .font(.bodySmall)
                                        .fontWeight(label == addressLabel ? .semibold : .regular)
                                        .foregroundColor(label == addressLabel ? .white : .textPrimary)
                                        .padding(.horizontal, Spacing.md)
                                        .padding(.vertical, Spacing.xs)
                                        .background(label == addressLabel ? Color.primary : Color.surface)
                                        .cornerRadius(Spacing.radiusPill)
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text("Complete Address *")
                            .font(.label)
                            .foregroundColor(.textPrimary)

                        TextEditor(text: $fullAddress)
                            .font(.input)
                            .frame(height: 100)
                            .padding(Spacing.md)
                            .background(Color.surface)
                            .cornerRadius(Spacing.radiusMd)
                    }

                    Toggle(isOn: $isDefault) {
                        Text("Set as default address")
                            .font(.bodyLarge)
                            .foregroundColor(.textPrimary)
                    }
                    .tint(.primary)
                }
                .padding(Spacing.screenPadding)
            }
            .background(Color.background)
            .navigationTitle("Edit Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAddress()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }

    private func saveAddress() {
        let updatedAddress = Address(
            id: address.id,
            label: label,
            fullAddress: fullAddress,
            city: city,
            isDefault: isDefault
        )

        Haptics.success()
        onSave(updatedAddress)
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
            ),
            Address(
                id: "2",
                label: "Office",
                fullAddress: "456, Cyber City, Sector 29, Gurugram - 122002",
                city: "Gurugram",
                isDefault: false
            )
        ],
        createdAt: Date(),
        updatedAt: Date()
    )

    return NavigationStack {
        SavedAddressesView()
            .environmentObject(authViewModel)
    }
}
