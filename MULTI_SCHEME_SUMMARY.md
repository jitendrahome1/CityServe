# Multi-Scheme Setup - Summary

✅ **Setup Complete!** Your project is now configured for multiple environments.

## What Was Created

### 1. Configuration Files (xcconfig)
Three build configuration files that define environment-specific settings:

- **`CityServe/Config/Dev.xcconfig`**
  - App Name: "UrbanNest DEV"
  - Environment: DEV
  - Firebase: GoogleService-Info-Dev.plist
  - API: dev-api.urbanest.app

- **`CityServe/Config/Staging.xcconfig`**
  - App Name: "UrbanNest STAGING"
  - Environment: STAGING
  - Firebase: GoogleService-Info-Staging.plist
  - API: staging-api.urbanest.app

- **`CityServe/Config/Production.xcconfig`**
  - App Name: "UrbanNest"
  - Environment: PRODUCTION
  - Firebase: GoogleService-Info-Production.plist
  - API: api.urbanest.app

### 2. Firebase Directory Structure
```
CityServe/Firebase/
├── README.md (setup instructions)
├── GoogleService-Info-Dev.plist (you need to add)
├── GoogleService-Info-Staging.plist (you need to add)
└── GoogleService-Info-Production.plist (you need to add)
```

### 3. Build Script
**`CityServe/Scripts/copy-firebase-config.sh`**
- Automatically copies the correct Firebase config based on selected scheme
- Validates that config files exist before building
- Provides helpful error messages if files are missing

### 4. App Configuration Helper
**`CityServe/Core/Config/AppConfig.swift`**
- Centralized configuration for environment detection
- Type-safe environment checking
- API URL configuration
- Feature flags (logging, analytics, crashlytics)
- Debug helpers

### 5. Documentation
- **`SCHEME_SETUP_GUIDE.md`** - Complete step-by-step Xcode setup instructions
- **`CityServe/Firebase/README.md`** - Firebase setup instructions
- **`MULTI_SCHEME_SUMMARY.md`** - This file

### 6. Updated .gitignore
Firebase configuration files are now properly ignored to prevent committing secrets.

## What You Need to Do Next

### Step 1: Complete Xcode Configuration (15-20 minutes)

Open **`SCHEME_SETUP_GUIDE.md`** and follow these steps:

1. ✅ Add xcconfig files to Xcode project
2. ✅ Create 6 build configurations (Debug/Release for Dev/Staging/Production)
3. ✅ Assign xcconfig files to configurations
4. ✅ Create 3 schemes (CityServe-Dev, CityServe-Staging, CityServe-Production)
5. ✅ Add build script phase to copy Firebase configs
6. ✅ Add Scripts and Firebase folders to project

### Step 2: Setup Firebase Projects (30 minutes)

Create three Firebase projects in the [Firebase Console](https://console.firebase.google.com):

1. **Development Project** (CityServe-Dev)
   - Download GoogleService-Info.plist
   - Rename to `GoogleService-Info-Dev.plist`
   - Place in `CityServe/Firebase/`

2. **Staging Project** (CityServe-Staging)
   - Download GoogleService-Info.plist
   - Rename to `GoogleService-Info-Staging.plist`
   - Place in `CityServe/Firebase/`

3. **Production Project** (CityServe-Production)
   - Download GoogleService-Info.plist
   - Rename to `GoogleService-Info-Production.plist`
   - Place in `CityServe/Firebase/`

For each project, enable:
- Authentication → Phone provider
- Firestore Database
- Storage (for images)

### Step 3: Test the Setup (5 minutes)

1. Select **CityServe-Dev** scheme in Xcode
2. Build and run (Cmd+R)
3. Check app name on home screen: "**UrbanNest DEV**"
4. Try phone authentication (should connect to Dev Firebase)

Repeat for Staging and Production schemes.

## How to Use Multiple Schemes

### Switching Environments

In Xcode:
1. Click the scheme dropdown (next to Run button)
2. Select the desired scheme:
   - **CityServe-Dev** - For local development
   - **CityServe-Staging** - For QA testing
   - **CityServe-Production** - For App Store releases

### In Your Code

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Show environment badge (Dev/Staging only)
            if AppConfig.showDebugUI {
                Text(AppConfig.environment.displayName)
                    .font(.caption)
                    .padding(4)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }

            // Your main UI
            Text("Welcome to \(AppConfig.appDisplayName)")
        }
        .onAppear {
            // Print configuration on launch (Dev/Staging only)
            AppConfig.printConfiguration()

            // Environment-specific logic
            if AppConfig.environment.isDevelopment {
                print("🔧 Running in development mode")
            }
        }
    }
}
```

### Environment-Specific API Calls

```swift
// Use the configured API base URL
let apiURL = URL(string: "\(AppConfig.apiBaseURL)/services")!

// Conditional logging
if AppConfig.isLoggingEnabled {
    print("API Request: \(apiURL)")
}

// Environment-specific behavior
#if DEV
    // Enable debug features
    let timeout: TimeInterval = 60
#elseif STAGING
    // Enable analytics but longer timeout
    let timeout: TimeInterval = 45
#else
    // Production - strict settings
    let timeout: TimeInterval = 30
