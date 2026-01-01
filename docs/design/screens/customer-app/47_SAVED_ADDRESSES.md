# Screen 47: Saved Addresses

## Overview

- **Screen ID**: 47
- **Screen Name**: Saved Addresses
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 46 (Edit Profile) → Tap "Manage Saved Addresses"
  - From: Screen 21 (Profile Dashboard) → "Saved Addresses"
  - From: Booking flow → "Change Address" → "Saved Addresses"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← Saved Addresses          + Add      │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🏠 Home                    ⭐   │   │ Address Card
│  │  John Smith                      │   │ (Primary)
│  │  123 Main Street, Apt 4B         │   │
│  │  New Delhi, Delhi 110001         │   │
│  │  India                           │   │
│  │  +91 98765 43210                 │   │
│  │                                  │   │
│  │  [Edit]  [Delete]  [Set Default]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  💼 Work                         │   │ Address Card
│  │  John Smith                      │   │
│  │  456 Business Park, Tower A      │   │
│  │  Gurgaon, Haryana 122001         │   │
│  │  India                           │   │
│  │  +91 98765 43210                 │   │
│  │                                  │   │
│  │  [Edit]  [Delete]  [Set Default]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  📍 Other - Parents' House       │   │
│  │  Sarah Smith                     │   │
│  │  789 Park Avenue                 │   │
│  │  Noida, Uttar Pradesh 201301     │   │
│  │  India                           │   │
│  │  +91 98765 11111                 │   │
│  │                                  │   │
│  │  [Edit]  [Delete]  [Set Default]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     + Add New Address            │   │ Add Button
│  └─────────────────────────────────┘   │
│                                         │
│  💡 You can save up to 10 addresses     │ Tip
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Address Cards
- **Label**: Home (🏠), Work (💼), Other (📍)
- **Primary Badge**: Star (⭐) for default address
- **Complete Address**: Name, street, city, state, pincode, country
- **Contact Number**: Phone for this address
- **Actions**:
  - Edit: Modify address details
  - Delete: Remove address (with confirmation)
  - Set Default: Make this the primary address

### 2. Address Types
- Home
- Work
- Other (with custom name)
- Visual icons for quick identification

### 3. Add New Address
- Prominent "+" button in header
- Large card-style button at bottom
- Opens add address form (modal/sheet)

### 4. Address Form Fields
- Full name
- Phone number
- Address line 1 (street, building)
- Address line 2 (apartment, floor)
- City
- State
- Pincode/ZIP code
- Country
- Save as (Home/Work/Other)
- Set as default toggle

### 5. Location Services
- "Use Current Location" button
- Auto-fill from GPS coordinates
- Google Maps integration
- Search location by name/pincode

### 6. Validation
- Required fields marked with *
- Pincode validation (6 digits for India)
- Phone number validation
- Serviceable area check (within delivery zones)

### 7. Address Limit
- Max 10 saved addresses
- Show count (e.g., "3/10 addresses saved")
- Disable add button when limit reached

## Component Breakdown

