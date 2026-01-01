//
//  FirebaseStorageService.swift
//  CityServe
//
//  Firebase Cloud Storage Service
//  Handles file uploads and downloads
//

import Foundation
// import FirebaseStorage // TODO: Enable when Firebase is configured
import UIKit

class FirebaseStorageService {

    // MARK: - Singleton

    static let shared = FirebaseStorageService()

    // MARK: - Private Properties

    // private let storage = Storage.storage() // TODO: Enable when Firebase is configured
    private let maxImageSize: Int64 = 5 * 1024 * 1024 // 5MB

    // MARK: - Storage Paths

    private enum StoragePath {
        static let userProfiles = "users"
        static let serviceImages = "services"
        static let providerDocuments = "providers/documents"
        static let bookingPhotos = "bookings/photos"
    }

    // MARK: - Initialization

    private init() {
        print("☁️ Firebase Storage configured")
    }

    // MARK: - User Profile Images

    /// Upload user profile image
    /// - Parameters:
    ///   - image: UIImage to upload
    ///   - userId: User ID
    /// - Returns: Download URL of uploaded image
    func uploadProfileImage(_ image: UIImage, userId: String) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw StorageError.invalidImage
        }

        let path = "\(StoragePath.userProfiles)/\(userId)/profile.jpg"
        return try await uploadImage(imageData, path: path, contentType: "image/jpeg")
    }

    /// Upload service image
    /// - Parameters:
    ///   - image: UIImage to upload
    ///   - serviceId: Service ID
    ///   - index: Image index (for multiple images)
    /// - Returns: Download URL
    func uploadServiceImage(_ image: UIImage, serviceId: String, index: Int = 0) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw StorageError.invalidImage
        }

        let path = "\(StoragePath.serviceImages)/\(serviceId)/image_\(index).jpg"
        return try await uploadImage(imageData, path: path, contentType: "image/jpeg")
    }

    /// Upload booking photo
    /// - Parameters:
    ///   - image: UIImage to upload
    ///   - bookingId: Booking ID
    ///   - type: Photo type (before/after/issue)
    /// - Returns: Download URL
    func uploadBookingPhoto(_ image: UIImage, bookingId: String, type: String) async throws -> URL {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw StorageError.invalidImage
        }

        let timestamp = Date().timeIntervalSince1970
        let path = "\(StoragePath.bookingPhotos)/\(bookingId)/\(type)_\(timestamp).jpg"
        return try await uploadImage(imageData, path: path, contentType: "image/jpeg")
    }

    // MARK: - Document Uploads

    /// Upload provider KYC document
    /// - Parameters:
    ///   - data: Document data
    ///   - providerId: Provider ID
    ///   - documentType: Document type (aadhar, pan, etc.)
    ///   - contentType: MIME type
    /// - Returns: Download URL
    func uploadProviderDocument(_ data: Data, providerId: String, documentType: String, contentType: String) async throws -> URL {
        let path = "\(StoragePath.providerDocuments)/\(providerId)/\(documentType)"
        return try await uploadData(data, path: path, contentType: contentType)
    }

    // MARK: - Generic Upload Methods

    /// Upload image data
    private func uploadImage(_ data: Data, path: String, contentType: String) async throws -> URL {
        // Validate size
        guard data.count <= maxImageSize else {
            throw StorageError.fileTooLarge
        }

        return try await uploadData(data, path: path, contentType: contentType)
    }

    /// Upload data with progress tracking
    private func uploadData(_ data: Data, path: String, contentType: String) async throws -> URL {
        // TODO: Enable when Firebase is configured
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference().child(path)

        // Set metadata
        let metadata = StorageMetadata()
        metadata.contentType = contentType

        print("📤 Uploading to: \(path)")

        // Upload data
        _ = try await storageRef.putDataAsync(data, metadata: metadata)

        // Get download URL
        let downloadURL = try await storageRef.downloadURL()

        print("✅ Upload complete: \(downloadURL.absoluteString)")
        return downloadURL
        */
    }

    // MARK: - Download Methods

    /// Download image from URL
    /// - Parameter url: Firebase Storage URL
    /// - Returns: UIImage
    func downloadImage(from url: URL) async throws -> UIImage {
        // TODO: Enable when Firebase is configured
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference(forURL: url.absoluteString)

        let data = try await storageRef.data(maxSize: maxImageSize)

        guard let image = UIImage(data: data) else {
            throw StorageError.invalidImage
        }

        return image
        */
    }

    /// Download image from path
    /// - Parameter path: Storage path
    /// - Returns: UIImage
    func downloadImage(path: String) async throws -> UIImage {
        // TODO: Enable when Firebase is configured
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference().child(path)

        let data = try await storageRef.data(maxSize: maxImageSize)

        guard let image = UIImage(data: data) else {
            throw StorageError.invalidImage
        }

        return image
        */
    }

    // MARK: - Delete Methods

    /// Delete file at path
    /// - Parameter path: Storage path
    func deleteFile(path: String) async throws {
        // TODO: Enable when Firebase is configured
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference().child(path)

        try await storageRef.delete()

        print("🗑️ File deleted: \(path)")
        */
    }

    /// Delete user profile image
    func deleteProfileImage(userId: String) async throws {
        let path = "\(StoragePath.userProfiles)/\(userId)/profile.jpg"
        try await deleteFile(path: path)
    }

    // MARK: - Helper Methods

    /// Get metadata for file
    func getMetadata(path: String) async throws -> String {
        // TODO: Enable when Firebase is configured - Return type changed from StorageMetadata to String
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference().child(path)
        return try await storageRef.getMetadata()
        */
    }

    /// List all files in directory
    func listFiles(path: String, maxResults: Int = 100) async throws -> [String] {
        // TODO: Enable when Firebase is configured - Return type changed from [StorageReference] to [String]
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference().child(path)
        let result = try await storageRef.list(maxResults: Int64(maxResults))
        return result.items
        */
    }
}

