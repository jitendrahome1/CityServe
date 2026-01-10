#!/bin/bash

echo "🚀 Starting CityServe Backend Locally..."
echo ""

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI not found. Installing..."
    npm install -g firebase-tools
fi

# Check if functions dependencies are installed
if [ ! -d "functions/node_modules" ]; then
    echo "📦 Installing dependencies..."
    cd functions
    npm install
    cd ..
fi

echo "✅ All prerequisites met!"
echo ""
echo "🔥 Starting Firebase Emulators..."
echo ""
echo "📊 Emulator UI will open at: http://localhost:4000"
echo "🌐 API will be available at: http://localhost:5001/[PROJECT_ID]/asia-south1/api"
echo ""
echo "💡 Press Ctrl+C to stop the emulators"
echo ""

# Start emulators
firebase emulators:start
