# Booking Detail (Admin View)

## Overview
- **Screen ID**: 34
- **Screen Name**: Booking Detail - Admin Management
- **User Role**: Admin, Super Admin, Support Admin
- **Platform**: Web (Desktop)
- **Navigation**: From All Bookings Dashboard → Click "View"

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  ←  All Bookings                                🔍 Search...        👤 Admin  🔔        │
├────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                         │
│  Booking Details: #BK789012                                      Status: 🟢 In Progress│
│                                                                                         │
│  ┌─────────────────────────────────────────┐  ┌────────────────────────────────────┐  │
│  │ 📋 Booking Information                  │  │ ⚡ Quick Actions                    │  │
│  │                                         │  │                                    │  │
│  │ Service: 🔧 AC Repair & Service         │  │ [Update Status]                    │  │
│  │ Booking ID: #BK789012                   │  │ [Reassign Provider]                │  │
│  │ Booking Date: Dec 20, 2024              │  │ [Contact Customer]                 │  │
│  │ Time Slot: 2:00 PM - 3:30 PM            │  │ [Contact Provider]                 │  │
│  │ Amount: ₹650                            │  │ [Process Refund]                   │  │
│  │ Payment: Paid (Razorpay)                │  │ [Cancel Booking]                   │  │
│  │                                         │  │                                    │  │
│  │ Created: Dec 19, 2024 at 3:45 PM        │  │ ⚠️ [Resolve Dispute]               │  │
│  │ Last Updated: Dec 20, 2024 at 2:45 PM   │  └────────────────────────────────────┘  │
│  └─────────────────────────────────────────┘                                          │
│                                                ┌────────────────────────────────────┐  │
│  ┌─────────────────────────────────────────┐  │ 📊 Booking Timeline                │  │
│  │ 👤 Customer Details                     │  │                                    │  │
│  │                                         │  │ ✅ Booking created                 │  │
│  │ [Photo] Amit Kumar                      │  │    Dec 19, 3:45 PM                 │  │
│  │         ⭐ 4.5 (28 bookings)            │  │                                    │  │
│  │         Member since: Jan 2024          │  │ ✅ Payment received                │  │
│  │                                         │  │    Dec 19, 3:46 PM                 │  │
│  │ 📞 +91 98765 43210                      │  │    ₹650 via Razorpay               │  │
│  │ ✉️ amit.kumar@email.com                 │  │                                    │  │
│  │ 📍 123 MG Road, HSR Layout              │  │ ✅ Provider accepted               │  │
│  │    Bangalore - 560034                   │  │    Dec 19, 4:15 PM                 │  │
│  │    [View on Map]                        │  │    Rajesh Kumar                    │  │
│  │                                         │  │                                    │  │
│  │ Previous Bookings: 28                   │  │ ✅ Job started                     │  │
│  │ Avg Rating Given: 4.6                   │  │    Dec 20, 2:00 PM                 │  │
│  │ Total Spent: ₹18,450                    │  │    Provider arrived on time        │  │
│  │                                         │  │                                    │  │
│  │ [View Customer Profile]                 │  │ 🔵 In Progress                     │  │
│  │ [Message Customer]                      │  │    Started 45 minutes ago          │  │
│  └─────────────────────────────────────────┘  │    Timer: 00:45:23                 │  │
│                                                │                                    │  │
│  ┌─────────────────────────────────────────┐  │ [View Full Timeline]               │  │
│  │ 🔧 Provider Details                     │  └────────────────────────────────────┘  │
│  │                                         │                                          │
│  │ [Photo] Rajesh Kumar                    │  ┌────────────────────────────────────┐  │
│  │         ⭐ 4.8 (156 jobs)               │  │ 💰 Payment Details                 │  │
│  │         Verified Provider               │  │                                    │  │
│  │                                         │  │ Service Charge:        ₹550        │  │
│  │ 📞 +91 98765 43210                      │  │ Tax (18%):             ₹99         │  │
│  │ ✉️ rajesh@email.com                     │  │ Platform Fee:          ₹1          │  │
│  │ Services: Plumbing, Electrical, AC      │  │ ──────────────────────────         │  │
│  │ Work Areas: South Delhi, Central Delhi  │  │ Total Paid:            ₹650        │  │
│  │                                         │  │                                    │  │
│  │ This Month:                             │  │ Provider Earnings:     ₹467 (85%)  │  │
│  │ • Jobs: 32                              │  │ Platform Earnings:     ₹83 (15%)   │  │
│  │ • Earnings: ₹24,500                     │  │                                    │  │
│  │ • Rating: 4.8                           │  │ Payment Method: Razorpay (Online)  │  │
│  │                                         │  │ Transaction ID: pay_abc123xyz      │  │
│  │ [View Provider Profile]                 │  │ Status: ✅ Settled                 │  │
│  │ [Message Provider]                      │  │                                    │  │
│  └─────────────────────────────────────────┘  │ [View Receipt] [Process Refund]    │  │
│                                                └────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────┐                                          │
│  │ 📝 Service Notes & Updates              │  ┌────────────────────────────────────┐  │
│  │                                         │  │ 📸 Service Photos                  │  │
│  │ Provider Updates:                       │  │                                    │  │
│  │ • 2:05 PM - Arrived at location         │  │ [Photo 1] [Photo 2] [Photo 3]      │  │
│  │ • 2:10 PM - Started diagnosis           │  │                                    │  │
│  │   Issue: Low gas, compressor OK         │  │ Before: [Photo]                    │  │
│  │ • 2:30 PM - Gas refilling in progress   │  │ During: [Photo]                    │  │
│  │                                         │  │ After: [Photo]                     │  │
│  │ Customer Notes:                         │  │                                    │  │
│  │ "Please carry gas cylinder. Parking     │  │ [View All Photos]                  │  │
│  │ available in basement."                 │  └────────────────────────────────────┘  │
│  │                                         │                                          │
│  │ Admin Notes (Internal):                 │  ┌────────────────────────────────────┐  │
│  │ Dec 19, 4:00 PM - Admin A               │  │ ⚠️ Disputes & Issues               │  │
│  │ "Verified payment received"             │  │                                    │  │
│  │                                         │  │ No active disputes                 │  │
│  │ [Add Admin Note]                        │  │                                    │  │
│  └─────────────────────────────────────────┘  │ [Report Issue] [View History]      │  │
│                                                └────────────────────────────────────┘  │
│                                                                                         │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐│
│  │  Admin Actions:                                                                   ││
│  │  [Update Status]  [Reassign Provider]  [Process Refund]  [Cancel Booking]        ││
│  └───────────────────────────────────────────────────────────────────────────────────┘│
│                                                                                         │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Page Layout
- **Max Width**: 1600px (centered)
- **Padding**: 32px
- **Grid**: 2 columns (60% left / 40% right)
- **Gap**: 24px

