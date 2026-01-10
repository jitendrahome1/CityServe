# CityServe Backend - Local Development Setup

## 🎯 Quick Start - Run Backend Locally

This guide will help you run the backend on your local machine and connect it to your iOS app.

**Time Required**: 15 minutes

---

## 📋 Prerequisites

1. Node.js 18+ installed
2. Firebase CLI installed: `npm install -g firebase-tools`
3. Firebase project created (can be a test project)

---

## 🚀 Step-by-Step Local Setup

### Step 1: Install Java (Required for Firebase Emulators)

Firebase Emulators require Java 11 or higher.

```bash
# Check if Java is installed
java -version

# If not installed, download from:
# https://www.oracle.com/java/technologies/downloads/
# Or use Homebrew on Mac:
brew install openjdk@11
```

### Step 2: Navigate to Backend Directory

```bash
cd "/Users/jitendra/Desktop/JItendra WorkSpace/MyProject/FullCode/WorkingCode/CityServe/ServerCode"
```

### Step 3: Install Dependencies

```bash
cd functions
npm install
cd ..
```

### Step 4: Login to Firebase

```bash
firebase login
```

### Step 5: Initialize Firebase (if not done)

```bash
firebase init

# Select:
# - Functions: Configure
# - Firestore: Configure
# - Emulators: Configure
#
# Choose existing project or create new one
# Select TypeScript
# Use existing files (don't overwrite)
#
# Select Emulators:
# [x] Functions Emulator
# [x] Firestore Emulator
# [x] Authentication Emulator
#
# Use default ports or custom:
# - Functions: 5001
# - Firestore: 8080
# - Auth: 9099
```

### Step 6: Start Local Emulators

```bash
# Start all emulators
firebase emulators:start

# Or start specific emulators
firebase emulators:start --only functions,firestore,auth
```

**Expected Output:**
```
✔  functions[asia-south1-api]: http function initialized (http://127.0.0.1:5001/PROJECT_ID/asia-south1/api).

┌─────────────────────────────────────────────────────────────┐
│ ✔  All emulators ready! It is now safe to connect your app. │
│ i  View Emulator UI at http://127.0.0.1:4000                │
└─────────────────────────────────────────────────────────────┘

┌──────────┬────────────────┬─────────────────────────────────┐
│ Emulator │ Host:Port      │ View in Emulator UI             │
├──────────┼────────────────┼─────────────────────────────────┤
│ Auth     │ 127.0.0.1:9099 │ http://127.0.0.1:4000/auth      │
│ Functions│ 127.0.0.1:5001 │ http://127.0.0.1:4000/functions │
│ Firestore│ 127.0.0.1:8080 │ http://127.0.0.1:4000/firestore │
└──────────┴────────────────┴─────────────────────────────────┘
```

**✅ Your backend is now running locally!**

---

## 📊 Step 7: Seed Sample Data

### Option A: Using Emulator UI (Easiest)

1. Open Firestore Emulator UI: http://127.0.0.1:4000/firestore
2. Click "Start collection"
3. Add documents from the sample data files in `sample-data/` folder

### Option B: Using Import Script (Automated)

I'll create a script for you:

```bash
# In ServerCode directory
node scripts/seed-local-data.js
```

---

## 🧪 Step 8: Test Local Backend

### Test Health Check

```bash
curl http://127.0.0.1:5001/PROJECT_ID/asia-south1/api/health
```

**Expected Response:**
```json
{
  "status": "healthy",
  "service": "CityServe API",
  "version": "1.0.0",
  "timestamp": "2026-01-10T..."
}
```

### Test Home Screen API

```bash
curl "http://127.0.0.1:5001/PROJECT_ID/asia-south1/api/api/v1/home/screen?cityId=delhi"
```

**If you get data**, ✅ backend is working!

---

## 📱 Step 9: Connect iOS App to Local Backend

### Update iOS App Configuration

1. Open your iOS project in Xcode
2. Find the API configuration file (usually `AppConfig.swift` or similar)
3. Update the base URL:

**Create/Update this file:**

```swift
// CityServe/Core/Config/AppConfig.swift

import Foundation

struct AppConfig {
    // MARK: - Environment

    #if DEBUG
    static let environment: Environment = .local
    #else
    static let environment: Environment = .production
    #endif

    // MARK: - API Configuration

    static var baseURL: String {
        switch environment {
        case .local:
            // Replace PROJECT_ID with your Firebase project ID
            return "http://127.0.0.1:5001/PROJECT_ID/asia-south1/api/api/v1"
        case .development:
            return "https://asia-south1-PROJECT_ID.cloudfunctions.net/api/api/v1"
        case .production:
            return "https://asia-south1-PROJECT_ID.cloudfunctions.net/api/api/v1"
        }
    }

    // MARK: - Environment Types

    enum Environment {
        case local
        case development
        case production
    }
}
```

