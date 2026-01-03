# Multi-Scheme Setup Guide for CityServe

This guide will walk you through setting up three schemes (Dev, Staging, Production) for the CityServe iOS app.

## Overview

The project is now configured with:
- ✅ 3 xcconfig files (Dev.xcconfig, Staging.xcconfig, Production.xcconfig)
- ✅ Firebase configuration directory structure
- ✅ Build script to copy correct GoogleService-Info.plist
- ✅ Dynamic app display names per environment

## Step-by-Step Setup in Xcode

### Step 1: Open the Project in Xcode

```bash
open CityServe.xcodeproj
```

### Step 2: Add xcconfig Files to Project

1. In Xcode, right-click on the `CityServe` folder in Project Navigator
2. Select "Add Files to CityServe..."
3. Navigate to `CityServe/Config/`
4. Select all three `.xcconfig` files (Dev.xcconfig, Staging.xcconfig, Production.xcconfig)
5. Make sure "Copy items if needed" is **unchecked** (files are already in the right place)
6. Click "Add"

### Step 3: Create Build Configurations

1. Click on the project name at the top of Project Navigator
2. Select the project (not the target) in the editor
3. Go to the "Info" tab
4. Under "Configurations", you'll see "Debug" and "Release"
5. Click the "+" button at the bottom of Configurations section

Create these configurations by duplicating:

**Duplicate Debug to create:**
- `Debug-Dev` (duplicate Debug)
- `Debug-Staging` (duplicate Debug)
- `Debug-Production` (duplicate Debug)

**Duplicate Release to create:**
- `Release-Dev` (duplicate Release)
- `Release-Staging` (duplicate Release)
- `Release-Production` (duplicate Release)

**Final configuration list should be:**
```
Debug (you can keep or delete this)
Debug-Dev
Debug-Staging
Debug-Production
Release (you can keep or delete this)
Release-Dev
Release-Staging
Release-Production
```

### Step 4: Assign xcconfig Files to Configurations

1. Still in the "Info" tab under "Configurations"
2. Expand each configuration row
3. For the **CityServe target** (not the project), assign:

| Configuration | Configuration File |
|--------------|-------------------|
| Debug-Dev | Dev |
| Debug-Staging | Staging |
| Debug-Production | Production |
| Release-Dev | Dev |
| Release-Staging | Staging |
| Release-Production | Production |

4. Click the dropdown next to each configuration and select the appropriate xcconfig file

### Step 5: Create Schemes

1. Go to **Product → Scheme → Manage Schemes** (or click the scheme dropdown in toolbar)
2. Click the "+" button to add a new scheme

**Create Dev Scheme:**
1. Name: `CityServe-Dev`
2. Target: `CityServe`
3. Click "Close"
4. Select the newly created scheme and click "Edit"
5. For each action (Run, Test, Profile, Analyze, Archive):
   - **Run**: Build Configuration = `Debug-Dev`
   - **Test**: Build Configuration = `Debug-Dev`
   - **Profile**: Build Configuration = `Release-Dev`
   - **Analyze**: Build Configuration = `Debug-Dev`
   - **Archive**: Build Configuration = `Release-Dev`
6. Click "Close"

**Create Staging Scheme:**
1. Repeat the above steps with:
   - Name: `CityServe-Staging`
   - Debug actions use `Debug-Staging`
   - Release actions use `Release-Staging`

**Create Production Scheme:**
1. Repeat the above steps with:
   - Name: `CityServe-Production`
   - Debug actions use `Debug-Production`
   - Release actions use `Release-Production`

### Step 6: Add Build Script Phase

This script copies the correct Firebase configuration file based on the selected scheme.

1. Click on the **CityServe target** (not the project)
2. Go to "Build Phases" tab
3. Click "+" at the top left
4. Select "New Run Script Phase"
5. Drag the new script phase to be **BEFORE** "Copy Bundle Resources"
6. Name it: `Copy Firebase Config`
7. In the script box, add:

```bash
bash "${SRCROOT}/CityServe/Scripts/copy-firebase-config.sh"
```

8. Click on "Show environment variables from build settings" triangle (optional, for debugging)

### Step 7: Add Firebase Config Files

1. In Xcode, right-click on the `CityServe/Firebase` folder
2. Select "Add Files to CityServe..."
3. Add the `README.md` file (already created)
4. Create three separate Firebase projects in Firebase Console:
   - CityServe-Dev
   - CityServe-Staging
   - CityServe-Production
5. Download each `GoogleService-Info.plist` and rename:
   - `GoogleService-Info-Dev.plist`
   - `GoogleService-Info-Staging.plist`
   - `GoogleService-Info-Production.plist`
6. Place them in the `CityServe/Firebase/` directory
7. **IMPORTANT**: These files should NOT be added to the Xcode project target membership
8. The build script will copy the correct one at build time

### Step 8: Add Scripts Folder to Project

1. In Xcode, right-click on the `CityServe` folder
2. Select "Add Files to CityServe..."
3. Navigate to `CityServe/Scripts/`
4. Select the folder and click "Add"
5. Make sure "Create folder references" is selected (not "Create groups")

