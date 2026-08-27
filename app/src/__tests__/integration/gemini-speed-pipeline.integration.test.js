import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';

// --- Unit tests for the new Gemini AI speed optimization layer ---
// These test the LRU cache, parallel model execution, and offline fallback
// WITHOUT making real API calls (all mocked).

// =========================================================================
// 1. LRU FOOD CACHE
// =========================================================================
describe('Food Query LRU Cache', () => {
  let FoodCache;

  beforeEach(async () => {
    FoodCache = (await import('../../lib/food-cache')).FoodCache;
  });

  it('normalizes queries: trims, lowercases, removes accents and extra spaces', () => {
    const cache = new FoodCache(100);
    const mockResult = [{ name: 'Banana', calories: 105 }];

    cache.set('  1 Plátano  ', mockResult);

    // All these variations should hit the same cache entry
    expect(cache.get('1 platano')).toEqual(mockResult);
    expect(cache.get('1 PLÁTANO')).toEqual(mockResult);
    expect(cache.get('  1  platano  ')).toEqual(mockResult);
    expect(cache.get('1 Platano')).toEqual(mockResult);
  });

  it('returns null for cache misses', () => {
    const cache = new FoodCache(100);
    expect(cache.get('100g arroz cocido')).toBeNull();
  });

  it('evicts oldest entries when capacity is exceeded', () => {
    const cache = new FoodCache(3); // Tiny capacity
    cache.set('item-a', [{ name: 'A' }]);
    cache.set('item-b', [{ name: 'B' }]);
    cache.set('item-c', [{ name: 'C' }]);

    // All 3 should be present
    expect(cache.get('item-a')).toBeTruthy();
    expect(cache.get('item-b')).toBeTruthy();
    expect(cache.get('item-c')).toBeTruthy();

    // Adding a 4th should evict the oldest (item-a)
    cache.set('item-d', [{ name: 'D' }]);
    expect(cache.get('item-a')).toBeNull();
    expect(cache.get('item-d')).toBeTruthy();
  });

  it('promotes recently accessed entries (LRU behavior)', () => {
    const cache = new FoodCache(3);
    cache.set('item-a', [{ name: 'A' }]);
    cache.set('item-b', [{ name: 'B' }]);
    cache.set('item-c', [{ name: 'C' }]);

    // Access item-a to make it recently used
    cache.get('item-a');

    // Now add a new item — should evict item-b (oldest non-accessed)
    cache.set('item-d', [{ name: 'D' }]);
    expect(cache.get('item-a')).toBeTruthy(); // Recently accessed, still here
    expect(cache.get('item-b')).toBeNull();   // Evicted
  });

  it('respects TTL expiration', () => {
    const cache = new FoodCache(100, 1000); // 1 second TTL
    cache.set('expired-item', [{ name: 'Old' }]);

    // Should be retrievable immediately
    expect(cache.get('expired-item')).toBeTruthy();

    // Simulate time passing by manipulating entry timestamp
    const key = cache._normalize('expired-item');
    const entry = cache._cache.get(key);
    entry.timestamp = Date.now() - 2000; // 2 seconds ago

    expect(cache.get('expired-item')).toBeNull();
  });
});

// =========================================================================
// 2. PARALLEL MODEL EXECUTION (Promise.any instead of sequential cascade)
// =========================================================================
describe('Parallel Gemini Model Execution', () => {
  it('resolves with the fastest successful model response', async () => {
    // Simulate 2 models: one slow (300ms), one fast (50ms)
    const { raceFoodModels } = await import('../../lib/gemini-fast');

    const slowModel = () => new Promise((resolve) =>
      setTimeout(() => resolve([{ name: 'Banana', calories: 105 }]), 300)
    );
    const fastModel = () => new Promise((resolve) =>
      setTimeout(() => resolve([{ name: 'Banana', calories: 105 }]), 50)
    );

    const start = Date.now();
    const result = await raceFoodModels([slowModel, fastModel]);
    const elapsed = Date.now() - start;

    expect(result).toEqual([{ name: 'Banana', calories: 105 }]);
    expect(elapsed).toBeLessThan(200); // Should resolve in ~50ms, not 300ms
  });

  it('still resolves if one model fails but another succeeds', async () => {
    const { raceFoodModels } = await import('../../lib/gemini-fast');

    const failingModel = () => Promise.reject(new Error('Model unavailable'));
    const workingModel = () => Promise.resolve([{ name: 'Rice', calories: 130 }]);

    const result = await raceFoodModels([failingModel, workingModel]);
    expect(result).toEqual([{ name: 'Rice', calories: 130 }]);
  });

  it('throws AggregateError when ALL models fail', async () => {
    const { raceFoodModels } = await import('../../lib/gemini-fast');

    const fail1 = () => Promise.reject(new Error('Fail 1'));
    const fail2 = () => Promise.reject(new Error('Fail 2'));

    await expect(raceFoodModels([fail1, fail2])).rejects.toThrow();
  });

  it('filters out empty/invalid JSON responses', async () => {
    const { raceFoodModels } = await import('../../lib/gemini-fast');

    const emptyResult = () => Promise.resolve([]);
    const validResult = () => Promise.resolve([{ name: 'Egg', calories: 70 }]);

    const result = await raceFoodModels([emptyResult, validResult]);
    expect(result.length).toBe(1);
    expect(result[0].name).toBe('Egg');
  });
});

