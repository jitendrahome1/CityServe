# Add/Edit Service

## Overview
- **Screen ID**: 36
- **Screen Name**: Add/Edit Service Form
- **User Role**: Admin, Super Admin
- **Platform**: Web (Desktop)
- **Navigation**: From Service Catalog → Click "Add New Service" or "Edit"

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  ←  Service Catalog                             🔍 Search...        👤 Admin  🔔        │
├────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                         │
│  Add New Service                                          Status: 🔵 Draft • Autosaved │
│                                                                                         │
│  ┌─────────────────────────────────────────┐  ┌────────────────────────────────────┐  │
│  │ 📋 Basic Information                    │  │ 👁️ Preview                        │  │
│  │                                         │  │                                    │  │
│  │ Service Name *                          │  │ ┌────────────────────────────────┐│  │
│  │ ┌─────────────────────────────────────┐│  │ │ [🔧] AC Repair & Service       ││  │
│  │ │ AC Repair & Service                 ││  │ │                                ││  │
│  │ └─────────────────────────────────────┘│  │ │ Complete air conditioning      ││  │
│  │                                         │  │ │ repair and servicing...        ││  │
│  │ Service Icon *                          │  │ │                                ││  │
│  │ ┌─────────────────────────────────────┐│  │ │ Starting from ₹499             ││  │
│  │ │ [🔧] [💡] [🚿] [❄️] [🎨] [🧹]      ││  │ │ ⭐ 4.6 (89 reviews)           ││  │
│  │ │ (🔧 selected)                       ││  │ │                                ││  │
│  │ └─────────────────────────────────────┘│  │ │ [Book Now]                     ││  │
│  │                                         │  │ └────────────────────────────────┘│  │
│  │ Category *                              │  │                                    │  │
│  │ ┌─────────────────────────────────────┐│  │ Mobile Preview:                    │  │
│  │ │ AC Services              ▼         ││  │ ┌────────┐                         │  │
│  │ └─────────────────────────────────────┘│  │ │[🔧] AC │                         │  │
│  │                                         │  │ │Repair  │                         │  │
│  │ Short Description *                     │  │ │₹499+   │                         │  │
│  │ ┌─────────────────────────────────────┐│  │ └────────┘                         │  │
│  │ │ Complete air conditioning repair    ││  └────────────────────────────────────┘  │
│  │ │ and servicing with gas refill...    ││                                          │
│  │ │                                     ││  ┌────────────────────────────────────┐  │
│  │ │ (250 characters)                    ││  │ 💡 Tips                            │  │
│  │ └─────────────────────────────────────┘│  │                                    │  │
│  │                                         │  │ • Use clear, descriptive name      │  │
│  │ Full Description *                      │  │ • Add high-quality images          │  │
│  │ ┌─────────────────────────────────────┐│  │ • Set competitive pricing          │  │
│  │ │ [Rich Text Editor]                  ││  │ • Include all service details      │  │
│  │ │                                     ││  │ • Define clear inclusions          │  │
│  │ │ • AC inspection                     ││  └────────────────────────────────────┘  │
│  │ │ • Gas refilling                     ││                                          │
│  │ │ • Filter cleaning                   ││                                          │
│  │ │ • Performance check                 ││                                          │
│  │ │ • 1 month warranty                  ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌─────────────────────────────────────────┐                                          │
│  │ 💰 Pricing                              │                                          │
│  │                                         │                                          │
│  │ Base Price *                            │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ ₹ 499                               ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  │                                         │                                          │
│  │ Price Range                             │                                          │
│  │ ┌──────────────┐    to   ┌───────────┐│                                          │
│  │ │ ₹ 499       │         │ ₹ 799    ││                                          │
│  │ └──────────────┘         └───────────┘│                                          │
│  │                                         │                                          │
│  │ ☑ Enable dynamic pricing                │                                          │
│  │   (Price varies by provider & location) │                                          │
│  │                                         │                                          │
│  │ Commission Structure                    │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ Platform: 15% • Provider: 85%       ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌─────────────────────────────────────────┐                                          │
│  │ 📸 Media                                │                                          │
│  │                                         │                                          │
│  │ Service Images * (Max 6)                │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ [Image 1] [Image 2] [Image 3]       ││                                          │
│  │ │ [+ Upload]                          ││                                          │
│  │ │                                     ││                                          │
│  │ │ Recommended: 1200x800px, JPG/PNG    ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  │                                         │                                          │
│  │ Video URL (Optional)                    │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ https://youtube.com/watch?v=...     ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌─────────────────────────────────────────┐                                          │
│  │ 📦 Service Details                      │                                          │
│  │                                         │                                          │
│  │ Duration (Estimated)                    │                                          │
│  │ ┌──────────────┐  ┌───────────────────┐│                                          │
│  │ │ 1.5         │  │ hours        ▼   ││                                          │
│  │ └──────────────┘  └───────────────────┘│                                          │
│  │                                         │                                          │
│  │ What's Included                         │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ • AC inspection                     ││                                          │
│  │ │ • Gas refilling (if needed)         ││                                          │
│  │ │ • Filter cleaning                   ││                                          │
│  │ │ • Performance optimization          ││                                          │
│  │ │ • 1 month warranty                  ││                                          │
│  │ │                                     ││                                          │
│  │ │ [+ Add Item]                        ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  │                                         │                                          │
│  │ What's Not Included                     │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ • Spare parts cost                  ││                                          │
│  │ │ • Major component replacement       ││                                          │
│  │ │                                     ││                                          │
│  │ │ [+ Add Item]                        ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  │                                         │                                          │
│  │ Requirements from Customer              │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ • Access to AC unit                 ││                                          │
│  │ │ • Power supply                      ││                                          │
│  │ │                                     ││                                          │
│  │ │ [+ Add Item]                        ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌─────────────────────────────────────────┐                                          │
│  │ 🌍 Availability                         │                                          │
│  │                                         │                                          │
│  │ Available Cities * (Select multiple)    │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ ☑ Delhi                             ││                                          │
│  │ │ ☑ Mumbai                            ││                                          │
│  │ │ ☑ Bangalore                         ││                                          │
│  │ │ ☐ Hyderabad                         ││                                          │
│  │ │ ☐ Chennai                           ││                                          │
│  │ │ ☐ Pune                              ││                                          │
│  │ │                                     ││                                          │
│  │ │ [Select All] [Select None]          ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  │                                         │                                          │
│  │ Tags (For search & filtering)           │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ [ac] [repair] [cooling] [hvac]      ││                                          │
│  │ │ [+ Add Tag]                         ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌─────────────────────────────────────────┐                                          │
│  │ ⚙️ Advanced Settings                    │                                          │
│  │                                         │                                          │
│  │ ☑ Allow same-day booking                │                                          │
│  │ ☑ Show on homepage                      │                                          │
│  │ ☑ Enable customer questions             │                                          │
│  │ ☐ Requires verification before booking  │                                          │
│  │                                         │                                          │
│  │ SEO Settings                            │                                          │
│  │ ┌─────────────────────────────────────┐│                                          │
│  │ │ Meta Title:                         ││                                          │
│  │ │ AC Repair & Service | UrbanNest     ││                                          │
│  │ │                                     ││                                          │
│  │ │ Meta Description:                   ││                                          │
│  │ │ Professional AC repair and service  ││                                          │
│  │ │ at affordable prices...             ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐│
│  │  Actions:                                                                         ││
│  │  [Cancel]  [Save as Draft]  [Preview]  [Publish Service]                         ││
│  └───────────────────────────────────────────────────────────────────────────────────┘│
│                                                                                         │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Page Layout
- **Max Width**: 1400px (centered)
- **Padding**: 32px
- **Grid**: 2 columns (70% form / 30% sidebar)
- **Gap**: 32px
- **Scroll**: Main content scrollable, sidebar fixed

