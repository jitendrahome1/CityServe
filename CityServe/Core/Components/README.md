# CityServe Component Library

Complete SwiftUI component library following the UrbanNest design system.

## 📁 Structure

```
Components/
├── Buttons/
│   ├── PrimaryButton.swift       ✅ Main CTA button
│   ├── SecondaryButton.swift     ✅ Secondary actions
│   └── IconButton.swift          ✅ Icon-only buttons
├── TextFields/
│   ├── StandardTextField.swift   ✅ General text input
│   └── OTPTextField.swift        ✅ One-time password input
├── Cards/
│   └── ServiceCard.swift         ✅ Service display cards
└── Common/
    ├── LoadingView.swift         ✅ Loading states
    ├── EmptyStateView.swift      ✅ Empty data states
    └── ErrorView.swift           ✅ Error handling
```

## 🎨 Design System Integration

All components use the design system foundation:
- **Colors**: `Color.primary`, `Color.secondary`, `Color.textPrimary`, etc.
- **Typography**: `.h1Style()`, `.bodyStyle()`, font extensions
- **Spacing**: `Spacing.md`, `Spacing.screenPadding`, etc.
- **Shadows**: `.mediumShadow()`, `.cardShadow()`, elevation levels
- **Animations**: `Animations.buttonTap`, haptic feedback

## 📚 Component Usage

### Buttons

#### Primary Button
Main CTA button with Deep Teal background and white text.

```swift
// Basic usage
PrimaryButton("Sign Up") {
    performSignUp()
}

// With icon
PrimaryButton("Continue", icon: "arrow.right") {
    navigateNext()
}

// Loading state
PrimaryButton("Processing...", isLoading: true) {
    // Won't trigger while loading
}

// Disabled state
PrimaryButton("Submit", isDisabled: !formIsValid) {
    submitForm()
}

// Size variants
PrimaryButton("Small", size: .small) { }
PrimaryButton("Medium", size: .medium) { }
PrimaryButton("Large", size: .large) { }  // Default

// Compact (not full width)
PrimaryButton("Next", fullWidth: false) {
    navigateNext()
}
```

#### Secondary Button
Outlined button for secondary actions.

```swift
// Basic usage
SecondaryButton("Cancel") {
    dismissView()
}

// Ghost style (no border)
SecondaryButton("Skip", style: .ghost) {
    skipStep()
}

// With icon
SecondaryButton("Back", icon: "arrow.left") {
    navigateBack()
}
```

#### Icon Button
Icon-only button for utility actions.

```swift
// Ghost style (default)
IconButton("xmark", accessibilityLabel: "Close") {
    dismiss()
}

// Filled style
IconButton("heart.fill", style: .filled) {
    toggleFavorite()
}

// Outlined style
IconButton("share", style: .outlined) {
    shareContent()
}

// Subtle background
IconButton("ellipsis", style: .subtle) {
    showMoreOptions()
}

// Size variants
IconButton("bell", size: .small) { }
IconButton("bell", size: .medium) { }   // Default
IconButton("bell", size: .large) { }
```

### Text Fields

#### Standard TextField
General purpose text input with label, icons, and error states.

```swift
// Basic usage
StandardTextField(
    label: "Email Address",
    placeholder: "Enter your email",
    text: $email
)

// With leading icon
StandardTextField(
    label: "Email",
    placeholder: "you@example.com",
    text: $email,
    leadingIcon: "envelope",
    keyboardType: .emailAddress,
    textContentType: .emailAddress
)

// Secure field (password)
StandardTextField(
    label: "Password",
    placeholder: "Enter password",
    text: $password,
    isSecure: true
)

// With error message
StandardTextField(
    label: "Email",
    placeholder: "you@example.com",
    text: $email,
    errorMessage: emailError
)

// With help text
StandardTextField(
    label: "Username",
    placeholder: "Choose a username",
    text: $username,
    helpText: "Must be 3-20 characters"
)

// With character limit
StandardTextField(
    label: "Bio",
    placeholder: "Tell us about yourself",
    text: $bio,
    maxLength: 150
)

// With trailing action
StandardTextField(
    label: "Code",
    placeholder: "Enter code",
    text: $code,
    trailingIcon: "doc.on.clipboard",
    trailingAction: {
        pasteFromClipboard()
    }
)
```