#endif
```

### Compiler Flags

You can use these flags for compile-time environment checks:

```swift
#if DEV
    // Development-only code
    print("Debug: User tapped button")
#elseif STAGING
    // Staging-only code
    Analytics.track("button_tapped")
#elseif PRODUCTION
    // Production-only code
    Analytics.track("button_tapped")
    Crashlytics.log("User interaction")
#endif
```

## Benefits of This Setup

### ✅ Environment Isolation
- Each environment has its own Firebase project
- No risk of test data polluting production
- Separate user bases for testing

### ✅ Easy Testing
- Install all three versions on same device
- Visually distinguish environments by app name
- Switch between environments with one click

### ✅ Safe Development
- Test features in Dev without affecting Staging/Production
- QA can test in Staging while Dev continues work
- Production remains pristine

### ✅ Simplified Deployment
- Select Production scheme for App Store builds
- No manual config changes needed
- Build script ensures correct Firebase config

### ✅ Future-Ready
- Already configured for multiple API endpoints
- Ready for environment-specific feature flags
- Scalable to add more environments if needed

## File Structure Overview

```
CityServe/
├── SCHEME_SETUP_GUIDE.md          ← Step-by-step Xcode setup
├── MULTI_SCHEME_SUMMARY.md        ← This file
├── .gitignore                     ← Updated to protect Firebase configs
│
├── CityServe/
│   ├── Config/                    ← Build configurations
│   │   ├── Dev.xcconfig
│   │   ├── Staging.xcconfig
│   │   └── Production.xcconfig
│   │
│   ├── Firebase/                  ← Firebase configs (gitignored)
│   │   ├── README.md
│   │   ├── GoogleService-Info-Dev.plist (add this)
│   │   ├── GoogleService-Info-Staging.plist (add this)
│   │   └── GoogleService-Info-Production.plist (add this)
│   │
│   ├── Scripts/                   ← Build scripts
│   │   └── copy-firebase-config.sh
│   │
│   └── Core/
│       └── Config/
│           └── AppConfig.swift    ← Runtime configuration helper
```

## Common Use Cases

### Scenario 1: Local Development
1. Select **CityServe-Dev** scheme
2. Run on simulator or device
3. App shows "UrbanNest DEV"
4. Connects to Dev Firebase
5. Full logging enabled
6. No analytics tracking

### Scenario 2: QA Testing
1. Select **CityServe-Staging** scheme
2. Build for TestFlight or direct install
3. App shows "UrbanNest STAGING"
4. Connects to Staging Firebase
5. Logging enabled + Analytics tracking
6. QA can test production-like environment

### Scenario 3: App Store Release
1. Select **CityServe-Production** scheme
2. Archive for App Store (Product → Archive)
3. App shows "UrbanNest"
4. Connects to Production Firebase
5. No logging, full analytics
6. Crashlytics enabled

## Troubleshooting

### Problem: Build fails with "Firebase config file not found"
**Solution**: You haven't added the Firebase config files yet. Follow Step 2 above.

### Problem: App name doesn't change when switching schemes
**Solution**:
1. Clean build folder (Cmd+Shift+K)
2. Delete app from device/simulator
3. Build and run again

### Problem: Wrong Firebase project is being used
**Solution**:
1. Check that build script ran successfully in build log
2. Verify correct GoogleService-Info-*.plist file exists
3. Check scheme configuration uses correct build configuration

### Problem: Can't find schemes in Xcode
**Solution**: You need to complete the Xcode setup in `SCHEME_SETUP_GUIDE.md` first.

## Next Steps (Optional Enhancements)

### 1. Different App Icons
Add badges to Dev/Staging icons to visually distinguish them:
- Dev: Add "DEV" badge overlay
- Staging: Add "STAGING" badge overlay
- Production: Clean icon

### 2. Different Bundle IDs
If you want to install all three versions simultaneously:
- Update `APP_BUNDLE_ID` in each xcconfig:
  - Dev: `com.urbanest.app.dev`
  - Staging: `com.urbanest.app.staging`
  - Production: `com.urbanest.app`

### 3. CI/CD Integration
- Use schemes in Xcode Cloud or Fastlane
- Automate builds for each environment
- Deploy Dev to internal TestFlight
- Deploy Staging to external TestFlight
- Deploy Production to App Store

### 4. Environment-Specific Features
```swift
// In AppConfig.swift, add feature flags
static var enableBetaFeatures: Bool {
    environment == .development || environment == .staging
}

static var enableDebugMenu: Bool {
    !environment.isProduction
}
```

## Questions?

- **Xcode Setup**: See `SCHEME_SETUP_GUIDE.md`
- **Firebase Setup**: See `CityServe/Firebase/README.md`
- **Code Usage**: See `CityServe/Core/Config/AppConfig.swift` for examples

---

**Status**: ✅ Configuration Complete - Ready for Xcode Setup

**Estimated Time to Complete**:
- Xcode configuration: 15-20 minutes
- Firebase setup: 30 minutes
- Testing: 5 minutes
- **Total: ~50-55 minutes**

After completing the setup, you'll have a professional multi-environment iOS project! 🚀
