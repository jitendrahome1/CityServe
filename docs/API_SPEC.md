# API_SPEC.md

**CityServe / UrbanNest Platform - Cloud Functions API Specification**

---

## Table of Contents

1. [API Overview](#api-overview)
2. [Authentication](#authentication)
3. [Auth APIs](#auth-apis)
4. [User APIs](#user-apis)
5. [Service & Category APIs](#service--category-apis)
6. [Booking APIs](#booking-apis)
7. [Provider Matching APIs](#provider-matching-apis)
8. [Payment APIs](#payment-apis)
9. [Review APIs](#review-apis)
10. [Notification APIs](#notification-apis)
11. [Admin APIs](#admin-apis)
12. [Error Handling](#error-handling)
13. [Rate Limiting](#rate-limiting)

---

## 1. API Overview

### Base URL

```
Production: https://asia-south1-cityserve-prod.cloudfunctions.net/api
Staging:    https://asia-south1-cityserve-staging.cloudfunctions.net/api
Development: http://localhost:5001/cityserve-dev/asia-south1/api
```

### API Architecture

- **Framework**: Firebase Cloud Functions (Node.js/TypeScript)
- **HTTP Framework**: Express.js
- **API Style**: RESTful
- **Authentication**: Firebase Auth + Custom JWT
- **Response Format**: JSON

### Common Headers

```http
Content-Type: application/json
Authorization: Bearer <firebase_id_token>
X-App-Version: <app_version>
X-Platform: ios | android | web
X-Device-ID: <device_unique_id>
```

### Standard Response Format

```typescript
// Success Response
{
  success: true,
  data: { /* response data */ },
  message: string | null,
  timestamp: string
}

// Error Response
{
  success: false,
  error: {
    code: string,
    message: string,
    details: object | null
  },
  timestamp: string
}
```

---

## 2. Authentication

### Authentication Methods

1. **Firebase ID Token** (Primary)
   - Obtained from Firebase Authentication SDK
   - Passed in `Authorization: Bearer <token>` header
   - Verified by Cloud Functions using Firebase Admin SDK

2. **Admin API Key** (Admin-only endpoints)
   - Passed in `X-Admin-API-Key` header
   - For internal admin operations

### Token Refresh

- Tokens expire after 1 hour
- Client should refresh token automatically using Firebase SDK

---

## 3. Auth APIs

### 3.1 Create User Profile

**Endpoint**: `POST /auth/profile`

**Description**: Creates user profile after successful Firebase Authentication

**Authentication**: Required (Firebase ID Token)

**Request Body**:

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "+919876543210",
  "type": "customer",  // or "provider"
  "referralCode": "ABC123"  // optional
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "userId": "user123",
    "profile": {
      "id": "user123",
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+919876543210",
      "type": "customer",
      "status": "active",
      "createdAt": "2025-12-30T10:00:00Z"
    },
    "isNewUser": true
  },
  "message": "Profile created successfully",
  "timestamp": "2025-12-30T10:00:01Z"
}
```

### 3.2 Get Current User

**Endpoint**: `GET /auth/me`

**Description**: Retrieves current authenticated user's profile

**Authentication**: Required

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "id": "user123",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+919876543210",
    "type": "customer",
    "profileImage": "https://...",
    "addresses": [...],
    "walletBalance": 250.00
  }
}
```

### 3.3 Verify Phone OTP

**Endpoint**: `POST /auth/verify-phone`

**Description**: Backend verification of phone number (if needed for additional checks)

**Authentication**: Required

**Request Body**:

```json
{
  "phone": "+919876543210",
  "otp": "123456"
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "verified": true,
    "userId": "user123"
  },
  "message": "Phone verified successfully"
}
```

---

## 4. User APIs

### 4.1 Update Profile

**Endpoint**: `PATCH /users/:userId`

**Description**: Updates user profile information

**Authentication**: Required (User must own the profile)

**Request Body**:

```json
{
  "name": "John Updated",
  "email": "john.new@example.com",
  "profileImage": "https://storage.firebase.com/...",
  "notificationPrefs": {
    "push": true,
    "sms": false,
    "email": true
  }
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "userId": "user123",
    "updatedFields": ["name", "email", "notificationPrefs"]
  },
  "message": "Profile updated successfully"
}
```

### 4.2 Add Address

**Endpoint**: `POST /users/:userId/addresses`

**Description**: Adds a new address to user's profile

**Authentication**: Required

**Request Body**:

```json
{
  "label": "Home",
  "fullAddress": "123 Main Street, Apartment 4B",
  "landmark": "Near Central Park",
  "cityId": "city_delhi",
  "zoneId": "zone_south_delhi",
  "location": {
    "latitude": 28.5355,
    "longitude": 77.3910
  },
  "isDefault": true
}
```

**Response** (`201 Created`):

```json
{
  "success": true,
  "data": {
    "addressId": "addr123",
    "address": { /* full address object */ }
  },
  "message": "Address added successfully"
}
```

### 4.3 Delete Address

**Endpoint**: `DELETE /users/:userId/addresses/:addressId`

**Authentication**: Required

**Response** (`200 OK`):

```json
{
  "success": true,
  "message": "Address deleted successfully"
}
```

### 4.4 Get Wallet Balance

**Endpoint**: `GET /users/:userId/wallet`

**Authentication**: Required

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "balance": 250.00,
    "currency": "INR",
    "transactions": [
      {
        "id": "txn123",
        "type": "credit",
        "amount": 100.00,
        "description": "Refund for booking #12345",
        "timestamp": "2025-12-29T15:30:00Z"
      }
    ]
  }
}
```

---

## 5. Service & Category APIs

### 5.1 Get All Categories

**Endpoint**: `GET /categories`

**Description**: Retrieves all active service categories

**Authentication**: Not required (Public)

**Query Parameters**:
- `cityId` (optional): Filter by city

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "categories": [
      {
        "id": "cat_cleaning",
        "name": "Home Cleaning",
        "description": "Professional cleaning services",
        "icon": "https://...",
        "imageUrl": "https://...",
        "servicesCount": 12
      }
    ]
  }
}
```

### 5.2 Get Services by Category

**Endpoint**: `GET /categories/:categoryId/services`

**Description**: Retrieves all services in a category

**Authentication**: Not required (Public)

**Query Parameters**:
- `cityId` (required): Filter by city
- `limit` (optional, default: 20)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "services": [
      {
        "id": "service_ac_repair",
        "name": "AC Repair & Service",
        "description": "Expert AC repair and maintenance",
        "basePrice": 499,
        "estimatedDuration": 60,
        "imageUrl": "https://...",
        "rating": 4.5,
        "totalBookings": 12500
      }
    ],
    "totalCount": 12
  }
}
```

### 5.3 Get Service Details

**Endpoint**: `GET /services/:serviceId`

**Description**: Retrieves detailed information about a service

**Authentication**: Not required (Public)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "service": {
      "id": "service_ac_repair",
      "name": "AC Repair & Service",
      "description": "Comprehensive AC repair...",
      "categoryId": "cat_home_repair",
      "basePrice": 499,
      "priceUnit": "fixed",
      "estimatedDuration": 60,
      "whatIncluded": ["Gas check", "Filter cleaning", ...],
      "whatNotIncluded": ["Gas refill", "Part replacement"],
      "requirements": ["Access to AC unit", "Power supply"],
      "imageUrl": "https://...",
      "gallery": ["https://...", "https://..."],
      "rating": 4.5,
      "totalReviews": 3200,
      "totalBookings": 12500
    }
  }
}
```

### 5.4 Search Services

**Endpoint**: `GET /services/search`

**Description**: Search services by keyword

**Authentication**: Not required (Public)

**Query Parameters**:
- `q` (required): Search query
- `cityId` (required)
- `limit` (optional, default: 10)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "results": [ /* array of services */ ],
    "totalCount": 5
  }
}
```

---

## 6. Booking APIs

### 6.1 Create Booking

**Endpoint**: `POST /bookings`

**Description**: Creates a new service booking

**Authentication**: Required (Customer only)

**Request Body**:

```json
{
  "serviceId": "service_ac_repair",
  "scheduledDate": "2025-12-31T10:00:00Z",
  "addressId": "addr123",  // or provide full address object
  "specialInstructions": "Please bring tools for split AC",
  "promoCode": "FIRST100"
}
```

**Response** (`201 Created`):

```json
{
  "success": true,
  "data": {
    "booking": {
      "id": "booking123",
      "bookingNumber": "URB123456",
      "serviceId": "service_ac_repair",
      "status": "requested",
      "scheduledDate": "2025-12-31T10:00:00Z",
      "pricing": {
        "basePrice": 499,
        "taxes": 89.82,
        "discount": 100,
        "surgeFee": 0,
        "totalPrice": 488.82
      },
      "payment": {
        "method": null,
        "status": "pending"
      }
    },
    "razorpayOrder": {
      "orderId": "order_xyz",
      "amount": 48882,  // in paise
      "currency": "INR"
    }
  },
  "message": "Booking created successfully. Complete payment to confirm."
}
```

### 6.2 Get Booking Details

**Endpoint**: `GET /bookings/:bookingId`

**Description**: Retrieves detailed booking information

**Authentication**: Required (Customer or assigned Provider)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "booking": {
      "id": "booking123",
      "bookingNumber": "URB123456",
      "customerId": "user123",
      "customer": {
        "name": "John Doe",
        "phone": "+919876543210",
        "profileImage": "https://..."
      },
      "providerId": "provider456",
      "provider": {
        "name": "Rajesh Kumar",
        "phone": "+919123456789",
        "profileImage": "https://...",
        "rating": 4.8
      },
      "service": { /* service details */ },
      "status": "provider_accepted",
      "scheduledDate": "2025-12-31T10:00:00Z",
      "address": { /* full address */ },
      "pricing": { /* pricing breakdown */ },
      "payment": { /* payment details */ },
      "timeline": [
        {
          "status": "requested",
          "timestamp": "2025-12-30T14:00:00Z",
          "actor": "customer"
        },
        {
          "status": "provider_assigned",
          "timestamp": "2025-12-30T14:02:00Z",
          "actor": "system"
        }
      ]
    }
  }
}
```

### 6.3 Get User's Bookings

**Endpoint**: `GET /users/:userId/bookings`

**Description**: Retrieves all bookings for a user

**Authentication**: Required

**Query Parameters**:
- `status` (optional): Filter by status
- `limit` (optional, default: 10)
- `offset` (optional, default: 0)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "bookings": [ /* array of booking objects */ ],
    "totalCount": 25,
    "hasMore": true
  }
}
```

### 6.4 Cancel Booking

**Endpoint**: `POST /bookings/:bookingId/cancel`

**Description**: Cancels a booking

**Authentication**: Required (Customer or Provider)

**Request Body**:

```json
{
  "reason": "Changed plans",
  "requestRefund": true
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "bookingId": "booking123",
    "status": "cancelled",
    "refund": {
      "amount": 488.82,
      "status": "processing",
      "estimatedTime": "3-5 business days"
    }
  },
  "message": "Booking cancelled successfully. Refund initiated."
}
```

### 6.5 Update Booking Status (Provider)

**Endpoint**: `PATCH /bookings/:bookingId/status`

**Description**: Provider updates booking status

**Authentication**: Required (Provider only)

**Request Body**:

```json
{
  "status": "in_progress",  // or "completed"
  "note": "Started service",
  "location": {  // optional, for tracking
    "latitude": 28.5355,
    "longitude": 77.3910
  }
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "bookingId": "booking123",
    "status": "in_progress",
    "updatedAt": "2025-12-31T10:15:00Z"
  },
  "message": "Booking status updated"
}
```

---

## 7. Provider Matching APIs

### 7.1 Find Available Providers

**Endpoint**: `POST /matching/find-providers`

**Description**: Finds available providers for a service

**Authentication**: Required (Internal/Admin use)

**Request Body**:

```json
{
  "serviceId": "service_ac_repair",
  "location": {
    "latitude": 28.5355,
    "longitude": 77.3910
  },
  "scheduledDate": "2025-12-31T10:00:00Z",
  "cityId": "city_delhi",
  "zoneId": "zone_south_delhi"
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "providers": [
      {
        "providerId": "provider456",
        "name": "Rajesh Kumar",
        "rating": 4.8,
        "completedBookings": 250,
        "distance": 2.5,  // in km
        "estimatedETA": 20,  // in minutes
        "matchScore": 0.95  // 0-1 score
      }
    ],
    "totalCount": 5
  }
}
```

### 7.2 Assign Provider

**Endpoint**: `POST /bookings/:bookingId/assign-provider`

**Description**: Assigns a specific provider to booking

**Authentication**: Required (System/Admin)

**Request Body**:

```json
{
  "providerId": "provider456"
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "bookingId": "booking123",
    "providerId": "provider456",
    "status": "provider_assigned",
    "notificationSent": true
  },
  "message": "Provider assigned and notified"
}
```

### 7.3 Provider Accept/Reject Booking

**Endpoint**: `POST /bookings/:bookingId/respond`

**Description**: Provider accepts or rejects a booking

**Authentication**: Required (Provider only)

**Request Body**:

```json
{
  "action": "accept",  // or "reject"
  "reason": "Not available"  // required if reject
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "bookingId": "booking123",
    "status": "provider_accepted",
    "estimatedArrival": "2025-12-31T10:15:00Z"
  },
  "message": "Booking accepted successfully"
}
```

---

## 8. Payment APIs

### 8.1 Create Payment Order

**Endpoint**: `POST /payments/create-order`

**Description**: Creates Razorpay payment order for booking

**Authentication**: Required (Customer)

**Request Body**:

```json
{
  "bookingId": "booking123"
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "orderId": "order_xyz123",
    "amount": 48882,  // in paise
    "currency": "INR",
    "razorpayOrderId": "order_xyz123",
    "notes": {
      "bookingId": "booking123",
      "serviceId": "service_ac_repair"
    }
  },
  "message": "Payment order created"
}
```

### 8.2 Verify Payment

**Endpoint**: `POST /payments/verify`

**Description**: Verifies Razorpay payment signature

**Authentication**: Required (Customer)

**Request Body**:

```json
{
  "bookingId": "booking123",
  "razorpayOrderId": "order_xyz123",
  "razorpayPaymentId": "pay_abc456",
  "razorpaySignature": "signature_hash"
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "paymentId": "payment123",
    "bookingId": "booking123",
    "status": "success",
    "amount": 488.82,
    "verifiedAt": "2025-12-30T14:30:00Z"
  },
  "message": "Payment verified successfully. Booking confirmed."
}
```

### 8.3 Request Refund

**Endpoint**: `POST /payments/:paymentId/refund`

**Description**: Initiates refund for a payment

**Authentication**: Required (Admin or Customer with valid reason)

**Request Body**:

```json
{
  "reason": "Service cancelled by provider",
  "amount": 488.82  // optional, defaults to full amount
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "refundId": "refund123",
    "paymentId": "payment123",
    "amount": 488.82,
    "status": "processing",
    "estimatedTime": "3-5 business days"
  },
  "message": "Refund initiated successfully"
}
```

### 8.4 Get Payment History

**Endpoint**: `GET /users/:userId/payments`

**Description**: Retrieves payment history for user

**Authentication**: Required

**Query Parameters**:
- `limit` (optional, default: 10)
- `offset` (optional, default: 0)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "payments": [
      {
        "id": "payment123",
        "bookingNumber": "URB123456",
        "amount": 488.82,
        "status": "success",
        "method": "upi",
        "createdAt": "2025-12-30T14:30:00Z"
      }
    ],
    "totalCount": 15
  }
}
```

