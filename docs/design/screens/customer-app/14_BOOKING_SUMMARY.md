# 14 - Booking Summary

**Screen ID:** 14
**Screen Name:** Booking Summary
**User Flow:** Date/Time Selection → Booking Summary → Payment → Confirmation
**Entry Point:** After selecting date and time slot
**Next Screen:** Payment Processing (16) or Payment Method Selection (15)

---

## Overview

The booking summary screen displays all booking details for user review before payment. It shows the service, date/time, address, pricing breakdown, and special instructions option. This is the final checkpoint before payment.

**Purpose:**
- Display complete booking details
- Show pricing breakdown (base price, taxes, discounts)
- Allow adding special instructions/notes
- Apply promo code for discounts
- Show cancellation policy
- Enable editing of previous selections
- Provide clear "Proceed to Payment" CTA

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ✕  Booking Summary                    │ ← Top Bar
├────────────────────────────────────────┤
│                                        │
│  Review your booking details           │ ← Title
│                                        │
│  ┌────────────────────────────────┐   │
│  │ [Image] 🔧 AC Service & Gas    │   │ ← Service Card
│  │ Refill                         │   │   (Summary)
│  │ ⭐ 4.9 • 234 reviews           │   │
│  │ Duration: 30-45 min      [Edit]│   │
│  └────────────────────────────────┘   │
│                                        │
│  📅 Date & Time              [Edit]   │ ← Section
│  Wednesday, January 15, 2025          │
│  8:00 AM - 9:00 AM                    │
│                                        │
│  📍 Service Address          [Edit]   │
│  🏠 Home                               │
│  123 MG Road, Flat 4B                 │
│  Near City Mall                       │
│  Bangalore - 560001                   │
│                                        │
│  📝 Special Instructions (Optional)   │
│  ┌────────────────────────────────┐   │
│  │ e.g., Ring the doorbell twice │   │ ← Text Area
│  └────────────────────────────────┘   │
│                                        │
│  🎟️  Have a promo code?               │
│  ┌─────────────────┬──────────────┐   │
│  │ FIRST20         │   Apply      │   │ ← Promo Input
│  └─────────────────┴──────────────┘   │
│                                        │
│  💳 Payment Summary                   │ ← Section Header
│  ┌────────────────────────────────┐   │
│  │ Service Charge      ₹599       │   │ ← Price Row
│  │ Taxes & Fees        ₹59        │   │
│  │ Discount (FIRST20) -₹100       │   │ ← Discount
│  │ ─────────────────────────      │   │
│  │ Total               ₹558       │   │ ← Total
│  └────────────────────────────────┘   │
│                                        │
│  ℹ️  Cancellation Policy              │
│  Free cancellation until 2 hours...   │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ Proceed to Payment - ₹558      │   │ ← Bottom CTA
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
│   ├─ Icon: xmark
│   ├─ Size: 20x20pt
│   ├─ Tap Target: 44x44pt
│   └─ Action: Show exit confirmation alert

Title:
├─ Text: "Booking Summary"
├─ Font: Inter SemiBold, 18pt
├─ Color: #1E1E1E / #E0E0E0
└─ Position: Center
```

### Title Section
```
Position: 16pt below top bar
Padding: 20pt horizontal

Text:
├─ Text: "Review your booking details"
├─ Font: Inter Medium, 16pt
├─ Color: #666666 / #A0A0A0
└─ Margin Bottom: 16pt
```

### Service Summary Card
```
Position: Below title
Padding: 20pt horizontal
Margin Bottom: 20pt

Card:
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Border Radius: 16pt
├─ Border: 1pt solid #F0F0F0 / #3A3A3A
├─ Shadow: 0 2px 8px rgba(0,0,0,0.06)
├─ Padding: 16pt
└─ Tap: Non-interactive (info only)

Layout (HStack):

Left Section (Image):
├─ Width: 80pt
├─ Height: 80pt
├─ Border Radius: 12pt
├─ Image: Service photo
├─ Background: #F5F5F5 (if no image)
└─ Object Fit: Cover

