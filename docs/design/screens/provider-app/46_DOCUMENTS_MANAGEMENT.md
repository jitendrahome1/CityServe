# Screen 46: Documents Management

## Overview

- **Screen ID**: 46
- **Screen Name**: Documents Management
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 23 (Provider Dashboard) → Tap "Documents" card
  - From: Screen 48 (Provider App Settings) → Tap "Documents & KYC"
  - From: Notification → "Document Expiring Soon" → Navigate to Documents

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Documents & KYC              ⓘ      │ Header
├─────────────────────────────────────────┤
│                                         │
│  Verification Status                    │
│  ┌────────────────────────────────┐    │
│  │ ✅ All Documents Verified       │    │ Status Banner
│  │                                 │    │
│  │ Account Status: Approved        │    │
│  │ Last Updated: Dec 25, 2025      │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Identity Documents ─────         │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🆔 Aadhaar Card           ✅    │    │ Document Card
│  │                                 │    │ (Verified)
│  │ Status: Verified                │    │
│  │ Number: ••••-••••-5678          │    │
│  │ Verified on: Dec 1, 2025        │    │
│  │                                 │    │
│  │ [View]  [Update]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🏦 PAN Card                ✅    │    │
│  │                                 │    │
│  │ Status: Verified                │    │
│  │ Number: ••••••••90X             │    │
│  │ Name: JOHN DOE                  │    │
│  │ Verified on: Dec 1, 2025        │    │
│  │                                 │    │
│  │ [View]  [Update]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Professional Documents ─────     │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 📜 Electrician License     ⚠️   │    │ Document Card
│  │                                 │    │ (Expiring Soon)
│  │ Status: Expiring Soon           │    │
│  │ Issued: Jan 10, 2020            │    │
│  │ Expires: Jan 10, 2026           │    │
│  │ 11 days remaining               │    │
│  │                                 │    │
│  │ [Renew Now]  [View]             │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 📄 Safety Certificate      ⏳   │    │ Document Card
│  │                                 │    │ (Pending)
│  │ Status: Under Review            │    │
│  │ Uploaded: Dec 28, 2025          │    │
│  │                                 │    │
│  │ ⏳ Verification in progress...   │    │
│  │ Usually takes 1-2 business days │    │
│  │                                 │    │
│  │ [View]  [Cancel Upload]         │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ + Add New Certification         │    │ Add Button
│  └────────────────────────────────┘    │
│                                         │
│  ───── Bank Documents ─────             │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🏦 Bank Statement          ✅    │    │
│  │                                 │    │
│  │ Status: Verified                │    │
│  │ Bank: HDFC Bank                 │    │
│  │ Account: ••••5678               │    │
│  │ Uploaded: Nov 15, 2025          │    │
│  │                                 │    │
│  │ [View]  [Update]                │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Police Verification ─────        │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 👮 Police Verification     ✅    │    │
│  │                                 │    │
│  │ Status: Clear                   │    │
│  │ Verified on: Nov 20, 2025       │    │
│  │ Valid until: Nov 20, 2026       │    │
│  │                                 │    │
│  │ [View]                          │    │
│  └────────────────────────────────┘    │
│                                         │
└─────────────────────────────────────────┘

UPLOAD DOCUMENT MODAL:

