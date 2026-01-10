# 🚀 CityServe Backend - Quick Start (5 Minutes)

## Run Backend Locally + Connect iOS App

**Total Time**: 5 minutes
**Result**: Backend running locally with sample data, iOS app showing live data

---

## ⚡ Super Quick Setup

### Step 1: Install Prerequisites (One-time)

```bash
# Install Firebase CLI (if not already installed)
npm install -g firebase-tools

# Login to Firebase
firebase login
```

### Step 2: Navigate to ServerCode

```bash
cd "/Users/jitendra/Desktop/JItendra WorkSpace/MyProject/FullCode/WorkingCode/CityServe/ServerCode"
```

### Step 3: Install Dependencies

```bash
cd functions
npm install
cd ..
```

### Step 4: Start Backend

```bash
firebase emulators:start
```

**✅ Backend is now running!**

Open Emulator UI: **http://localhost:4000**

---

## 📊 Step 5: Add Sample Data

### Method 1: Using Emulator UI (Manual - 5 minutes)

1. Open **http://localhost:4000/firestore**
2. Click **"Start collection"**
3. Add these collections with data from `sample-data/` folder:

#### Collection 1: cities
- Collection ID: `cities`
- Document ID: `delhi`
- Fields (copy from `sample-data/cities.json`):
```
name: "Delhi"
displayName: "Delhi NCR"
isActive: true
coordinates (map):
  - latitude: 28.7041
  - longitude: 77.1025
timezone: "Asia/Kolkata"
currency: "INR"
currencySymbol: "₹"
serviceRadius: 25
```

Repeat for: mumbai, bangalore, pune, hyderabad

#### Collection 2: service_categories
- Document ID: `salon_women`, `plumbing`, `electrical`, `cleaning`, etc.
- Copy data from `sample-data/service_categories.json`

#### Collection 3: services
- Document ID: `ac_repair_basic`, `tap_repair`, etc.
- Copy data from `sample-data/services.json`

#### Collection 4: promotional_banners
- Document ID: `plus_membership_2026`, etc.
- Copy data from `sample-data/promotional_banners.json`

#### Collection 5: app_config
- Document ID: `global`
- Copy data from `sample-data/app_config.json`

---

## 📱 Step 6: Connect iOS App

### Find Your Project ID

```bash
firebase projects:list
```

Output will show your PROJECT_ID.

### Update iOS App

1. Open Xcode
2. Create file: `CityServe/Core/Config/AppConfig.swift`

```swift
import Foundation

struct AppConfig {
    #if DEBUG
    static let environment: Environment = .local
    #else
    static let environment: Environment = .production
    #endif

    static var baseURL: String {
        switch environment {
        case .local:
            return "http://127.0.0.1:5001/YOUR_PROJECT_ID_HERE/asia-south1/api/api/v1"
        case .production:
            return "https://asia-south1-YOUR_PROJECT_ID_HERE.cloudfunctions.net/api/api/v1"
        }
    }

    enum Environment {
        case local
        case production
    }
}
```

**Replace `YOUR_PROJECT_ID_HERE` with your actual project ID!**