#### OTP TextField
One-time password input with individual digit boxes.

```swift
// 6-digit OTP (default)
OTPTextField(
    otpCode: $otpCode,
    onComplete: { code in
        verifyOTP(code)
    }
)

// 4-digit OTP
OTPTextField(
    otpCode: $otpCode,
    numberOfDigits: 4,
    onComplete: { code in
        verifyOTP(code)
    }
)

// With error state
OTPTextField(
    otpCode: $otpCode,
    errorMessage: otpError
)
```

### Cards

#### Service Card
Display service information with image, name, price, and rating.

```swift
// Create service model
let service = ServiceCardModel(
    id: "srv_123",
    name: "AC Repair & Service",
    icon: "❄️",
    imageURL: "https://...",
    shortDescription: "Complete AC repair...",
    basePrice: 499,
    maxPrice: 799,
    rating: 4.6,
    reviewCount: 89
)

// Vertical style (grid)
ServiceCard(
    service: service,
    style: .vertical,
    action: {
        navigateToDetail(service)
    }
)

// Horizontal style (list)
ServiceCard(
    service: service,
    style: .horizontal,
    action: {
        navigateToDetail(service)
    }
)

// Compact style (home grid)
ServiceCard(
    service: service,
    style: .compact,
    action: {
        navigateToDetail(service)
    }
)

// In a grid
LazyVGrid(columns: [
    GridItem(.flexible()),
    GridItem(.flexible())
], spacing: Spacing.md) {
    ForEach(services) { service in
        ServiceCard(service: service) {
            selectService(service)
        }
    }
}
```

### Common Components

#### Loading View
Display loading states with spinner or shimmer effect.

```swift
// Spinner with message
LoadingView(
    message: "Loading services...",
    style: .spinner
)

// Inline loader
LoadingView(
    message: "Processing",
    style: .inline
)

// Shimmer skeleton
LoadingView(style: .shimmer)

// Full screen loading
if isLoading {
    LoadingView(message: "Please wait...")
} else {
    ContentView()
}
```

#### Empty State View
Display empty data states with icon, message, and optional action.

```swift
// Custom empty state
EmptyStateView(
    icon: "calendar.badge.exclamationmark",
    title: "No Bookings Yet",
    description: "You haven't made any bookings.",
    actionTitle: "Explore Services",
    action: {
        navigateToServices()
    }
)

// Predefined states
EmptyStateView.noBookings {
    navigateToServices()
}

EmptyStateView.noSearchResults(searchQuery: query)

EmptyStateView.noServices {
    changeCity()
}

EmptyStateView.noNotifications

EmptyStateView.noFavorites {
    browseServices()
}

EmptyStateView.connectionError {
    retryConnection()
}
```

#### Error View
Display error states with retry option.

```swift
// Network error
ErrorView.networkError {
    retryRequest()
}

// Server error
ErrorView.serverError {
    retryRequest()
}

// Not found
ErrorView.notFound

// Unauthorized
ErrorView.unauthorized

// Custom error
ErrorView.custom(
    title: "Payment Failed",
    message: "Could not process payment",
    icon: "creditcard.trianglebadge.exclamationmark",
    retry: {
        retryPayment()
    }
)

// Inline error banner
ErrorBanner(
    message: "Invalid email format",
    dismissAction: {
        clearError()
    }
)
```

## 🎯 Best Practices

### 1. Always Use Design System
```swift
// ✅ Good
Text("Hello")
    .foregroundColor(.textPrimary)
    .font(.body)

// ❌ Bad
Text("Hello")
    .foregroundColor(Color(hex: "#1E1E1E"))
    .font(.system(size: 14))
```