### Header Section
- **Height**: 64px
- **Booking ID**: Inter Bold 24px, #1E1E1E
- **Status Badge**: 36px height, colored background
- **Back Button**: 36x36px

### Information Cards
- **Padding**: 24px
- **Background**: White (#FFFFFF)
- **Border Radius**: 12px
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)
- **Section Title**: Inter SemiBold 18px, #1E1E1E
- **Label**: Inter Medium 13px, #666666
- **Value**: Inter Regular 14px, #1E1E1E

### Customer/Provider Cards
- **Avatar**: 72x72px circular
- **Name**: Inter SemiBold 18px
- **Rating**: Star icon + count
- **Badge** (Member since, Verified): Pill style
- **Contact Info**: Inter Regular 14px, monospace for phone
- **Stats**: Grid layout, icon + value + label

### Quick Actions Panel
- **Button Height**: 40px
- **Button Width**: Full width
- **Button Spacing**: 8px gap
- **Primary Actions**: Deep Teal (#0D7377)
- **Secondary Actions**: Outlined
- **Warning Actions**: Red (#EA5455)
- **Icon + Text**: 16px icon, Inter Medium 14px

### Timeline Section
- **Padding**: 20px
- **Item Spacing**: 16px vertical gap
- **Checkmark Icon**: 20x20px, green
- **Clock Icon**: 20x20px, blue for active
- **Time**: Inter Regular 13px, #666666
- **Description**: Inter Regular 14px, #1E1E1E
- **Border Left**: 2px solid #E0E0E0 (connecting line)

### Payment Details Card
- **Row Height**: 32px
- **Label**: Inter Regular 14px, #666666
- **Amount**: Inter SemiBold 16px, #1E1E1E
- **Divider**: 1px solid #E0E0E0
- **Total**: Inter Bold 20px, #0D7377
- **Transaction ID**: Inter Regular 12px, monospace

### Service Photos Gallery
- **Thumbnail Size**: 100x100px
- **Grid**: 3 columns
- **Gap**: 8px
- **Border Radius**: 8px
- **Hover**: Scale 1.05, shadow
- **Lightbox**: Full-screen modal

## Components Used

### Status Update Modal
```jsx
const UpdateStatusModal = ({ booking, onUpdate, onClose }) => {
  const [newStatus, setNewStatus] = useState(booking.status);
  const [notes, setNotes] = useState('');

  const statusOptions = [
    { value: 'pending', label: 'Pending', color: '#999999' },
    { value: 'confirmed', label: 'Confirmed', color: '#00CFE8' },
    { value: 'in_progress', label: 'In Progress', color: '#28C76F' },
    { value: 'completed', label: 'Completed', color: '#999999' },
    { value: 'cancelled', label: 'Cancelled', color: '#EA5455' }
  ];

  const handleSubmit = async () => {
    await onUpdate({
      bookingId: booking.id,
      status: newStatus,
      notes
    });
    onClose();
  };

  return (
    <Modal title="Update Booking Status" onClose={onClose}>
      <div className="status-selector">
        <label>New Status</label>
        <select value={newStatus} onChange={e => setNewStatus(e.target.value)}>
          {statusOptions.map(option => (
            <option key={option.value} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      </div>

      <div className="notes-section">
        <label>Notes (optional)</label>
        <textarea
          value={notes}
          onChange={e => setNotes(e.target.value)}
          placeholder="Add notes about this status change..."
          rows={4}
        />
      </div>

      <div className="modal-actions">
        <button className="cancel" onClick={onClose}>Cancel</button>
        <button className="confirm" onClick={handleSubmit}>Update Status</button>
      </div>
    </Modal>
  );
};
```

### Reassign Provider Modal
```jsx
const ReassignProviderModal = ({ booking, onReassign, onClose }) => {
  const [providers, setProviders] = useState([]);
  const [selectedProvider, setSelectedProvider] = useState(null);
  const [reason, setReason] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadAvailableProviders();
  }, []);

  const loadAvailableProviders = async () => {
    try {
      const response = await fetch(`/api/admin/providers/available?service=${booking.service}&city=${booking.customer.city}`);
      const data = await response.json();
      setProviders(data.providers);
    } catch (error) {
      showErrorToast('Failed to load providers');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Modal title="Reassign Provider" onClose={onClose}>
      {loading ? (
        <LoadingSpinner />
      ) : (
        <>
          <div className="current-provider">
            <p>Current Provider: <strong>{booking.provider.name}</strong></p>
            <p>Rating: ⭐ {booking.provider.rating}</p>
          </div>

          <div className="provider-list">
            <label>Select New Provider</label>
            {providers.map(provider => (
              <div
                key={provider.id}
                className={`provider-option ${selectedProvider?.id === provider.id ? 'selected' : ''}`}
                onClick={() => setSelectedProvider(provider)}
              >
                <img src={provider.photoUrl} alt={provider.name} />
                <div className="info">
                  <h4>{provider.name}</h4>
                  <p>⭐ {provider.rating} • {provider.completedJobs} jobs</p>
                  <p>{provider.distance} km away</p>
                </div>
              </div>
            ))}
          </div>

          <div className="reason-section">
            <label>Reason for Reassignment</label>
            <select value={reason} onChange={e => setReason(e.target.value)}>
              <option value="">Select reason...</option>
              <option value="provider_unavailable">Provider Unavailable</option>
              <option value="customer_request">Customer Request</option>
              <option value="quality_issue">Quality Issue</option>
              <option value="other">Other</option>
            </select>
          </div>

          <div className="modal-actions">
            <button className="cancel" onClick={onClose}>Cancel</button>
            <button
              className="confirm"
              onClick={() => onReassign(selectedProvider, reason)}
              disabled={!selectedProvider || !reason}
            >
              Reassign Provider
            </button>
          </div>
        </>
      )}
    </Modal>
  );
};
```

### Process Refund Modal
```jsx
const ProcessRefundModal = ({ booking, onProcess, onClose }) => {
  const [refundAmount, setRefundAmount] = useState(booking.amount);
  const [refundReason, setRefundReason] = useState('');
  const [customReason, setCustomReason] = useState('');

  const refundReasons = [
    'Service not provided',
    'Quality issues',
    'Customer cancellation',
    'Provider no-show',
    'Duplicate booking',
    'Other'
  ];

  const maxRefund = booking.amount;

  return (
    <Modal title="Process Refund" onClose={onClose}>
      <div className="refund-info">
        <p><strong>Original Amount:</strong> ₹{booking.amount}</p>
        <p><strong>Refundable Amount:</strong> ₹{maxRefund}</p>
        <p><strong>Payment Method:</strong> {booking.paymentMethod}</p>
      </div>

      <div className="refund-amount">
        <label>Refund Amount</label>
        <input
          type="number"
          value={refundAmount}
          onChange={e => setRefundAmount(Math.min(e.target.value, maxRefund))}
          max={maxRefund}
          min={0}
        />
        <p className="note">Maximum refundable: ₹{maxRefund}</p>
      </div>

      <div className="refund-reason">
        <label>Reason for Refund</label>
        <select value={refundReason} onChange={e => setRefundReason(e.target.value)}>
          <option value="">Select reason...</option>
          {refundReasons.map(reason => (
            <option key={reason} value={reason}>{reason}</option>
          ))}
        </select>
      </div>

      {refundReason === 'Other' && (
        <div className="custom-reason">
          <label>Please specify</label>
          <textarea
            value={customReason}
            onChange={e => setCustomReason(e.target.value)}
            placeholder="Enter custom reason..."
            rows={3}
          />
        </div>
      )}

      <div className="refund-warning">
        ⚠️ Refund will be processed immediately and cannot be reversed.
      </div>

      <div className="modal-actions">
        <button className="cancel" onClick={onClose}>Cancel</button>
        <button
          className="confirm danger"
          onClick={() => onProcess({ amount: refundAmount, reason: refundReason || customReason })}
          disabled={!refundAmount || !refundReason}
        >
          Process Refund
        </button>
      </div>
    </Modal>
  );
};
```

### Timeline Component
```jsx
const BookingTimeline = ({ events }) => {
  return (
    <div className="booking-timeline">
      {events.map((event, index) => (
        <div key={index} className="timeline-item">
          <div className={`timeline-icon ${event.type}`}>
            {getEventIcon(event.type)}
          </div>
          <div className="timeline-content">
            <p className="timeline-title">{event.title}</p>
            <p className="timeline-time">{formatTimestamp(event.timestamp)}</p>
            {event.description && (
              <p className="timeline-description">{event.description}</p>
            )}
            {event.metadata && (
              <div className="timeline-metadata">
                {Object.entries(event.metadata).map(([key, value]) => (
                  <span key={key}>{key}: {value}</span>
                ))}
              </div>
            )}
          </div>
        </div>
      ))}
    </div>
  );
};
```

## Key Features

### Real-time Updates
```javascript
useEffect(() => {
  const unsubscribe = firestore
    .collection('bookings')
    .doc(bookingId)
    .onSnapshot(snapshot => {
      if (snapshot.exists) {
        setBooking(snapshot.data());

        // Show toast for important updates
        if (snapshot.data().status !== booking?.status) {
          showToast(`Status changed to ${snapshot.data().status}`);
        }
      }
    });

  return () => unsubscribe();
}, [bookingId]);
```

### Update Status
- Select new status from dropdown
- Add optional notes
- Confirmation dialog
- Update database
- Send notification to customer and provider
- Add entry to timeline
- Update analytics

### Reassign Provider
- Search available providers by service + location
- Show provider ratings, distance, availability
- Select reassignment reason
- Notify current provider (cancellation)
- Notify new provider (new assignment)
- Update booking record
- Refund/adjust payments if needed

### Process Refund
- Calculate refundable amount
- Select refund reason
- Initiate Razorpay refund
- Update payment status
- Send confirmation to customer
- Log in timeline
- Update analytics

### Cancel Booking
- Select cancellation reason
- Determine refund policy (based on time remaining)
- Calculate refund amount
- Process refund if applicable
- Notify customer and provider
- Update status to cancelled
- Release provider availability

### Contact Customer/Provider
- Click to call: Initiate phone call
- Message: Open messaging interface
- Email: Open email client with template
- SMS: Send SMS via service
- Log all communications

### Resolve Dispute
- View dispute details
- Add resolution notes
- Select resolution type (refund, redo service, compensation)
- Process actions (refund, reschedule)
- Close dispute
- Notify parties
- Update ratings if needed

## Interactions

### Update Status Button
- Open status update modal
- Select new status
- Add notes
- Confirm
- Show success toast

### Reassign Provider Button
- Open reassign modal
- Load available providers
- Select provider
- Select reason
- Confirm reassignment
- Success message

### Process Refund Button
- Check refund eligibility
- Open refund modal
- Enter amount and reason
- Confirm refund
- Process via Razorpay
- Success confirmation

### Cancel Booking Button
- Warning dialog
- Select cancellation reason
- Calculate refund
- Confirm cancellation
- Process refund if applicable
- Success message

### Contact Buttons
- **Call Customer**: Initiate call, log communication
- **Call Provider**: Initiate call, log communication
- **Message**: Open messaging panel
- **Email**: Open email client

### View Map Button
- Open Google Maps in new tab
- Show customer address location
- Show provider current location (if job active)

### View Timeline Button
- Expand full timeline modal
- Show all events chronologically
- Export timeline as PDF

### View Photos
- Click photo → Open lightbox
- Navigation arrows
- Zoom controls
- Download option
- Close with ESC

### Add Admin Note
- Text area input
- Auto-save on blur
- Show in timeline
- Timestamp + admin name

## States

### Loading State
- Skeleton loaders for cards
- Disabled buttons
- Loading spinner

### Error State
- Error message: "Failed to load booking"
- Retry button
- Back to list button

### Booking Statuses
- **Pending**: Gray, waiting for provider
- **Confirmed**: Blue, provider accepted
- **In Progress**: Green, service ongoing
- **Completed**: Gray, service finished
- **Cancelled**: Red, booking cancelled
- **Disputed**: Orange, active dispute

## Data Loading

```javascript
const BookingDetail = ({ bookingId }) => {
  const [booking, setBooking] = useState(null);
  const [timeline, setTimeline] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadBooking();

    // Real-time updates
    const unsubscribe = subscribeToBookingUpdates(bookingId, (updated) => {
      setBooking(updated);
      loadTimeline();
    });

    return () => unsubscribe();
  }, [bookingId]);

  const loadBooking = async () => {
    try {
      const [bookingData, timelineData] = await Promise.all([
        fetch(`/api/admin/bookings/${bookingId}`).then(r => r.json()),
        fetch(`/api/admin/bookings/${bookingId}/timeline`).then(r => r.json())
      ]);

      setBooking(bookingData);
      setTimeline(timelineData);
    } catch (error) {
      showErrorToast('Failed to load booking');
    } finally {
      setLoading(false);
    }
  };

  const handleUpdateStatus = async (data) => {
    try {
      await fetch(`/api/admin/bookings/${bookingId}/status`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      });

      showSuccessToast('Status updated successfully');
      loadBooking();
    } catch (error) {
      showErrorToast('Failed to update status');
    }
  };

  const handleReassignProvider = async (provider, reason) => {
    try {
      await fetch(`/api/admin/bookings/${bookingId}/reassign`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          newProviderId: provider.id,
          reason
        })
      });

      showSuccessToast(`Provider reassigned to ${provider.name}`);
      loadBooking();
    } catch (error) {
      showErrorToast('Failed to reassign provider');
    }
  };

  const handleProcessRefund = async (refundData) => {
    try {
      await fetch(`/api/admin/bookings/${bookingId}/refund`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(refundData)
      });

      showSuccessToast('Refund processed successfully');
      loadBooking();
    } catch (error) {
      showErrorToast('Failed to process refund');
    }
  };
};
```

## Permissions

- **Super Admin**: Full access to all actions
- **Admin**: Can update status, reassign, process refunds up to ₹5,000
- **Support Admin**: View only, can add notes and contact parties

## Analytics

- `booking_detail_viewed`: Page loaded
- `status_updated`: Status changed
- `provider_reassigned`: Provider changed
- `refund_processed`: Refund issued
- `booking_cancelled`: Booking cancelled
- `customer_contacted`: Contact initiated
- `provider_contacted`: Contact initiated
- `dispute_resolved`: Dispute closed
- `note_added`: Admin note added

## API Endpoints

### GET /api/admin/bookings/:bookingId
```json
{
  "id": "BK789012",
  "service": "AC Repair & Service",
  "amount": 650,
  "status": "in_progress",
  "createdAt": "2024-12-19T15:45:00Z",
  "updatedAt": "2024-12-20T14:45:00Z",
  "customer": { /* full customer details */ },
  "provider": { /* full provider details */ },
  "payment": {
    "transactionId": "pay_abc123xyz",
    "method": "razorpay",
    "status": "settled",
    "breakdown": { /* payment breakdown */ }
  },
  "timeline": [ /* timeline events */ ],
  "photos": [ /* service photos */ ],
  "notes": [ /* admin notes */ ],
  "dispute": null
}
```

### PATCH /api/admin/bookings/:bookingId/status
```json
{
  "status": "completed",
  "notes": "Service completed as per customer satisfaction"
}
```

### POST /api/admin/bookings/:bookingId/reassign
```json
{
  "newProviderId": "PRV_456",
  "reason": "provider_unavailable"
}
```

### POST /api/admin/bookings/:bookingId/refund
```json
{
  "amount": 650,
  "reason": "Service not provided",
  "customReason": "Provider did not show up"
}
```

## Testing Checklist

- ✅ Booking details load
- ✅ Real-time updates work
- ✅ Status update works
- ✅ Reassign provider works
- ✅ Refund processing works
- ✅ Cancellation works
- ✅ Contact buttons work
- ✅ Timeline displays correctly
- ✅ Photos display and lightbox works
- ✅ Admin notes save
- ✅ Permissions enforced
- ✅ Error handling works

## Navigation Flow

**Entry Point:**
- All Bookings Dashboard → Click "View"

**Exit Points:**
- Back button → All Bookings Dashboard
- View Customer Profile → Customer detail page
- View Provider Profile → Provider detail page
- Sidebar → Other admin sections
