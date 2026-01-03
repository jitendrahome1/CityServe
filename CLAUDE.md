# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**CityServe** (branded as **UrbanNest**) is a comprehensive on-demand service marketplace platform similar to Urban Company. It connects customers with verified professional service providers for home and lifestyle services.

- **Brand Name**: UrbanNest (primary), Servly/Taskora/FixMate (backups)
- **Platform Type**: Multi-sided marketplace (Customers, Providers, Admins)
- **Target Market**: India-first (Delhi NCR launch), global expansion ready
- **Business Model**: Commission-based, escrow payment system
- **Current Status**: iOS Customer App MVP Complete ✅ + Firebase Auth Integrated 🔥

### Technology Stack

- **iOS**: SwiftUI + Combine (iOS 17.0+, Xcode 15.0+)
- **Architecture**: MVVM + Clean Architecture
- **Backend**: Firebase (Auth ✅, Firestore ready, Cloud Functions planned, Storage ready)
- **Localization**: Type-safe localization system with Strings.swift
- **Payments (Planned)**: Razorpay (India), UPI, Cards, Wallets
- **Notifications (Planned)**: Firebase Cloud Messaging
- **Maps (Planned)**: Google Maps Platform

## Repository Structure

This repository contains the **iOS Customer App** (CityServe). The project is currently a single iOS application with plans for backend and additional platforms:

```
CityServe/
├── NAMING.md                    # Complete brand strategy
├── CLAUDE.md                    # This file
├── APP_IMPLEMENTATION_SUMMARY.md # Implementation status
├── docs/                        # Technical documentation
│   ├── ARCHITECTURE.md          # System architecture
│   ├── DATABASE_SCHEMA.md       # Firestore data model
│   ├── API_SPEC.md              # Cloud Functions API spec
│   ├── design/                  # Design specs
│   │   ├── DESIGN_SYSTEM.md     # Complete design system
│   │   ├── COMPONENT_LIBRARY.md # Component usage guide
│   │   └── screens/             # Screen-by-screen specs
│   └── WEB_*.md                 # Web platform specs
├── CityServe.xcodeproj/         # Xcode project
└── CityServe/                   # iOS app source code
    ├── CityServeApp.swift       # App entry point (@main)
    ├── ContentView.swift        # Root view
    ├── GoogleService-Info.plist # Firebase config (replace with real file!)
    ├── Core/                    # Core systems
    │   ├── DesignSystem/        # Brand colors, typography, spacing
    │   │   ├── Colors.swift
    │   │   ├── Typography.swift
    │   │   ├── Spacing.swift
    │   │   ├── Shadows.swift
    │   │   ├── Animations.swift
    │   │   └── Haptics.swift
    │   ├── Localization/        # Type-safe localization
    │   │   └── Strings.swift    # All app strings (supports i18n)
    │   ├── Firebase/            # Firebase service layer
    │   │   ├── FirebaseAuthService.swift
    │   │   ├── FirestoreService.swift
    │   │   └── FirebaseStorageService.swift
    │   └── Components/          # Reusable UI components
    │       ├── Buttons/         # PrimaryButton, SecondaryButton, IconButton
    │       ├── TextFields/      # StandardTextField, OTPTextField
    │       ├── Cards/           # ServiceCard
    │       └── Common/          # LoadingView, EmptyStateView, ErrorView
    ├── Models/                  # Data models
    │   ├── User.swift           # User, Address, PhoneVerification
    │   ├── Service.swift        # Service, ServiceCategory, ServiceReview
    │   ├── Provider.swift       # Provider, ProviderReview, Availability
    │   └── Booking.swift        # Booking, Payment, TimeSlot, PromoCode
    ├── ViewModels/              # MVVM ViewModels
    │   ├── AuthViewModel.swift
    │   ├── HomeViewModel.swift
    │   ├── ServiceDetailViewModel.swift
    │   ├── BookingViewModel.swift
    │   ├── OrdersViewModel.swift
    │   └── ProfileViewModel.swift
    └── Views/                   # SwiftUI Views
        ├── Main/
        │   └── MainTabView.swift
        ├── Authentication/      # Splash, Onboarding, Phone, OTP, Profile Setup
        ├── Home/               # Home, Categories, Service Detail, Search
        ├── Booking/            # 4-step booking flow
        ├── Orders/             # Active & past bookings
        └── Profile/            # Profile management & settings
```