### 2. Provide Accessibility Labels
```swift
// ✅ Good
IconButton("xmark", accessibilityLabel: "Close") {
    dismiss()
}

// ❌ Bad
IconButton("xmark") {
    dismiss()
}
```

### 3. Handle Loading and Error States
```swift
// ✅ Good
@State private var isLoading = false
@State private var error: Error?

var body: some View {
    if isLoading {
        LoadingView(message: "Loading...")
    } else if let error = error {
        ErrorView.serverError {
            loadData()
        }
    } else {
        ContentView()
    }
}
```

### 4. Use Haptic Feedback
```swift
// ✅ Good - Components handle this automatically
PrimaryButton("Submit") {
    // Haptic feedback is automatic
    submitForm()
}

// For custom interactions
Button("Custom") {
    Haptics.medium()
    performAction()
}
```

### 5. Consistent Spacing
```swift
// ✅ Good
VStack(spacing: Spacing.md) {
    Text("Title")
    Text("Subtitle")
}
.padding(Spacing.screenPadding)

// ❌ Bad
VStack(spacing: 16) {
    Text("Title")
    Text("Subtitle")
}
.padding(20)
```

## 🔄 State Management

Components support standard SwiftUI state binding:

```swift
struct MyView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var otpCode = ""
    @State private var isLoading = false

    var body: some View {
        VStack {
            StandardTextField(
                label: "Email",
                placeholder: "Enter email",
                text: $email
            )

            StandardTextField(
                label: "Password",
                placeholder: "Enter password",
                text: $password,
                isSecure: true
            )

            PrimaryButton(
                "Sign In",
                isLoading: isLoading
            ) {
                signIn()
            }
        }
    }
}
```

## 🌓 Dark Mode

All components automatically support dark mode. No additional code needed!

```swift
// Components adapt automatically
PrimaryButton("Continue") {
    navigateNext()
}

// Test dark mode in previews
#Preview {
    MyView()
        .preferredColorScheme(.dark)
}
```

## ♿ Accessibility

Components are built with accessibility in mind:

- ✅ Dynamic Type support
- ✅ VoiceOver labels
- ✅ Minimum touch targets (44x44pt)
- ✅ Color contrast (WCAG AA)
- ✅ Semantic labels

## 📱 Platform Support

- iOS 17.0+
- SwiftUI
- iPhone and iPad

## 🎨 Customization

Components are designed to be flexible:

```swift
// Customize button sizes
PrimaryButton("Text", size: .small) { }
PrimaryButton("Text", size: .medium) { }
PrimaryButton("Text", size: .large) { }

// Customize button width
PrimaryButton("Compact", fullWidth: false) { }

// Customize card styles
ServiceCard(service: service, style: .vertical) { }
ServiceCard(service: service, style: .horizontal) { }
ServiceCard(service: service, style: .compact) { }

// Customize loading styles
LoadingView(style: .spinner)
LoadingView(style: .shimmer)
LoadingView(style: .inline)
```

## 🚀 Performance Tips

1. **Use LazyVGrid/LazyVStack** for long lists
2. **Provide stable IDs** for ForEach loops
3. **Minimize state updates** in large lists
4. **Use @State sparingly** - prefer @Binding when possible
5. **Profile with Instruments** to catch performance issues

## 📝 Adding New Components

When creating new components:

1. Follow the existing structure
2. Use the design system (Colors, Typography, Spacing)
3. Support dark mode automatically
4. Add accessibility labels
5. Include haptic feedback where appropriate
6. Create comprehensive previews
7. Document usage in this README

## 🐛 Troubleshooting

### Colors not showing?
Make sure you've added color assets to Assets.xcassets, or use the fallback hex values.

### Fonts look wrong?
Add Inter font family to your project and register in Info.plist.

### Components not importing?
Ensure all files are added to your Xcode target.

## 📖 Additional Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Accessibility Best Practices](https://developer.apple.com/accessibility/)

---

**Last Updated**: December 31, 2024
**Version**: 1.0.0
**Maintainer**: UrbanNest Design Team
