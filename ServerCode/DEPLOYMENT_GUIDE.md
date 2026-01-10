# CityServe Backend - Complete Deployment Guide

## 🎯 Overview

This guide walks you through deploying the CityServe Home Screen backend from scratch.

**Time Required**: ~30 minutes
**Prerequisites**: Firebase project, Node.js 18, Basic terminal knowledge

---

## 📋 Prerequisites

### 1. Install Node.js 18 LTS
```bash
# Check version
node --version  # Should be v18.x.x

# If not installed, download from https://nodejs.org/
```

### 2. Install Firebase CLI
```bash
npm install -g firebase-tools

# Verify installation
firebase --version
```

### 3. Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click "Add Project"
3. Enter project name: `cityserve-prod` (or your choice)
4. Enable Google Analytics (optional)
5. Click "Create Project"

### 4. Enable Firestore Database
1. In Firebase Console, go to "Firestore Database"
2. Click "Create Database"
3. Choose "Production mode" (we'll deploy rules next)
4. Select region: `asia-south1` (India)
5. Click "Enable"

---

## 🚀 Step-by-Step Deployment

### Step 1: Firebase Login

```bash
# Login to Firebase
firebase login

# This will open a browser for authentication
# Select your Google account and grant permissions
```

### Step 2: Navigate to Backend Directory

```bash
cd /path/to/CityServe/ServerCode
```

### Step 3: Initialize Firebase Project

```bash
# Initialize Firebase in this directory
firebase init

# Answer prompts:
# ? Which Firebase features? Select:
#   - Functions
#   - Firestore (Database)
#
# ? Select a default Firebase project: Choose your project
# ? What language? TypeScript
# ? Use ESLint? Yes
# ? Install dependencies? Yes
# ? What file should be used for Firestore Rules? firestore.rules
# ? File firestore.rules already exists. Overwrite? No
# ? What file should be used for Firestore indexes? firestore.indexes.json
# ? File firestore.indexes.json already exists. Overwrite? No
```

### Step 4: Install Dependencies

```bash
cd functions
npm install
cd ..
```

### Step 5: Build TypeScript

```bash
cd functions
npm run build

# This compiles TypeScript to JavaScript in the 'lib' folder
```

### Step 6: Deploy Firestore Rules

```bash
# From ServerCode directory
firebase deploy --only firestore:rules

# Output should show:
# ✔ Deploy complete!
```

### Step 7: Deploy Firestore Indexes

```bash
firebase deploy --only firestore:indexes

# This may take a few minutes
# Indexes need to be built before queries work
```

### Step 8: Deploy Cloud Functions

```bash
firebase deploy --only functions

# This may take 2-5 minutes
# Output will show the deployed function URL
```

**Expected Output:**
```
✔  functions[asia-south1-api]: Successful create operation.
Function URL (api): https://asia-south1-PROJECT_ID.cloudfunctions.net/api
```

**Save this URL!** You'll use it to call your API.

---

## 📊 Step 9: Seed Sample Data

### Option A: Using Firebase Console (Recommended for beginners)

1. Go to Firebase Console → Firestore Database
2. Click "Start Collection"
3. Collection ID: `cities`
4. Add documents from `sample-data/cities.json`:

**Example Document:**
```
Document ID: delhi

Fields:
name (string): Delhi
displayName (string): Delhi NCR
isActive (boolean): true
coordinates (map):
  - latitude (number): 28.7041
  - longitude (number): 77.1025
timezone (string): Asia/Kolkata
currency (string): INR
currencySymbol (string): ₹
serviceRadius (number): 25
createdAt (timestamp): [current timestamp]
updatedAt (timestamp): [current timestamp]
```

Repeat for all collections: `cities`, `service_categories`, `services`, `promotional_banners`, `app_config`.

### Option B: Using Firebase Admin SDK (Advanced)

Create a seed script (`seed-data.ts`) or use Firebase Admin SDK in a Node.js script to bulk import data.

---

## ✅ Step 10: Test Your API

### Test Health Check
```bash
curl https://asia-south1-PROJECT_ID.cloudfunctions.net/api/health
```

**Expected Response:**
```json
{
  "status": "healthy",
  "service": "CityServe API",
  "version": "1.0.0",
  "timestamp": "..."
}
```

### Test Home Screen API
```bash
curl "https://asia-south1-PROJECT_ID.cloudfunctions.net/api/api/v1/home/screen?cityId=delhi"
```

**Expected Response:**
```json
{
  "success": true,
  "data": {
    "city": { "id": "delhi", "name": "Delhi", ... },
    "categories": { "personal": [...], "home": [...] },
    "popularServices": [...],
    "trendingServices": [...],
    "banners": [...],
    "trustIndicators": { ... }
  },
  "timestamp": "..."
}
```

---

## 🔧 Troubleshooting

### Issue 1: "Firestore index required"

**Error:**
```
The query requires an index. You can create it here: https://...
```

**Solution:**
1. Click the link in the error
2. Wait for index to build (5-10 minutes)
3. Or deploy indexes manually: `firebase deploy --only firestore:indexes`

### Issue 2: "Function timeout"

**Error:**
```
Function execution took too long
```

**Solution:**
Edit `functions/src/index.ts`:
```typescript
.runWith({
  timeoutSeconds: 120, // Increase from 60 to 120
})
```
Redeploy: `firebase deploy --only functions`

### Issue 3: "City not found"

**Error:**
```json
{
  "success": false,
  "error": { "code": "RESOURCE_NOT_FOUND", "message": "City not found" }
}
```

**Solution:**
- Ensure you've seeded the `cities` collection in Firestore
- Check the `cityId` parameter matches a document ID in `cities` collection
- Example: `cityId=delhi` (lowercase, no spaces)

### Issue 4: "Invalid city ID"

**Error:**
```json
{
  "success": false,
  "error": { "code": "INVALID_PARAMETERS", "message": "cityId must be lowercase..." }
}
```

**Solution:**
- City IDs must be lowercase alphanumeric (with optional underscores)
- Valid: `delhi`, `mumbai`, `bangalore`
- Invalid: `Delhi`, `delhi NCR`, `delhi-ncr`

---

## 📝 Post-Deployment Checklist

- [ ] Health check endpoint returns 200
- [ ] Home screen API returns data for at least one city
- [ ] Firestore indexes are built (check Console)
- [ ] Firestore rules are deployed
- [ ] Function logs show no errors: `firebase functions:log`
- [ ] API URL saved in iOS app configuration

---

## 🔐 Security Configuration

### Set Admin Custom Claims (for Admin Panel)

```javascript
// Using Firebase Admin SDK in a Node.js script
const admin = require('firebase-admin');
admin.initializeApp();

// Set admin claim for a user
admin.auth().setCustomUserClaims('USER_UID_HERE', { admin: true })
  .then(() => console.log('Admin claim set'))
  .catch(console.error);
```

### Enable App Check (Production)

1. Firebase Console → App Check
2. Add your iOS app
3. Select "DeviceCheck" provider
4. Update iOS app with App Check SDK

---

## 💰 Cost Estimation

### Free Tier (Spark Plan)
- Cloud Functions: 2M invocations/month
- Firestore: 50K reads/day, 20K writes/day
- **Sufficient for development and testing**

### Blaze Plan (Pay-as-you-go)
- Cloud Functions: $0.40 per million invocations
- Firestore: $0.06 per 100K reads
- **Required for production**

### Estimated Monthly Cost (10,000 active users)
- ~1M API calls: $0.40
- ~10M Firestore reads: $6.00
- Total: **~$6.50/month**

---

## 📊 Monitoring

### View Logs
```bash
firebase functions:log

# Tail logs in real-time
firebase functions:log --only api
```

### Firebase Console Dashboards
- **Functions**: Response time, invocations, errors, memory usage
- **Firestore**: Read/write operations, query performance
- **Usage**: Track costs and quotas

---

## 🔄 Update & Redeploy

### Update Code
```bash
cd functions
# Make your code changes
npm run build
cd ..
firebase deploy --only functions
```

### Update Firestore Rules
```bash
# Edit firestore.rules
firebase deploy --only firestore:rules
```

### Update Indexes
```bash
# Edit firestore.indexes.json
firebase deploy --only firestore:indexes
```

---

## 🎓 Next Steps

After successful deployment:

1. **Connect iOS App**:
   - Update API base URL in iOS app
   - Test end-to-end from app

2. **Add More Sample Data**:
   - Add more services
   - Create promotional banners
   - Add more categories

3. **Monitor Performance**:
   - Check response times in Firebase Console
   - Review error logs
   - Optimize slow queries

4. **Implement Phase 2**:
   - Booking APIs
   - Provider matching
   - Real-time updates

---

## 📞 Support

**Issues?**
- Check Firebase Functions logs
- Verify Firestore indexes are built
- Review Firestore rules
- Check Cloud Functions dashboard for errors

**Documentation:**
- Firebase Functions: https://firebase.google.com/docs/functions
- Firestore: https://firebase.google.com/docs/firestore
- TypeScript: https://www.typescriptlang.org/docs/

---

**Deployment Guide Version**: 1.0
**Last Updated**: January 10, 2026
**Maintained by**: CityServe Backend Team
