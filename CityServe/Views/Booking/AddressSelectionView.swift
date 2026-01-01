//
//  AddressSelectionView.swift
//  CityServe
//
//  Address Selection for Booking
//

import SwiftUI

struct AddressSelectionView: View {

    @ObservedObject var viewModel: BookingViewModel
    @State private var showAddAddress = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                // Header
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Where do you need the service?")
                        .font(.h3)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    Text("Select or add a service address")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }

                // Addresses List
                if viewModel.addresses.isEmpty {
                    emptyState
                } else {
                    VStack(spacing: Spacing.md) {
                        ForEach(viewModel.addresses) { address in
                            AddressCard(
                                address: address,
                                isSelected: viewModel.selectedAddress?.id == address.id,
                                onSelect: {
                                    viewModel.selectAddress(address)
                                }
                            )
                        }
                    }
                }

                // Add New Address Button
                Button(action: {
                    showAddAddress = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.h4)
                            .foregroundColor(.primary)

                        Text("Add New Address")
                            .font(.bodyLarge)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.body)
                            .foregroundColor(.textTertiary)
                    }
                    .padding(Spacing.md)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusMd)
                    .overlay(
                        RoundedRectangle(cornerRadius: Spacing.radiusMd)
                            .stroke(Color.primary.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, dash: [5, 5]))
                    )
                }

                Spacer(minLength: Spacing.xl)
            }
            .padding(Spacing.screenPadding)
        }
        .sheet(isPresented: $showAddAddress) {
            AddAddressView(onSave: { newAddress in
                viewModel.addNewAddress(newAddress)
                showAddAddress = false
            })
        }
    }

    // MARK: - Subviews

    private var emptyState: some View {
        VStack(spacing: Spacing.md) {
            Image(systemName: "mappin.slash")
                .font(.h1)
                .foregroundColor(.textTertiary)

            Text("No saved addresses")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.medium)

            Text("Add an address to continue with your booking")
                .font(.body)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.xl * 2)
    }
}

// MARK: - Address Card

struct AddressCard: View {
    let address: Address
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: {
            Haptics.light()
            onSelect()
        }) {
            HStack(alignment: .top, spacing: Spacing.md) {
                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.primary : Color.divider, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 14, height: 14)
                    }
                }
                .padding(.top, 2)

                // Address Details
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack {
                        Text(address.label)
                            .font(.bodyLarge)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)

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

                        Spacer()
                    }

                    Text(address.fullAddress)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(2)
                        .multilineTextAlignment(.leading)

                    Text(address.city)
                        .font(.bodySmall)
                        .foregroundColor(.textTertiary)
                }

                Spacer()
            }
            .padding(Spacing.md)
            .background(isSelected ? Color.primary.opacity(0.05) : Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(isSelected ? Color.primary : Color.divider, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    let viewModel = BookingViewModel(service: Service.mockServices[0])
    viewModel.addresses = [
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
    ]
    viewModel.selectedAddress = viewModel.addresses[0]

    return NavigationStack {
        AddressSelectionView(viewModel: viewModel)
    }
}
