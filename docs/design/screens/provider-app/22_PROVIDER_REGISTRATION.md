# Provider Registration (Multi-Step)

## Overview
- **Screen ID**: 22
- **Screen Name**: Provider Registration
- **User Flow**: Multi-step onboarding for service providers to join UrbanNest platform
- **Navigation**:
  - Entry: From marketing website, referral link, or app download
  - Exit: To Document Upload screen (on completion)
  - Back: Previous step or exit confirmation

## Multi-Step Flow

### Steps Overview
1. **Phone Verification** (Step 1/6)
2. **Basic Information** (Step 2/6)
3. **Service Selection** (Step 3/6)
4. **Experience & Skills** (Step 4/6)
5. **Work Area** (Step 5/6)
6. **Bank Details** (Step 6/6)

## ASCII Wireframe

### Step 1: Phone Verification
```
┌──────────────────────────────────────────┐
│  ←                                       │ ← Nav Bar (back)
├──────────────────────────────────────────┤
│                                          │
│  ●○○○○○                                  │ ← Progress Indicator
│  Step 1 of 6                             │   (1/6 filled)
│                                          │
│         👨‍🔧                               │ ← Icon
│                                          │
│  Join UrbanNest as a                     │ ← Heading
│  Service Provider                        │
│                                          │
│  Earn ₹30,000+ per month by providing   │ ← Subheading
│  quality services to customers           │
│                                          │
│  Enter Your Phone Number                 │ ← Label
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ +91 │ [9876543210]                 │ │ ← Phone Input
│  └────────────────────────────────────┘ │
│                                          │
│  ☑️ I agree to Terms & Conditions       │ ← Checkbox
│     and Privacy Policy                   │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Send OTP                          │ │ ← CTA Button
│  └────────────────────────────────────┘ │
│                                          │
│  Already registered? Sign In            │ ← Sign In Link
│                                          │
└──────────────────────────────────────────┘
```

### Step 1b: OTP Verification
```
┌──────────────────────────────────────────┐
│  ←                                       │
├──────────────────────────────────────────┤
│                                          │
│  ●○○○○○                                  │
│  Step 1 of 6                             │
│                                          │
│         📱                               │
│                                          │
│  Verify Your Number                      │
│                                          │
│  Enter the 6-digit code sent to          │
│  +91 98765 43210                         │
│                                          │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐  │ ← OTP Input
│  │ 1 │ │ 2 │ │ 3 │ │ 4 │ │ 5 │ │ 6 │  │   (6 boxes)
│  └───┘ └───┘ └───┘ └───┘ └───┘ └───┘  │
│                                          │
│  Didn't receive? Resend in 0:45         │ ← Resend Timer
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Verify & Continue                 │ │ ← CTA Button
│  └────────────────────────────────────┘ │
│                                          │
│         Change Number                    │ ← Change Link
│                                          │
└──────────────────────────────────────────┘
```