┌─────────────────────────────────────────┐
│         Upload Document            ✕    │
├─────────────────────────────────────────┤
│                                         │
│  Document Type *                        │
│  ┌────────────────────────────────┐    │
│  │ Electrician License ▼           │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  Document Number                        │
│  ┌────────────────────────────────┐    │
│  │ EL123456789                     │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Issuing Authority                      │
│  ┌────────────────────────────────┐    │
│  │ Indian Electrical Engineers     │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Issue Date                             │
│  ┌────────────────────────────────┐    │
│  │ 10 Jan 2020              📅     │    │ Date Picker
│  └────────────────────────────────┘    │
│                                         │
│  Expiry Date                            │
│  ┌────────────────────────────────┐    │
│  │ 10 Jan 2026              📅     │    │ Date Picker
│  └────────────────────────────────┘    │
│                                         │
│  Upload Document File *                 │
│  ┌────────────────────────────────┐    │
│  │         [No file chosen]        │    │ File Picker
│  │      [Browse Files]             │    │
│  └────────────────────────────────┘    │
│                                         │
│  Supported: PDF, JPG, PNG               │
│  Max size: 5MB per file                 │
│                                         │
│  Requirements:                          │
│  • Clear, readable scan                 │
│  • All corners visible                  │
│  • No watermarks or edits               │
│  • Original document preferred          │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Upload Document             │   │ Primary Button
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘

DOCUMENT VERIFICATION STATUS:

┌─────────────────────────────────────────┐
│      Verification Status           ✕    │
├─────────────────────────────────────────┤
│                                         │
│  📜 Electrician License                 │
│                                         │
│  ┌────────────────────────────────┐    │
│  │        ✅ Verified               │    │ Success State
│  │                                 │    │
│  │  Your document has been verified│    │
│  │  by our team                    │    │
│  │                                 │    │
│  │  Verified on: Dec 1, 2025       │    │
│  │  Verified by: Admin Team        │    │
│  └────────────────────────────────┘    │
│                                         │
│  Document Details:                      │
│  • Number: EL123456789                  │
│  • Issued: Jan 10, 2020                 │
│  • Expires: Jan 10, 2026                │
│  • Issuing Authority: IEE               │
│                                         │
│  [Download Copy]  [View Certificate]    │
│                                         │
└─────────────────────────────────────────┘

DOCUMENT REJECTED:

┌─────────────────────────────────────────┐
│      Verification Failed           ✕    │
├─────────────────────────────────────────┤
│                                         │
│  📄 Safety Certificate                  │
│                                         │
│  ┌────────────────────────────────┐    │
│  │         ❌ Rejected              │    │ Error State
│  │                                 │    │
│  │  Your document was not verified │    │
│  │                                 │    │
│  │  Reason:                        │    │
│  │  "Document image is blurry and  │    │
│  │   expiry date is not visible.   │    │
│  │   Please upload a clear scan."  │    │
│  │                                 │    │
│  │  Reviewed on: Dec 29, 2025      │    │
│  └────────────────────────────────┘    │
│                                         │
│  What to do next:                       │
│  • Take a clear, well-lit photo         │
│  • Ensure all text is readable          │
│  • Show all 4 corners of document       │
│  • Avoid shadows and glare              │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Re-upload Document          │   │ Primary Button
│  └─────────────────────────────────┘   │
│                                         │
│  [Contact Support]                      │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Document Categories
- **Identity Documents**: Aadhaar, PAN Card, Driving License
- **Professional Certifications**: Trade licenses, skill certifications
- **Bank Documents**: Bank statement, cancelled cheque
- **Background Verification**: Police verification, address proof

### 2. Document Status
- **Verified (✅)**: Green checkmark, document approved
- **Pending (⏳)**: Yellow, under review
- **Expiring Soon (⚠️)**: Orange warning, < 30 days to expire
- **Expired (❌)**: Red, needs renewal
- **Rejected (❌)**: Red, needs re-upload

### 3. Upload Functionality
- Select document type
- Enter document details (number, dates, issuing authority)
- Upload file (PDF, JPG, PNG, max 5MB)
- Auto-submit for verification

### 4. Verification Process
- Admin reviews document (1-2 business days)
- Automated checks (OCR for number, dates)
- Approval/rejection with reason
- Email/push notification on status change

### 5. Expiry Management
- Automatic expiry tracking
- Alerts at 60, 30, 15, 7 days before expiry
- "Renew Now" quick action
- Email reminders

### 6. Document Viewing
- View uploaded documents securely
- Download verified copies
- Zoom and pan for details
- Watermarked previews