Right Section (Details):
├─ Padding Left: 12pt
├─ Flex: 1 (fills space)
│
├─ Service Name:
│   ├─ Text: "AC Service & Gas Refill"
│   ├─ Font: Inter SemiBold, 16pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Max Lines: 2
│   └─ Truncation: Tail
│
├─ Rating (HStack):
│   ├─ Icon: star.fill, 14x14pt, #FFC107
│   ├─ Text: "4.9"
│   ├─ Font: SF Pro Medium, 13pt
│   ├─ Color: #666666
│   ├─ Gap: 4pt
│   ├─ Separator: "•"
│   ├─ Reviews: "234 reviews"
│   └─ Margin Top: 6pt
│
├─ Duration:
│   ├─ Icon: clock, 12x12pt, #666666
│   ├─ Text: "Duration: 30-45 min"
│   ├─ Font: SF Pro Regular, 13pt
│   ├─ Color: #666666 / #A0A0A0
│   ├─ Gap: 4pt
│   └─ Margin Top: 6pt
│
└─ Edit Button:
    ├─ Text: "Edit"
    ├─ Font: SF Pro Medium, 13pt
    ├─ Color: #0D7377
    ├─ Background: rgba(13,115,119,0.1)
    ├─ Padding: 4pt vertical, 10pt horizontal
    ├─ Border Radius: 12pt
    ├─ Position: Top-right corner (absolute)
    └─ Action: Return to Service Detail
```

### Detail Section (Repeatable Component)
```
Position: Sequential, 20pt gaps
Padding: 20pt horizontal

Section Format:
├─ Background: White / #2A2A2A
├─ Border Radius: 16pt
├─ Border: 1pt solid #F0F0F0 / #3A3A3A
├─ Shadow: 0 2px 6px rgba(0,0,0,0.06)
├─ Padding: 16pt
└─ Margin Bottom: 12pt

Header (HStack):
├─ Icon: SF Symbol, 20x20pt, #0D7377
│   ├─ calendar.fill (Date & Time)
│   ├─ mappin.circle.fill (Address)
│   ├─ note.text (Instructions)
│   └─ tag.fill (Promo)
│
├─ Title: "Date & Time"
│   ├─ Font: Inter SemiBold, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Flex: 1
│
└─ Edit Button (if applicable):
    ├─ Text: "Edit"
    ├─ Font: SF Pro Medium, 13pt
    ├─ Color: #0D7377
    └─ Action: Navigate to respective screen

Content (below header, 12pt margin):
└─ Details specific to section
```

### Date & Time Section
```
Content:
├─ Date:
│   ├─ Text: "Wednesday, January 15, 2025"
│   ├─ Font: SF Pro Medium, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Margin Top: 12pt
│
└─ Time:
    ├─ Text: "8:00 AM - 9:00 AM"
    ├─ Font: SF Pro Regular, 14pt
    ├─ Color: #666666 / #A0A0A0
    └─ Margin Top: 4pt
```

### Service Address Section
```
Content:
├─ Address Type (HStack):
│   ├─ Icon: house.fill, 16x16pt, #666666
│   ├─ Text: "Home"
│   ├─ Font: SF Pro Medium, 14pt
│   ├─ Color: #666666
│   ├─ Gap: 6pt
│   └─ Margin Top: 12pt
│
├─ Line 1 (Street):
│   ├─ Text: "123 MG Road, Flat 4B"
│   ├─ Font: SF Pro Medium, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Margin Top: 8pt
│
├─ Line 2 (Landmark):
│   ├─ Text: "Near City Mall"
│   ├─ Font: SF Pro Regular, 14pt
│   ├─ Color: #666666 / #A0A0A0
│   └─ Margin Top: 4pt
│
└─ Line 3 (City, Pincode):
    ├─ Text: "Bangalore - 560001"
    ├─ Font: SF Pro Regular, 14pt
    ├─ Color: #666666 / #A0A0A0
    └─ Margin Top: 4pt
```

### Special Instructions Section
```
Content:
├─ Header: "Special Instructions (Optional)"
│   ├─ Icon: note.text
│   └─ No Edit button
│
└─ Text Area:
    ├─ Height: 80pt (min), grows with content
    ├─ Border Radius: 8pt
    ├─ Border: 1pt solid #E0E0E0 / #3A3A3A
    ├─ Background: #F8F8F8 / #2A2A2A
    ├─ Padding: 12pt
    ├─ Placeholder: "e.g., Ring the doorbell twice"
    ├─ Font: SF Pro Regular, 14pt
    ├─ Color: #1E1E1E / #E0E0E0
    ├─ Placeholder Color: #999999
    ├─ Max Length: 200 characters
    ├─ Keyboard: Default
    └─ Character counter: "0/200" (bottom-right)
