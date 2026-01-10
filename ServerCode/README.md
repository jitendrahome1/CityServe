# CityServe Backend - Home Screen Module

## Project Structure

```
ServerCode/
├── functions/
│   ├── src/
│   │   ├── modules/
│   │   │   └── home/
│   │   │       ├── home.controller.ts
│   │   │       ├── home.service.ts
│   │   │       ├── home.repository.ts
│   │   │       └── home.dto.ts
│   │   ├── common/
│   │   │   ├── firebase.admin.ts
│   │   │   ├── response.handler.ts
│   │   │   ├── error.handler.ts
│   │   │   └── validators.ts
│   │   ├── types/
│   │   │   └── index.ts
│   │   └── index.ts
│   ├── package.json
│   └── tsconfig.json
├── firestore.rules
├── firestore.indexes.json
└── sample-data/
    ├── cities.json
    ├── service_categories.json
    ├── services.json
    ├── promotional_banners.json
    └── app_config.json
```

## Data Model Design

### 1. **cities** Collection
**Purpose**: Multi-city support. Stores available service cities.

```typescript
{
  id: string;              // "delhi", "mumbai", "bangalore"
  name: string;            // "Delhi"
  displayName: string;     // "Delhi NCR"
  isActive: boolean;
  coordinates: {
    latitude: number;
    longitude: number;
  };
  timezone: string;        // "Asia/Kolkata"
  currency: string;        // "INR"
  currencySymbol: string;  // "₹"
  serviceRadius: number;   // in km
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**Why?**: Future expansion to multiple cities. Enables city-specific pricing, services, and promotions.

---

### 2. **service_categories** Collection
**Purpose**: Organize services into categories (Personal, Home Services, etc.)

```typescript
{
  id: string;              // "salon_women", "plumbing"
  name: string;            // "Salon for Women"
  displayName: string;     // "Salon for Women"
  type: "personal" | "home" | "business";
  icon: string;            // "scissors"
  imageUrl?: string;
  description: string;
  sortOrder: number;       // For grid display order
  isActive: boolean;
  isPopular: boolean;
  availableCities: string[]; // ["delhi", "mumbai"]
  metadata: {
    color?: string;        // "#FF6B9D"
    tags?: string[];
  };
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**Why?**: Extensible category system. Supports filtering by city, type. Sort order for UI control.

---

### 3. **services** Collection
**Purpose**: Individual services within categories

```typescript
{
  id: string;              // "ac_repair_basic"
  categoryId: string;      // Reference to service_categories
  name: string;            // "AC Repair & Service"
  displayName: string;
  shortDescription: string;
  longDescription: string;
  basePrice: number;
  priceRange: {
    min: number;
    max: number;
  };
  duration: number;        // in minutes
  rating: number;          // 4.5
  reviewCount: number;
  isPopular: boolean;
  isTrending: boolean;
  isActive: boolean;
  availableCities: string[];
  imageUrls: string[];
  tags: string[];          // ["AC", "cooling", "repair"]
  metadata: {
    warranty?: string;
    includes?: string[];
    excludes?: string[];
  };
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**Indexes Required**:
- `categoryId` + `isActive` + `isPopular` (DESC)
- `isActive` + `isTrending` + `rating` (DESC)
- `availableCities` (ARRAY_CONTAINS) + `isActive` + `rating` (DESC)

**Why?**: Core service data. Supports filtering, sorting, city-based availability. Rating/review for trust.

---

### 4. **promotional_banners** Collection
**Purpose**: Home screen marketing banners

```typescript
{
  id: string;
  title: string;           // "Save 15% on every service"
  subtitle?: string;
  imageUrl: string;
  type: "plus_membership" | "custom_package" | "sponsored" | "seasonal";
  action: {
    type: "navigate" | "deeplink" | "external";
    target: string;        // "/plus-membership" or service ID
  };
  displayOrder: number;
  isActive: boolean;
  targetCities: string[]; // [] = all cities
  targetUsers?: {         // Optional targeting
    type: "all" | "new" | "premium";
  };
  validFrom: Timestamp;
  validUntil: Timestamp;
  impressions: number;    // Analytics
  clicks: number;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**Why?**: Flexible banner system. Supports targeting, scheduling, analytics tracking.

---

### 5. **app_config** Collection (Single Document)
**Purpose**: Global app configuration, trust indicators, feature flags

```typescript
{
  id: "global";
  trustIndicators: {
    totalServicesCompleted: number;
    averageRating: number;
    verifiedProfessionals: number;
    cities: number;
  };
  features: {
    plusMembershipEnabled: boolean;
    customPackageEnabled: boolean;
    chatSupportEnabled: boolean;
  };
  constants: {
    minOrderValue: number;
    platformFeePercentage: number;
    defaultServiceRadius: number;
  };
  version: string;         // API version
  updatedAt: Timestamp;
}
```

**Why?**: Centralized config. Easy to update trust metrics, toggle features without redeployment.

---

### 6. **users** Collection (User Preferences Subcollection)
**Path**: `users/{userId}/preferences/settings`

```typescript
{
  selectedCity: string;    // "delhi"
  recentSearches: string[];
  favoriteCategories: string[];
  lastUpdated: Timestamp;
}
```

**Why?**: Personalized experience. Selected city persists across sessions.

---

## API Endpoints

### GET `/api/v1/home/screen`
**Query Params**:
- `cityId` (required): string
- `userId` (optional): string - for personalization

**Response**:
```typescript
{
  success: true,
  data: {
    city: CityDTO,
    categories: {
      personal: CategoryDTO[],
      home: CategoryDTO[]
    },
    popularServices: ServiceDTO[],
    trendingServices: ServiceDTO[],
    banners: BannerDTO[],
    trustIndicators: TrustIndicatorDTO
  },
  timestamp: string
}
```

---

## Firestore Security Rules

See `firestore.rules` for complete implementation. Key rules:
- Public read for cities, categories, services, banners
- Read-only app_config
- User-specific write for preferences
- Admin-only write for all collections

---

## Setup Instructions

1. **Install Dependencies**:
```bash
cd ServerCode/functions
npm install
```

2. **Configure Firebase**:
```bash
firebase init functions
# Select TypeScript
# Select asia-south1 region
```

3. **Set Environment Variables**:
```bash
firebase functions:config:set app.env="production"
```

4. **Deploy**:
```bash
npm run build
firebase deploy --only functions
```

5. **Seed Sample Data**:
```bash
node scripts/seed-data.js
```

---

## Testing

```bash
# Run tests
npm test

# Test locally
npm run serve
# Access: http://localhost:5001/cityserve-dev/asia-south1/api/v1/home/screen?cityId=delhi
```

---

## Performance Considerations

1. **Caching**:
   - Categories: Cache for 1 hour (rarely change)
   - Services: Cache for 15 minutes
   - Banners: Cache for 5 minutes
   - Trust indicators: Cache for 1 hour

2. **Pagination**: Services support limit/offset for large datasets

3. **Indexes**: Pre-defined composite indexes for common queries

4. **CDN**: Static assets (images) served via Firebase Storage + CDN

---

## Future Enhancements (Not in Scope)

- Personalized recommendations based on history
- A/B testing for banners
- Real-time service availability
- Location-based service filtering
- Dynamic pricing based on demand

---

**Author**: CityServe Backend Team
**Last Updated**: January 2026
**Version**: 1.0.0