### Header Section
- **Height**: 64px
- **Title**: Inter Bold 24px, #1E1E1E
- **Status Badge**: 32px height, pill shape
- **Autosave Indicator**: Inter Regular 13px, #666666

### Form Sections
- **Section Card**:
  - Padding: 24px
  - Background: White (#FFFFFF)
  - Border Radius**: 12px
  - Shadow: 0 2px 8px rgba(0,0,0,0.08)
  - Margin Bottom: 24px

### Section Titles
- **Font**: Inter SemiBold 18px
- **Color**: #1E1E1E
- **Icon**: 24x24px emoji
- **Margin Bottom**: 20px

### Form Fields
- **Label**: Inter Medium 14px, #333333
- **Required Asterisk**: Red (#EA5455)
- **Input Height**: 44px
- **Border**: 1px solid #E0E0E0
- **Border Radius**: 8px
- **Focus**: Deep Teal (#0D7377) border, 2px
- **Padding**: 12px horizontal
- **Font**: Inter Regular 14px

### Text Areas
- **Min Height**: 120px
- **Max Height**: 300px (scrollable)
- **Resize**: Vertical only
- **Padding**: 12px

### Icon Picker
- **Icon Size**: 48x48px
- **Grid**: Flex wrap, 8px gap
- **Icon Button**: 60x60px, border-radius 8px
- **Hover**: Light gray background
- **Selected**: Deep Teal border, 2px

### Rich Text Editor
- **Min Height**: 200px
- **Toolbar**: Bold, italic, list, link
- **Font**: Inter Regular 14px
- **Placeholder**: Gray text

### Image Upload
- **Thumbnail Size**: 140x140px
- **Grid**: 3 columns
- **Gap**: 12px
- **Upload Button**: Dashed border, gray
- **Hover**: Deep Teal border
- **Image Preview**: Overlay with delete icon

### Checkboxes
- **Size**: 20x20px
- **Border Radius**: 4px
- **Checked**: Deep Teal background
- **Label**: Inter Regular 14px, 8px left margin

### Preview Panel (Sidebar)
- **Position**: Sticky, top 24px
- **Desktop Preview**: 320px width
- **Mobile Preview**: 160px width (scaled)
- **Background**: #F5F5F5
- **Padding**: 16px

### Action Buttons (Bottom)
- **Container**: Fixed bottom or sticky
- **Height**: 72px
- **Background**: White with top border
- **Button Height**: 48px
- **Spacing**: 12px gap
- **Cancel**: Outlined, gray
- **Save Draft**: Outlined, Deep Teal
- **Preview**: Outlined, Deep Teal
- **Publish**: Filled, Deep Teal

## Components Used

### Icon Picker
```jsx
const IconPicker = ({ value, onChange }) => {
  const icons = ['🔧', '💡', '🚿', '❄️', '🎨', '🧹', '✂️', '🚗', '🏠', '🌿', '🔌', '🪟'];

  return (
    <div className="icon-picker">
      {icons.map(icon => (
        <button
          key={icon}
          className={`icon-option ${value === icon ? 'selected' : ''}`}
          onClick={() => onChange(icon)}
          type="button"
        >
          {icon}
        </button>
      ))}
    </div>
  );
};
```

### Image Upload Component
```jsx
const ImageUpload = ({ images, maxImages, onChange }) => {
  const [uploading, setUploading] = useState(false);

  const handleUpload = async (file) => {
    if (images.length >= maxImages) {
      showToast('Maximum 6 images allowed');
      return;
    }

    setUploading(true);
    try {
      // Upload to cloud storage
      const formData = new FormData();
      formData.append('image', file);

      const response = await fetch('/api/admin/upload/image', {
        method: 'POST',
        body: formData
      });

      const data = await response.json();
      onChange([...images, data.url]);
    } catch (error) {
      showErrorToast('Failed to upload image');
    } finally {
      setUploading(false);
    }
  };

  const handleRemove = (index) => {
    const newImages = images.filter((_, i) => i !== index);
    onChange(newImages);
  };

  return (
    <div className="image-upload">
      {images.map((url, index) => (
        <div key={index} className="image-preview">
          <img src={url} alt={`Service ${index + 1}`} />
          <button
            className="remove-btn"
            onClick={() => handleRemove(index)}
          >
            ✕
          </button>
        </div>
      ))}

      {images.length < maxImages && (
        <label className="upload-btn">
          <input
            type="file"
            accept="image/*"
            onChange={e => handleUpload(e.target.files[0])}
            disabled={uploading}
          />
          {uploading ? <Spinner /> : '+ Upload'}
        </label>
      )}
    </div>
  );
};
```

### Rich Text Editor
```jsx
const RichTextEditor = ({ value, onChange, placeholder }) => {
  const [isFocused, setIsFocused] = useState(false);

  // Using a library like TipTap or Quill
  const editor = useEditor({
    extensions: [
      StarterKit,
      Link,
      BulletList,
      OrderedList
    ],
    content: value,
    onUpdate: ({ editor }) => {
      onChange(editor.getHTML());
    }
  });

  return (
    <div className={`rich-editor ${isFocused ? 'focused' : ''}`}>
      <div className="toolbar">
        <button onClick={() => editor.chain().focus().toggleBold().run()}>
          <strong>B</strong>
        </button>
        <button onClick={() => editor.chain().focus().toggleItalic().run()}>
          <em>I</em>
        </button>
        <button onClick={() => editor.chain().focus().toggleBulletList().run()}>
          • List
        </button>
        <button onClick={() => editor.chain().focus().toggleOrderedList().run()}>
          1. List
        </button>
      </div>
      <EditorContent
        editor={editor}
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
      />
    </div>
  );
};
```

### Live Preview
```jsx
const ServicePreview = ({ service }) => {
  return (
    <div className="service-preview">
      <h3>Preview</h3>

      {/* Desktop Preview */}
      <div className="desktop-preview">
        <div className="service-card">
          <div className="icon">{service.icon}</div>
          <h4>{service.name || 'Service Name'}</h4>
          <p className="description">
            {service.shortDescription || 'Short description...'}
          </p>
          <p className="price">
            Starting from ₹{service.basePrice || '---'}
          </p>
          {service.rating && (
            <p className="rating">⭐ {service.rating}</p>
          )}
          <button className="book-btn">Book Now</button>
        </div>
      </div>

      {/* Mobile Preview */}
      <div className="mobile-preview">
        <h4>Mobile Preview:</h4>
        <div className="mobile-card">
          <div className="icon">{service.icon}</div>
          <p className="name">{service.name?.substring(0, 20) || 'Service'}</p>
          <p className="price">₹{service.basePrice || '---'}+</p>
        </div>
      </div>
    </div>
  );
};
```

## Key Features

### Auto-save
- Save form data every 30 seconds
- Save on blur for each field
- Show "Saving..." indicator
- Show "Saved" confirmation
- Restore from draft on reload

### Form Validation
```javascript
const validateService = (data) => {
  const errors = {};

  if (!data.name || data.name.length < 3) {
    errors.name = 'Service name must be at least 3 characters';
  }

  if (!data.icon) {
    errors.icon = 'Please select an icon';
  }

  if (!data.categoryId) {
    errors.category = 'Please select a category';
  }

  if (!data.shortDescription || data.shortDescription.length < 20) {
    errors.shortDescription = 'Short description must be at least 20 characters';
  }

  if (!data.fullDescription || data.fullDescription.length < 50) {
    errors.fullDescription = 'Full description must be at least 50 characters';
  }

  if (!data.basePrice || data.basePrice < 0) {
    errors.basePrice = 'Please enter a valid base price';
  }

  if (data.images.length === 0) {
    errors.images = 'Please upload at least one image';
  }

  if (!data.duration || data.duration <= 0) {
    errors.duration = 'Please enter estimated duration';
  }

  if (data.cities.length === 0) {
    errors.cities = 'Please select at least one city';
  }

  return errors;
};
```

### Live Preview
- Update preview as user types
- Show desktop and mobile views
- Reflect all changes in real-time
- Preview images immediately after upload

### Dynamic Pricing
- Enable/disable toggle
- If enabled, base price is "starting from"
- Providers can set their own prices
- Price range validation (max > min)

### Media Management
- Upload up to 6 images
- Drag to reorder images
- First image is primary
- Image compression on upload
- Video URL optional (YouTube/Vimeo embed)

### Inclusion/Exclusion Lists
- Add/remove items dynamically
- Bullet point format
- Clear communication of what's covered
- Important for customer expectations

## Interactions

### Cancel Button
- Warning if unsaved changes
- Confirmation dialog: "Discard changes?"
- Navigate back to Service Catalog

### Save as Draft Button
- Validate required fields
- Save to database with status "draft"
- Success toast: "Saved as draft"
- Remain on page

### Preview Button
- Validate form
- Open service detail page in new tab
- Show preview mode indicator
- Allow testing before publish

### Publish Service Button
- Full validation
- Confirmation dialog: "Publish service?"
- Set status to "active"
- Success message
- Navigate to Service Catalog

### Icon Select
- Click icon to select
- Highlight selected icon
- Update preview immediately

### Image Upload
- Click to open file picker
- Drag & drop support
- Show upload progress
- Auto-compress large images
- Validate format (JPG, PNG, WebP)
- Max file size: 5MB

### Add List Item
- Click "+ Add Item"
- Insert new input field
- Focus on new field
- Remove item with × button

### City Selection
- Checkbox list
- "Select All" / "Select None" shortcuts
- Show selected count
- Group by region (optional)

### Tag Input
- Type and press Enter to add
- Click × to remove
- Auto-suggest popular tags
- Max 10 tags

## States

### Loading State
- Show when loading existing service
- Skeleton loaders for form fields
- Disabled inputs

### Saving State
- "Saving..." indicator
- Disabled submit buttons
- Spinner icon

### Error State
- Red border on invalid fields
- Error message below field
- Scroll to first error
- Focus first error field

### Success State
- Green checkmark icon
- "Service published!" message
- Confetti animation (optional)
- Redirect to catalog after 2 seconds

## Data Loading

```javascript
const AddEditService = ({ serviceId }) => {
  const [service, setService] = useState({
    name: '',
    icon: '🔧',
    categoryId: '',
    shortDescription: '',
    fullDescription: '',
    basePrice: '',
    priceRange: { min: '', max: '' },
    dynamicPricing: true,
    images: [],
    videoUrl: '',
    duration: '',
    durationUnit: 'hours',
    inclusions: [],
    exclusions: [],
    requirements: [],
    cities: [],
    tags: [],
    allowSameDayBooking: true,
    showOnHomepage: false,
    enableQuestions: true,
    requiresVerification: false,
    metaTitle: '',
    metaDescription: ''
  });

  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);
  const [autoSaveTimer, setAutoSaveTimer] = useState(null);

  useEffect(() => {
    if (serviceId) {
      loadService();
    }

    // Set up auto-save
    const timer = setInterval(() => {
      autoSave();
    }, 30000); // 30 seconds

    setAutoSaveTimer(timer);

    return () => clearInterval(timer);
  }, [serviceId]);

  const loadService = async () => {
    try {
      const response = await fetch(`/api/admin/services/${serviceId}`);
      const data = await response.json();
      setService(data);
    } catch (error) {
      showErrorToast('Failed to load service');
    }
  };

  const autoSave = async () => {
    if (!hasChanges()) return;

    try {
      await saveService('draft', false);
      showToast('Auto-saved', 'success', 2000);
    } catch (error) {
      console.error('Auto-save failed');
    }
  };

  const saveService = async (status, showNotification = true) => {
    setSaving(true);

    try {
      const endpoint = serviceId
        ? `/api/admin/services/${serviceId}`
        : '/api/admin/services';

      const response = await fetch(endpoint, {
        method: serviceId ? 'PATCH' : 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...service, status })
      });

      const data = await response.json();

      if (showNotification) {
        showSuccessToast(
          status === 'draft' ? 'Saved as draft' : 'Service published!'
        );
      }

      return data;
    } catch (error) {
      showErrorToast('Failed to save service');
      throw error;
    } finally {
      setSaving(false);
    }
  };

  const handlePublish = async () => {
    const validationErrors = validateService(service);

    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      scrollToFirstError();
      return;
    }

    const confirmed = await showConfirmDialog({
      title: 'Publish Service?',
      message: 'Service will be visible to customers immediately.',
      confirmText: 'Publish',
      cancelText: 'Cancel'
    });

    if (!confirmed) return;

    try {
      await saveService('active');
      setTimeout(() => {
        navigate('/admin/services');
      }, 2000);
    } catch (error) {
      // Error already shown in saveService
    }
  };

  const handleFieldChange = (field, value) => {
    setService(prev => ({ ...prev, [field]: value }));

    // Clear error for this field
    if (errors[field]) {
      setErrors(prev => {
        const newErrors = { ...prev };
        delete newErrors[field];
        return newErrors;
      });
    }
  };
};
```

## Permissions

- **Super Admin**: Full access
- **Admin**: Can create and edit services
- **Support Admin**: View only (no access to this screen)

## Analytics

- `service_form_opened`: Form loaded
- `service_created`: New service created
- `service_updated`: Service edited
- `service_published`: Service activated
- `service_draft_saved`: Draft saved
- `field_validation_error`: Validation error shown
- `image_uploaded`: Image uploaded
- `auto_save_triggered`: Auto-save executed

## API Endpoints

### POST /api/admin/services
```json
{
  "name": "AC Repair & Service",
  "icon": "🔧",
  "categoryId": "CAT_001",
  "shortDescription": "Complete air conditioning repair...",
  "fullDescription": "<p>Detailed description...</p>",
  "basePrice": 499,
  "priceRange": { "min": 499, "max": 799 },
  "dynamicPricing": true,
  "images": ["https://...", "https://..."],
  "videoUrl": "https://youtube.com/...",
  "duration": 1.5,
  "durationUnit": "hours",
  "inclusions": ["AC inspection", "Gas refilling", "Filter cleaning"],
  "exclusions": ["Spare parts cost"],
  "requirements": ["Access to AC unit", "Power supply"],
  "cities": ["delhi", "mumbai", "bangalore"],
  "tags": ["ac", "repair", "cooling", "hvac"],
  "allowSameDayBooking": true,
  "showOnHomepage": false,
  "enableQuestions": true,
  "requiresVerification": false,
  "metaTitle": "AC Repair & Service | UrbanNest",
  "metaDescription": "Professional AC repair...",
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

### POST /api/admin/upload/image
```javascript
// FormData with image file
// Returns: { "url": "https://..." }
```

## Testing Checklist

- ✅ Form loads correctly
- ✅ All fields validate
- ✅ Auto-save works
- ✅ Image upload works
- ✅ Rich text editor works
- ✅ Icon picker works
- ✅ City selection works
- ✅ Tags work
- ✅ Live preview updates
- ✅ Save as draft works
- ✅ Publish works
- ✅ Edit existing service works
- ✅ Cancel with confirmation works
- ✅ Error states display
- ✅ Loading states show

## Navigation Flow

**Entry Points:**
- Service Catalog → Click "Add New Service"
- Service Catalog → Click "Edit" on service

**Exit Points:**
- Cancel button → Service Catalog (with confirmation)
- After publish → Service Catalog
- Back button → Service Catalog (with confirmation if unsaved changes)
