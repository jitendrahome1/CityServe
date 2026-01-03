# Firebase Configuration Files

This directory contains Firebase configuration files for different environments.

## Setup Instructions

You need to create **three separate Firebase projects** in the Firebase Console:

### 1. Development Project
- Project name: `CityServe-Dev` (or `UrbanNest-Dev`)
- Download `GoogleService-Info.plist`
- Rename to `GoogleService-Info-Dev.plist`
- Place in this directory

### 2. Staging Project
- Project name: `CityServe-Staging` (or `UrbanNest-Staging`)
- Download `GoogleService-Info.plist`
- Rename to `GoogleService-Info-Staging.plist`
- Place in this directory

### 3. Production Project
- Project name: `CityServe-Production` (or `UrbanNest`)
- Download `GoogleService-Info.plist`
- Rename to `GoogleService-Info-Production.plist`
- Place in this directory

## File Structure

```
Firebase/
├── README.md (this file)
├── GoogleService-Info-Dev.plist
├── GoogleService-Info-Staging.plist
└── GoogleService-Info-Production.plist
```

## Important Notes

- **NEVER** commit these files to git (they're in .gitignore)
- Each environment should have its own Firebase project for proper isolation
- The build script automatically copies the correct file based on the selected scheme
- Make sure to enable Phone Authentication in each Firebase project

## Firebase Project Configuration

For each Firebase project, you need to:

1. **Enable Authentication**
   - Go to Authentication → Sign-in method
   - Enable "Phone" provider
   - Add your app's App Store ID (for production)

2. **Create Firestore Database**
   - Go to Firestore Database
   - Create database (start in test mode, then add security rules)

3. **Enable Storage** (for profile photos, service images)
   - Go to Storage
   - Get started with default security rules

4. **Add iOS App**
   - Bundle ID: `com.urbanest.app` (same for all environments)
   - Download the GoogleService-Info.plist
   - Rename according to environment

## Testing

To verify the correct configuration is loaded:

1. Run the app with different schemes (Dev/Staging/Production)
2. Check the Firebase Console to see which project receives the authentication requests
3. Look for the app name in the title bar:
   - Dev: "UrbanNest DEV"
   - Staging: "UrbanNest STAGING"
   - Production: "UrbanNest"