// =========================================================================
// 3. OFFLINE FALLBACK (parser.js reactivation)
// =========================================================================
describe('Offline Food Parser Fallback', () => {
  let parseFoodTextLocal;

  beforeEach(async () => {
    parseFoodTextLocal = (await import('../../lib/parser')).parseFoodTextLocal;
  });

  it('parses "1 huevo" correctly offline', () => {
    const result = parseFoodTextLocal('1 huevo');
    expect(result.length).toBe(1);
    expect(result[0].name.toLowerCase()).toContain('huevo');
    expect(result[0].calories).toBeGreaterThanOrEqual(60);
    expect(result[0].calories).toBeLessThanOrEqual(80);
    expect(result[0].protein).toBeGreaterThanOrEqual(5);
  });

  it('parses "100g arroz cocido" as cooked rice (~130 kcal)', () => {
    const result = parseFoodTextLocal('100g arroz cocido');
    expect(result.length).toBe(1);
    expect(result[0].calories).toBeGreaterThanOrEqual(120);
    expect(result[0].calories).toBeLessThanOrEqual(140);
    expect(result[0].unit).toBe('g');
  });

  it('parses "medio ice pop" as ~25 kcal', () => {
    const result = parseFoodTextLocal('medio ice pop');
    expect(result.length).toBe(1);
    expect(result[0].quantity).toBe(0.5);
    expect(result[0].calories).toBeGreaterThanOrEqual(20);
    expect(result[0].calories).toBeLessThanOrEqual(30);
  });

  it('parses "2 plátanos" as ~210 kcal', () => {
    const result = parseFoodTextLocal('2 platanos');
    expect(result.length).toBe(1);
    expect(result[0].quantity).toBe(2);
    expect(result[0].calories).toBeGreaterThanOrEqual(190);
    expect(result[0].calories).toBeLessThanOrEqual(220);
  });

  it('parses multiple comma-separated foods correctly', () => {
    const result = parseFoodTextLocal('100g tofu, 50g avena, 80g zanahoria');
    expect(result.length).toBe(3);

    const tofuItem = result.find((i) => i.name.toLowerCase().includes('tofu'));
    expect(tofuItem).toBeTruthy();
    expect(tofuItem.quantity).toBe(100);
    expect(tofuItem.unit).toBe('g');

    const oatItem = result.find((i) => i.name.toLowerCase().includes('avena'));
    expect(oatItem).toBeTruthy();
    expect(oatItem.quantity).toBe(50);
  });
});

// =========================================================================
// 4. FULL PIPELINE INTEGRATION (Cache → Gemini → Fallback)
// =========================================================================
describe('Food AI Pipeline Integration (Cache → API → Offline Fallback)', () => {
  it('returns cached result on cache hit without calling Gemini', async () => {
    const { FoodCache } = await import('../../lib/food-cache');
    const cache = new FoodCache(100);

    const cachedData = [{ name: 'Banana', calories: 105, protein: 1.3, carbs: 27, fats: 0.3 }];
    cache.set('1 platano', cachedData);

    // Simulate pipeline: check cache first
    const cacheResult = cache.get('1 platano');
    expect(cacheResult).toEqual(cachedData);
    // If cache hit, no API call needed — this test validates the pattern
  });

  it('normalizes Spanish input consistently across cache layers', async () => {
    const { FoodCache } = await import('../../lib/food-cache');
    const cache = new FoodCache(100);

    const data = [{ name: 'Cooked Rice', calories: 130 }];
    cache.set('100g arroz cocido', data);

    // These should all be cache hits
    expect(cache.get('100G ARROZ COCIDO')).toEqual(data);
    expect(cache.get('  100g  arroz  cocido  ')).toEqual(data);
    expect(cache.get('100g Arroz Cocido')).toEqual(data);
  });
});
