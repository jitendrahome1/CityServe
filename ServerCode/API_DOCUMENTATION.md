# CityServe Backend API Documentation

## Home Screen API - Complete Implementation

---

## 🚀 Quick Start

### Prerequisites
- Node.js 18 LTS
- Firebase CLI: `npm install -g firebase-tools`
- Firebase project created
- Firestore Database enabled

### Installation

```bash
# Navigate to functions directory
cd ServerCode/functions

# Install dependencies
npm install

# Login to Firebase
firebase login

# Initialize project (if not done)
firebase init

# Deploy
npm run deploy
```

---

## 📡 API Endpoints

### Base URL
- **Production**: `https://asia-south1-[PROJECT_ID].cloudfunctions.net/api`
- **Local**: `http://localhost:5001/[PROJECT_ID]/asia-south1/api`

---

## 1. Health Check

### GET `/health`

Check if API is running.

**Response:**
```json
{
  "status": "healthy",
  "service": "CityServe API",
  "version": "1.0.0",
  "timestamp": "2026-01-10T10:30:00.000Z"
}
```

---

## 2. Get Home Screen Data

### GET `/api/v1/home/screen`

Fetch complete home screen data for a city.

**Query Parameters:**
| Parameter | Type | Required | Description | Example |
|-----------|------|----------|-------------|---------|
| `cityId` | string | Yes | City identifier (lowercase) | `delhi` |
| `userId` | string | No | User ID for personalization | `abc123xyz` |
| `limit` | number | No | Max popular services (1-100) | `10` |

**Example Request:**
```bash
curl "https://asia-south1-PROJECT_ID.cloudfunctions.net/api/api/v1/home/screen?cityId=delhi&limit=10"
```

**Success Response (200):**
```json
{
  "success": true,
  "data": {
    "city": {
      "id": "delhi",
      "name": "Delhi",
      "displayName": "Delhi NCR",
      "currencySymbol": "₹"
    },
    "categories": {
      "personal": [
        {
          "id": "salon_women",
          "name": "Salon for Women",
          "displayName": "Salon for Women",
          "type": "personal",
          "icon": "scissors",
          "imageUrl": "https://...",
          "sortOrder": 1,
          "color": "#FF6B9D",
          "isPopular": true
        }
      ],
      "home": [
        {
          "id": "plumbing",
          "name": "Plumbing",
          "displayName": "Plumbing Services",
          "type": "home",
          "icon": "drop.fill",
          "imageUrl": "https://...",
          "sortOrder": 1,
          "color": "#4ECDC4",
          "isPopular": true
        }
      ]
    },
    "popularServices": [
      {
        "id": "ac_repair_basic",
        "categoryId": "electrical",
        "name": "AC Repair & Service",
        "shortDescription": "Complete AC check-up and repair",
        "basePrice": 399,
        "priceRange": { "min": 399, "max": 1499 },
        "duration": 60,
        "rating": 4.7,
        "reviewCount": 2847,
        "imageUrl": "https://...",
        "tags": ["AC", "cooling", "repair"]
      }
    ],
    "trendingServices": [
      {
        "id": "spa_aromatherapy",
        "categoryId": "spa_women",
        "name": "Aromatherapy Massage",
        "shortDescription": "Relaxing full-body massage with essential oils",
        "basePrice": 1299,
        "priceRange": { "min": 1299, "max": 2499 },
        "duration": 90,
        "rating": 4.9,
        "reviewCount": 1523,
        "imageUrl": "https://...",
        "tags": ["spa", "massage", "relaxation"]
      }
    ],
    "banners": [
      {
        "id": "plus_membership_2026",
        "title": "Save 15% on every service",
        "subtitle": "Join CityServe Plus today",
        "imageUrl": "https://...",
        "type": "plus_membership",
        "action": {
          "type": "navigate",
          "target": "/plus-membership"
        }
      }
    ],
    "trustIndicators": {
      "totalServicesCompleted": 2500000,
      "averageRating": 4.6,
      "verifiedProfessionals": 15000,
      "cities": 15
    }
  },
  "timestamp": "2026-01-10T10:30:00.000Z"
}
```

**Error Responses:**

