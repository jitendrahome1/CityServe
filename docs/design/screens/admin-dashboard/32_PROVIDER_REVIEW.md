# Provider Application Review (KYC)

## Overview
- **Screen ID**: 32
- **Screen Name**: Provider Application Review & KYC Verification
- **User Role**: Admin, Super Admin
- **Platform**: Web (Desktop)
- **Navigation**: From Pending Approvals List → Click "Review"

## ASCII Wireframe

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│  ←  Provider Applications                          🔍 Search...   👤 Admin  🔔         │
├────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                         │
│  Review Application: Rajesh Kumar (#PRV_001234)                     Status: ⏳ Pending │
│                                                                                         │
│  ┌─────────────────────────────────────────┐  ┌────────────────────────────────────┐  │
│  │ 📋 Basic Information                    │  │ ✅ Verification Checklist          │  │
│  │                                         │  │                                    │  │
│  │ [Photo]  Rajesh Kumar                   │  │ ☑️ Identity verified (Aadhaar)    │  │
│  │          ⭐ New Provider                │  │ ☑️ Tax ID verified (PAN)          │  │
│  │                                         │  │ ☑️ Selfie matches ID              │  │
│  │ 📞 +91 98765 43210                      │  │ ☑️ Address proof valid            │  │
│  │ ✉️ rajesh.kumar@email.com               │  │ ☐ Background check               │  │
│  │ 📍 Delhi                                │  │ ☐ Skills verified                │  │
│  │ 📅 Submitted: 2 hours ago               │  │ ☐ Bank account verified          │  │
│  │                                         │  │                                    │  │
│  │ Services Applied For:                   │  │ Completion: 58% ████░░░           │  │
│  │ • 🔧 Plumbing (5 years exp)             │  │                                    │  │
│  │ • 💡 Electrical (3 years exp)           │  │ ⚠️ 3 items need review            │  │
│  │                                         │  │                                    │  │
│  │ Work Areas:                             │  │ [Mark All Verified]                │  │
│  │ • South Delhi, Central Delhi            │  └────────────────────────────────────┘  │
│  │                                         │                                          │
│  └─────────────────────────────────────────┘  ┌────────────────────────────────────┐  │
│                                                │ 📝 Admin Notes                     │  │
│  ┌─────────────────────────────────────────┐  │                                    │  │
│  │ 🆔 Identity Documents                   │  │ [Text area for internal notes]     │  │
│  │                                         │  │                                    │  │
│  │ Aadhaar Card: ✅ Verified               │  │ Previous notes:                    │  │
│  │ ┌─────────────────────────────────────┐│  │ • Dec 19: Requested clear Aadhaar  │  │
│  │ │ [Aadhaar Card Image]                ││  │          photo - Admin A           │  │
│  │ │                                     ││  │                                    │  │
│  │ │ Name: RAJESH KUMAR                  ││  │ [Add Note]                         │  │
│  │ │ DOB: 15/08/1985                     ││  └────────────────────────────────────┘  │
│  │ │ Aadhaar: XXXX-XXXX-1234 ✓           ││                                          │
│  │ └─────────────────────────────────────┘│  ┌────────────────────────────────────┐  │
│  │                                         │  │ 📊 Risk Assessment                 │  │
│  │ [🔍 View Full Size] [✓ Verify] [✗ Reject]│ │                                    │  │
│  │                                         │  │ Risk Score: LOW ████░░░░░░ 35/100  │  │
│  │ PAN Card: ✅ Verified                   │  │                                    │  │
│  │ ┌─────────────────────────────────────┐│  │ Factors:                           │  │
│  │ │ [PAN Card Image]                    ││  │ ✅ Valid government IDs            │  │
│  │ │                                     ││  │ ✅ Phone number verified           │  │
│  │ │ Name: RAJESH KUMAR                  ││  │ ✅ Email verified                  │  │
│  │ │ PAN: ABCDE1234F ✓                   ││  │ ⚠️ No previous work history        │  │
│  │ │ DOB: 15/08/1985 ✓                   ││  │ ✅ No criminal record              │  │
│  │ └─────────────────────────────────────┘│  │                                    │  │
│  │                                         │  │ Recommendation: APPROVE             │  │
│  │ [🔍 View Full Size] [✓ Verify] [✗ Reject]│ └────────────────────────────────────┘  │
│  │                                         │                                          │
│  │ Selfie with ID: ✅ Verified             │  ┌────────────────────────────────────┐  │
│  │ ┌─────────────────────────────────────┐│  │ 💳 Bank Account Details            │  │
│  │ │ [Selfie Photo]                      ││  │                                    │  │
│  │ │                                     ││  │ Account Name: Rajesh Kumar         │  │
│  │ │ ✓ Face matches Aadhaar              ││  │ Account Number: XXXX-XXXX-4567     │  │
│  │ │ ✓ Holding Aadhaar card              ││  │ IFSC Code: HDFC0001234             │  │
│  │ │ ✓ Photo quality good                ││  │ Bank: HDFC Bank                    │  │
│  │ └─────────────────────────────────────┘│  │ Account Type: Savings              │  │
│  │                                         │  │                                    │  │
│  │ [🔍 View Full Size] [✓ Verify] [✗ Reject]│ │ Status: ⏳ Pending Verification    │  │
│  │                                         │  │                                    │  │
│  │ Address Proof: ⏳ Pending               │  │ [Verify Bank Account]              │  │
│  │ ┌─────────────────────────────────────┐│  └────────────────────────────────────┘  │
│  │ │ [Utility Bill/Passport]             ││                                          │
│  │ │                                     ││                                          │
│  │ │ Type: Electricity Bill              ││                                          │
│  │ │ Date: Nov 2024                      ││                                          │
│  │ │ Address: 123 MG Road, Delhi         ││                                          │
│  │ └─────────────────────────────────────┘│                                          │
│  │                                         │                                          │
│  │ [🔍 View Full Size] [✓ Verify] [✗ Reject]│                                         │
│  └─────────────────────────────────────────┘                                          │
│                                                                                         │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐│
│  │  Decision:                                                                        ││
│  │                                                                                   ││
│  │  [Request More Information]  [Reject Application]  [✅ Approve & Activate]       ││
│  └───────────────────────────────────────────────────────────────────────────────────┘│
│                                                                                         │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

## Layout Specifications

### Page Layout
- **Max Width**: 1440px (centered)
- **Padding**: 32px all sides
- **Column Gap**: 24px
- **Main Content**: 60% width (left column)
- **Sidebar**: 40% width (right column)

### Header Section
- **Height**: 64px
- **Provider Name**: Inter Bold 24px, #1E1E1E
- **Provider ID**: Inter Regular 14px, monospace, #666666
- **Status Badge**: 32px height, pill shape
- **Back Button**: 36x36px icon button

### Basic Information Card
- **Padding**: 24px
- **Background**: White (#FFFFFF)
- **Border Radius**: 12px
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)
- **Avatar**: 80x80px circular
- **Name**: Inter SemiBold 20px
- **Rating**: SF Symbols star, 16px, #FFC107
- **Contact Info**: Inter Regular 14px, #666666
- **Services List**: Bullet points, Inter Medium 14px
- **Experience**: Inter Regular 13px, #999999

### Document Cards
- **Width**: Full width of left column
- **Padding**: 20px
- **Border**: 1px solid #E0E0E0
- **Border Radius**: 8px
- **Document Image**: Max width 100%, max height 400px
- **OCR Extracted Data**: Inter Regular 14px, monospace background
- **Verification Status**:
  - Verified: Green checkmark (#28C76F)
  - Pending: Yellow clock (#FFC107)
  - Rejected: Red cross (#EA5455)

### Document Image Viewer
- **Image**: Responsive, maintain aspect ratio
- **Max Height**: 400px
- **Zoom Controls**: Magnify icon, opens lightbox
- **Buttons**: 36px height, Inter Medium 13px
- **Button Spacing**: 8px gap

### Verification Checklist
- **Padding**: 20px
- **Background**: #F9F9F9
- **Checkbox**: 20x20px, Deep Teal when checked
- **Label**: Inter Regular 14px, #1E1E1E
- **Progress Bar**: 8px height, rounded
- **Alert Badge**: Red (#EA5455) for pending items

### Admin Notes Section
- **Text Area**: Min height 120px
- **Previous Notes**: Timeline style
- **Timestamp**: Inter Regular 12px, #999999
- **Author**: Inter Medium 13px, #666666

### Risk Assessment Card
- **Score Meter**: 200px width, gradient fill
- **Score Value**: Inter Bold 32px
- **Risk Level**: Color-coded (Low: Green, Medium: Yellow, High: Red)
- **Factors List**: Bullet points with icons
- **Recommendation**: Inter SemiBold 16px

### Bank Account Card
- **Masked Numbers**: •••• format
- **Status Badge**: Same as document status
- **Verify Button**: Secondary button style

### Decision Buttons (Bottom)
- **Container Height**: 72px
- **Background**: White with top border
- **Button Height**: 48px
- **Primary Button** (Approve): Deep Teal (#0D7377), white text
- **Secondary Button** (Request Info): Outlined, teal border
- **Destructive Button** (Reject): Red (#EA5455), white text
- **Button Spacing**: 16px gap
- **Padding**: 16px all sides

## Components Used

### Document Viewer
```jsx
const DocumentViewer = ({
  document,
  type,
  verificationStatus,
  extractedData,
  onVerify,
  onReject
}) => {
  const [lightboxOpen, setLightboxOpen] = useState(false);

  return (
    <div className="document-card">
      <div className="document-header">
        <h3>{document.type}</h3>
        <StatusBadge status={verificationStatus} />
      </div>

      <div className="document-image">
        <img
          src={document.url}
          alt={document.type}
          onClick={() => setLightboxOpen(true)}
        />
      </div>

      {extractedData && (
        <div className="extracted-data">
          {Object.entries(extractedData).map(([key, value]) => (
            <DataRow key={key} label={key} value={value} />
          ))}
        </div>
      )}

      <div className="document-actions">
        <button onClick={() => setLightboxOpen(true)}>
          🔍 View Full Size
        </button>
        <button className="verify" onClick={() => onVerify(document.id)}>
          ✓ Verify
        </button>
        <button className="reject" onClick={() => onReject(document.id)}>
          ✗ Reject
        </button>
      </div>

      {lightboxOpen && (
        <Lightbox
          image={document.url}
          onClose={() => setLightboxOpen(false)}
        />
      )}
    </div>
  );
};
```

### Verification Checklist
```jsx
const VerificationChecklist = ({ items, onCheckChange, onMarkAll }) => {
  const completedCount = items.filter(item => item.checked).length;
  const progress = (completedCount / items.length) * 100;

  return (
    <div className="verification-checklist">
      <h3>Verification Checklist</h3>

      {items.map(item => (
        <label key={item.id} className="checklist-item">
          <input
            type="checkbox"
            checked={item.checked}
            onChange={() => onCheckChange(item.id)}
          />
          <span>{item.label}</span>
        </label>
      ))}

      <div className="progress-section">
        <p>Completion: {Math.round(progress)}%</p>
        <div className="progress-bar">
          <div
            className="progress-fill"
            style={{ width: `${progress}%` }}
          />
        </div>
      </div>

      {completedCount < items.length && (
        <p className="alert">
          ⚠️ {items.length - completedCount} items need review
        </p>
      )}

      <button onClick={onMarkAll}>Mark All Verified</button>
    </div>
  );
};
```

### Risk Assessment
```jsx
const RiskAssessment = ({ application }) => {
  const score = calculateRiskScore(application);
  const level = score < 40 ? 'LOW' : score < 70 ? 'MEDIUM' : 'HIGH';
  const color = level === 'LOW' ? '#28C76F' : level === 'MEDIUM' ? '#FFC107' : '#EA5455';

  return (
    <div className="risk-assessment">
      <h3>Risk Assessment</h3>

      <div className="risk-score">
        <div className="score-meter">
          <div
            className="score-fill"
            style={{
              width: `${score}%`,
              backgroundColor: color
            }}
          />
        </div>
        <p className="score-value">{score}/100</p>
        <p className="risk-level" style={{ color }}>
          Risk Score: {level}
        </p>
      </div>

      <div className="risk-factors">
        <h4>Factors:</h4>
        {getRiskFactors(application).map(factor => (
          <RiskFactor key={factor.id} {...factor} />
        ))}
      </div>

      <div className="recommendation">
        <strong>Recommendation:</strong>{' '}
        {level === 'LOW' ? 'APPROVE' : level === 'MEDIUM' ? 'REVIEW FURTHER' : 'REJECT'}
      </div>
    </div>
  );
};

const calculateRiskScore = (application) => {
  let score = 0;

  // Add points for missing/invalid documents
  if (!application.documents.aadhaar?.verified) score += 20;
  if (!application.documents.pan?.verified) score += 20;
  if (!application.documents.selfie?.verified) score += 15;
  if (!application.documents.addressProof?.verified) score += 10;

  // Add points for other risk factors
  if (!application.phone_verified) score += 15;
  if (!application.email_verified) score += 10;
  if (application.criminalRecord) score += 50;

  // Deduct points for positive factors
  if (application.experienceYears > 5) score -= 10;
  if (application.references?.length > 0) score -= 5;

  return Math.max(0, Math.min(100, score));
};
```

## Key Features

### Document Verification Workflow
1. **View Document**: Click to open lightbox, zoom, rotate
2. **OCR Extracted Data**: Auto-populated from uploaded image
3. **Manual Verification**: Admin confirms data matches
4. **Cross-Verification**: Compare Aadhaar name/DOB with PAN
5. **Face Matching**: Selfie vs Aadhaar photo (manual check)
6. **Status Update**: Mark as Verified, Pending, or Rejected

### Auto-Verification Checks
```javascript
const autoVerifyChecks = async (application) => {
  const checks = {
    aadhaarFormat: validateAadhaarFormat(application.aadhaar),
    panFormat: validatePANFormat(application.pan),
    nameMatch: compareNames(
      application.aadhaar.name,
      application.pan.name
    ),
    dobMatch: compareDOB(
      application.aadhaar.dob,
      application.pan.dob
    ),
    phoneVerified: application.phone_verified,
    emailVerified: application.email_verified,
    duplicateCheck: await checkDuplicateProvider(application.aadhaar)
  };

  return checks;
};
```

### Request More Information
- Open modal with template messages
- Select missing/unclear documents
- Add custom message
- Email + in-app notification sent
- Status updated to "Waiting for Info"
- Reminder sent after 48 hours if no response

### Reject Application
- Open modal with rejection reasons:
  - Incomplete documents
  - Invalid/fake documents
  - Failed background check
  - Duplicate account
  - Ineligible for platform
  - Other (custom reason)
- Confirmation dialog
- Send rejection email with reason
- Allow reapplication after 30 days
- Log rejection in admin notes

### Approve & Activate
- Final validation: All checklist items checked
- Confirmation dialog
- Create provider account
- Generate provider ID
- Send welcome email with credentials
- Schedule onboarding call
- Activate in system
- Send first available jobs

## Interactions

### Document Image Click
- Open lightbox modal
- Full-screen image view
- Zoom in/out controls
- Pan/drag to move
- Rotate buttons
- Download original
- Close with ESC or X button

### Verify Button Click
- Mark document as verified
- Update checklist
- Enable approve button if all verified
- Success toast: "Document verified"

### Reject Document
- Open reject reason modal
- Select reason or enter custom
- Update document status to rejected
- Add to admin notes
- Notify provider via email

### Checklist Item Toggle
- Check/uncheck item
- Update progress bar
- Enable/disable approve button
- Auto-save state

### Mark All Verified
- Confirmation dialog
- Check all checklist items
- Update all document statuses
- Enable approve button

### Add Admin Note
- Text area input
- Max 500 characters
- Auto-save on blur
- Show in timeline with timestamp + admin name

### Verify Bank Account
- Open bank verification modal
- Options:
  - Manual verification (admin confirms)
  - Penny drop verification (auto via Razorpay)
  - Skip for now (mark pending)
- Update status
- Success confirmation

### Approve & Activate Click
- Validate all items checked
- Show confirmation modal:
  - Summary of provider
  - Services approved
  - Work areas
  - "Activate provider?" message
- On confirm:
  - Create account
  - Send welcome email
  - Show success screen
  - Navigate back to pending list

### Request More Information Click
- Open request modal
- Template messages:
  - "Please upload a clearer Aadhaar photo"
  - "PAN card image is unclear"
  - "Selfie doesn't match ID"
  - "Missing address proof"
  - Custom message
- Select recipient (email + SMS)
- Send notification
- Update status to "Waiting for Info"
- Set reminder for 48 hours

### Reject Application Click
- Open rejection modal
- Select reason from dropdown
- Add custom message (optional)
- Preview rejection email
- Confirmation: "Reject application?"
- On confirm:
  - Update status to rejected
  - Send email
  - Log in system
  - Navigate back to list

## Data Loading

```javascript
const ProviderReview = ({ providerId }) => {
  const [application, setApplication] = useState(null);
  const [loading, setLoading] = useState(true);
  const [verificationChecklist, setChecklist] = useState([]);
  const [adminNotes, setAdminNotes] = useState([]);

  useEffect(() => {
    loadApplication();

    // Real-time updates if provider uploads new docs
    const unsubscribe = firestore
      .collection('provider_applications')
      .doc(providerId)
      .onSnapshot(snapshot => {
        if (snapshot.exists) {
          setApplication(snapshot.data());
          showToast('Application updated by provider');
        }
      });

    return () => unsubscribe();
  }, [providerId]);

  const loadApplication = async () => {
    try {
      const response = await fetch(`/api/admin/providers/${providerId}`);
      const data = await response.json();

      setApplication(data.application);
      setChecklist(generateChecklist(data.application));
      setAdminNotes(data.notes);

      // Auto-run verification checks
      const autoChecks = await runAutoVerification(data.application);
      updateChecklistWithAutoChecks(autoChecks);
    } catch (error) {
      showErrorToast('Failed to load application');
    } finally {
      setLoading(false);
    }
  };

  const handleApprove = async () => {
    const confirmed = await showConfirmDialog({
      title: 'Approve Provider?',
      message: `Activate ${application.name} as a service provider?`,
      confirmText: 'Approve & Activate',
      cancelText: 'Cancel'
    });

    if (!confirmed) return;

    try {
      await fetch(`/api/admin/providers/${providerId}/approve`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          services: application.services,
          workAreas: application.workAreas,
          bankAccount: application.bankAccount
        })
      });

      showSuccessToast('Provider approved and activated!');
      navigate('/admin/providers/pending');
    } catch (error) {
      showErrorToast('Failed to approve provider');
    }
  };
};
```

## Validation Rules

### Aadhaar Card
- **Format**: 12 digits (XXXX-XXXX-XXXX)
- **Name**: Must match PAN name (fuzzy match, 85% similarity)
- **Age**: Provider must be 18+ years old
- **Image Quality**: Minimum 800x600px, readable text
- **Valid**: Not expired (no expiry on Aadhaar, but check issue date)

### PAN Card
- **Format**: ABCDE1234F (5 letters + 4 digits + 1 letter)
- **Name**: Must match Aadhaar name
- **DOB**: Must match Aadhaar DOB (or within 1 day tolerance)
- **Image Quality**: Minimum 800x600px

### Selfie with ID
- **Face Detected**: Must have one clear face
- **ID Visible**: Aadhaar card must be clearly visible
- **Face Match**: Visual similarity to Aadhaar photo
- **No Blur**: Image quality check
- **Recent**: Not older than 7 days

### Address Proof
- **Accepted Types**: Utility bill, bank statement, passport, rent agreement
- **Date**: Must be within last 3 months
- **Name**: Must match provider name
- **Address**: Complete with city, state, PIN

### Bank Account
- **Account Number**: 9-18 digits
- **IFSC Code**: Valid format (XXXX0XXXXXX)
- **Name**: Must match provider name
- **Verification**: Penny drop or manual confirmation

## Permissions

- **Super Admin**: Full access, can approve/reject
- **Admin**: Can review, approve (max ₹50k/month providers)
- **Support Admin**: View only, cannot approve

## Analytics

- `provider_review_opened`: Review screen loaded
- `document_verified`: Document marked as verified
- `document_rejected`: Document marked as rejected
- `checklist_completed`: All items checked
- `bank_verified`: Bank account verified
- `provider_approved`: Provider approved
- `provider_rejected`: Provider rejected
- `info_requested`: More info requested from provider
- `note_added`: Admin note added
- `time_to_review`: Duration spent on review

## API Endpoints

### GET /api/admin/providers/:providerId
```json
{
  "application": {
    "id": "PRV_001234",
    "name": "Rajesh Kumar",
    "phone": "+919876543210",
    "email": "rajesh@example.com",
    "photoUrl": "https://...",
    "city": "Delhi",
    "services": [
      { "id": "plumbing", "experienceYears": 5 },
      { "id": "electrical", "experienceYears": 3 }
    ],
    "workAreas": ["South Delhi", "Central Delhi"],
    "documents": {
      "aadhaar": {
        "url": "https://...",
        "status": "verified",
        "extractedData": {
          "name": "RAJESH KUMAR",
          "dob": "15/08/1985",
          "number": "XXXX-XXXX-1234"
        }
      },
      "pan": { /* similar structure */ },
      "selfie": { /* similar structure */ },
      "addressProof": { /* similar structure */ }
    },
    "bankAccount": {
      "accountNumber": "XXXX-XXXX-4567",
      "ifsc": "HDFC0001234",
      "accountName": "Rajesh Kumar",
      "verified": false
    },
    "submittedAt": "2024-12-20T10:00:00Z",
    "status": "pending"
  },
  "notes": [
    {
      "id": "note_1",
      "text": "Requested clear Aadhaar photo",
      "author": "Admin A",
      "timestamp": "2024-12-19T15:30:00Z"
    }
  ]
}
```

### POST /api/admin/providers/:providerId/approve
```json
{
  "services": ["plumbing", "electrical"],
  "workAreas": ["South Delhi", "Central Delhi"],
  "bankAccount": { /* bank details */ }
}
```

### POST /api/admin/providers/:providerId/reject
```json
{
  "reason": "incomplete_documents",
  "customMessage": "Aadhaar card image is unclear",
  "allowReapply": true,
  "reapplyAfterDays": 30
}
```

### POST /api/admin/providers/:providerId/request-info
```json
{
  "missingItems": ["aadhaar", "address_proof"],
  "message": "Please upload clearer documents",
  "reminderAfterHours": 48
}
```

## Testing Checklist

- ✅ All documents load correctly
- ✅ OCR extracted data displays
- ✅ Document verification works
- ✅ Checklist updates correctly
- ✅ Progress bar accurate
- ✅ Admin notes save
- ✅ Risk assessment calculates
- ✅ Bank verification works
- ✅ Approve flow works
- ✅ Reject flow works
- ✅ Request info flow works
- ✅ Real-time updates work
- ✅ Lightbox opens/closes
- ✅ Image zoom works
- ✅ Validation rules enforce

## Navigation Flow

**Entry Point:**
- Pending Approvals List → Click "Review" button

**Exit Points:**
- Back button → Pending Approvals List
- After approve → Success screen → Pending Approvals List
- After reject → Pending Approvals List
- Sidebar click → Other admin sections