## Development Commands

### iOS Development

**Prerequisites**: Xcode 15.0+, macOS 14.0+, iOS 17.0+

**Opening the Project:**
```bash
# Open in Xcode
open CityServe.xcodeproj

# Or from current directory
xed .
```

**In Xcode:**
- Build: `Cmd+B`
- Run: `Cmd+R`
- Clean: `Cmd+Shift+K`
- Clean Build Folder: `Cmd+Shift+Option+K`
- Run Tests: `Cmd+U`
- Show Console: `Cmd+Shift+Y`

**Command Line:**
```bash
# Build for iOS simulator (Debug)
xcodebuild -scheme CityServe -configuration Debug -sdk iphonesimulator build

# Run tests
xcodebuild -scheme CityServe test -destination 'platform=iOS Simulator,name=iPhone 15'

# Build for release
xcodebuild -scheme CityServe -configuration Release -sdk iphoneos build

# List available destinations
xcodebuild -scheme CityServe -showdestinations

# Clean build artifacts
xcodebuild clean -scheme CityServe
```

**Running in Simulator:**
```bash
# List available simulators
xcrun simctl list devices available

# Boot a specific simulator
xcrun simctl boot "iPhone 15"

# Install and run the app
xcodebuild -scheme CityServe -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Future Platform Commands

**Android, Backend, and Web** platforms are planned but not yet implemented. See documentation in `docs/` for specifications.

## Code Architecture

### iOS Architecture (MVVM + Clean Architecture)

**Architecture Pattern**: MVVM with Clean Architecture principles
- **Model**: Data structures and business logic
- **View**: SwiftUI views (declarative UI)
- **ViewModel**: ObservableObject classes with @Published properties

**Data Flow**:
```
User Action → View → ViewModel (via methods)
                        ↓
                   Business Logic
                        ↓
                   Update @Published properties
                        ↓
                   View auto-updates
```

**Key iOS Technologies**:
- **UI Framework**: SwiftUI (iOS 17.0+)
- **Reactive**: Combine framework (@Published, @StateObject, @EnvironmentObject)
- **Navigation**: NavigationStack (modern approach)
- **Async**: async/await for asynchronous operations
- **State Management**: @State, @Binding, @StateObject, @EnvironmentObject
- **Animations**: Built-in SwiftUI animations + custom transitions
- **Haptics**: UIImpactFeedbackGenerator, UINotificationFeedbackGenerator

**Current Implementation Status**:
- ✅ Complete Design System (Colors, Typography, Spacing, Shadows, Animations, Haptics)
- ✅ Type-safe Localization System (ready for multi-language support)
- ✅ 10 Reusable UI Components (Buttons, TextFields, Cards, Common views)
- ✅ 5 Data Models (User, Service, Provider, Booking, Help)
- ✅ 8 ViewModels (Auth, Home, ServiceDetail, Booking, Orders, Profile, HelpCenter, ContactSupport, Chat)
- ✅ 35+ SwiftUI Views across 6 major flows
- ✅ Mock data for testing (Firebase Auth is live, other features use mock data)
- ✅ Dark mode support
- ✅ Accessibility labels

**Component Library**:
See `CityServe/Core/Components/README.md` for detailed component usage guide.

**Design System**:
See `docs/design/DESIGN_SYSTEM.md` for complete design specifications.

### Design System Integration

All components use centralized design tokens:

```swift
// Colors
Color.primary          // Deep Teal #0D7377
Color.secondary        // Warm Orange #FF6B35
Color.textPrimary      // #1E1E1E (light mode)

// Typography
.h1Style()             // 32pt Bold
.h2Style()             // 24pt SemiBold
.bodyStyle()           // 14pt Regular

// Spacing (8pt grid)
Spacing.xs             // 8pt
Spacing.md             // 16pt
Spacing.lg             // 24pt
Spacing.screenPadding  // 16pt

// Shadows
.cardShadow()          // Level 1
.buttonShadow()        // Level 2

// Animations
Animations.buttonTap   // 100ms spring
Animations.pageTransition // 300ms ease-in-out
```

## Current Implementation Details

### Data Architecture (Hybrid Approach)

The app uses a **hybrid approach** - Firebase Auth is live, but most features still use mock data:

```swift
// Authentication - Uses REAL Firebase
func sendOTP() async {
    let formattedPhone = "+91\(phoneNumber)"
    let verificationID = try await authService.sendOTP(to: formattedPhone)
    // Real SMS sent via Firebase
}