```

### Promo Code Section
```
Content:
├─ Header: "Have a promo code?"
│   ├─ Icon: tag.fill
│   └─ No Edit button
│
└─ Input Row (HStack):
    ├─ Text Field:
    │   ├─ Width: Flex (fills available space)
    │   ├─ Height: 48pt
    │   ├─ Border Radius: 8pt (left side only)
    │   ├─ Border: 1pt solid #E0E0E0
    │   ├─ Background: #F8F8F8 / #2A2A2A
    │   ├─ Padding: 12pt horizontal
    │   ├─ Placeholder: "Enter promo code"
    │   ├─ Font: SF Pro Medium, 15pt
    │   ├─ Color: #1E1E1E
    │   ├─ Autocapitalization: All characters
    │   └─ Max Length: 20 characters
    │
    └─ Apply Button:
        ├─ Width: 80pt
        ├─ Height: 48pt
        ├─ Border Radius: 8pt (right side only)
        ├─ Background: #0D7377
        ├─ Text: "Apply"
        ├─ Font: SF Pro SemiBold, 15pt
        ├─ Color: White
        ├─ Border Left: None (connected to input)
        └─ Action: Validate and apply promo code

States:
├─ Empty: Apply button disabled
├─ Filled: Apply button enabled
├─ Applying: Spinner in button
├─ Applied: Checkmark + "Applied" text, green background
└─ Invalid: Red border, error message below
```

### Payment Summary Section
```
Position: Below promo code
Padding: 20pt horizontal
Margin Top: 20pt

Card:
├─ Background: White / #2A2A2A
├─ Border Radius: 16pt
├─ Border: 1pt solid #F0F0F0 / #3A3A3A
├─ Shadow: 0 2px 8px rgba(0,0,0,0.06)
├─ Padding: 16pt
└─ Layout: VStack

Header:
├─ Icon: creditcard.fill, 20x20pt, #0D7377
├─ Text: "Payment Summary"
├─ Font: Inter SemiBold, 15pt
├─ Color: #1E1E1E / #E0E0E0
└─ Margin Bottom: 16pt

Price Rows (each row):
├─ Layout: HStack with space between
├─ Height: 28pt
├─ Gap: 8pt between rows
│
├─ Label (left):
│   ├─ Text: "Service Charge" / "Taxes & Fees" / "Discount"
│   ├─ Font: SF Pro Regular, 14pt
│   ├─ Color: #666666 / #A0A0A0
│   └─ Flex: 1
│
└─ Amount (right):
    ├─ Text: "₹599" / "₹59" / "-₹100"
    ├─ Font: SF Pro Medium, 15pt
    ├─ Color:
    │   ├─ Regular: #1E1E1E / #E0E0E0
    │   └─ Discount: #28C76F (green with minus)
    └─ Alignment: Right

Divider:
├─ Position: After discounts, before total
├─ Height: 1pt
├─ Color: #E0E0E0 / #3A3A3A
└─ Margin: 12pt vertical

Total Row:
├─ Label: "Total"
│   ├─ Font: Inter SemiBold, 17pt
│   ├─ Color: #1E1E1E / #E0E0E0
│
└─ Amount: "₹558"
    ├─ Font: Inter Bold, 20pt
    ├─ Color: #0D7377 (brand primary)
    └─ Alignment: Right

Breakdown Details:
├─ Service Charge: Base service price
├─ Taxes & Fees: GST (18%) + Platform fee
├─ Discount: Promo code discount
├─ Surge (if applicable): High demand charge
└─ Total: Final amount to pay
```

### Cancellation Policy Section
```
Position: Below payment summary
Padding: 20pt horizontal
Margin Top: 16pt
Margin Bottom: 20pt

Component:
├─ Background: #FFF9F0 (light yellow) / #2A2520 (dark)
├─ Border Radius: 12pt
├─ Border: 1pt solid #FFD700 / #4A4020
├─ Padding: 12pt
└─ Layout: HStack

