import React, { useState, useMemo } from 'react';
import { Package, Plus, ShoppingBag, Tag, Search, Check, Store } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

const CATEGORIES = [
  { id: 'all', label: 'All Categories', emoji: '📦' },
  { id: 'frutas', label: 'Fruits & Veggies', emoji: '🥑' },
  { id: 'carnes', label: 'Meat & Fish', emoji: '🍗' },
  { id: 'lacteos', label: 'Dairy & Eggs', emoji: '🧀' },
  { id: 'panaderia', label: 'Bread & Cereals', emoji: '🍞' },
  { id: 'bebidas', label: 'Drinks', emoji: '🧃' },
  { id: 'limpieza', label: 'Cleaning & Home', emoji: '🧹' },
  { id: 'other', label: 'Others', emoji: '📦' },
];

const DEFAULT_MASTER_CATALOG = [
  { name: 'Chicken breast', category: 'carnes', unit: 'kg', emoji: '🍗' },
  { name: 'Fresh Milk', category: 'lacteos', unit: 'L', emoji: '🥛' },
  { name: 'Eggs', category: 'lacteos', unit: 'pack', emoji: '🥚' },
  { name: 'White rice', category: 'panaderia', unit: 'kg', emoji: '🍚' },
  { name: 'Oatmeal', category: 'panaderia', unit: 'kg', emoji: '🥣' },
  { name: 'Whole wheat bread', category: 'panaderia', unit: 'ud', emoji: '🍞' },
  { name: 'Avocado', category: 'frutas', unit: 'ud', emoji: '🥑' },
  { name: 'Carrots', category: 'frutas', unit: 'kg', emoji: '🥕' },
  { name: 'Apples', category: 'frutas', unit: 'kg', emoji: '🍎' },
  { name: 'Bananas', category: 'frutas', unit: 'kg', emoji: '🍌' },
  { name: 'Firm Tofu', category: 'carnes', unit: 'kg', emoji: '🍽️' },
  { name: 'Canned tuna', category: 'carnes', unit: 'ud', emoji: '🐟' },
  { name: 'Fresh cheese', category: 'lacteos', unit: 'ud', emoji: '🧀' },
  { name: 'Natural yogurt', category: 'lacteos', unit: 'ud', emoji: '🍨' },
  { name: 'Olive oil', category: 'frutas', unit: 'L', emoji: '🫒' },
  { name: 'Coffee', category: 'bebidas', unit: 'ud', emoji: '☕' },
  { name: 'Pasta', category: 'panaderia', unit: 'kg', emoji: '🍝' },
  { name: 'Salmon', category: 'carnes', unit: 'kg', emoji: '🐟' },
  { name: 'Broccoli', category: 'frutas', unit: 'kg', emoji: '🥦' },
  { name: 'Mineral Water', category: 'bebidas', unit: 'L', emoji: '💧' },
];