### Step 2: Basic Information
```
┌──────────────────────────────────────────┐
│  ←                                       │
├──────────────────────────────────────────┤
│                                          │
│  ●●○○○○                                  │
│  Step 2 of 6                             │
│                                          │
│  Basic Information                       │
│                                          │
│  Tell us about yourself                  │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │      [Add Photo]                   │ │ ← Photo Upload
│  │      (Tap to upload)               │ │   (circular)
│  └────────────────────────────────────┘ │
│                                          │
│  Full Name *                             │
│  ┌────────────────────────────────────┐ │
│  │ Rajesh Kumar                       │ │ ← Text Input
│  └────────────────────────────────────┘ │
│                                          │
│  Email Address                           │
│  ┌────────────────────────────────────┐ │
│  │ rajesh@email.com                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Date of Birth *                         │
│  ┌────────────────────────────────────┐ │
│  │ DD / MM / YYYY                     │ │ ← Date Picker
│  └────────────────────────────────────┘ │
│                                          │
│  Gender *                                │
│  ┌──────────┐ ┌──────────┐ ┌─────────┐│
│  │   Male   │ │  Female  │ │  Other  ││ ← Radio Buttons
│  └──────────┘ └──────────┘ └─────────┘│
│     (selected)                           │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Continue                          │ │ ← CTA Button
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Step 3: Service Selection
```
┌──────────────────────────────────────────┐
│  ←                                       │
├──────────────────────────────────────────┤
│                                          │
│  ●●●○○○                                  │
│  Step 3 of 6                             │
│                                          │
│  Select Your Services                    │
│                                          │
│  Choose the services you can provide    │
│  (You can select multiple)               │
│                                          │
│  🔧 Home Repair & Maintenance            │ ← Category
│  ┌────────────────────────────────────┐ │
│  │ ☑️ AC Repair & Service             │ │ ← Checkbox List
│  │ ☑️ Electrical Work                 │ │   (selected)
│  │ ☐ Plumbing                         │ │
│  │ ☐ Carpenter Work                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ✂️ Beauty & Wellness                    │
│  ┌────────────────────────────────────┐ │
│  │ ☐ Salon at Home (Male)             │ │
│  │ ☐ Salon at Home (Female)           │ │
│  │ ☐ Spa & Massage                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🧹 Cleaning Services                    │
│  ┌────────────────────────────────────┐ │
│  │ ☐ Home Cleaning                    │ │
│  │ ☐ Deep Cleaning                    │ │
│  │ ☐ Bathroom Cleaning                │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Selected: 2 services                    │ ← Counter
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Continue                          │ │
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Step 4: Experience & Skills
```
┌──────────────────────────────────────────┐
│  ←                                       │
├──────────────────────────────────────────┤
│                                          │
│  ●●●●○○                                  │
│  Step 4 of 6                             │
│                                          │
│  Experience & Skills                     │
│                                          │
│  Share your experience details           │
│                                          │
│  Years of Experience *                   │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐  │
│  │ <1   │ │ 1-3  │ │ 3-5  │ │  5+  │  │ ← Pills
│  └──────┘ └──────┘ └──────┘ └──────┘  │
│              (selected)                  │
│                                          │
│  AC Repair & Service                     │ ← Service 1
│  ┌────────────────────────────────────┐ │
│  │ Experience (years): 3              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ☑️ Window AC                            │ ← Skills checklist
│  ☑️ Split AC                             │
│  ☑️ Installation                         │
│  ☑️ Gas Refilling                        │
│  ☐ Central AC                            │
│                                          │
│  Electrical Work                         │ ← Service 2
│  ┌────────────────────────────────────┐ │
│  │ Experience (years): 2              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ☑️ Wiring                               │
│  ☑️ Switch/Socket Repair                 │
│  ☐ MCB Installation                      │
│  ☐ Fan Installation                      │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Continue                          │ │
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Step 5: Work Area
```
┌──────────────────────────────────────────┐
│  ←                                       │
├──────────────────────────────────────────┤
│                                          │
│  ●●●●●○                                  │
│  Step 5 of 6                             │
│                                          │
│  Work Area                               │
│                                          │
│  Where do you want to work?              │
│                                          │
│  Primary City *                          │
│  ┌────────────────────────────────────┐ │
│  │ Bangalore              ▼           │ │ ← Dropdown
│  └────────────────────────────────────┘ │
│                                          │
│  Work Locations *                        │
│  Select areas where you can work         │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🔍 Search localities...            │ │ ← Search
│  └────────────────────────────────────┘ │
│                                          │
│  Popular Areas:                          │
│  ┌──────────┐ ┌──────────┐             │
│  │ Koramanga│ │  Indiranag│             │ ← Pills
│  │    la    │ │    ar     │             │   (multi-select)
│  └──────────┘ └──────────┘             │
│     (selected)  (selected)              │
│                                          │
│  ┌──────────┐ ┌──────────┐ ┌─────────┐│
│  │ Whitefield│ │  HSR     │ │  BTM    ││
│  │          │ │  Layout  │ │ Layout  ││
│  └──────────┘ └──────────┘ └─────────┘│
│                                          │
│  ┌──────────┐ ┌──────────┐             │
│  │ Electronic│ │ Marathaha││
│  │   City   │ │    lli   ││
│  └──────────┘ └──────────┘             │
│                                          │
│  Selected: 2 locations                   │
│                                          │
│  Willing to travel up to:                │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐  │
│  │ 5 km │ │10 km │ │15 km │ │20+ km│  │
│  └──────┘ └──────┘ └──────┘ └──────┘  │
│              (selected)                  │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Continue                          │ │
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Step 6: Bank Details
```
┌──────────────────────────────────────────┐
│  ←                                       │
├──────────────────────────────────────────┤
│                                          │
│  ●●●●●●                                  │
│  Step 6 of 6                             │
│                                          │
│  Bank Details                            │
│                                          │
│  For receiving payments                  │
│                                          │
│  Account Holder Name *                   │
│  ┌────────────────────────────────────┐ │
│  │ Rajesh Kumar                       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Bank Account Number *                   │
│  ┌────────────────────────────────────┐ │
│  │ 1234567890123456                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Re-enter Account Number *               │
│  ┌────────────────────────────────────┐ │
│  │ 1234567890123456                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  IFSC Code *                             │
│  ┌────────────────────────────────────┐ │
│  │ HDFC0001234                        │ │
│  │ HDFC Bank, MG Road Branch          │ │ ← Auto-filled
│  └────────────────────────────────────┘ │
│                                          │
│  Account Type *                          │
│  ┌──────────┐ ┌──────────┐             │
│  │ Savings  │ │ Current  │             │
│  └──────────┘ └──────────┘             │
│   (selected)                             │
│                                          │
│  🔒 Your bank details are encrypted      │ ← Trust Badge
│     and secure                           │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Submit Application                │ │ ← Final CTA
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Final: Application Submitted
```
┌──────────────────────────────────────────┐
│                                          │
│                                          │
│                                          │
│              ✅                          │ ← Success Icon
│                                          │
│  Application Submitted!                  │ ← Heading
│                                          │
│  Your application has been received      │
│  and is under review.                    │
│                                          │
│  What's Next?                            │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  1️⃣ Upload Documents                │ │ ← Steps Card
│  │     ID Proof, Photo, Certificates   │ │
│  │                                    │ │
│  │  2️⃣ Verification (2-3 days)         │ │
│  │     Our team will verify details    │ │
│  │                                    │ │
│  │  3️⃣ Training & Onboarding           │ │
│  │     Brief training session          │ │
│  │                                    │ │
│  │  4️⃣ Start Earning!                  │ │
│  │     Accept jobs and earn money      │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Upload Documents Now              │ │ ← Primary CTA
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  I'll Do It Later                  │ │ ← Secondary CTA
│  └────────────────────────────────────┘ │
│                                          │
│  Need help? Call us: 1800-123-4567      │ ← Support
│                                          │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt
- **Safe Area Bottom**: 34pt
- **Content Width**: 358pt (16pt padding)
- **Form Max Width**: 358pt