Icon:
├─ Image: info.circle.fill
├─ Size: 18x18pt
├─ Color: #FFA500 (orange)
└─ Position: Top-aligned

Text (VStack):
├─ Title: "Cancellation Policy"
│   ├─ Font: SF Pro SemiBold, 13pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Margin Bottom: 4pt
│
└─ Details:
    ├─ Text: "Free cancellation until 2 hours before the scheduled time. After that, cancellation charges may apply."
    ├─ Font: SF Pro Regular, 12pt
    ├─ Color: #666666 / #A0A0A0
    ├─ Line Height: 1.4
    └─ Max Lines: 3 (expand to show more)

Link (optional):
├─ Text: "View full policy"
├─ Font: SF Pro Medium, 12pt
├─ Color: #0D7377
└─ Action: Show policy modal
```

### Bottom Spacer
```
Height: 120pt
```

### Fixed Bottom CTA
```
Position: Fixed at bottom
Height: 80pt + safe area = 114pt
Background: White / #2A2A2A
Border Top: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 -4px 16px rgba(0,0,0,0.12)
Padding: 16pt horizontal, 16pt top

Button:
├─ Width: Full (358pt)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background: #0D7377
├─ Shadow: 0 4px 16px rgba(13,115,119,0.3)
└─ Tap: Navigate to Payment

Content (HStack):
├─ Text: "Proceed to Payment"
│   ├─ Font: Inter SemiBold, 17pt
│   ├─ Color: White
│   └─ Letter Spacing: 0.3pt
│
├─ Spacer
│
└─ Price: "₹558"
    ├─ Font: Inter Bold, 20pt
    ├─ Color: White
    └─ Background: rgba(255,255,255,0.2) (pill)
        ├─ Padding: 6pt vertical, 12pt horizontal
        └─ Border Radius: 20pt

Animation:
├─ Press: Scale 0.98
├─ Haptic: Medium impact
└─ Loading: Spinner if validating
```

---

## Component Breakdown

### 1. Editable Detail Section
```
Component: EditableDetailCard
Props:
├─ icon: String (SF Symbol name)
├─ title: String
├─ content: AnyView (flexible content)
├─ showEdit: Bool
├─ onEdit: () -> Void
└─ Reusable for all detail sections
```

### 2. Promo Code Input
```
Component: PromoCodeInput
Props:
├─ code: Binding<String>
├─ isValid: Binding<Bool>
├─ discount: Binding<Double?>
├─ onApply: (String) async throws -> Discount
└─ States: Empty, Applying, Applied, Invalid
```

### 3. Price Breakdown
```
Component: PriceBreakdown
Props:
├─ basePrice: Double
├─ taxes: Double
├─ discount: Double?
├─ total: Double
└─ Layout: Rows with labels and amounts
```

---

## Animations & Transitions

### Screen Entry
```
Duration: 400ms

Sequence:
0ms   - Screen slides in from right
100ms - Service card fades in + slides up (10pt)
150ms - Date/Time section fades in
200ms - Address section fades in
250ms - Instructions section fades in
300ms - Promo section fades in
350ms - Payment summary fades in
400ms - Bottom CTA slides up
```

### Promo Code Apply
```
Trigger: Tap "Apply" button
Duration: 800ms

Sequence:
0ms   - Button shows spinner
200ms - API call to validate code
500ms - If valid:
        ├─ Discount row animates in (fade + slide down)
        ├─ Total amount updates with animation
        ├─ Button changes to green "Applied ✓"
        └─ Haptic: Success
600ms - If invalid:
        ├─ Input border turns red
        ├─ Error message appears below
        ├─ Shake animation (±8pt)
        └─ Haptic: Error
```

### Edit Button Tap
```
Duration: 150ms

