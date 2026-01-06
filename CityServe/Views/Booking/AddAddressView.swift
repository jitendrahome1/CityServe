//
//  AddAddressView.swift
//  CityServe
//
//  Add New Address Form
//

import SwiftUI

struct AddAddressView: View {

    let onSave: (Address) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var label = ""
    @State private var fullAddress = ""
    @State private var city = ""
    @State private var pincode = ""
    @State private var isDefault = false

    @State private var errorMessage: String?

    let addressLabels = ["Home", "Office", "Other"]
    let cities = ["Delhi", "Mumbai", "Bangalore", "Pune", "Hyderabad", "Chennai", "Kolkata"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Address Label Selection
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
                                            .overlay(
                                                RoundedRectangle(cornerRadius: Spacing.radiusPill)
                                                    .stroke(label == addressLabel ? Color.clear : Color.divider, lineWidth: 1)
                                            )
                                    }
                                }
                            }
                        }

                        // Full Address
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Complete Address *")
                                .font(.label)
                                .foregroundColor(.textPrimary)

                            TextEditor(text: $fullAddress)
                                .font(.input)
                                .frame(height: 100)
                                .padding(Spacing.md)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusLg)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                                        .stroke(Color.divider, lineWidth: 1)
                                )
                        }

                        // City Selection
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("City *")
                                .font(.label)
                                .foregroundColor(.textPrimary)

                            Menu {
                                ForEach(cities, id: \.self) { cityOption in
                                    Button(cityOption) {
                                        city = cityOption
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(city.isEmpty ? "Select city" : city)
                                        .font(.input)
                                        .foregroundColor(city.isEmpty ? .textTertiary : .textPrimary)

                                    Spacer()

                                    Image(systemName: "chevron.down")
                                        .font(.body)
                                        .foregroundColor(.textSecondary)
                                }
                                .padding(Spacing.md)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusLg)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                                        .stroke(Color.divider, lineWidth: 1)
                                )
                            }
                        }

                        // Pincode
                        StandardTextField(
                            label: "Pincode *",
                            placeholder: "110001",
                            text: $pincode,
                            leadingIcon: "location.fill"
                        )
                        .onChange(of: pincode) { _, newValue in
                            // Only allow numbers
                            let filtered = newValue.filter { $0.isNumber }
                            pincode = String(filtered.prefix(6))
                        }

                        // Set as Default
                        Toggle(isOn: $isDefault) {
                            VStack(alignment: .leading, spacing: Spacing.xxs) {
                                Text("Set as default address")
                                    .font(.bodyLarge)
                                    .foregroundColor(.textPrimary)

                                Text("Use this address for all future bookings")
                                    .font(.bodySmall)
                                    .foregroundColor(.textSecondary)
                            }
                        }
                        .tint(.primary)
                        .padding(Spacing.md)
                        .background(Color.surface)
                        .cornerRadius(Spacing.radiusLg)

                        // Error Message
                        if let error = errorMessage {
                            ErrorBanner(message: error)
                        }

                        Spacer(minLength: Spacing.xl)
                    }
                    .padding(Spacing.screenPadding)
                }
            }
            .navigationTitle("Add New Address")
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
                    .disabled(!isFormValid)
                }
            }
        }
    }

    // MARK: - Computed Properties

    private var isFormValid: Bool {
        !label.isEmpty &&
        !fullAddress.isEmpty &&
        !city.isEmpty &&
        pincode.count == 6
    }

    // MARK: - Actions

    private func saveAddress() {
        guard isFormValid else {
            errorMessage = "Please fill all required fields"
            return
        }

        let newAddress = Address(
            id: UUID().uuidString,
            label: label,
            fullAddress: fullAddress,
            city: city,
            isDefault: isDefault
        )

        Haptics.success()
        onSave(newAddress)
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    AddAddressView(onSave: { address in
        print("Saved address: \(address)")
    })
}
