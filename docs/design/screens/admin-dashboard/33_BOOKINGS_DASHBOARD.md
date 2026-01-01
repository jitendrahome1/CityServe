# All Bookings Dashboard

## Overview
- **Screen ID**: 33
- **Screen Name**: All Bookings Dashboard
- **User Role**: Admin, Super Admin, Support Admin
- **Platform**: Web (Desktop)
- **Navigation**: From Dashboard → Bookings, Sidebar → Bookings

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  UrbanNest Admin                                    🔍 Search...        👤 Admin  🔔   │
├──────────────┬─────────────────────────────────────────────────────────────────────────┤
│              │                                                                          │
│  📊 Dashboard│  All Bookings                                 [Filters ▼] [Export CSV] │
│  👥 Providers│  ┌──────────────────────────────────────────────────────────────────┐   │
│  📋 Bookings │  │ All (1,245) │ Active (48) │ Completed (980) │ Cancelled (217)  │   │
│  ──────────  │  └──────────────────────────────────────────────────────────────────┘   │
│  👨 Customers│   (All selected)                                                        │
│  🔧 Services │                                                                          │
│  💰 Payments │  📊 Quick Stats                                                         │
│  📊 Analytics│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐      │
│  ⚙️ Settings │  │ 💰 Revenue  │ │ ✅ Success  │ │ ⏱️ Avg Time │ │ ⭐ Avg Rating│      │
│              │  │             │ │             │ │             │ │             │      │
│              │  │ ₹1,24,500   │ │   94.2%     │ │  2.5 hrs    │ │    4.6      │      │
│              │  │ This month  │ │ +2.1% ↑    │ │ -0.3 hrs ↓ │ │  +0.2 ↑    │      │
│              │  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘      │
│              │                                                                          │
│              │  🔍 [Search by ID, customer, provider, service...            ]  [Search]│
│              │                                                                          │
│              │  Filters: 📅 Today • 🏙️ All Cities • 🔧 All Services         [Clear]   │
│              │                                                                          │
│              │  ┌──┬──────────────┬──────────────┬──────────────┬──────────┬────────┐ │
│              │  │☑│ Booking      │ Customer     │ Provider     │ Status   │ Actions│ │
│              │  ├──┼──────────────┼──────────────┼──────────────┼──────────┼────────┤ │
│              │  │☐│ #BK789012    │ Amit Kumar   │ Rajesh K.    │ 🟢 Active│ [View] │ │
│              │  │ │ AC Repair    │ Delhi        │ ⭐ 4.8       │ In Prog  │        │ │
│              │  │ │ ₹650         │ 2:00-3:30 PM │ +91 987654.. │ Started  │        │ │
│              │  │ │ Dec 20, 2024 │              │              │ 45m ago  │        │ │
│              │  ├──┼──────────────┼──────────────┼──────────────┼──────────┼────────┤ │
│              │  │☐│ #BK789011    │ Priya Sharma │ Amit P.      │ 🔵 Sched.│ [View] │ │
│              │  │ │ Plumbing     │ Mumbai       │ ⭐ 4.6       │ 5:00 PM  │        │ │
│              │  │ │ ₹450         │ 5:00-6:00 PM │ +91 987653.. │ In 2 hrs │        │ │
│              │  │ │ Dec 20, 2024 │              │              │          │        │ │
│              │  ├──┼──────────────┼──────────────┼──────────────┼──────────┼────────┤ │
│              │  │☐│ #BK789010    │ Rahul Singh  │ Neha V.      │ ✅ Done  │ [View] │ │
│              │  │ │ Electrical   │ Bangalore    │ ⭐ 4.9       │ Completed│        │ │
│              │  │ │ ₹550         │ Completed    │ +91 987652.. │ ⭐ 5.0   │        │ │
│              │  │ │ Dec 20, 2024 │ 11:30 AM     │              │          │        │ │
│              │  ├──┼──────────────┼──────────────┼──────────────┼──────────┼────────┤ │
│              │  │☐│ #BK789009    │ Neha Verma   │ Rajesh K.    │ ❌ Cancel│ [View] │ │
│              │  │ │ Painting     │ Delhi        │ ⭐ 4.8       │ Cust.    │        │ │
│              │  │ │ ₹1,999       │ Cancelled    │ +91 987654.. │ Refund   │        │ │
│              │  │ │ Dec 19, 2024 │ 3:00 PM      │              │ Processed│        │ │
│              │  ├──┼──────────────┼──────────────┼──────────────┼──────────┼────────┤ │
│              │  │☐│ #BK789008    │ Sanjay Gupta │ Priya S.     │ ⚠️ Issue │ [View] │ │
│              │  │ │ AC Repair    │ Delhi        │ ⭐ 4.7       │ Dispute  │ [Action│ │
│              │  │ │ ₹650         │ 2:00 PM      │ +91 987651.. │ Pending  │ Needed]│ │
│              │  │ │ Dec 19, 2024 │              │              │          │        │ │
│              │  └──┴──────────────┴──────────────┴──────────────┴──────────┴────────┘ │
│              │                                                                          │
│              │  Showing 1-20 of 1,245                        [◄] [1] [2] [3] ... [►]  │
│              │                                                                          │
│              │  Selected: 0                                                             │
│              │  ┌────────────────────────────────────────────────────────────────────┐ │
│              │  │ [Bulk Update Status]  [Bulk Export]  [Send Notification]          │ │
│              │  └────────────────────────────────────────────────────────────────────┘ │
│              │                                                                          │
└──────────────┴─────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Filter Tabs
- **Height**: 48px
- **Tab Style**: Same as provider approvals
- **Badge Count**: Real-time count from database
- **Active Tab**: Deep Teal background

