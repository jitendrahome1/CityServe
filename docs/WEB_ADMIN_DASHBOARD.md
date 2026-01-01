# WEB_ADMIN_DASHBOARD.md

**UrbanNest Admin Dashboard - Complete Documentation**

---

## Table of Contents

1. [Overview](#overview)
2. [Technology Stack](#technology-stack)
3. [Authentication & Authorization](#authentication--authorization)
4. [Dashboard Layout](#dashboard-layout)
5. [Provider Management](#provider-management)
6. [Customer Management](#customer-management)
7. [Service Catalog Management](#service-catalog-management)
8. [Booking Oversight](#booking-oversight)
9. [Pricing Configuration](#pricing-configuration)
10. [City & Zone Management](#city--zone-management)
11. [Analytics & Reporting](#analytics--reporting)
12. [Dispute Resolution](#dispute-resolution)
13. [Refund Processing](#refund-processing)
14. [Notifications & Alerts](#notifications--alerts)
15. [Settings & Configuration](#settings--configuration)
16. [Audit Logs](#audit-logs)

---

## 1. Overview

### Purpose
The UrbanNest Admin Dashboard is a comprehensive web-based management system that enables administrators to oversee all platform operations, manage providers and customers, configure services, handle disputes, and monitor business metrics.

### Target Users

**Super Admin:**
- Full access to all features
- Platform-wide configuration
- User role management
- Financial oversight

**City Manager:**
- Manage operations within assigned cities
- Provider verification and approval
- Local pricing configuration
- Zone management

**Support Staff:**
- Handle customer support tickets
- Process refunds
- Resolve disputes
- View booking details (limited)

**Finance Manager:**
- Financial reports
- Payout processing
- Revenue analytics
- Transaction oversight

### Key Objectives
1. **Operational Efficiency**: Streamline daily operations
2. **Quality Control**: Ensure service quality through provider verification
3. **Customer Satisfaction**: Quick dispute resolution and support
4. **Business Intelligence**: Data-driven decision making
5. **Scalability**: Manage multi-city operations

---

## 2. Technology Stack

### Frontend
- **Next.js 14+**: Framework with App Router
- **React 18**: UI library
- **TypeScript**: Type safety
- **Tailwind CSS**: Styling
- **Shadcn/ui**: Component library
- **Recharts**: Charts and graphs
- **TanStack Table**: Data tables with sorting/filtering
- **React Hook Form + Zod**: Form handling

### Backend Integration
- **Firebase Admin SDK**: Server-side Firebase operations
- **Cloud Functions**: API endpoints
- **Firestore**: Real-time data

### State Management
- **Zustand**: Global state
- **SWR**: Data fetching and caching

### Authentication
- **Firebase Auth**: Admin authentication
- **2FA**: Two-factor authentication (optional)
- **RBAC**: Role-based access control

### Data Visualization
- **Recharts**: Line charts, bar charts, pie charts
- **React-Calendar-Heatmap**: Activity heatmaps

### File Handling
- **React Dropzone**: File uploads
- **PDF-lib**: PDF generation for reports

---

## 3. Authentication & Authorization

### 3.1 Admin Login Flow

**Login Page (`/admin/login`):**

```
1. Admin enters email and password
2. Firebase Auth validates credentials
3. If 2FA enabled:
   - Send OTP to registered phone/email
   - Admin enters OTP
   - Verify OTP
4. Fetch admin user document from Firestore
5. Verify admin role (type: 'admin')
6. Check permissions for user's role
7. Generate session token
8. Redirect to dashboard
```

**Technical Implementation:**
```typescript
// app/admin/login/page.tsx
'use client';

import { signInWithEmailAndPassword } from 'firebase/auth';
import { doc, getDoc } from 'firebase/firestore';

export default function AdminLogin() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = async () => {
    try {
      // Step 1: Sign in with Firebase Auth
      const userCredential = await signInWithEmailAndPassword(
        auth,
        email,
        password
      );

      // Step 2: Verify admin role
      const userDoc = await getDoc(
        doc(db, 'users', userCredential.user.uid)
      );

      if (userDoc.data()?.type !== 'admin') {
        throw new Error('Unauthorized: Not an admin user');
      }

      // Step 3: Set admin session
      const token = await userCredential.user.getIdToken();
      document.cookie = `admin_token=${token}; path=/; secure; samesite=strict`;

      // Step 4: Redirect to dashboard
      router.push('/admin/dashboard');
    } catch (error) {
      toast.error('Login failed: ' + error.message);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center">
      <Card className="w-[400px]">
        <CardHeader>
          <h1>UrbanNest Admin</h1>
        </CardHeader>
        <CardContent>
          <form onSubmit={(e) => { e.preventDefault(); handleLogin(); }}>
            <Input
              type="email"
              placeholder="Admin Email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
            <Input
              type="password"
              placeholder="Password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
            <Button type="submit">Login</Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
```

### 3.2 Role-Based Access Control (RBAC)

**User Roles and Permissions:**

```typescript
// lib/roles.ts
export const ROLES = {
  SUPER_ADMIN: 'super_admin',
  CITY_MANAGER: 'city_manager',
  SUPPORT_STAFF: 'support_staff',
  FINANCE_MANAGER: 'finance_manager',
} as const;

export const PERMISSIONS = {
  // Provider Management
  VIEW_PROVIDERS: 'view_providers',
  APPROVE_PROVIDERS: 'approve_providers',
  SUSPEND_PROVIDERS: 'suspend_providers',

  // Customer Management
  VIEW_CUSTOMERS: 'view_customers',
  MANAGE_CUSTOMERS: 'manage_customers',

  // Service Catalog
  VIEW_SERVICES: 'view_services',
  MANAGE_SERVICES: 'manage_services',

  // Bookings
  VIEW_BOOKINGS: 'view_bookings',
  MANAGE_BOOKINGS: 'manage_bookings',
  CANCEL_BOOKINGS: 'cancel_bookings',

  // Financial
  VIEW_REPORTS: 'view_reports',
  PROCESS_REFUNDS: 'process_refunds',
  PROCESS_PAYOUTS: 'process_payouts',

  // Configuration
  MANAGE_CITIES: 'manage_cities',
  MANAGE_PRICING: 'manage_pricing',
  MANAGE_ADMINS: 'manage_admins',
};

export const ROLE_PERMISSIONS = {
  [ROLES.SUPER_ADMIN]: Object.values(PERMISSIONS),
  [ROLES.CITY_MANAGER]: [
    PERMISSIONS.VIEW_PROVIDERS,
    PERMISSIONS.APPROVE_PROVIDERS,
    PERMISSIONS.VIEW_CUSTOMERS,
    PERMISSIONS.VIEW_BOOKINGS,
    PERMISSIONS.MANAGE_BOOKINGS,
    PERMISSIONS.VIEW_SERVICES,
    PERMISSIONS.MANAGE_PRICING,
  ],
  [ROLES.SUPPORT_STAFF]: [
    PERMISSIONS.VIEW_PROVIDERS,
    PERMISSIONS.VIEW_CUSTOMERS,
    PERMISSIONS.VIEW_BOOKINGS,
    PERMISSIONS.PROCESS_REFUNDS,
  ],
  [ROLES.FINANCE_MANAGER]: [
    PERMISSIONS.VIEW_REPORTS,
    PERMISSIONS.PROCESS_REFUNDS,
    PERMISSIONS.PROCESS_PAYOUTS,
  ],
};

export function hasPermission(userRole: string, permission: string): boolean {
  return ROLE_PERMISSIONS[userRole]?.includes(permission) || false;
}
```

**Protected Routes:**
```typescript
// middleware.ts
import { hasPermission } from '@/lib/roles';

export async function middleware(request: NextRequest) {
  const token = request.cookies.get('admin_token');

  if (!token) {
    return NextResponse.redirect(new URL('/admin/login', request.url));
  }

  // Verify token and get user role
  const user = await verifyAdminToken(token.value);

  // Check route-specific permissions
  const pathname = request.nextUrl.pathname;

  if (pathname.startsWith('/admin/providers/approve')) {
    if (!hasPermission(user.role, PERMISSIONS.APPROVE_PROVIDERS)) {
      return NextResponse.redirect(new URL('/admin/unauthorized', request.url));
    }
  }

  return NextResponse.next();
}
```

### 3.3 Session Management

**Session Settings:**
- **Duration**: 8 hours
- **Auto-logout**: After 30 minutes of inactivity
- **Token refresh**: Every 1 hour
- **Concurrent sessions**: Not allowed (logout from other devices)

---

## 4. Dashboard Layout

### 4.1 Overall Layout Structure

```
┌─────────────────────────────────────────────────────────────┐
│  Header: Logo | City Selector | Notifications | Profile     │
├───────────┬─────────────────────────────────────────────────┤
│           │                                                 │
│  Sidebar  │          Main Content Area                      │
│           │                                                 │
│  - Dashboard                                                │
│  - Providers                                                │
│  - Customers                                                │
│  - Bookings                                                 │
│  - Services                                                 │
│  - Analytics                                                │
│  - Settings                                                 │
│           │                                                 │
└───────────┴─────────────────────────────────────────────────┘
```

### 4.2 Sidebar Navigation

**Navigation Items:**

```typescript
// components/admin/Sidebar.tsx
const navigationItems = [
  {
    label: 'Dashboard',
    icon: LayoutDashboard,
    href: '/admin/dashboard',
    permission: null, // All admins
  },
  {
    label: 'Providers',
    icon: Users,
    permission: PERMISSIONS.VIEW_PROVIDERS,
    children: [
      {
        label: 'Pending Approvals',
        href: '/admin/providers/pending',
        badge: pendingCount,
        permission: PERMISSIONS.APPROVE_PROVIDERS,
      },
      {
        label: 'Active Providers',
        href: '/admin/providers/active',
      },
      {
        label: 'Suspended',
        href: '/admin/providers/suspended',
      },
    ],
  },
  {
    label: 'Customers',
    icon: UserCircle,
    href: '/admin/customers',
    permission: PERMISSIONS.VIEW_CUSTOMERS,
  },
  {
    label: 'Bookings',
    icon: Calendar,
    href: '/admin/bookings',
    permission: PERMISSIONS.VIEW_BOOKINGS,
  },
  {
    label: 'Services',
    icon: Wrench,
    permission: PERMISSIONS.VIEW_SERVICES,
    children: [
      {
        label: 'All Services',
        href: '/admin/services',
      },
      {
        label: 'Categories',
        href: '/admin/categories',
      },
      {
        label: 'Add New Service',
        href: '/admin/services/new',
        permission: PERMISSIONS.MANAGE_SERVICES,
      },
    ],
  },
  {
    label: 'Analytics',
    icon: BarChart3,
    href: '/admin/analytics',
    permission: PERMISSIONS.VIEW_REPORTS,
  },
  {
    label: 'Cities & Zones',
    icon: MapPin,
    href: '/admin/cities',
    permission: PERMISSIONS.MANAGE_CITIES,
  },
  {
    label: 'Settings',
    icon: Settings,
    href: '/admin/settings',
  },
];
```

### 4.3 Dashboard Homepage

**Quick Stats Cards:**

```typescript
// app/admin/dashboard/page.tsx
export default function AdminDashboard() {
  return (
    <div className="p-6">
      {/* Quick Stats */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        <StatsCard
          title="Total Bookings Today"
          value="247"
          change="+12%"
          trend="up"
          icon={Calendar}
        />
        <StatsCard
          title="Active Providers"
          value="1,234"
          change="+5%"
          trend="up"
          icon={Users}
        />
        <StatsCard
          title="Pending Approvals"
          value="18"
          urgent
          icon={AlertCircle}
        />
        <StatsCard
          title="Revenue Today"
          value="₹1,24,500"
          change="+8%"
          trend="up"
          icon={IndianRupee}
        />
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        <Card>
          <CardHeader>
            <h3>Bookings Overview (Last 7 Days)</h3>
          </CardHeader>
          <CardContent>
            <LineChart data={bookingsData} />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <h3>Service Distribution</h3>
          </CardHeader>
          <CardContent>
            <PieChart data={servicesData} />
          </CardContent>
        </Card>
      </div>

      {/* Recent Activity */}
      <Card>
        <CardHeader>
          <h3>Recent Bookings</h3>
        </CardHeader>
        <CardContent>
          <BookingsTable bookings={recentBookings} />
        </CardContent>
      </Card>
    </div>
  );
}
```

---

## 5. Provider Management

### 5.1 Provider Registration Approval Workflow

This is the **most critical feature** for admin operations.

#### Step 1: Pending Applications List (`/admin/providers/pending`)

**Page Features:**

**Filters & Sorting:**
- Filter by:
  - Date submitted (Today, Last 7 days, Last 30 days)
  - Service type (Plumbing, Electrical, Cleaning, etc.)
  - City
  - Priority (High, Normal, Low)
- Sort by:
  - Date submitted (Newest first)
  - Priority
  - Applicant name (A-Z)

**Application Cards/Table:**

```typescript
// components/admin/PendingProviderCard.tsx
interface PendingProviderCardProps {
  application: ProviderApplication;
}

export function PendingProviderCard({ application }: PendingProviderCardProps) {
  return (
    <Card className="mb-4">
      <CardContent className="flex items-center justify-between p-4">
        <div className="flex items-center gap-4">
          <Avatar>
            <AvatarImage src={application.profileImage} />
            <AvatarFallback>{application.name[0]}</AvatarFallback>
          </Avatar>
          <div>
            <h3 className="font-semibold">{application.name}</h3>
            <p className="text-sm text-gray-600">
              {application.services.join(', ')}
            </p>
            <p className="text-xs text-gray-500">
              Applied on {formatDate(application.submittedAt)}
            </p>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <Badge variant={getPriorityVariant(application.priority)}>
            {application.priority}
          </Badge>
          <Badge>{application.city}</Badge>
          <Button onClick={() => router.push(`/admin/providers/review/${application.id}`)}>
            Review Application
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
```

#### Step 2: Application Review Page (`/admin/providers/review/[applicationId]`)

**Layout:**

```
┌────────────────────────────────────────────────────────┐
│  Provider Information                                  │
│  Photo | Name | Phone | Email | City | Experience     │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Document Verification Section                        │
│                                                        │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐│
│  │ Aadhar Card  │  │  PAN Card    │  │Certificates ││
│  │  (Front)     │  │              │  │             ││
│  │ [Image View] │  │ [Image View] │  │[Image View] ││
│  │              │  │              │  │             ││
│  │ ✓ Verify     │  │ ✓ Verify     │  │ ✓ Verify    ││
│  │ ✗ Reject     │  │ ✗ Reject     │  │ ✗ Reject    ││
│  └──────────────┘  └──────────────┘  └─────────────┘│
│                                                        │
│  ┌──────────────┐                                     │
│  │ Aadhar Card  │                                     │
│  │   (Back)     │                                     │
│  │ [Image View] │                                     │
│  │ ✓ Verify     │                                     │
│  │ ✗ Reject     │                                     │
│  └──────────────┘                                     │
├────────────────────────────────────────────────────────┤
│  Bank Details Verification                            │
│  Account Number: ************1234                     │
│  IFSC Code: SBIN0001234                               │
│  Bank Name: State Bank of India                       │
│  ✓ Verified                                           │
├────────────────────────────────────────────────────────┤
│  Background Check (Optional)                          │
│  Police Verification: [ ] Initiated  [ ] Completed    │
│  References: [View Submitted References]              │
├────────────────────────────────────────────────────────┤
│  Admin Notes                                          │
│  [Text area for internal notes]                       │
├────────────────────────────────────────────────────────┤
│  Decision Actions                                     │
│  [Approve] [Reject] [Request More Info]               │
└────────────────────────────────────────────────────────┘
```

**Technical Implementation:**

```typescript
// app/admin/providers/review/[id]/page.tsx
'use client';

export default function ProviderReviewPage({ params }: { params: { id: string } }) {
  const [application, setApplication] = useState<ProviderApplication | null>(null);
  const [documentStatus, setDocumentStatus] = useState({
    aadharFront: 'pending',
    aadharBack: 'pending',
    pan: 'pending',
    certificates: 'pending',
  });
  const [adminNotes, setAdminNotes] = useState('');

  useEffect(() => {
    fetchApplicationDetails(params.id);
  }, [params.id]);

  const handleDocumentVerification = (docType: string, status: 'verified' | 'rejected') => {
    setDocumentStatus(prev => ({ ...prev, [docType]: status }));
  };

  const handleApprove = async () => {
    // Check all documents are verified
    const allVerified = Object.values(documentStatus).every(s => s === 'verified');

    if (!allVerified) {
      toast.error('Please verify all documents before approving');
      return;
    }

    try {
      await apiClient.post(`/admin/providers/${params.id}/approve`, {
        adminNotes,
        documentsVerified: documentStatus,
      });

      toast.success('Provider approved successfully! Welcome email sent.');
      router.push('/admin/providers/active');
    } catch (error) {
      toast.error('Failed to approve provider');
    }
  };

  const handleReject = async () => {
    const reason = prompt('Enter rejection reason:');
    if (!reason) return;

    try {
      await apiClient.post(`/admin/providers/${params.id}/reject`, {
        reason,
        adminNotes,
      });

      toast.success('Provider rejected. Email notification sent.');
      router.push('/admin/providers/pending');
    } catch (error) {
      toast.error('Failed to reject provider');
    }
  };

  const handleRequestMoreInfo = async () => {
    const message = prompt('What additional information is needed?');
    if (!message) return;

    try {
      await apiClient.post(`/admin/providers/${params.id}/request-info`, {
        message,
      });

      toast.success('Information request sent to provider');
      router.push('/admin/providers/pending');
    } catch (error) {
      toast.error('Failed to send request');
    }
  };

  return (
    <div className="p-6">
      {/* Provider Information Card */}
      <Card className="mb-6">
        <CardHeader>
          <h2>Provider Application Review</h2>
        </CardHeader>
        <CardContent>
          <div className="flex items-start gap-6">
            <Avatar className="w-24 h-24">
              <AvatarImage src={application?.profileImage} />
            </Avatar>
            <div className="grid grid-cols-2 gap-4 flex-1">
              <div>
                <label className="text-sm text-gray-600">Full Name</label>
                <p className="font-semibold">{application?.name}</p>
              </div>
              <div>
                <label className="text-sm text-gray-600">Phone</label>
                <p className="font-semibold">{application?.phone}</p>
              </div>
              <div>
                <label className="text-sm text-gray-600">Email</label>
                <p className="font-semibold">{application?.email}</p>
              </div>
              <div>
                <label className="text-sm text-gray-600">City</label>
                <p className="font-semibold">{application?.city}</p>
              </div>
              <div>
                <label className="text-sm text-gray-600">Services Offered</label>
                <p className="font-semibold">{application?.services.join(', ')}</p>
              </div>
              <div>
                <label className="text-sm text-gray-600">Experience</label>
                <p className="font-semibold">{application?.yearsOfExperience} years</p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Document Verification */}
      <Card className="mb-6">
        <CardHeader>
          <h3>Document Verification</h3>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {/* Aadhar Front */}
            <DocumentVerificationCard
              title="Aadhar Card (Front)"
              imageUrl={application?.documents.aadharFront}
              status={documentStatus.aadharFront}
              onVerify={() => handleDocumentVerification('aadharFront', 'verified')}
              onReject={() => handleDocumentVerification('aadharFront', 'rejected')}
            />

            {/* Aadhar Back */}
            <DocumentVerificationCard
              title="Aadhar Card (Back)"
              imageUrl={application?.documents.aadharBack}
              status={documentStatus.aadharBack}
              onVerify={() => handleDocumentVerification('aadharBack', 'verified')}
              onReject={() => handleDocumentVerification('aadharBack', 'rejected')}
            />

            {/* PAN Card */}
            <DocumentVerificationCard
              title="PAN Card"
              imageUrl={application?.documents.pan}
              status={documentStatus.pan}
              onVerify={() => handleDocumentVerification('pan', 'verified')}
              onReject={() => handleDocumentVerification('pan', 'rejected')}
            />

            {/* Certificates */}
            {application?.documents.certificates.map((cert, index) => (
              <DocumentVerificationCard
                key={index}
                title={`Certificate ${index + 1}`}
                imageUrl={cert}
                status={documentStatus.certificates}
                onVerify={() => handleDocumentVerification('certificates', 'verified')}
                onReject={() => handleDocumentVerification('certificates', 'rejected')}
              />
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Bank Details */}
      <Card className="mb-6">
        <CardHeader>
          <h3>Bank Account Details</h3>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label>Account Holder Name</label>
              <p className="font-semibold">{application?.bankDetails.accountHolderName}</p>
            </div>
            <div>
              <label>Account Number</label>
              <p className="font-semibold">
                ************{application?.bankDetails.accountNumber.slice(-4)}
              </p>
            </div>
            <div>
              <label>IFSC Code</label>
              <p className="font-semibold">{application?.bankDetails.ifscCode}</p>
            </div>
            <div>
              <label>Bank Name</label>
              <p className="font-semibold">{application?.bankDetails.bankName}</p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Admin Notes */}
      <Card className="mb-6">
        <CardHeader>
          <h3>Admin Notes (Internal)</h3>
        </CardHeader>
        <CardContent>
          <Textarea
            placeholder="Add any internal notes about this application..."
            value={adminNotes}
            onChange={(e) => setAdminNotes(e.target.value)}
            rows={4}
          />
        </CardContent>
      </Card>

      {/* Action Buttons */}
      <div className="flex gap-4">
        <Button
          size="lg"
          variant="default"
          onClick={handleApprove}
          className="bg-green-600 hover:bg-green-700"
        >
          <CheckCircle className="mr-2" />
          Approve Application
        </Button>

        <Button
          size="lg"
          variant="destructive"
          onClick={handleReject}
        >
          <XCircle className="mr-2" />
          Reject Application
        </Button>

        <Button
          size="lg"
          variant="outline"
          onClick={handleRequestMoreInfo}
        >
          <Info className="mr-2" />
          Request More Information
        </Button>
      </div>
    </div>
  );
}
```

**Document Verification Component:**

```typescript
// components/admin/DocumentVerificationCard.tsx
interface DocumentVerificationCardProps {
  title: string;
  imageUrl: string;
  status: 'pending' | 'verified' | 'rejected';
  onVerify: () => void;
  onReject: () => void;
}

export function DocumentVerificationCard({
  title,
  imageUrl,
  status,
  onVerify,
  onReject,
}: DocumentVerificationCardProps) {
  const [showFullImage, setShowFullImage] = useState(false);

  return (
    <div className="border rounded-lg p-4">
      <h4 className="font-semibold mb-2">{title}</h4>

      {/* Document Image */}
      <div
        className="relative aspect-[3/2] bg-gray-100 rounded-md overflow-hidden cursor-pointer mb-3"
        onClick={() => setShowFullImage(true)}
      >
        <img
          src={imageUrl}
          alt={title}
          className="w-full h-full object-cover"
        />
        <div className="absolute bottom-2 right-2 bg-black/50 text-white text-xs px-2 py-1 rounded">
          Click to zoom
        </div>
      </div>

      {/* Status Badge */}
      <div className="mb-3">
        {status === 'pending' && (
          <Badge variant="secondary">Pending Review</Badge>
        )}
        {status === 'verified' && (
          <Badge variant="success" className="bg-green-600">
            <CheckCircle className="w-3 h-3 mr-1" />
            Verified
          </Badge>
        )}
        {status === 'rejected' && (
          <Badge variant="destructive">
            <XCircle className="w-3 h-3 mr-1" />
            Rejected
          </Badge>
        )}
      </div>

      {/* Action Buttons */}
      {status === 'pending' && (
        <div className="flex gap-2">
          <Button
            size="sm"
            variant="outline"
            className="flex-1 border-green-600 text-green-600 hover:bg-green-50"
            onClick={onVerify}
          >
            <Check className="w-4 h-4 mr-1" />
            Verify
          </Button>
          <Button
            size="sm"
            variant="outline"
            className="flex-1 border-red-600 text-red-600 hover:bg-red-50"
            onClick={onReject}
          >
            <X className="w-4 h-4 mr-1" />
            Reject
          </Button>
        </div>
      )}

      {/* Full Image Modal */}
      {showFullImage && (
        <Dialog open={showFullImage} onOpenChange={setShowFullImage}>
          <DialogContent className="max-w-4xl">
            <img src={imageUrl} alt={title} className="w-full" />
          </DialogContent>
        </Dialog>
      )}
    </div>
  );
}
```

#### Step 3: Post-Approval Actions

**After Approval:**

1. **Update Provider Status:**
   ```typescript
   await updateDoc(doc(db, 'users', providerId), {
     kycStatus: 'approved',
     status: 'active',
     approvedAt: serverTimestamp(),
     approvedBy: adminId,
   });
   ```

2. **Send Welcome Email:**
   ```typescript
   await sendEmail({
     to: provider.email,
     subject: 'Welcome to UrbanNest - Your Application is Approved!',
     template: 'provider_approval',
     data: {
       providerName: provider.name,
       loginUrl: 'https://urbannest.in/provider/login',
       nextSteps: [
         'Download the Provider App',
         'Set your availability',
         'Complete your profile',
         'Start accepting bookings'
       ],
     },
   });
   ```

3. **Send SMS Notification:**
   ```typescript
   await sendSMS({
     phone: provider.phone,
     message: `Congratulations ${provider.name}! Your UrbanNest provider account is approved. Download the app and start earning today!`,
   });
   ```

4. **Create Audit Log:**
   ```typescript
   await addDoc(collection(db, 'audit_logs'), {
     action: 'PROVIDER_APPROVED',
     performedBy: adminId,
     targetId: providerId,
     timestamp: serverTimestamp(),
     details: {
       adminNotes,
       documentsVerified,
     },
   });
   ```

### 5.2 Active Providers Management

**Page:** `/admin/providers/active`

**Features:**
- Search providers by name, phone, or service
- Filter by city, service type, rating
- Sort by rating, earnings, completion rate
- Bulk actions (export, notify)

**Provider List:**

```typescript
// components/admin/ProviderTable.tsx
export function ProviderTable({ providers }: { providers: Provider[] }) {
  return (
    <DataTable
      columns={[
        {
          accessorKey: 'name',
          header: 'Provider',
          cell: ({ row }) => (
            <div className="flex items-center gap-2">
              <Avatar>
                <AvatarImage src={row.original.profileImage} />
              </Avatar>
              <div>
                <p className="font-semibold">{row.original.name}</p>
                <p className="text-sm text-gray-600">{row.original.phone}</p>
              </div>
            </div>
          ),
        },
        {
          accessorKey: 'services',
          header: 'Services',
          cell: ({ row }) => row.original.services.join(', '),
        },
        {
          accessorKey: 'city',
          header: 'City',
        },
        {
          accessorKey: 'rating',
          header: 'Rating',
          cell: ({ row }) => (
            <div className="flex items-center">
              <Star className="w-4 h-4 text-yellow-400 fill-yellow-400 mr-1" />
              {row.original.rating.toFixed(1)} ({row.original.totalRatings})
            </div>
          ),
        },
        {
          accessorKey: 'completedBookings',
          header: 'Completed',
        },
        {
          accessorKey: 'totalEarnings',
          header: 'Earnings',
          cell: ({ row }) => `₹${row.original.totalEarnings.toLocaleString()}`,
        },
        {
          accessorKey: 'status',
          header: 'Status',
          cell: ({ row }) => (
            <Badge variant={row.original.isAvailable ? 'success' : 'secondary'}>
              {row.original.isAvailable ? 'Available' : 'Unavailable'}
            </Badge>
          ),
        },
        {
          id: 'actions',
          cell: ({ row }) => (
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="sm">
                  <MoreVertical className="w-4 h-4" />
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem onClick={() => router.push(`/admin/providers/${row.original.id}`)}>
                  View Details
                </DropdownMenuItem>
                <DropdownMenuItem>Send Message</DropdownMenuItem>
                <DropdownMenuItem>View Earnings</DropdownMenuItem>
                <DropdownMenuSeparator />
                <DropdownMenuItem className="text-red-600">
                  Suspend Provider
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          ),
        },
      ]}
      data={providers}
    />
  );
}
```

**Provider Detail Page:** `/admin/providers/[id]`

Shows complete provider information:
- Personal details
- KYC documents (verified)
- Services offered
- Availability calendar
- Performance metrics (rating, completion rate, on-time %)
- Earnings history
- Recent bookings
- Customer reviews
- Actions (suspend, edit, send notification)

---

## 6. Customer Management

**Page:** `/admin/customers`

**Features:**
- Customer list with search and filters
- View customer profile and booking history
- Handle customer complaints
- Account suspension/reactivation
- Wallet adjustments (add/deduct credits)
- Export customer data

**Customer Detail Page:**

```typescript
// app/admin/customers/[id]/page.tsx
export default function CustomerDetailPage({ params }) {
  const [customer, setCustomer] = useState<Customer | null>(null);

  return (
    <div className="p-6">
      {/* Customer Info Card */}
      <Card className="mb-6">
        <CardHeader>
          <h2>{customer?.name}</h2>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div>
              <label>Phone</label>
              <p>{customer?.phone}</p>
            </div>
            <div>
              <label>Email</label>
              <p>{customer?.email}</p>
            </div>
            <div>
              <label>City</label>
              <p>{customer?.city}</p>
            </div>
            <div>
              <label>Member Since</label>
              <p>{formatDate(customer?.createdAt)}</p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Booking Statistics */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <StatsCard title="Total Bookings" value={customer?.totalBookings} />
        <StatsCard title="Completed" value={customer?.completedBookings} />
        <StatsCard title="Cancelled" value={customer?.cancelledBookings} />
        <StatsCard title="Wallet Balance" value={`₹${customer?.walletBalance}`} />
      </div>

      {/* Booking History */}
      <Card>
        <CardHeader>
          <h3>Booking History</h3>
        </CardHeader>
        <CardContent>
          <BookingTable bookings={customer?.bookings} />
        </CardContent>
      </Card>

      {/* Actions */}
      <div className="mt-6 flex gap-4">
        <Button variant="outline">Send Notification</Button>
        <Button variant="outline">Adjust Wallet</Button>
        <Button variant="destructive">Suspend Account</Button>
      </div>
    </div>
  );
}
```

---

## 7. Service Catalog Management

### 7.1 Service List (`/admin/services`)

**Features:**
- Grid/List view toggle
- Search services
- Filter by category, city, active status
- Sort by popularity, price, name
- Bulk actions (activate/deactivate, export)

### 7.2 Add New Service (`/admin/services/new`)

**Form Fields:**

```typescript
// app/admin/services/new/page.tsx
export default function AddServicePage() {
  const [formData, setFormData] = useState({
    name: '',
    categoryId: '',
    description: '',
    basePrice: 0,
    priceUnit: 'fixed',
    estimatedDuration: 60,
    whatIncluded: [''],
    whatNotIncluded: [''],
    requirements: [''],
    images: [],
    videoUrl: '',
    cities: [],
    isActive: true,
  });

  const handleSubmit = async () => {
    try {
      // Upload images to Firebase Storage
      const imageUrls = await uploadImages(formData.images);

      // Create service document
      await apiClient.post('/admin/services', {
        ...formData,
        imageUrl: imageUrls[0],
        gallery: imageUrls,
        createdAt: new Date(),
        createdBy: adminId,
      });

      toast.success('Service created successfully!');
      router.push('/admin/services');
    } catch (error) {
      toast.error('Failed to create service');
    }
  };

  return (
    <form onSubmit={handleSubmit} className="p-6 max-w-4xl mx-auto">
      <Card>
        <CardHeader>
          <h2>Add New Service</h2>
        </CardHeader>
        <CardContent className="space-y-6">
          {/* Basic Information */}
          <div>
            <Label>Service Name</Label>
            <Input
              value={formData.name}
              onChange={(e) => setFormData({ ...formData, name: e.target.value })}
              placeholder="e.g., AC Repair & Servicing"
            />
          </div>

          <div>
            <Label>Category</Label>
            <Select
              value={formData.categoryId}
              onValueChange={(value) => setFormData({ ...formData, categoryId: value })}
            >
              <SelectTrigger>
                <SelectValue placeholder="Select category" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="home_cleaning">Home Cleaning</SelectItem>
                <SelectItem value="appliance_repair">Appliance Repair</SelectItem>
                <SelectItem value="plumbing">Plumbing</SelectItem>
                {/* More categories */}
              </SelectContent>
            </Select>
          </div>

          <div>
            <Label>Description</Label>
            <Textarea
              value={formData.description}
              onChange={(e) => setFormData({ ...formData, description: e.target.value })}
              rows={5}
              placeholder="Detailed service description..."
            />
          </div>

          {/* Pricing */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <Label>Base Price (₹)</Label>
              <Input
                type="number"
                value={formData.basePrice}
                onChange={(e) => setFormData({ ...formData, basePrice: parseFloat(e.target.value) })}
              />
            </div>
            <div>
              <Label>Duration (minutes)</Label>
              <Input
                type="number"
                value={formData.estimatedDuration}
                onChange={(e) => setFormData({ ...formData, estimatedDuration: parseInt(e.target.value) })}
              />
            </div>
          </div>

          {/* What's Included */}
          <div>
            <Label>What's Included</Label>
            {formData.whatIncluded.map((item, index) => (
              <div key={index} className="flex gap-2 mb-2">
                <Input
                  value={item}
                  onChange={(e) => {
                    const updated = [...formData.whatIncluded];
                    updated[index] = e.target.value;
                    setFormData({ ...formData, whatIncluded: updated });
                  }}
                  placeholder="e.g., Gas leak check"
                />
                <Button
                  type="button"
                  variant="outline"
                  size="icon"
                  onClick={() => {
                    const updated = formData.whatIncluded.filter((_, i) => i !== index);
                    setFormData({ ...formData, whatIncluded: updated });
                  }}
                >
                  <X />
                </Button>
              </div>
            ))}
            <Button
              type="button"
              variant="outline"
              onClick={() => setFormData({ ...formData, whatIncluded: [...formData.whatIncluded, ''] })}
            >
              Add Item
            </Button>
          </div>

          {/* Image Upload */}
          <div>
            <Label>Service Images</Label>
            <ImageUpload
              onUpload={(files) => setFormData({ ...formData, images: files })}
              maxFiles={5}
            />
          </div>

          {/* City Availability */}
          <div>
            <Label>Available in Cities</Label>
            <MultiSelect
              options={cities}
              value={formData.cities}
              onChange={(cities) => setFormData({ ...formData, cities })}
            />
          </div>

          {/* Active Status */}
          <div className="flex items-center space-x-2">
            <Switch
              checked={formData.isActive}
              onCheckedChange={(checked) => setFormData({ ...formData, isActive: checked })}
            />
            <Label>Publish service (make it visible to customers)</Label>
          </div>

          <div className="flex gap-4">
            <Button type="submit" size="lg">
              Create Service
            </Button>
            <Button type="button" variant="outline" onClick={() => router.back()}>
              Cancel
            </Button>
          </div>
        </CardContent>
      </Card>
    </form>
  );
}
```

---

## 8. Booking Oversight

**Page:** `/admin/bookings`

**Real-time Booking Dashboard:**

```typescript
// app/admin/bookings/page.tsx
export default function BookingsPage() {
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [filters, setFilters] = useState({
    status: 'all',
    city: 'all',
    dateRange: 'today',
    serviceType: 'all',
  });

  // Real-time subscription
  useEffect(() => {
    const unsubscribe = onSnapshot(
      query(
        collection(db, 'bookings'),
        where('status', '!=', 'cancelled'),
        orderBy('createdAt', 'desc'),
        limit(100)
      ),
      (snapshot) => {
        const bookingsData = snapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }));
        setBookings(bookingsData);
      }
    );

    return () => unsubscribe();
  }, []);

  return (
    <div className="p-6">
      {/* Filters */}
      <Card className="mb-6">
        <CardContent className="pt-6">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <Select value={filters.status} onValueChange={(v) => setFilters({ ...filters, status: v })}>
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">All Status</SelectItem>
                <SelectItem value="requested">Requested</SelectItem>
                <SelectItem value="in_progress">In Progress</SelectItem>
                <SelectItem value="completed">Completed</SelectItem>
              </SelectContent>
            </Select>

            <Select value={filters.city} onValueChange={(v) => setFilters({ ...filters, city: v })}>
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">All Cities</SelectItem>
                <SelectItem value="delhi">Delhi NCR</SelectItem>
                <SelectItem value="bangalore">Bangalore</SelectItem>
              </SelectContent>
            </Select>

            <Select value={filters.dateRange} onValueChange={(v) => setFilters({ ...filters, dateRange: v })}>
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="today">Today</SelectItem>
                <SelectItem value="week">This Week</SelectItem>
                <SelectItem value="month">This Month</SelectItem>
              </SelectContent>
            </Select>

            <Button onClick={() => setFilters({ status: 'all', city: 'all', dateRange: 'today', serviceType: 'all' })}>
              Reset Filters
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Bookings Table */}
      <Card>
        <CardHeader>
          <h3>All Bookings ({bookings.length})</h3>
        </CardHeader>
        <CardContent>
          <BookingsAdminTable
            bookings={bookings}
            onViewDetails={(id) => router.push(`/admin/bookings/${id}`)}
            onReassignProvider={(id) => handleReassignProvider(id)}
            onCancelBooking={(id) => handleCancelBooking(id)}
          />
        </CardContent>
      </Card>
    </div>
  );
}
```

**Booking Detail Page:** `/admin/bookings/[id]`

Shows full booking details with admin actions:
- View complete timeline
- Reassign provider
- Cancel booking
- Issue refund
- Contact customer/provider
- View evidence (photos, notes)

---

## 9. Pricing Configuration

**Page:** `/admin/pricing`

**Features:**
- Base price management per service
- City-specific multipliers
- Surge pricing rules
- Seasonal pricing
- Promo code management
- Tax configuration (GST)

---

## 10. City & Zone Management

**Page:** `/admin/cities`

**Add New City:**
- City name
- State/Country
- Operational hours
- Available services
- Pricing multiplier
- Define zones (draw on map)

---

## 11. Analytics & Reporting

**Page:** `/admin/analytics`

**Dashboards:**
- Revenue analytics
- Booking trends
- Provider performance
- Customer acquisition
- Service popularity
- Geographic distribution
- Export reports (CSV, PDF)

---

## 12. Dispute Resolution

**Process:**
1. Dispute raised
2. Admin reviews details
3. Contact both parties
4. Make decision
5. Execute resolution

---

## 13. Refund Processing

**Workflow:**
1. View refund request
2. Check eligibility
3. Approve/Reject/Partial
4. Process refund
5. Update status

---

## 14. Notifications & Alerts

- In-app notifications
- Email alerts
- SMS notifications
- Real-time dashboard alerts

---

## 15. Settings & Configuration

- Admin user management
- Platform settings
- Feature flags
- Maintenance mode

---

## 16. Audit Logs

Track all admin actions:
- User
- Action
- Timestamp
- Details
- Export logs

---

## Document Metadata

**Created**: December 2025
**Platform**: CityServe / UrbanNest
**Application**: Admin Dashboard (Next.js)
**Version**: 1.0
**Last Updated**: December 30, 2025
