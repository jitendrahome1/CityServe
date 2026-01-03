//
//  CityServeApp.swift
//  CityServe
//
//  Created by Jitendra on 30/12/25.
//

import SwiftUI
import FirebaseCore


@main
struct CityServeApp: App {

    // MARK: - Initialization

    init() {
        // Configure Firebase
        FirebaseApp.configure()

        #if DEBUG
        print("✅ Firebase configured successfully")
        print("📱 Project: cityserve-42e9b")
        print("📦 Bundle ID: com.agarwal.product.com.CityServe")
        // Optional: Use Firebase Emulators for local development
        // configureFirebaseEmulators()
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    // MARK: - Firebase Emulators (Development Only)

    #if DEBUG
    private func configureFirebaseEmulators() {
        // Uncomment when using Firebase Emulator Suite
        /*
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)

        let settings = Firestore.firestore().settings
        settings.host = "localhost:8080"
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings

        Storage.storage().useEmulator(withHost: "localhost", port: 9199)
        Functions.functions().useEmulator(withHost: "localhost", port: 5001)

        print("🔧 Using Firebase Emulators")
        */
    }
    #endif
}
