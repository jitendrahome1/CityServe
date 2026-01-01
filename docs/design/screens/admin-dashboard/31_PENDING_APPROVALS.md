# Pending Provider Approvals

## Overview
- **Screen ID**: 31
- **Screen Name**: Pending Provider Approvals List
- **User Role**: Admin, Super Admin
- **Platform**: Web (Desktop)
- **Navigation**: From Dashboard → Providers → Pending Approvals

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  UrbanNest Admin                                    🔍 Search...        👤 Admin  🔔   │
├──────────────┬─────────────────────────────────────────────────────────────────────────┤
│              │                                                                          │
│  📊 Dashboard│  Provider Approvals                                           [Filters] │
│  👥 Providers│  ┌────────────────────────────────────────────────────────────────────┐ │
│  ────────────│  │ All (42) │ New (12) │ Under Review (18) │ Need Info (8) │ Urgent (4)│ │
│  📋 Bookings │  └────────────────────────────────────────────────────────────────────┘ │
│  👨 Customers│   (All selected)                                                        │
│  🔧 Services │                                                                          │
│  💰 Payments │  ┌─┬──────────────────────────┬────────────┬─────────────┬────────────┐│
│  📊 Analytics│  │☑│ Provider Info            │ Services   │ Submitted   │ Status     ││
│  ⚙️ Settings │  ├─┼──────────────────────────┼────────────┼─────────────┼────────────┤│
│              │  │☐│ [Photo] Rajesh Kumar     │ Plumbing   │ 2 hours ago │ 🔴 Urgent  ││
│              │  │ │ +91 98765 43210          │ Electrical │             │ Missing ID ││
│              │  │ │ Delhi • ID: PRV_001234   │            │             │ [Review]   ││
│              │  ├─┼──────────────────────────┼────────────┼─────────────┼────────────┤│
│              │  │☐│ [Photo] Priya Sharma     │ AC Repair  │ 5 hours ago │ ⚪ New     ││
│              │  │ │ +91 98765 43211          │ Cleaning   │             │            ││
│              │  │ │ Mumbai • ID: PRV_001235  │            │             │ [Review]   ││
│              │  ├─┼──────────────────────────┼────────────┼─────────────┼────────────┤│
│              │  │☐│ [Photo] Amit Patel       │ Salon      │ 1 day ago   │ 🟡 Review  ││
│              │  │ │ +91 98765 43212          │            │             │ Docs OK    ││
│              │  │ │ Bangalore • ID: PRV_001236│           │             │ [Review]   ││
│              │  ├─┼──────────────────────────┼────────────┼─────────────┼────────────┤│
│              │  │☐│ [Photo] Neha Verma       │ Painting   │ 2 days ago  │ 🔵 Waiting ││
│              │  │ │ +91 98765 43213          │            │             │ More Info  ││
│              │  │ │ Delhi • ID: PRV_001237   │            │             │ [Review]   ││
│              │  ├─┼──────────────────────────┼────────────┼─────────────┼────────────┤│
│              │  │☐│ [Photo] Rahul Singh      │ Plumbing   │ 3 days ago  │ 🔴 Urgent  ││
│              │  │ │ +91 98765 43214          │ AC Repair  │             │ Pending 3d ││
│              │  │ │ Delhi • ID: PRV_001238   │            │             │ [Review]   ││
│              │  └─┴──────────────────────────┴────────────┴─────────────┴────────────┘│
│              │                                                                          │
│              │  Showing 1-5 of 42                           [◄] [1] [2] [3] [4] [►]   │
│              │                                                                          │
│              │  Selected: 0                                                             │
│              │  ┌──────────────────────────────────────────────────────────────────┐   │
│              │  │ [Bulk Approve]  [Bulk Reject]  [Request Info]  [Export CSV]     │   │
│              │  └──────────────────────────────────────────────────────────────────┘   │
│              │                                                                          │
└──────────────┴─────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Filter Tabs
- **Height**: 48px
- **Tab Padding**: 16px horizontal, 12px vertical
- **Active Tab**: Deep Teal (#0D7377) background, white text
- **Inactive Tab**: Transparent, gray text (#666666)
- **Badge Count**: Inter SemiBold 12px, white text in colored circle
- **Border Radius**: 8px for active tab

### Provider Table
- **Width**: Full container width
- **Row Height**: 80px
- **Header Row**: 48px height, Inter SemiBold 14px, #666666
- **Checkbox**: 20x20px, 4px border-radius
- **Photo**: 56x56px circular avatar
- **Name**: Inter SemiBold 16px, #1E1E1E
- **Phone/Location**: Inter Regular 13px, #666666
- **Provider ID**: Inter Regular 12px, monospace, #999999
- **Services**: Pills with service icons, 8px gap
- **Time**: Inter Regular 13px, #666666
- **Status Badge**:
  - Urgent: Red (#EA5455) background
  - New: Gray (#999999) background
  - Under Review: Yellow (#FFC107) background
  - Need Info: Blue (#00CFE8) background

### Bulk Actions Bar
- **Height**: 56px
- **Background**: Light gray (#F5F5F5)
- **Border**: 1px solid #E0E0E0
- **Button Spacing**: 12px gap
- **Button Height**: 36px
- **Button Padding**: 12px horizontal

### Pagination
- **Height**: 48px
- **Button Size**: 36x36px
- **Active Page**: Deep Teal background
- **Hover**: Light teal background (#E6F4F5)

## Components Used

### Provider Row
```jsx
const ProviderRow = ({ provider, isSelected, onSelect, onReview }) => {
  const urgencyColor = {
    urgent: '#EA5455',
    new: '#999999',
    review: '#FFC107',
    waiting: '#00CFE8'
  };

  return (
    <tr className="provider-row">
      <td>
        <input
          type="checkbox"
          checked={isSelected}
          onChange={onSelect}
          aria-label={`Select ${provider.name}`}
        />
      </td>
      <td>
        <div className="provider-info">
          <img
            src={provider.photoUrl}
            alt={provider.name}
            className="avatar"
          />
          <div className="details">
            <h4>{provider.name}</h4>
            <p className="contact">{provider.phone}</p>
            <p className="meta">
              {provider.city} • ID: {provider.id}
            </p>
          </div>
        </div>
      </td>
      <td>
        <div className="services">
          {provider.services.map(service => (
            <ServicePill key={service} service={service} />
          ))}
        </div>
      </td>
      <td className="submitted">{provider.submittedAt}</td>
      <td>
        <StatusBadge
          status={provider.status}
          color={urgencyColor[provider.urgency]}
          message={provider.statusMessage}
        />
        <button
          className="review-btn"
          onClick={() => onReview(provider.id)}
        >
          Review
        </button>
      </td>
    </tr>
  );
};
```

### Filter Tabs
```jsx
const FilterTabs = ({ activeFilter, counts, onFilterChange }) => {
  const filters = [
    { id: 'all', label: 'All', count: counts.all },
    { id: 'new', label: 'New', count: counts.new },
    { id: 'review', label: 'Under Review', count: counts.review },
    { id: 'needInfo', label: 'Need Info', count: counts.needInfo },
    { id: 'urgent', label: 'Urgent', count: counts.urgent }
  ];

  return (
    <div className="filter-tabs">
      {filters.map(filter => (
        <button
          key={filter.id}
          className={`tab ${activeFilter === filter.id ? 'active' : ''}`}
          onClick={() => onFilterChange(filter.id)}
        >
          {filter.label}
          <span className="badge">{filter.count}</span>
        </button>
      ))}
    </div>
  );
};
```

### Bulk Actions Bar
```jsx
const BulkActionsBar = ({
  selectedCount,
  onBulkApprove,
  onBulkReject,
  onRequestInfo,
  onExport
}) => {
  if (selectedCount === 0) return null;

  return (
    <div className="bulk-actions-bar">
      <p className="selected-count">Selected: {selectedCount}</p>
      <div className="actions">
        <button className="approve" onClick={onBulkApprove}>
          <CheckIcon /> Bulk Approve
        </button>
        <button className="reject" onClick={onBulkReject}>
          <XIcon /> Bulk Reject
        </button>
        <button className="info" onClick={onRequestInfo}>
          <InfoIcon /> Request Info
        </button>
        <button className="export" onClick={onExport}>
          <DownloadIcon /> Export CSV
        </button>
      </div>
    </div>
  );
};
```

## Key Features

### Filtering System
- **All**: Show all pending approvals
- **New**: Applications submitted in last 24 hours
- **Under Review**: Admin has opened but not completed
- **Need Info**: Additional information requested from provider
- **Urgent**: Pending > 3 days or critical issues

### Sorting Options
- **Submitted**: Oldest first (default) / Newest first
- **Urgency**: Most urgent first
- **Name**: Alphabetical A-Z / Z-A
- **City**: Group by location

### Search Functionality
- Search by:
  - Provider name
  - Phone number
  - Provider ID
  - City
  - Service type
- Real-time search with debounce (300ms)
- Highlight matching text in results

### Bulk Operations
- Select multiple providers (checkbox)
- Select all (header checkbox)
- Bulk actions:
  - Approve (if all docs verified)
  - Reject with reason
  - Request additional information
  - Export to CSV

### Advanced Filters
```jsx
const AdvancedFilters = () => {
  return (
    <div className="advanced-filters">
      <Select
        label="City"
        options={['All Cities', 'Delhi', 'Mumbai', 'Bangalore']}
      />
      <Select
        label="Service Type"
        options={['All Services', 'Plumbing', 'AC Repair', 'Electrical']}
      />
      <Select
        label="Submitted"
        options={['All Time', 'Last 24 hours', 'Last 7 days', 'Last 30 days']}
      />
      <Select
        label="Document Status"
        options={['All', 'Complete', 'Incomplete', 'Expired']}
      />
      <button onClick={clearFilters}>Clear All</button>
    </div>
  );
};
```

## Interactions

### Review Button Click
- Navigate to Provider Application Review screen (Screen 32)
- Pass provider ID as parameter
- Open in new tab with Cmd/Ctrl + Click

### Row Click (not on button)
- Quick preview modal
- Show provider summary
- Quick actions: Approve, Reject, View Full Details

### Checkbox Selection
- Toggle individual selection
- Update bulk actions bar
- Enable bulk operation buttons

### Header Checkbox
- Select all on current page
- Deselect all if all selected
- Indeterminate state if some selected

### Tab Filter Click
- Filter table data
- Update counts in tabs
- Maintain search query
- Reset to page 1

### Export CSV
- Generate CSV with selected providers
- Include all provider data
- Auto-download file
- Format: `provider_approvals_YYYYMMDD.csv`

### Bulk Approve
- Confirmation modal: "Approve X providers?"
- Validate all have complete documents
- Show error if any missing docs
- Success toast: "X providers approved"
- Email notification to providers
- Remove from pending list

### Bulk Reject
- Open rejection reason modal
- Require reason selection (predefined + custom)
- Confirmation: "Reject X providers?"
- Send rejection email with reason
- Move to rejected list
- Allow provider to reapply after 30 days

### Request Info
- Open modal with info request form
- Select provider(s)
- Choose missing items:
  - Aadhaar card
  - PAN card
  - Address proof
  - Selfie with ID
  - Police verification
  - Other (custom message)
- Send email + in-app notification
- Update status to "Waiting for Info"

## States

### Loading State
- Skeleton rows (5 rows)
- Shimmer animation
- Disabled buttons

### Empty State
- **No Results**: "No pending approvals found"
- **Search No Results**: "No providers match your search"
- **Filter No Results**: "No providers in this category"
- Icon + message + "Clear filters" button

### Error State
- Error message: "Failed to load approvals"
- Retry button
- Contact support link

## Data Loading

```javascript
const PendingApprovals = () => {
  const [providers, setProviders] = useState([]);
  const [activeFilter, setActiveFilter] = useState('all');
  const [selectedIds, setSelectedIds] = useState(new Set());
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const pageSize = 20;

  useEffect(() => {
    loadProviders();

    // Real-time updates for new applications
    const unsubscribe = firestore
      .collection('provider_applications')
      .where('status', 'in', ['pending', 'under_review', 'need_info'])
      .orderBy('submittedAt', 'desc')
      .onSnapshot(snapshot => {
        snapshot.docChanges().forEach(change => {
          if (change.type === 'added') {
            showNewApplicationNotification(change.doc.data());
          }
        });
        updateProviderList(snapshot);
      });

    return () => unsubscribe();
  }, [activeFilter, page]);

  const loadProviders = async () => {
    setLoading(true);
    try {
      const response = await fetch(
        `/api/admin/providers/pending?filter=${activeFilter}&page=${page}&limit=${pageSize}`
      );
      const data = await response.json();
      setProviders(data.providers);
      setTotalPages(data.totalPages);
    } catch (error) {
      showErrorToast('Failed to load providers');
    } finally {
      setLoading(false);
    }
  };

  const handleBulkApprove = async () => {
    const confirmed = await showConfirmDialog({
      title: 'Approve Providers?',
      message: `Are you sure you want to approve ${selectedIds.size} providers?`,
      confirmText: 'Approve All',
      cancelText: 'Cancel'
    });

    if (!confirmed) return;

    try {
      await fetch('/api/admin/providers/bulk-approve', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          providerIds: Array.from(selectedIds)
        })
      });

      showSuccessToast(`${selectedIds.size} providers approved`);
      setSelectedIds(new Set());
      loadProviders();
    } catch (error) {
      showErrorToast('Failed to approve providers');
    }
  };
};
```

## Urgency Calculation

```javascript
const calculateUrgency = (application) => {
  const daysSinceSubmit = daysDiff(application.submittedAt, Date.now());

  // Urgent if pending > 3 days
  if (daysSinceSubmit > 3) {
    return {
      level: 'urgent',
      message: `Pending ${daysSinceSubmit}d`,
      color: 'red'
    };
  }

  // Urgent if missing critical docs
  if (!application.aadhaar || !application.pan) {
    return {
      level: 'urgent',
      message: 'Missing ID',
      color: 'red'
    };
  }

  // Under review
  if (application.reviewedBy) {
    return {
      level: 'review',
      message: 'Docs OK',
      color: 'yellow'
    };
  }

  // Waiting for more info
  if (application.infoRequested) {
    return {
      level: 'waiting',
      message: 'More Info',
      color: 'blue'
    };
  }

  // New application
  return {
    level: 'new',
    message: '',
    color: 'gray'
  };
};
```

## Permissions

- **Super Admin**: Full access, bulk approve/reject
- **Admin**: View, review individual, request info
- **Support Admin**: View only, cannot approve

## Analytics

- `pending_approvals_viewed`: Screen loaded
- `approval_filter_changed`: Filter tab clicked
- `provider_reviewed`: Review button clicked
- `bulk_approve_used`: Bulk approve executed
- `bulk_reject_used`: Bulk reject executed
- `info_requested`: Additional info requested
- `csv_exported`: CSV export downloaded
- `search_performed`: Search query submitted

## API Endpoints

### GET /api/admin/providers/pending
```javascript
// Query params: filter, page, limit, search, sortBy
{
  "providers": [
    {
      "id": "PRV_001234",
      "name": "Rajesh Kumar",
      "phone": "+919876543210",
      "email": "rajesh@example.com",
      "photoUrl": "https://...",
      "city": "Delhi",
      "services": ["plumbing", "electrical"],
      "submittedAt": "2024-12-20T10:00:00Z",
      "status": "pending",
      "documents": {
        "aadhaar": { status: "missing" },
        "pan": { status: "verified" },
        "selfie": { status: "verified" },
        "addressProof": { status: "pending" }
      },
      "urgency": "urgent"
    }
  ],
  "totalCount": 42,
  "totalPages": 3,
  "currentPage": 1
}
```

### POST /api/admin/providers/bulk-approve
```javascript
{
  "providerIds": ["PRV_001234", "PRV_001235"]
}
// Response:
{
  "success": true,
  "approved": 2,
  "failed": 0,
  "errors": []
}
```

### POST /api/admin/providers/bulk-reject
```javascript
{
  "providerIds": ["PRV_001234"],
  "reason": "incomplete_documents",
  "customMessage": "Aadhaar card is unclear"
}
```

### POST /api/admin/providers/request-info
```javascript
{
  "providerIds": ["PRV_001234"],
  "missingItems": ["aadhaar", "address_proof"],
  "message": "Please upload a clear photo of your Aadhaar card"
}
```

## Testing Checklist

- ✅ Filter tabs work correctly
- ✅ Search functionality works
- ✅ Sorting works
- ✅ Pagination works
- ✅ Bulk selection works
- ✅ Bulk approve works
- ✅ Bulk reject works
- ✅ Request info works
- ✅ CSV export works
- ✅ Real-time updates work
- ✅ Loading states show
- ✅ Empty states show
- ✅ Error handling works
- ✅ Permissions enforced
- ✅ Urgency calculation correct

## Navigation Flow

**Entry Points:**
- Dashboard → Pending Actions → Provider Approvals
- Sidebar → Providers → Pending Approvals

**Exit Points:**
- Click Review → Provider Application Review (Screen 32)
- Click provider row → Quick preview modal
- Sidebar click → Other admin sections
