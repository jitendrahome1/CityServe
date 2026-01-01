# Web Application Workflows - UrbanNest Platform

This document provides detailed step-by-step workflow diagrams for all critical user journeys in the UrbanNest platform, covering customer and provider interactions, admin operations, and system processes.

---

## Table of Contents

1. [Customer Registration Workflows](#1-customer-registration-workflows)
2. [Provider Onboarding & Approval Workflow](#2-provider-onboarding--approval-workflow)
3. [Customer Booking Flow](#3-customer-booking-flow)
4. [Admin Booking Management Workflow](#4-admin-booking-management-workflow)
5. [Refund Processing Workflow](#5-refund-processing-workflow)
6. [Service Catalog Management Workflow](#6-service-catalog-management-workflow)
7. [Dispute Resolution Workflow](#7-dispute-resolution-workflow)
8. [Provider Performance Review Workflow](#8-provider-performance-review-workflow)

---

## 1. Customer Registration Workflows

### 1.1 Phone Number Registration (Primary Method)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CUSTOMER PHONE REGISTRATION                      │
└─────────────────────────────────────────────────────────────────────┘

Customer Action                    System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

1. Visit UrbanNest website
   (urbanest.com)
        │
        ▼
2. Click "Sign Up" or             Load registration page
   "Book Now" button               with phone input form
        │
        ▼
3. Enter phone number             Validate format
   (+91XXXXXXXXXX)    ────────►   (+91 prefix required)
        │                                │
        │                                ▼
        │                         Show reCAPTCHA verification
        ▼
4. Complete reCAPTCHA             Verify human interaction
        │                                │
        ▼                                ▼
5. Click "Send OTP"               Generate 6-digit OTP
                      ────────►   Send via MSG91 SMS API
                                  Start 5-minute timer
                                         │
        ┌────────────────────────────────┘
        ▼
   SMS received on phone
   "Your UrbanNest OTP is: 123456
    Valid for 5 minutes."
        │
        ▼
6. Enter OTP (123456)             Verify OTP
                      ────────►   Check expiration (< 5 min)  ──────► Create temp session
        │                         Check attempts (max 3)
        ▼
   [IF OTP INVALID]               Show error message
   ├─► "Invalid OTP"              Decrement attempts counter
   │   Try again (3 attempts)
   │
   [IF OTP EXPIRED]
   ├─► "OTP expired"              Allow resend
   │   Click "Resend OTP"
   │
   [IF OTP VALID] ✓
        │
        ▼
7. OTP Verified Successfully      Redirect to profile setup
                                  page with pre-filled phone
        │
        ▼
8. Complete Profile Setup:
   ├─ Full Name (Required)        Validate name format
   ├─ Email (Optional)            Validate email if provided
   ├─ Profile Photo (Optional)    Upload to Firebase Storage
   └─ Select City (Required)      Show available cities list
        │
        ▼
9. Click "Complete Registration"  Create user document         ──────► Firestore: users/{userId}
                      ────────►   Generate userId (Firebase)              ├─ type: 'customer'
                                  Create JWT token                        ├─ phone: '+91XXXXXXXXXX'
                                  Send welcome email                      ├─ name: 'John Doe'
                                         │                                ├─ email: 'john@example.com'
        ┌────────────────────────────────┘                               ├─ city: 'Delhi'
        ▼                                                                 ├─ profileImage: 'url'
10. Registration Complete                                                 ├─ createdAt: timestamp
    ├─ Welcome email sent                                                 ├─ status: 'active'
    ├─ SMS confirmation                                                   └─ wallet: 0
    └─ Redirect to dashboard
            │
            ▼
    Customer Dashboard
    ├─ Browse services
    ├─ Book services
    └─ Manage profile

─────────────────────────────────────────────────────────────────────────

ERROR HANDLING:

[Phone Already Registered]
├─ System checks: User exists with this phone?
│  └─ Yes → Show "Phone already registered. Please login."
│           Redirect to login page
│
[OTP Delivery Failed]
├─ MSG91 API error
│  └─ Show "Failed to send OTP. Please try again."
│      Log error for admin review
│
[Network Issues]
├─ Connection timeout
│  └─ Show offline indicator
│      Cache form data locally
│      Retry when online

─────────────────────────────────────────────────────────────────────────
```

### 1.2 Email/Password Registration (Secondary Method)

```
┌─────────────────────────────────────────────────────────────────────┐
│                   CUSTOMER EMAIL REGISTRATION                       │
└─────────────────────────────────────────────────────────────────────┘

Customer Action                    System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

1. Visit registration page
        │
        ▼
2. Click "Sign up with Email"     Show email registration form
        │
        ▼
3. Fill registration form:
   ├─ Full Name                   Validate: 2+ characters
   ├─ Email Address               Validate: email format
   ├─ Password                    Validate: 8+ chars, 1 uppercase,
   │                                        1 number, 1 special char
   └─ Confirm Password            Match password fields
        │
        ▼
4. Click "Create Account"         Check email uniqueness
                      ────────►   Hash password (bcrypt)
                                  Create Firebase Auth user
                                  Send verification email        ──────► Firebase Auth
                                         │
        ┌────────────────────────────────┘
        ▼
5. See confirmation message:      Create user document           ──────► Firestore: users/{userId}
   "Account created!                     │                                  ├─ type: 'customer'
    Please check your email              │                                  ├─ email: 'user@example.com'
    to verify your account."             │                                  ├─ name: 'Jane Smith'
        │                                 │                                  ├─ emailVerified: false
        ▼                                 ▼                                  ├─ createdAt: timestamp
6. Check email inbox              Email sent with verification           └─ status: 'pending_verification'
   "Welcome to UrbanNest!          link (expires in 24 hours)
    Click below to verify"
        │
        ▼
7. Click verification link        Validate token
                      ────────►   Check expiration (< 24 hrs)
        │                         Mark email as verified         ──────► Update: emailVerified: true
        ▼                                │                                       status: 'active'
8. Email verified successfully           │
   Redirect to login page                ▼
        │                         Show success message
        ▼
9. Login with credentials         Verify email + password
                      ────────►   Check emailVerified: true
                                  Create JWT session
                                         │
        ┌────────────────────────────────┘
        ▼
10. Complete additional profile:
    ├─ Phone Number (Required)    Send OTP for verification
    ├─ City Selection (Required)  Show cities dropdown
    └─ Profile Photo (Optional)   Upload to Storage
        │
        ▼
11. Profile completed             Update user document
    Redirect to dashboard         Send welcome email
            │
            ▼
    Customer Dashboard

─────────────────────────────────────────────────────────────────────────

PASSWORD RESET FLOW:

Forgot Password
      │
      ▼
Enter email address ───────►  Check email exists
      │                       Send reset link (expires 1 hour)
      ▼
Check email
"Reset your password"
      │
      ▼
Click reset link ──────────►  Validate token
      │                       Show reset password form
      ▼
Enter new password ────────►  Validate strength
Confirm new password          Hash and update
      │                       Invalidate old sessions
      ▼
Password reset successful
Redirect to login

─────────────────────────────────────────────────────────────────────────
```

### 1.3 Google Sign-In Registration (Quick Method)

```
┌─────────────────────────────────────────────────────────────────────┐
│                   GOOGLE SIGN-IN REGISTRATION                       │
└─────────────────────────────────────────────────────────────────────┘

Customer Action                    System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

1. Visit registration page
        │
        ▼
2. Click "Continue with Google"   Initialize Google OAuth
   button                         Show Google account picker
        │
        ▼
3. Select Google account          Google OAuth consent screen
   or login if needed             Shows permissions requested:
        │                         ├─ Basic profile info
        ▼                         ├─ Email address
4. Review permissions:            └─ Name and photo
   "UrbanNest wants to access
    your basic profile"
        │
        ▼
5. Click "Allow"                  Google returns OAuth token
                      ────────►   Exchange token for user info
                                  Firebase verifies token
                                         │
        ┌────────────────────────────────┘
        ▼
   [CHECK: User exists?]
        │
        ├─[NO - NEW USER]
        │       │
        │       ▼
        │   Create new user document    ──────► Firestore: users/{userId}
        │   Auto-populate:                         ├─ type: 'customer'
        │   ├─ Name from Google                    ├─ email: 'user@gmail.com'
        │   ├─ Email from Google                   ├─ name: 'John Doe'
        │   ├─ Profile photo from Google           ├─ profileImage: 'google_url'
        │   └─ emailVerified: true                 ├─ emailVerified: true
        │       │                                  ├─ authProvider: 'google'
        │       ▼                                  ├─ createdAt: timestamp
        │   Show "Complete Your Profile"           └─ status: 'active'
        │   Additional info needed:
        │   ├─ Phone Number (Required)
        │   │  └─ Send OTP for verification
        │   └─ City Selection (Required)
        │       │
        │       ▼
        │   Profile completed
        │   Send welcome email
        │       │
        └───────┼───────────────────┐
                │                   │
        ├─[YES - EXISTING USER]     │
        │       │                   │
        │       ▼                   │
        │   Verify account active   │
        │   Create JWT session      │
        │   Update lastLogin        ──────► Update: lastLogin: timestamp
        │       │                   │
        └───────┼───────────────────┘
                │
                ▼
6. Login successful
   Redirect to dashboard
            │
            ▼
   Customer Dashboard

─────────────────────────────────────────────────────────────────────────

LINKING ACCOUNTS:

User has email account, wants to add Google:
      │
      ▼
Settings → Connected Accounts
      │
      ▼
Click "Connect Google" ────────►  Google OAuth flow
      │                           Link accounts in Firebase
      ▼                           Update authProviders array
Google linked successfully
      │
      ▼
Can now login with either method

─────────────────────────────────────────────────────────────────────────
```

---

## 2. Provider Onboarding & Approval Workflow

### 2.1 Provider Registration Process (Provider Perspective)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    PROVIDER ONBOARDING PROCESS                      │
│                        (Provider's View)                            │
└─────────────────────────────────────────────────────────────────────┘

Provider Action                    System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

1. Visit UrbanNest website
   (urbanest.com)
        │
        ▼
2. Click "Become a Professional"  Load provider registration
   or "Join as Partner"           landing page with benefits:
        │                         ├─ Earn ₹30,000-₹60,000/month
        ▼                         ├─ Flexible working hours
3. Click "Register Now"           ├─ Weekly payouts
        │                         └─ Free training provided
        ▼                                │
                                         ▼
4. STEP 1: Basic Information      Show registration form
   ────────────────────────
   Fill form:
   ├─ Full Name (Required)        Validate: 2+ characters
   ├─ Phone Number (Required)     Validate: +91 format
   ├─ Email (Required)            Validate: email format
   ├─ Date of Birth (Required)    Validate: 18+ years old
   └─ Gender (Optional)           Dropdown: Male/Female/Other
        │
        ▼
5. Click "Continue"               Send OTP to phone
                      ────────►   Verify phone number
        │                         (Same OTP flow as customer)
        ▼
6. Enter OTP                      Verify OTP
        │                         Create temp provider account ──────► Firestore: providers/{providerId}
        ▼                                │                                ├─ type: 'provider'
                                         ▼                                ├─ phone: '+91XXXXXXXXXX'
7. OTP Verified                   Proceed to Step 2                      ├─ status: 'registration_incomplete'
        │                                                                 └─ createdAt: timestamp
        ▼

8. STEP 2: Professional Details
   ─────────────────────────────
   Fill professional info:
   ├─ City of Operation           Dropdown: Delhi/Mumbai/etc
   ├─ Zones/Areas                 Multi-select within city
   │  (e.g., Connaught Place,     Show map to select zones
   │   Rohini, Dwarka)
   ├─ Services Offered            Multi-select checkboxes:
   │                              ├─ AC Repair
   │                              ├─ Plumbing
   │                              ├─ Electrical
   │                              ├─ Cleaning
   │                              └─ Salon at Home
   ├─ Years of Experience         Number input (1-30)
   ├─ Specializations             Text area (optional)
   └─ Previous Employer           Text input (optional)
        │
        ▼
9. Click "Continue"               Validate selections
                      ────────►   Save professional details   ──────► Update: professionalDetails
        │                                │
        ▼                                ▼
10. Proceed to Step 3            Show document upload interface

11. STEP 3: KYC Documents Upload
    ─────────────────────────────
    Upload required documents:

    A. Aadhar Card (Required)
       ├─ Front image              Validate: JPG/PNG, < 5MB
       └─ Back image               Check image quality
                      ────────►    Upload to Firebase Storage
                                   Generate secure URLs        ──────► Update: documents.aadhar
                                          │                               ├─ frontUrl
                                          │                               ├─ backUrl
                                          │                               └─ uploadedAt

    B. PAN Card (Required)
       └─ PAN image                Validate format
                      ────────►    Upload to Storage          ──────► Update: documents.pan
                                          │

    C. Bank Account Details
       ├─ Account Number           Validate: 9-18 digits
       ├─ IFSC Code                Validate: format
       ├─ Account Holder Name      Must match Aadhar/PAN
       └─ Bank Passbook/Cheque     Upload proof
              Image                       │
                      ────────►    Save bank details          ──────► Update: bankDetails

    D. Service Certifications (If applicable)
       └─ Certificate images       Upload certificates
                      ────────►    Store URLs                 ──────► Update: documents.certifications[]

    E. Profile Photo (Required)
       └─ Professional headshot    Validate: Clear, front-facing
                      ────────►    Upload and crop            ──────► Update: profileImage
        │
        ▼
12. Review uploaded documents     Show preview of all docs
    Check all documents                  │
        │                                ▼
        ▼                         Validate: All required docs uploaded?
13. Click "Submit Application"           │
                      ────────►    [YES]
                                   Update status              ──────► Update: status: 'pending_verification'
                                   Send confirmation email                    kycStatus: 'pending'
                                   Send confirmation SMS                      submittedAt: timestamp
                                   Notify admin team
                                          │
        ┌────────────────────────────────┘
        ▼
14. Application Submitted
    Show confirmation screen:

    ┌──────────────────────────────────┐
    │  ✓ Application Submitted         │
    │                                  │
    │  Application ID: PRV-2024-12345  │
    │                                  │
    │  Your application is under       │
    │  review. We'll notify you via    │
    │  email and SMS within 2-3        │
    │  business days.                  │
    │                                  │
    │  Track Status: [View Dashboard]  │
    └──────────────────────────────────┘
        │
        ▼
15. Provider Dashboard (Limited Access)
    Can view:
    ├─ Application Status: "Under Review"
    ├─ Progress: 3/3 Steps Complete
    ├─ Submitted Documents
    └─ Estimated Review Time: 2-3 days
        │
        ▼
    [WAIT FOR ADMIN APPROVAL]

─────────────────────────────────────────────────────────────────────────

TRACKING APPLICATION STATUS:

Provider can track via:
    │
    ├─► Email updates
    │   ├─ "Application Received"
    │   ├─ "Under Review"
    │   ├─ "Documents Verified"
    │   └─ "Approved/Rejected"
    │
    ├─► SMS updates
    │   └─ Real-time status changes
    │
    └─► Provider Dashboard
        └─ Login to check status anytime

─────────────────────────────────────────────────────────────────────────

POSSIBLE OUTCOMES:

[APPROVED] ────► See Section 2.2 (Approval Process)
      │
      ▼
   Account activated
   Full dashboard access
   Start accepting jobs

[REJECTED] ────► Email with rejection reason
      │          Option to resubmit
      ▼
   Fix issues and resubmit
   └─► Back to Step 3 (Upload corrected docs)

[MORE INFO REQUIRED] ────► Email/SMS with specific requests
      │                    (e.g., "Please upload clear PAN image")
      ▼
   Upload requested documents
   └─► Admin re-reviews

─────────────────────────────────────────────────────────────────────────
```

### 2.2 Provider Approval Process (Admin Perspective)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    PROVIDER APPROVAL WORKFLOW                       │
│                         (Admin's View)                              │
└─────────────────────────────────────────────────────────────────────┘

Admin Action                       System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

[NEW PROVIDER APPLICATION RECEIVED]
        │
        ▼
1. Admin Dashboard                Real-time notification:
   Notification bell shows        "New provider application
   new application count          received from John Doe"
        │
        ▼
2. Navigate to:                   Load pending applications
   Admin → Providers →            with filters:
   Pending Applications           ├─ Date submitted
        │                         ├─ City
        ▼                         ├─ Service type
3. View Applications List         └─ Priority (auto-ranked)

   ┌────────────────────────────────────────────────────┐
   │ PENDING PROVIDER APPLICATIONS                      │
   ├────────────────────────────────────────────────────┤
   │ Name         City    Service      Submitted  Action│
   ├────────────────────────────────────────────────────┤
   │ John Doe     Delhi   AC Repair    2h ago   [Review]│
   │ Jane Smith   Mumbai  Plumbing     5h ago   [Review]│
   │ Raj Kumar    Delhi   Electrical   1d ago   [Review]│
   └────────────────────────────────────────────────────┘
        │
        ▼
4. Click [Review] on              Load full application
   John Doe's application         details page
        │
        ▼
5. APPLICATION REVIEW PAGE
   ════════════════════════

   A. PROVIDER INFORMATION
      ─────────────────────
      ├─ Full Name: John Doe
      ├─ Phone: +91-9876543210
      ├─ Email: john@example.com
      ├─ Age: 32 years
      ├─ City: Delhi
      ├─ Zones: Connaught Place, Rohini
      ├─ Services: AC Repair, Refrigerator Repair
      ├─ Experience: 8 years
      └─ Previous Employer: CoolAir Services Pvt Ltd
        │
        ▼
   B. DOCUMENT VERIFICATION
      ──────────────────────

      Document 1: AADHAR CARD
      ┌──────────────────────────────────┐
      │ [Aadhar Front Image]             │
      │                                  │
      │ Name: John Doe                   │
      │ Aadhar: XXXX-XXXX-1234           │
      │ Address: 123 Main St, Delhi      │
      │                                  │
      │ [Zoom] [Download]                │
      │                                  │
      │ Status: [Pending]                │
      │ [✓ Verify] [✗ Reject]            │
      └──────────────────────────────────┘

      ├─► Admin clicks [Zoom]           Open full-screen viewer
      │       │                         Check for:
      │       ▼                         ├─ Image clarity
      │   Inspect document:             ├─ Name matches application
      │   ├─ Is photo clear?            ├─ No tampering/editing signs
      │   ├─ Name matches?              └─ Valid Aadhar format
      │   ├─ Address valid?
      │   └─ Any signs of tampering?
      │       │
      │       ▼
      │   [DECISION]
      │       │
      │       ├─[VERIFIED] ──────►  Click [✓ Verify]
      │       │                    Status: Verified ✓
      │       │                    Color: Green
      │       │
      │       └─[REJECTED] ──────►  Click [✗ Reject]
      │                            Enter reason:
      │                            "Image not clear, please reupload"
      │                            Status: Rejected ✗
      │                            Color: Red
      │
      Document 2: PAN CARD
      ┌──────────────────────────────────┐
      │ [PAN Card Image]                 │
      │                                  │
      │ Name: JOHN DOE                   │
      │ PAN: ABCDE1234F                  │
      │ Father: Robert Doe               │
      │ DOB: 15/06/1992                  │
      │                                  │
      │ Status: [Pending]                │
      │ [✓ Verify] [✗ Reject]            │
      └──────────────────────────────────┘

      ├─► Verify:
      │   ├─ Name matches Aadhar?
      │   ├─ PAN format correct?
      │   ├─ DOB matches (age 32)?
      │   └─ Clear image?
      │       │
      │       ▼
      │   Click [✓ Verify]
      │
      Document 3: BANK DETAILS
      ┌──────────────────────────────────┐
      │ [Bank Passbook/Cheque Image]     │
      │                                  │
      │ Account: 1234567890123456        │
      │ IFSC: SBIN0001234                │
      │ Name: John Doe                   │
      │ Bank: State Bank of India        │
      │ Branch: Connaught Place          │
      │                                  │
      │ Status: [Pending]                │
      │ [✓ Verify] [✗ Reject]            │
      └──────────────────────────────────┘

      ├─► Verify:
      │   ├─ Account holder name matches?
      │   ├─ IFSC code valid?
      │   └─ Clear passbook/cheque image?
      │       │
      │       ▼
      │   Click [✓ Verify]
      │
      Document 4: SERVICE CERTIFICATIONS
      ┌──────────────────────────────────┐
      │ [AC Technician Certificate]      │
      │                                  │
      │ Certification: HVAC Technician   │
      │ Issued By: National Skill Dev.   │
      │ Valid Till: 31/12/2025           │
      │                                  │
      │ Status: [Pending]                │
      │ [✓ Verify] [✗ Reject]            │
      └──────────────────────────────────┘

      └─► Verify certification validity
              │
              ▼
          Click [✓ Verify]
        │
        ▼
   C. BACKGROUND CHECK (Optional)
      ────────────────────────────
      ├─ Police Verification: [Initiate] / [View Status]
      ├─ References Check: [Contact] / [Verified]
      ├─ Previous Employer: [Verify] / [Skipped]
      └─ Skill Assessment: [Schedule Test] / [Completed]
        │
        ▼
6. VERIFICATION SUMMARY
   ════════════════════

   Documents Status:
   ├─ Aadhar Card: ✓ Verified
   ├─ PAN Card: ✓ Verified
   ├─ Bank Details: ✓ Verified
   └─ Certifications: ✓ Verified

   All Required Documents: VERIFIED ✓
        │
        ▼
7. APPROVAL DECISION
   ═════════════════

   Admin makes decision:

   [OPTION A: APPROVE]
   ───────────────────
        │
        ▼
   A1. Click [Approve Provider] button
        │
        ▼
   A2. Confirmation dialog:
       "Are you sure you want to approve
        John Doe as a provider?"

       [Cancel] [Confirm Approval]
        │
        ▼
   A3. Click [Confirm Approval]
        │
        ▼
   A4. Configure Provider Settings:
       ┌──────────────────────────────────┐
       │ PROVIDER ACTIVATION SETUP        │
       ├──────────────────────────────────┤
       │ Services Allowed:                │
       │ ☑ AC Repair                      │
       │ ☑ Refrigerator Repair            │
       │ ☐ Washing Machine Repair         │
       │                                  │
       │ Operational Zones:               │
       │ ☑ Connaught Place                │
       │ ☑ Rohini                         │
       │ ☐ Dwarka                         │
       │                                  │
       │ Commission Rate: [20]%           │
       │ Priority Level: [Standard] ▼     │
       │                                  │
       │ [Save & Activate]                │
       └──────────────────────────────────┘
        │
        ▼
   A5. Click [Save & Activate]
                      ────────►  System actions:           ──────► Update Firestore:
                                                                     ├─ status: 'active'
                                 1. Update provider status           ├─ kycStatus: 'approved'
                                                                     ├─ approvedAt: timestamp
                                 2. Create provider profile          ├─ approvedBy: adminId
                                    in Providers collection          ├─ services: [...]
                                                                     ├─ zones: [...]
                                 3. Send welcome email:              └─ commissionRate: 20
                                    Subject: "Welcome to UrbanNest!"
                                    Body: Account activated,
                                          Login credentials,
                                          Next steps guide

                                 4. Send SMS notification:
                                    "Congratulations! Your UrbanNest
                                     provider account is approved.
                                     Download the app to start."

                                 5. Send provider app download link

                                 6. Create audit log entry     ──────► auditLogs collection:
                                                                        ├─ action: 'provider_approved'
                                                                        ├─ adminId: adminId
                                                                        ├─ providerId: providerId
                                                                        └─ timestamp

                                 7. Notify provider via:
                                    ├─ Email
                                    ├─ SMS
                                    └─ In-app notification
        │
        ▼
   A6. Approval Complete
       Show success message:
       "✓ Provider approved successfully!
        Welcome email sent to john@example.com"
        │
        ▼
   A7. Provider Status Changed
       ├─ Dashboard shows: Active Provider
       ├─ Provider receives welcome package
       └─ Provider can login and start working

   [OPTION B: REJECT]
   ──────────────────
        │
        ▼
   B1. Click [Reject Application] button
        │
        ▼
   B2. Rejection Reason Form:
       ┌──────────────────────────────────┐
       │ REJECTION DETAILS                │
       ├──────────────────────────────────┤
       │ Reason for Rejection:            │
       │ ┌──────────────────────────────┐ │
       │ │ Please select:               │ │
       │ │ • Incomplete documents       │ │
       │ │ • Documents not clear        │ │
       │ │ • Information mismatch       │ │
       │ │ • Failed background check    │ │
       │ │ • Other (specify below)      │ │
       │ └──────────────────────────────┘ │
       │                                  │
       │ Detailed Comments:               │
       │ ┌──────────────────────────────┐ │
       │ │ PAN card image is not clear  │ │
       │ │ enough to verify details.    │ │
       │ │ Please re-upload a high-res  │ │
       │ │ image.                       │ │
       │ └──────────────────────────────┘ │
       │                                  │
       │ [Cancel] [Confirm Rejection]     │
       └──────────────────────────────────┘
        │
        ▼
   B3. Click [Confirm Rejection]
                      ────────►  System actions:           ──────► Update Firestore:
                                                                     ├─ status: 'rejected'
                                 1. Update status                    ├─ kycStatus: 'rejected'
                                                                     ├─ rejectedAt: timestamp
                                 2. Send rejection email:            ├─ rejectedBy: adminId
                                    Subject: "Application Update"    └─ rejectionReason: "..."
                                    Body: Detailed reason,
                                          How to reapply

                                 3. Send SMS notification

                                 4. Create audit log

                                 5. Archive application
        │
        ▼
   B4. Rejection Complete
       Provider notified with next steps

   [OPTION C: REQUEST MORE INFO]
   ─────────────────────────────
        │
        ▼
   C1. Click [Request More Information]
        │
        ▼
   C2. Information Request Form:
       ┌──────────────────────────────────┐
       │ REQUEST ADDITIONAL INFORMATION   │
       ├──────────────────────────────────┤
       │ Select Documents Needed:         │
       │ ☑ Re-upload Aadhar (clear image) │
       │ ☐ Re-upload PAN                  │
       │ ☑ Additional certifications      │
       │ ☐ References contact details     │
       │                                  │
       │ Message to Provider:             │
       │ ┌──────────────────────────────┐ │
       │ │ Please upload a clearer      │ │
       │ │ Aadhar image and provide     │ │
       │ │ your service certifications. │ │
       │ └──────────────────────────────┘ │
       │                                  │
       │ [Send Request]                   │
       └──────────────────────────────────┘
        │
        ▼
   C3. Click [Send Request]
                      ────────►  System actions:           ──────► Update Firestore:
                                                                     ├─ status: 'info_required'
                                 1. Update status                    ├─ requestedInfo: [...]
                                                                     └─ requestedAt: timestamp
                                 2. Send email with details

                                 3. Send SMS notification

                                 4. Update provider dashboard
                                    to show pending items
        │
        ▼
   C4. Provider receives request
       Uploads requested documents
       └──► Admin reviews again (back to step 5)

─────────────────────────────────────────────────────────────────────────

POST-APPROVAL ACTIONS:

After provider is approved:
      │
      ├─► Provider receives:
      │   ├─ Welcome email with login credentials
      │   ├─ SMS with app download link
      │   ├─ Onboarding guide (PDF)
      │   └─ Training materials access
      │
      ├─► Provider completes:
      │   ├─ Download provider app
      │   ├─ Complete profile (bio, portfolio)
      │   ├─ Set availability calendar
      │   ├─ Watch training videos
      │   └─ Take skill assessment test
      │
      └─► Admin monitors:
          ├─ First booking performance
          ├─ Customer ratings
          ├─ Punctuality metrics
          └─ Quality of service

─────────────────────────────────────────────────────────────────────────
```

---

## 3. Customer Booking Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                      CUSTOMER BOOKING WORKFLOW                      │
└─────────────────────────────────────────────────────────────────────┘

Customer Action                    System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

[CUSTOMER LOGGED IN]
        │
        ▼
1. Homepage Dashboard             Show service categories grid:
                                  ┌──────────────────────────────┐
                                  │ 🔧 Home Appliances           │
                                  │ 💡 Electrical                │
                                  │ 🚿 Plumbing                  │
                                  │ ✂️  Salon & Spa              │
                                  │ 🧹 Cleaning                  │
                                  │ 🎨 Painting                  │
                                  └──────────────────────────────┘
        │
        ▼
2. Browse or Search:

   [OPTION A: Browse by Category]
        │
        ▼
   A1. Click "Home Appliances"    Load services list:
                                  ├─ AC Repair (₹499)
                                  ├─ Refrigerator Repair (₹399)
                                  ├─ Washing Machine (₹349)
                                  └─ Microwave Repair (₹299)
        │
        ▼
   A2. Click "AC Repair"          Load service detail page

   [OPTION B: Search]
        │
        ▼
   B1. Type "AC Repair" in        Live search results:
       search bar                 ├─ AC Repair & Service (₹499)
        │                         ├─ AC Installation (₹1,299)
        ▼                         └─ AC Deep Cleaning (₹699)
   B2. Select from results
        │
        └───────────┬──────────────┘
                    │
                    ▼
3. SERVICE DETAIL PAGE
   ═══════════════════

   Display:
   ├─ Service: AC Repair & Service
   ├─ Rating: ⭐ 4.8 (1,234 reviews)
   ├─ Price: ₹499 onwards
   ├─ Duration: ~60 minutes
   ├─ Description: Complete AC checkup and repair
   │
   ├─ What's Included:
   │  ├─ Gas leak check
   │  ├─ Cooling check
   │  ├─ General service
   │  └─ 30-day warranty
   │
   ├─ What's Not Included:
   │  ├─ Gas refilling (₹2,500 extra)
   │  ├─ Part replacement (as per actual)
   │  └─ Deep cleaning (₹400 extra)
   │
   ├─ Available in: Delhi, Mumbai, Bangalore
   │
   ├─ Top-rated Providers:
   │  ├─ Rajesh Kumar (⭐ 4.9, 500+ services)
   │  ├─ Amit Sharma (⭐ 4.8, 300+ services)
   │  └─ Vijay Patel (⭐ 4.7, 200+ services)
   │
   └─ Customer Reviews:
      "Excellent service! Quick and professional."
      - Priya Singh
        │
        ▼
4. Click [Book Now] button        Check user logged in? ✓
        │                         Load booking flow
        ▼

5. STEP 1: SELECT ADDRESS
   ══════════════════════

   Show saved addresses:
   ┌────────────────────────────────────┐
   │ ⦿ Home                             │
   │   123 Main Street, Connaught Place │
   │   Delhi - 110001                   │
   │   [Edit] [Select]                  │
   ├────────────────────────────────────┤
   │ ○ Office                           │
   │   456 Business Park, Rohini        │
   │   Delhi - 110085                   │
   │   [Edit] [Select]                  │
   ├────────────────────────────────────┤
   │ + Add New Address                  │
   └────────────────────────────────────┘
        │
        ├─[Select Existing Address]
        │       │
        │       ▼
        │   Click [Select] on "Home"
        │
        ├─[Add New Address]
        │       │
        │       ▼
        │   Click [+ Add New Address]
        │       │
        │       ▼
        │   Fill address form:
        │   ├─ House/Flat No.
        │   ├─ Street/Area
        │   ├─ Landmark
        │   ├─ City
        │   ├─ Pincode
        │   └─ Location on Map (drag pin)
        │       │
        │       ▼
        │   Save address             ──────► Update: user.addresses[]
        │
        └───────┬──────────────┘
                │
                ▼
   Address Selected: 123 Main St...
        │
        ▼
6. Click [Continue]               Validate address
                                  Check service availability
                                  in this zone ✓
        │
        ▼
7. STEP 2: SELECT DATE & TIME
   ══════════════════════════

   Show calendar picker:
   ┌────────────────────────────────────┐
   │ December 2024                      │
   ├────────────────────────────────────┤
   │ Mon  Tue  Wed  Thu  Fri  Sat  Sun  │
   │                          1          │
   │  2    3    4    5    6    7    8   │
   │  9   10   11   12   13   14   15   │
   │ 16   17   18   19   20   21   22   │
   │ 23   24   25   26   27   28   29   │
   │ 30   31                            │
   └────────────────────────────────────┘
        │
        ▼
   Select Date: December 31, 2024
                      ────────►  Fetch available time slots
                                 for this date and zone
        │                              │
        ▼                              ▼
   Show available time slots:    Check provider availability:
   ┌────────────────────────────────────┐
   │ AVAILABLE TIME SLOTS               │
   ├────────────────────────────────────┤
   │ Morning:                           │
   │ ⦿ 08:00 AM - 09:00 AM (3 providers)│
   │ ○ 09:00 AM - 10:00 AM (5 providers)│
   │ ○ 10:00 AM - 11:00 AM (2 providers)│
   │ ○ 11:00 AM - 12:00 PM (4 providers)│
   │                                    │
   │ Afternoon:                         │
   │ ○ 12:00 PM - 01:00 PM (6 providers)│
   │ ○ 02:00 PM - 03:00 PM (8 providers)│ ← Most Available
   │ ○ 03:00 PM - 04:00 PM (5 providers)│
   │                                    │
   │ Evening:                           │
   │ ○ 05:00 PM - 06:00 PM (7 providers)│
   │ ○ 06:00 PM - 07:00 PM (4 providers)│
   │ ○ 07:00 PM - 08:00 PM (2 providers)│
   └────────────────────────────────────┘
        │
        ▼
   Select: 02:00 PM - 03:00 PM
        │
        ▼
8. Add Special Instructions       Text area input:
   (Optional)                     "Please bring ladder.
                                   AC is on 3rd floor."
        │
        ▼
9. Click [Continue]               Save booking details
        │
        ▼
10. STEP 3: REVIEW & PAYMENT
    ════════════════════════

    Booking Summary:
    ┌────────────────────────────────────┐
    │ BOOKING DETAILS                    │
    ├────────────────────────────────────┤
    │ Service: AC Repair & Service       │
    │ Date: 31 Dec 2024                  │
    │ Time: 02:00 PM - 03:00 PM          │
    │ Address: 123 Main St, Delhi        │
    │ Special Notes: Please bring ladder │
    ├────────────────────────────────────┤
    │ PRICE BREAKDOWN                    │
    ├────────────────────────────────────┤
    │ Service Charge:        ₹499.00     │
    │ Convenience Fee:       ₹ 20.00     │
    │ GST (18%):             ₹ 93.42     │
    │ ────────────────────────────────── │
    │ Subtotal:              ₹612.42     │
    │                                    │
    │ Promo Code: [FIRST100]   [Apply]   │
    │ Discount:              -₹100.00    │
    │ ────────────────────────────────── │
    │ TOTAL:                 ₹512.42     │
    └────────────────────────────────────┘
        │
        ▼
11. Apply Promo Code              Validate promo code
    "FIRST100"        ────────►   Check eligibility:
        │                         ├─ First-time user? ✓
        ▼                         ├─ Min order value? ✓
    Discount Applied: -₹100       └─ Code active? ✓
        │                                │
        ▼                                ▼
12. Select Payment Method         Show payment options:
    ┌────────────────────────────────────┐
    │ PAY ONLINE (Recommended)           │
    │ ⦿ UPI (Google Pay, PhonePe, etc.)  │
    │ ○ Credit/Debit Card                │
    │ ○ Net Banking                      │
    │ ○ Wallet (UrbanNest Wallet: ₹0)   │
    │                                    │
    │ Pay ₹512 now, 100% refund if      │
    │ service not satisfactory           │
    ├────────────────────────────────────┤
    │ CASH ON SERVICE                    │
    │ ○ Pay after service completion     │
    │   (₹50 extra charge applies)       │
    └────────────────────────────────────┘
        │
        ▼
13. Select: UPI Payment
    Click [Proceed to Pay]
                      ────────►  Create Razorpay order      ──────► Firestore: bookings/{bookingId}
                                 Generate order ID                    ├─ customerId: userId
                                 Amount: ₹51242 (in paise)            ├─ serviceId: 'ac_repair'
                                        │                             ├─ status: 'payment_pending'
        ┌───────────────────────────────┘                            ├─ scheduledDate: timestamp
        ▼                                                             ├─ scheduledTime: '14:00-15:00'
14. Razorpay Checkout Opens                                          ├─ address: {...}
    ┌────────────────────────────────────┐                           ├─ pricing: {...}
    │ Pay ₹512.42 to UrbanNest           │                           ├─ promoCode: 'FIRST100'
    │                                    │                           ├─ discount: 100
    │ UPI ID: customer@oksbi             │                           ├─ totalAmount: 512.42
    │                                    │                           ├─ paymentMethod: 'upi'
    │ [Pay with UPI App]                 │                           ├─ razorpayOrderId: 'order_xyz'
    │                                    │                           ├─ createdAt: timestamp
    │ Scan QR Code:                      │                           └─ providerId: null (pending)
    │ ┌──────────┐                       │
    │ │ [QR Code]│                       │
    │ └──────────┘                       │
    └────────────────────────────────────┘
        │
        ▼
15. Customer completes payment    Razorpay webhook triggered
    in UPI app (Google Pay)       Payment signature verified
        │                                │
        ▼                                ▼
    Payment Success! ✓            Update booking status       ──────► Update:
                                                                       ├─ status: 'confirmed'
                                  Trigger provider matching            ├─ paymentStatus: 'paid'
                                  algorithm                            ├─ razorpayPaymentId: 'pay_abc'
                                        │                              └─ confirmedAt: timestamp
        ┌───────────────────────────────┘
        ▼
16. CONFIRMATION SCREEN
    ┌────────────────────────────────────┐
    │ ✓ BOOKING CONFIRMED!               │
    │                                    │
    │ Booking ID: BKG-2024-12345         │
    │                                    │
    │ We're finding the best provider    │
    │ for you. You'll be notified soon!  │
    │                                    │
    │ [View Booking Details]             │
    │ [Track Status]                     │
    └────────────────────────────────────┘
        │
        ├─► Send confirmation email
        ├─► Send confirmation SMS
        └─► Create notification
                │
                ▼
17. PROVIDER MATCHING (Automated)
    ════════════════════════════

    System runs matching algorithm:
    ────────────────────────────────
    Query providers WHERE:
    ├─ service: 'ac_repair'
    ├─ zone: 'Connaught Place'
    ├─ available: true
    ├─ date: '2024-12-31'
    └─ time: '14:00-15:00'
        │
        ▼
    Found 8 available providers
        │
        ▼
    Rank by:
    ├─ Rating (weight: 40%)
    ├─ Distance (weight: 30%)
    ├─ Completion rate (weight: 20%)
    └─ Response time (weight: 10%)
        │
        ▼
    Top Match: Rajesh Kumar
    ├─ Rating: 4.9/5
    ├─ Distance: 2.3 km
    ├─ Completed: 500+ services
    └─ Avg response: 2 minutes
        │
        ▼
    Assign provider              ──────► Update:
    Send job notification                ├─ providerId: 'provider_xyz'
    to Rajesh Kumar                      ├─ providerAssignedAt: timestamp
        │                                └─ status: 'provider_assigned'
        ▼
18. Provider Accepts (within 5 min)
        │
        ▼
    Update customer:
    ┌────────────────────────────────────┐
    │ PROVIDER ASSIGNED                  │
    │                                    │
    │ ┌──────┐                           │
    │ │Photo │ Rajesh Kumar              │
    │ └──────┘ ⭐ 4.9 (500+ services)    │
    │                                    │
    │ 📞 Call Provider                   │
    │ 💬 Chat                            │
    │                                    │
    │ ETA: Arriving by 1:55 PM           │
    │                                    │
    │ [Track on Map]                     │
    └────────────────────────────────────┘
        │
        ▼
19. SERVICE DAY
    ═══════════

    Timeline:

    1:30 PM - Provider starts traveling
              └─► Customer sees: "Rajesh is on the way"
              └─► Real-time map tracking

    1:55 PM - Provider arrives
              └─► Provider clicks "Arrived"
              └─► Customer notified

    2:00 PM - Service starts
              └─► Provider clicks "Start Service"
              └─► Timer begins

    3:15 PM - Service completes
              └─► Provider clicks "Complete"
              └─► Upload service photos
              └─► Customer verification requested
        │
        ▼
20. SERVICE COMPLETION
    ══════════════════

    Customer receives:
    "Service completed! Please verify and rate."
        │
        ▼
21. Customer verifies service    Mark as verified
    Clicks "Confirm Completion"
        │
        ▼
22. RATING & REVIEW
    ═══════════════

    ┌────────────────────────────────────┐
    │ How was your experience?           │
    │                                    │
    │ ⭐ ⭐ ⭐ ⭐ ⭐                        │
    │                                    │
    │ Write a review (optional):         │
    │ ┌────────────────────────────────┐ │
    │ │ Excellent service! Very         │ │
    │ │ professional and quick.         │ │
    │ └────────────────────────────────┘ │
    │                                    │
    │ [Skip] [Submit Review]             │
    └────────────────────────────────────┘
        │
        ▼
23. Submit 5-star rating         Save review                 ──────► Create: reviews/{reviewId}
                                 Update provider rating               ├─ bookingId
                                 Release payment to provider          ├─ customerId
                                        │                             ├─ providerId
        ┌───────────────────────────────┘                            ├─ rating: 5
        ▼                                                             ├─ comment: "Excellent..."
24. INVOICE & RECEIPT                                                 └─ createdAt
    ═════════════════

    Download invoice:
    ┌────────────────────────────────────┐
    │ URBANEST SERVICE INVOICE           │
    │ Invoice #: INV-2024-12345          │
    │ Date: 31 Dec 2024                  │
    ├────────────────────────────────────┤
    │ Customer: John Doe                 │
    │ Service: AC Repair                 │
    │ Provider: Rajesh Kumar             │
    │                                    │
    │ Service Charge:        ₹499.00     │
    │ Discount (FIRST100):  -₹100.00     │
    │ GST (18%):             ₹ 93.42     │
    │ ────────────────────────────────── │
    │ Total Paid:            ₹512.42     │
    │                                    │
    │ Payment Mode: UPI                  │
    │ Transaction ID: pay_abc123         │
    │                                    │
    │ [Download PDF] [Share]             │
    └────────────────────────────────────┘
        │
        ▼
25. Booking Complete!

    Customer can:
    ├─ View in Order History
    ├─ Book again (one-click rebook)
    ├─ Download invoice
    └─ Contact support if needed

─────────────────────────────────────────────────────────────────────────

EDGE CASES:

[No Provider Available]
├─ Show message: "No providers available for this slot"
└─ Suggest alternative time slots

[Provider Rejects]
├─ Auto-assign next available provider
└─ Notify customer of new provider

[Provider No-Show]
├─ Customer reports no-show
├─ Full refund initiated
└─ Provider penalized

[Service Cancelled by Customer]
├─ If >4 hours before: Full refund
├─ If 2-4 hours before: 50% refund
└─ If <2 hours before: No refund

[Payment Failed]
├─ Retry payment
├─ Try different method
└─ Booking held for 15 minutes

─────────────────────────────────────────────────────────────────────────
```

---

## 4. Admin Booking Management Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                    ADMIN BOOKING MANAGEMENT                         │
└─────────────────────────────────────────────────────────────────────┘

Admin Action                       System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

1. Admin Dashboard                Real-time booking stats:
   Homepage                       ┌────────────────────────────────┐
        │                         │ TODAY'S OVERVIEW               │
        ▼                         ├────────────────────────────────┤
   View dashboard widgets:        │ Total Bookings: 156            │
   ├─ Active Bookings: 23         │ Active Now: 23                 │
   ├─ Pending Approval: 5         │ Completed: 98                  │
   ├─ In Progress: 18             │ Cancelled: 12                  │
   ├─ Completed Today: 98         │ Pending: 5                     │
   └─ Issues/Disputes: 3          │ Revenue: ₹1,24,500             │
        │                         └────────────────────────────────┘
        ▼
2. Navigate to:                   Load bookings dashboard
   Bookings → All Bookings        with filters and search
        │
        ▼
3. BOOKINGS DASHBOARD
   ══════════════════

   Filters:
   ┌────────────────────────────────────────────────────────────────┐
   │ Status: [All ▼] City: [All ▼] Date: [Today ▼] Service: [All ▼]│
   │ Search: [Search by booking ID, customer, provider...]          │
   └────────────────────────────────────────────────────────────────┘
        │
        ▼
   Bookings Table:
   ┌──────────────────────────────────────────────────────────────────┐
   │ ID        Customer    Provider    Service  Time     Status  Action│
   ├──────────────────────────────────────────────────────────────────┤
   │BKG-12345  John Doe    Rajesh K   AC Rep   2:00 PM  Active [View] │
   │BKG-12346  Jane S      Amit S     Plumb    3:00 PM  Pending[View] │
   │BKG-12347  Raj Kumar   Vijay P    Elec     4:00 PM  Complete[View]│
   │BKG-12348  Priya S     (Unassign) Clean    5:00 PM  Pending[View] │
   │BKG-12349  Amit P      Ravi M     Paint    6:00 PM  Cancelled[View]│
   └──────────────────────────────────────────────────────────────────┘
        │
        ▼
4. Click [View] on BKG-12345      Load detailed booking view
        │
        ▼
5. BOOKING DETAIL PAGE
   ═══════════════════

   ┌────────────────────────────────────┐
   │ BOOKING #BKG-12345                 │
   │ Status: IN_PROGRESS 🟢             │
   ├────────────────────────────────────┤
   │ CUSTOMER DETAILS                   │
   ├────────────────────────────────────┤
   │ Name: John Doe                     │
   │ Phone: +91-9876543210              │
   │ Email: john@example.com            │
   │ Address: 123 Main St, Delhi        │
   │                                    │
   │ [📞 Call] [📧 Email] [💬 Chat]     │
   ├────────────────────────────────────┤
   │ PROVIDER DETAILS                   │
   ├────────────────────────────────────┤
   │ Name: Rajesh Kumar                 │
   │ Phone: +91-9876500000              │
   │ Rating: ⭐ 4.9 (500+ services)     │
   │ Status: En Route to Location       │
   │                                    │
   │ [📞 Call] [View Profile]           │
   ├────────────────────────────────────┤
   │ SERVICE DETAILS                    │
   ├────────────────────────────────────┤
   │ Service: AC Repair & Service       │
   │ Category: Home Appliances          │
   │ Scheduled: 31 Dec 2024, 2:00 PM    │
   │ Duration: 60 minutes               │
   │ Special Notes: Please bring ladder │
   ├────────────────────────────────────┤
   │ PAYMENT DETAILS                    │
   ├────────────────────────────────────┤
   │ Service Charge: ₹499.00            │
   │ Discount: -₹100.00 (FIRST100)      │
   │ GST: ₹93.42                        │
   │ Total: ₹512.42                     │
   │                                    │
   │ Payment Status: PAID ✓             │
   │ Method: UPI                        │
   │ Transaction ID: pay_abc123         │
   │ Razorpay Order: order_xyz789       │
   ├────────────────────────────────────┤
   │ TIMELINE                           │
   ├────────────────────────────────────┤
   │ ✓ Booking Created                  │
   │   30 Dec 2024, 6:30 PM             │
   │                                    │
   │ ✓ Payment Confirmed                │
   │   30 Dec 2024, 6:32 PM             │
   │                                    │
   │ ✓ Provider Assigned (Rajesh K)     │
   │   30 Dec 2024, 6:35 PM             │
   │                                    │
   │ ✓ Provider Accepted                │
   │   30 Dec 2024, 6:37 PM             │
   │                                    │
   │ ✓ Provider En Route                │
   │   31 Dec 2024, 1:30 PM             │
   │                                    │
   │ ⏳ Service In Progress              │
   │   Expected completion: 3:00 PM     │
   └────────────────────────────────────┘
        │
        ▼
6. ADMIN ACTIONS AVAILABLE
   ═══════════════════════

   [Reassign Provider]
   [Cancel Booking]
   [Issue Refund]
   [Contact Customer]
   [Contact Provider]
   [View on Map]
   [Download Invoice]
   [View Communication Log]
   [Raise Dispute]
        │
        ▼

   [SCENARIO A: REASSIGN PROVIDER]
   ───────────────────────────────
        │
        ▼
   A1. Click [Reassign Provider]
        │
        ▼
   A2. Reassignment Reason:
       ┌──────────────────────────────┐
       │ Why reassign provider?       │
       │ • Provider unavailable       │
       │ • Customer request           │
       │ • Provider delayed           │
       │ • Other                      │
       │                              │
       │ Comments: __________________ │
       │                              │
       │ [Continue]                   │
       └──────────────────────────────┘
        │
        ▼
   A3. Find Alternative Provider:
       Query available providers      Same matching algorithm
       Show list with ratings         as automated matching
        │
        ▼
   A4. Select new provider:
       ┌──────────────────────────────┐
       │ ⦿ Amit Sharma                │
       │   ⭐ 4.8 (300 services)      │
       │   Distance: 1.5 km           │
       │   Available: ✓               │
       │                              │
       │ ○ Vijay Patel                │
       │   ⭐ 4.7 (200 services)      │
       │   Distance: 3.2 km           │
       │                              │
       │ [Assign Selected Provider]   │
       └──────────────────────────────┘
        │
        ▼
   A5. Confirm reassignment
                      ────────►  Update booking             ──────► Update:
                                 Notify old provider                 ├─ providerId: new_provider_id
                                 (with cancellation reason)          ├─ reassignedAt: timestamp
                                 Notify new provider                 ├─ reassignedBy: adminId
                                 Notify customer                     └─ reassignReason: "..."
                                        │
        ┌───────────────────────────────┘
        ▼
   A6. Reassignment Complete
       Success message shown

   [SCENARIO B: CANCEL BOOKING]
   ────────────────────────────
        │
        ▼
   B1. Click [Cancel Booking]
        │
        ▼
   B2. Cancellation Form:
       ┌──────────────────────────────┐
       │ CANCEL BOOKING               │
       ├──────────────────────────────┤
       │ Reason:                      │
       │ • Customer request           │
       │ • Provider unavailable       │
       │ • Service not feasible       │
       │ • Duplicate booking          │
       │ • Other                      │
       │                              │
       │ Refund Amount:               │
       │ • Full refund (₹512.42)      │
       │ • Partial refund: ₹_____     │
       │ • No refund                  │
       │                              │
       │ Cancellation Note:           │
       │ ┌──────────────────────────┐ │
       │ │ Provider had emergency   │ │
       │ │ Issuing full refund      │ │
       │ └──────────────────────────┘ │
       │                              │
       │ Notify:                      │
       │ ☑ Customer (Email + SMS)     │
       │ ☑ Provider (Email + SMS)     │
       │                              │
       │ [Cancel] [Confirm Cancellation]│
       └──────────────────────────────┘
        │
        ▼
   B3. Confirm cancellation
                      ────────►  Update status              ──────► Update:
                                 Initiate refund                     ├─ status: 'cancelled'
                                 Send notifications                  ├─ cancelledAt: timestamp
                                 Create audit log                    ├─ cancelledBy: adminId
                                 Free provider slot                  ├─ cancellationReason
                                        │                            └─ refundAmount: 512.42
        ┌───────────────────────────────┘
        ▼
   B4. Booking cancelled
       Refund processed
       All parties notified

   [SCENARIO C: HANDLE DISPUTE]
   ────────────────────────────
        │
        ▼
   C1. Dispute raised by customer
       or provider
        │
        ▼
   C2. Dispute Details:
       ┌──────────────────────────────┐
       │ DISPUTE #DIS-12345           │
       ├──────────────────────────────┤
       │ Raised By: Customer          │
       │ Booking: BKG-12345           │
       │ Date: 31 Dec 2024            │
       │                              │
       │ Issue: "Service incomplete.  │
       │ AC still not cooling         │
       │ properly."                   │
       │                              │
       │ Evidence:                    │
       │ • Photos uploaded (3)        │
       │ • Video uploaded (1)         │
       │                              │
       │ Provider Response:           │
       │ "Completed all checklist     │
       │ items. Customer's AC needs   │
       │ gas refill which is extra."  │
       └──────────────────────────────┘
        │
        ▼
   C3. Admin Investigation:
       ├─ Review service photos
       ├─ Check completion checklist
       ├─ Review communication logs
       ├─ Call both parties
       └─ Check service SOP
        │
        ▼
   C4. Resolution Options:
       ┌──────────────────────────────┐
       │ RESOLVE DISPUTE              │
       ├──────────────────────────────┤
       │ ⦿ Partial refund to customer │
       │   Amount: ₹250 (50%)         │
       │                              │
       │ ○ Full refund + penalty      │
       │   Provider penalty: ₹500     │
       │                              │
       │ ○ Free re-service            │
       │   Assign different provider  │
       │                              │
       │ ○ Close with no action       │
       │   Insufficient evidence      │
       │                              │
       │ Resolution Note:             │
       │ ┌──────────────────────────┐ │
       │ │ AC gas refill is outside │ │
       │ │ service scope. Partial   │ │
       │ │ refund as goodwill.      │ │
       │ └──────────────────────────┘ │
       │                              │
       │ [Cancel] [Apply Resolution]  │
       └──────────────────────────────┘
        │
        ▼
   C5. Apply resolution
                      ────────►  Process refund if any
                                 Update provider rating
                                 Send resolution email
                                 Close dispute           ──────► Update:
                                 Create case study                ├─ disputeStatus: 'resolved'
                                        │                         ├─ resolution: "..."
        ┌───────────────────────────────┘                        ├─ resolvedAt: timestamp
        ▼                                                         └─ resolvedBy: adminId
   C6. Dispute resolved
       Both parties notified

─────────────────────────────────────────────────────────────────────────

BULK OPERATIONS:

Admin can perform bulk actions:
      │
      ├─► Export bookings (CSV, Excel)
      │   └─ Filtered date range
      │
      ├─► Bulk cancel (emergency)
      │   └─ E.g., city-wide shutdown
      │
      ├─► Bulk reassign
      │   └─ If provider unavailable
      │
      └─► Generate reports
          ├─ Revenue by service
          ├─ Provider performance
          └─ Cancellation analysis

─────────────────────────────────────────────────────────────────────────
```

---

## 5. Refund Processing Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                     REFUND PROCESSING WORKFLOW                      │
└─────────────────────────────────────────────────────────────────────┘

Trigger/Action                     System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

[REFUND INITIATED BY]
├─ Customer cancellation
├─ Admin cancellation
├─ Provider no-show
├─ Service quality issue
└─ Payment error
        │
        ▼
1. Refund Request Created         Create refund record       ──────► Create: refunds/{refundId}
                                         │                              ├─ bookingId
        ┌────────────────────────────────┘                             ├─ customerId
        ▼                                                               ├─ amount: 512.42
2. Admin Dashboard Notification                                        ├─ reason: 'cancellation'
   "New refund request"                                                ├─ status: 'pending'
        │                                                               ├─ requestedAt: timestamp
        ▼                                                               └─ requestedBy: userId
3. Navigate to:                   Load refunds dashboard
   Payments → Refunds → Pending
        │
        ▼
4. REFUNDS DASHBOARD
   ═════════════════

   ┌──────────────────────────────────────────────────────────────────┐
   │ PENDING REFUNDS                                                  │
   ├──────────────────────────────────────────────────────────────────┤
   │ Refund ID  Booking ID  Customer    Amount   Reason       Action  │
   ├──────────────────────────────────────────────────────────────────┤
   │ REF-001    BKG-12345   John Doe    ₹512.42  Cancellation [Process]│
   │ REF-002    BKG-12346   Jane S      ₹250.00  Partial      [Process]│
   │ REF-003    BKG-12347   Raj K       ₹699.00  No-show      [Process]│
   └──────────────────────────────────────────────────────────────────┘
        │
        ▼
5. Click [Process] on REF-001     Load refund details
        │
        ▼
6. REFUND DETAIL VIEW
   ══════════════════

   ┌────────────────────────────────────┐
   │ REFUND REQUEST #REF-001            │
   │ Status: PENDING REVIEW             │
   ├────────────────────────────────────┤
   │ BOOKING DETAILS                    │
   ├────────────────────────────────────┤
   │ Booking ID: BKG-12345              │
   │ Service: AC Repair & Service       │
   │ Date: 31 Dec 2024, 2:00 PM         │
   │ Customer: John Doe                 │
   │ Provider: Rajesh Kumar             │
   ├────────────────────────────────────┤
   │ PAYMENT DETAILS                    │
   ├────────────────────────────────────┤
   │ Original Amount: ₹512.42           │
   │ Payment Method: UPI                │
   │ Transaction ID: pay_abc123         │
   │ Payment Date: 30 Dec 2024          │
   ├────────────────────────────────────┤
   │ REFUND REQUEST                     │
   ├────────────────────────────────────┤
   │ Requested By: Customer             │
   │ Requested On: 31 Dec 2024, 1:00 PM │
   │ Reason: Booking cancelled by       │
   │         customer 6 hours before    │
   │         scheduled time             │
   │                                    │
   │ Refund Amount Requested: ₹512.42   │
   ├────────────────────────────────────┤
   │ CANCELLATION POLICY                │
   ├────────────────────────────────────┤
   │ Cancelled: 6 hours before service  │
   │ Policy: Full refund (>4 hrs before)│
   │ Eligible Refund: ₹512.42 (100%)    │
   └────────────────────────────────────┘
        │
        ▼
7. ELIGIBILITY CHECK
   ═════════════════

   System auto-calculates:
   ├─ Cancellation time vs service time
   │  └─ 6 hours before → Eligible
   │
   ├─ Refund policy rules:
   │  ├─ >4 hours: 100% refund ✓
   │  ├─ 2-4 hours: 50% refund
   │  └─ <2 hours: No refund
   │
   ├─ Payment status:
   │  └─ Paid ✓
   │
   └─ Previous refunds count:
      └─ 0 refunds in last 30 days ✓
        │
        ▼
   ELIGIBILITY: APPROVED ✓
   Recommended: Full Refund ₹512.42
        │
        ▼
8. ADMIN REVIEW
   ════════════

   Admin options:
   ┌────────────────────────────────────┐
   │ REFUND DECISION                    │
   ├────────────────────────────────────┤
   │ ⦿ APPROVE FULL REFUND              │
   │   Amount: ₹512.42                  │
   │   Method:                          │
   │   ○ Original payment method (UPI)  │
   │      Timeline: 3-5 business days   │
   │   ⦿ UrbanNest Wallet (Instant)     │
   │                                    │
   │ ○ APPROVE PARTIAL REFUND           │
   │   Amount: ₹ __________             │
   │   Reason: ____________________     │
   │                                    │
   │ ○ REJECT REFUND                    │
   │   Reason: ____________________     │
   │                                    │
   │ Admin Notes (Optional):            │
   │ ┌────────────────────────────────┐ │
   │ │ Booking cancelled as per       │ │
   │ │ policy. Approving full refund  │ │
   │ │ to wallet for instant credit.  │ │
   │ └────────────────────────────────┘ │
   │                                    │
   │ Notify Customer:                   │
   │ ☑ Email                            │
   │ ☑ SMS                              │
   │ ☑ In-app notification              │
   │                                    │
   │ [Cancel] [Process Refund]          │
   └────────────────────────────────────┘
        │
        ▼
9. Admin selects:
   ⦿ Approve Full Refund
   ⦿ To UrbanNest Wallet (Instant)
        │
        ▼
10. Click [Process Refund]
                      ────────►  Validate refund amount
                                 Check wallet balance limit
                                 Process refund            ──────► Update multiple collections:
                                        │
        ┌───────────────────────────────┴──────────────┐          bookings/{bookingId}:
        │                                               │          ├─ refundStatus: 'processed'
        ▼                                               ▼          ├─ refundAmount: 512.42
   [WALLET REFUND]                            [BANK REFUND]        └─ refundedAt: timestamp
        │                                               │
        │                                               │          refunds/{refundId}:
   Update wallet balance                    Call Razorpay API      ├─ status: 'approved'
   ├─ Current: ₹0                            Create refund request  ├─ approvedBy: adminId
   ├─ Add: ₹512.42                           Razorpay processes     ├─ approvedAt: timestamp
   └─ New: ₹512.42                           (3-5 days)             ├─ refundMethod: 'wallet'
        │                                               │           └─ processedAt: timestamp
        ▼                                               ▼
   Create wallet                             Create refund          users/{userId}:
   transaction:                              transaction:           └─ walletBalance: +512.42
   ├─ Type: Credit                           ├─ Type: Bank Refund
   ├─ Amount: ₹512.42                        ├─ Status: Processing  transactions/{transId}:
   ├─ Reason: Refund                         ├─ Timeline: 3-5 days  ├─ type: 'refund'
   └─ Reference: BKG-12345                   └─ Razorpay ID: rfnd_x ├─ amount: 512.42
        │                                               │           ├─ bookingId: BKG-12345
        │                                               │           └─ createdAt: timestamp
        ├───────────────────────────────────────────────┤
        │                                               │
        ▼                                               ▼
11. Send Notifications                      Send Notifications
        │                                               │
        ├─► Email:                                      ├─► Email:
        │   "Refund Processed                           │   "Refund Initiated"
        │   ₹512.42 added to your                       │   "₹512.42 will be
        │   UrbanNest wallet instantly!"                │    credited in 3-5 days"
        │                                               │
        ├─► SMS:                                        ├─► SMS:
        │   "Refund of ₹512.42 added                    │   "Refund processing.
        │    to wallet. Use for next                    │    Check bank in 3-5 days"
        │    booking! -UrbanNest"                       │
        │                                               │
        └─► In-app Notification:                        └─► In-app:
            "✓ Refund added to wallet"                      "⏳ Refund processing"
        │
        ▼
12. REFUND COMPLETED

    Admin dashboard shows:
    ┌────────────────────────────────────┐
    │ ✓ REFUND PROCESSED                 │
    │                                    │
    │ Refund ID: REF-001                 │
    │ Amount: ₹512.42                    │
    │ Method: Wallet (Instant)           │
    │ Status: COMPLETED                  │
    │                                    │
    │ Customer notified via:             │
    │ ✓ Email                            │
    │ ✓ SMS                              │
    │ ✓ In-app notification              │
    │                                    │
    │ [View Receipt] [Close]             │
    └────────────────────────────────────┘
        │
        ▼
13. Create Audit Log                ──────► auditLogs/{logId}:
                                             ├─ action: 'refund_processed'
                                             ├─ adminId: adminId
                                             ├─ refundId: REF-001
                                             ├─ bookingId: BKG-12345
                                             ├─ amount: 512.42
                                             ├─ method: 'wallet'
                                             └─ timestamp
        │
        ▼
14. Customer View:

    Customer's dashboard:
    ┌────────────────────────────────────┐
    │ WALLET BALANCE                     │
    │ ₹512.42                            │
    │                                    │
    │ Recent Transaction:                │
    │ + ₹512.42 (Refund for BKG-12345)   │
    │   31 Dec 2024, 1:30 PM             │
    │                                    │
    │ [Use Wallet for Next Booking]      │
    └────────────────────────────────────┘
        │
        ▼
15. Next Booking:
    Customer can use wallet balance
    to pay for future services

─────────────────────────────────────────────────────────────────────────

SPECIAL CASES:

[PARTIAL REFUND]
├─ Service partially completed
├─ Admin decides: 50% refund (₹256.21)
└─ Process same as full refund

[REFUND REJECTION]
├─ Reason: Outside cancellation policy
├─ Send rejection email with explanation
└─ Provide alternative resolution

[FAILED REFUND]
├─ Bank account closed
├─ UPI ID invalid
└─ Retry with different method or wallet

[BULK REFUNDS]
├─ City-wide service disruption
├─ Select multiple bookings
└─ Process refunds in batch

REFUND TIMELINE TRACKING:
└─► Wallet refunds: Instant
└─► Bank refunds:
    ├─ Day 0: Initiated
    ├─ Day 1: Razorpay processing
    ├─ Day 3-5: Bank credit
    └─ Customer can track status

─────────────────────────────────────────────────────────────────────────
```

---

## 6. Service Catalog Management Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                  SERVICE CATALOG MANAGEMENT WORKFLOW                │
└─────────────────────────────────────────────────────────────────────┘

Admin Action                       System Response                    Database Update
─────────────────                 ─────────────────                  ────────────────

[ADMIN WANTS TO ADD NEW SERVICE]
        │
        ▼
1. Navigate to:                   Load services dashboard
   Services → Service Catalog
        │
        ▼
2. SERVICES DASHBOARD
   ══════════════════

   Current services list:
   ┌──────────────────────────────────────────────────────────────────┐
   │ ACTIVE SERVICES (127)                          [+ Add Service]   │
   ├──────────────────────────────────────────────────────────────────┤
   │ Service Name         Category        Price   Cities   Status     │
   ├──────────────────────────────────────────────────────────────────┤
   │ AC Repair           Home Appliances  ₹499    12      Active [Edit]│
   │ Plumbing            Home Services    ₹349    15      Active [Edit]│
   │ Salon at Home       Beauty          ₹799    8       Active [Edit]│
   │ House Cleaning      Cleaning        ₹599    20      Active [Edit]│
   └──────────────────────────────────────────────────────────────────┘
        │
        ▼
3. Click [+ Add Service]          Open service creation form
        │
        ▼
4. SERVICE CREATION FORM
   ═════════════════════

   ┌────────────────────────────────────────────────────────────┐
   │ ADD NEW SERVICE                                            │
   ├────────────────────────────────────────────────────────────┤
   │                                                            │
   │ STEP 1: BASIC INFORMATION                                  │
   │ ─────────────────────────                                  │
   │                                                            │
   │ Service Name: *                                            │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Refrigerator Repair                                    │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Category: *                                                │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Home Appliances                              ▼         │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Sub-Category: (Optional)                                   │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Kitchen Appliances                           ▼         │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Short Description: *                                       │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Professional refrigerator repair service for all       │ │
   │ │ brands. Expert technicians with 10+ years experience.  │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Detailed Description: *                                    │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Our refrigerator repair service includes:              │ │
   │ │ • Complete diagnosis of cooling issues                 │ │
   │ │ • Gas leak detection and repair                        │ │
   │ │ • Compressor check and repair                          │ │
   │ │ • Thermostat replacement                               │ │
   │ │ • Door seal replacement                                │ │
   │ │ • Ice maker repair                                     │ │
   │ │ • 30-day warranty on all repairs                       │ │
   │ │                                                        │ │
   │ │ All brands supported: LG, Samsung, Whirlpool, etc.     │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ [Continue to Step 2]                                       │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
5. Fill basic info, click Continue Validate required fields
                                   Save draft               ──────► Create draft:
        │                                                            services/{serviceId}
        ▼                                                            ├─ name: 'Refrigerator Repair'
                                                                     ├─ category: 'Home Appliances'
   ┌────────────────────────────────────────────────────────────┐   ├─ description: '...'
   │ STEP 2: PRICING & DURATION                                 │   ├─ status: 'draft'
   │ ──────────────────────────                                 │   └─ createdAt: timestamp
   │                                                            │
   │ Base Price (₹): *                                          │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ 599                                                    │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Price Type:                                                │
   │ ⦿ Fixed Price                                              │
   │ ○ Starting From (₹599 onwards)                             │
   │ ○ Hourly Rate                                              │
   │                                                            │
   │ Estimated Duration (minutes): *                            │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ 90                                                     │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ GST Applicable:                                            │
   │ ☑ Yes (18%)                                                │
   │                                                            │
   │ What's Included in Base Price:                             │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ • Complete diagnosis                                   │ │
   │ │ • Gas leak check                                       │ │
   │ │ • Cooling performance test                             │ │
   │ │ • Door seal inspection                                 │ │
   │ │ • General service and cleaning                         │ │
   │ │ • 30-day warranty on service                           │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ What's NOT Included (Extra Charges):                       │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ • Gas refilling (₹2,500 - ₹4,000)                     │ │
   │ │ • Compressor replacement (₹5,000 - ₹8,000)            │ │
   │ │ • Thermostat replacement (₹800 - ₹1,500)              │ │
   │ │ • Parts and components (as per actual)                 │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ [Back] [Continue to Step 3]                                │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
6. Fill pricing, click Continue   Update draft with pricing ──────► Update:
        │                                                            ├─ basePrice: 599
        ▼                                                            ├─ priceType: 'fixed'
                                                                     ├─ duration: 90
   ┌────────────────────────────────────────────────────────────┐   ├─ inclusions: [...]
   │ STEP 3: MEDIA & IMAGES                                     │   └─ exclusions: [...]
   │ ──────────────────                                         │
   │                                                            │
   │ Primary Service Image: *                                   │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │  [Upload Image]                                        │ │
   │ │  Recommended: 1200x800px, JPG/PNG, < 2MB               │ │
   │ │                                                        │ │
   │ │  [Preview: Refrigerator technician working]            │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Gallery Images: (Up to 5)                                  │
   │ ┌──────────┐ ┌──────────┐ ┌──────────┐                    │
   │ │[Image 1] │ │[Image 2] │ │[Image 3] │ [+ Add More]       │
   │ └──────────┘ └──────────┘ └──────────┘                    │
   │                                                            │
   │ Service Video: (Optional)                                  │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │  [Upload Video]                                        │ │
   │ │  Max: 60 seconds, MP4, < 50MB                          │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Icon/Thumbnail: *                                          │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │  [Upload Icon]                                         │ │
   │ │  Square: 512x512px, PNG with transparency              │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ [Back] [Continue to Step 4]                                │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
7. Upload images                  Upload to Firebase Storage
                      ────────►   Generate secure URLs       ──────► Update:
        │                         Optimize images                    ├─ primaryImage: 'url'
        ▼                         Create thumbnails                  ├─ gallery: ['url1', 'url2']
                                        │                            ├─ videoUrl: 'url'
        ┌───────────────────────────────┘                            └─ icon: 'url'
        ▼
   ┌────────────────────────────────────────────────────────────┐
   │ STEP 4: AVAILABILITY & CITIES                              │
   │ ─────────────────────────────                              │
   │                                                            │
   │ Select Cities Where Available: *                           │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ ☑ Delhi NCR                                            │ │
   │ │ ☑ Mumbai                                               │ │
   │ │ ☑ Bangalore                                            │ │
   │ │ ☑ Hyderabad                                            │ │
   │ │ ☐ Pune                                                 │ │
   │ │ ☐ Chennai                                              │ │
   │ │ ☐ Kolkata                                              │ │
   │ │                                                        │ │
   │ │ [Select All] [Clear All]                               │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ City-Specific Pricing (Optional):                          │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ City        Base Price   Multiplier   Final Price      │ │
   │ ├────────────────────────────────────────────────────────┤ │
   │ │ Delhi NCR   ₹599        1.0x          ₹599             │ │
   │ │ Mumbai      ₹599        1.2x          ₹719             │ │
   │ │ Bangalore   ₹599        1.1x          ₹659             │ │
   │ │ Hyderabad   ₹599        1.0x          ₹599             │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Operational Hours:                                         │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Monday - Saturday: 08:00 AM - 08:00 PM                 │ │
   │ │ Sunday: 10:00 AM - 06:00 PM                            │ │
   │ │                                                        │ │
   │ │ [Customize Hours]                                      │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Surge Pricing Rules: (Optional)                            │
   │ ☐ Enable weekend surcharge (+20%)                         │
   │ ☐ Enable holiday surcharge (+30%)                         │
   │ ☐ Enable late evening surcharge (+15%) [after 7 PM]       │
   │                                                            │
   │ [Back] [Continue to Step 5]                                │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
8. Select cities, click Continue  Update availability       ──────► Update:
        │                                                            ├─ cities: ['delhi', 'mumbai'...]
        ▼                                                            ├─ cityPricing: {...}
                                                                     ├─ operationalHours: {...}
   ┌────────────────────────────────────────────────────────────┐   └─ surgePricing: {...}
   │ STEP 5: PROVIDER REQUIREMENTS                              │
   │ ─────────────────────────                                  │
   │                                                            │
   │ Required Skills/Certifications:                            │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ ☑ HVAC Technician Certification                        │ │
   │ │ ☑ Refrigeration Specialist                             │ │
   │ │ ☐ Electrical License                                   │ │
   │ │ ☑ Minimum 3 years experience                           │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Tools/Equipment Providers Must Have:                       │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ • Multimeter                                           │ │
   │ │ • Gas leak detector                                    │ │
   │ │ • Screwdriver set                                      │ │
   │ │ • Spare fuses and basic parts                          │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Commission Rate for Providers: *                           │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ 20 %                                                   │ │
   │ │ Provider receives ₹479.20 (80% of ₹599)                │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ [Back] [Continue to Step 6]                                │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
9. Configure requirements         Update requirements       ──────► Update:
        │                                                            ├─ requirements: [...]
        ▼                                                            ├─ tools: [...]
                                                                     └─ commissionRate: 20
   ┌────────────────────────────────────────────────────────────┐
   │ STEP 6: SEO & METADATA                                     │
   │ ──────────────────────                                     │
   │                                                            │
   │ SEO Title: *                                               │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Refrigerator Repair Service | Expert Technicians       │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ SEO Description: *                                         │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Professional refrigerator repair service. All brands.  │ │
   │ │ Expert technicians. 30-day warranty. Book online now!  │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Keywords (comma-separated):                                │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ refrigerator repair, fridge repair, cooling issue,     │ │
   │ │ gas refill, compressor repair                          │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ FAQ Section:                                               │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ Q: How long does repair take?                          │ │
   │ │ A: Most repairs complete in 60-90 minutes.             │ │
   │ │                                                        │ │
   │ │ Q: Do you service all brands?                          │ │
   │ │ A: Yes, all major brands are supported.                │ │
   │ │                                                        │ │
   │ │ [+ Add More FAQs]                                      │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ [Back] [Continue to Review]                                │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
10. Add SEO metadata              Update SEO fields         ──────► Update:
        │                                                            ├─ seo: {title, description}
        ▼                                                            ├─ keywords: [...]
                                                                     └─ faqs: [...]
   ┌────────────────────────────────────────────────────────────┐
   │ STEP 7: REVIEW & PUBLISH                                   │
   │ ────────────────────────                                   │
   │                                                            │
   │ PREVIEW:                                                   │
   │ ┌────────────────────────────────────────────────────────┐ │
   │ │ [Service Card Preview - How it appears to customers]   │ │
   │ │                                                        │ │
   │ │ ┌────────────────────┐                                 │ │
   │ │ │ [Fridge Image]     │  Refrigerator Repair           │ │
   │ │ └────────────────────┘  ⭐ New Service                 │ │
   │ │                                                        │ │
   │ │  ₹599 · ~90 minutes                                    │ │
   │ │  Available in 4 cities                                 │ │
   │ │                                                        │ │
   │ │  Professional refrigerator repair...                   │ │
   │ │                                                        │ │
   │ │  [Book Now]                                            │ │
   │ └────────────────────────────────────────────────────────┘ │
   │                                                            │
   │ Service Summary:                                           │
   │ ├─ Name: Refrigerator Repair                              │
   │ ├─ Category: Home Appliances                              │
   │ ├─ Base Price: ₹599                                       │
   │ ├─ Duration: 90 minutes                                   │
   │ ├─ Cities: Delhi, Mumbai, Bangalore, Hyderabad (4)        │
   │ ├─ Commission: 20%                                        │
   │ └─ Status: Draft                                          │
   │                                                            │
   │ Publish Options:                                           │
   │ ⦿ Publish Immediately                                      │
   │   Service will be visible to customers instantly          │
   │                                                            │
   │ ○ Save as Draft                                            │
   │   Service saved but not visible to customers              │
   │                                                            │
   │ ○ Schedule for Later                                       │
   │   Choose date/time: [___________]                          │
   │                                                            │
   │ [Back] [Save Draft] [Publish Service]                      │
   └────────────────────────────────────────────────────────────┘
        │
        ▼
11. Select "Publish Immediately"
    Click [Publish Service]
                      ────────►  Final validation            ──────► Update:
                                 Generate service slug                ├─ status: 'active'
                                 Create search index                  ├─ publishedAt: timestamp
                                 Update city availability             ├─ publishedBy: adminId
                                 Notify eligible providers            └─ slug: 'refrigerator-repair'
                                 Send admin confirmation
                                        │
        ┌───────────────────────────────┘
        ▼
12. SUCCESS SCREEN
    ┌────────────────────────────────────┐
    │ ✓ SERVICE PUBLISHED!               │
    │                                    │
    │ Refrigerator Repair is now live    │
    │ and available for booking.         │
    │                                    │
    │ Service URL:                       │
    │ urbanest.com/services/             │
    │ refrigerator-repair                │
    │                                    │
    │ Notifications Sent:                │
    │ ✓ 45 eligible providers notified   │
    │ ✓ Marketing team notified          │
    │                                    │
    │ Next Steps:                        │
    │ ├─ Monitor bookings                │
    │ ├─ Track provider adoption         │
    │ └─ Review customer feedback        │
    │                                    │
    │ [View Live Service]                │
    │ [Add Another Service]              │
    │ [Back to Dashboard]                │
    └────────────────────────────────────┘
        │
        ▼
13. Service is now live!
    ├─ Appears in customer portal
    ├─ Eligible providers can offer service
    ├─ Search indexed
    └─ Analytics tracking started

─────────────────────────────────────────────────────────────────────────

EDITING EXISTING SERVICE:

Admin wants to update AC Repair price:
      │
      ▼
1. Services Dashboard → Find "AC Repair"
      │
      ▼
2. Click [Edit]
      │
      ▼
3. Edit Service Form (pre-filled)
   └─ Change base price: ₹499 → ₹599
      │
      ▼
4. Click [Save Changes]
                      ────────►  Create version history
                                 Update service
                                 Notify active bookings
                                 Update pricing index
                                        │
                                        ▼
                                 ✓ Service updated
                                 New bookings use ₹599
                                 Active bookings unaffected

DEACTIVATING A SERVICE:

1. Click [Deactivate] on service
      │
      ▼
2. Confirmation dialog:
   "Deactivate service?
    - New bookings will stop
    - Active bookings continue
    - Service hidden from customers"
      │
      ▼
3. Confirm → Service deactivated
              Status: 'inactive'

─────────────────────────────────────────────────────────────────────────
```

---

## 7. Dispute Resolution Workflow

*(Covered in detail in Section 4 - Admin Booking Management, Scenario C)*

Key steps:
1. Dispute raised by customer or provider
2. Admin reviews evidence (photos, videos, chat logs)
3. Admin investigates (contact both parties, check SOPs)
4. Admin decides resolution (refund, penalty, re-service, or close)
5. Resolution applied and both parties notified
6. Case documented for future reference

---

## 8. Provider Performance Review Workflow

```
┌─────────────────────────────────────────────────────────────────────┐
│                  PROVIDER PERFORMANCE REVIEW                        │
└─────────────────────────────────────────────────────────────────────┘

Trigger: Monthly automated review
        │
        ▼
1. System generates performance report for each provider

   Metrics tracked:
   ├─ Total bookings completed
   ├─ Average rating (out of 5)
   ├─ Customer complaints
   ├─ Cancellation rate
   ├─ On-time arrival rate
   ├─ Service completion time
   ├─ Re-service requests
   └─ Revenue generated
        │
        ▼
2. Admin Dashboard → Providers → Performance Reports
        │
        ▼
3. View provider performance:

   ┌────────────────────────────────────┐
   │ RAJESH KUMAR - Performance Report  │
   │ Period: December 2024              │
   ├────────────────────────────────────┤
   │ Overall Rating: 4.9/5 ⭐⭐⭐⭐⭐  │
   │ Status: EXCELLENT                  │
   ├────────────────────────────────────┤
   │ Metrics:                           │
   │ ├─ Total Services: 85              │
   │ ├─ Completed: 83 (97.6%)           │
   │ ├─ Cancelled: 2 (2.4%)             │
   │ ├─ On-time: 81/83 (97.6%)          │
   │ ├─ Avg Completion: 62 min          │
   │ ├─ Re-service: 1 (1.2%)            │
   │ ├─ Complaints: 0                   │
   │ └─ Revenue: ₹40,120                │
   │                                    │
   │ Customer Feedback:                 │
   │ "Excellent service!"  - 78 reviews │
   │ "Very professional"   - 65 reviews │
   │                                    │
   │ [View Details] [Send Appreciation] │
   └────────────────────────────────────┘
        │
        ▼
4. [IF PERFORMANCE EXCELLENT]
   ├─► Send appreciation email
   ├─► Badge: "Top Performer"
   ├─► Bonus: Performance incentive
   └─► Priority job assignment

   [IF PERFORMANCE POOR]
   ├─► Send warning email
   ├─► Mandatory training
   ├─► Probation period
   └─► Consider suspension

─────────────────────────────────────────────────────────────────────────
```

---

## Summary

This document provides complete workflow diagrams for all critical processes in the UrbanNest platform:

1. **Customer Registration** - Phone OTP (primary), Email, and Google Sign-In flows
2. **Provider Onboarding & Approval** - Complete KYC verification and admin approval process
3. **Customer Booking** - End-to-end booking from service discovery to rating
4. **Admin Booking Management** - Reassignment, cancellation, and dispute resolution
5. **Refund Processing** - Wallet and bank refund workflows
6. **Service Catalog Management** - Creating and publishing new services
7. **Dispute Resolution** - Handling customer-provider disputes
8. **Provider Performance Review** - Monthly performance evaluation

Each workflow includes:
- Step-by-step actions
- System responses
- Database updates
- User notifications
- Error handling
- Edge cases

These workflows serve as the blueprint for implementing the complete UrbanNest platform.

---

**Document Version:** 1.0
**Last Updated:** 30 December 2024
**Author:** CityServe Development Team