### Quick Stats Cards
- **Grid**: 4 columns (equal width)
- **Card Height**: 120px
- **Icon**: 28x28px
- **Value**: Inter Bold 28px
- **Change Indicator**: Inter Medium 13px, colored arrows
- **Label**: Inter Regular 12px, #666666

### Search Bar
- **Width**: 60% of container
- **Height**: 44px
- **Border Radius**: 8px
- **Placeholder**: Inter Regular 14px, #999999
- **Search Button**: 44x44px, Deep Teal background

### Active Filters Display
- **Height**: 36px
- **Pills**: Rounded tags with X button
- **Clear All**: Link button on right

### Bookings Table
- **Row Height**: 88px (multi-line content)
- **Checkbox Column**: 48px width
- **Booking Column**: 200px width
- **Customer Column**: 180px width
- **Provider Column**: 180px width
- **Status Column**: 140px width
- **Actions Column**: 100px width
- **Borders**: 1px solid #E0E0E0
- **Hover**: Light gray background (#F9F9F9)

### Booking Cell Content
- **Booking ID**: Inter SemiBold 14px, monospace, #0D7377
- **Service Name**: Inter Medium 14px, #1E1E1E
- **Amount**: Inter SemiBold 16px, #1E1E1E
- **Date**: Inter Regular 13px, #666666

### Customer Cell Content
- **Name**: Inter Medium 14px, #1E1E1E
- **City**: Inter Regular 13px, #666666
- **Time Slot**: Inter Regular 13px, #666666

### Provider Cell Content
- **Name**: Inter Medium 14px, #1E1E1E
- **Rating**: Star icon + number
- **Phone**: Inter Regular 12px, monospace, #999999

### Status Badges
- **Height**: 28px
- **Border Radius**: 6px
- **Padding**: 6px 12px
- **Font**: Inter SemiBold 12px
- **Colors**:
  - Active (In Progress): Green (#28C76F) background, white text
  - Scheduled: Blue (#00CFE8) background, white text
  - Completed: Gray (#999999) background, white text
  - Cancelled: Red (#EA5455) background, white text
  - Issue/Dispute: Orange (#FFC107) background, dark text

### Actions Column
- **View Button**: 32px height, Inter Medium 13px
- **Action Needed**: Red button, pulsing animation

### Pagination
- **Height**: 48px
- **Button Size**: 36x36px
- **Current Page**: Deep Teal background
- **Ellipsis**: Gray text for "..."

## Components Used

### Booking Row
```jsx
const BookingRow = ({ booking, isSelected, onSelect, onView }) => {
  const statusConfig = {
    active: { color: '#28C76F', label: 'Active', icon: '🟢' },
    scheduled: { color: '#00CFE8', label: 'Scheduled', icon: '🔵' },
    completed: { color: '#999999', label: 'Completed', icon: '✅' },
    cancelled: { color: '#EA5455', label: 'Cancelled', icon: '❌' },
    dispute: { color: '#FFC107', label: 'Issue', icon: '⚠️' }
  };

  const status = statusConfig[booking.status];

  return (
    <tr className="booking-row">
      <td>
        <input
          type="checkbox"
          checked={isSelected}
          onChange={onSelect}
          aria-label={`Select booking ${booking.id}`}
        />
      </td>
      <td>
        <div className="booking-info">
          <p className="booking-id">#{booking.id}</p>
          <p className="service-name">{booking.service}</p>
          <p className="amount">₹{booking.amount}</p>
          <p className="date">{formatDate(booking.date)}</p>
        </div>
      </td>
      <td>
        <div className="customer-info">
          <p className="name">{booking.customer.name}</p>
          <p className="city">{booking.customer.city}</p>
          <p className="time">{booking.timeSlot}</p>
        </div>
      </td>
      <td>
        <div className="provider-info">
          <p className="name">{booking.provider.name}</p>
          <p className="rating">⭐ {booking.provider.rating}</p>
          <p className="phone">{booking.provider.phone}</p>
        </div>
      </td>
      <td>
        <StatusBadge
          icon={status.icon}
          label={status.label}
          sublabel={booking.statusDetail}
          color={status.color}
        />
      </td>
      <td>
        <button className="view-btn" onClick={() => onView(booking.id)}>
          View
        </button>
        {booking.needsAction && (
          <button className="action-btn pulse">
            Action Needed
          </button>
        )}
      </td>
    </tr>
  );
};
```

### Filter Modal
```jsx
const FilterModal = ({ onApply, onClose }) => {
  const [filters, setFilters] = useState({
    dateRange: 'today',
    city: 'all',
    service: 'all',
    status: 'all',
    minAmount: '',
    maxAmount: '',
    provider: '',
    customer: ''
  });

  return (
    <Modal title="Advanced Filters" onClose={onClose}>
      <div className="filter-grid">
        <div className="filter-group">
          <label>Date Range</label>
          <select
            value={filters.dateRange}
            onChange={e => setFilters({ ...filters, dateRange: e.target.value })}
          >
            <option value="today">Today</option>
            <option value="yesterday">Yesterday</option>
            <option value="last7days">Last 7 days</option>
            <option value="last30days">Last 30 days</option>
            <option value="thisMonth">This month</option>
            <option value="lastMonth">Last month</option>
            <option value="custom">Custom range</option>
          </select>
        </div>

        <div className="filter-group">
          <label>City</label>
          <select
            value={filters.city}
            onChange={e => setFilters({ ...filters, city: e.target.value })}
          >
            <option value="all">All Cities</option>
            <option value="delhi">Delhi</option>
            <option value="mumbai">Mumbai</option>
            <option value="bangalore">Bangalore</option>
          </select>
        </div>

        <div className="filter-group">
          <label>Service Type</label>
          <select
            value={filters.service}
            onChange={e => setFilters({ ...filters, service: e.target.value })}
          >
            <option value="all">All Services</option>
            <option value="ac-repair">AC Repair</option>
            <option value="plumbing">Plumbing</option>
            <option value="electrical">Electrical</option>
            {/* ... more services */}
          </select>
        </div>

        <div className="filter-group">
          <label>Status</label>
          <MultiSelect
            options={['Active', 'Scheduled', 'Completed', 'Cancelled']}
            value={filters.status}
            onChange={value => setFilters({ ...filters, status: value })}
          />
        </div>

        <div className="filter-group">
          <label>Amount Range</label>
          <div className="range-inputs">
            <input
              type="number"
              placeholder="Min ₹"
              value={filters.minAmount}
              onChange={e => setFilters({ ...filters, minAmount: e.target.value })}
            />
            <span>to</span>
            <input
              type="number"
              placeholder="Max ₹"
              value={filters.maxAmount}
              onChange={e => setFilters({ ...filters, maxAmount: e.target.value })}
            />
          </div>
        </div>
      </div>

      <div className="filter-actions">
        <button className="clear" onClick={() => setFilters({})}>
          Clear All
        </button>
        <button className="apply" onClick={() => onApply(filters)}>
          Apply Filters
        </button>
      </div>
    </Modal>
  );
};
```

### Quick Stats
```jsx
const QuickStats = ({ stats }) => {
  return (
    <div className="quick-stats">
      <StatCard
        icon="💰"
        label="Revenue"
        value={`₹${formatNumber(stats.revenue)}`}
        change={stats.revenueChange}
        period="This month"
      />
      <StatCard
        icon="✅"
        label="Success Rate"
        value={`${stats.successRate}%`}
        change={stats.successRateChange}
        period={`${stats.totalBookings} bookings`}
      />
      <StatCard
        icon="⏱️"
        label="Avg Service Time"
        value={`${stats.avgTime} hrs`}
        change={stats.avgTimeChange}
        period="Per booking"
      />
      <StatCard
        icon="⭐"
        label="Avg Rating"
        value={stats.avgRating.toFixed(1)}
        change={stats.ratingChange}
        period={`${stats.totalRatings} reviews`}
      />
    </div>
  );
};
```

## Key Features

### Advanced Filtering
- **Date Range**: Predefined periods + custom date picker
- **City**: Multi-select cities
- **Service Type**: Multi-select services
- **Status**: Multiple statuses
- **Amount Range**: Min/max price filter
- **Provider/Customer**: Search by name or ID
- **Payment Status**: Paid, pending, refunded
- **Rating**: Minimum rating filter

### Real-time Updates
```javascript
useEffect(() => {
  // Subscribe to booking updates
  const unsubscribe = firestore
    .collection('bookings')
    .where('updatedAt', '>', lastUpdate)
    .onSnapshot(snapshot => {
      snapshot.docChanges().forEach(change => {
        if (change.type === 'modified') {
          updateBookingInList(change.doc.id, change.doc.data());
          showToast(`Booking ${change.doc.id} updated`);
        }
      });
    });

  return () => unsubscribe();
}, [lastUpdate]);
```

### Search Functionality
- **Search Fields**: Booking ID, customer name, provider name, phone, service
- **Auto-suggest**: Show matching results as typing
- **Highlight**: Highlight matching text in results
- **Debounce**: 300ms delay before search

### Sorting Options
- **Date**: Newest/oldest first
- **Amount**: Highest/lowest first
- **Status**: Active, scheduled, completed, cancelled
- **Rating**: Highest/lowest first
- **City**: Alphabetical

### Bulk Operations
- **Update Status**: Change status for multiple bookings
- **Export**: Export selected bookings to CSV/Excel
- **Send Notification**: Bulk email/SMS to customers or providers
- **Assign Provider**: Reassign provider for multiple bookings

### Export Options
- **CSV**: Comma-separated values
- **Excel**: .xlsx format with formatting
- **PDF**: Formatted report
- **Columns**: Select which columns to export
- **Date Range**: Filter export by date

## Interactions

### Tab Filter Click
- Filter bookings by status
- Update table data
- Update quick stats
- Maintain search query

### Search Submit
- Query database
- Display results in table
- Highlight matching text
- Show result count

### Filter Button Click
- Open advanced filters modal
- Apply filters on submit
- Show active filters as pills
- Update table data

### Clear Filters
- Reset all filters
- Reload original data
- Remove filter pills

### Row Click (not on button)
- Quick preview modal
- Show booking summary
- Quick actions available

### View Button Click
- Navigate to Booking Detail screen (Screen 34)
- Pass booking ID
- Open in new tab with Cmd/Ctrl + Click

### Action Needed Button
- Open action modal
- Show required action (refund, reassign, resolve dispute)
- Quick action buttons

### Checkbox Selection
- Select individual booking
- Update bulk actions bar
- Enable bulk operations

### Bulk Update Status
- Open status update modal
- Select new status
- Confirmation dialog
- Update all selected bookings

### Export CSV
- Generate CSV with selected bookings or all
- Include filters in filename
- Auto-download
- Format: `bookings_YYYYMMDD_HHMMSS.csv`

### Send Notification
- Open notification modal
- Select recipients (customer/provider)
- Choose template or custom message
- Preview before sending
- Send via email + SMS

## States

### Loading State
- Skeleton rows (10 rows)
- Shimmer animation
- Disabled filters and buttons

### Empty State
- **No Bookings**: "No bookings found"
- **No Search Results**: "No bookings match your search"
- **No Filter Results**: "No bookings match your filters"
- Icon + message + "Clear filters" button

### Error State
- Error message: "Failed to load bookings"
- Retry button
- Contact support link

## Data Loading

```javascript
const AllBookingsPage = () => {
  const [bookings, setBookings] = useState([]);
  const [stats, setStats] = useState(null);
  const [filters, setFilters] = useState({});
  const [selectedIds, setSelectedIds] = useState(new Set());
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const pageSize = 20;

  useEffect(() => {
    loadBookings();
    loadStats();

    // Real-time updates
    const unsubscribe = subscribeToBookingUpdates();
    return () => unsubscribe();
  }, [filters, page]);

  const loadBookings = async () => {
    setLoading(true);
    try {
      const queryParams = new URLSearchParams({
        page,
        limit: pageSize,
        ...filters
      });

      const response = await fetch(`/api/admin/bookings?${queryParams}`);
      const data = await response.json();

      setBookings(data.bookings);
      setTotalPages(data.totalPages);
    } catch (error) {
      showErrorToast('Failed to load bookings');
    } finally {
      setLoading(false);
    }
  };

  const loadStats = async () => {
    try {
      const response = await fetch('/api/admin/bookings/stats');
      const data = await response.json();
      setStats(data);
    } catch (error) {
      console.error('Failed to load stats');
    }
  };

  const handleBulkExport = async (format = 'csv') => {
    try {
      const response = await fetch('/api/admin/bookings/export', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          bookingIds: Array.from(selectedIds),
          format,
          filters
        })
      });

      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `bookings_${Date.now()}.${format}`;
      a.click();
    } catch (error) {
      showErrorToast('Failed to export bookings');
    }
  };
};
```

## Analytics

- `bookings_dashboard_viewed`: Page loaded
- `booking_filter_applied`: Filters applied
- `booking_searched`: Search performed
- `booking_sorted`: Sorting changed
- `booking_viewed`: View button clicked
- `bulk_export_used`: Bulk export performed
- `bulk_status_updated`: Bulk status update
- `notification_sent`: Bulk notification sent

## API Endpoints

### GET /api/admin/bookings
```javascript
// Query params: page, limit, filters, search, sortBy
{
  "bookings": [
    {
      "id": "BK789012",
      "service": "AC Repair & Service",
      "amount": 650,
      "date": "2024-12-20",
      "timeSlot": "2:00 PM - 3:30 PM",
      "status": "active",
      "statusDetail": "In Progress - Started 45m ago",
      "customer": {
        "id": "CUST_123",
        "name": "Amit Kumar",
        "phone": "+919876543210",
        "city": "Delhi"
      },
      "provider": {
        "id": "PRV_456",
        "name": "Rajesh K.",
        "phone": "+919876543210",
        "rating": 4.8
      },
      "needsAction": false
    }
  ],
  "totalCount": 1245,
  "totalPages": 63,
  "currentPage": 1
}
```

### GET /api/admin/bookings/stats
```json
{
  "revenue": 124500,
  "revenueChange": 12,
  "successRate": 94.2,
  "successRateChange": 2.1,
  "avgTime": 2.5,
  "avgTimeChange": -0.3,
  "avgRating": 4.6,
  "ratingChange": 0.2,
  "totalBookings": 1245
}
```

### POST /api/admin/bookings/bulk-update
```json
{
  "bookingIds": ["BK789012", "BK789011"],
  "updates": {
    "status": "completed"
  }
}
```

### POST /api/admin/bookings/export
```json
{
  "bookingIds": ["BK789012"],
  "format": "csv",
  "filters": { "dateRange": "today" }
}
```

## Testing Checklist

- ✅ Filter tabs work
- ✅ Search works
- ✅ Advanced filters work
- ✅ Sorting works
- ✅ Pagination works
- ✅ Bulk selection works
- ✅ Bulk export works
- ✅ Bulk status update works
- ✅ Real-time updates work
- ✅ Quick stats accurate
- ✅ Loading states show
- ✅ Empty states show
- ✅ Error handling works

## Navigation Flow

**Entry Points:**
- Dashboard → Bookings stat card
- Sidebar → Bookings

**Exit Points:**
- Click View → Booking Detail (Screen 34)
- Sidebar → Other admin sections