---

## 9. Review APIs

### 9.1 Create Review

**Endpoint**: `POST /bookings/:bookingId/review`

**Description**: Customer submits review for completed booking

**Authentication**: Required (Customer who made the booking)

**Request Body**:

```json
{
  "rating": 5,
  "comment": "Excellent service! Very professional.",
  "categoryRatings": {
    "punctuality": 5,
    "quality": 5,
    "professionalism": 5,
    "cleanliness": 4
  },
  "photos": ["https://...", "https://..."]
}
```

**Response** (`201 Created`):

```json
{
  "success": true,
  "data": {
    "reviewId": "review123",
    "bookingId": "booking123",
    "rating": 5,
    "status": "pending"  // pending moderation
  },
  "message": "Review submitted successfully"
}
```

### 9.2 Get Service Reviews

**Endpoint**: `GET /services/:serviceId/reviews`

**Description**: Retrieves approved reviews for a service

**Authentication**: Not required (Public)

**Query Parameters**:
- `limit` (optional, default: 10)
- `minRating` (optional): Filter by minimum rating

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "reviews": [
      {
        "id": "review123",
        "customer": {
          "name": "John D.",  // Anonymized
          "profileImage": "https://..."
        },
        "rating": 5,
        "comment": "Excellent service!",
        "createdAt": "2025-12-29T18:00:00Z",
        "helpfulCount": 12
      }
    ],
    "averageRating": 4.6,
    "totalReviews": 3200,
    "ratingDistribution": {
      "5": 2100,
      "4": 800,
      "3": 200,
      "2": 50,
      "1": 50
    }
  }
}
```

### 9.3 Provider Response to Review

**Endpoint**: `POST /reviews/:reviewId/respond`

**Description**: Provider responds to customer review

**Authentication**: Required (Provider mentioned in review)

**Request Body**:

```json
{
  "response": "Thank you for your kind words! Happy to serve you."
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "reviewId": "review123",
    "providerResponse": "Thank you for your kind words!",
    "respondedAt": "2025-12-30T10:00:00Z"
  },
  "message": "Response added successfully"
}
```

---

## 10. Notification APIs

### 10.1 Register Device Token

**Endpoint**: `POST /notifications/register-device`

**Description**: Registers FCM device token for push notifications

**Authentication**: Required

**Request Body**:

```json
{
  "fcmToken": "fcm_token_xyz",
  "platform": "ios",  // or "android"
  "deviceId": "device_unique_id"
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "message": "Device registered for push notifications"
}
```

### 10.2 Get User Notifications

**Endpoint**: `GET /users/:userId/notifications`

**Description**: Retrieves user's notifications

**Authentication**: Required

**Query Parameters**:
- `limit` (optional, default: 20)
- `unreadOnly` (optional, boolean)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "notif123",
        "type": "booking_update",
        "title": "Booking Confirmed",
        "body": "Your AC repair is scheduled for Dec 31 at 10 AM",
        "imageUrl": null,
        "isRead": false,
        "actionType": "open_booking",
        "actionData": {
          "bookingId": "booking123"
        },
        "createdAt": "2025-12-30T14:35:00Z"
      }
    ],
    "unreadCount": 3
  }
}
```

