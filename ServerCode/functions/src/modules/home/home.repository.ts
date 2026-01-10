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

import { db, FieldValue } from '../../common/firebase.admin';
import {
  City,
  ServiceCategory,
  Service,
  PromotionalBanner,
  AppConfig,
  COLLECTIONS,
} from '../../types';
import { NotFoundError } from '../../common/error.handler';

/**
 * Repository class for Home Screen data operations
 */
export class HomeRepository {
  /**
   * Fetch city by ID
   *
   * @param cityId - City identifier
   * @returns City document or throws NotFoundError
   */
  async getCityById(cityId: string): Promise<City> {
    const cityDoc = await db.collection(COLLECTIONS.CITIES).doc(cityId).get();

    if (!cityDoc.exists) {
      throw new NotFoundError('City');
    }

    return { id: cityDoc.id, ...cityDoc.data() } as City;
  }

  /**
   * Fetch all active service categories for a city
   * Sorted by sortOrder for consistent UI display
   *
   * @param cityId - City identifier
   * @returns Array of active categories
   */
  async getCategoriesByCity(cityId: string): Promise<ServiceCategory[]> {
    const snapshot = await db
      .collection(COLLECTIONS.SERVICE_CATEGORIES)
      .where('isActive', '==', true)
      .where('availableCities', 'array-contains', cityId)
      .orderBy('sortOrder', 'asc')
      .get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    })) as ServiceCategory[];
  }

  /**
   * Fetch popular services for a city
   * Limited to top N services based on rating and popularity
   *
   * @param cityId - City identifier
   * @param limit - Maximum number of services to return
   * @returns Array of popular services
   */
  async getPopularServices(cityId: string, limit: number = 10): Promise<Service[]> {
    const snapshot = await db
      .collection(COLLECTIONS.SERVICES)
      .where('isActive', '==', true)
      .where('isPopular', '==', true)
      .where('availableCities', 'array-contains', cityId)
      .orderBy('rating', 'desc')
      .limit(limit)
      .get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    })) as Service[];
  }

  /**
   * Fetch trending services for a city
   * Services marked as trending, sorted by rating
   *
   * @param cityId - City identifier
   * @param limit - Maximum number of services to return
   * @returns Array of trending services
   */
  async getTrendingServices(cityId: string, limit: number = 6): Promise<Service[]> {
    const snapshot = await db
      .collection(COLLECTIONS.SERVICES)
      .where('isActive', '==', true)
      .where('isTrending', '==', true)
      .where('availableCities', 'array-contains', cityId)
      .orderBy('rating', 'desc')
      .limit(limit)
      .get();

    return snapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    })) as Service[];
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
  async getBannersByCity(cityId: string): Promise<PromotionalBanner[]> {
    // Note: Simplified for local testing - showing all active banners without time filtering
    // In production, add time-based filtering with validFrom/validUntil

    // Fetch banners targeted to this city
    const cityTargetedSnapshot = await db
      .collection(COLLECTIONS.PROMOTIONAL_BANNERS)
      .where('isActive', '==', true)
      .where('targetCities', 'array-contains', cityId)
      .orderBy('displayOrder', 'asc')
      .get();

    // Fetch banners targeted to all cities (empty targetCities array)
    const allCitiesSnapshot = await db
      .collection(COLLECTIONS.PROMOTIONAL_BANNERS)
      .where('isActive', '==', true)
      .where('targetCities', '==', [])
      .orderBy('displayOrder', 'asc')
      .get();

    // Combine and deduplicate
    const bannersMap = new Map<string, PromotionalBanner>();

    cityTargetedSnapshot.docs.forEach((doc) => {
      bannersMap.set(doc.id, { id: doc.id, ...doc.data() } as PromotionalBanner);
    });

    allCitiesSnapshot.docs.forEach((doc) => {
      if (!bannersMap.has(doc.id)) {
        bannersMap.set(doc.id, { id: doc.id, ...doc.data() } as PromotionalBanner);
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
  async getAppConfig(): Promise<AppConfig> {
    const configDoc = await db.collection(COLLECTIONS.APP_CONFIG).doc('global').get();

    if (!configDoc.exists) {
      throw new NotFoundError('App configuration');
    }

    return { id: 'global', ...configDoc.data() } as AppConfig;
  }

  /**
   * Record banner impression (analytics)
   * Increments the impressions counter
   *
   * @param bannerId - Banner identifier
   */
  async incrementBannerImpressions(bannerId: string): Promise<void> {
    const bannerRef = db.collection(COLLECTIONS.PROMOTIONAL_BANNERS).doc(bannerId);

    await bannerRef.update({
      impressions: FieldValue.increment(1),
    });
  }

  /**
   * Fetch user preferences (optional, for personalization)
   *
   * @param userId - User identifier
   * @returns User preferences or null if not found
   */
  async getUserPreferences(userId: string): Promise<{ selectedCity: string } | null> {
    const prefDoc = await db
      .collection(COLLECTIONS.USERS)
      .doc(userId)
      .collection(COLLECTIONS.USER_PREFERENCES)
      .doc('settings')
      .get();

    if (!prefDoc.exists) {
      return null;
    }

    return prefDoc.data() as { selectedCity: string };
  }
}