### Navigation Bar
- **Height**: 56pt
- **Background**: White / Dark (#2A2A2A)
- **Back Button**: 24x24pt chevron.left, #0D7377
- **No Title**: Clean look
- **Padding**: 16pt horizontal

### Progress Indicator
- **Layout**: Horizontal dots
- **Total Dots**: 6 (one per step)
- **Dot Size**: 10x10pt
- **Gap**: 8pt between dots
- **Colors**:
  - Completed: #0D7377 (solid)
  - Current: #0D7377 (solid)
  - Upcoming: #E0E0E0 (outline)
- **Margin**: 24pt top, 8pt bottom
- **Alignment**: Left-aligned with padding

### Step Label
- **Typography**: SF Pro Regular 14pt
- **Color**: #666666 / #A0A0A0
- **Format**: "Step X of 6"
- **Margin**: 4pt bottom from progress dots

### Headings
- **Main Heading**: Inter Bold 28pt, #1E1E1E / #E0E0E0
- **Subheading**: SF Pro Regular 16pt, #666666 / #A0A0A0
- **Margin**: 24pt top, 8pt bottom (subheading)
- **Line Spacing**: 1.3

### Icons
- **Size**: 80x80pt
- **Margin**: 32pt top, 24pt bottom
- **Alignment**: Center
- **Style**: Emoji or SF Symbol

### Input Fields
- **Height**: 56pt
- **Border Radius**: 12pt
- **Border**: 1.5pt solid #E0E0E0 / #3A3A3A
- **Focus Border**: 2pt solid #0D7377
- **Background**: White / #2A2A2A
- **Padding**: 16pt horizontal
- **Typography**: SF Pro Regular 16pt
- **Placeholder**: #999999
- **Margin**: 20pt bottom

### Labels
- **Typography**: Inter Medium 14pt
- **Color**: #1E1E1E / #E0E0E0
- **Margin**: 8pt bottom from field
- **Required Asterisk**: #EA5455

### Phone Input
- **Country Code**: Fixed "+91" prefix, 60pt width
- **Separator**: 1pt vertical line, #E0E0E0
- **Input**: Remaining width
- **Number Format**: Auto-format with spaces

### OTP Input
- **Individual Box**: 48x56pt
- **Border Radius**: 8pt
- **Border**: 1.5pt solid #E0E0E0
- **Focus Border**: 2pt solid #0D7377
- **Gap**: 12pt between boxes
- **Typography**: Inter SemiBold 24pt
- **Text Alignment**: Center
- **Layout**: Horizontal, evenly spaced

### Checkbox
- **Size**: 24x24pt
- **Border Radius**: 6pt
- **Border**: 2pt solid #E0E0E0
- **Checked**: #0D7377 background, white checkmark
- **Label**: SF Pro Regular 14pt, 8pt left margin
- **Line Height**: 1.5 (for multi-line)

### Radio Buttons (Gender Selection)
- **Height**: 48pt
- **Border Radius**: 8pt
- **Border**: 1.5pt solid #E0E0E0
- **Selected**: Background #E8F7F8, Border #0D7377
- **Unselected**: Background White, Border #E0E0E0
- **Typography**: Inter Medium 15pt
- **Gap**: 12pt between buttons
- **Layout**: Horizontal grid, equal width

### Photo Upload
- **Size**: 120x120pt circular
- **Border**: 2pt dashed #0D7377
- **Background**: #F5F5F5 / #2A2A2A
- **Icon**: 32x32pt camera.fill, #0D7377
- **Text**: SF Pro Regular 13pt, #666666
- **Margin**: 24pt bottom
- **Alignment**: Center

### Service Checkboxes
- **Category Header**:
  - Typography: Inter SemiBold 16pt
  - Icon: 24x24pt emoji
  - Margin: 20pt top, 12pt bottom
- **Checkbox Item**:
  - Height: 48pt
  - Checkbox: 20x20pt, left-aligned
  - Label: SF Pro Regular 15pt
  - Background: #F5F5F5 on hover
  - Border Bottom: 1pt #E0E0E0 (except last)

### Pill Buttons (Multi-Select)
- **Height**: 40pt
- **Border Radius**: 20pt (pill shape)
- **Padding**: 12pt horizontal
- **Border**: 1.5pt solid #E0E0E0
- **Selected**: Background #0D7377, Text White
- **Unselected**: Background White, Text #666666
- **Typography**: Inter Medium 14pt
- **Gap**: 8pt
- **Layout**: Flex wrap

### Search Input
- **Height**: 48pt
- **Border Radius**: 12pt
- **Border**: 1.5pt solid #E0E0E0
- **Icon**: 20x20pt magnifyingglass, #999999, left
- **Padding**: 12pt left (after icon), 12pt right
- **Margin**: 16pt bottom

### Counter/Status Text
- **Typography**: SF Pro Medium 14pt
- **Color**: #0D7377
- **Margin**: 12pt top
- **Alignment**: Left

### CTA Button
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: #0D7377 (gradient to #14A0A5)
- **Text**: Inter SemiBold 16pt, White
- **Shadow**: 0 4px 12px rgba(13,115,119,0.3)
- **Disabled**: Opacity 0.5, no shadow
- **Margin**: 32pt top
- **Active State**: Scale 0.98

### Secondary Links
- **Typography**: Inter Medium 15pt
- **Color**: #0D7377
- **Underline**: None
- **Margin**: 16pt top
- **Alignment**: Center
- **Active**: Opacity 0.7

### Trust Badge
- **Icon**: 16x16pt lock.shield, #28C76F
- **Typography**: SF Pro Regular 13pt, #666666
- **Background**: #F5F5F5 / #2A2A2A
- **Padding**: 12pt
- **Border Radius**: 8pt
- **Margin**: 20pt top

### Success Screen
- **Icon**: 100x100pt checkmark.circle.fill, #28C76F
- **Heading**: Inter Bold 28pt
- **Margin**: 80pt top for icon
- **Steps Card**:
  - Background: White / #2A2A2A
  - Border Radius: 12pt
  - Border: 1pt #E0E0E0
  - Padding: 20pt
  - Each Step: Icon + Title + Description
  - Step Gap: 16pt

## Components Used

### Existing Components
1. **CustomNavigationBar**
2. **PrimaryButton**
3. **SecondaryButton**
4. **StandardTextField**
5. **PhoneTextField**

### New Components Needed
1. **ProgressDots** (step indicator)
2. **OTPInputField** (6-digit boxes)
3. **PhotoUploader** (circular upload)
4. **CheckboxList** (service selection)
5. **PillSelector** (multi-select pills)
6. **LocalityPicker** (searchable area selection)
7. **BankAccountInput** (with IFSC lookup)
8. **SuccessCard** (application submitted)

## Validation Rules

### Phone Number
- Must be 10 digits
- Indian format only (+91)
- No duplicate registration
- Verified via OTP

### OTP
- 6 digits
- Valid for 10 minutes
- Max 3 attempts
- Resend after 60 seconds

### Basic Information
- Name: Min 3 characters, alphabets only
- Email: Valid email format (optional)
- Date of Birth: Age must be 18-65 years
- Gender: Required selection
- Photo: Max 5MB, JPG/PNG only

### Service Selection
- Minimum 1 service required
- Maximum 5 services allowed
- Each service must have skills selected

### Experience
- Must select experience range
- Skills selection required for each service
- Minimum 1 skill per service

### Work Area
- City required
- Minimum 2 localities required
- Maximum 10 localities allowed
- Travel distance required

### Bank Details
- Account holder name matches registration name
- Account number: 9-18 digits
- Re-enter must match
- Valid IFSC code (verified via API)
- Account type required

## Interactions

### Back Button (Any Step)
- **Action**: Go to previous step
- **Confirmation**: If data entered, show "Discard changes?" alert
- **Data**: Preserve entered data
- **Haptic**: Light impact

### Progress Dot Tap
- **Action**: Navigate to that step (if previously completed)
- **Disabled**: For future steps
- **Visual**: Disabled dots grayed out
- **Haptic**: Light impact

### Send OTP
- **Validation**: Check phone format
- **API Call**: Send OTP to phone
- **Loading**: Show spinner in button
- **Success**: Navigate to OTP screen
- **Error**: Show error toast
- **Haptic**: Medium impact

### OTP Auto-Fill
- **iOS**: Auto-read SMS OTP
- **Android**: SMS auto-retrieval
- **Manual**: Allow typing
- **Auto-Verify**: Submit when 6 digits entered

### Resend OTP
- **Timer**: 60 second countdown
- **Disabled**: While counting
- **Action**: Send new OTP
- **Limit**: Max 3 resends
- **Toast**: "OTP sent successfully"

### Photo Upload
- **Action**: Show action sheet
- **Options**:
  - Take Photo (camera)
  - Choose from Gallery
  - Cancel
- **Permission**: Camera, Photo Library
- **Crop**: Circular crop UI
- **Compression**: Auto-compress to < 5MB
- **Upload**: To Firebase Storage
- **Preview**: Show uploaded photo

### Service Checkbox Toggle
- **Action**: Add/remove from selection
- **Validation**: Min 1, Max 5
- **Visual**: Checkmark animation
- **Counter**: Update "Selected: X services"
- **Haptic**: Light impact

### Skills Checkbox
- **Action**: Toggle skill
- **Validation**: Min 1 per service
- **Dependent**: Only for selected services
- **Haptic**: Light impact

### Locality Search
- **Debounce**: 300ms
- **API**: Search localities by name
- **Results**: Dropdown list
- **Selection**: Add pill
- **Limit**: Max 10 localities

### IFSC Lookup
- **Trigger**: After entering IFSC
- **API**: Fetch bank details
- **Display**: Show bank name and branch
- **Error**: "Invalid IFSC code"
- **Haptic**: Success or error

### Continue Button (Each Step)
- **Validation**: Check required fields
- **Error**: Show field errors
- **Success**: Navigate to next step
- **Loading**: Show spinner
- **Haptic**: Success feedback

### Submit Application
- **Validation**: All steps completed
- **Confirmation**: "Submit application?" alert
- **API**: POST to backend
- **Loading**: Full-screen spinner
- **Success**: Navigate to success screen
- **Error**: Show error, allow retry
- **Analytics**: Log submission

### Upload Documents Now
- **Action**: Navigate to Document Upload screen
- **Data**: Pass application ID
- **Haptic**: Medium impact

### I'll Do It Later
- **Action**: Navigate to Application Status screen
- **Save**: Save progress
- **Reminder**: Schedule notification
- **Haptic**: Light impact

## States

### Default State (Step 1)
- **Progress**: 1/6
- **Fields**: Empty
- **Button**: Disabled until phone entered
- **Checkbox**: Unchecked

### Loading State (API Calls)
- **Button**: Spinner, disabled
- **Overlay**: For final submission
- **Duration**: Until response

### Error State
- **Field Error**: Red border, error message below
- **Toast**: For general errors
- **Icon**: Exclamation mark

### Success State (OTP Verified)
- **Visual**: Green checkmark
- **Toast**: "Phone verified"
- **Auto-Navigate**: After 1 second

### Validation Error
- **Trigger**: On field blur or submit
- **Display**: Below field, red text
- **Clear**: On field focus
- **Examples**:
  - "Phone number must be 10 digits"
  - "Please select at least one service"
  - "Account numbers do not match"

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card/Field Background**: #2A2A2A
- **Border**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Progress Dots**: Same
- **Primary Button**: Same gradient

## Accessibility

### VoiceOver Labels
- **Progress**: "Step 1 of 6, Phone verification"
- **Phone Input**: "Phone number, text field"
- **OTP Box**: "OTP digit 1 of 6, text field"
- **Checkbox**: "[Service name], checkbox, checked/unchecked"
- **Photo Upload**: "Profile photo, button, tap to upload"
- **Continue**: "Continue to next step, button"

### VoiceOver Hints
- **Back**: "Double tap to go back to previous step"
- **Continue**: "Double tap to proceed to [next step name]"

### Dynamic Type Support
- All text scales appropriately
- Minimum button height: 44pt
- Layout adjusts for larger text

### Color Contrast
- All text meets WCAG AA
- Error messages clearly visible
- Progress dots distinguishable

## Analytics Events

### Registration Started
```json
{
  "event": "provider_registration_started",
  "source": "app_download", // or referral, website
  "timestamp": "ISO8601"
}
```

### Step Completed
```json
{
  "event": "registration_step_completed",
  "step_number": 1,
  "step_name": "phone_verification",
  "time_spent_seconds": 45
}
```

### Service Selected
```json
{
  "event": "services_selected",
  "services": ["ac_repair", "electrical"],
  "service_count": 2
}
```

### Application Submitted
```json
{
  "event": "provider_application_submitted",
  "services": ["ac_repair", "electrical"],
  "city": "bangalore",
  "localities_count": 3,
  "experience_years": "1-3",
  "total_time_minutes": 8
}
```

## SwiftUI Implementation

### View Structure
```swift
struct ProviderRegistrationFlow: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @State private var currentStep: RegistrationStep = .phoneVerification

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray100.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Progress Indicator
                    ProgressDots(
                        total: 6,
                        current: currentStep.stepNumber,
                        onTap: navigateToStep
                    )
                    .padding(.top, 24)
                    .padding(.horizontal, 16)

                    // Step Label
                    Text("Step \(currentStep.stepNumber) of 6")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    // Current Step Content
                    ScrollView {
                        currentStepView
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: BackButton {
                    handleBackAction()
                }
            )
            .onAppear {
                Analytics.logEvent("provider_registration_started")
            }
        }
    }

    @ViewBuilder
    private var currentStepView: some View {
        switch currentStep {
        case .phoneVerification:
            PhoneVerificationStep(
                viewModel: viewModel,
                onContinue: { currentStep = .basicInfo }
            )

        case .basicInfo:
            BasicInfoStep(
                viewModel: viewModel,
                onContinue: { currentStep = .serviceSelection }
            )

        case .serviceSelection:
            ServiceSelectionStep(
                viewModel: viewModel,
                onContinue: { currentStep = .experience }
            )

        case .experience:
            ExperienceSkillsStep(
                viewModel: viewModel,
                onContinue: { currentStep = .workArea }
            )

        case .workArea:
            WorkAreaStep(
                viewModel: viewModel,
                onContinue: { currentStep = .bankDetails }
            )

        case .bankDetails:
            BankDetailsStep(
                viewModel: viewModel,
                onSubmit: submitApplication
            )
        }
    }

    private func handleBackAction() {
        if currentStep.stepNumber > 1 {
            currentStep = currentStep.previous()
            HapticFeedback.light()
        } else {
            showExitConfirmation()
        }
    }

    private func navigateToStep(_ step: Int) {
        guard step <= viewModel.completedSteps else { return }
        currentStep = RegistrationStep(rawValue: step) ?? .phoneVerification
        HapticFeedback.light()
    }

    private func submitApplication() {
        Task {
            let success = await viewModel.submitApplication()
            if success {
                navigateToSuccessScreen()
            }
        }
    }

    private func navigateToSuccessScreen() {
        navigationController?.push(
            ApplicationSubmittedView(
                applicationId: viewModel.applicationId
            )
        )
    }

    private func showExitConfirmation() {
        AlertManager.show(
            title: "Exit Registration?",
            message: "Your progress will be saved. You can continue later.",
            primaryButton: "Exit",
            primaryAction: { dismiss() },
            secondaryButton: "Cancel"
        )
    }
}

enum RegistrationStep: Int {
    case phoneVerification = 1
    case basicInfo = 2
    case serviceSelection = 3
    case experience = 4
    case workArea = 5
    case bankDetails = 6

    var stepNumber: Int { rawValue }

    func previous() -> RegistrationStep {
        RegistrationStep(rawValue: rawValue - 1) ?? .phoneVerification
    }
}
```

### ViewModel
```swift
class RegistrationViewModel: ObservableObject {
    @Published var phone: String = ""
    @Published var otp: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var dateOfBirth: Date?
    @Published var gender: Gender?
    @Published var profilePhoto: UIImage?
    @Published var selectedServices: [Service] = []
    @Published var serviceSkills: [String: [Skill]] = [:]
    @Published var experienceYears: ExperienceRange?
    @Published var city: String = ""
    @Published var localities: [String] = []
    @Published var travelDistance: Int = 10
    @Published var bankDetails: BankDetails?
    @Published var completedSteps: Int = 0
    @Published var applicationId: String?
    @Published var isLoading: Bool = false

    private let authService: AuthService
    private let providerService: ProviderService

    init() {
        self.authService = AuthService()
        self.providerService = ProviderService()
    }

    func sendOTP() async throws {
        isLoading = true
        try await authService.sendOTP(to: phone)
        isLoading = false
    }

    func verifyOTP() async throws -> Bool {
        isLoading = true
        let verified = try await authService.verifyOTP(phone: phone, otp: otp)
        isLoading = false

        if verified {
            completedSteps = max(completedSteps, 1)
            Analytics.logEvent("registration_step_completed", parameters: [
                "step_number": 1,
                "step_name": "phone_verification"
            ])
        }

        return verified
    }

    func uploadProfilePhoto(_ image: UIImage) async throws -> String {
        let url = try await providerService.uploadPhoto(image)
        profilePhoto = image
        return url
    }

    func lookupIFSC(_ code: String) async throws -> BankInfo {
        return try await providerService.lookupIFSC(code)
    }

    func submitApplication() async -> Bool {
        isLoading = true

        let application = ProviderApplication(
            phone: phone,
            name: name,
            email: email,
            dateOfBirth: dateOfBirth!,
            gender: gender!,
            services: selectedServices,
            skills: serviceSkills,
            experience: experienceYears!,
            city: city,
            localities: localities,
            travelDistance: travelDistance,
            bankDetails: bankDetails!
        )

        do {
            let applicationId = try await providerService.submitApplication(application)
            self.applicationId = applicationId
            isLoading = false

            Analytics.logEvent("provider_application_submitted", parameters: [
                "services": selectedServices.map { $0.id },
                "city": city,
                "localities_count": localities.count
            ])

            return true
        } catch {
            isLoading = false
            return false
        }
    }
}
```

## Performance Optimization

### Data Loading
- Lazy load service categories
- Cache locality list
- Compress uploaded photo

### Form State
- Save progress locally (UserDefaults)
- Auto-save on step completion
- Resume from saved state

## Testing Checklist

### Functional
- ✅ Phone OTP flow works
- ✅ All validation rules enforced
- ✅ Photo upload successful
- ✅ Service selection limited to 5
- ✅ Skills required per service
- ✅ Locality search works
- ✅ IFSC lookup successful
- ✅ Bank account validation
- ✅ Application submission
- ✅ Progress saved

### Edge Cases
- ✅ OTP timeout
- ✅ Invalid IFSC
- ✅ Duplicate phone
- ✅ Network errors
- ✅ Photo upload failure
- ✅ Back navigation
- ✅ App backgrounded

### Visual
- ✅ All steps render correctly
- ✅ Dark mode
- ✅ Dynamic Type
- ✅ VoiceOver
- ✅ Small screens (iPhone SE)
