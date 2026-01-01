# Service Catalog Management

## Overview
- **Screen ID**: 35
- **Screen Name**: Service Catalog Management
- **User Role**: Admin, Super Admin
- **Platform**: Web (Desktop)
- **Navigation**: From Dashboard → Sidebar → Services

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  UrbanNest Admin                                    🔍 Search...        👤 Admin  🔔   │
├──────────────┬─────────────────────────────────────────────────────────────────────────┤
│              │                                                                          │
│  📊 Dashboard│  Service Catalog                               [+ Add New Service]      │
│  👥 Providers│  ┌──────────────────────────────────────────────────────────────────┐   │
│  📋 Bookings │  │ All (24) │ Active (20) │ Inactive (4) │ Draft (2)              │   │
│  👨 Customers│  └──────────────────────────────────────────────────────────────────┘   │
│  🔧 Services │   (All selected)                                                        │
│  ──────────  │                                                                          │
│  💰 Payments │  🔍 [Search services by name, category...                    ]  [Search]│
│  📊 Analytics│                                                                          │
│  ⚙️ Settings │  Filters: 📂 All Categories • 🏙️ All Cities                 [Clear]    │
│              │                                                                          │
│              │  ┌───────────────────────────────────────────────────────────────────┐  │
│              │  │ Categories                                                        │  │
│              │  │                                                                   │  │
│              │  │ [🔧 Home Repair (8)]  [💡 Electrical (3)]  [🚿 Plumbing (4)]    │  │
│              │  │ [❄️ AC Services (5)]  [🎨 Painting (2)]     [🧹 Cleaning (3)]   │  │
│              │  │ [✂️ Salon (6)]        [🚗 Auto (2)]         [+ Add Category]     │  │
│              │  └───────────────────────────────────────────────────────────────────┘  │
│              │                                                                          │
│              │  ┌──┬────────────────┬────────────┬──────────┬──────────┬──────────────┐│
│              │  │☑│ Service        │ Category   │ Price    │ Status   │ Actions      ││
│              │  ├──┼────────────────┼────────────┼──────────┼──────────┼──────────────┤│
│              │  │☐│ [🔧] AC Repair │ AC Services│ ₹499-799 │ 🟢 Active│ [Edit] [···] ││
│              │  │ │ & Service      │ 145 bookings│         │          │              ││
│              │  │ │ 4.6 ⭐ (89)     │ 12 providers│         │ 32 cities│              ││
│              │  ├──┼────────────────┼────────────┼──────────┼──────────┼──────────────┤│
│              │  │☐│ [💡] Electrical│ Electrical │ ₹299-599 │ 🟢 Active│ [Edit] [···] ││
│              │  │ │ Wiring & Repair│ 98 bookings │         │          │              ││
│              │  │ │ 4.5 ⭐ (72)     │ 8 providers │         │ 28 cities│              ││
│              │  ├──┼────────────────┼────────────┼──────────┼──────────┼──────────────┤│
│              │  │☐│ [🚿] Plumbing  │ Plumbing   │ ₹349-699 │ 🟢 Active│ [Edit] [···] ││
│              │  │ │ Repair         │ 124 bookings│         │          │              ││
│              │  │ │ 4.7 ⭐ (95)     │ 15 providers│         │ 35 cities│              ││
│              │  ├──┼────────────────┼────────────┼──────────┼──────────┼──────────────┤│
│              │  │☐│ [🎨] Home      │ Painting   │ ₹1999+   │ 🟢 Active│ [Edit] [···] ││
│              │  │ │ Painting       │ 67 bookings │         │          │              ││
│              │  │ │ 4.8 ⭐ (54)     │ 6 providers │         │ 18 cities│              ││
│              │  ├──┼────────────────┼────────────┼──────────┼──────────┼──────────────┤│
│              │  │☐│ [✂️] Salon at  │ Salon      │ ₹799-1499│ 🔵 Draft │ [Edit] [···] ││
│              │  │ │ Home           │ 0 bookings  │         │          │              ││
│              │  │ │ N/A            │ 0 providers │         │ 0 cities │              ││
│              │  ├──┼────────────────┼────────────┼──────────┼──────────┼──────────────┤│
│              │  │☐│ [🧹] Deep      │ Cleaning   │ ₹599-999 │ ⚪ Inactive│[Edit] [···] ││
│              │  │ │ Cleaning       │ 12 bookings │         │          │              ││
│              │  │ │ 4.2 ⭐ (8)      │ 2 providers │         │ 5 cities │              ││
│              │  └──┴────────────────┴────────────┴──────────┴──────────┴──────────────┘│
│              │                                                                          │
│              │  Showing 1-10 of 24                           [◄] [1] [2] [3] [►]      │
│              │                                                                          │
│              │  Selected: 0                                                             │
│              │  ┌────────────────────────────────────────────────────────────────────┐ │
│              │  │ [Bulk Activate]  [Bulk Deactivate]  [Bulk Delete]  [Export CSV]   │ │
│              │  └────────────────────────────────────────────────────────────────────┘ │
│              │                                                                          │
└──────────────┴─────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Header Section
- **Height**: 64px
- **Title**: Inter Bold 24px, #1E1E1E
- **Add Service Button**: 40px height, Deep Teal background, white text
- **Icon**: Plus icon, 20x20px