**400 - Invalid Parameters:**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_PARAMETERS",
    "message": "Invalid query parameters",
    "details": {
      "errors": ["cityId is required"]
    }
  },
  "timestamp": "2026-01-10T10:30:00.000Z"
}
```

**404 - City Not Found:**
```json
{
  "success": false,
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "City not found"
  },
  "timestamp": "2026-01-10T10:30:00.000Z"
}
```

---

## 📊 Data Model Summary

### Collections Created

1. **cities** - Available service cities
2. **service_categories** - Service categories (Personal, Home, Business)
3. **services** - Individual services with pricing and ratings
4. **promotional_banners** - Marketing banners
5. **app_config** - Global configuration (trust indicators, feature flags)
6. **users/{userId}/preferences** - User-specific settings

### Sample Data Provided

- **5 cities**: Delhi, Mumbai, Bangalore, Pune, Hyderabad
- **10 categories**: Mix of personal and home services
- **20 services**: Popular services across categories
- **3 banners**: Plus membership, custom package, seasonal offer
- **1 app config**: Trust indicators and feature flags

---

## 🔐 Security

### Firestore Rules
- **Public read**: cities, categories, services, banners, app_config
- **Admin write**: All collections
- **User-specific**: users/{userId}/preferences

### Authentication
- Phone OTP via Firebase Auth
- Custom claims for admin roles
- Future: App Check for additional security

---

## ⚡ Performance Optimizations

### Caching Strategy
```typescript
// Response headers set automatically
Cache-Control: public, max-age=300  // 5 minutes
Vary: Accept-Encoding              // Enable compression
```

### Parallel Data Fetching
All data fetched in parallel using `Promise.all` for optimal performance.

### Composite Indexes
Pre-defined Firestore indexes for efficient queries (see `firestore.indexes.json`).

### Scaling
- **Auto-scaling**: 0 to 100 instances
- **Memory**: 256MB per instance
- **Region**: asia-south1 (India) for low latency

---

## 🧪 Testing

### Local Testing
```bash
# Start Firebase emulators
npm run serve

# Test health check
curl http://localhost:5001/PROJECT_ID/asia-south1/api/health

# Test home screen API
curl "http://localhost:5001/PROJECT_ID/asia-south1/api/api/v1/home/screen?cityId=delhi"
```

### Production Testing
```bash
curl "https://asia-south1-PROJECT_ID.cloudfunctions.net/api/api/v1/home/screen?cityId=delhi"
```

---

## 📦 Deployment

### Full Deployment
```bash
cd ServerCode/functions
npm run build
firebase deploy --only functions
```

### Deploy Firestore Rules & Indexes
```bash
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes
```

### Environment Variables (if needed)
```bash
firebase functions:config:set app.env="production"
firebase functions:config:set app.region="asia-south1"
```

---

## 🐛 Debugging

### View Logs
```bash
firebase functions:log

# Follow logs in real-time
firebase functions:log --only api
```

### Common Issues

**Issue**: Function timeout
**Solution**: Increase timeout in `index.ts`:
```typescript
.runWith({ timeoutSeconds: 120 })
```

**Issue**: Firestore indexes not created
**Solution**: Deploy indexes explicitly:
```bash
firebase deploy --only firestore:indexes
```

**Issue**: CORS errors
**Solution**: Add your domain to allowed origins in `index.ts`

---

## 📈 Monitoring

### Firebase Console
- Functions dashboard: Response time, invocations, errors
- Firestore dashboard: Read/write operations, costs
- Performance monitoring: Real user metrics

### Logging
All requests logged with timestamp, method, path, and query params.

---

## 🔮 Future Enhancements (Not in Scope)

1. Personalized service recommendations
2. City listing endpoint
3. Service search with filters
4. Real-time service availability
5. A/B testing for banners
6. Dynamic pricing based on demand
7. Scheduled functions for trending services update

---

## 📝 Code Quality

### TypeScript Features Used
- ✅ Strict mode enabled
- ✅ Strong typing everywhere
- ✅ No implicit `any`
- ✅ Null safety checks
- ✅ Exhaustive error handling

### Architecture Patterns
- ✅ Clean Architecture (Controller → Service → Repository)
- ✅ Dependency Injection ready
- ✅ DTOs for API responses
- ✅ Centralized error handling
- ✅ Modular design

---

## 👥 Support

For backend issues:
1. Check Firebase Functions logs
2. Verify Firestore indexes are deployed
3. Ensure security rules are correct
4. Check API query parameters

---

## ✅ Implementation Checklist

- [x] TypeScript configuration
- [x] Firebase Admin SDK initialization
- [x] Data model design (6 collections)
- [x] DTOs for clean API responses
- [x] Repository layer (data access)
- [x] Service layer (business logic)
- [x] Controller layer (HTTP handling)
- [x] Error handling & validation
- [x] Firestore security rules
- [x] Firestore composite indexes
- [x] API documentation
- [x] Deployment instructions

---

**Version**: 1.0.0
**Last Updated**: January 10, 2026
**Maintained by**: CityServe Backend Team
