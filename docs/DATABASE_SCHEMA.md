# DATABASE_SCHEMA.md

**CityServe / UrbanNest Platform - Complete Firestore Database Schema**

---

## Table of Contents

1. [Database Overview](#database-overview)
2. [Core Collections](#core-collections)
3. [Data Models](#data-models)
4. [Indexes](#indexes)
5. [Security Rules](#security-rules)
6. [Data Relationships](#data-relationships)
7. [Query Patterns](#query-patterns)
8. [Backup & Recovery](#backup--recovery)

---

## 1. Database Overview

### Technology Stack
- **Primary Database**: Cloud Firestore (NoSQL document database)
- **Real-time Database**: Firebase Realtime Database (for live tracking)
- **Caching Layer**: Client-side Firestore cache + Redis (for Cloud Functions)
- **Analytics**: BigQuery export for data warehousing

### Design Principles
1. **Denormalization**: Duplicate data where needed for read efficiency
2. **Shallow Queries**: Avoid deep nesting, use subcollections
3. **Geo-Indexing**: Use GeoPoint for location-based queries
4. **Audit Trail**: Track all state changes with timestamps
5. **Soft Deletes**: Mark as deleted instead of removing documents

---

## 2. Core Collections

### Collection Structure

```
/users/{userId}
/services/{serviceId}
/categories/{categoryId}
/bookings/{bookingId}
/cities/{cityId}
  /zones/{zoneId}
/providers/{providerId}
  /availability/{date}
  /earnings/{monthYear}
/reviews/{reviewId}
/payments/{paymentId}
/notifications/{notificationId}
/promo_codes/{promoId}
/support_tickets/{ticketId}
/analytics_events/{eventId}
```

---

## 3. Data Models

### 3.1 Users Collection

**Collection**: `/users/{userId}`

**Document Structure**:

```typescript
{
  // Basic Info
  id: string;                    // Firebase Auth UID
  phone: string;                 // +91XXXXXXXXXX (unique, indexed)
  email: string | null;          // Optional email
  name: string;                  // Display name
  profileImage: string | null;   // Firebase Storage URL

  // User Type
  type: 'customer' | 'provider' | 'admin';

  // Status
  status: 'active' | 'suspended' | 'deleted';
  isVerified: boolean;           // Phone verified

  // Timestamps
  createdAt: Timestamp;
  updatedAt: Timestamp;
  lastLoginAt: Timestamp;

  // Customer-Specific Fields (if type === 'customer')
  addresses: Address[];          // Saved addresses
  defaultAddressId: string | null;
  savedProviders: string[];      // Provider IDs
  walletBalance: number;         // In INR
  totalBookings: number;

  // Provider-Specific Fields (if type === 'provider')
  services: string[];            // Service IDs they offer
  documents: ProviderDocument[]; // KYC documents
  kycStatus: 'pending' | 'approved' | 'rejected' | 'resubmit';
  kycRejectionReason: string | null;
  rating: number;                // Average rating (0-5)
  totalRatings: number;
  completedBookings: number;
  totalEarnings: number;         // Lifetime earnings in INR
  bankDetails: BankDetails | null;
  isAvailable: boolean;          // Currently accepting bookings
  cityId: string;                // Operating city
  zoneIds: string[];             // Operating zones

  // Notification Preferences
  fcmTokens: string[];           // FCM device tokens
  notificationPrefs: {
    push: boolean;
    sms: boolean;
    email: boolean;
    whatsapp: boolean;
  };

  // Metadata
  deviceInfo: {
    platform: 'ios' | 'android' | 'web';
    appVersion: string;
    deviceId: string;
  } | null;

  referralCode: string;          // User's own referral code
  referredBy: string | null;     // Referrer's user ID
}
```

**Sub-Types**:

```typescript
type Address = {
  id: string;
  label: string;                 // 'Home', 'Office', 'Other'
  fullAddress: string;
  landmark: string | null;
  cityId: string;
  zoneId: string;
  location: GeoPoint;            // Firestore GeoPoint
  isDefault: boolean;
};

type ProviderDocument = {
  type: 'aadhar' | 'pan' | 'license' | 'certificate';
  documentUrl: string;           // Firebase Storage URL
  documentNumber: string;
  uploadedAt: Timestamp;
  verifiedAt: Timestamp | null;
  status: 'pending' | 'verified' | 'rejected';
};

type BankDetails = {
  accountNumber: string;         // Encrypted
  ifscCode: string;
  accountHolderName: string;
  bankName: string;
  upiId: string | null;
  verifiedAt: Timestamp | null;
};
```

### 3.2 Services Collection

**Collection**: `/services/{serviceId}`

```typescript
{
  id: string;
  name: string;                  // "AC Repair", "Haircut at Home"
  description: string;           // Detailed description
  categoryId: string;            // Reference to categories collection

  // Pricing
  basePrice: number;             // Base price in INR
  priceUnit: 'fixed' | 'per_hour' | 'per_sqft';
  estimatedDuration: number;     // In minutes

  // Media
  imageUrl: string;              // Primary image
  gallery: string[];             // Additional images
  videoUrl: string | null;       // Demo video

  // Availability
  isActive: boolean;
  cities: string[];              // City IDs where available

  // Service Details
  whatIncluded: string[];        // List of inclusions
  whatNotIncluded: string[];     // List of exclusions
  requirements: string[];        // Customer preparation needed

  // Metadata
  searchKeywords: string[];      // For search optimization
  popularityScore: number;       // Booking frequency
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### 3.3 Categories Collection

**Collection**: `/categories/{categoryId}`

```typescript
{
  id: string;
  name: string;                  // "Home Cleaning", "Beauty & Spa"
  description: string;
  icon: string;                  // Icon URL or name
  imageUrl: string;              // Category banner

  displayOrder: number;          // Sort order in UI
  isActive: boolean;
  parentCategoryId: string | null; // For sub-categories

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### 3.4 Bookings Collection

**Collection**: `/bookings/{bookingId}`

```typescript
{
  id: string;
  bookingNumber: string;         // Human-readable (e.g., "URB123456")

  // Parties
  customerId: string;            // User ID
  providerId: string | null;     // Assigned provider (null initially)
  serviceId: string;

  // Status & Timeline
  status: 'requested' | 'provider_assigned' | 'provider_accepted' |
          'provider_rejected' | 'in_progress' | 'completed' |
          'cancelled' | 'refunded';

  timeline: BookingEvent[];      // Status change history

  // Scheduling
  scheduledDate: Timestamp;      // Service date/time
  estimatedDuration: number;     // In minutes
  actualStartTime: Timestamp | null;
  actualEndTime: Timestamp | null;

  // Location
  address: Address;              // Full address object
  location: GeoPoint;            // For geo queries
  cityId: string;
  zoneId: string;

  // Pricing
  pricing: {
    basePrice: number;
    taxes: number;               // GST
    discount: number;            // Promo discount
    surgeFee: number;            // Surge pricing
    totalPrice: number;          // Final amount
    currency: 'INR';
  };

  // Payment
  payment: {
    method: 'razorpay_upi' | 'razorpay_card' | 'razorpay_wallet' |
            'razorpay_netbanking' | 'wallet' | 'cash';
    status: 'pending' | 'paid' | 'failed' | 'refunded';
    transactionId: string | null;
    razorpayOrderId: string | null;
    razorpayPaymentId: string | null;
    paidAt: Timestamp | null;
  };

  // Provider Matching
  assignmentAttempts: number;    // Number of providers notified
  rejectedProviderIds: string[]; // Providers who declined

  // Service Details
  specialInstructions: string | null;
  attachments: string[];         // Image URLs (before photos)

  // Rating & Review
  rating: {
    score: number | null;        // 1-5 stars
    comment: string | null;
    createdAt: Timestamp | null;
  };

  // Completion Evidence
  afterServicePhotos: string[];  // Provider uploads
  serviceReport: string | null;  // Provider notes

  // Cancellation
  cancellationReason: string | null;
  cancelledBy: 'customer' | 'provider' | 'admin' | null;
  cancelledAt: Timestamp | null;

  // Promo & Offers
  promoCode: string | null;

  // Timestamps
  createdAt: Timestamp;
  updatedAt: Timestamp;
  completedAt: Timestamp | null;
}
```

**Sub-Types**:

```typescript
type BookingEvent = {
  status: string;
  timestamp: Timestamp;
  actor: 'customer' | 'provider' | 'system' | 'admin';
  note: string | null;
};
```

### 3.5 Cities Collection

**Collection**: `/cities/{cityId}`

```typescript
{
  id: string;
  name: string;                  // "Delhi NCR", "Bangalore"
  state: string;                 // "Delhi", "Karnataka"
  country: string;               // "India"

  // Coordinates for center
  centerLocation: GeoPoint;

  // Operational Status
  isActive: boolean;
  launchDate: Timestamp;

  // Service Configuration
  availableServices: string[];   // Service IDs
  operationalHours: {
    start: string;               // "06:00"
    end: string;                 // "22:00"
  };

  // Pricing
  pricingMultiplier: number;     // City-specific price adjustment (1.0 = default)

  // Metadata
  timezone: string;              // "Asia/Kolkata"
  currency: 'INR';
  language: string[];            // ['en', 'hi']

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

**Subcollection**: `/cities/{cityId}/zones/{zoneId}`

```typescript
{
  id: string;
  name: string;                  // "Indiranagar", "Koramangala"
  cityId: string;

  // Geographic Boundaries
  polygon: GeoPoint[];           // Array of coordinates forming boundary
  centerLocation: GeoPoint;

  // Operational
  isActive: boolean;
  serviceableHours: {
    start: string;
    end: string;
  };

  // Provider Coverage
  activeProviders: number;       // Count of available providers

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### 3.6 Providers Availability Subcollection

**Collection**: `/providers/{providerId}/availability/{date}`

**Document ID**: Date in YYYY-MM-DD format (e.g., "2025-12-30")

```typescript
{
  date: string;                  // "2025-12-30"
  providerId: string;

  // Availability Status
  isAvailable: boolean;
  availabilityType: 'full_day' | 'custom_slots' | 'unavailable';

  // Time Slots (if custom_slots)
  slots: TimeSlot[];

  // Bookings
  bookingIds: string[];          // Confirmed bookings for this date

  // Capacity
  maxBookings: number;           // Max bookings per day
  remainingCapacity: number;

  updatedAt: Timestamp;
}
```

**Sub-Types**:

```typescript
type TimeSlot = {
  startTime: string;             // "09:00"
  endTime: string;               // "10:00"
  isBooked: boolean;
  bookingId: string | null;
};
```

### 3.7 Reviews Collection

**Collection**: `/reviews/{reviewId}`

```typescript
{
  id: string;
  bookingId: string;
  customerId: string;
  providerId: string;
  serviceId: string;

  // Rating
  rating: number;                // 1-5 stars
  comment: string | null;

  // Categories (optional detailed ratings)
  categoryRatings: {
    punctuality: number | null;
    quality: number | null;
    professionalism: number | null;
    cleanliness: number | null;
  } | null;

  // Media
  photos: string[];              // Review photos

  // Moderation
  status: 'pending' | 'approved' | 'flagged' | 'hidden';
  isFeatured: boolean;

  // Provider Response
  providerResponse: string | null;
  providerRespondedAt: Timestamp | null;

  // Helpfulness (future feature)
  helpfulCount: number;
  notHelpfulCount: number;

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### 3.8 Payments Collection

**Collection**: `/payments/{paymentId}`

```typescript
{
  id: string;
  bookingId: string;
  customerId: string;
  providerId: string | null;

  // Amount
  amount: number;                // In INR
  currency: 'INR';

  // Payment Gateway
  gateway: 'razorpay' | 'wallet';
  razorpayOrderId: string | null;
  razorpayPaymentId: string | null;
  razorpaySignature: string | null;

  // Status
  status: 'initiated' | 'pending' | 'success' | 'failed' | 'refunded';

  // Payment Method
  method: 'upi' | 'card' | 'netbanking' | 'wallet';
  methodDetails: {
    last4: string | null;        // Last 4 digits of card
    bank: string | null;
    upiId: string | null;
  } | null;

  // Escrow & Payout
  escrowStatus: 'held' | 'released' | 'refunded';
  releasedToProvider: boolean;
  providerPayoutId: string | null;

  // Refund
  refundAmount: number | null;
  refundReason: string | null;
  refundedAt: Timestamp | null;

  // Timestamps
  createdAt: Timestamp;
  updatedAt: Timestamp;
  completedAt: Timestamp | null;
}
```

### 3.9 Provider Earnings Subcollection

**Collection**: `/providers/{providerId}/earnings/{monthYear}`

**Document ID**: Month-Year format (e.g., "2025-12")

```typescript
{
  providerId: string;
  month: number;                 // 1-12
  year: number;                  // 2025

  // Earnings
  totalEarnings: number;         // Gross earnings
  platformCommission: number;    // Platform fee deducted
  netEarnings: number;           // Amount payable to provider

  // Breakdown
  completedBookings: number;
  totalHoursWorked: number;
  averageRating: number;

  // Payout
  payoutStatus: 'pending' | 'processing' | 'paid';
  payoutDate: Timestamp | null;
  payoutTransactionId: string | null;

  // Bookings
  bookingIds: string[];          // All bookings in this month

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### 3.10 Notifications Collection

**Collection**: `/notifications/{notificationId}`

```typescript
{
  id: string;
  userId: string;

  // Notification Details
  type: 'booking_update' | 'payment' | 'promo' | 'general';
  title: string;
  body: string;
  imageUrl: string | null;

  // Action
  actionType: 'open_booking' | 'open_profile' | 'open_url' | 'none';
  actionData: {
    bookingId: string | null;
    url: string | null;
  } | null;

  // Delivery
  channels: ('push' | 'sms' | 'email')[];
  deliveryStatus: {
    push: 'sent' | 'delivered' | 'failed' | 'pending';
    sms: 'sent' | 'delivered' | 'failed' | 'pending';
    email: 'sent' | 'delivered' | 'failed' | 'pending';
  };

  // Read Status
  isRead: boolean;
  readAt: Timestamp | null;

  // Priority
  priority: 'high' | 'normal' | 'low';

  createdAt: Timestamp;
  expiresAt: Timestamp | null;   // Auto-delete after expiry
}
```

### 3.11 Promo Codes Collection

**Collection**: `/promo_codes/{promoId}`

```typescript
{
  id: string;
  code: string;                  // "FIRST100", "WELCOME50" (unique)

  // Discount
  discountType: 'percentage' | 'fixed';
  discountValue: number;         // 10 (for 10%) or 100 (for ₹100)
  maxDiscount: number | null;    // Cap for percentage discounts
  minOrderValue: number | null;  // Minimum booking amount

  // Validity
  isActive: boolean;
  startDate: Timestamp;
  endDate: Timestamp;

  // Usage Limits
  usageLimit: number | null;     // Total uses allowed
  usageCount: number;            // Current usage count
  perUserLimit: number;          // Uses per user

  // Applicability
  applicableServices: string[];  // Empty = all services
  applicableCities: string[];    // Empty = all cities
  userType: 'all' | 'new' | 'existing';

  // Description
  title: string;                 // "First booking discount"
  description: string;
  termsAndConditions: string;

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### 3.12 Support Tickets Collection

**Collection**: `/support_tickets/{ticketId}`

```typescript
{
  id: string;
  ticketNumber: string;          // "SUP123456"

  // User
  userId: string;
  userType: 'customer' | 'provider';

  // Issue
  category: 'booking' | 'payment' | 'provider_issue' | 'app_bug' | 'other';
  subject: string;
  description: string;
  relatedBookingId: string | null;

  // Status
  status: 'open' | 'in_progress' | 'resolved' | 'closed';
  priority: 'low' | 'medium' | 'high' | 'urgent';

  // Assignment
  assignedTo: string | null;     // Admin user ID

  // Messages (subcollection: /support_tickets/{ticketId}/messages/{messageId})
  lastMessageAt: Timestamp;

  // Resolution
  resolution: string | null;
  resolvedAt: Timestamp | null;

  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

---

## 4. Indexes

### Required Composite Indexes

```javascript
// Bookings - Query by customer with status filter
Collection: bookings
Fields: customerId (Ascending), status (Ascending), createdAt (Descending)

// Bookings - Query by provider with status filter
Collection: bookings
Fields: providerId (Ascending), status (Ascending), scheduledDate (Ascending)

// Bookings - Geo query with city filter
Collection: bookings
Fields: cityId (Ascending), location (GeoPoint)

// Providers - Active providers in city/zone
Collection: users
Fields: type (Ascending), cityId (Ascending), zoneIds (Array), isAvailable (Ascending)

// Services - Active services in city
Collection: services
Fields: isActive (Ascending), cities (Array), categoryId (Ascending)

// Reviews - Provider reviews
Collection: reviews
Fields: providerId (Ascending), status (Ascending), createdAt (Descending)

// Notifications - Unread notifications
Collection: notifications
Fields: userId (Ascending), isRead (Ascending), createdAt (Descending)
```

### Single-Field Indexes

```javascript
// Auto-created by Firestore for frequently queried fields
users: phone, email, type, status
bookings: customerId, providerId, serviceId, status
payments: razorpayOrderId, razorpayPaymentId
```

---

## 5. Security Rules

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper Functions
    function isSignedIn() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }

    function isAdmin() {
      return isSignedIn() &&
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.type == 'admin';
    }

    function isProvider() {
      return isSignedIn() &&
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.type == 'provider';
    }

    // Users Collection
    match /users/{userId} {
      allow read: if isOwner(userId) || isAdmin();
      allow create: if isSignedIn() && isOwner(userId);
      allow update: if isOwner(userId) || isAdmin();
      allow delete: if isAdmin();
    }

    // Services Collection (Public Read)
    match /services/{serviceId} {
      allow read: if true;  // Public
      allow write: if isAdmin();
    }

    // Categories Collection (Public Read)
    match /categories/{categoryId} {
      allow read: if true;  // Public
      allow write: if isAdmin();
    }

    // Bookings Collection
    match /bookings/{bookingId} {
      allow read: if isOwner(resource.data.customerId) ||
                     isOwner(resource.data.providerId) ||
                     isAdmin();
      allow create: if isSignedIn();
      allow update: if isOwner(resource.data.customerId) ||
                       isOwner(resource.data.providerId) ||
                       isAdmin();
      allow delete: if isAdmin();
    }

    // Cities Collection (Public Read)
    match /cities/{cityId} {
      allow read: if true;  // Public
      allow write: if isAdmin();

      match /zones/{zoneId} {
        allow read: if true;  // Public
        allow write: if isAdmin();
      }
    }

    // Provider Availability
    match /providers/{providerId}/availability/{date} {
      allow read: if true;  // Public for matching
      allow write: if isOwner(providerId) || isAdmin();
    }

    // Reviews Collection
    match /reviews/{reviewId} {
      allow read: if resource.data.status == 'approved';  // Only approved reviews
      allow create: if isSignedIn() && isOwner(request.resource.data.customerId);
      allow update: if isOwner(resource.data.customerId) ||
                       isOwner(resource.data.providerId) ||  // For provider response
                       isAdmin();
      allow delete: if isAdmin();
    }

    // Payments Collection
    match /payments/{paymentId} {
      allow read: if isOwner(resource.data.customerId) ||
                     isOwner(resource.data.providerId) ||
                     isAdmin();
      allow create: if isSignedIn();
      allow update: if isAdmin();  // Only backend/admin can update
      allow delete: if false;  // Never delete payments
    }

    // Notifications Collection
    match /notifications/{notificationId} {
      allow read: if isOwner(resource.data.userId);
      allow write: if false;  // Only backend can write
    }

    // Support Tickets
    match /support_tickets/{ticketId} {
      allow read: if isOwner(resource.data.userId) || isAdmin();
      allow create: if isSignedIn();
      allow update: if isOwner(resource.data.userId) || isAdmin();
    }
  }
}
```

---

## 6. Data Relationships

### Entity Relationship Diagram (Logical)

```
┌─────────────┐
│    Users    │
│  (Customer/ │
│   Provider) │
└──────┬──────┘
       │
       ├──────────┐
       │          │
       ▼          ▼
  ┌─────────┐  ┌──────────┐
  │Bookings │  │ Reviews  │
  └────┬────┘  └────┬─────┘
       │            │
       │            │
       ▼            ▼
  ┌─────────┐  ┌──────────┐
  │Payments │  │Providers │
  └─────────┘  └──────────┘
       │
       ▼
  ┌──────────┐      ┌──────────┐
  │ Services │◄─────│Categories│
  └────┬─────┘      └──────────┘
       │
       ▼
  ┌─────────┐
  │  Cities │
  │  /Zones │
  └─────────┘
```

### Key Relationships

1. **User → Bookings**: One-to-Many
   - Customer can have multiple bookings
   - Provider can serve multiple bookings

2. **Booking → Service**: Many-to-One
   - Multiple bookings for same service

3. **Booking → Payment**: One-to-One
   - Each booking has one payment record

4. **Booking → Review**: One-to-One
   - Each completed booking can have one review

5. **Service → Category**: Many-to-One
   - Services belong to one category

6. **Provider → Availability**: One-to-Many
   - Provider has availability docs for multiple dates

7. **City → Zones**: One-to-Many
   - City contains multiple serviceable zones

---

## 7. Query Patterns

### Common Queries

#### Get Active Services in City

```typescript
const services = await db.collection('services')
  .where('isActive', '==', true)
  .where('cities', 'array-contains', cityId)
  .orderBy('popularityScore', 'desc')
  .limit(20)
  .get();
```

#### Get Customer's Bookings

```typescript
const bookings = await db.collection('bookings')
  .where('customerId', '==', userId)
  .orderBy('createdAt', 'desc')
  .limit(10)
  .get();
```

#### Find Available Providers in Zone

```typescript
const providers = await db.collection('users')
  .where('type', '==', 'provider')
  .where('isAvailable', '==', true)
  .where('zoneIds', 'array-contains', zoneId)
  .where('services', 'array-contains', serviceId)
  .limit(10)
  .get();
```

#### Get Provider's Today's Bookings

```typescript
const startOfDay = new Date();
startOfDay.setHours(0, 0, 0, 0);
const endOfDay = new Date();
endOfDay.setHours(23, 59, 59, 999);

const bookings = await db.collection('bookings')
  .where('providerId', '==', providerId)
  .where('scheduledDate', '>=', startOfDay)
  .where('scheduledDate', '<=', endOfDay)
  .where('status', 'in', ['provider_accepted', 'in_progress'])
  .orderBy('scheduledDate', 'asc')
  .get();
```

---

## 8. Backup & Recovery

### Backup Strategy

1. **Automated Daily Backups**
   - Enable Firestore automatic backups
   - Retention: 30 days
   - Storage: Firebase Cloud Storage

2. **BigQuery Export**
   - Daily export to BigQuery for analytics
   - Full historical data preservation

3. **Critical Collections**
   - Real-time replication for:
     - `users`
     - `bookings`
     - `payments`

### Recovery Procedures

1. **Point-in-Time Recovery**: Available within 7 days via Firebase Console
2. **Full Database Restore**: From daily backup snapshots
3. **Selective Collection Restore**: Import specific collections from BigQuery

---

## Document Metadata

**Created**: December 2025
**Platform**: CityServe / UrbanNest
**Database**: Cloud Firestore (Firebase)
**Version**: 1.0
**Last Updated**: December 30, 2025
