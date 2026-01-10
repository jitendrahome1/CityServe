"use strict";
/**
 * Home Repository Layer
 *
 * Handles all Firestore database operations for the Home Screen module.
 * Encapsulates data access logic and provides a clean interface for the service layer.
 *
 * Design Principles:
 * - Single Responsibility: Only handles data access
 * - No business logic: Pure data fetching/writing
 * - Type-safe: Strongly typed return values
 * - Error propagation: Lets service layer handle errors
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.HomeRepository = void 0;
const firebase_admin_1 = require("../../common/firebase.admin");
const types_1 = require("../../types");
const error_handler_1 = require("../../common/error.handler");
/**
 * Repository class for Home Screen data operations
 */
class HomeRepository {
    /**
     * Fetch city by ID
     *
     * @param cityId - City identifier
     * @returns City document or throws NotFoundError
     */
    async getCityById(cityId) {
        const cityDoc = await firebase_admin_1.db.collection(types_1.COLLECTIONS.CITIES).doc(cityId).get();
        if (!cityDoc.exists) {
            throw new error_handler_1.NotFoundError('City');
        }
        return { id: cityDoc.id, ...cityDoc.data() };
    }
    /**
     * Fetch all active service categories for a city
     * Sorted by sortOrder for consistent UI display
     *
     * @param cityId - City identifier
     * @returns Array of active categories
     */
    async getCategoriesByCity(cityId) {
        const snapshot = await firebase_admin_1.db
            .collection(types_1.COLLECTIONS.SERVICE_CATEGORIES)
            .where('isActive', '==', true)
            .where('availableCities', 'array-contains', cityId)
            .orderBy('sortOrder', 'asc')
            .get();
        return snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
        }));
    }
    /**
     * Fetch popular services for a city
     * Limited to top N services based on rating and popularity
     *
     * @param cityId - City identifier
     * @param limit - Maximum number of services to return
     * @returns Array of popular services
     */
    async getPopularServices(cityId, limit = 10) {
        const snapshot = await firebase_admin_1.db
            .collection(types_1.COLLECTIONS.SERVICES)
            .where('isActive', '==', true)
            .where('isPopular', '==', true)
            .where('availableCities', 'array-contains', cityId)
            .orderBy('rating', 'desc')
            .limit(limit)
            .get();
        return snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
        }));
    }
    /**
     * Fetch trending services for a city
     * Services marked as trending, sorted by rating
     *
     * @param cityId - City identifier
     * @param limit - Maximum number of services to return
     * @returns Array of trending services
     */
    async getTrendingServices(cityId, limit = 6) {
        const snapshot = await firebase_admin_1.db
            .collection(types_1.COLLECTIONS.SERVICES)
            .where('isActive', '==', true)
            .where('isTrending', '==', true)
            .where('availableCities', 'array-contains', cityId)
            .orderBy('rating', 'desc')
            .limit(limit)
            .get();
        return snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
        }));
    }
    /**
     * Fetch active promotional banners for a city
     * Filters by:
     * - Active status
     * - Current time within valid period
     * - City targeting (empty array = all cities)
     * Sorted by displayOrder for consistent positioning
     *
     * @param cityId - City identifier
     * @returns Array of active banners
     */
    async getBannersByCity(cityId) {
        // Note: Simplified for local testing - showing all active banners without time filtering
        // In production, add time-based filtering with validFrom/validUntil
        // Fetch banners targeted to this city
        const cityTargetedSnapshot = await firebase_admin_1.db
            .collection(types_1.COLLECTIONS.PROMOTIONAL_BANNERS)
            .where('isActive', '==', true)
            .where('targetCities', 'array-contains', cityId)
            .orderBy('displayOrder', 'asc')
            .get();
        // Fetch banners targeted to all cities (empty targetCities array)
        const allCitiesSnapshot = await firebase_admin_1.db
            .collection(types_1.COLLECTIONS.PROMOTIONAL_BANNERS)
            .where('isActive', '==', true)
            .where('targetCities', '==', [])
            .orderBy('displayOrder', 'asc')
            .get();
        // Combine and deduplicate
        const bannersMap = new Map();
        cityTargetedSnapshot.docs.forEach((doc) => {
            bannersMap.set(doc.id, { id: doc.id, ...doc.data() });
        });
        allCitiesSnapshot.docs.forEach((doc) => {
            if (!bannersMap.has(doc.id)) {
                bannersMap.set(doc.id, { id: doc.id, ...doc.data() });
            }
        });
        // Convert to array and sort by displayOrder
        return Array.from(bannersMap.values()).sort((a, b) => a.displayOrder - b.displayOrder);
    }
    /**
     * Fetch global app configuration
     * Includes trust indicators, feature flags, and constants
     *
     * @returns App configuration document
     */
    async getAppConfig() {
        const configDoc = await firebase_admin_1.db.collection(types_1.COLLECTIONS.APP_CONFIG).doc('global').get();
        if (!configDoc.exists) {
            throw new error_handler_1.NotFoundError('App configuration');
        }
        return { id: 'global', ...configDoc.data() };
    }
    /**
     * Record banner impression (analytics)
     * Increments the impressions counter
     *
     * @param bannerId - Banner identifier
     */
    async incrementBannerImpressions(bannerId) {
        const bannerRef = firebase_admin_1.db.collection(types_1.COLLECTIONS.PROMOTIONAL_BANNERS).doc(bannerId);
        await bannerRef.update({
            impressions: firebase_admin_1.FieldValue.increment(1),
        });
    }
    /**
     * Fetch user preferences (optional, for personalization)
     *
     * @param userId - User identifier
     * @returns User preferences or null if not found
     */
    async getUserPreferences(userId) {
        const prefDoc = await firebase_admin_1.db
            .collection(types_1.COLLECTIONS.USERS)
            .doc(userId)
            .collection(types_1.COLLECTIONS.USER_PREFERENCES)
            .doc('settings')
            .get();
        if (!prefDoc.exists) {
            return null;
        }
        return prefDoc.data();
    }
}
exports.HomeRepository = HomeRepository;
//# sourceMappingURL=home.repository.js.map