Animation:
├─ Scale: 1.0 → 0.95
├─ Background: Slight darken
├─ Haptic: Light impact
└─ Navigate to respective edit screen
```

---

## States

### Default State (All Details Loaded)
```
Visual:
├─ All sections: Populated with booking data
├─ Promo code: Empty
├─ Instructions: Empty (optional)
├─ Payment summary: Shows base price + taxes
├─ Proceed button: Enabled
└─ Total: Base calculation
```

### Promo Code Applied
```
Trigger: Valid promo code entered and applied
Visual:
├─ Promo input: Green border, "Applied ✓" button
├─ Payment summary: Discount row appears
├─ Total: Updated with discount
├─ Proceed button: Shows discounted price
└─ Toast: "Promo applied! You save ₹100"
```

### Promo Code Invalid
```
Trigger: Invalid/expired promo code
Visual:
├─ Promo input: Red border
├─ Error message: "Invalid or expired code"
├─ Apply button: Returns to normal
└─ Shake animation on input
```

### Loading State (Initial)
```
Visual:
├─ Service card: Shimmer
├─ Detail sections: Shimmer
├─ Payment summary: Shimmer
├─ Proceed button: Disabled
└─ Duration: 500ms-1s
```

### Price Recalculating
```
Trigger: Promo applied or surge pricing update
Visual:
├─ Payment summary: Shimmer on affected rows
├─ Total: Animates to new value (count up/down)
├─ Duration: 500ms
└─ Proceed button: Shows loading briefly
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E
Cards: #2A2A2A
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Border: #3A3A3A
Promo Input: #2A2A2A
Payment Summary: #2A2A2A
Cancellation Info: #2A2520 (dark yellow tint)
Discount Green: #28C76F (same)
Total Price: #14A0A5 (lighter teal)
```

---

## Accessibility

### VoiceOver

**Labels:**
```
Close: "Close, button"
Service Card: "AC Service & Gas Refill, ₹599, 4.9 stars"
Edit Service: "Edit service, button"
Date: "Wednesday January 15th 2025, 8:00 AM to 9:00 AM"
Edit Date: "Edit date and time, button"
Address: "Home, 123 MG Road Flat 4B, Bangalore 560001"
Edit Address: "Edit address, button"
Instructions: "Special instructions, optional, text field"
Promo Code: "Promo code, text field"
Apply: "Apply promo code, button"
Price Row: "Service charge, ₹599"
Total: "Total amount, ₹558"
Policy: "Cancellation policy, free cancellation until 2 hours before"
Proceed: "Proceed to payment, ₹558, button"
```

### Dynamic Type

**Scaling:** -2 to +3
```
Service name: 16pt → 14pt (min) to 19pt (max)
Section title: 15pt → 13pt (min) to 18pt (max)
Price amounts: 15pt → 13pt (min) to 18pt (max)
Total: 20pt → 17pt (min) to 24pt (max)

