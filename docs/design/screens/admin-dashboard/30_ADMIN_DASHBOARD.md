# Admin Dashboard Home

## Overview
- **Screen ID**: 30
- **Screen Name**: Admin Dashboard Home
- **User Role**: Admin, Super Admin
- **Platform**: Web (Desktop)
- **Navigation**: Default landing page after admin login

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  UrbanNest Admin                                    🔍 Search...        👤 Admin  🔔   │
├──────────────┬─────────────────────────────────────────────────────────────────────────┤
│              │                                                                          │
│  📊 Dashboard│  Dashboard Overview                                    📅 Dec 20, 2024 │
│  ────────────│                                                                          │
│  👥 Providers│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐  │
│  📋 Bookings │  │ 📈 Revenue   │ │ 📅 Bookings  │ │ 👤 Customers │ │ 🔧 Providers │  │
│  👨 Customers│  │              │ │              │ │              │ │              │  │
│  🔧 Services │  │  ₹1,24,500   │ │     248      │ │    1,245     │ │     186      │  │
│  💰 Payments │  │  +12% ↑     │ │  +8% ↑      │ │  +15% ↑     │ │  +5% ↑      │  │
│  📊 Analytics│  │              │ │              │ │              │ │              │  │
│  ⚙️ Settings │  │  This month  │ │    Today     │ │    Active    │ │   Active     │  │
│              │  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘  │
│              │                                                                          │
│              │  📋 Recent Activity                          [View All]                 │
│              │  ┌────────────────────────────────────────────────────────────────────┐│
│              │  │ Type         │ Details                      │ Time       │ Status  ││
│              │  ├────────────────────────────────────────────────────────────────────┤│
│              │  │ 🔧 Booking   │ AC Repair - Amit Kumar       │ 2 min ago  │ ✅ Done ││
│              │  │ 👤 Provider  │ New registration - Rajesh    │ 15 min ago │ ⏳ Pending││
│              │  │ 💰 Payment   │ Payout to Priya Sharma       │ 1 hour ago │ ✅ Paid ││
│              │  │ 🔧 Booking   │ Plumbing - Rahul Singh       │ 2 hour ago │ ⏳ Active││
│              │  │ 👤 Customer  │ New signup - Neha Verma      │ 3 hour ago │ ✅ Done ││
│              │  └────────────────────────────────────────────────────────────────────┘│
│              │                                                                          │
│              │  ┌───────────────────────────────┐  ┌──────────────────────────────┐   │
│              │  │ 📊 Booking Trends (Last 7 Days)│  │ ⚠️ Pending Actions          │   │
│              │  │                               │  │                              │   │
│              │  │      [Line Chart]             │  │ • 12 Provider approvals     │   │
│              │  │      Showing booking volume   │  │ • 5 Dispute resolutions     │   │
│              │  │      per day                  │  │ • 3 Refund requests         │   │
│              │  │                               │  │ • 8 Service verifications   │   │
│              │  │                               │  │                              │   │
│              │  │                               │  │ [Review All]                 │   │
│              │  └───────────────────────────────┘  └──────────────────────────────┘   │
│              │                                                                          │
│              │  ┌───────────────────────────────┐  ┌──────────────────────────────┐   │
│              │  │ 🌟 Top Performing Providers   │  │ 📍 Service Coverage Map      │   │
│              │  │                               │  │                              │   │
│              │  │ 1. Rajesh Kumar  ⭐ 4.9 (85) │  │   [Interactive Map]          │   │
│              │  │    ₹45,200 earned this month │  │                              │   │
│              │  │                               │  │   Showing provider density   │   │
│              │  │ 2. Priya Sharma  ⭐ 4.8 (72) │  │   across Delhi NCR           │   │
│              │  │    ₹38,900 earned this month │  │                              │   │
│              │  │                               │  │                              │   │
│              │  │ 3. Amit Patel    ⭐ 4.8 (68) │  │                              │   │
│              │  │    ₹36,500 earned this month │  │                              │   │
│              │  │                               │  │                              │   │
│              │  │ [View All Providers]          │  │                              │   │
│              │  └───────────────────────────────┘  └──────────────────────────────┘   │
│              │                                                                          │
└──────────────┴─────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Desktop Breakpoints
- **Large Desktop**: 1920x1080 (primary design)
- **Standard Desktop**: 1440x900
- **Laptop**: 1366x768 (minimum supported)