### Step 9: Update .gitignore

Add these lines to your `.gitignore` file if not already present:

```
# Firebase configs (keep these secret!)
CityServe/Firebase/GoogleService-Info-*.plist

# Don't ignore the README
!CityServe/Firebase/README.md

# Config directory is OK to commit
!CityServe/Config/*.xcconfig
```

## Testing the Setup

### Test 1: Verify Scheme Selection

1. In Xcode toolbar, click the scheme dropdown (next to the run button)
2. You should see three schemes:
   - CityServe-Dev
   - CityServe-Staging
   - CityServe-Production

### Test 2: Verify App Display Names

1. Select `CityServe-Dev` scheme
2. Run the app (Cmd+R)
3. Check the app name on the simulator home screen: Should say "**UrbanNest DEV**"
4. Stop the app
5. Select `CityServe-Staging` scheme
6. Run the app
7. Check the app name: Should say "**UrbanNest STAGING**"
8. Stop the app
9. Select `CityServe-Production` scheme
10. Run the app
11. Check the app name: Should say "**UrbanNest**"

All three app versions should be installed simultaneously on the simulator/device!

### Test 3: Verify Firebase Configuration

1. Select a scheme (e.g., Dev)
2. Build the project (Cmd+B)
3. Check the build log for: `✅ Successfully copied GoogleService-Info-Dev.plist to app bundle`
4. If you see errors, check that the Firebase config files exist in `CityServe/Firebase/`

### Test 4: Verify Environment Flags

In your code, you can now use:

```swift
#if DEV
    print("Running in Development environment")
#elseif STAGING
    print("Running in Staging environment")
#elseif PRODUCTION
    print("Running in Production environment")
#endif
```

Or access the environment at runtime:

```swift
// Add this to a config file
struct AppConfig {
    static var environment: String {
        #if DEV
        return "Development"
        #elseif STAGING
        return "Staging"
        #elseif PRODUCTION
        return "Production"
        #else
        return "Unknown"
        #endif
    }

    static var apiBaseURL: String {
        #if DEV
        return "https://dev-api.urbanest.app"
        #elseif STAGING
        return "https://staging-api.urbanest.app"
        #elseif PRODUCTION
        return "https://api.urbanest.app"
        #else
        return ""
        #endif
    }
}
```

## Common Issues and Solutions

### Issue 1: Build script fails with "Firebase config file not found"

**Solution:**
- Ensure you've created the three Firebase projects
- Download the `GoogleService-Info.plist` files
- Rename them correctly (GoogleService-Info-Dev.plist, etc.)
- Place them in `CityServe/Firebase/` directory
- Make sure they're NOT added to target membership (should not have checkmark in Xcode)

### Issue 2: App still shows old name after switching schemes

**Solution:**
- Clean build folder (Cmd+Shift+K)
- Delete the app from simulator/device
- Build and run again

### Issue 3: xcconfig settings not being applied

**Solution:**
- Make sure you assigned the xcconfig files to the **target** not the project
- Check that there are no conflicting build settings in the target that override xcconfig
- Try setting the build settings to "$(inherited)" in the target if needed

### Issue 4: Multiple app installations overwrite each other

**Solution:**
- If you want to install all three versions simultaneously, change the bundle identifiers:
  - Dev: `com.urbanest.app.dev`
  - Staging: `com.urbanest.app.staging`
  - Production: `com.urbanest.app`
- Update the `APP_BUNDLE_ID` in each xcconfig file
- You mentioned wanting the same bundle ID, but note that this means only one can be installed at a time

### Issue 5: Scheme not showing correct configuration

**Solution:**
- Edit the scheme (Product → Scheme → Edit Scheme)
- Verify each action (Run, Test, Archive, etc.) uses the correct configuration
- Make sure "Build Configuration" dropdown shows the right config for each action

## Next Steps

1. ✅ Complete the Xcode setup steps above
2. 🔥 Create three Firebase projects and add config files
3. 📱 Test all three schemes
4. 🎨 (Optional) Create different app icons for Dev/Staging with badges
5. 🔔 Set up different Firebase Cloud Messaging sender IDs per environment
6. 📊 Configure different analytics tracking IDs per environment

## Files Created

```
CityServe/
├── Config/
│   ├── Dev.xcconfig
│   ├── Staging.xcconfig
│   └── Production.xcconfig
├── Firebase/
│   ├── README.md
│   ├── GoogleService-Info-Dev.plist (you need to create)
│   ├── GoogleService-Info-Staging.plist (you need to create)
│   └── GoogleService-Info-Production.plist (you need to create)
└── Scripts/
    └── copy-firebase-config.sh
```

## Additional Resources

- [Xcode Build Configuration Files](https://nshipster.com/xcconfig/)
- [Managing Different Environments in iOS](https://www.appcoda.com/xcconfig-guide/)
- [Firebase iOS Setup](https://firebase.google.com/docs/ios/setup)

---

**Note**: After completing the setup, you'll be able to easily switch between Dev, Staging, and Production environments just by selecting the appropriate scheme in Xcode. Each environment will have its own Firebase project, display name, and configuration settings!