### Create API Service

Create a new file: `CityServe/Core/Services/APIService.swift`

```swift
import Foundation

class APIService {
    static let shared = APIService()

    private let baseURL = AppConfig.baseURL

    private init() {}

    // MARK: - Home Screen API

    func fetchHomeScreen(cityId: String) async throws -> HomeScreenResponse {
        let urlString = "\(baseURL)/home/screen?cityId=\(cityId)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        print("📡 Fetching from: \(urlString)")

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        print("📊 Response status: \(httpResponse.statusCode)")

        guard httpResponse.statusCode == 200 else {
            throw APIError.httpError(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let apiResponse = try decoder.decode(APIResponse<HomeScreenData>.self, from: data)

        if apiResponse.success, let data = apiResponse.data {
            return HomeScreenResponse(from: data)
        } else {
            throw APIError.serverError(apiResponse.error?.message ?? "Unknown error")
        }
    }
}

// MARK: - Response Models

struct APIResponse<T: Decodable>: Decodable {
    let success: Bool
    let data: T?
    let error: APIErrorResponse?
    let timestamp: String
}

struct APIErrorResponse: Decodable {
    let code: String
    let message: String
}

struct HomeScreenData: Decodable {
    let city: CityDTO
    let categories: CategoriesDTO
    let popularServices: [ServiceDTO]
    let trendingServices: [ServiceDTO]
    let banners: [BannerDTO]
    let trustIndicators: TrustIndicatorDTO
}

struct CityDTO: Decodable {
    let id: String
    let name: String
    let displayName: String
    let currencySymbol: String
}

struct CategoriesDTO: Decodable {
    let personal: [CategoryDTO]
    let home: [CategoryDTO]
}

struct CategoryDTO: Decodable {
    let id: String
    let name: String
    let displayName: String
    let type: String
    let icon: String
    let imageUrl: String?
    let sortOrder: Int
    let color: String?
    let isPopular: Bool
}

struct ServiceDTO: Decodable {
    let id: String
    let categoryId: String
    let name: String
    let shortDescription: String
    let basePrice: Double
    let priceRange: PriceRangeDTO
    let duration: Int
    let rating: Double
    let reviewCount: Int
    let imageUrl: String?
    let tags: [String]
}

struct PriceRangeDTO: Decodable {
    let min: Double
    let max: Double
}

struct BannerDTO: Decodable {
    let id: String
    let title: String
    let subtitle: String?
    let imageUrl: String
    let type: String
    let action: BannerActionDTO
}

struct BannerActionDTO: Decodable {
    let type: String
    let target: String
}

struct TrustIndicatorDTO: Decodable {
    let totalServicesCompleted: Int
    let averageRating: Double
    let verifiedProfessionals: Int
    let cities: Int
}

// MARK: - API Errors

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case serverError(String)
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .serverError(let message):
            return message
        case .decodingError:
            return "Failed to decode response"
        }
    }
}

// MARK: - Response Conversion

struct HomeScreenResponse {
    let city: City
    let categories: Categories
    let popularServices: [Service]
    let trendingServices: [Service]
    let banners: [Banner]
    let trustIndicators: TrustIndicators

    init(from data: HomeScreenData) {
        self.city = City(from: data.city)
        self.categories = Categories(
            personal: data.categories.personal.map { Service(from: $0) },
            home: data.categories.home.map { Service(from: $0) }
        )
        self.popularServices = data.popularServices.map { Service(from: $0) }
        self.trendingServices = data.trendingServices.map { Service(from: $0) }
        self.banners = data.banners.map { Banner(from: $0) }
        self.trustIndicators = TrustIndicators(from: data.trustIndicators)
    }
}

struct Categories {
    let personal: [Service]
    let home: [Service]
}

struct TrustIndicators {
    let totalServicesCompleted: Int
    let averageRating: Double
    let verifiedProfessionals: Int
    let cities: Int

    init(from dto: TrustIndicatorDTO) {
        self.totalServicesCompleted = dto.totalServicesCompleted
        self.averageRating = dto.averageRating
        self.verifiedProfessionals = dto.verifiedProfessionals
        self.cities = dto.cities
    }
}

struct Banner {
    let id: String
    let title: String
    let subtitle: String?
    let imageUrl: String
    let type: String

    init(from dto: BannerDTO) {
        self.id = dto.id
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.imageUrl = dto.imageUrl
        self.type = dto.type
    }
}

// Extend existing City and Service models with DTO initializers
extension City {
    init(from dto: CityDTO) {
        self.init(
            id: dto.id,
            name: dto.name,
            displayName: dto.displayName,
            currencySymbol: dto.currencySymbol
        )
    }
}

extension Service {
    init(from dto: ServiceDTO) {
        // Map DTO to your existing Service model
        // Adjust based on your actual Service model structure
    }
}
```