export default function ProductsManager({
  items = [],
  productPrices = [],
  onAddItem,
  onOpenComparator,
}) {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [addedItemNames, setAddedItemNames] = useState(new Set());

  // Derive consolidated list of unique master products
  const masterProducts = useMemo(() => {
    const productMap = new Map();

    // 1. Add default catalog items
    DEFAULT_MASTER_CATALOG.forEach((p) => {
      productMap.set(p.name.toLowerCase().trim(), { ...p });
    });

    // 2. Add items from shopping list
    items.forEach((i) => {
      if (i.name && i.name.trim()) {
        const key = i.name.toLowerCase().trim();
        const existing = productMap.get(key);
        productMap.set(key, {
          name: i.name.trim(),
          category: i.category || existing?.category || 'other',
          unit: i.unit || existing?.unit || 'ud',
          emoji: existing?.emoji || '📦',
        });
      }
    });

    // 3. Add items from price comparator
    productPrices.forEach((p) => {
      const pName = p.product_name || p.products?.name;
      if (pName && pName.trim()) {
        const key = pName.toLowerCase().trim();
        const existing = productMap.get(key);
        productMap.set(key, {
          name: pName.trim(),
          category: existing?.category || 'other',
          unit: p.unit || existing?.unit || 'kg',
          emoji: existing?.emoji || '📦',
        });
      }
    });

    return Array.from(productMap.values()).sort((a, b) => a.name.localeCompare(b.name));
  }, [items, productPrices]);

  // Helper to find recorded prices for a product
  const getPricesForProduct = (prodName) => {
    const clean = prodName.toLowerCase().trim();
    return productPrices.filter((p) => {
      const pName = (p.product_name || p.products?.name || '').toLowerCase().trim();
      return pName === clean || pName.includes(clean) || clean.includes(pName);
    });
  };

  const getCheapestPrice = (prices) => {
    if (!prices || prices.length === 0) return null;
    return [...prices].sort((a, b) => (a.price || 0) - (b.price || 0))[0];
  };

  // Filtered products list
  const filteredProducts = useMemo(() => {
    return masterProducts.filter((p) => {
      const matchesSearch =
        !searchQuery || p.name.toLowerCase().includes(searchQuery.toLowerCase().trim());
      const matchesCategory =
        selectedCategory === 'all' || p.category === selectedCategory;
      return matchesSearch && matchesCategory;
    });
  }, [masterProducts, searchQuery, selectedCategory]);

  const handleQuickAddToList = (prod) => {
    if (typeof onAddItem === 'function') {
      onAddItem({
        name: prod.name,
        quantity: 1,
        unit: prod.unit || 'ud',
        category: prod.category || 'other',
        is_checked: false,
      });
    }

    setAddedItemNames((prev) => new Set(prev).add(prod.name));
    setTimeout(() => {
      setAddedItemNames((prev) => {
        const next = new Set(prev);
        next.delete(prod.name);
        return next;
      });
    }, 2000);
  };

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Header Search & Category Filter Card */}
      <Card className="p-5 sm:p-6 shadow-sm space-y-4">
        <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3">
          <CardTitle icon={Package}>Products Catalog ({masterProducts.length})</CardTitle>
          <div className="relative flex-1 sm:max-w-xs">
            <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
            <Input
              type="text"
              placeholder="Search product..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-9 w-full"
            />
          </div>
        </div>

        {/* Category Pills */}
        <div className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1">
          {CATEGORIES.map((cat) => (
            <button
              key={cat.id}
              onClick={() => setSelectedCategory(cat.id)}
              className={`px-3.5 py-2 rounded-xl text-xs font-semibold whitespace-nowrap transition-all ${
                selectedCategory === cat.id
                  ? 'bg-indigo-600 text-white shadow-sm'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              {cat.emoji} {cat.label}
            </button>
          ))}
        </div>
      </Card>

      {/* Product Cards Grid */}
      {filteredProducts.length === 0 ? (
        <Card className="text-center py-12 space-y-3">
          <Package className="w-12 h-12 text-slate-300 mx-auto" />
          <p className="text-sm font-medium text-slate-500">No products found matching your search.</p>
        </Card>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredProducts.map((prod, idx) => {
            const prices = getPricesForProduct(prod.name);
            const cheapest = getCheapestPrice(prices);
            const isJustAdded = addedItemNames.has(prod.name);
            const catObj = CATEGORIES.find((c) => c.id === prod.category) || CATEGORIES[7];

            return (
              <Card
                key={idx}
                className="p-4 sm:p-5 flex flex-col justify-between space-y-4 hover:border-indigo-200 transition-all shadow-sm group"
              >
                <div className="space-y-2">
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex items-center gap-2.5 min-w-0">
                      <span className="text-2xl shrink-0">{prod.emoji || catObj.emoji}</span>
                      <h4 className="font-bold text-sm sm:text-base text-slate-900 truncate">
                        {prod.name}
                      </h4>
                    </div>
                    <span className="text-[11px] font-semibold px-2.5 py-0.5 rounded-full bg-slate-100 text-slate-600 shrink-0">
                      {catObj.label}
                    </span>
                  </div>

                  {/* Recorded Prices Summary */}
                  {cheapest ? (
                    <div className="flex items-center justify-between text-xs p-2.5 rounded-xl bg-emerald-50/80 border border-emerald-200/80">
                      <span className="flex items-center gap-1 text-emerald-800 font-medium truncate">
                        <Store className="w-3.5 h-3.5 shrink-0" />
                        <span className="truncate">{cheapest.markets?.name || 'Best Store'}</span>
                      </span>
                      <span className="font-bold font-mono text-emerald-700 shrink-0">
                        {cheapest.currency || '₱'} {cheapest.price}/{cheapest.unit || 'ud'}
                      </span>
                    </div>
                  ) : (
                    <div className="text-[11px] text-slate-400 font-medium px-2 py-1 bg-slate-50 rounded-lg border border-slate-100 flex items-center justify-between">
                      <span>No prices recorded yet</span>
                      {prices.length > 0 && <span className="font-semibold">{prices.length} prices</span>}
                    </div>
                  )}
                </div>

                {/* Actions */}
                <div className="flex items-center gap-2 pt-2 border-t border-slate-100">
                  <Button
                    type="button"
                    variant={isJustAdded ? 'success' : 'secondary'}
                    size="sm"
                    icon={isJustAdded ? Check : Plus}
                    onClick={() => handleQuickAddToList(prod)}
                    className="flex-1 text-xs"
                  >
                    {isJustAdded ? 'Added!' : 'Add to List'}
                  </Button>

                  {typeof onOpenComparator === 'function' && (
                    <button
                      type="button"
                      onClick={() => onOpenComparator(prod.name)}
                      className="p-2 text-slate-400 hover:text-indigo-600 hover:bg-indigo-50 rounded-xl transition-all shrink-0 cursor-pointer"
                      title="Compare or record price"
                    >
                      <Tag className="w-4 h-4" />
                    </button>
                  )}
                </div>
              </Card>
            );
          })}
        </div>
      )}
    </div>
  );
}
