import React, { useState } from 'react';
import { Tag, Plus, ArrowUpDown, Award, Trash2, Edit3, X, Check, Store } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

export default function PriceComparator({ markets, productPrices, onSavePrice, onDeletePrice, onSaveMarket }) {
  const [productNameInput, setProductNameInput] = useState('');
  const [selectedMarketId, setSelectedMarketId] = useState(markets[0]?.id || '');
  const [priceInput, setPriceInput] = useState('');
  const [currencyInput, setCurrencyInput] = useState('PHP');
  const [unitInput, setUnitInput] = useState('kg');

  // Editing state
  const [editingPriceId, setEditingPriceId] = useState(null);
  const [showSuggestions, setShowSuggestions] = useState(false);

  // Derive unique list of all known products (default catalog + market prices)
  const allProductSuggestions = React.useMemo(() => {
    const defaultCatalog = [
      'Pechuga de pollo',
      'Leche entera',
      'Huevos frescos',
      'Arroz blanco',
      'Avena integral',
      'Pan integral',
      'Aguacate',
      'Zanahorias',
      'Manzanas',
      'Plátanos',
      'Tofu',
      'Atún en lata',
      'Queso fresco',
      'Yogur natural',
      'Aceite de oliva',
      'Café molido',
      'Pasta / Spaghettis',
      'Chicken breast',
      'Fresh Milk',
      'Eggs',
      'Salmon',
      'Broccoli',
    ];

    const set = new Set(defaultCatalog);
    (productPrices || []).forEach((p) => {
      const pName = p.product_name || p.products?.name;
      if (pName && pName.trim()) set.add(pName.trim());
    });

    return Array.from(set).sort((a, b) => a.localeCompare(b));
  }, [productPrices]);

  const filteredSuggestions = React.useMemo(() => {
    const query = productNameInput.trim().toLowerCase();
    if (!query) return [];
    return allProductSuggestions
      .filter((prod) => prod.toLowerCase().includes(query) && prod.toLowerCase() !== query)
      .slice(0, 7);
  }, [productNameInput, allProductSuggestions]);

  // Quick Store Modal State
  const [isNewStoreModalOpen, setIsNewStoreModalOpen] = useState(false);
  const [newStoreName, setNewStoreName] = useState('');
  const [newStoreAddress, setNewStoreAddress] = useState('');
  const [newStoreEmoji, setNewStoreEmoji] = useState('🏪');

  const handleQuickSaveStore = async (e) => {
    e.preventDefault();
    if (!newStoreName.trim() || !onSaveMarket) return;

    const saved = await onSaveMarket({
      name: newStoreName.trim(),
      address: newStoreAddress.trim() || null,
      emoji: newStoreEmoji,
    });

    if (saved && saved.id) {
      setSelectedMarketId(saved.id);
    }

    setNewStoreName('');
    setNewStoreAddress('');
    setIsNewStoreModalOpen(false);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!productNameInput.trim() || !selectedMarketId || !priceInput) return;

    onSavePrice({
      id: editingPriceId || null,
      product_name: productNameInput.trim(),
      market_id: selectedMarketId,
      price: parseFloat(priceInput),
      currency: currencyInput,
      unit: unitInput,
    });

    handleReset();
  };

  const handleStartEdit = (p) => {
    setEditingPriceId(p.id);
    setProductNameInput(p.product_name || p.products?.name || '');
    setSelectedMarketId(p.market_id);
    setPriceInput(p.price.toString());
    setCurrencyInput(p.currency || 'PHP');
    setUnitInput(p.unit || 'kg');
  };

  const handleReset = () => {
    setEditingPriceId(null);
    setProductNameInput('');
    setPriceInput('');
  };

  const handleDelete = (priceId) => {
    if (window.confirm('Delete this price record?')) {
      onDeletePrice(priceId);
    }
  };

  const groupedPrices = productPrices.reduce((acc, item) => {
    const key = item.product_name || item.products?.name || 'Others';
    if (!acc[key]) acc[key] = [];
    acc[key].push(item);
    return acc;
  }, {});

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Price Form */}
      <Card className="p-5 sm:p-6 shadow-sm">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="flex items-center justify-between">
            <CardTitle icon={Tag}>
              {editingPriceId ? 'Edit Product Price' : 'Link Product Price'}
            </CardTitle>
            {editingPriceId && (
              <button
                type="button"
                onClick={handleReset}
                className="text-xs font-semibold text-slate-500 hover:text-slate-900 flex items-center gap-1"
              >
                <X className="w-4 h-4" /> Cancel Edit
              </button>
            )}
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div className="relative">
              <Input
                type="text"
                placeholder="Product name (e.g., Chicken breast)"
                aria-label="Product name"
                value={productNameInput}
                onChange={(e) => {
                  setProductNameInput(e.target.value);
                  setShowSuggestions(true);
                }}
                onFocus={() => setShowSuggestions(true)}
                onBlur={() => setTimeout(() => setShowSuggestions(false), 200)}
                required
                className="w-full"
                autoComplete="off"
              />

              {showSuggestions && filteredSuggestions.length > 0 && (
                <div className="absolute left-0 right-0 top-full mt-1.5 bg-white/95 backdrop-blur-md border border-slate-200/90 rounded-2xl shadow-xl z-50 overflow-hidden divide-y divide-slate-100 max-h-56 overflow-y-auto transition-all animate-in fade-in slide-in-from-top-2">
                  {filteredSuggestions.map((prod, idx) => (
                    <button
                      key={idx}
                      type="button"
                      onMouseDown={(e) => {
                        e.preventDefault();
                        setProductNameInput(prod);
                        setShowSuggestions(false);
                      }}
                      className="w-full text-left px-4 py-2.5 hover:bg-indigo-50 hover:text-indigo-600 font-medium text-xs sm:text-sm text-slate-700 transition-colors flex items-center justify-between group cursor-pointer"
                    >
                      <span className="truncate font-semibold">{prod}</span>
                      <span className="text-[10px] text-slate-400 group-hover:text-indigo-600 font-bold px-2 py-0.5 rounded-full bg-slate-100 group-hover:bg-indigo-100 shrink-0">
                        Select
                      </span>
                    </button>
                  ))}
                </div>
              )}
            </div>

            <div className="space-y-1">
              <div className="flex items-center justify-between">
                <label className="block text-xs font-semibold text-slate-700">Store / Market</label>
                <button
                  type="button"
                  onClick={() => setIsNewStoreModalOpen(true)}
                  className="text-xs font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1 cursor-pointer"
                >
                  <Plus className="w-3.5 h-3.5" /> New Store
                </button>
              </div>

              <Select
                aria-label="Select Store"
                value={selectedMarketId}
                onChange={(e) => setSelectedMarketId(e.target.value)}
                required
              >
                <option value="" disabled>
                  Select Store...
                </option>
                {markets.map((m) => (
                  <option key={m.id} value={m.id}>
                    {m.emoji || '🏪'} {m.name}
                  </option>
                ))}
              </Select>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row gap-3">
            <Input
              type="number"
              step="any"
              placeholder="Price (e.g., 4.50)"
              aria-label="Price"
              value={priceInput}
              onChange={(e) => setPriceInput(e.target.value)}
              className="flex-1 font-mono font-bold"
              required
            />

            <div className="flex gap-2">
              <Select
                aria-label="Currency"
                value={currencyInput}
                onChange={(e) => setCurrencyInput(e.target.value)}
                className="w-28 font-bold"
              >
                <option value="PHP">₱ PHP</option>
                <option value="EUR">€ EUR</option>
                <option value="USD">$ USD</option>
              </Select>

              <Select
                aria-label="Unit of measure"
                value={unitInput}
                onChange={(e) => setUnitInput(e.target.value)}
                className="w-24 font-bold"
              >
                <option value="kg">/ kg</option>
                <option value="ud">/ pc</option>
                <option value="L">/ L</option>
                <option value="pack">/ pack</option>
              </Select>

              <Button type="submit" icon={editingPriceId ? Check : Plus} variant="primary" className="shrink-0">
                {editingPriceId ? 'Update Price' : 'Save'}
              </Button>
            </div>
          </div>
        </form>
      </Card>

      {/* Comparison Matrix */}
      <div className="space-y-4">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Recorded Price Comparisons ({Object.keys(groupedPrices).length} products)
        </h3>

        {Object.keys(groupedPrices).length === 0 ? (
          <Card className="text-center py-10 space-y-3">
            <ArrowUpDown className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No price comparisons recorded yet.</p>
          </Card>
        ) : (
          <div className="space-y-5 sm:space-y-6">
            {Object.entries(groupedPrices).map(([productName, priceList]) => {
              const sorted = [...priceList].sort((a, b) => a.price - b.price);
              const cheapestId = sorted[0]?.id;

              return (
                <Card key={productName} className="space-y-4 p-5 sm:p-6 shadow-sm">
                  <h4 className="text-base font-bold text-slate-900 flex items-center justify-between">
                    <span className="flex items-center gap-2">
                      <span className="text-lg">🏷️</span>
                      <span>{productName}</span>
                    </span>
                    <span className="text-xs text-slate-500 font-mono font-semibold">
                      {priceList.length} {priceList.length === 1 ? 'store' : 'stores'}
                    </span>
                  </h4>

                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    {priceList.map((p) => {
                      const isCheapest = p.id === cheapestId;
                      const marketName = p.markets?.name || 'Store';
                      const marketEmoji = p.markets?.emoji || '🏪';

                      return (
                        <div
                          key={p.id || Math.random()}
                          className={`flex items-center justify-between p-4 rounded-xl text-xs sm:text-sm ${
                            isCheapest
                              ? 'bg-emerald-50/90 border border-emerald-200 text-emerald-900 font-semibold shadow-xs'
                              : 'bg-slate-50 border border-slate-200 text-slate-700'
                          }`}
                        >
                          <div className="flex items-center gap-2.5">
                            <span className="text-lg">{marketEmoji}</span>
                            <span className="font-bold">{marketName}</span>
                          </div>

                          <div className="flex items-center gap-3">
                            <div className="flex items-center gap-1.5 font-mono font-bold">
                              <span>
                                {p.price} {p.currency} <span className="text-xs font-normal text-slate-500">/{p.unit}</span>
                              </span>
                              {isCheapest && (
                                <span className="text-[10px] bg-emerald-100 text-emerald-800 font-sans px-2.5 py-0.5 rounded-full border border-emerald-300 font-bold flex items-center gap-1">
                                  <Award className="w-3.5 h-3.5 text-emerald-600" />
                                  <span>Cheapest</span>
                                </span>
                              )}
                            </div>

                            <div className="flex items-center gap-1">
                              <button
                                onClick={() => handleStartEdit(p)}
                                aria-label="Edit price"
                                className="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-indigo-50"
                              >
                                <Edit3 className="w-4 h-4" />
                              </button>
                              <button
                                onClick={() => handleDelete(p.id)}
                                aria-label="Delete price"
                                className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                              >
                                <Trash2 className="w-4 h-4" />
                              </button>
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </Card>
              );
            })}
          </div>
        )}
      </div>

      {/* Quick New Store Modal */}
      {isNewStoreModalOpen && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setIsNewStoreModalOpen(false)}
        >
          <Card
            className="max-w-md w-full p-6 space-y-4 shadow-2xl border border-slate-200 cursor-default"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Store className="w-5 h-5 text-indigo-600" />
                <span>Add New Store</span>
              </h3>
              <button
                type="button"
                onClick={() => setIsNewStoreModalOpen(false)}
                className="p-1 text-slate-400 hover:text-slate-700 rounded-lg"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleQuickSaveStore} className="space-y-4">
              <div className="flex gap-3">
                <Select
                  aria-label="Store Icon"
                  value={newStoreEmoji}
                  onChange={(e) => setNewStoreEmoji(e.target.value)}
                  className="w-24 text-base text-center font-emoji font-bold"
                >
                  {['🏪', '🛒', '🥦', '🥩', '🥖', '🏬', '📍'].map((emoji) => (
                    <option key={emoji} value={emoji}>
                      {emoji}
                    </option>
                  ))}
                </Select>

                <Input
                  type="text"
                  placeholder="Store name (e.g., Trader Joe's, Target)"
                  aria-label="Store name"
                  value={newStoreName}
                  onChange={(e) => setNewStoreName(e.target.value)}
                  required
                  className="flex-1"
                />
              </div>

              <Input
                type="text"
                placeholder="Location / note (optional)"
                aria-label="Location"
                value={newStoreAddress}
                onChange={(e) => setNewStoreAddress(e.target.value)}
                className="w-full"
              />

              <div className="flex justify-end gap-3 pt-2 border-t border-slate-100">
                <Button variant="ghost" onClick={() => setIsNewStoreModalOpen(false)}>
                  Cancel
                </Button>
                <Button type="submit" variant="primary" icon={Plus}>
                  Save & Use Store
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}
    </div>
  );
}
