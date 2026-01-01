# 11 - Address Selection

**Screen ID:** 11
**Screen Name:** Address Selection
**User Flow:** Service Detail → Book Now → Address Selection → Date/Time Selection
**Entry Point:** Tap "Book Now" from Service Detail screen
**Next Screen:** Date & Time Selection (13) or Add New Address (12)

---

## Overview

The address selection screen is the first step in the booking flow. Users select where they want the service performed from their saved addresses or add a new location.

**Purpose:**
- Display user's saved addresses
- Enable selection of service location
- Allow adding new addresses
- Show address details (flat, landmark)
- Detect current location option
- Validate address coverage (service area)

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ✕  Select Address              Next → │ ← Top Bar
├────────────────────────────────────────┤
│                                        │
│  Where should we provide the service?  │ ← Title
│                                        │
│  📍 Use Current Location               │ ← Current Location
│  ┌────────────────────────────────┐   │   (Tappable)
│  │ Detecting location...          │   │
│  └────────────────────────────────┘   │
│                                        │
│  Saved Addresses                       │ ← Section Header
│                                        │
│  ┌────────────────────────────────┐   │
│  │ ● Home                    ✓    │   │ ← Address Card
│  │ 🏠                             │   │   (Selected)
│  │ 123 MG Road, Flat 4B           │   │
│  │ Near City Mall                 │   │
│  │ Bangalore, Karnataka - 560001  │   │
│  │ [Edit]                         │   │
│  └────────────────────────────────┘   │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ ○ Work                         │   │ ← Address Card
│  │ 🏢                             │   │   (Unselected)
│  │ 456 Tech Park, Tower B         │   │
│  │ Whitefield                     │   │
│  │ Bangalore, Karnataka - 560066  │   │
│  │ [Edit]                         │   │
│  └────────────────────────────────┘   │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ + Add New Address              │   │ ← Add Address
│  └────────────────────────────────┘   │   Button
│                                        │
│                                        │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ Continue                       │   │ ← Bottom CTA
│  └────────────────────────────────┘   │
│                                        │
└────────────────────────────────────────┘
```

---

## Layout Specifications

### Screen Dimensions
```
Device: iPhone 14 (390x844pt)
Safe Area Top: 47pt
Safe Area Bottom: 34pt (+ 80pt for bottom CTA = 114pt)
Content Area: 390x (730pt)
Scrollable: Yes (vertical)
```

### Background
```
Color: #F5F5F5 (light gray) / #1E1E1E (dark)
```

### Top Navigation Bar
```
Position: Fixed at top
Height: 56pt
Background: White (#FFFFFF) / #2A2A2A
Border Bottom: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 2px 4px rgba(0,0,0,0.04)

Left Section:
├─ Close Button:
│   ├─ Icon: xmark (X)
│   ├─ Size: 20x20pt
│   ├─ Color: #333333 / #E0E0E0
│   ├─ Tap Target: 44x44pt
│   ├─ Position: 12pt from left
│   └─ Action: Show exit confirmation alert

Title:
├─ Text: "Select Address"
├─ Font: Inter SemiBold, 18pt
├─ Color: #1E1E1E / #E0E0E0
└─ Position: Center

Right Section (Optional):
└─ Next Button (Skip):
    ├─ Text: "Next"
    ├─ Icon: arrow.right, 16x16pt
    ├─ Font: SF Pro Medium, 16pt
    ├─ Color: #0D7377 (if address selected), #CCCCCC (disabled)
    ├─ Tap Target: 44pt height
    ├─ Position: 16pt from right
    └─ Action: Continue to Date/Time (same as bottom CTA)
```

### Title Section
```
Position: 16pt below top bar
Padding: 20pt horizontal
Background: Transparent

Title:
├─ Text: "Where should we provide the service?"
├─ Font: Inter SemiBold, 20pt
├─ Color: #1E1E1E / #E0E0E0
├─ Line Height: 1.3
├─ Max Lines: 2
└─ Alignment: Left
```

### Current Location Section
```
Position: 16pt below title
Padding: 20pt horizontal
Height: 64pt
Background: White (#FFFFFF) / #2A2A2A
Border Radius: 12pt
Border: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 2px 6px rgba(0,0,0,0.06)
Tap: Detect current location

Layout (HStack):

Icon:
├─ Image: location.fill (SF Symbol)
├─ Size: 24x24pt
├─ Color: #0D7377 (brand primary)
├─ Position: 16pt from left
└─ Background: Circle, 40x40pt, rgba(13,115,119,0.1)

Text (VStack):
├─ Primary: "Use Current Location"
│   ├─ Font: SF Pro SemiBold, 16pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Position: 12pt from icon
│
└─ Secondary (if detecting):
    ├─ Text: "Detecting location..." or "Bangalore, Karnataka"
    ├─ Font: SF Pro Regular, 13pt
    ├─ Color: #666666 / #A0A0A0
    └─ Margin Top: 4pt

States:
├─ Idle: "Tap to detect"
├─ Loading: "Detecting location..." + spinner
├─ Success: Shows detected city/area
└─ Error: "Unable to detect. Please enter manually."
```

### Section Header (Saved Addresses)
```
Position: 24pt below current location
Padding: 20pt horizontal

Text:
├─ Text: "Saved Addresses"
├─ Font: Inter SemiBold, 16pt
├─ Color: #1E1E1E / #E0E0E0
└─ Margin Bottom: 12pt
```

### Address Card
```
Position: Below section header
Padding: 0pt horizontal (cards have margin)
Margin: 12pt horizontal, 12pt bottom
Height: Dynamic (min 140pt)
Background: White (#FFFFFF) / #2A2A2A
Border Radius: 16pt
Border:
├─ Selected: 2pt solid #0D7377 (brand primary)
└─ Unselected: 1pt solid #E0E0E0 / #3A3A3A
Shadow:
├─ Selected: 0 4px 12px rgba(13,115,119,0.15)
└─ Unselected: 0 2px 6px rgba(0,0,0,0.06)
Padding: 16pt
Tap: Select this address

Layout (VStack):

Header (HStack):
├─ Selection Indicator:
│   ├─ Icon: circle.fill (selected), circle (unselected)
│   ├─ Size: 22x22pt
│   ├─ Color: #0D7377 (selected), #CCCCCC (unselected)
│   └─ Position: Top-left
│
├─ Address Label:
│   ├─ Text: "Home" or "Work" or "Other"
│   ├─ Font: Inter SemiBold, 16pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Position: 12pt from selection indicator
│   └─ Flex: 1
│
└─ Checkmark (if selected):
    ├─ Icon: checkmark.circle.fill
    ├─ Size: 24x24pt
    ├─ Color: #28C76F (success green)
    └─ Position: Top-right

Address Type Icon:
├─ Icon: house.fill (Home), building.2.fill (Work), mappin.circle.fill (Other)
├─ Size: 20x20pt
├─ Color: #666666 / #A0A0A0
├─ Position: Below header, 12pt top margin
└─ Alignment: Left

Address Details (VStack):
├─ Margin Top: 8pt
├─ Padding Left: 32pt (aligned with icon)
│
├─ Line 1 (Street):
│   ├─ Text: "123 MG Road, Flat 4B"
│   ├─ Font: SF Pro Medium, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Max Lines: 2
│
├─ Line 2 (Landmark):
│   ├─ Text: "Near City Mall"
│   ├─ Font: SF Pro Regular, 14pt
│   ├─ Color: #666666 / #A0A0A0
│   ├─ Margin Top: 4pt
│   └─ Max Lines: 1
│
└─ Line 3 (City, Pincode):
    ├─ Text: "Bangalore, Karnataka - 560001"
    ├─ Font: SF Pro Regular, 14pt
    ├─ Color: #666666 / #A0A0A0
    ├─ Margin Top: 4pt
    └─ Max Lines: 1

Edit Button:
├─ Text: "Edit"
├─ Icon: pencil (optional)
├─ Font: SF Pro Medium, 14pt
├─ Color: #0D7377
├─ Background: rgba(13,115,119,0.1)
├─ Padding: 6pt vertical, 12pt horizontal
├─ Border Radius: 16pt (pill)
├─ Position: Bottom-left, 16pt from bottom
├─ Tap Target: 44pt width min
└─ Action: Navigate to Edit Address screen
```

### Add New Address Button
```
Position: Below last address card
Padding: 20pt horizontal
Margin Top: 8pt
Height: 56pt

Button:
├─ Width: Full (350pt)
├─ Height: 56pt
├─ Border Radius: 12pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Border: 1.5pt dashed #0D7377
├─ Shadow: None
└─ Tap: Navigate to Add New Address (12)

Content (HStack):
├─ Icon: plus.circle.fill
│   ├─ Size: 24x24pt
│   ├─ Color: #0D7377
│   └─ Position: Center vertical, 20pt from left
│
└─ Text: "Add New Address"
    ├─ Font: SF Pro SemiBold, 16pt
    ├─ Color: #0D7377
    └─ Position: 12pt from icon
```

### Bottom Spacer
```
Height: 120pt (space for fixed CTA)
```

### Fixed Bottom CTA
```
Position: Fixed at bottom, above safe area
Height: 80pt + safe area (34pt) = 114pt total
Background: White (#FFFFFF) / #2A2A2A
Border Top: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 -4px 16px rgba(0,0,0,0.12)
Padding: 16pt horizontal, 16pt top

Button:
├─ Width: Full (358pt)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background:
│   ├─ Enabled: #0D7377 (brand primary)
│   └─ Disabled: #E0E0E0
├─ Shadow:
│   ├─ Enabled: 0 4px 12px rgba(13,115,119,0.3)
│   └─ Disabled: None
└─ Tap: Navigate to Date/Time Selection (13)

Text:
├─ Text: "Continue"
├─ Font: Inter SemiBold, 17pt
├─ Color: White (#FFFFFF)
└─ Letter Spacing: 0.3pt

States:
├─ Disabled: No address selected (gray)
├─ Enabled: Address selected (teal)
└─ Loading: Validating address (spinner)

Animation:
├─ Press: Scale 0.98
└─ Haptic: Medium impact
```

---

## Component Breakdown

### 1. Current Location Detector
```
Component: CurrentLocationButton
Features:
├─ Tap to detect location via GPS
├─ Show loading state while detecting
├─ Display detected city/area
├─ Handle permission denied gracefully
└─ Fallback to manual address entry

Permissions:
├─ Request location access (when user taps)
├─ Handle "Allow Once" vs "Always"
└─ Show permission denied state
```

### 2. Address Card (Selectable)
```
Component: AddressCard (reusable)
Props:
├─ address: Address model
├─ isSelected: Bool
├─ onTap: Select this address
├─ onEdit: Navigate to edit screen
└─ Layout: Full address details with selection indicator

Used in:
├─ Address Selection (this screen)
├─ Checkout flows
└─ Profile (Manage Addresses)
```

### 3. Add Address Button
```
Component: DashedBorderButton
Props:
├─ title: "Add New Address"
├─ icon: plus.circle.fill
├─ action: Navigate to Add Address
└─ Style: Dashed border, brand color
```

---

## Animations & Transitions

### Screen Entry Animation
```
Duration: 400ms
Easing: Ease Out

Sequence:
0ms   - Screen slides up from bottom (modal presentation)
100ms - Title fades in
200ms - Current location button fades in + slides up (10pt)
300ms - Address cards fade in sequentially (100ms each)
400ms - Add address button fades in
```

### Address Selection Animation
```
Trigger: User taps an address card
Duration: 250ms
Easing: Ease Out

Changes:
├─ Previously selected: Border 2pt → 1pt, color teal → gray
├─ Newly selected: Border 1pt → 2pt, color gray → teal
├─ Checkmark appears with scale animation (0.8 → 1.0)
├─ Shadow increases on newly selected
└─ Haptic: Light impact

Bottom Button:
├─ Changes from disabled (gray) to enabled (teal)
├─ Shadow appears
└─ Slight scale pulse (1.0 → 1.02 → 1.0)
```

### Current Location Detection
```
Trigger: Tap "Use Current Location"
Duration: 2-5 seconds

States:
├─ Initial: "Tap to detect"
├─ Loading: Spinner + "Detecting location..."
├─ Success: "Bangalore, Karnataka" (detected)
└─ Error: "Unable to detect" + error icon

Animation:
├─ Loading: Spinner rotates continuously
├─ Success: Text fades in, icon changes to checkmark
├─ Error: Shake animation, red icon
└─ Haptic: Success or error feedback
```

### Add Address Button Tap
```
Duration: 150ms

Press:
├─ Background: White → rgba(13,115,119,0.05)
├─ Scale: 1.0 → 0.98
└─ Haptic: Light impact

Release:
├─ Scale: 0.98 → 1.0
├─ Navigate to Add New Address screen
└─ Transition: Slide in from right
```

### Continue Button Press
```
Duration: 150ms

Press:
├─ Scale: 1.0 → 0.98
├─ Shadow: Slightly reduces
└─ Haptic: Medium impact

Release:
├─ Scale: 0.98 → 1.0
├─ Validate address (check service coverage)
├─ If valid: Navigate to Date/Time Selection
└─ If invalid: Show error alert
```

---

## States

### Default State (Has Saved Addresses)
```
Visual:
├─ Current location: "Tap to detect"
├─ Saved addresses: List of 2-5 addresses
├─ First address: Auto-selected (or last used)
├─ Continue button: Enabled (teal)
└─ Scroll: Enabled if > 3 addresses
```

### Empty State (No Saved Addresses)
```
Trigger: New user, no addresses saved
Visual:
├─ Current location: Prominent (suggest using it)
├─ Empty state component:
│   ├─ Icon: Illustration (map marker)
│   ├─ Message: "No saved addresses yet"
│   ├─ Subtitle: "Add an address to continue"
│   └─ CTA: "Add Address" (same as button below)
├─ Add address button: Highlighted
└─ Continue button: Disabled (gray)

Alternative:
└─ Auto-open "Add New Address" screen
```

### Loading State (Validating Address)
```
Trigger: User taps Continue
Visual:
├─ Continue button: Shows spinner
├─ Address cards: Disabled (non-interactive)
├─ Current location: Disabled
└─ Overlay: Semi-transparent (optional)

Actions:
├─ Validate address with backend (service area check)
├─ Duration: 1-2 seconds
└─ Success: Navigate to Date/Time
    Error: Show alert
```

### Location Permission Denied
```
Trigger: User denies location access
Visual:
├─ Current location button: Shows error state
├─ Icon: location.slash (crossed out)
├─ Text: "Location access denied"
├─ Action button: "Enable in Settings"
└─ Fallback: User can still select saved address
```

### Out of Service Area
```
Trigger: Selected address not in coverage
Visual:
├─ Alert appears:
│   ├─ Title: "Service Unavailable"
│   ├─ Message: "We don't serve this area yet. Please choose another address."
│   ├─ Action: "OK" (dismiss)
│   └─ Alternative: "Notify Me" (when available)
├─ Address remains selected but flagged
└─ Continue button: Disabled
```

### Address Selected
```
Visual:
├─ Selected address: Highlighted (teal border, checkmark)
├─ Other addresses: Normal state (gray border)
├─ Continue button: Enabled (teal, with shadow)
└─ Scroll: Auto-scroll to show Continue button
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E
Top Bar: #2A2A2A
Current Location Card: #2A2A2A
Address Card: #2A2A2A
Selected Border: #0D7377 (same)
Unselected Border: #3A3A3A
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Icon Color: #0D7377 (same for brand)
Add Button Background: #2A2A2A
Add Button Border: #0D7377 (same)
Bottom CTA Background: #2A2A2A
Button Disabled: #3A3A3A
```

---

## Accessibility

### VoiceOver

**Labels:**
```
Close: "Close, button"
Title: "Where should we provide the service, heading"
Current Location: "Use current location, button, detecting"
Address Card: "Home, 123 MG Road Flat 4B, Bangalore, selected, button"
Edit: "Edit address, button"
Add Address: "Add new address, button"
Continue: "Continue, button" / "Continue, disabled, button"
```

**Announcements:**
```
On address select: "Home address selected"
On location detect: "Location detected, Bangalore Karnataka"
On location error: "Unable to detect location"
On validation: "Checking service availability"
On error: "Service unavailable in this area"
```

### Dynamic Type

**Scaling:** -2 to +3
```
Title: 20pt → 17pt (min) to 24pt (max)
Address label: 16pt → 14pt (min) to 19pt (max)
Address line: 15pt → 13pt (min) to 18pt (max)
Button text: 17pt → 15pt (min) to 20pt (max)

Layout:
├─ At +2: Card height increases (140pt → 160pt)
├─ At +3: Line spacing increases
└─ Continue button: Height 52pt → 60pt
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct AddressSelectionView: View {
    @StateObject private var viewModel = AddressSelectionViewModel()
    @State private var selectedAddressId: String?
    @State private var isDetectingLocation: Bool = false
    @State private var showAddAddress: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray100.ignoresSafeArea()

            // Main Content
            ScrollView {
                VStack(spacing: 0) {
                    // Title
                    Text("Where should we provide the service?")
                        .font(.custom("Inter-SemiBold", size: 20))
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, 20)
                        .padding(.top, 72)
                        .padding(.bottom, 16)

                    // Current Location
                    CurrentLocationButton(isDetecting: $isDetectingLocation) {
                        detectCurrentLocation()
                    }
                    .padding(.horizontal, 20)

                    // Saved Addresses
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Saved Addresses")
                            .font(.custom("Inter-SemiBold", size: 16))
                            .foregroundColor(.textPrimary)
                            .padding(.horizontal, 20)
                            .padding(.top, 24)

                        ForEach(viewModel.addresses) { address in
                            AddressCard(
                                address: address,
                                isSelected: selectedAddressId == address.id,
                                onTap: {
                                    withAnimation {
                                        selectedAddressId = address.id
                                    }
                                },
                                onEdit: {
                                    navigateToEditAddress(address)
                                }
                            )
                            .padding(.horizontal, 12)
                        }
                    }

                    // Add New Address
                    Button(action: { showAddAddress = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.brandPrimary)

                            Text("Add New Address")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.brandPrimary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(
                                    style: StrokeStyle(lineWidth: 1.5, dash: [5])
                                )
                                .foregroundColor(.brandPrimary)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    Spacer(minLength: 120)
                }
            }

            // Top Navigation
            CustomNavigationBar(
                title: "Select Address",
                leftItems: [.close],
                rightItems: selectedAddressId != nil ? [.next] : [],
                onClose: { dismiss() },
                onNext: continueToDateTime
            )

            // Bottom CTA
            VStack {
                Spacer()
                FixedBottomCTA(
                    title: "Continue",
                    action: continueToDateTime,
                    isDisabled: selectedAddressId == nil
                )
            }
        }
        .sheet(isPresented: $showAddAddress) {
            AddNewAddressView()
        }
        .onAppear {
            viewModel.loadAddresses()
            if let lastUsed = viewModel.lastUsedAddressId {
                selectedAddressId = lastUsed
            }
        }
    }

    private func detectCurrentLocation() {
        isDetectingLocation = true

        Task {
            do {
                let location = try await viewModel.detectCurrentLocation()
                // Handle detected location
                isDetectingLocation = false
            } catch {
                isDetectingLocation = false
                showLocationError()
            }
        }
    }

    private func continueToDateTime() {
        guard let addressId = selectedAddressId,
              let address = viewModel.addresses.first(where: { $0.id == addressId }) else {
            return
        }

        Task {
            do {
                // Validate service coverage
                let isAvailable = try await viewModel.validateServiceArea(address)
                if isAvailable {
                    // Navigate to Date/Time Selection
                } else {
                    showServiceUnavailableAlert()
                }
            } catch {
                showError(error)
            }
        }
    }

    private func navigateToEditAddress(_ address: Address) {
        // Navigate to edit screen
    }

    private func showLocationError() {
        // Show alert
    }

    private func showServiceUnavailableAlert() {
        // Show alert
    }

    private func showError(_ error: Error) {
        // Show error alert
    }
}
```

---

## Assets Required

### SF Symbols
```
- xmark
- arrow.right
- location.fill
- location.slash
- circle.fill / circle
- checkmark.circle.fill
- house.fill
- building.2.fill
- mappin.circle.fill
- pencil
- plus.circle.fill
```

---

## Navigation Flow

### Entry
```
From Service Detail → Tap "Book Now"
Transition: Slide up (modal presentation)
Data: { serviceId, serviceName, price }
```

### Exit
```
1. Continue → Date/Time Selection (13)
   └─ Transition: Slide in from right
   └─ Data: { serviceId, addressId, address }

2. Add New Address → Add Address Screen (12)
   └─ Transition: Slide in from right (within modal)
   └─ Return: Refresh address list

3. Close → Dismiss modal
   └─ Show confirmation: "Cancel booking?"
   └─ If confirmed: Return to Service Detail
```

---

## Testing Checklist

- [ ] Shows saved addresses correctly
- [ ] Address selection works (radio behavior)
- [ ] Selected address highlights properly
- [ ] Edit button navigates correctly
- [ ] Add address button works
- [ ] Current location detection works
- [ ] Location permission denied handled
- [ ] Continue button enables/disables correctly
- [ ] Service area validation works
- [ ] Out of area alert shows
- [ ] Empty state shows if no addresses
- [ ] Close confirmation works
- [ ] Dark mode renders correctly
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Works on all devices

---

## Analytics

```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "address_selection",
    "service_id": serviceId
])

Analytics.logEvent("address_selected", parameters: [
    "address_id": addressId,
    "address_type": address.type // "home", "work", "other"
])

Analytics.logEvent("current_location_tapped", parameters: [:])

Analytics.logEvent("add_address_tapped", parameters: [
    "source": "booking_flow"
])

Analytics.logEvent("continue_tapped", parameters: [
    "has_address": selectedAddressId != nil
])
```

---

**This address selection screen starts the booking journey. It must be quick, show clear options, and handle edge cases gracefully.**
