/**
 * LRU Cache for food query results.
 * Avoids redundant Gemini API calls for repeated/similar food inputs.
 *
 * Features:
 * - Normalized keys (lowercase, no accents, trimmed, collapsed whitespace)
 * - Configurable capacity and TTL
 * - LRU eviction (least recently used entries are removed first)
 */

/**
 * Normalize a query string for consistent cache key matching.
 * Removes accents, lowercases, trims, and collapses whitespace.
 */
function normalizeQuery(text) {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // strip diacritics/accents
    .toLowerCase()
    .replace(/\s+/g, ' ')           // collapse whitespace
    .trim();
}

export class FoodCache {
  /**
   * @param {number} capacity - Max number of entries
   * @param {number} ttlMs - Time-to-live in milliseconds (default: 24h)
   */
  constructor(capacity = 200, ttlMs = 24 * 60 * 60 * 1000) {
    this._cache = new Map();
    this._capacity = capacity;
    this._ttlMs = ttlMs;
  }

  _normalize(query) {
    return normalizeQuery(query);
  }

  /**
   * Get a cached result for the given query.
   * Returns null on miss or expired entry.
   */
  get(query) {
    const key = this._normalize(query);
    const entry = this._cache.get(key);

    if (!entry) return null;

    // Check TTL expiration
    if (Date.now() - entry.timestamp > this._ttlMs) {
      this._cache.delete(key);
      return null;
    }

    // Promote to most-recently-used (delete + re-insert at end of Map)
    this._cache.delete(key);
    this._cache.set(key, entry);

    return entry.data;
  }

  /**
   * Store a result in the cache.
   * Evicts the oldest entry if capacity is exceeded.
   */
  set(query, data) {
    const key = this._normalize(query);

    // If key already exists, remove it first (will re-insert at end)
    if (this._cache.has(key)) {
      this._cache.delete(key);
    }

    // Evict oldest if at capacity
    while (this._cache.size >= this._capacity) {
      const oldestKey = this._cache.keys().next().value;
      this._cache.delete(oldestKey);
    }

    this._cache.set(key, {
      data,
      timestamp: Date.now(),
    });
  }

  /**
   * Clear the entire cache.
   */
  clear() {
    this._cache.clear();
  }

  /**
   * Get the current number of entries in the cache.
   */
  get size() {
    return this._cache.size;
  }
}

// Singleton instance for the app
export const foodCache = new FoodCache(200);