### Update HomeViewModel to Use API

```swift
// CityServe/ViewModels/HomeViewModel.swift

@MainActor
class HomeViewModel: ObservableObject {
    // ... existing properties ...

    private let apiService = APIService.shared

    func loadInitialData() {
        Task {
            isLoading = true
            errorMessage = nil

            do {
                let response = try await apiService.fetchHomeScreen(cityId: selectedCity)

                // Update published properties with API data
                self.personalServiceCategories = response.categories.personal
                self.homeServiceCategories = response.categories.home
                self.popularServices = response.popularServices
                self.trendingServices = response.trendingServices
                // ... update other properties ...

                print("✅ Data loaded successfully")
            } catch {
                print("❌ Error loading data: \(error)")
                errorMessage = error.localizedDescription
                // Fall back to mock data
                loadMockData()
            }

            isLoading = false
        }
    }

    private func loadMockData() {
        // Your existing mock data loading logic
        categories = ServiceCategory.mockCategories
        allServices = Service.mockServices
        // ...
    }
}
```

---

## 🔧 iOS App Transport Security (ATS)

To allow local HTTP connections, update `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

**⚠️ Remove this in production!** Only for local development.

---

## ✅ Step 10: Test End-to-End

1. **Start Backend**: `firebase emulators:start`
2. **Seed Data**: Use Emulator UI or import script
3. **Run iOS App**: Build and run in Xcode
4. **Check Logs**: Should see API requests in console

**Expected Flow:**
```
📡 Fetching from: http://127.0.0.1:5001/.../home/screen?cityId=delhi
📊 Response status: 200
✅ Data loaded successfully
```

---

## 🐛 Troubleshooting

### Issue 1: "Connection refused"

**Error**: Cannot connect to localhost
**Solution**:
- Ensure emulators are running: `firebase emulators:start`
- Check ports: `lsof -i :5001`
- Use `127.0.0.1` instead of `localhost`

### Issue 2: "No data returned"

**Error**: API returns empty data
**Solution**:
- Check Firestore Emulator UI: http://127.0.0.1:4000/firestore
- Verify sample data is imported
- Check cityId parameter matches a document in `cities` collection

### Issue 3: "Invalid project ID"

**Error**: Project ID not found
**Solution**:
- Find your project ID: `firebase projects:list`
- Update URLs with correct PROJECT_ID
- Check `.firebaserc` file

### Issue 4: "iOS app can't connect"

**Error**: iOS app shows network error
**Solution**:
- Check Info.plist has NSAllowsLocalNetworking
- Run on iOS Simulator (not real device for localhost)
- Verify URL format: `http://127.0.0.1:5001/...`

---

## 📊 Viewing Data in Emulator UI

### Firestore Data
http://127.0.0.1:4000/firestore

- View all collections
- Add/edit/delete documents
- Real-time updates

### Functions Logs
http://127.0.0.1:4000/functions

- View function invocations
- Check request/response logs
- Debug errors

### Authentication
http://127.0.0.1:4000/auth

- View test users
- Test phone authentication

---

## 🚀 Quick Commands Reference

```bash
# Start emulators
firebase emulators:start

# Start specific emulators
firebase emulators:start --only functions,firestore

# Build functions
cd functions && npm run build && cd ..

# View logs
firebase emulators:start --debug

# Import data (if export exists)
firebase emulators:start --import=./firebase-data

# Export data
firebase emulators:export ./firebase-data
```

---

## 📝 Next Steps

1. ✅ Emulators running
2. ✅ Sample data imported
3. ✅ iOS app connected
4. ✅ Data flowing end-to-end

**Now you can**:
- Add more sample data in Emulator UI
- Test different cities
- Modify API responses
- Debug issues in real-time

---

**Need Help?**
- Check emulator logs
- Verify data in Firestore UI
- Check iOS console for API errors
- Ensure correct PROJECT_ID in all URLs
