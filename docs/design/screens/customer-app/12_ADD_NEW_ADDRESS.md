# 12 - Add New Address

**Screen ID:** 12
**Screen Name:** Add New Address
**User Flow:** Address Selection → Add New Address → Save → Return to Address Selection
**Entry Point:** Tap "Add New Address" from Address Selection screen
**Next Screen:** Returns to Address Selection (11) with new address added

---

## Overview

The add new address screen is a form where users enter complete address details for service delivery. It includes address type selection, flat/house number, street, landmark, city, and pincode fields with validation.

**Purpose:**
- Collect complete delivery address
- Allow address type selection (Home, Work, Other)
- Validate pincode and city
- Use map picker for location (optional)
- Save address to user profile
- Enable quick re-use in future bookings

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ✕  Add New Address                    │ ← Top Bar
├────────────────────────────────────────┤
│                                        │
│  📍 Use Map to Pick Location   →      │ ← Map Picker (Optional)
│                                        │
│  Address Type                          │ ← Section
│  ┌─────┬─────┬─────────┐              │
│  │ 🏠  │ 🏢  │ 📍      │              │ ← Type Chips
│  │Home │Work │ Other   │              │
│  └─────┴─────┴─────────┘              │
│                                        │
│  Flat / House No. *                    │ ← Input Label
│  ┌────────────────────────────────┐   │
│  │ 4B                             │   │ ← Text Input
│  └────────────────────────────────┘   │
│                                        │
│  Street / Society Name *               │
│  ┌────────────────────────────────┐   │
│  │ MG Road                        │   │
│  └────────────────────────────────┘   │
│                                        │
│  Landmark (Optional)                   │
│  ┌────────────────────────────────┐   │
│  │ Near City Mall                 │   │
│  └────────────────────────────────┘   │
│                                        │
│  City / District *                     │
│  ┌────────────────────────────────┐   │
│  │ Bangalore                      │   │
│  └────────────────────────────────┘   │
│                                        │
│  State *                               │
│  ┌────────────────────────────────┐   │
│  │ Karnataka            ▼         │   │ ← Dropdown
│  └────────────────────────────────┘   │
│                                        │
│  Pincode *                             │
│  ┌────────────────────────────────┐   │
│  │ 560001                         │   │
│  └────────────────────────────────┘   │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ Save Address                   │   │ ← Bottom CTA
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
Safe Area Bottom: 34pt (+ 80pt for CTA = 114pt)
Content Area: 390x730pt
Scrollable: Yes (vertical, keyboard-aware)
```

### Background
```
Color: White (#FFFFFF) / #1E1E1E (dark)
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
│   ├─ Icon: xmark or chevron.left
│   ├─ Size: 20x20pt
│   ├─ Tap Target: 44x44pt
│   └─ Action: Dismiss (with unsaved changes warning)

Title:
├─ Text: "Add New Address"
├─ Font: Inter SemiBold, 18pt
├─ Color: #1E1E1E / #E0E0E0
└─ Position: Center
```

### Map Picker (Optional)
```
Position: 16pt below top bar
Padding: 20pt horizontal
Height: 56pt
Background: #F8F8F8 / #2A2A2A
Border Radius: 12pt
Border: 1pt solid #E0E0E0 / #3A3A3A
Tap: Navigate to Map Picker screen

Content (HStack):
├─ Icon: map.fill
│   ├─ Size: 22x22pt
│   ├─ Color: #0D7377
│   └─ Position: 16pt from left
│
├─ Text: "Use Map to Pick Location"
│   ├─ Font: SF Pro Medium, 15pt
│   ├─ Color: #0D7377
│   └─ Position: 12pt from icon
│
└─ Arrow: chevron.right
    ├─ Size: 16x16pt
    ├─ Color: #0D7377
    └─ Position: Right edge, 16pt padding
```

### Address Type Section
```
Position: 20pt below map picker (or 20pt below top bar if no map)
Padding: 20pt horizontal

Label:
├─ Text: "Address Type"
├─ Font: SF Pro Medium, 14pt
├─ Color: #666666 / #A0A0A0
└─ Margin Bottom: 12pt

Type Chips (HStack):
├─ Layout: 3 chips (Home, Work, Other)
├─ Gap: 12pt between chips
├─ Distribution: Equal width (flexible)
└─ Tap: Select address type (single selection)

Chip:
├─ Width: (390 - 40 - 24) / 3 = 108pt
├─ Height: 48pt
├─ Border Radius: 12pt
├─ Selected:
│   ├─ Background: #0D7377 (brand primary)
│   ├─ Border: None
│   ├─ Shadow: 0 2px 6px rgba(13,115,119,0.2)
│   └─ Text Color: White
│
└─ Unselected:
    ├─ Background: White / #2A2A2A
    ├─ Border: 1pt solid #E0E0E0 / #3A3A3A
    ├─ Shadow: None
    └─ Text Color: #666666 / #A0A0A0

Chip Content (VStack):
├─ Icon: house.fill, building.2.fill, mappin.circle.fill
│   ├─ Size: 20x20pt
│   ├─ Color: Inherit (white selected, gray unselected)
│   └─ Margin Bottom: 4pt
│
└─ Text: "Home" / "Work" / "Other"
    ├─ Font: SF Pro Medium, 13pt
    └─ Color: Inherit

Animation:
└─ On tap: Scale 1.0 → 1.05 → 1.0 (spring)
```

### Input Fields
```
Position: Sequential, 20pt gaps between fields
Padding: 20pt horizontal

Label:
├─ Text: "Flat / House No. *" (* indicates required)
├─ Font: SF Pro Medium, 14pt
├─ Color: #666666 / #A0A0A0
└─ Margin Bottom: 8pt

Text Field:
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Border: 1pt solid #E0E0E0 (default)
├─ Border (focused): 2pt solid #0D7377
├─ Border (error): 2pt solid #EA5455
├─ Background: #F8F8F8 / #2A2A2A
├─ Padding: 16pt horizontal
├─ Font: SF Pro Regular, 16pt
├─ Color: #1E1E1E / #E0E0E0
├─ Placeholder Color: #999999
└─ Shadow (focused): 0 0 0 4px rgba(13,115,119,0.1)

Clear Button:
├─ Icon: xmark.circle.fill
├─ Size: 20x20pt
├─ Color: #CCCCCC
├─ Position: Right edge, 16pt padding
├─ Visible: Only when text present
└─ Action: Clear text

Error Message (if validation fails):
├─ Position: 6pt below input
├─ Icon: exclamationmark.circle.fill, 14x14pt, #EA5455
├─ Text: "This field is required"
├─ Font: SF Pro Regular, 13pt
├─ Color: #EA5455
└─ Gap: 6pt between icon and text

Fields List:
1. Flat / House No. (Required)
   ├─ Placeholder: "e.g., 4B, A-201"
   ├─ Keyboard: Default
   ├─ Max Length: 50
   └─ Validation: Not empty

2. Street / Society Name (Required)
   ├─ Placeholder: "e.g., MG Road, Green Park Society"
   ├─ Keyboard: Default
   ├─ Max Length: 100
   └─ Validation: Not empty, min 3 chars

3. Landmark (Optional)
   ├─ Placeholder: "e.g., Near City Mall"
   ├─ Keyboard: Default
   ├─ Max Length: 100
   └─ Validation: None

4. City / District (Required)
   ├─ Placeholder: "e.g., Bangalore"
   ├─ Keyboard: Default
   ├─ Max Length: 50
   ├─ Validation: Not empty, letters only
   └─ Auto-capitalize: Words

5. State (Required)
   ├─ Type: Dropdown picker
   ├─ Icon: chevron.down (right side)
   ├─ Options: All Indian states
   ├─ Default: Based on detected location or blank
   └─ Tap: Show picker bottom sheet

6. Pincode (Required)
   ├─ Placeholder: "e.g., 560001"
   ├─ Keyboard: Number Pad
   ├─ Max Length: 6 digits
   ├─ Validation: Exactly 6 digits
   ├─ Auto-fetch: City/State from pincode (API)
   └─ Loading indicator: While fetching
```

### Bottom Spacer
```
Height: 120pt (space for fixed CTA + keyboard)
```

### Fixed Bottom CTA
```
Position: Fixed at bottom, above safe area
Height: 80pt + safe area (34pt) = 114pt
Background: White (#FFFFFF) / #2A2A2A
Border Top: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 -4px 16px rgba(0,0,0,0.12)
Padding: 16pt horizontal, 16pt top

Button:
├─ Width: Full (358pt)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background:
│   ├─ Enabled: #0D7377
│   └─ Disabled: #E0E0E0
├─ Shadow:
│   ├─ Enabled: 0 4px 12px rgba(13,115,119,0.3)
│   └─ Disabled: None
└─ Tap: Validate and save address

Text:
├─ Text: "Save Address"
├─ Font: Inter SemiBold, 17pt
├─ Color: White
└─ Icon (loading): Spinner

States:
├─ Disabled: Required fields not filled
├─ Enabled: All required fields valid
├─ Loading: Saving address to backend
└─ Success: Dismiss and return to Address Selection

Validation (client-side):
├─ Flat/House: Not empty
├─ Street: Not empty, min 3 chars
├─ City: Not empty, letters only
├─ State: Selected
├─ Pincode: Exactly 6 digits
└─ Address Type: Selected (default: Home)

Backend Validation:
├─ Pincode exists in database
├─ Pincode in service area
└─ Address not duplicate
```

---

## Component Breakdown

### 1. Address Type Chip Selector
```
Component: ChipSelector (reusable)
Props:
├─ options: [AddressType] (Home, Work, Other)
├─ selected: Binding<AddressType>
├─ layout: Horizontal equal width
└─ Animation: Scale on selection
```

### 2. Validated Text Field
```
Component: ValidatedTextField (reusable)
Props:
├─ label: String
├─ placeholder: String
├─ text: Binding<String>
├─ validation: ValidationRule
├─ isRequired: Bool
├─ keyboardType: UIKeyboardType
├─ errorMessage: Binding<String?>
└─ onValidate: Callback
```

### 3. State Picker (Dropdown)
```
Component: StatePickerField
Props:
├─ selectedState: Binding<String>
├─ states: [String] (Indian states)
└─ Presentation: Bottom sheet picker
```

### 4. Pincode Field with Auto-Fetch
```
Component: PincodeTextField
Features:
├─ Number input (6 digits)
├─ Auto-fetch city/state from pincode
├─ Loading indicator during fetch
├─ Validate pincode existence
└─ Error if invalid or out of service area
```

---

## Animations & Transitions

### Screen Entry
```
Duration: 400ms
Transition: Slide in from right (or modal from bottom)

Sequence:
0ms   - Screen appears
100ms - Address type chips fade in
200ms - Input fields fade in sequentially (50ms each)
300ms - Save button slides up from bottom
```

### Address Type Selection
```
Trigger: Tap a chip
Duration: 250ms

Animation:
├─ Previous chip: Background teal → white, text white → gray
├─ New chip: Background white → teal, text gray → white
├─ Scale: 1.0 → 1.05 → 1.0 (spring)
├─ Shadow: Appears on selected
└─ Haptic: Light impact
```

### Input Focus
```
Trigger: Tap text field
Duration: 200ms

Animation:
├─ Border: 1pt gray → 2pt teal
├─ Background: Subtle highlight
├─ Shadow: Appears (teal glow)
├─ Keyboard: Slides up (iOS system)
└─ Scroll: Auto-scroll to show field above keyboard
```

### Pincode Auto-Fetch
```
Trigger: 6th digit entered
Duration: 1-2 seconds

States:
├─ Typing: Normal input
├─ Complete (6 digits): Show loading spinner (right side)
├─ Fetching: Spinner rotates
├─ Success: City/State fields auto-fill, checkmark appears
└─ Error: Red border, error message below

Animation:
├─ Spinner: Fade in, rotate continuously
├─ Auto-fill: Fields animate (fade in + slide up)
├─ Checkmark: Scale 0.8 → 1.0 with success color
└─ Error: Shake field, red border flash
```

### Validation Error
```
Trigger: User leaves field with invalid input
Duration: 400ms

Animation:
├─ Field: Shake (±8pt horizontal)
├─ Border: Gray → Red
├─ Error message: Fade in + slide down (5pt)
├─ Icon: exclamationmark.circle.fill appears
└─ Haptic: Error notification
```

### Save Button Press
```
Duration: 150ms

Press:
├─ Scale: 1.0 → 0.98
├─ Haptic: Medium impact
└─ Shadow: Reduces slightly

Release:
├─ Scale: 0.98 → 1.0
├─ Validate all fields
├─ If valid: Show loading (spinner)
├─ If invalid: Scroll to first error, shake field
└─ Success: Dismiss screen
```

---

## States

### Default State (Empty Form)
```
Visual:
├─ Address Type: "Home" selected (default)
├─ All fields: Empty with placeholders
├─ Save button: Disabled (gray)
└─ Keyboard: Hidden
```

### Filling State (Partial)
```
Visual:
├─ Some fields: Filled
├─ Current field: Focused (blue border)
├─ Other fields: Normal
├─ Keyboard: Visible
├─ Save button: Still disabled (if required fields empty)
└─ Scroll: Adjusted to show focused field
```

### Valid Ready State
```
Visual:
├─ All required fields: Filled and valid
├─ Pincode: Auto-fetched city/state (if successful)
├─ Save button: Enabled (teal with shadow)
└─ No error messages visible
```

### Saving State (Loading)
```
Trigger: Tap Save Address
Visual:
├─ Save button: Spinner replacing text
├─ All fields: Disabled (non-editable)
├─ Keyboard: Dismissed
├─ Screen: Semi-transparent overlay (optional)
└─ User: Cannot interact

Duration: 1-2 seconds
```

### Success State → Dismiss
```
Trigger: Address saved successfully
Action:
├─ Show success toast: "Address saved!" (2 seconds)
├─ Haptic: Success notification
├─ Dismiss screen (slide out to right or modal down)
├─ Return to Address Selection
└─ New address: Auto-selected in list
```

### Error State (Field Validation)
```
Trigger: Invalid field value
Visual:
├─ Field: Red border
├─ Error message: Below field
├─ Icon: exclamationmark.circle.fill
├─ Save button: Disabled
└─ Focus: Auto-focus on first error field
```

### Error State (Pincode Invalid)
```
Trigger: Pincode not found or out of service area
Visual:
├─ Pincode field: Red border
├─ Error: "Invalid pincode" or "Service unavailable in this area"
├─ City/State: Not auto-filled (or cleared)
├─ Save button: Disabled
└─ Alternative: "Notify me when available" link
```

### Error State (Save Failed)
```
Trigger: Backend error during save
Visual:
├─ Alert appears:
│   ├─ Title: "Failed to Save"
│   ├─ Message: "Please try again"
│   └─ Action: "Retry" / "Cancel"
├─ Save button: Returns to enabled
├─ Form data: Retained (not lost)
└─ User: Can edit and retry
```

### Map Picker Result
```
Trigger: User picks location from map
Visual:
├─ Map picker dismissed
├─ Lat/Lng stored
├─ Reverse geocode address
├─ Auto-fill fields: Street, City, State, Pincode
├─ User: Can edit auto-filled values
└─ Save button: Enabled if all required filled
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E
Fields Background: #2A2A2A
Field Border: #3A3A3A
Field Border (focused): #0D7377
Field Border (error): #EA5455
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Placeholder: #666666
Chip Selected: #0D7377
Chip Unselected: #2A2A2A
Bottom CTA: #2A2A2A
Button Disabled: #3A3A3A
Error Text: #EA5455
```

---

## Accessibility

### VoiceOver

**Labels:**
```
Close: "Close, button"
Map Picker: "Use map to pick location, button"
Address Type Home: "Home, chip, selected" / "unselected"
Flat Field: "Flat or house number, required, text field"
Street Field: "Street or society name, required, text field"
Landmark Field: "Landmark, optional, text field"
City Field: "City or district, required, text field"
State Field: "State, required, picker button"
Pincode Field: "Pincode, required, 6 digits, text field"
Save Button: "Save address, button" / "disabled, button"
```

**Announcements:**
```
On chip select: "Home selected"
On field error: "Error, This field is required"
On pincode fetch: "Fetching location details"
On pincode success: "City and state auto-filled"
On pincode error: "Invalid pincode"
On save: "Saving address"
On success: "Address saved successfully"
```

### Dynamic Type

**Scaling:** -2 to +3
```
Title: 18pt → 16pt (min) to 22pt (max)
Label: 14pt → 12pt (min) to 17pt (max)
Input: 16pt → 14pt (min) to 19pt (max)
Chip Text: 13pt → 11pt (min) to 16pt (max)
Button: 17pt → 15pt (min) to 20pt (max)

Layout:
├─ At +2: Field height 52pt → 60pt
├─ At +3: Chip height 48pt → 56pt
└─ Spacing increases proportionally
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct AddNewAddressView: View {
    @StateObject private var viewModel = AddNewAddressViewModel()
    @State private var addressType: AddressType = .home
    @State private var flatNo: String = ""
    @State private var street: String = ""
    @State private var landmark: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var pincode: String = ""
    @State private var errors: [String: String] = [:]
    @State private var isSaving: Bool = false
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss

    enum Field: Hashable {
        case flat, street, landmark, city, state, pincode
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Map Picker
                    MapPickerButton()
                        .padding(.top, 72)
                        .padding(.horizontal, 20)

                    // Address Type
                    AddressTypeSelector(selectedType: $addressType)
                        .padding(.horizontal, 20)

                    // Input Fields
                    VStack(spacing: 20) {
                        ValidatedTextField(
                            label: "Flat / House No.",
                            placeholder: "e.g., 4B, A-201",
                            text: $flatNo,
                            isRequired: true,
                            errorMessage: errors["flat"]
                        )
                        .focused($focusedField, equals: .flat)

                        ValidatedTextField(
                            label: "Street / Society Name",
                            placeholder: "e.g., MG Road, Green Park",
                            text: $street,
                            isRequired: true,
                            errorMessage: errors["street"]
                        )
                        .focused($focusedField, equals: .street)

                        ValidatedTextField(
                            label: "Landmark",
                            placeholder: "e.g., Near City Mall",
                            text: $landmark,
                            isRequired: false,
                            errorMessage: nil
                        )
                        .focused($focusedField, equals: .landmark)

                        ValidatedTextField(
                            label: "City / District",
                            placeholder: "e.g., Bangalore",
                            text: $city,
                            isRequired: true,
                            errorMessage: errors["city"]
                        )
                        .focused($focusedField, equals: .city)

                        StatePickerField(
                            label: "State",
                            selectedState: $state,
                            isRequired: true,
                            errorMessage: errors["state"]
                        )

                        PincodeTextField(
                            label: "Pincode",
                            pincode: $pincode,
                            isRequired: true,
                            errorMessage: errors["pincode"],
                            onAutoFetch: { fetchedCity, fetchedState in
                                city = fetchedCity
                                state = fetchedState
                            }
                        )
                        .focused($focusedField, equals: .pincode)
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 120)
                }
            }
            .scrollDismissesKeyboard(.interactively)

            // Top Bar
            CustomNavigationBar(
                title: "Add New Address",
                leftItems: [.close],
                onClose: handleClose
            )

            // Bottom CTA
            VStack {
                Spacer()
                FixedBottomCTA(
                    title: "Save Address",
                    action: saveAddress,
                    isLoading: isSaving,
                    isDisabled: !isFormValid
                )
            }
        }
    }

    private var isFormValid: Bool {
        !flatNo.isEmpty &&
        !street.isEmpty &&
        !city.isEmpty &&
        !state.isEmpty &&
        pincode.count == 6
    }

    private func saveAddress() {
        // Validate all fields
        errors = validateForm()

        guard errors.isEmpty else {
            // Focus first error field
            scrollToFirstError()
            return
        }

        isSaving = true
        focusedField = nil // Dismiss keyboard

        Task {
            do {
                let address = Address(
                    type: addressType,
                    flatNo: flatNo,
                    street: street,
                    landmark: landmark,
                    city: city,
                    state: state,
                    pincode: pincode
                )

                try await viewModel.saveAddress(address)
                isSaving = false

                // Show success toast
                showToast(message: "Address saved!")

                // Dismiss
                dismiss()

            } catch {
                isSaving = false
                showError(error)
            }
        }
    }

    private func validateForm() -> [String: String] {
        var errors: [String: String] = [:]

        if flatNo.isEmpty {
            errors["flat"] = "This field is required"
        }
        if street.isEmpty || street.count < 3 {
            errors["street"] = "Please enter a valid street name"
        }
        if city.isEmpty {
            errors["city"] = "This field is required"
        }
        if state.isEmpty {
            errors["state"] = "Please select a state"
        }
        if pincode.count != 6 {
            errors["pincode"] = "Please enter a valid 6-digit pincode"
        }

        return errors
    }

    private func handleClose() {
        if hasUnsavedChanges {
            showDiscardAlert()
        } else {
            dismiss()
        }
    }

    private var hasUnsavedChanges: Bool {
        !flatNo.isEmpty || !street.isEmpty || !landmark.isEmpty ||
        !city.isEmpty || !state.isEmpty || !pincode.isEmpty
    }

    private func scrollToFirstError() {
        // Scroll to first error field
    }

    private func showDiscardAlert() {
        // Show confirmation alert
    }

    private func showError(_ error: Error) {
        // Show error alert
    }

    private func showToast(message: String) {
        // Show success toast
    }
}
```

---

## Assets Required

### SF Symbols
```
- xmark / chevron.left
- map.fill
- chevron.right
- house.fill
- building.2.fill
- mappin.circle.fill
- xmark.circle.fill
- exclamationmark.circle.fill
- chevron.down
- checkmark.circle.fill
```

---

## Navigation Flow

### Entry
```
From Address Selection → Tap "Add New Address"
Transition: Slide in from right (or modal)
```

### Exit
```
1. Save Success → Dismiss to Address Selection
   └─ New address auto-selected
   └─ Transition: Slide out to right