### 10.3 Mark Notification as Read

**Endpoint**: `PATCH /notifications/:notificationId/read`

**Description**: Marks notification as read

**Authentication**: Required

**Response** (`200 OK`):

```json
{
  "success": true,
  "message": "Notification marked as read"
}
```

---

## 11. Admin APIs

### 11.1 Approve Provider KYC

**Endpoint**: `POST /admin/providers/:providerId/approve-kyc`

**Description**: Admin approves provider KYC documents

**Authentication**: Required (Admin only)

**Request Body**:

```json
{
  "status": "approved",  // or "rejected"
  "reason": "Documents verified successfully"  // or rejection reason
}
```

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "providerId": "provider456",
    "kycStatus": "approved",
    "approvedAt": "2025-12-30T15:00:00Z"
  },
  "message": "KYC approved successfully"
}
```

### 11.2 Get Platform Analytics

**Endpoint**: `GET /admin/analytics`

**Description**: Retrieves platform analytics

**Authentication**: Required (Admin only)

**Query Parameters**:
- `startDate` (required)
- `endDate` (required)
- `cityId` (optional)

**Response** (`200 OK`):

```json
{
  "success": true,
  "data": {
    "overview": {
      "totalBookings": 1250,
      "completedBookings": 1100,
      "revenue": 625000,
      "activeProviders": 450,
      "activeCustomers": 8500
    },
    "bookingsByStatus": {
      "completed": 1100,
      "in_progress": 50,
      "cancelled": 100
    },
    "topServices": [
      {
        "serviceId": "service_ac_repair",
        "name": "AC Repair",
        "bookings": 320
      }
    ]
  }
}
```

### 11.3 Manage Service Catalog

**Endpoint**: `POST /admin/services`

**Description**: Creates or updates service

**Authentication**: Required (Admin only)

**Request Body**:

```json
{
  "name": "Refrigerator Repair",
  "description": "Expert refrigerator repair services",
  "categoryId": "cat_home_repair",
  "basePrice": 599,
  "estimatedDuration": 90,
  "whatIncluded": [...],
  "isActive": true
}
```

**Response** (`201 Created`):

```json
{
  "success": true,
  "data": {
    "serviceId": "service_fridge_repair",
    "service": { /* full service object */ }
  },
  "message": "Service created successfully"
}
```

---

## 12. Error Handling

### Standard Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `AUTH_REQUIRED` | 401 | Authentication token missing or invalid |
| `FORBIDDEN` | 403 | User lacks permission for action |
| `NOT_FOUND` | 404 | Resource not found |
| `VALIDATION_ERROR` | 400 | Request validation failed |
| `BOOKING_CONFLICT` | 409 | Provider already booked for time slot |
| `PAYMENT_FAILED` | 402 | Payment processing failed |
| `RATE_LIMIT_EXCEEDED` | 429 | Too many requests |
| `INTERNAL_ERROR` | 500 | Server error |

### Error Response Example

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request data",
    "details": {
      "field": "scheduledDate",
      "issue": "Date must be in the future"
    }
  },
  "timestamp": "2025-12-30T10:00:00Z"
}
```

---

## 13. Rate Limiting

### Rate Limit Policy

| Endpoint Type | Rate Limit | Window |
|---------------|------------|--------|
| Public APIs (unauthenticated) | 60 requests | 1 minute |
| Authenticated User APIs | 300 requests | 5 minutes |
| Provider Availability Updates | 100 requests | 5 minutes |
| Admin APIs | 1000 requests | 5 minutes |

### Rate Limit Headers

```http
X-RateLimit-Limit: 300
X-RateLimit-Remaining: 287
X-RateLimit-Reset: 1640865000
```

### Rate Limit Exceeded Response

```json
{
  "success": false,
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please try again later.",
    "details": {
      "retryAfter": 120  // seconds
    }
  },
  "timestamp": "2025-12-30T10:00:00Z"
}
```

---

## Document Metadata

**Created**: December 2025
**Platform**: CityServe / UrbanNest
**Backend**: Firebase Cloud Functions (Node.js/TypeScript)
**Version**: 1.0
**Last Updated**: December 30, 2025