// MARK: - Storage Upload with Progress

extension FirebaseStorageService {

    /// Upload data with progress tracking
    /// - Parameters:
    ///   - data: Data to upload
    ///   - path: Storage path
    ///   - contentType: MIME type
    ///   - progressHandler: Progress callback (0.0 to 1.0)
    /// - Returns: Download URL
    func uploadDataWithProgress(
        _ data: Data,
        path: String,
        contentType: String,
        progressHandler: @escaping (Double) -> Void
    ) async throws -> URL {
        // TODO: Enable when Firebase is configured
        throw StorageError.notConfigured
        /*
        let storageRef = storage.reference().child(path)

        let metadata = StorageMetadata()
        metadata.contentType = contentType

        return try await withCheckedThrowingContinuation { continuation in
            let uploadTask = storageRef.putData(data, metadata: metadata)

            // Observe progress
            uploadTask.observe(.progress) { snapshot in
                guard let progress = snapshot.progress else { return }
                let percentComplete = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
                progressHandler(percentComplete)
            }

            // Observe completion
            uploadTask.observe(.success) { snapshot in
                storageRef.downloadURL { url, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let url = url {
                        continuation.resume(returning: url)
                    }
                }
            }

            // Observe failure
            uploadTask.observe(.failure) { snapshot in
                if let error = snapshot.error {
                    continuation.resume(throwing: error)
                }
            }
        }
        */
    }
}

// MARK: - Image Compression

extension FirebaseStorageService {

    /// Compress image to target size
    /// - Parameters:
    ///   - image: Original image
    ///   - maxSizeKB: Maximum size in KB
    /// - Returns: Compressed image data
    func compressImage(_ image: UIImage, maxSizeKB: Int = 500) -> Data? {
        var compression: CGFloat = 1.0
        var imageData = image.jpegData(compressionQuality: compression)

        while let data = imageData, data.count > maxSizeKB * 1024 && compression > 0.1 {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }

        return imageData
    }

    /// Resize image to maximum dimensions
    /// - Parameters:
    ///   - image: Original image
    ///   - maxWidth: Maximum width
    ///   - maxHeight: Maximum height
    /// - Returns: Resized image
    func resizeImage(_ image: UIImage, maxWidth: CGFloat = 1024, maxHeight: CGFloat = 1024) -> UIImage {
        let size = image.size
        let widthRatio = maxWidth / size.width
        let heightRatio = maxHeight / size.height
        let ratio = min(widthRatio, heightRatio, 1.0)

        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage ?? image
    }
}

// MARK: - Storage Errors

enum StorageError: LocalizedError {
    case invalidImage
    case fileTooLarge
    case uploadFailed
    case downloadFailed
    case permissionDenied
    case notConfigured

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "Invalid image format"
        case .fileTooLarge:
            return "File size exceeds maximum limit (5MB)"
        case .uploadFailed:
            return "Upload failed. Please try again."
        case .downloadFailed:
            return "Download failed. Please try again."
        case .permissionDenied:
            return "Permission denied. Please check your credentials."
        case .notConfigured:
            return "Firebase Storage is not configured yet."
        }
    }
}
