/**
 * Import Sample Data to Firestore Emulator
 *
 * This script imports all sample data from the sample-data/ folder
 * into the Firestore emulator for local testing.
 *
 * Usage: node import-sample-data.js
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Initialize Firebase Admin SDK for emulator
process.env.FIRESTORE_EMULATOR_HOST = 'localhost:8080';

admin.initializeApp({
  projectId: 'demo-no-project',
});

const db = admin.firestore();

async function importData() {
  console.log('🚀 Starting sample data import...\n');

  try {
    // 1. Import Cities
    console.log('📍 Importing cities...');
    const cities = JSON.parse(
      fs.readFileSync(path.join(__dirname, 'sample-data', 'cities.json'), 'utf8')
    );

    const batch1 = db.batch();
    cities.forEach((city) => {
      const docRef = db.collection('cities').doc(city.id);
      const { id, ...data } = city;
      batch1.set(docRef, data);
    });
    await batch1.commit();
    console.log(`✅ Imported ${cities.length} cities\n`);

    // 2. Import Service Categories
    console.log('🏷️  Importing service categories...');
    const categories = JSON.parse(
      fs.readFileSync(path.join(__dirname, 'sample-data', 'service_categories.json'), 'utf8')
    );

    const batch2 = db.batch();
    categories.forEach((category) => {
      const docRef = db.collection('service_categories').doc(category.id);
      const { id, ...data } = category;
      batch2.set(docRef, data);
    });
    await batch2.commit();
    console.log(`✅ Imported ${categories.length} service categories\n`);

    // 3. Import Services
    console.log('🔧 Importing services...');
    const services = JSON.parse(
      fs.readFileSync(path.join(__dirname, 'sample-data', 'services.json'), 'utf8')
    );

    // Split into batches of 500 (Firestore batch limit)
    for (let i = 0; i < services.length; i += 500) {
      const batch = db.batch();
      const chunk = services.slice(i, i + 500);

      chunk.forEach((service) => {
        const docRef = db.collection('services').doc(service.id);
        const { id, ...data } = service;
        batch.set(docRef, data);
      });

      await batch.commit();
    }
    console.log(`✅ Imported ${services.length} services\n`);

    // 4. Import Promotional Banners
    console.log('🎉 Importing promotional banners...');
    const banners = JSON.parse(
      fs.readFileSync(path.join(__dirname, 'sample-data', 'promotional_banners.json'), 'utf8')
    );

    const batch4 = db.batch();
    banners.forEach((banner) => {
      const docRef = db.collection('promotional_banners').doc(banner.id);
      const { id, ...data } = banner;

      // Convert date strings to Firestore Timestamps
      if (data.validFrom) {
        data.validFrom = admin.firestore.Timestamp.fromDate(new Date(data.validFrom));
      }
      if (data.validUntil) {
        data.validUntil = admin.firestore.Timestamp.fromDate(new Date(data.validUntil));
      }

      batch4.set(docRef, data);
    });
    await batch4.commit();
    console.log(`✅ Imported ${banners.length} promotional banners\n`);

    // 5. Import App Config
    console.log('⚙️  Importing app config...');
    const appConfig = JSON.parse(
      fs.readFileSync(path.join(__dirname, 'sample-data', 'app_config.json'), 'utf8')
    );

    const { id, ...configData } = appConfig;
    await db.collection('app_config').doc('global').set(configData);
    console.log('✅ Imported app config\n');

    console.log('🎉 All sample data imported successfully!');
    console.log('\n📊 Summary:');
    console.log(`   - ${cities.length} cities`);
    console.log(`   - ${categories.length} service categories`);
    console.log(`   - ${services.length} services`);
    console.log(`   - ${banners.length} promotional banners`);
    console.log(`   - 1 app config`);
    console.log('\n✅ You can now test the API with:');
    console.log('   curl "http://127.0.0.1:5001/demo-no-project/asia-south1/api/api/v1/home/screen?cityId=delhi"');
    console.log('\n🌐 View data in Emulator UI: http://127.0.0.1:4000/firestore');

  } catch (error) {
    console.error('❌ Error importing data:', error);
    process.exit(1);
  }

  process.exit(0);
}

// Run import
importData();