## Component Breakdown

### 1. Status Banner
```swift
struct DocumentStatusBanner: View {
    let allDocumentsVerified: Bool
    let accountStatus: String
    let lastUpdated: Date

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: allDocumentsVerified ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                .font(.system(size: 32))
                .foregroundColor(allDocumentsVerified ? Color("SuccessGreen") : Color("WarningYellow"))

            VStack(alignment: .leading, spacing: 4) {
                Text(allDocumentsVerified ? "All Documents Verified" : "Action Required")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                Text("Account Status: \(accountStatus)")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextSecondary"))

                Text("Last Updated: \(lastUpdated.formatted(date: .abbreviated, time: .omitted))")
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color("TextTertiary"))
            }

            Spacer()
        }
        .padding(16)
        .background(allDocumentsVerified ? Color("SuccessGreen").opacity(0.1) : Color("WarningYellow").opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(allDocumentsVerified ? Color("SuccessGreen").opacity(0.3) : Color("WarningYellow").opacity(0.3), lineWidth: 1)
        )
    }
}
```

### 2. Document Card
```swift
struct DocumentCard: View {
    let document: Document
    let onView: () -> Void
    let onUpdate: () -> Void
    let onRenew: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text(document.icon)
                    .font(.system(size: 28))

                Text(document.name)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                // Status Icon
                statusIcon(for: document.status)
            }

            // Status Label
            HStack(spacing: 6) {
                Text("Status:")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextSecondary"))

                Text(document.status.displayName)
                    .font(.custom("Inter-SemiBold", size: 13))
                    .foregroundColor(document.status.color)
            }

            // Document Details
            VStack(alignment: .leading, spacing: 4) {
                if let number = document.number {
                    DocumentDetailRow(label: "Number", value: maskDocumentNumber(number))
                }

                if let issuedDate = document.issuedDate {
                    DocumentDetailRow(label: "Issued", value: issuedDate.formatted(date: .abbreviated, time: .omitted))
                }

                if let expiryDate = document.expiryDate {
                    DocumentDetailRow(label: "Expires", value: expiryDate.formatted(date: .abbreviated, time: .omitted))

                    // Expiry Warning
                    if let daysRemaining = document.daysUntilExpiry, daysRemaining <= 30 {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 12))
                            Text("\(daysRemaining) days remaining")
                                .font(.custom("Inter-SemiBold", size: 12))
                        }
                        .foregroundColor(Color("WarningYellow"))
                    }
                }

                if let verifiedDate = document.verifiedDate {
                    DocumentDetailRow(label: "Verified on", value: verifiedDate.formatted(date: .abbreviated, time: .omitted))
                }
            }

            // Status-specific Message
            if document.status == .pending {
                HStack(spacing: 8) {
                    ProgressView()
                        .scaleEffect(0.8)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Verification in progress...")
                            .font(.custom("Inter-Medium", size: 12))
                            .foregroundColor(Color("WarningYellow"))

                        Text("Usually takes 1-2 business days")
                            .font(.custom("Inter-Regular", size: 11))
                            .foregroundColor(Color("TextTertiary"))
                    }
                }
                .padding(10)
                .background(Color("WarningYellow").opacity(0.1))
                .cornerRadius(6)
            }

            Divider()
                .padding(.vertical, 4)

            // Actions
            HStack(spacing: 16) {
                if let renewAction = onRenew, document.needsRenewal {
                    Button(action: renewAction) {
                        Text("Renew Now")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color("SecondaryOrange"))
                            .cornerRadius(6)
                    }
                }

                Button(action: onView) {
                    Text("View")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("PrimaryTeal"))
                }

                if document.status == .verified {
                    Button(action: onUpdate) {
                        Text("Update")
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("TextSecondary"))
                    }
                } else if document.status == .pending {
                    Button(action: onUpdate) {
                        Text("Cancel Upload")
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("ErrorRed"))
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor(for: document.status), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
    }

    func statusIcon(for status: DocumentStatus) -> some View {
        Group {
            switch status {
            case .verified:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color("SuccessGreen"))
            case .pending:
                ProgressView()
                    .scaleEffect(0.8)
            case .expiringSoon:
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(Color("WarningYellow"))
            case .expired, .rejected:
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color("ErrorRed"))
            }
        }
        .font(.system(size: 20))
    }

    func borderColor(for status: DocumentStatus) -> Color {
        switch status {
        case .verified: return Color("SuccessGreen").opacity(0.3)
        case .pending: return Color("WarningYellow").opacity(0.3)
        case .expiringSoon: return Color("WarningYellow").opacity(0.5)
        case .expired, .rejected: return Color("ErrorRed").opacity(0.3)
        }
    }

    func maskDocumentNumber(_ number: String) -> String {
        guard number.count > 4 else { return number }
        let lastFour = String(number.suffix(4))
        let masked = String(repeating: "•", count: max(0, number.count - 4))
        return masked + lastFour
    }
}

struct DocumentDetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))

            Text(value)
                .font(.custom("Inter-Medium", size: 12))
                .foregroundColor(Color("TextPrimary"))
        }
    }
}

enum DocumentStatus {
    case verified, pending, expiringSoon, expired, rejected

    var displayName: String {
        switch self {
        case .verified: return "Verified"
        case .pending: return "Under Review"
        case .expiringSoon: return "Expiring Soon"
        case .expired: return "Expired"
        case .rejected: return "Rejected"
        }
    }

    var color: Color {
        switch self {
        case .verified: return Color("SuccessGreen")
        case .pending: return Color("WarningYellow")
        case .expiringSoon: return Color("WarningYellow")
        case .expired, .rejected: return Color("ErrorRed")
        }
    }
}

struct Document: Identifiable {
    let id: String
    let icon: String
    let name: String
    let status: DocumentStatus
    let number: String?
    let issuedDate: Date?
    let expiryDate: Date?
    let verifiedDate: Date?

    var daysUntilExpiry: Int? {
        guard let expiryDate = expiryDate else { return nil }
        return Calendar.current.dateComponents([.day], from: Date(), to: expiryDate).day
    }

    var needsRenewal: Bool {
        guard let days = daysUntilExpiry else { return false }
        return days <= 30 && days >= 0
    }
}
```

