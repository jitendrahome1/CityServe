# WEB_CUSTOMER_PORTAL.md

**UrbanNest Customer Web Portal - Complete Documentation**

---

## Table of Contents

1. [Overview](#overview)
2. [Technology Stack](#technology-stack)
3. [Authentication & Registration](#authentication--registration)
4. [User Interface Structure](#user-interface-structure)
5. [Core Features](#core-features)
6. [Component Architecture](#component-architecture)
7. [API Integration](#api-integration)
8. [SEO Optimization](#seo-optimization)
9. [Progressive Web App (PWA)](#progressive-web-app-pwa)
10. [Responsive Design](#responsive-design)

---

## 1. Overview

### Purpose
The UrbanNest Customer Web Portal is a responsive, SEO-optimized website that allows customers to browse, book, and manage professional home services through their web browser.

### Target Users
- **Primary**: Desktop users researching services before booking
- **Secondary**: Mobile web users seeking quick service booking
- **Tertiary**: Users without the mobile app installed

### Key Objectives
1. **Service Discovery**: Help customers find the right service easily
2. **Seamless Booking**: Simple, intuitive booking process
3. **Trust Building**: Showcase verified providers, reviews, and guarantees
4. **SEO Visibility**: Rank well for service-related searches
5. **Conversion Optimization**: Convert visitors to customers

---

## 2. Technology Stack

### Frontend Framework
- **Next.js 14+**: React framework with App Router
- **React 18**: UI library
- **TypeScript**: Type-safe development

### Styling & UI
- **Tailwind CSS**: Utility-first CSS framework
- **Shadcn/ui**: Component library (built on Radix UI)
- **Framer Motion**: Animations and transitions
- **Lucide Icons**: Icon library

### State Management
- **Zustand**: Lightweight state management
- **React Context**: For theme and auth state
- **SWR**: Data fetching and caching

### Forms & Validation
- **React Hook Form**: Form handling
- **Zod**: Schema validation

### Backend Integration
- **Firebase JavaScript SDK**: Client-side Firebase
- **Axios**: HTTP client for Cloud Functions

### Maps & Location
- **Google Maps JavaScript API**: Location selection
- **Google Places Autocomplete**: Address input

### Payment
- **Razorpay Checkout.js**: Payment integration

### Analytics & Monitoring
- **Google Analytics 4**: User behavior tracking
- **Firebase Analytics**: App-specific tracking
- **Vercel Analytics**: Performance monitoring (if hosted on Vercel)

### Development Tools
- **ESLint**: Code linting
- **Prettier**: Code formatting
- **Husky**: Git hooks
- **Jest**: Unit testing
- **Playwright**: E2E testing

### Deployment
- **Firebase Hosting**: Production hosting
- **Vercel** (Alternative): Hosting with SSR support

---

## 3. Authentication & Registration

### 3.1 Registration Methods

#### Option 1: Phone Number Registration (Primary Method)

**Flow:**
```
1. User lands on homepage
2. Clicks "Sign Up" or "Book Service" (triggers auth)
3. Modal/Page opens with phone input
4. Enters +91XXXXXXXXXX
5. Clicks "Send OTP"
6. Receives 6-digit OTP via SMS (MSG91)
7. Enters OTP within 5 minutes
8. Firebase verifies OTP
9. Profile creation screen:
   - Full Name (required)
   - Email (optional)
   - City selection (required)
10. Account created → Redirect to dashboard
```

**Technical Implementation:**
```typescript
// hooks/usePhoneAuth.ts
import { getAuth, RecaptchaVerifier, signInWithPhoneNumber } from 'firebase/auth';

export const usePhoneAuth = () => {
  const sendOTP = async (phoneNumber: string) => {
    const auth = getAuth();
    const recaptchaVerifier = new RecaptchaVerifier('recaptcha-container', {
      'size': 'invisible'
    }, auth);

    const confirmationResult = await signInWithPhoneNumber(
      auth,
      phoneNumber,
      recaptchaVerifier
    );

    return confirmationResult;
  };

  const verifyOTP = async (confirmationResult, otp: string) => {
    const result = await confirmationResult.confirm(otp);
    return result.user;
  };

  return { sendOTP, verifyOTP };
};
```

#### Option 2: Email/Password Registration (Secondary Method)

**Flow:**
```
1. User clicks "Continue with Email"
2. Enter email and create password
3. Firebase creates account
4. Verification email sent
5. User clicks verification link
6. Profile setup (name, city)
7. Account activated
```

#### Option 3: Google Sign-In (Quick Registration)

**Flow:**
```
1. User clicks "Continue with Google"
2. Google OAuth popup opens
3. User selects Google account
4. Firebase receives Google credentials
5. Profile auto-created with Google info
6. Select city (only missing info)
7. Registration complete
```

**Technical Implementation:**
```typescript
// hooks/useGoogleAuth.ts
import { getAuth, GoogleAuthProvider, signInWithPopup } from 'firebase/auth';

export const useGoogleAuth = () => {
  const signInWithGoogle = async () => {
    const auth = getAuth();
    const provider = new GoogleAuthProvider();

    const result = await signInWithPopup(auth, provider);
    return result.user;
  };

  return { signInWithGoogle };
};
```

### 3.2 Session Management

**Persistence:**
- Firebase Auth persists session using IndexedDB
- Token automatically refreshed every hour
- Session timeout: 30 days (Firebase default)

**Protected Routes:**
```typescript
// middleware.ts (Next.js 14)
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const token = request.cookies.get('__session');

  if (!token && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/dashboard/:path*', '/bookings/:path*']
};
```

### 3.3 Profile Setup

**Initial Profile Fields:**
- Full Name (required)
- Email (optional if registered via phone)
- Phone Number (auto-filled from registration)
- Profile Photo (optional, can add later)
- Primary City (required)
- First Address (optional, can add during booking)

---

## 4. User Interface Structure

### 4.1 Page Hierarchy

```
/                           (Homepage)
├── /services               (Service Categories Grid)
│   └── /[categoryId]       (Category Detail Page)
│       └── /[serviceId]    (Service Detail Page)
├── /booking                (Booking Flow)
│   ├── /address            (Select/Add Address)
│   ├── /schedule           (Date & Time Selection)
│   ├── /review             (Review Booking)
│   └── /payment            (Payment Page)
├── /dashboard              (Customer Dashboard)
│   ├── /bookings           (All Bookings)
│   │   └── /[bookingId]    (Booking Detail & Tracking)
│   ├── /profile            (Profile Management)
│   ├── /addresses          (Manage Addresses)
│   ├── /wallet             (Wallet & Transactions)
│   └── /settings           (Account Settings)
├── /search                 (Search Results Page)
├── /about                  (About UrbanNest)
├── /how-it-works           (How It Works Page)
├── /become-professional    (Provider Registration Landing)
├── /help                   (Help Center)
└── /auth
    ├── /login              (Login Page)
    └── /register           (Registration Page)
```

### 4.2 Navigation Structure

**Header (Desktop):**
```
Logo | Services ▾ | How It Works | Become a Professional | Search 🔍 | City: Delhi ▾ | Login / Dashboard
```

**Header (Mobile):**
```
☰ | Logo | City: Delhi ▾ | 🔍
```

**Footer:**
```
Column 1: Services     Column 2: Company    Column 3: Support    Column 4: Social
- Home Cleaning        - About Us           - Help Center        - Facebook
- AC Repair            - Careers            - Contact Us         - Instagram
- Plumbing             - Press              - Terms              - Twitter
- View All             - Blog               - Privacy            - LinkedIn
```

### 4.3 Responsive Design Breakpoints

```css
/* Tailwind CSS Breakpoints */
sm:  640px    /* Small devices (phones) */
md:  768px    /* Medium devices (tablets) */
lg:  1024px   /* Large devices (laptops) */
xl:  1280px   /* Extra large devices (desktops) */
2xl: 1536px   /* 2X large devices (large desktops) */
```

**Layout Adjustments:**
- Mobile (<768px): Single column, hamburger menu
- Tablet (768-1024px): Two-column grid, simplified header
- Desktop (>1024px): Full layout, sticky header

---

## 5. Core Features

### 5.1 Homepage

**Sections:**

1. **Hero Section**
   - Headline: "Professional Services at Your Doorstep"
   - Subheadline: "Trusted experts for home cleaning, repairs, beauty & more"
   - Search bar with city selector
   - Primary CTA: "Book a Service"
   - Background: Hero image or video

2. **Service Categories Grid**
   - 8-12 popular categories with icons
   - Category cards clickable → Category detail page
   - "View All Services" button

3. **How It Works**
   - 3-step process:
     1. Choose Service → Icon of service selection
     2. Get Matched → Icon of provider assignment
     3. Service Done → Icon of completed service
   - Visual timeline or cards

4. **Why Choose UrbanNest**
   - 100% Verified Professionals
   - Transparent Pricing
   - Service Guarantee
   - 24/7 Support
   - Icons + Short descriptions

5. **Top-Rated Services**
   - Carousel of popular services
   - Service cards with:
     - Service image
     - Name
     - Starting price
     - Average rating
     - "Book Now" button

6. **Customer Testimonials**
   - Carousel of 3-5 reviews
   - Customer photo (if provided) or avatar
   - Rating stars
   - Review text
   - Service booked

7. **Become a Professional CTA**
   - Background image of provider
   - "Earn with UrbanNest"
   - "Join 10,000+ professionals"
   - CTA button → Provider registration

8. **Download App Section**
   - App store badges (iOS & Android)
   - App screenshots carousel
   - QR code for quick download

**Technical Implementation:**
```typescript
// app/page.tsx
import { HeroSection } from '@/components/home/HeroSection';
import { ServiceCategories } from '@/components/home/ServiceCategories';
import { HowItWorks } from '@/components/home/HowItWorks';
import { Testimonials } from '@/components/home/Testimonials';

export default async function HomePage() {
  // Server component - fetch initial data
  const categories = await getCategories();
  const topServices = await getTopServices();

  return (
    <main>
      <HeroSection />
      <ServiceCategories categories={categories} />
      <HowItWorks />
      <TopServices services={topServices} />
      <Testimonials />
      <BecomeProviderCTA />
      <DownloadApp />
    </main>
  );
}
```

### 5.2 Service Discovery

#### Service Categories Page (`/services`)

**Layout:**
- Grid of all service categories
- Filter/Sort options:
  - Sort by: Popularity, Price (Low to High), Rating
  - Filter by: City availability
- Search within services

**Category Card:**
- Category image
- Category name
- Number of services
- Starting price
- Click → Category detail page

#### Category Detail Page (`/services/[categoryId]`)

**Content:**
- Category hero image
- Category description
- Grid of services in this category
- Filter/Sort options
- Related categories

**Service Card:**
- Service image
- Service name
- Starting price: ₹499 onwards
- Rating (4.5 ⭐)
- Number of bookings
- "Book Now" button

#### Service Detail Page (`/services/[categoryId]/[serviceId]`)

**Sections:**

1. **Service Header**
   - Service name
   - Rating & reviews count
   - Breadcrumb (Home > Category > Service)
   - Share buttons

2. **Service Images**
   - Image gallery (4-6 images)
   - Main image + thumbnails
   - Lightbox on click

3. **Pricing & CTA**
   - Starting price: ₹499
   - Duration: ~60 minutes
   - "Book Now" button (sticky on mobile)
   - Offer banner (if applicable)

4. **Service Description**
   - Detailed description
   - What's Included (checklist)
   - What's Not Included (checklist)
   - Requirements (e.g., "Access to AC unit required")

5. **How It Works (Service-Specific)**
   - Step-by-step process for this service
   - Visual representation

6. **Why Book This Service**
   - Key benefits
   - Trust indicators (verified professionals, guarantee, etc.)

7. **Top-Rated Providers**
   - 3-4 provider cards
   - Provider photo, name, rating
   - Completed jobs count
   - "View Profile" link

8. **Customer Reviews**
   - Sortable reviews (Most Recent, Highest Rating)
   - Review cards with:
     - Customer name (anonymized)
     - Rating
     - Review text
     - Photos (if uploaded)
     - Service date
   - "Load More" pagination

9. **FAQ Section**
   - Accordion with common questions
   - Service-specific FAQs

10. **Similar Services**
    - Carousel of related services

**Technical Implementation:**
```typescript
// app/services/[categoryId]/[serviceId]/page.tsx
import { getService, getProviders, getReviews } from '@/lib/api';

export async function generateMetadata({ params }) {
  const service = await getService(params.serviceId);

  return {
    title: `${service.name} | UrbanNest`,
    description: service.description,
    openGraph: {
      images: [service.imageUrl],
    },
  };
}

export default async function ServiceDetailPage({ params }) {
  const service = await getService(params.serviceId);
  const providers = await getProviders(params.serviceId);
  const reviews = await getReviews(params.serviceId);

  return (
    <div>
      <ServiceHeader service={service} />
      <ServiceGallery images={service.gallery} />
      <ServiceInfo service={service} />
      <TopProviders providers={providers} />
      <ReviewsSection reviews={reviews} />
      <FAQSection faqs={service.faqs} />
    </div>
  );
}
```

### 5.3 Booking Flow

#### Step 1: Service Selection (Already Done on Service Detail Page)

#### Step 2: Address Selection (`/booking/address`)

**Options:**
1. **Select Saved Address**
   - List of user's saved addresses
   - Radio button selection
   - "Edit" and "Delete" options

2. **Add New Address**
   - Form fields:
     - Address Label (Home/Office/Other)
     - Full Address (Google Places Autocomplete)
     - Landmark (optional)
     - Pin location on map
   - "Save for future" checkbox
   - "Continue" button

**Technical Implementation:**
```typescript
// components/booking/AddressSelector.tsx
import { GoogleMap, Marker } from '@react-google-maps/api';
import { Autocomplete } from '@react-google-maps/api';

export function AddressSelector() {
  const [selectedAddress, setSelectedAddress] = useState<Address | null>(null);

  return (
    <div>
      <h2>Select Service Address</h2>
      <SavedAddresses
        addresses={userAddresses}
        onSelect={setSelectedAddress}
      />
      <div>OR</div>
      <AddNewAddress onSave={(address) => {
        saveAddress(address);
        setSelectedAddress(address);
      }} />
      <button onClick={() => navigateTo('/booking/schedule')}>
        Continue
      </button>
    </div>
  );
}
```

#### Step 3: Schedule Selection (`/booking/schedule`)

**Date Picker:**
- Calendar view (next 30 days)
- Disabled dates (past dates, fully booked)
- Highlighted available dates

**Time Slot Selection:**
- Available slots based on provider availability
- Slots: Morning (6-12), Afternoon (12-6), Evening (6-10)
- Specific time slots (e.g., 9:00 AM, 10:00 AM, etc.)
- Popular slots badged
- Unavailable slots grayed out

**Special Instructions:**
- Text area for additional notes
- Character limit: 500

**Continue Button:** → Review Booking

#### Step 4: Review & Confirm (`/booking/review`)

**Booking Summary:**
- Service details
- Selected provider (if chosen) or "Best match will be assigned"
- Date & time
- Address
- Special instructions

**Pricing Breakdown:**
- Service price: ₹499
- Taxes (GST 18%): ₹89.82
- Discount (if promo applied): -₹100
- **Total**: ₹488.82

**Promo Code:**
- Input field
- "Apply" button
- Success/error message

**Terms & Conditions:**
- Checkbox: "I agree to terms"
- Link to full terms

**CTA:** "Proceed to Payment"

#### Step 5: Payment (`/booking/payment`)

**Payment Options:**
- UPI
- Credit/Debit Card
- Net Banking
- Wallet (if balance available)

**Razorpay Integration:**
```typescript
// lib/razorpay.ts
declare global {
  interface Window {
    Razorpay: any;
  }
}

export const initiatePayment = (orderData, onSuccess, onFailure) => {
  const options = {
    key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
    amount: orderData.amount, // in paise
    currency: 'INR',
    name: 'UrbanNest',
    description: orderData.serviceDescription,
    order_id: orderData.razorpayOrderId,
    handler: function (response) {
      // Payment successful
      onSuccess({
        razorpayPaymentId: response.razorpay_payment_id,
        razorpayOrderId: response.razorpay_order_id,
        razorpaySignature: response.razorpay_signature
      });
    },
    prefill: {
      name: orderData.customerName,
      email: orderData.customerEmail,
      contact: orderData.customerPhone
    },
    theme: {
      color: '#0D7377'
    },
    modal: {
      ondismiss: function() {
        onFailure('Payment cancelled by user');
      }
    }
  };

  const razorpay = new window.Razorpay(options);
  razorpay.open();
};
```

**Payment Success:**
- Success message
- Booking ID displayed
- Booking details
- "Track Service" button
- Email and SMS confirmation sent

**Payment Failure:**
- Error message
- "Retry Payment" button
- Support contact information

### 5.4 Order Management

#### Active Bookings (`/dashboard/bookings?status=active`)

**Booking Card:**
- Service name & image
- Provider details (once assigned)
- Date & time
- Status badge (Pending, Confirmed, In Progress)
- "Track Service" button
- "Cancel" button (if eligible)

**Tracking View (`/dashboard/bookings/[bookingId]`):**
- Service timeline:
  - Booking Confirmed ✅
  - Provider Assigned ✅
  - Provider On the Way 🚗 (current)
  - Service Started ⏳
  - Service Completed ✅
- Provider location on map (real-time)
- ETA: 15 minutes
- Provider contact button
- Live chat (optional)

#### Order History (`/dashboard/bookings?status=completed`)

**Completed Booking Card:**
- Service name & date
- Provider name & rating
- Total amount paid
- Status: Completed ✅
- "Rate & Review" button (if not rated)
- "View Receipt" button
- "Book Again" button

#### Booking Detail Page (`/dashboard/bookings/[bookingId]`)

**Full Booking Information:**
- Service details
- Provider information
- Timeline of events
- Payment information
- Invoice/Receipt
- Photos (before/after service, if uploaded by provider)
- Rating & review (if given)

### 5.5 User Profile Management

#### Profile Page (`/dashboard/profile`)

**Editable Fields:**
- Profile Photo (upload/change)
- Full Name
- Email
- Phone Number (verified, cannot change)
- City

**Actions:**
- "Save Changes" button
- "Change Password" (if email/password auth)

#### Address Management (`/dashboard/addresses`)

**Address List:**
- Saved addresses with labels
- "Edit" and "Delete" for each
- "Add New Address" button

**Add/Edit Address Form:**
- Address Label
- Full Address (autocomplete)
- Landmark
- Map pin
- "Set as Default" checkbox

#### Wallet (`/dashboard/wallet`)

**Wallet Balance:**
- Current balance: ₹250.00
- "Add Money" button

**Transaction History:**
- Date
- Description (e.g., "Refund for Booking #URB12345")
- Amount (+ credit, - debit)
- Balance after transaction

#### Settings (`/dashboard/settings`)

**Notification Preferences:**
- Push Notifications (toggle)
- SMS Notifications (toggle)
- Email Notifications (toggle)
- Marketing Communications (toggle)

**Privacy:**
- Data Download
- Delete Account

**Logout:**
- "Logout" button

---

## 6. Component Architecture

### 6.1 Component Structure

```
components/
├── layout/
│   ├── Header.tsx
│   ├── Footer.tsx
│   ├── Sidebar.tsx
│   └── MobileNav.tsx
├── home/
│   ├── HeroSection.tsx
│   ├── ServiceCategories.tsx
│   ├── HowItWorks.tsx
│   ├── Testimonials.tsx
│   └── DownloadApp.tsx
├── services/
│   ├── ServiceCard.tsx
│   ├── ServiceGrid.tsx
│   ├── ServiceDetail.tsx
│   └── ServiceGallery.tsx
├── booking/
│   ├── AddressSelector.tsx
│   ├── DateTimePicker.tsx
│   ├── BookingSummary.tsx
│   └── PaymentForm.tsx
├── dashboard/
│   ├── BookingCard.tsx
│   ├── BookingTimeline.tsx
│   ├── ProfileForm.tsx
│   └── AddressForm.tsx
├── ui/ (Shadcn/ui components)
│   ├── button.tsx
│   ├── card.tsx
│   ├── input.tsx
│   ├── dialog.tsx
│   └── ...
└── shared/
    ├── SearchBar.tsx
    ├── CitySelector.tsx
    ├── RatingStars.tsx
    └── LoadingSpinner.tsx
```

### 6.2 Reusable Components

**ServiceCard:**
```typescript
// components/services/ServiceCard.tsx
interface ServiceCardProps {
  service: Service;
  onBook?: () => void;
}

export function ServiceCard({ service, onBook }: ServiceCardProps) {
  return (
    <div className="border rounded-lg p-4 hover:shadow-lg transition">
      <img src={service.imageUrl} alt={service.name} />
      <h3>{service.name}</h3>
      <div className="flex items-center gap-2">
        <RatingStars rating={service.rating} />
        <span>({service.totalReviews})</span>
      </div>
      <p className="text-2xl font-bold">₹{service.basePrice} onwards</p>
      <Button onClick={onBook}>Book Now</Button>
    </div>
  );
}
```

**RatingStars:**
```typescript
// components/shared/RatingStars.tsx
interface RatingStarsProps {
  rating: number; // 0-5
  size?: 'sm' | 'md' | 'lg';
}

export function RatingStars({ rating, size = 'md' }: RatingStarsProps) {
  const stars = Array.from({ length: 5 }, (_, i) => i + 1);

  return (
    <div className="flex">
      {stars.map((star) => (
        <Star
          key={star}
          className={cn(
            star <= rating ? 'text-yellow-400 fill-yellow-400' : 'text-gray-300',
            size === 'sm' && 'w-4 h-4',
            size === 'md' && 'w-5 h-5',
            size === 'lg' && 'w-6 h-6'
          )}
        />
      ))}
    </div>
  );
}
```

---

## 7. API Integration

### 7.1 API Client Setup

```typescript
// lib/api/client.ts
import axios from 'axios';
import { getAuth } from 'firebase/auth';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL;

export const apiClient = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
});

// Request interceptor - Add auth token
apiClient.interceptors.request.use(async (config) => {
  const auth = getAuth();
  const user = auth.currentUser;

  if (user) {
    const token = await user.getIdToken();
    config.headers.Authorization = `Bearer ${token}`;
  }

  return config;
});

// Response interceptor - Handle errors
apiClient.interceptors.response.use(
  (response) => response.data,
  (error) => {
    if (error.response?.status === 401) {
      // Redirect to login
      window.location.href = '/auth/login';
    }
    return Promise.reject(error);
  }
);
```

### 7.2 API Functions

```typescript
// lib/api/services.ts
export const getServices = async (cityId?: string) => {
  return apiClient.get('/services', { params: { cityId } });
};

export const getService = async (serviceId: string) => {
  return apiClient.get(`/services/${serviceId}`);
};

// lib/api/bookings.ts
export const createBooking = async (bookingData: CreateBookingDTO) => {
  return apiClient.post('/bookings', bookingData);
};

export const getBookings = async (userId: string, status?: string) => {
  return apiClient.get(`/users/${userId}/bookings`, { params: { status } });
};

export const cancelBooking = async (bookingId: string, reason: string) => {
  return apiClient.post(`/bookings/${bookingId}/cancel`, { reason });
};

// lib/api/payments.ts
export const createPaymentOrder = async (bookingId: string) => {
  return apiClient.post('/payments/create-order', { bookingId });
};

export const verifyPayment = async (paymentData: VerifyPaymentDTO) => {
  return apiClient.post('/payments/verify', paymentData);
};
```

### 7.3 Error Handling

```typescript
// hooks/useApi.ts
import { useState } from 'react';
import { toast } from 'sonner';

export function useApi<T>(apiFunction: (...args: any[]) => Promise<T>) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const execute = async (...args: any[]) => {
    try {
      setLoading(true);
      setError(null);
      const result = await apiFunction(...args);
      return result;
    } catch (err: any) {
      const errorMessage = err.response?.data?.error?.message || 'An error occurred';
      setError(errorMessage);
      toast.error(errorMessage);
      throw err;
    } finally {
      setLoading(false);
    }
  };

  return { execute, loading, error };
}

// Usage
const { execute: createBookingFn, loading } = useApi(createBooking);

const handleBooking = async () => {
  try {
    const booking = await createBookingFn(bookingData);
    navigate(`/bookings/${booking.id}`);
  } catch (error) {
    // Error already handled by useApi
  }
};
```

---

## 8. SEO Optimization

### 8.1 Meta Tags

```typescript
// app/services/[categoryId]/[serviceId]/page.tsx
import type { Metadata } from 'next';

export async function generateMetadata({ params }): Promise<Metadata> {
  const service = await getService(params.serviceId);

  return {
    title: `${service.name} in Delhi NCR | Starting at ₹${service.basePrice} | UrbanNest`,
    description: `Book professional ${service.name} service at home. ${service.description}. Verified professionals, transparent pricing, 100% satisfaction guaranteed.`,
    keywords: [
      service.name,
      `${service.name} near me`,
      `book ${service.name}`,
      `${service.name} at home`,
      'UrbanNest',
    ],
    openGraph: {
      title: service.name,
      description: service.description,
      images: [service.imageUrl],
      type: 'website',
    },
    twitter: {
      card: 'summary_large_image',
      title: service.name,
      description: service.description,
      images: [service.imageUrl],
    },
  };
}
```

### 8.2 Structured Data

```typescript
// components/SEO/ServiceStructuredData.tsx
export function ServiceStructuredData({ service }: { service: Service }) {
  const structuredData = {
    '@context': 'https://schema.org',
    '@type': 'Service',
    'name': service.name,
    'description': service.description,
    'provider': {
      '@type': 'Organization',
      'name': 'UrbanNest',
      'url': 'https://urbannest.in'
    },
    'areaServed': {
      '@type': 'City',
      'name': 'Delhi NCR'
    },
    'offers': {
      '@type': 'Offer',
      'price': service.basePrice,
      'priceCurrency': 'INR'
    },
    'aggregateRating': {
      '@type': 'AggregateRating',
      'ratingValue': service.rating,
      'reviewCount': service.totalReviews
    }
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(structuredData) }}
    />
  );
}
```

### 8.3 Sitemap

```typescript
// app/sitemap.ts
import { MetadataRoute } from 'next';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const services = await getAllServices();

  const serviceUrls = services.map((service) => ({
    url: `https://urbannest.in/services/${service.categoryId}/${service.id}`,
    lastModified: service.updatedAt,
    changeFrequency: 'weekly' as const,
    priority: 0.8,
  }));

  return [
    {
      url: 'https://urbannest.in',
      lastModified: new Date(),
      changeFrequency: 'daily',
      priority: 1,
    },
    {
      url: 'https://urbannest.in/services',
      lastModified: new Date(),
      changeFrequency: 'daily',
      priority: 0.9,
    },
    ...serviceUrls,
  ];
}
```

### 8.4 robots.txt

```
# public/robots.txt
User-agent: *
Allow: /
Disallow: /dashboard/
Disallow: /api/
Disallow: /admin/

Sitemap: https://urbannest.in/sitemap.xml
```

---

## 9. Progressive Web App (PWA)

### 9.1 Service Worker Setup

```typescript
// public/sw.js
const CACHE_NAME = 'urbannest-v1';
const urlsToCache = [
  '/',
  '/services',
  '/offline',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request)
      .then((response) => response || fetch(event.request))
      .catch(() => caches.match('/offline'))
  );
});
```

### 9.2 Web App Manifest

```json
// public/manifest.json
{
  "name": "UrbanNest - Professional Services at Home",
  "short_name": "UrbanNest",
  "description": "Book professional home services with verified experts",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#0D7377",
  "icons": [
    {
      "src": "/icons/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icons/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

### 9.3 Install Prompt

```typescript
// components/PWAInstallPrompt.tsx
'use client';

import { useState, useEffect } from 'react';

export function PWAInstallPrompt() {
  const [deferredPrompt, setDeferredPrompt] = useState<any>(null);
  const [showPrompt, setShowPrompt] = useState(false);

  useEffect(() => {
    window.addEventListener('beforeinstallprompt', (e) => {
      e.preventDefault();
      setDeferredPrompt(e);
      setShowPrompt(true);
    });
  }, []);

  const handleInstall = async () => {
    if (!deferredPrompt) return;

    deferredPrompt.prompt();
    const { outcome } = await deferredPrompt.userChoice;

    if (outcome === 'accepted') {
      setShowPrompt(false);
    }

    setDeferredPrompt(null);
  };

  if (!showPrompt) return null;

  return (
    <div className="fixed bottom-4 left-4 right-4 bg-white p-4 rounded-lg shadow-lg">
      <h3>Install UrbanNest</h3>
      <p>Get quick access to book services anytime!</p>
      <button onClick={handleInstall}>Install</button>
      <button onClick={() => setShowPrompt(false)}>Not Now</button>
    </div>
  );
}
```

---

## 10. Responsive Design

### 10.1 Mobile-First Approach

**Design Principles:**
- Design for mobile first, then scale up
- Touch-friendly buttons (min 44x44px)
- Simplified navigation on small screens
- Optimized images for mobile bandwidth

### 10.2 Responsive Components

```typescript
// components/layout/ResponsiveContainer.tsx
export function ResponsiveContainer({ children }) {
  return (
    <div className="
      container
      mx-auto
      px-4 sm:px-6 lg:px-8
      max-w-7xl
    ">
      {children}
    </div>
  );
}

// components/services/ServiceGrid.tsx
export function ServiceGrid({ services }) {
  return (
    <div className="
      grid
      grid-cols-1
      sm:grid-cols-2
      lg:grid-cols-3
      xl:grid-cols-4
      gap-4 sm:gap-6
    ">
      {services.map((service) => (
        <ServiceCard key={service.id} service={service} />
      ))}
    </div>
  );
}
```

### 10.3 Image Optimization

```typescript
// components/shared/OptimizedImage.tsx
import Image from 'next/image';

export function OptimizedImage({ src, alt, ...props }) {
  return (
    <Image
      src={src}
      alt={alt}
      loading="lazy"
      placeholder="blur"
      blurDataURL="/placeholder.jpg"
      {...props}
    />
  );
}
```

---

## Document Metadata

**Created**: December 2025
**Platform**: CityServe / UrbanNest
**Application**: Customer Web Portal (Next.js)
**Version**: 1.0
**Last Updated**: December 30, 2025