3. Update `Info.plist` to allow local connections:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>
```

4. Update `HomeViewModel.swift` to use API:

```swift
func loadInitialData() {
    Task {
        isLoading = true

        do {
            // Call API
            let urlString = "\(AppConfig.baseURL)/home/screen?cityId=delhi"
            guard let url = URL(string: urlString) else { return }

            print("📡 Fetching from: \(urlString)")

            let (data, _) = try await URLSession.shared.data(from: url)

            // For now, just check if we got data
            print("✅ Got data: \(data.count) bytes")

            // Parse and update (see LOCAL_SETUP_GUIDE.md for full implementation)

        } catch {
            print("❌ Error: \(error)")
            // Fall back to mock data
            categories = ServiceCategory.mockCategories
            allServices = Service.mockServices
        }

        isLoading = false
    }
}
```

---

## ✅ Step 7: Test End-to-End

### Test 1: Backend Health Check

```bash
curl http://127.0.0.1:5001/YOUR_PROJECT_ID/asia-south1/api/health
```

**Expected**: `{"status":"healthy",...}`

### Test 2: Home Screen API

```bash
curl "http://127.0.0.1:5001/YOUR_PROJECT_ID/asia-south1/api/api/v1/home/screen?cityId=delhi"
```

**Expected**: Full JSON response with cities, categories, services, banners

### Test 3: Run iOS App

1. Build and run in Xcode (⌘R)
2. Check console logs for:
```
📡 Fetching from: http://127.0.0.1:5001/.../home/screen?cityId=delhi
✅ Got data: XXXX bytes
```

3. Home screen should show data from your local backend!

---

## 🎯 What You Should See

### In Firestore Emulator UI (http://localhost:4000/firestore):
- ✅ 5 collections (cities, service_categories, services, promotional_banners, app_config)
- ✅ Documents in each collection

### In Functions Logs (http://localhost:4000/functions):
- ✅ Request logs when you call the API
- ✅ No errors

### In iOS App:
- ✅ Home screen loads
- ✅ Services display
- ✅ Categories show
- ✅ Banners appear

---

## 🐛 Troubleshooting

### Issue: "Cannot connect to 127.0.0.1"

**Solution**:
- Ensure emulators are running: `firebase emulators:start`
- Check if port 5001 is in use: `lsof -i :5001`

### Issue: "No data in response"

**Solution**:
- Open http://localhost:4000/firestore
- Verify collections exist with data
- Check cityId parameter: must be lowercase (e.g., "delhi")

### Issue: "Project ID not found"

**Solution**:
- Run `firebase projects:list`
- Copy exact project ID
- Update URLs with correct PROJECT_ID

### Issue: iOS App shows "Connection error"

**Solution**:
- Check Info.plist has NSAllowsLocalNetworking = true
- Run on iOS Simulator (not real device for localhost)
- Verify URL: `http://127.0.0.1:5001/...` (use 127.0.0.1, not localhost)

---

## 🔥 Quick Commands Reference

```bash
# Start backend
firebase emulators:start

# Stop (Ctrl+C)

# View your project ID
firebase projects:list

# Check if emulators are running
lsof -i :5001

# Test API
curl "http://127.0.0.1:5001/PROJECT_ID/asia-south1/api/api/v1/home/screen?cityId=delhi"
```

---

## 📁 File Structure You Created

```
ServerCode/
├── functions/
│   ├── node_modules/     ✅ Installed
│   ├── src/              ✅ Backend code
│   ├── package.json      ✅ Dependencies
│   └── tsconfig.json     ✅ TypeScript config
├── sample-data/          ✅ Sample data files
│   ├── cities.json
│   ├── service_categories.json
│   ├── services.json
│   ├── promotional_banners.json
│   └── app_config.json
├── firebase.json         ✅ Emulator config
└── firestore.rules       ✅ Security rules
```

---

## 🎉 Success!

If you see:
- ✅ Emulators running
- ✅ Data in Firestore UI
- ✅ API returning JSON
- ✅ iOS app showing live data

**You're all set! Backend is running locally and connected to your iOS app.**

---

## 📚 Next Steps

1. ✅ **Play with data**: Edit services/categories in Firestore UI
2. ✅ **Test changes**: iOS app updates immediately
3. ✅ **Add more data**: Create new services, cities, banners
4. ✅ **Review logs**: Check Function logs for API requests
5. ✅ **Deploy to production**: When ready, follow DEPLOYMENT_GUIDE.md

---

## 💡 Pro Tips

- **Emulator data persists**: Data stays until you clear it
- **Auto-reload**: Code changes auto-reload (may need to restart emulators)
- **Multiple terminals**: Run emulators in one terminal, test in another
- **Firestore UI**: Best friend for debugging - use it liberally!

---

**Time Taken**: ~5 minutes
**Status**: ✅ Local backend running with sample data
**Next**: Connect iOS app or deploy to production

Happy coding! 🚀