```swift
struct SavedAddressesView: View {
    @StateObject private var viewModel = SavedAddressesViewModel()
    @State private var showAddAddress = false

    var body: some View {
        VStack(spacing: 0) {
            // Address List
            if viewModel.addresses.isEmpty {
                EmptyAddressesView(onAdd: { showAddAddress = true })
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.addresses) { address in
                            AddressCard(
                                address: address,
                                isPrimary: address.id == viewModel.primaryAddressId,
                                onEdit: {
                                    viewModel.selectedAddress = address
                                    showAddAddress = true
                                },
                                onDelete: {
                                    viewModel.deleteAddress(address)
                                },
                                onSetDefault: {
                                    viewModel.setPrimaryAddress(address)
                                }
                            )
                        }

                        // Add New Button
                        if viewModel.addresses.count < 10 {
                            AddNewAddressButton(onTap: { showAddAddress = true })
                        }
                    }
                    .padding(16)
                }

                // Info Footer
                HStack(spacing: 8) {
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Color("SecondaryOrange"))

                    Text("You can save up to 10 addresses")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))

                    Spacer()

                    Text("\(viewModel.addresses.count)/10")
                        .font(.custom("Inter-SemiBold", size: 12))
                        .foregroundColor(Color("TextPrimary"))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color("SecondaryOrange").opacity(0.1))
            }
        }
        .navigationTitle("Saved Addresses")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.addresses.count < 10 {
                    Button(action: { showAddAddress = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color("PrimaryTeal"))
                    }
                }
            }
        }
        .sheet(isPresented: $showAddAddress) {
            AddEditAddressView(
                address: viewModel.selectedAddress,
                onSave: { newAddress in
                    if let existing = viewModel.selectedAddress {
                        viewModel.updateAddress(existing.id, with: newAddress)
                    } else {
                        viewModel.addAddress(newAddress)
                    }
                    showAddAddress = false
                    viewModel.selectedAddress = nil
                }
            )
        }
        .onAppear {
            viewModel.loadAddresses()
        }
    }
}

struct AddressCard: View {
    let address: Address
    let isPrimary: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onSetDefault: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 8) {
                Text(address.type.icon)
                    .font(.system(size: 20))

                Text(address.type.displayName)
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                if !address.customLabel.isEmpty {
                    Text("- \(address.customLabel)")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()

                if isPrimary {
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SecondaryOrange"))
                }
            }

            // Address Details
            VStack(alignment: .leading, spacing: 4) {
                Text(address.recipientName)
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color("TextPrimary"))

                Text(address.addressLine1)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                if !address.addressLine2.isEmpty {
                    Text(address.addressLine2)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }

                Text("\(address.city), \(address.state) \(address.pincode)")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                Text(address.country)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                HStack(spacing: 4) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("TextTertiary"))

                    Text(address.phone)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }
                .padding(.top, 4)
            }

            Divider()

            // Actions
            HStack(spacing: 16) {
                Button(action: onEdit) {
                    HStack(spacing: 4) {
                        Image(systemName: "pencil")
                            .font(.system(size: 14))
                        Text("Edit")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                }

                Button(action: { showDeleteConfirmation = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                        Text("Delete")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("ErrorRed"))
                }

                Spacer()

                if !isPrimary {
                    Button(action: onSetDefault) {
                        Text("Set Default")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("SecondaryOrange"))
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isPrimary ? Color("SecondaryOrange") : Color("BorderLight"), lineWidth: isPrimary ? 2 : 1)
        )
        .alert("Delete Address", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to delete this address?")
        }
    }
}

struct AddNewAddressButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color("PrimaryTeal"))

                Text("Add New Address")
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("PrimaryTeal"))

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(Color("PrimaryTeal").opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("PrimaryTeal"), lineWidth: 1, style: StrokeStyle(dash: [5]))
            )
        }
    }
}

struct EmptyAddressesView: View {
    let onAdd: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "mappin.circle")
                .font(.system(size: 70))
                .foregroundColor(Color("TextTertiary"))

            VStack(spacing: 8) {
                Text("No Saved Addresses")
                    .font(.custom("Inter-SemiBold", size: 18))
                    .foregroundColor(Color("TextPrimary"))

                Text("Add your addresses for faster booking")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }

            Button(action: onAdd) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 18))
                    Text("Add Address")
                        .font(.custom("Inter-SemiBold", size: 16))
                }
                .foregroundColor(.white)
                .frame(width: 180, height: 48)
                .background(Color("PrimaryTeal"))
                .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(48)
    }
}

struct Address: Identifiable {
    let id: String
    let type: AddressType
    let customLabel: String
    let recipientName: String
    let phone: String
    let addressLine1: String
    let addressLine2: String
    let city: String
    let state: String
    let pincode: String
    let country: String
    let latitude: Double?
    let longitude: Double?
}

enum AddressType: String, CaseIterable {
    case home = "Home"
    case work = "Work"
    case other = "Other"

    var displayName: String { rawValue }

    var icon: String {
        switch self {
        case .home: return "🏠"
        case .work: return "💼"
        case .other: return "📍"
        }
    }
}
```

## Add/Edit Address Form

```swift
struct AddEditAddressView: View {
    let address: Address?
    let onSave: (Address) -> Void
    @Environment(\.dismiss) var dismiss

    @State private var type: AddressType = .home
    @State private var customLabel = ""
    @State private var recipientName = ""
    @State private var phone = ""
    @State private var addressLine1 = ""
    @State private var addressLine2 = ""
    @State private var city = ""
    @State private var state = ""
    @State private var pincode = ""
    @State private var country = "India"
    @State private var setAsDefault = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Address Type")) {
                    Picker("Type", selection: $type) {
                        ForEach(AddressType.allCases, id: \.self) { type in
                            Text("\(type.icon) \(type.displayName)").tag(type)
                        }
                    }
                    .pickerStyle(.segmented)

                    if type == .other {
                        TextField("Label (e.g., Parents' House)", text: $customLabel)
                            .font(.custom("Inter-Regular", size: 15))
                    }
                }

                Section(header: Text("Contact Details")) {
                    TextField("Recipient Name *", text: $recipientName)
                        .textContentType(.name)

                    TextField("Phone Number *", text: $phone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Address")) {
                    TextField("Address Line 1 *", text: $addressLine1)
                        .textContentType(.streetAddressLine1)

                    TextField("Address Line 2 (Optional)", text: $addressLine2)
                        .textContentType(.streetAddressLine2)

                    TextField("City *", text: $city)
                        .textContentType(.addressCity)

                    TextField("State *", text: $state)
                        .textContentType(.addressState)

                    TextField("Pincode *", text: $pincode)
                        .textContentType(.postalCode)
                        .keyboardType(.numberPad)

                    TextField("Country *", text: $country)
                        .textContentType(.countryName)
                }

                Section {
                    Button(action: { /* Use current location */ }) {
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color("PrimaryTeal"))
                            Text("Use Current Location")
                                .foregroundColor(Color("PrimaryTeal"))
                        }
                    }
                }

                Section {
                    Toggle("Set as Default Address", isOn: $setAsDefault)
                        .tint(Color("PrimaryTeal"))
                }
            }
            .navigationTitle(address == nil ? "Add Address" : "Edit Address")
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
                    .disabled(!isFormValid)
                }
            }
        }
    }

    var isFormValid: Bool {
        !recipientName.isEmpty &&
        !phone.isEmpty &&
        !addressLine1.isEmpty &&
        !city.isEmpty &&
        !state.isEmpty &&
        !pincode.isEmpty &&
        pincode.count == 6
    }

    func saveAddress() {
        // Create address object and call onSave
        dismiss()
    }
}
```