## API Integration

### Get Documents List
```
GET /providers/{providerId}/documents

Response:
{
  "success": true,
  "data": {
    "allVerified": true,
    "accountStatus": "approved",
    "documents": [
      {
        "id": "doc_abc123",
        "type": "aadhaar",
        "icon": "🆔",
        "name": "Aadhaar Card",
        "status": "verified",
        "number": "123456785678",
        "issuedDate": null,
        "expiryDate": null,
        "verifiedDate": "2025-12-01T00:00:00Z",
        "fileUrl": "https://..."
      }
    ]
  }
}
```

### Upload Document
```
POST /providers/{providerId}/documents

Request (multipart/form-data):
- documentType: "license"
- documentNumber: "EL123456789"
- issuingAuthority: "IEE"
- issueDate: "2020-01-10"
- expiryDate: "2026-01-10"
- file: (binary)

Response:
{
  "success": true,
  "data": {
    "documentId": "doc_xyz789",
    "status": "pending"
  },
  "message": "Document uploaded successfully. Verification in progress."
}
```

## Navigation

- From Screen 23/48 → Documents Management
- Upload → Modal overlay
- View Document → Full-screen viewer
- Back → Return to previous screen

## Testing Checklist

- [ ] Load all documents correctly
- [ ] Upload new document
- [ ] View document PDF/image
- [ ] Update existing document
- [ ] Renew expiring document
- [ ] Handle rejected documents
- [ ] Expiry date warnings display
- [ ] Status banners show correctly
- [ ] Network error handling

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
