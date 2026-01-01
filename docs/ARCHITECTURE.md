# ARCHITECTURE.md

**CityServe / UrbanNest Platform - System Architecture Overview**

---

## Table of Contents

1. [System Overview](#system-overview)
2. [High-Level Architecture](#high-level-architecture)
3. [Component Architecture](#component-architecture)
4. [Data Flow Diagrams](#data-flow-diagrams)
5. [Security Architecture](#security-architecture)
6. [Scalability & Performance](#scalability--performance)
7. [Deployment Architecture](#deployment-architecture)
8. [Technology Stack](#technology-stack)
9. [Integration Architecture](#integration-architecture)
10. [Monitoring & Observability](#monitoring--observability)

---

## 1. System Overview

### Platform Purpose

CityServe (branded as UrbanNest) is a three-sided marketplace platform connecting:
- **Customers**: Users seeking professional home and lifestyle services
- **Service Providers**: Skilled professionals offering services
- **Admins**: Platform operators managing operations and quality

### Core Capabilities

1. **Service Discovery**: Browse and search 50+ home service categories
2. **Smart Matching**: AI-powered provider matching based on location, availability, and ratings
3. **Real-time Booking**: Instant service booking with live tracking
4. **Secure Payments**: Escrow-based payment system with multiple payment methods
5. **Quality Assurance**: KYC verification, ratings, reviews, and dispute resolution
6. **Multi-city Operations**: City-specific pricing, zones, and provider networks

---

## 2. High-Level Architecture

### System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT LAYER                             │
├────────────┬────────────┬────────────┬──────────────────────────┤
│  iOS App   │ Android App│  Web App   │   Admin Dashboard        │
│  (SwiftUI) │  (Kotlin)  │ (Next.js)  │     (Next.js)            │
└─────┬──────┴─────┬──────┴──────┬─────┴────────────┬─────────────┘
      │            │             │                  │
      └────────────┴─────────────┴──────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────────────────────────────┐
│                      API GATEWAY LAYER                            │
├──────────────────────────────────────────────────────────────────┤
│              Firebase Cloud Functions (Express.js)                │
│  ┌──────┬──────┬──────┬──────┬────────┬─────────┬──────────┐   │
│  │ Auth │ User │Booking│Match│Payment │  Review │   Admin  │   │
│  │  API │  API │  API  │ API │  API   │   API   │    API   │   │
│  └──────┴──────┴──────┴──────┴────────┴─────────┴──────────┘   │
└───────────────────────────────┬──────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────┐
│                     BUSINESS LOGIC LAYER                          │
├──────────────────────────────────────────────────────────────────┤
│  ┌────────────────┬──────────────────┬──────────────────────┐   │
│  │Provider Matching│  Pricing Engine  │ Notification Engine  │   │
│  │   Algorithm     │  (Surge, Promo)  │  (Push, SMS, Email)  │   │
│  └────────────────┴──────────────────┴──────────────────────┘   │
└───────────────────────────────┬──────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────┐
│                       DATA LAYER                                  │
├──────────────────────────────────────────────────────────────────┤
│  ┌─────────────────┬──────────────┬─────────────┬─────────────┐ │
│  │Cloud Firestore  │Firebase RTDB │   Redis     │  BigQuery   │ │
│  │(Primary Data)   │(Live Track)  │  (Cache)    │ (Analytics) │ │
│  └─────────────────┴──────────────┴─────────────┴─────────────┘ │
└──────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌──────────────────────────────────────────────────────────────────┐
│                  EXTERNAL INTEGRATIONS                            │
├──────────────────────────────────────────────────────────────────┤
│  ┌──────────┬──────────┬──────────┬──────────┬─────────────┐    │
│  │Razorpay  │  MSG91   │  FCM     │Google    │   SendGrid  │    │
│  │(Payments)│  (SMS)   │ (Push)   │  Maps    │   (Email)   │    │
│  └──────────┴──────────┴──────────┴──────────┴─────────────┘    │
└──────────────────────────────────────────────────────────────────┘
```

### Architecture Principles

1. **Serverless-First**: Use Firebase Cloud Functions for backend logic (no server management)
2. **Event-Driven**: Trigger actions based on database changes and user events
3. **Microservices**: Loosely coupled services with clear boundaries
4. **API-First**: Well-defined RESTful APIs for all client interactions
5. **Real-time Sync**: Firestore listeners for live data updates
6. **Security by Default**: Authentication, authorization, and encryption at every layer

---

## 3. Component Architecture

### 3.1 Mobile Applications (iOS & Android)

**Architecture Pattern**: MVVM + Clean Architecture

```
┌──────────────────────────────────────────────────┐
│                  PRESENTATION LAYER              │
│  ┌──────────────────────────────────────────┐   │
│  │          Views (SwiftUI/Compose)         │   │
│  └─────────────────┬────────────────────────┘   │
│                    │                             │
│  ┌─────────────────▼────────────────────────┐   │
│  │            ViewModels                    │   │
│  │  (Combine/StateFlow Publishers)          │   │
│  └─────────────────┬────────────────────────┘   │
└────────────────────┼──────────────────────────── │
                     │
┌────────────────────▼────────────────────────────┐
│                DOMAIN LAYER                      │
│  ┌──────────────────────────────────────────┐   │
│  │           Use Cases                      │   │
│  │  (Business Logic)                        │   │
│  └─────────────────┬────────────────────────┘   │
│                    │                             │
│  ┌─────────────────▼────────────────────────┐   │
│  │           Repositories (Interfaces)      │   │
│  └─────────────────┬────────────────────────┘   │
└────────────────────┼──────────────────────────── │
                     │
┌────────────────────▼────────────────────────────┐
│                 DATA LAYER                       │
│  ┌──────────────────────────────────────────┐   │
│  │      Repository Implementations          │   │
│  └─────┬────────────────────────────┬───────┘   │
│        │                            │            │
│  ┌─────▼────────┐          ┌────────▼─────┐     │
│  │ Remote Data  │          │  Local Data  │     │
│  │   Source     │          │    Source    │     │
│  │(Firebase SDK)│          │   (Cache)    │     │
│  └──────────────┘          └──────────────┘     │
└──────────────────────────────────────────────────┘
```

**Key Components**:

1. **Views**: SwiftUI (iOS) / Jetpack Compose (Android)
2. **ViewModels**: Handle UI state and user interactions
3. **Use Cases**: Encapsulate business logic (e.g., `BookServiceUseCase`)
4. **Repositories**: Abstract data access (local + remote)
5. **Data Sources**:
   - Remote: Firebase SDK (Firestore, Auth, Storage, Functions)
   - Local: UserDefaults/SharedPreferences, CoreData/Room (offline cache)

### 3.2 Web Applications (Next.js)

**Architecture**: App Router + Server Components

```
┌──────────────────────────────────────────────────┐
│              CUSTOMER WEB APP                    │
├──────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────┐   │
│  │    Server Components (RSC)               │   │
│  │  - Server-side rendering                 │   │
│  │  - Direct database access                │   │
│  └─────────────────┬────────────────────────┘   │
│                    │                             │
│  ┌─────────────────▼────────────────────────┐   │
│  │    Client Components                     │   │
│  │  - Interactive UI                        │   │
│  │  - State management (Zustand)            │   │
│  └─────────────────┬────────────────────────┘   │
│                    │                             │
│  ┌─────────────────▼────────────────────────┐   │
│  │     API Routes (Backend)                 │   │
│  │  - Firebase Admin SDK                    │   │
│  │  - Server-side business logic            │   │
│  └──────────────────────────────────────────┘   │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│              ADMIN DASHBOARD                     │
├──────────────────────────────────────────────────┤
│  - Provider management UI                        │
│  - Analytics & reporting                         │
│  - Service catalog CRUD                          │
│  - Real-time operations monitoring               │
└──────────────────────────────────────────────────┘
```

### 3.3 Backend Services (Cloud Functions)

**Service Organization**:

```
backend/functions/src/
├── auth/
│   ├── createProfile.ts
│   ├── verifyPhone.ts
│   └── updateProfile.ts
├── booking/
│   ├── createBooking.ts
│   ├── updateBookingStatus.ts
│   ├── cancelBooking.ts
│   └── completeBooking.ts
├── matching/
│   ├── findProviders.ts
│   ├── assignProvider.ts
│   ├── calculateETA.ts
│   └── rankProviders.ts
├── payment/
│   ├── createOrder.ts
│   ├── verifyPayment.ts
│   ├── processRefund.ts
│   └── processProviderPayout.ts
├── notification/
│   ├── sendPush.ts
│   ├── sendSMS.ts
│   └── sendEmail.ts
├── admin/
│   ├── approveKYC.ts
│   ├── manageServices.ts
│   └── getAnalytics.ts
└── shared/
    ├── middleware/
    ├── utils/
    └── types/
```

---

## 4. Data Flow Diagrams

### 4.1 Booking Creation Flow

```
┌──────────┐       ┌──────────┐       ┌──────────┐       ┌──────────┐
│ Customer │       │iOS/Android│      │  Cloud   │       │Firestore │
│   App    │       │    App   │       │ Function │       │          │
└────┬─────┘       └────┬─────┘       └────┬─────┘       └────┬─────┘
     │                  │                   │                  │
     │ 1. Select Service│                   │                  │
     │ ─────────────────▶                   │                  │
     │                  │                   │                  │
     │ 2. Choose Date   │                   │                  │
     │    & Address     │                   │                  │
     │ ─────────────────▶                   │                  │
     │                  │                   │                  │
     │ 3. Create Booking│                   │                  │
     │ ─────────────────▶                   │                  │
     │                  │                   │                  │
     │                  │ 4. POST /bookings │                  │
     │                  │ ──────────────────▶                  │
     │                  │                   │                  │
     │                  │                   │ 5. Create Doc    │
     │                  │                   │ ─────────────────▶
     │                  │                   │                  │
     │                  │                   │ 6. Trigger Match │
     │                  │                   │ ◀─ ─ ─ ─ ─ ─ ─ ─│
     │                  │                   │                  │
     │                  │                   │ 7. Find Providers│
     │                  │                   │ ─────────────────▶
     │                  │                   │                  │
     │                  │                   │ 8. Assign Provider
     │                  │                   │ ─────────────────▶
     │                  │                   │                  │
     │                  │                   │ 9. Send Notif    │
     │                  │ ◀─ ─ ─ ─ ─ ─ ─ ─ ─│◀─ ─ ─ ─ ─ ─ ─ ─│
     │                  │                   │                  │
     │ 10. Payment UI   │                   │                  │
     │ ◀────────────────│                   │                  │
     │                  │                   │                  │
     │ 11. Pay via      │                   │                  │
     │     Razorpay     │                   │                  │
     │ ─────────────────▶                   │                  │
     │                  │                   │                  │
     │                  │12. Verify Payment │                  │
     │                  │ ──────────────────▶                  │
     │                  │                   │                  │
     │                  │                   │ 13. Update Status│
     │                  │                   │ ─────────────────▶
     │                  │                   │                  │
     │ 14. Booking      │                   │                  │
     │     Confirmed    │                   │                  │
     │ ◀────────────────│                   │                  │
     │                  │                   │                  │
```

### 4.2 Provider Matching Flow

```
┌─────────────┐      ┌──────────────┐      ┌─────────────┐
│  Booking    │      │   Matching   │      │  Provider   │
│   Created   │      │   Algorithm  │      │   Database  │
└──────┬──────┘      └──────┬───────┘      └──────┬──────┘
       │                    │                     │
       │ 1. Trigger Match   │                     │
       │ ───────────────────▶                     │
       │                    │                     │
       │                    │ 2. Query Available  │
       │                    │     Providers       │
       │                    │ ────────────────────▶
       │                    │                     │
       │                    │ 3. Provider List    │
       │                    │ ◀────────────────────
       │                    │                     │
       │                    │ 4. Calculate Scores │
       │                    │    - Distance       │
       │                    │    - Rating         │
       │                    │    - Availability   │
       │                    │    - Completion Rate│
       │                    │                     │
       │                    │ 5. Rank Providers   │
       │                    │                     │
       │                    │ 6. Select Top       │
       │                    │    Provider         │
       │                    │                     │
       │ 7. Assign Provider │                     │
       │ ◀───────────────────                     │
       │                    │                     │
       │ 8. Notify Provider │                     │
       │ ───────────────────────────────────────▶ │
       │                    │                     │
```

### 4.3 Payment Flow

```
┌─────────┐   ┌──────────┐   ┌─────────┐   ┌──────────┐   ┌──────────┐
│Customer │   │  App     │   │Cloud    │   │Razorpay  │   │Firestore │
│         │   │          │   │Function │   │          │   │          │
└────┬────┘   └────┬─────┘   └────┬────┘   └────┬─────┘   └────┬─────┘
     │             │              │              │              │
     │ 1. Confirm  │              │              │              │
     │    Booking  │              │              │              │
     │ ────────────▶              │              │              │
     │             │              │              │              │
     │             │2. Create Order              │              │
     │             │ ─────────────▶              │              │
     │             │              │              │              │
     │             │              │3. Create Order              │
     │             │              │ ─────────────▶              │
     │             │              │              │              │
     │             │              │4. Order ID   │              │
     │             │              │ ◀─────────────              │
     │             │              │              │              │
     │             │5. Razorpay   │              │              │
     │             │   Order ID   │              │              │
     │ ◀────────────              │              │              │
     │             │              │              │              │
     │ 6. Open     │              │              │              │
     │    Razorpay │              │              │              │
     │    Checkout │              │              │              │
     │ ────────────────────────────────────────▶ │              │
     │             │              │              │              │
     │ 7. Complete │              │              │              │
     │    Payment  │              │              │              │
     │ ◀────────────────────────────────────────│              │
     │             │              │              │              │
     │             │8. Verify     │              │              │
     │             │   Payment    │              │              │
     │             │ ─────────────▶              │              │
     │             │              │              │              │
     │             │              │9. Verify     │              │
     │             │              │   Signature  │              │
     │             │              │ ─────────────▶              │
     │             │              │              │              │
     │             │              │10. Confirmed │              │
     │             │              │ ◀─────────────              │
     │             │              │              │              │
     │             │              │11. Update    │              │
     │             │              │    Payment   │              │
     │             │              │ ─────────────────────────────▶
     │             │              │              │              │
     │             │12. Success   │              │              │
     │ ◀────────────              │              │              │
     │             │              │              │              │
```

---

## 5. Security Architecture

### 5.1 Authentication & Authorization

**Multi-Layer Security**:

```
┌─────────────────────────────────────────────────────────┐
│                 SECURITY LAYERS                          │
├─────────────────────────────────────────────────────────┤
│  Layer 1: Firebase Authentication                       │
│  - Phone OTP verification                               │
│  - Email/Password (optional)                            │
│  - Google Sign-In (optional)                            │
│  - JWT tokens with 1-hour expiry                        │
├─────────────────────────────────────────────────────────┤
│  Layer 2: Firestore Security Rules                      │
│  - Document-level access control                        │
│  - User owns their data                                 │
│  - Role-based permissions (customer/provider/admin)     │
├─────────────────────────────────────────────────────────┤
│  Layer 3: Cloud Functions Middleware                    │
│  - Token verification on every request                  │
│  - User type validation                                 │
│  - Rate limiting                                        │
├─────────────────────────────────────────────────────────┤
│  Layer 4: Data Encryption                               │
│  - TLS/SSL for all API calls                           │
│  - Encrypted storage (Keychain/Keystore)                │
│  - Sensitive field encryption (bank details)            │
└─────────────────────────────────────────────────────────┘
```

### 5.2 Data Protection

1. **At Rest**:
   - Firestore: Encrypted by default (AES-256)
   - Firebase Storage: Server-side encryption
   - Sensitive fields: Additional application-level encryption

2. **In Transit**:
   - HTTPS/TLS 1.3 for all API communication
   - Certificate pinning in mobile apps
   - Secure WebSocket for real-time data

3. **PII Protection**:
   - Phone numbers: Hashed for search indexes
   - Bank details: Encrypted with customer-managed keys
   - Addresses: Accessible only to user and assigned provider

### 5.3 Compliance

- **GDPR**: Right to erasure, data portability
- **Indian Data Protection**: Data residency in Indian regions
- **PCI DSS**: Payment data never stored (Razorpay handles)

---

## 6. Scalability & Performance

### 6.1 Horizontal Scaling Strategy

```
┌───────────────────────────────────────────────────────┐
│              LOAD BALANCING                            │
│  ┌───────────────────────────────────────────────┐   │
│  │   Firebase Cloud Functions Auto-Scaling       │   │
│  │  - Automatic instance provisioning            │   │
│  │  - Concurrent request handling (1000+)        │   │
│  └───────────────────────────────────────────────┘   │
└───────────────────────────────────────────────────────┘
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│  Function    │ │  Function    │ │  Function    │
│  Instance 1  │ │  Instance 2  │ │  Instance N  │
└──────────────┘ └──────────────┘ └──────────────┘
        │               │               │
        └───────────────┼───────────────┘
                        ▼
              ┌──────────────────┐
              │    Firestore     │
              │  (Auto-sharded)  │
              └──────────────────┘
```

### 6.2 Caching Strategy

**Multi-Level Caching**:

1. **Client-Side** (Mobile Apps):
   - Firestore offline persistence
   - Image caching (URLCache)
   - Response caching (7 days for static data)

2. **Server-Side** (Cloud Functions):
   - Redis cache for frequent queries
   - Service catalog cache (TTL: 1 hour)
   - Provider availability cache (TTL: 5 minutes)

3. **CDN** (Firebase Hosting):
   - Static assets (images, CSS, JS)
   - Web app bundles
   - Edge caching for global delivery

### 6.3 Database Optimization

1. **Indexing**:
   - Composite indexes for common queries
   - Geo-indexing for location-based searches

2. **Denormalization**:
   - Embed frequently accessed data
   - Provider summary in booking documents
   - Service details in booking records

3. **Sharding** (Future):
   - City-based data partitioning
   - Horizontal scaling as data grows

### 6.4 Performance Targets

| Metric | Target | Monitoring |
|--------|--------|------------|
| API Response Time (p95) | < 300ms | Firebase Performance |
| App Launch Time | < 2s | Firebase Performance |
| Booking Creation | < 5s | Custom metrics |
| Payment Verification | < 2s | Razorpay webhooks |
| Real-time Updates | < 1s | Firestore listeners |

---

## 7. Deployment Architecture

### 7.1 Environment Separation

```
┌─────────────────────────────────────────────────────────┐
│                  DEVELOPMENT                             │
│  Firebase Project: cityserve-dev                         │
│  - Local emulators                                       │
│  - Test data                                             │
│  - No rate limiting                                      │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│                  STAGING                                 │
│  Firebase Project: cityserve-staging                     │
│  - Production-like setup                                 │
│  - Sample production data                                │
│  - QA testing environment                                │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│                  PRODUCTION                              │
│  Firebase Project: cityserve-prod                        │
│  - Live customer data                                    │
│  - Full monitoring                                       │
│  - Auto-scaling enabled                                  │
└─────────────────────────────────────────────────────────┘
```

### 7.2 CI/CD Pipeline

```
┌──────────────┐
│   Git Push   │
│  to GitHub   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│GitHub Actions│
│   Trigger    │
└──────┬───────┘
       │
       ▼
┌──────────────────────────────────────┐
│         BUILD STAGE                  │
│  1. Lint code (ESLint, SwiftLint)   │
│  2. Run unit tests                   │
│  3. Build iOS app (Xcode Cloud)      │
│  4. Build Android app (Gradle)       │
│  5. Build Cloud Functions            │
└──────┬───────────────────────────────┘
       │
       ▼
┌──────────────────────────────────────┐
│         TEST STAGE                   │
│  1. Integration tests                │
│  2. Security scanning                │
│  3. Firestore rules testing          │
└──────┬───────────────────────────────┘
       │
       ▼
┌──────────────────────────────────────┐
│       DEPLOY STAGE                   │
│  1. Deploy to Staging                │
│  2. Run smoke tests                  │
│  3. Manual approval (Production)     │
│  4. Deploy to Production             │
│  5. Health checks                    │
└──────────────────────────────────────┘
```

---

## 8. Technology Stack

### Complete Technology Matrix

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Mobile - iOS** | SwiftUI | Declarative UI framework |
| | Combine | Reactive programming |
| | Firebase iOS SDK | Backend integration |
| | Razorpay iOS SDK | Payment processing |
| | Google Maps SDK | Location services |
| **Mobile - Android** | Kotlin | Programming language |
| | Jetpack Compose | UI framework |
| | Firebase Android SDK | Backend integration |
| | Razorpay Android SDK | Payment processing |
| | Google Maps SDK | Location services |
| **Web** | Next.js 14+ | React framework |
| | TypeScript | Type safety |
| | Tailwind CSS | Styling |
| | Shadcn/ui | Component library |
| **Backend** | Cloud Functions | Serverless compute |
| | Node.js / TypeScript | Runtime & language |
| | Express.js | HTTP framework |
| **Database** | Cloud Firestore | Primary NoSQL database |
| | Firebase Realtime DB | Live tracking |
| | Redis (Cloud Memorystore) | Caching layer |
| | BigQuery | Data warehousing |
| **Auth** | Firebase Authentication | User authentication |
| **Storage** | Firebase Storage | File storage |
| **Payments** | Razorpay | Payment gateway |
| **SMS** | MSG91 | SMS notifications |
| **Email** | SendGrid | Email delivery |
| **Push Notifications** | Firebase Cloud Messaging | Push notifications |
| **Maps** | Google Maps Platform | Geocoding, directions |
| **Analytics** | Firebase Analytics | App analytics |
| | Google Analytics | Web analytics |
| **Monitoring** | Firebase Crashlytics | Crash reporting |
| | Firebase Performance | Performance monitoring |
| | Sentry | Error tracking |
| **CI/CD** | GitHub Actions | Automation |
| | Xcode Cloud | iOS builds |
| **Version Control** | GitHub | Code repository |

---

## 9. Integration Architecture

### 9.1 Third-Party Integrations

**Payment Integration (Razorpay)**:
```
App → Create Order → Cloud Function → Razorpay API
                                     ↓
                              Order ID returned
                                     ↓
App → Razorpay Checkout SDK → Payment Success/Failure
                                     ↓
Cloud Function ← Webhook ← Razorpay (Payment Verified)
                 ↓
         Update Firestore
```

**SMS Integration (MSG91)**:
```
Event Trigger → Cloud Function → MSG91 API → SMS Sent
(Booking created)
```

**Maps Integration (Google Maps)**:
```
App → Geocoding API → Lat/Long from Address
App → Directions API → Route from Provider to Customer
App → Places API → Address Autocomplete
```

### 9.2 Webhook Management

**Inbound Webhooks**:
- Razorpay payment status updates
- SMS delivery reports (MSG91)

**Outbound Webhooks** (Future):
- Booking status updates to enterprise clients
- Analytics data export

---

## 10. Monitoring & Observability

### 10.1 Monitoring Stack

```
┌──────────────────────────────────────────────────┐
│        APPLICATION MONITORING                    │
│  - Firebase Crashlytics (Crash reports)          │
│  - Firebase Performance (App metrics)            │
│  - Sentry (Error tracking with context)          │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│        INFRASTRUCTURE MONITORING                 │
│  - Cloud Functions metrics (Invocations, latency)│
│  - Firestore metrics (Reads, writes, storage)    │
│  - Firebase Hosting (Requests, bandwidth)        │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│        BUSINESS METRICS                          │
│  - Booking success rate                          │
│  - Payment conversion                            │
│  - Provider acceptance rate                      │
│  - Customer satisfaction (ratings)               │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│        ALERTING                                  │
│  - Firebase Alerts (Budget, quota, performance)  │
│  - Slack notifications                           │
│  - Email alerts for critical issues              │
└──────────────────────────────────────────────────┘
```

### 10.2 Logging Strategy

1. **Application Logs**:
   - Cloud Functions: Structured JSON logs via Winston
   - Mobile Apps: Firebase Crashlytics + console logs

2. **Audit Logs**:
   - All booking state changes
   - Payment transactions
   - Admin actions (KYC approvals, refunds)

3. **Log Aggregation**:
   - Cloud Logging (Google Cloud)
   - Searchable via Log Explorer
   - Retention: 30 days (standard), 90 days (audit logs)

### 10.3 Health Checks

**System Health Endpoints**:
- `/health` - Overall system status
- `/health/database` - Firestore connectivity
- `/health/payments` - Razorpay integration status

**Uptime Monitoring**:
- Uptime checks via Firebase Monitoring
- Third-party monitoring (Pingdom/UptimeRobot)

---

## Document Metadata

**Created**: December 2025
**Platform**: CityServe / UrbanNest
**Architecture**: Serverless, Event-Driven, Multi-Platform
**Version**: 1.0
**Last Updated**: December 30, 2025