// Other features - Still use mock data (ready to migrate)
func loadServices() async {
    isLoading = true
    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
    services = MockData.services  // TODO: Replace with Firestore
    isLoading = false
}
```

**Live Firebase data**:
- ✅ User authentication (phone OTP)
- ✅ User profiles in Firestore

**Mock data (ready to migrate)**:
- Services and categories
- Providers
- Bookings
- Promo codes
- Time slots
- Payment methods

### Navigation Patterns

The app uses **NavigationStack** for modern SwiftUI navigation:

```swift
// Tab-based navigation
MainTabView (4 tabs)
  ├── Home
  ├── Explore (Service Categories)
  ├── Orders
  └── Profile

// Deep navigation with NavigationStack
NavigationStack {
    HomeView()
        .navigationDestination(for: Service.self) { service in
            ServiceDetailView(service: service)
        }
}
```

### State Management Patterns

**ViewModel Pattern**:
```swift
class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func signIn(phone: String) async {
        // Business logic
    }
}
```

**Environment Injection**:
```swift
@main
struct CityServeApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
```

### Firebase Integration

**Phase 1 - Completed ✅**:
- ✅ Firebase Authentication (Phone number auth working)
- ✅ Service layer created (FirebaseAuthService, FirestoreService, FirebaseStorageService)
- ✅ AuthViewModel migrated from mock to real Firebase
- ✅ User registration saves to Firestore
- ⚠️ **IMPORTANT**: The app currently has Firebase commented out in CityServeApp.swift (line 9, 18). You must:
  1. Replace `GoogleService-Info.plist` with real Firebase credentials
  2. Uncomment `import Firebase` in CityServeApp.swift
  3. Uncomment `FirebaseApp.configure()` in the init method
  4. Ensure Firebase SDK is properly integrated via Swift Package Manager

**Phase 2 - Ready to implement**:
- Firestore Database (services, bookings, providers)
- Real-time listeners for bookings
- Cloud Functions (backend APIs)
- Cloud Storage (profile photos, service images)
- Cloud Messaging (push notifications)
- Crashlytics (crash reporting)

See `FIREBASE_INTEGRATION_COMPLETE.md` for detailed integration status.

## Implemented Features (iOS Customer App)

### ✅ Authentication Flow
- Splash screen with animated logo
- 3-page onboarding carousel
- Phone number registration (India format)
- 6-digit OTP verification with timer
- Profile setup (name, email, city)
- Session management

### ✅ Service Discovery
- Browse service categories
- View service details with pricing & reviews
- Search services
- Filter by price range, rating, availability
- Sort by price, rating, popularity
- View provider profiles
- Read service reviews

### ✅ Booking Flow (4 Steps)
- **Step 1**: Address selection (select existing or add new)
- **Step 2**: Date & time slot selection
- **Step 3**: Booking summary with promo code
- **Step 4**: Payment method selection
- Booking confirmation screen

### ✅ Orders Management
- View active bookings (pending, confirmed, in-progress)
- View past bookings (completed, cancelled)
- Booking detail with status timeline
- Cancel booking (with confirmation)
- Reschedule booking
- Rate and review completed services

### ✅ Profile & Settings
- View and edit profile
- Manage saved addresses (CRUD operations)
- Set default address
- Notification preferences
- Logout with confirmation

## Data Models

The iOS app uses Swift structs that mirror the planned Firestore schema:

```swift
// User.swift
struct User: Identifiable, Codable {
    let id: String
    var name: String
    var email: String
    var phoneNumber: String
    var profileImageURL: String?
    var addresses: [Address]
    // ...
}

// Service.swift
struct Service: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let categoryId: String
    let basePrice: Double
    let rating: Double
    let reviewCount: Int
    // ...
}