## Interactions

### Address Card
1. **Tap Edit**: Opens edit form with pre-filled data
2. **Tap Delete**: Shows confirmation dialog
3. **Tap Set Default**: Makes address primary, updates star badge

### Add New Address
1. **Tap + (Header)**: Opens add address form
2. **Tap Add New Card**: Opens add address form
3. **Fill Form**: Validates fields in real-time
4. **Tap Save**: Validates, saves, closes form

### Location Services
1. **Tap Use Current Location**: Requests location permission
2. **Permission Granted**: Auto-fills city, state, pincode
3. **Permission Denied**: Shows error, manual entry

## States

### Empty State
- No addresses saved
- Large icon with message
- "Add Address" CTA button

### Loading State
```swift
ProgressView()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
```

### Error State
```swift
Text("Failed to load addresses")
    .foregroundColor(Color("ErrorRed"))
Button("Retry") { viewModel.loadAddresses() }
```

## API Integration

### Get Saved Addresses
```
GET /customers/{customerId}/addresses

Response:
{
  "success": true,
  "data": {
    "addresses": [
      {
        "id": "addr_001",
        "type": "home",
        "customLabel": "",
        "recipientName": "John Smith",
        "phone": "+919876543210",
        "addressLine1": "123 Main Street, Apt 4B",
        "addressLine2": "",
        "city": "New Delhi",
        "state": "Delhi",
        "pincode": "110001",
        "country": "India",
        "latitude": 28.6139,
        "longitude": 77.2090,
        "isPrimary": true
      }
    ]
  }
}
```

### Add Address
```
POST /customers/{customerId}/addresses

Request:
{
  "type": "home",
  "customLabel": "",
  "recipientName": "John Smith",
  "phone": "+919876543210",
  "addressLine1": "123 Main Street, Apt 4B",
  "addressLine2": "",
  "city": "New Delhi",
  "state": "Delhi",
  "pincode": "110001",
  "country": "India",
  "setAsPrimary": true
}

Response:
{
  "success": true,
  "data": {
    "addressId": "addr_002"
  },
  "message": "Address added successfully"
}
```

### Update Address
```
PUT /customers/{customerId}/addresses/{addressId}

Request: (same as add)

Response:
{
  "success": true,
  "message": "Address updated successfully"
}
```

### Delete Address
```
DELETE /customers/{customerId}/addresses/{addressId}

Response:
{
  "success": true,
  "message": "Address deleted successfully"
}
```

### Set Primary Address
```
PUT /customers/{customerId}/addresses/{addressId}/set-primary

Response:
{
  "success": true,
  "message": "Primary address updated"
}
```

## Navigation

### Entry Points
- **From Screen 46** (Edit Profile): "Manage Saved Addresses"
- **From Screen 21** (Profile): "Saved Addresses"
- **From Booking Flow**: "Change Address"

### Exit Points
- **Back Button**: Return to previous screen
- **Add/Edit Form**: Modal sheet, dismiss on save/cancel

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Home address for John Smith")
.accessibilityHint("Double tap to edit or delete")
```

### Touch Targets
- Edit/Delete buttons: 44x44pt
- Address card: Full width, tappable
- Add button: 48pt height

## Analytics Events

### Address Added
```swift
Analytics.logEvent("address_added", parameters: [
    "type": addressType,
    "is_primary": isPrimary
])
```

### Address Deleted
```swift
Analytics.logEvent("address_deleted", parameters: [
    "address_id": addressId
])
```

## Testing Checklist

- [ ] Addresses load correctly
- [ ] Empty state shows when no addresses
- [ ] Add address form opens
- [ ] Form validation works
- [ ] Save address works
- [ ] Edit address pre-fills data
- [ ] Update address works
- [ ] Delete confirmation works
- [ ] Delete address works
- [ ] Set default works
- [ ] Star badge updates
- [ ] Max 10 addresses enforced
- [ ] Use current location works
- [ ] Location permission handling
- [ ] Pincode validation works
- [ ] Phone validation works

## Design Notes

### Validation Rules
- Pincode: 6 digits (India)
- Phone: Valid format
- Required fields: Name, phone, line1, city, state, pincode

### Edge Cases
- Cannot delete primary address if it's the only one
- Auto-set first address as primary
- Handle location services disabled

### Future Enhancements
- Map view for address visualization
- Address autocomplete (Google Places API)
- Verify address with postal service
- Recent addresses (not saved)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