Layout:
├─ At +2: Card padding increases
├─ At +3: Some HStacks become VStacks
└─ Line spacing increases
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct BookingSummaryView: View {
    let serviceId: String
    let addressId: String
    let date: Date
    let timeSlot: TimeSlot

    @StateObject private var viewModel: BookingSummaryViewModel
    @State private var promoCode: String = ""
    @State private var instructions: String = ""
    @State private var appliedDiscount: Discount?

    init(serviceId: String, addressId: String, date: Date, timeSlot: TimeSlot) {
        self.serviceId = serviceId
        self.addressId = addressId
        self.date = date
        self.timeSlot = timeSlot
        _viewModel = StateObject(wrappedValue: BookingSummaryViewModel(
            serviceId: serviceId,
            addressId: addressId
        ))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray100.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Review your booking details")
                        .font(.custom("Inter-Medium", size: 16))
                        .foregroundColor(.textSecondary)
                        .padding(.horizontal, 20)
                        .padding(.top, 72)

                    // Service Card
                    ServiceSummaryCard(
                        service: viewModel.service,
                        onEdit: editService
                    )
                    .padding(.horizontal, 20)

                    // Date & Time
                    EditableDetailCard(
                        icon: "calendar.fill",
                        title: "Date & Time",
                        showEdit: true,
                        onEdit: editDateTime
                    ) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(date.formatted(date: .long, time: .omitted))
                                .font(.system(size: 15, weight: .medium))
                            Text("\(timeSlot.startTime) - \(timeSlot.endTime)")
                                .font(.system(size: 14))
                                .foregroundColor(.textSecondary)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Address
                    EditableDetailCard(
                        icon: "mappin.circle.fill",
                        title: "Service Address",
                        showEdit: true,
                        onEdit: editAddress
                    ) {
                        AddressDisplay(address: viewModel.address)
                    }
                    .padding(.horizontal, 20)

                    // Special Instructions
                    EditableDetailCard(
                        icon: "note.text",
                        title: "Special Instructions (Optional)",
                        showEdit: false
                    ) {
                        TextEditor(text: $instructions)
                            .frame(height: 80)
                            .padding(8)
                            .background(Color.gray100)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)

                    // Promo Code
                    PromoCodeSection(
                        code: $promoCode,
                        appliedDiscount: $appliedDiscount,
                        onApply: applyPromoCode
                    )
                    .padding(.horizontal, 20)

                    // Payment Summary
                    PaymentSummaryCard(
                        basePrice: viewModel.service.price,
                        taxes: viewModel.taxes,
                        discount: appliedDiscount?.amount,
                        total: calculateTotal()
                    )
                    .padding(.horizontal, 20)

                    // Cancellation Policy
                    CancellationPolicyView()
                        .padding(.horizontal, 20)

                    Spacer(minLength: 120)
                }
            }

            // Top Bar
            CustomNavigationBar(
                title: "Booking Summary",
                leftItems: [.close],
                onClose: handleClose
            )

            // Bottom CTA
            VStack {
                Spacer()
                FixedBottomCTA(
                    title: "Proceed to Payment",
                    price: calculateTotal(),
                    action: proceedToPayment
                )
            }
        }
        .onAppear {
            viewModel.loadBookingDetails()
        }
    }

    private func calculateTotal() -> Double {
        var total = viewModel.service.price + viewModel.taxes
        if let discount = appliedDiscount {
            total -= discount.amount
        }
        return max(total, 0)
    }

    private func applyPromoCode() async throws {
        let discount = try await viewModel.validatePromoCode(promoCode)
        appliedDiscount = discount
        showToast(message: "Promo applied! You save ₹\(discount.amount)")
    }

    private func proceedToPayment() {
        // Navigate to Payment screen
        // Pass: all booking details + total amount
    }

    private func editService() { /* Navigate back */ }
    private func editDateTime() { /* Navigate to date/time */ }
    private func editAddress() { /* Navigate to address */ }
    private func handleClose() { /* Show exit confirmation */ }
    private func showToast(message: String) { /* Toast */ }
}
```

---

## Assets Required

### SF Symbols
```
- xmark
- star.fill
- clock
- calendar.fill
- mappin.circle.fill
- note.text
- tag.fill
- creditcard.fill
- info.circle.fill
- house.fill
- checkmark
```

---

## Navigation Flow

### Entry
```
From Date/Time Selection → Tap "Continue"
Transition: Slide in from right
Data: { serviceId, addressId, date, timeSlot }
```

### Exit
```
1. Proceed to Payment → Payment Screen (16)
   └─ Transition: Slide in from right
   └─ Data: { all booking details, total }

2. Edit Service → Service Detail
3. Edit Date/Time → Date/Time Selection
4. Edit Address → Address Selection
5. Close → Show confirmation, dismiss flow
```

---

## Testing Checklist

- [ ] All booking details display correctly
- [ ] Edit buttons navigate properly
- [ ] Special instructions text area works
- [ ] Promo code validation works
- [ ] Promo code apply/remove works
- [ ] Price recalculation works
- [ ] Payment summary updates correctly
- [ ] Cancellation policy displays
- [ ] Proceed button shows correct total
- [ ] Close confirmation works
- [ ] Dark mode renders correctly
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Works on all devices

---

## Analytics

```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "booking_summary",
    "service_id": serviceId,
    "total_amount": calculateTotal()
])

Analytics.logEvent("promo_code_applied", parameters: [
    "code": promoCode,
    "discount_amount": appliedDiscount?.amount ?? 0
])

Analytics.logEvent("proceed_to_payment_tapped", parameters: [
    "service_id": serviceId,
    "amount": calculateTotal(),
    "has_promo": appliedDiscount != nil,
    "has_instructions": !instructions.isEmpty
])
```

---

**This booking summary screen is the final review before payment. It must be clear, editable, and build trust before the user commits to payment.**