// Booking.swift
struct Booking: Identifiable, Codable {
    let id: String
    let serviceId: String
    let customerId: String
    let providerId: String?
    let status: BookingStatus
    let scheduledDate: Date
    let totalAmount: Double
    // ...
}
```

See `docs/DATABASE_SCHEMA.md` for complete Firestore schema design.

## Firebase Configuration (IMPORTANT!)

### First-Time Setup

Before running the app, you MUST configure Firebase:

1. **Create Firebase Project**:
   ```
   - Go to https://console.firebase.google.com
   - Create a new project: "CityServe-Dev"
   - Add iOS app with your Bundle ID
   ```

2. **Download Configuration**:
   ```
   - Download GoogleService-Info.plist from Firebase Console
   - Replace the placeholder file in CityServe/GoogleService-Info.plist
   - NEVER commit real credentials to git (.gitignore protects this)
   ```

3. **Enable Phone Authentication**:
   ```
   - Firebase Console → Authentication → Sign-in method
   - Enable "Phone" provider
   - Add test phone numbers if needed
   ```

4. **Create Firestore Database**:
   ```
   - Firebase Console → Firestore Database
   - Create database (start in test mode)
   - Set up security rules (see docs/DATABASE_SCHEMA.md)
   ```

5. **Test Authentication**:
   ```
   - Build and run on a REAL device (phone auth doesn't work well on simulator)
   - Try phone registration flow end-to-end
   - Check Firestore for user document
   ```

See `FIREBASE_INTEGRATION_COMPLETE.md` for detailed troubleshooting.

## Common Development Tasks

### Adding a New SwiftUI View

1. **Create the View file**:
   ```bash
   # Location: CityServe/Views/{Feature}/{ScreenName}View.swift
   ```

2. **Basic structure**:
   ```swift
   import SwiftUI

   struct MyNewView: View {
       @StateObject private var viewModel = MyViewModel()

       var body: some View {
           VStack {
               // Your UI here
           }
           .navigationTitle("Screen Title")
       }
   }

   #Preview {
       MyNewView()
   }
   ```

3. **Add navigation** in parent view:
   ```swift
   NavigationLink(value: myItem) {
       Text("Go to new screen")
   }
   .navigationDestination(for: MyItem.self) { item in
       MyNewView(item: item)
   }
   ```

### Adding a New Component

1. Create file in `CityServe/Core/Components/{Category}/`
2. Follow design system patterns (Colors, Typography, Spacing)
3. Add SwiftUI preview for testing
4. Document in `Core/Components/README.md`

### Modifying a Data Model

1. **Update the struct** in `CityServe/Models/{ModelName}.swift`
2. **Update mock data** if used for testing
3. **Update affected ViewModels** that use the model
4. **Update corresponding Views** if UI changes needed

### Adding Mock Data

Mock data is defined in the model files:

```swift
// In Service.swift
extension Service {
    static let mockACRepair = Service(
        id: "srv_001",
        name: "AC Repair & Service",
        // ...
    )
}
```

### Debugging in Xcode

**Console Logging**:
```swift
print("Debug: \(variable)")
dump(complexObject)  // Pretty print
```

**Breakpoints**:
- Click line number to add breakpoint
- Use `po variableName` in debugger console
- Add conditional breakpoints for specific cases

**SwiftUI Previews**:
```swift
#Preview {
    MyView()
}

#Preview("Dark Mode") {
    MyView()
        .preferredColorScheme(.dark)
}

#Preview("With Data") {
    MyView(service: Service.mockACRepair)
}
```

## Important Development Guidelines

### SwiftUI Best Practices

1. **Always use Design System components** instead of creating custom ones
2. **Use @StateObject for ViewModels** (created once), @ObservedObject for passed instances
3. **Prefer async/await** over Combine publishers for async operations
4. **Use NavigationStack** instead of deprecated NavigationView
5. **Add SwiftUI Previews** to every view for rapid development
6. **Follow MVVM pattern** - keep Views simple, logic in ViewModels
7. **Use type-safe localization** - Always use `Strings.*` enum instead of hardcoded strings:
   ```swift
   // Good
   Text(Strings.Auth.phoneTitle)

   // Bad
   Text("Enter Phone Number")
   ```

### Code Organization

- **Views**: UI only, minimal logic
- **ViewModels**: Business logic, state management, data operations
- **Models**: Data structures, conform to Codable for serialization
- **Components**: Reusable UI elements in `Core/Components/`
- **DesignSystem**: Centralized colors, typography, spacing, animations, haptics
- **Localization**: Type-safe strings in `Core/Localization/Strings.swift`
- **Firebase**: Service layer for backend integration in `Core/Firebase/`

### Naming Conventions

```swift
// Views
struct HomeView: View { }          // Screen views end with "View"
struct PrimaryButton: View { }      // Components are descriptive

// ViewModels
class HomeViewModel: ObservableObject { }  // End with "ViewModel"

