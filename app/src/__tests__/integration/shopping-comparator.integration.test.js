import { describe, it, expect } from 'vitest';

// Pure price comparator helpers matching ProductsManager and PriceComparator
function getPricesForProduct(productPrices = [], prodName = '') {
  const clean = prodName.toLowerCase().trim();
  return productPrices.filter((p) => {
    const pName = (p.product_name || p.products?.name || '').toLowerCase().trim();
    return pName === clean || pName.includes(clean) || clean.includes(pName);
  });
}

function getCheapestPrice(prices = []) {
  if (!prices || prices.length === 0) return null;
  return [...prices].sort((a, b) => (Number(a.price) || 0) - (Number(b.price) || 0))[0];
}

function aggregateMasterProducts(defaultCatalog = [], shoppingItems = [], recordedPrices = []) {
  const productMap = new Map();

  defaultCatalog.forEach((p) => {
    productMap.set(p.name.toLowerCase().trim(), {
      name: p.name,
      category: p.category,
      unit: p.unit,
      emoji: p.emoji,
    });
  });

  shoppingItems.forEach((item) => {
    if (item.name && !productMap.has(item.name.toLowerCase().trim())) {
      productMap.set(item.name.toLowerCase().trim(), {
        name: item.name,
        category: item.category || 'other',
        unit: item.unit || 'ud',
      });
    }
  });

  recordedPrices.forEach((price) => {
    const pName = price.product_name || price.products?.name;
    if (pName && !productMap.has(pName.toLowerCase().trim())) {
      productMap.set(pName.toLowerCase().trim(), {
        name: pName,
        category: price.category || 'other',
        unit: price.unit || 'ud',
      });
    }
  });

  return Array.from(productMap.values()).sort((a, b) => a.name.localeCompare(b.name));
}

describe('Shopping & Price Comparator Module Integration', () => {
  const mockDefaultCatalog = [
    { name: 'Chicken breast', category: 'carnes', unit: 'kg', emoji: '🍗' },
    { name: 'White rice', category: 'panaderia', unit: 'kg', emoji: '🍚' },
    { name: 'Eggs', category: 'lacteos', unit: 'pack', emoji: '🥚' },
  ];

  const mockShoppingItems = [
    { name: 'Chicken breast', quantity: 2, unit: 'kg' },
    { name: 'Firm Tofu', quantity: 1, unit: 'pack', category: 'carnes' },
  ];

  const mockRecordedPrices = [
    { product_name: 'Chicken breast', price: 280, currency: '₱', unit: 'kg', markets: { name: 'Puregold' } },
    { product_name: 'Chicken breast', price: 260, currency: '₱', unit: 'kg', markets: { name: 'Mercado Local' } },
    { product_name: 'Chicken breast', price: 310, currency: '₱', unit: 'kg', markets: { name: 'SM Supermarket' } },
    { product_name: 'White rice', price: 52, currency: '₱', unit: 'kg', markets: { name: 'Puregold' } },
    { product_name: 'Firm Tofu', price: 45, currency: '₱', unit: 'pack', markets: { name: 'Robinsons' } },
  ];

  describe('Master Product Aggregation & Deduplication', () => {
    it('merges default catalog, user shopping list, and recorded price items without duplicates', () => {
      const masterList = aggregateMasterProducts(mockDefaultCatalog, mockShoppingItems, mockRecordedPrices);
      const names = masterList.map((p) => p.name.toLowerCase());

      expect(masterList.length).toBe(4); // Chicken breast, White rice, Eggs, Firm Tofu
      expect(names).toContain('chicken breast');
      expect(names).toContain('firm tofu');
      expect(names).toContain('white rice');
      expect(names).toContain('eggs');
    });
  });

  describe('Cheapest Price & Market Comparison', () => {
    it('identifies the lowest price and market for a given product', () => {
      const chickenPrices = getPricesForProduct(mockRecordedPrices, 'Chicken breast');
      expect(chickenPrices.length).toBe(3);

      const cheapest = getCheapestPrice(chickenPrices);
      expect(cheapest).not.toBeNull();
      expect(cheapest.price).toBe(260);
      expect(cheapest.markets.name).toBe('Mercado Local');
    });

    it('returns null when a product has no recorded prices', () => {
      const eggPrices = getPricesForProduct(mockRecordedPrices, 'Eggs');
      expect(eggPrices.length).toBe(0);

      const cheapest = getCheapestPrice(eggPrices);
      expect(cheapest).toBeNull();
    });

    it('performs case-insensitive fuzzy matching for product names', () => {
      const matched = getPricesForProduct(mockRecordedPrices, 'chicken breast');
      expect(matched.length).toBe(3);

      const matchedRice = getPricesForProduct(mockRecordedPrices, 'Rice');
      expect(matchedRice.length).toBe(1);
      expect(matchedRice[0].price).toBe(52);
    });
  });
});