2. Close (X) → Dismiss
   └─ Show confirmation if unsaved changes
   └─ Transition: Slide out to right

3. Map Picker → Map Screen (full screen)
   └─ Return with coordinates + reverse geocode
```

---

## Testing Checklist

- [ ] All fields render correctly
- [ ] Address type selection works
- [ ] Input validation works (client-side)
- [ ] Pincode auto-fetch works
- [ ] Pincode validation works
- [ ] State picker works
- [ ] Save button enables/disables correctly
- [ ] Save address to backend works
- [ ] Success toast shows
- [ ] Error handling works (save failed)
- [ ] Close confirmation works (unsaved changes)
- [ ] Keyboard dismissal works
- [ ] Scroll adjusts for keyboard
- [ ] Dark mode renders correctly
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Works on all devices

---

## Analytics

```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "add_new_address",
    "source": "booking_flow" // or "profile"
])

Analytics.logEvent("address_type_selected", parameters: [
    "type": addressType.rawValue
])

Analytics.logEvent("pincode_auto_fetch_success", parameters: [
    "pincode": pincode
])

Analytics.logEvent("address_saved", parameters: [
    "type": addressType.rawValue,
    "source": "booking_flow"
])

Analytics.logEvent("map_picker_used", parameters: [:])
```

---

**This add address screen must be simple, validate inputs properly, and make data entry as effortless as possible.**