// Models
struct Service: Identifiable { }    // Domain objects

// Properties
@Published var isLoading = false    // Clear, descriptive names
@State private var selectedTab = 0  // Use private for local state
```

### Performance Tips

1. Use `LazyVStack` / `LazyVGrid` for long lists
2. Avoid expensive operations in view body
3. Use `@StateObject` properly to avoid recreation
4. Profile with Instruments to find bottlenecks
5. Minimize view redraw with `equatable` conformance

## Documentation

### Key Documentation Files

- **APP_IMPLEMENTATION_SUMMARY.md**: Complete implementation overview
- **FIREBASE_INTEGRATION_COMPLETE.md**: Firebase integration status and guide
- **NAMING.md**: Brand strategy and naming
- **docs/DESIGN_SYSTEM.md**: Design specifications
- **docs/COMPONENT_LIBRARY.md**: Component usage guide
- **docs/DATABASE_SCHEMA.md**: Firestore data model
- **docs/API_SPEC.md**: Backend API spec
- **CityServe/Core/Components/README.md**: Component library reference
- **.claude/agents/README.md**: Specialized AI agents documentation

### External Resources

- **SwiftUI**: https://developer.apple.com/documentation/swiftui
- **Human Interface Guidelines**: https://developer.apple.com/design/human-interface-guidelines
- **Combine**: https://developer.apple.com/documentation/combine
- **Firebase iOS**: https://firebase.google.com/docs/ios/setup
- **Firebase Auth**: https://firebase.google.com/docs/auth/ios/phone-auth

## Brand Guidelines

**App Name**: UrbanNest
**Tagline**: "Trusted services, delivered smartly"
**Primary Color**: Deep Teal (#0D7377)
**Secondary Color**: Warm Orange (#FF6B35)
**Typography**: Inter (headings), SF Pro (body)
**Design Language**: Modern, clean, approachable

See `NAMING.md` and `docs/design/DESIGN_SYSTEM.md` for complete guidelines.

## Current Status

**iOS Customer App MVP** - ✅ Complete + Firebase Auth Ready 🔥
- ✅ Full authentication flow implemented (Phone OTP)
- ✅ Firebase service layer created and ready
- ✅ Type-safe localization system implemented
- ✅ Service discovery & search functional (mock data)
- ✅ Complete 4-step booking flow (mock data)
- ✅ Orders management with tracking (mock data)
- ✅ Profile & settings complete
- ✅ Help center and contact support views
- ✅ Design system & component library ready
- ✅ 12 specialized Claude Code agents configured

**Next Steps**:
1. **CRITICAL**: Enable Firebase integration:
   - Replace GoogleService-Info.plist with real credentials
   - Uncomment Firebase imports and initialization in CityServeApp.swift
   - Add Firebase SDK via Swift Package Manager if not already added
2. Migrate remaining features to Firebase (Services, Bookings, Orders)
3. Implement real-time listeners for bookings
4. Add localization files (.strings) for multi-language support
5. Implement Razorpay payment integration
6. Add real-time location tracking
7. Implement push notifications (FCM)
8. Add unit and UI tests
9. Deploy to TestFlight for beta testing

## Specialized Agents

This project includes 12 specialized Claude Code agents that automatically help with common tasks:

- **security-auditor**: Security vulnerability detection and OWASP compliance (use before production!)
- **performance-optimizer**: App performance analysis and optimization (launch time, memory, battery)
- **api-integrator**: REST API & third-party service integration (Razorpay, Google Maps, FCM)
- **data-migrator**: Migrate mock data to Firebase/Firestore
- **ui-animator**: SwiftUI animations, transitions, and gesture interactions
- **firebase-integrator**: Firebase setup and backend integration
- **ios-builder**: Build errors and compilation fixes
- **swiftui-reviewer**: SwiftUI code review and best practices
- **viewmodel-expert**: MVVM architecture and Combine patterns
- **ios-debugger**: Runtime debugging and crash analysis
- **test-runner**: Test execution and failure analysis
- **design-enforcer**: Design system compliance checking

See `.claude/agents/README.md` for detailed usage.

---

**Last Updated**: January 1, 2026
**Version**: 1.0 MVP
**Platform**: iOS (SwiftUI)
**Firebase Status**: Phase 1 Complete (Auth ✅) | Phase 2 Ready (Data Migration)
**Status**: ✅ MVP Complete + Firebase Auth Working