### Filter Tabs
- **Height**: 48px
- **Tab Style**: Pill shape when active
- **Badge Count**: Real-time from database
- **Active Tab**: Deep Teal (#0D7377)

### Search Bar
- **Width**: 60% of container
- **Height**: 44px
- **Border Radius**: 8px
- **Placeholder**: Inter Regular 14px

### Category Pills
- **Height**: 40px
- **Padding**: 12px horizontal
- **Border Radius**: 20px (pill)
- **Background**: Light gray (#F5F5F5)
- **Hover**: Deep Teal tint
- **Active**: Deep Teal background, white text
- **Icon**: 20x20px, category emoji
- **Count**: Inter SemiBold 13px in parentheses
- **Gap**: 8px between pills

### Services Table
- **Row Height**: 80px (multi-line content)
- **Checkbox Column**: 48px width
- **Service Column**: 280px width
- **Category Column**: 160px width
- **Price Column**: 120px width
- **Status Column**: 120px width
- **Actions Column**: 120px width

### Service Cell Content
- **Icon**: 32x32px emoji in colored circle
- **Name**: Inter SemiBold 15px, #1E1E1E
- **Rating**: Star icon + score, Inter Medium 13px
- **Review Count**: Inter Regular 12px, #999999

### Metadata (Under Service Name)
- **Bookings**: Inter Regular 13px, #666666
- **Providers**: Inter Regular 13px, #666666
- **Icon**: Small icon, 14x14px

### Category Cell
- **Name**: Inter Medium 14px, #1E1E1E
- **Stats**: Inter Regular 12px, #666666

### Price Cell
- **Range**: Inter SemiBold 15px, #1E1E1E
- **Format**: ₹XXX-YYY or ₹XXX+ (starting from)

### Status Badges
- **Height**: 28px
- **Border Radius**: 6px
- **Padding**: 6px 12px
- **Font**: Inter SemiBold 12px
- **Colors**:
  - Active: Green (#28C76F)
  - Inactive: Gray (#999999)
  - Draft: Blue (#00CFE8)

### Actions Column
- **Edit Button**: 32px height, Inter Medium 13px, outlined
- **More Menu** (···): 32x32px icon button
- **Dropdown Menu**:
  - View Details
  - Duplicate
  - Deactivate
  - Delete

## Components Used

### Service Row
```jsx
const ServiceRow = ({ service, isSelected, onSelect, onEdit, onAction }) => {
  const statusConfig = {
    active: { color: '#28C76F', label: 'Active', icon: '🟢' },
    inactive: { color: '#999999', label: 'Inactive', icon: '⚪' },
    draft: { color: '#00CFE8', label: 'Draft', icon: '🔵' }
  };

  const status = statusConfig[service.status];

  return (
    <tr className="service-row">
      <td>
        <input
          type="checkbox"
          checked={isSelected}
          onChange={onSelect}
        />
      </td>
      <td>
        <div className="service-info">
          <div className="service-icon">{service.icon}</div>
          <div className="service-details">
            <h4 className="service-name">{service.name}</h4>
            <div className="service-meta">
              <span className="rating">
                {service.rating ? `${service.rating} ⭐ (${service.reviewCount})` : 'N/A'}
              </span>
            </div>
          </div>
        </div>
      </td>
      <td>
        <div className="category-info">
          <p className="category-name">{service.category}</p>
          <p className="category-stats">
            {service.bookingCount} bookings<br />
            {service.providerCount} providers
          </p>
        </div>
      </td>
      <td>
        <p className="price-range">
          {service.priceRange.min && service.priceRange.max
            ? `₹${service.priceRange.min}-${service.priceRange.max}`
            : `₹${service.priceRange.starting}+`}
        </p>
      </td>
      <td>
        <StatusBadge
          icon={status.icon}
          label={status.label}
          color={status.color}
        />
        <p className="availability">{service.cityCount} cities</p>
      </td>
      <td>
        <div className="action-buttons">
          <button className="edit-btn" onClick={() => onEdit(service.id)}>
            Edit
          </button>
          <Dropdown
            trigger={<button className="more-btn">···</button>}
            items={[
              { label: 'View Details', onClick: () => viewDetails(service.id) },
              { label: 'Duplicate', onClick: () => duplicate(service.id) },
              { label: 'Deactivate', onClick: () => deactivate(service.id) },
              { label: 'Delete', onClick: () => deleteService(service.id), danger: true }
            ]}
          />
        </div>
      </td>
    </tr>
  );
};
```

### Category Filter Pills
```jsx
const CategoryFilters = ({ categories, activeCategory, onCategoryChange }) => {
  return (
    <div className="category-filters">
      {categories.map(category => (
        <button
          key={category.id}
          className={`category-pill ${activeCategory === category.id ? 'active' : ''}`}
          onClick={() => onCategoryChange(category.id)}
        >
          <span className="icon">{category.icon}</span>
          <span className="name">{category.name}</span>
          <span className="count">({category.serviceCount})</span>
        </button>
      ))}
      <button className="add-category-btn" onClick={showAddCategoryModal}>
        + Add Category
      </button>
    </div>
  );
};
```

### Add/Edit Category Modal
```jsx
const CategoryModal = ({ category, onSave, onClose }) => {
  const [name, setName] = useState(category?.name || '');
  const [icon, setIcon] = useState(category?.icon || '🔧');
  const [description, setDescription] = useState(category?.description || '');

  const iconOptions = ['🔧', '💡', '🚿', '❄️', '🎨', '🧹', '✂️', '🚗', '🏠', '🌿'];

  return (
    <Modal title={category ? 'Edit Category' : 'Add Category'} onClose={onClose}>
      <div className="form-group">
        <label>Category Name</label>
        <input
          type="text"
          value={name}
          onChange={e => setName(e.target.value)}
          placeholder="e.g., Home Repair"
        />
      </div>

      <div className="form-group">
        <label>Icon</label>
        <div className="icon-picker">
          {iconOptions.map(emoji => (
            <button
              key={emoji}
              className={`icon-option ${icon === emoji ? 'selected' : ''}`}
              onClick={() => setIcon(emoji)}
            >
              {emoji}
            </button>
          ))}
        </div>
      </div>

      <div className="form-group">
        <label>Description</label>
        <textarea
          value={description}
          onChange={e => setDescription(e.target.value)}
          placeholder="Brief description of this category"
          rows={3}
        />
      </div>

      <div className="modal-actions">
        <button className="cancel" onClick={onClose}>Cancel</button>
        <button
          className="save"
          onClick={() => onSave({ name, icon, description })}
          disabled={!name}
        >
          {category ? 'Update' : 'Create'} Category
        </button>
      </div>
    </Modal>
  );
};
```

## Key Features

### Service Management
- **Create**: Add new service with all details
- **Edit**: Update existing service
- **Duplicate**: Clone service for similar offerings
- **Activate/Deactivate**: Toggle availability
- **Delete**: Remove service (with confirmation)

### Filtering & Search
- **Category Filter**: Filter by service category
- **Status Filter**: Active, inactive, draft
- **City Filter**: Services available in specific cities
- **Search**: Search by name, description, keywords
- **Sort**: Name, price, rating, bookings, date added

### Bulk Operations
- **Bulk Activate**: Activate multiple services
- **Bulk Deactivate**: Deactivate multiple services
- **Bulk Delete**: Delete multiple services (confirmation required)
- **Bulk Export**: Export service data to CSV

### Category Management
- **Add Category**: Create new service category
- **Edit Category**: Update category details
- **Reorder**: Drag to reorder category display
- **Icon**: Select from emoji picker
- **Delete**: Remove category (if no services)

### Service Analytics
- **Booking Count**: Total bookings per service
- **Rating**: Average customer rating
- **Provider Count**: Providers offering service
- **City Coverage**: Number of cities available
- **Revenue**: Total revenue generated

## Interactions

### Add New Service Button
- Navigate to Add/Edit Service screen (Screen 36)
- Clear form for new entry
- Set status to "Draft" by default

### Edit Button Click
- Navigate to Add/Edit Service screen (Screen 36)
- Pre-populate form with service data
- Allow modifications

### More Menu (···) Click
- Open dropdown menu
- **View Details**: Show full service details modal
- **Duplicate**: Clone service, open in edit mode
- **Deactivate**: Toggle active/inactive status
- **Delete**: Confirmation dialog → Delete service

### Category Pill Click
- Filter services by category
- Update table data
- Highlight active category
- Show service count

### Add Category Button
- Open category creation modal
- Fill name, icon, description
- Save to database
- Add to filter pills

### Checkbox Selection
- Select individual service
- Enable bulk actions
- Update selection count

### Bulk Activate
- Confirmation dialog
- Update status for all selected
- Success toast
- Refresh table

### Bulk Deactivate
- Confirmation dialog
- Update status for all selected
- Warning if provider has active bookings
- Success toast

### Bulk Delete
- Warning dialog: "Delete X services?"
- Check for active bookings
- Prevent deletion if active bookings exist
- Move to trash (soft delete)
- Success toast

### Export CSV
- Generate CSV with all service data
- Include filters in filename
- Auto-download
- Format: `services_YYYYMMDD.csv`

### Search Submit
- Query database
- Filter results
- Highlight matching text
- Show result count

## States

### Loading State
- Skeleton rows (10 rows)
- Shimmer animation
- Disabled buttons

### Empty State
- **No Services**: "No services added yet. Create your first service."
- **No Search Results**: "No services match your search"
- **No Category**: "No services in this category"

### Error State
- Error message: "Failed to load services"
- Retry button

## Data Loading

```javascript
const ServiceCatalog = () => {
  const [services, setServices] = useState([]);
  const [categories, setCategories] = useState([]);
  const [activeFilter, setActiveFilter] = useState('all');
  const [activeCategory, setActiveCategory] = useState(null);
  const [selectedIds, setSelectedIds] = useState(new Set());
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const pageSize = 20;

  useEffect(() => {
    loadServices();
    loadCategories();
  }, [activeFilter, activeCategory, page]);

  const loadServices = async () => {
    setLoading(true);
    try {
      const queryParams = new URLSearchParams({
        page,
        limit: pageSize,
        status: activeFilter !== 'all' ? activeFilter : undefined,
        category: activeCategory,
        sortBy: 'name'
      });

      const response = await fetch(`/api/admin/services?${queryParams}`);
      const data = await response.json();

      setServices(data.services);
      setTotalPages(data.totalPages);
    } catch (error) {
      showErrorToast('Failed to load services');
    } finally {
      setLoading(false);
    }
  };

  const loadCategories = async () => {
    try {
      const response = await fetch('/api/admin/categories');
      const data = await response.json();
      setCategories(data.categories);
    } catch (error) {
      console.error('Failed to load categories');
    }
  };

  const handleBulkActivate = async () => {
    try {
      await fetch('/api/admin/services/bulk-activate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          serviceIds: Array.from(selectedIds)
        })
      });

      showSuccessToast(`${selectedIds.size} services activated`);
      setSelectedIds(new Set());
      loadServices();
    } catch (error) {
      showErrorToast('Failed to activate services');
    }
  };

  const handleDelete = async (serviceId) => {
    const confirmed = await showConfirmDialog({
      title: 'Delete Service?',
      message: 'This action cannot be undone. Active bookings will not be affected.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      danger: true
    });

    if (!confirmed) return;

    try {
      await fetch(`/api/admin/services/${serviceId}`, {
        method: 'DELETE'
      });

      showSuccessToast('Service deleted');
      loadServices();
    } catch (error) {
      showErrorToast('Failed to delete service');
    }
  };
};
```

## Permissions

- **Super Admin**: Full access to all operations
- **Admin**: Can create, edit, activate/deactivate services
- **Support Admin**: View only

## Analytics

- `service_catalog_viewed`: Page loaded
- `service_filter_changed`: Filter applied
- `service_created`: New service added
- `service_updated`: Service edited
- `service_activated`: Service activated
- `service_deactivated`: Service deactivated
- `service_deleted`: Service removed
- `category_created`: New category added
- `bulk_operation_performed`: Bulk action executed

## API Endpoints

### GET /api/admin/services
```javascript
// Query params: page, limit, status, category, search, sortBy
{
  "services": [
    {
      "id": "SRV_001",
      "name": "AC Repair & Service",
      "icon": "🔧",
      "category": "AC Services",
      "categoryId": "CAT_001",
      "priceRange": { "min": 499, "max": 799 },
      "rating": 4.6,
      "reviewCount": 89,
      "bookingCount": 145,
      "providerCount": 12,
      "cityCount": 32,
      "status": "active",
      "description": "Complete AC repair and servicing",
      "createdAt": "2024-01-15T10:00:00Z",
      "updatedAt": "2024-12-10T14:30:00Z"
    }
  ],
  "totalCount": 24,
  "totalPages": 2,
  "currentPage": 1
}
```

### GET /api/admin/categories
```json
{
  "categories": [
    {
      "id": "CAT_001",
      "name": "AC Services",
      "icon": "❄️",
      "description": "Air conditioning repair and installation",
      "serviceCount": 5,
      "order": 1
    }
  ]
}
```

### POST /api/admin/services
```json
{
  "name": "New Service",
  "categoryId": "CAT_001",
  "description": "Service description",
  "basePrice": 499,
  "status": "draft"
}
```

### PATCH /api/admin/services/:serviceId
```json
{
  "name": "Updated Service Name",
  "basePrice": 599
}
```

### DELETE /api/admin/services/:serviceId
```json
// No body required
// Returns: { "success": true }
```

### POST /api/admin/services/bulk-activate
```json
{
  "serviceIds": ["SRV_001", "SRV_002"]
}
```

## Testing Checklist

- ✅ Services list loads
- ✅ Category filters work
- ✅ Status filters work
- ✅ Search works
- ✅ Sorting works
- ✅ Pagination works
- ✅ Add service works
- ✅ Edit service works
- ✅ Delete service works
- ✅ Bulk operations work
- ✅ Category management works
- ✅ Export CSV works
- ✅ Loading states show
- ✅ Empty states show
- ✅ Error handling works

## Navigation Flow

**Entry Points:**
- Dashboard → Services stat
- Sidebar → Services

**Exit Points:**
- Click Add/Edit → Add/Edit Service screen (Screen 36)
- Sidebar → Other admin sections