### Sidebar Navigation
- **Width**: 200px (collapsed: 60px)
- **Background**: #1E1E1E (dark) or #FFFFFF (light theme)
- **Active Item**: Deep Teal (#0D7377) background, white text
- **Hover**: Light gray background (#F5F5F5)
- **Icons**: 20x20px, Inter Medium 14px text

### Top Header Bar
- **Height**: 64px
- **Background**: White (#FFFFFF) with subtle shadow
- **Logo**: "UrbanNest Admin" Inter SemiBold 20px
- **Search Bar**: 300px width, 40px height, rounded 8px
- **User Profile**: Avatar 36x36px, name Inter Regular 14px
- **Notifications**: Bell icon with badge count

### Stat Cards (4 Cards)
- **Grid**: 4 columns (equal width)
- **Card Size**: Flexible width x 140px height
- **Border Radius**: 12px
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)
- **Padding**: 20px
- **Icon**: 32x32px top-left
- **Value**: Inter Bold 32px, #1E1E1E
- **Change**: Inter Medium 14px, Green (#28C76F) or Red (#EA5455)
- **Label**: Inter Regular 12px, #666666

### Recent Activity Table
- **Width**: Full container width
- **Row Height**: 56px
- **Header**: Inter SemiBold 14px, #666666
- **Cell Text**: Inter Regular 14px, #1E1E1E
- **Border**: 1px solid #E0E0E0
- **Hover**: Light gray background (#F9F9F9)
- **Status Badge**:
  - Done: Green (#28C76F) background, white text
  - Pending: Orange (#FFC107) background, dark text
  - Active: Blue (#00CFE8) background, white text

### Section Spacing
- **Container Padding**: 24px all sides
- **Card Margin**: 16px between cards
- **Section Margin**: 32px between major sections

## Components Used

### Stat Card
```jsx
const StatCard = ({ icon, value, change, label, trend }) => {
  return (
    <div className="stat-card">
      <div className="icon">{icon}</div>
      <h2 className="value">{value}</h2>
      <div className="change" data-trend={trend}>
        {change} {trend === 'up' ? '↑' : '↓'}
      </div>
      <p className="label">{label}</p>
    </div>
  );
};
```

### Activity Table Row
```jsx
const ActivityRow = ({ type, details, time, status }) => {
  return (
    <tr className="activity-row">
      <td>
        <span className="type-icon">{getIcon(type)}</span>
        {type}
      </td>
      <td>{details}</td>
      <td className="time">{time}</td>
      <td>
        <StatusBadge status={status} />
      </td>
    </tr>
  );
};
```

### Sidebar Navigation
```jsx
const AdminSidebar = ({ activePage }) => {
  const navItems = [
    { icon: '📊', label: 'Dashboard', path: '/' },
    { icon: '👥', label: 'Providers', path: '/providers' },
    { icon: '📋', label: 'Bookings', path: '/bookings' },
    { icon: '👨', label: 'Customers', path: '/customers' },
    { icon: '🔧', label: 'Services', path: '/services' },
    { icon: '💰', label: 'Payments', path: '/payments' },
    { icon: '📊', label: 'Analytics', path: '/analytics' },
    { icon: '⚙️', label: 'Settings', path: '/settings' },
  ];

  return (
    <aside className="admin-sidebar">
      {navItems.map(item => (
        <NavItem
          key={item.path}
          {...item}
          isActive={activePage === item.path}
        />
      ))}
    </aside>
  );
};
```

## Key Features

### Real-time Stats
- Auto-refresh every 30 seconds
- WebSocket connection for instant updates
- Trend indicators (percentage change)
- Comparison periods (day/week/month)

### Activity Feed
- Last 10 activities displayed
- Real-time updates via Firebase Firestore listener
- Filter by activity type
- Click row to view details

### Pending Actions Panel
- High-priority tasks requiring attention
- Color-coded by urgency
- Direct links to action pages
- Badge counts auto-update

### Charts & Analytics
- **Booking Trends**: Line chart showing 7-day booking volume
- **Service Coverage Map**: Interactive map with provider distribution
- **Top Performers**: Ranked list of highest-earning providers
- Chart library: Recharts or Chart.js

## Interactions

### Stat Card Click
- Navigate to detailed view
- Example: Click "Bookings" → Navigate to Bookings Dashboard

### Activity Row Click
- Open modal with full activity details
- Actions available (approve, reject, view more)

### Pending Actions Click
- Navigate to specific management page
- Example: "12 Provider approvals" → Provider Approvals List

### Search Bar
- Global search across all entities
- Auto-suggestions dropdown
- Search scope: Bookings, Providers, Customers, Services
- Keyboard shortcut: Cmd/Ctrl + K

### Notification Bell
- Show notification dropdown
- Unread count badge
- Mark as read functionality
- Navigate to notification detail

## Data Loading

### Initial Load
```javascript
const AdminDashboard = () => {
  const [stats, setStats] = useState(null);
  const [activities, setActivities] = useState([]);
  const [pendingActions, setPendingActions] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadDashboardData();

    // Real-time activity updates
    const unsubscribe = firestore
      .collection('activities')
      .orderBy('timestamp', 'desc')
      .limit(10)
      .onSnapshot(snapshot => {
        const newActivities = snapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }));
        setActivities(newActivities);
      });

    return () => unsubscribe();
  }, []);

  const loadDashboardData = async () => {
    try {
      const [statsData, pendingData] = await Promise.all([
        fetchDashboardStats(),
        fetchPendingActions()
      ]);
      setStats(statsData);
      setPendingActions(pendingData);
    } catch (error) {
      showErrorToast('Failed to load dashboard');
    } finally {
      setLoading(false);
    }
  };
};
```

### Auto-refresh Stats
- Refresh interval: 30 seconds
- Only when tab is active (Page Visibility API)
- Debounce rapid refreshes

## Permissions

### Admin Roles
- **Super Admin**: Full access to all features
- **Admin**: View and manage bookings, providers, customers
- **Finance Admin**: Access to payments and analytics only
- **Support Admin**: View-only access, can update booking status

### Feature Access Matrix
| Feature | Super Admin | Admin | Finance | Support |
|---------|-------------|-------|---------|---------|
| View Dashboard | ✅ | ✅ | ✅ | ✅ |
| Manage Providers | ✅ | ✅ | ❌ | ❌ |
| Manage Bookings | ✅ | ✅ | ❌ | ✅ |
| Manage Services | ✅ | ✅ | ❌ | ❌ |
| View Payments | ✅ | ✅ | ✅ | ❌ |
| Process Refunds | ✅ | ❌ | ✅ | ❌ |
| System Settings | ✅ | ❌ | ❌ | ❌ |

## States

### Loading State
- Skeleton loaders for stat cards
- Shimmer effect on tables
- Spinner for charts

### Error State
- Error message with retry button
- Fallback to cached data if available
- Toast notification for errors

### Empty State
- No activities: "No recent activity"
- No pending actions: "All caught up! 🎉"
- No providers: "No providers yet"

## Dark Mode

### Color Adjustments
- Background: #121212
- Surface (cards): #1E1E1E
- Text Primary: #E0E0E0
- Text Secondary: #A0A0A0
- Border: #2A2A2A
- Sidebar: #1A1A1A

## Accessibility

### Keyboard Navigation
- Tab through all interactive elements
- Enter to activate buttons/links
- Esc to close modals
- Arrow keys for table navigation

### Screen Reader
- Proper heading hierarchy (h1, h2, h3)
- ARIA labels for icon buttons
- Table headers properly associated
- Live regions for real-time updates

### Focus Management
- Visible focus indicators
- Focus trap in modals
- Skip to main content link

## Analytics Tracking

- `admin_dashboard_viewed`: Dashboard loaded
- `stat_card_clicked`: Which stat card clicked
- `activity_row_clicked`: Activity type clicked
- `pending_action_clicked`: Action type clicked
- `chart_interaction`: Chart filters/interactions
- `search_used`: Global search performed
- `notification_opened`: Notification panel opened

## API Endpoints

### GET /api/admin/dashboard/stats
```json
{
  "revenue": {
    "value": 124500,
    "change": 12,
    "trend": "up",
    "period": "month"
  },
  "bookings": {
    "value": 248,
    "change": 8,
    "trend": "up",
    "period": "today"
  },
  "customers": {
    "value": 1245,
    "change": 15,
    "trend": "up",
    "period": "active"
  },
  "providers": {
    "value": 186,
    "change": 5,
    "trend": "up",
    "period": "active"
  }
}
```

### GET /api/admin/activities?limit=10
```json
{
  "activities": [
    {
      "id": "act_123",
      "type": "booking",
      "icon": "🔧",
      "details": "AC Repair - Amit Kumar",
      "timestamp": "2024-12-20T14:32:00Z",
      "status": "completed"
    }
  ]
}
```

### GET /api/admin/pending-actions
```json
{
  "providerApprovals": 12,
  "disputes": 5,
  "refunds": 3,
  "serviceVerifications": 8
}
```

## Testing Checklist

- ✅ All stat cards display correct data
- ✅ Real-time activity updates work
- ✅ Charts render properly
- ✅ Sidebar navigation works
- ✅ Search functionality works
- ✅ Notifications panel works
- ✅ Responsive on different screen sizes
- ✅ Dark mode toggle works
- ✅ Loading states show correctly
- ✅ Error handling works
- ✅ Permissions enforced correctly
- ✅ Keyboard navigation works
- ✅ Screen reader compatible

## Implementation Notes

### Tech Stack
- **Framework**: Next.js 14 (App Router)
- **UI Library**: React with TypeScript
- **Styling**: Tailwind CSS
- **Charts**: Recharts
- **Maps**: Google Maps JavaScript API
- **State Management**: React Context + hooks
- **Real-time**: Firebase Firestore listeners
- **Authentication**: Firebase Admin SDK

### Performance Optimizations
- Server-side rendering for initial load
- Client-side data fetching for real-time updates
- Lazy load charts (only when visible)
- Memoize expensive calculations
- Virtual scrolling for long activity lists
- Image optimization with Next.js Image component

### Security
- Role-based access control (RBAC)
- JWT token validation on every API call
- CSRF protection
- XSS prevention (sanitize inputs)
- SQL injection prevention (parameterized queries)
- Rate limiting on API endpoints

## Navigation Flow

**Entry Point:**
- Admin login → Admin Dashboard Home

**Exit Points:**
- Click stat card → Respective detail page
- Click sidebar item → Navigate to section
- Click activity row → Activity detail modal
- Click pending action → Management page
- Click top performer → Provider detail page
- Click search result → Entity detail page
