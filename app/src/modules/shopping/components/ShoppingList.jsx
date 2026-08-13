import React, { useState } from 'react';
import { Plus, Check, Trash2, ShoppingBag, Store, Award, Edit3, X, Tag } from 'lucide-react';
import Avatar from '../../../shared/Avatar';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

const CATEGORIES = [
  { id: 'all', label: 'All', emoji: '🛒' },
  { id: 'frutas', label: 'Fruits & Veggies', emoji: '🥑' },
  { id: 'carnes', label: 'Meat & Fish', emoji: '🍗' },
  { id: 'lacteos', label: 'Dairy & Eggs', emoji: '🧀' },
  { id: 'panaderia', label: 'Bread & Cereals', emoji: '🍞' },
  { id: 'bebidas', label: 'Drinks', emoji: '🧃' },
  { id: 'limpieza', label: 'Cleaning & Home', emoji: '🧹' },
  { id: 'other', label: 'Others', emoji: '📦' },
];

export default function ShoppingList({
  items,
  onAddItem,
  onToggleItem,
  onDeleteItem,
  activeProfile,
  profiles,
  markets = [],
  productPrices = [],
  onSavePrice,
  onDeletePrice,
  onSaveMarket,
}) {
  const [nameInput, setNameInput] = useState('');
  const [quantityInput, setQuantityInput] = useState('1');
  const [unitInput, setUnitInput] = useState('ud');
  const [selectedCategory, setSelectedCategory] = useState('frutas');
  const [filterCategory, setFilterCategory] = useState('all');

  // Interactive Market Price Modal for an item
  const [inspectingItem, setInspectingItem] = useState(null);
  const [modalMarketId, setModalMarketId] = useState(markets[0]?.id || '');
  const [modalPriceInput, setModalPriceInput] = useState('');
  const [modalCurrencyInput, setModalCurrencyInput] = useState('PHP');
  const [modalUnitInput, setModalUnitInput] = useState('kg');
  const [editingModalPriceId, setEditingModalPriceId] = useState(null);

  // Quick Store Creation State for Modal
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
      setModalMarketId(saved.id);
    }

    setNewStoreName('');
    setNewStoreAddress('');
    setIsNewStoreModalOpen(false);
  };

  const handleAdd = (e) => {
    e.preventDefault();
    if (!nameInput.trim()) return;

    onAddItem({
      name: nameInput.trim(),
      quantity: parseFloat(quantityInput) || 1,
      unit: unitInput,
      category: selectedCategory,
      is_checked: false,
      added_by: activeProfile?.id || null,
    });

    setNameInput('');
    setQuantityInput('1');
  };

  // Helper to match prices for an item
  const getItemPrices = (itemName) => {
    if (!itemName || productPrices.length === 0) return [];
    const cleanName = itemName.trim().toLowerCase();
    return productPrices.filter((p) => {
      const pName = (p.product_name || p.products?.name || '').trim().toLowerCase();
      return pName === cleanName || pName.includes(cleanName) || cleanName.includes(pName);
    });
  };

  const getCheapestPrice = (priceList) => {
    if (!priceList || priceList.length === 0) return null;
    const sorted = [...priceList].sort((a, b) => a.price - b.price);
    return sorted[0];
  };

  const handleOpenMarketModal = (item) => {
    setInspectingItem(item);
    setEditingModalPriceId(null);
    setModalPriceInput('');
    if (markets.length > 0 && !modalMarketId) {
      setModalMarketId(markets[0].id);
    }
  };

  const handleSaveModalPrice = (e) => {
    e.preventDefault();
    if (!inspectingItem || !modalMarketId || !modalPriceInput) return;

    onSavePrice({
      id: editingModalPriceId || null,
      product_name: inspectingItem.name,
      market_id: modalMarketId,
      price: parseFloat(modalPriceInput),
      currency: modalCurrencyInput,
      unit: modalUnitInput,
    });

    setEditingModalPriceId(null);
    setModalPriceInput('');
  };

  const handleStartEditModalPrice = (p) => {
    setEditingModalPriceId(p.id);
    setModalMarketId(p.market_id);
    setModalPriceInput(p.price.toString());
    setModalCurrencyInput(p.currency || 'PHP');
    setModalUnitInput(p.unit || 'kg');
  };

  const filteredItems = items.filter((item) => {
    if (filterCategory === 'all') return true;
    return item.category === filterCategory;
  });

  const pendingItems = filteredItems.filter((item) => !item.is_checked);
  const checkedItems = filteredItems.filter((item) => item.is_checked);

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Quick Add Form Card */}
      <Card className="p-5 sm:p-6 shadow-sm">
        <form onSubmit={handleAdd} className="space-y-4">
          <div className="flex flex-col sm:flex-row gap-3">
            <Input
              type="text"
              placeholder="e.g., Chicken breast, Milk..."
              aria-label="Product name"
              value={nameInput}
              onChange={(e) => setNameInput(e.target.value)}
              className="flex-1"
            />
            <div className="flex gap-2">
              <Input
                type="number"
                min="0.1"
                step="any"
                aria-label="Quantity"
                value={quantityInput}
                onChange={(e) => setQuantityInput(e.target.value)}
                className="w-24 text-center font-mono font-bold"
              />
              <Select
                aria-label="Unit of measure"
                value={unitInput}
                onChange={(e) => setUnitInput(e.target.value)}
                className="w-28 font-semibold"
              >
                <option value="ud">pc</option>
                <option value="kg">kg</option>
                <option value="g">g</option>
                <option value="L">L</option>
                <option value="pack">pack</option>
              </Select>
            </div>
          </div>

          <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3 pt-1">
            {/* Category Selector Pills */}
            <div className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1">
              {CATEGORIES.filter((c) => c.id !== 'all').map((cat) => (
                <button
                  key={cat.id}
                  type="button"
                  onClick={() => setSelectedCategory(cat.id)}
                  className={`px-3.5 py-2 rounded-xl text-xs font-semibold whitespace-nowrap transition-all ${
                    selectedCategory === cat.id
                      ? 'bg-indigo-50 text-indigo-700 border border-indigo-200 shadow-sm'
                      : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                  }`}
                >
                  {cat.emoji} {cat.label}
                </button>
              ))}
            </div>

            <Button type="submit" icon={Plus} variant="primary" className="shrink-0">
              Add Product
            </Button>
          </div>
        </form>
      </Card>

      {/* Category Filter Scroll */}
      <div className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1">
        {CATEGORIES.map((cat) => (
          <button
            key={cat.id}
            onClick={() => setFilterCategory(cat.id)}
            className={`px-4 py-2 rounded-2xl text-xs sm:text-sm font-bold whitespace-nowrap transition-all ${
              filterCategory === cat.id
                ? 'bg-indigo-600 text-white shadow-sm'
                : 'bg-white border border-slate-200 text-slate-600 hover:bg-slate-50'
            }`}
          >
            {cat.emoji} {cat.label}
          </button>
        ))}
      </div>

      {/* List Content */}
      <div className="space-y-6 sm:space-y-7">
        {/* Pending Items */}
        <div className="space-y-4">
          <div className="flex items-center justify-between px-1">
            <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
              To Buy ({pendingItems.length})
            </h3>
            {pendingItems.length === 0 && (
              <span className="text-emerald-600 text-xs font-semibold">Shopping completed! 🎉</span>
            )}
          </div>

          {pendingItems.length === 0 ? (
            <Card className="text-center py-10 space-y-3">
              <ShoppingBag className="w-12 h-12 text-slate-300 mx-auto" />
              <p className="text-sm text-slate-500 font-medium">No pending items in the shopping list.</p>
            </Card>
          ) : (
            <div className="space-y-4">
              {pendingItems.map((item) => {
                const addedByProfile = profiles.find((p) => p.id === item.added_by);
                const catObj = CATEGORIES.find((c) => c.id === item.category);

                const itemPrices = getItemPrices(item.name);
                const cheapest = getCheapestPrice(itemPrices);

                return (
                  <Card
                    key={item.id}
                    className="p-4 sm:p-5 space-y-3 hover:border-indigo-200/80 shadow-sm"
                  >
                    <div className="flex items-center justify-between gap-4">
                      <div className="flex items-center gap-4 flex-1 min-w-0">
                        <button
                          onClick={() => onToggleItem(item.id, true)}
                          aria-label={`Mark ${item.name} as purchased`}
                          className="w-8 h-8 rounded-xl border-2 border-slate-300 hover:border-indigo-600 flex items-center justify-center transition-all bg-white shadow-sm shrink-0"
                        >
                          <Check className="w-4 h-4 text-transparent hover:text-indigo-600" />
                        </button>

                        <div className="flex-1 min-w-0 space-y-1">
                          <div className="flex items-center gap-2 flex-wrap">
                            <span className="text-base">{catObj?.emoji || '📦'}</span>
                            <span className="text-sm sm:text-base font-bold text-slate-900 truncate">
                              {item.name}
                            </span>
                            <span className="text-xs font-mono text-indigo-700 bg-indigo-50 border border-indigo-100 px-2.5 py-1 rounded-lg font-bold">
                              {item.quantity} {item.unit}
                            </span>
                          </div>
                        </div>
                      </div>

                      <div className="flex items-center gap-2 shrink-0">
                        {addedByProfile && <Avatar profile={addedByProfile} size="sm" />}
                        <button
                          onClick={() => onDeleteItem(item.id)}
                          aria-label={`Delete ${item.name}`}
                          className="p-2 text-slate-400 hover:text-rose-600 transition-all rounded-xl hover:bg-rose-50"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </div>

                    {/* Market Price Indicator / Inspector Trigger */}
                    <div className="pt-2 border-t border-slate-100 flex items-center justify-between text-xs">
                      {cheapest ? (
                        <button
                          onClick={() => handleOpenMarketModal(item)}
                          className="flex items-center gap-1.5 font-semibold text-emerald-800 bg-emerald-50 hover:bg-emerald-100 px-2.5 py-1 rounded-lg border border-emerald-200 transition-all"
                        >
                          <Award className="w-3.5 h-3.5 text-emerald-600" />
                          <span>
                            Cheapest at {cheapest.markets?.emoji || '🏪'} {cheapest.markets?.name}:{' '}
                            <strong>
                              {cheapest.price} {cheapest.currency}/{cheapest.unit}
                            </strong>
                          </span>
                        </button>
                      ) : (
                        <span className="text-slate-400 font-medium italic">No market prices recorded</span>
                      )}

                      <button
                        onClick={() => handleOpenMarketModal(item)}
                        className="font-bold text-indigo-600 hover:text-indigo-700 flex items-center gap-1 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg border border-indigo-100"
                      >
                        <Store className="w-3.5 h-3.5" />
                        <span>Compare / Edit Prices ({itemPrices.length})</span>
                      </button>
                    </div>
                  </Card>
                );
              })}
            </div>
          )}
        </div>

        {/* Checked Items */}
        {checkedItems.length > 0 && (
          <div className="space-y-4 pt-4 border-t border-slate-200/80">
            <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider px-1">
              Purchased ({checkedItems.length})
            </h3>

            <div className="space-y-4 opacity-80">
              {checkedItems.map((item) => {
                const checkedByProfile = profiles.find((p) => p.id === item.checked_by);
                const catObj = CATEGORIES.find((c) => c.id === item.category);

                return (
                  <Card
                    key={item.id}
                    className="p-4 sm:p-5 flex items-center justify-between bg-slate-50/80 border-slate-200 gap-4"
                  >
                    <div className="flex items-center gap-4 flex-1 min-w-0">
                      <button
                        onClick={() => onToggleItem(item.id, false)}
                        aria-label={`Uncheck ${item.name}`}
                        className="w-8 h-8 rounded-xl bg-emerald-500 text-white flex items-center justify-center shadow-sm shrink-0"
                      >
                        <Check className="w-4 h-4" />
                      </button>

                      <div className="flex items-center gap-2 flex-1 min-w-0 line-through text-slate-400">
                        <span className="text-base">{catObj?.emoji || '📦'}</span>
                        <span className="text-sm font-semibold truncate">{item.name}</span>
                        <span className="text-xs font-mono opacity-80">
                          {item.quantity} {item.unit}
                        </span>
                      </div>
                    </div>

                    <div className="flex items-center gap-3 shrink-0">
                      {checkedByProfile && <Avatar profile={checkedByProfile} size="sm" />}
                      <button
                        onClick={() => onDeleteItem(item.id)}
                        aria-label={`Delete ${item.name}`}
                        className="p-2 text-slate-400 hover:text-rose-600 transition-all rounded-xl"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </Card>
                );
              })}
            </div>
          </div>
        )}
      </div>

      {/* Market Prices Comparison Modal */}
      {inspectingItem && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setInspectingItem(null)}
        >
          <Card className="max-w-lg w-full p-6 space-y-5 shadow-xl border border-slate-200 cursor-default" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <div>
                <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                  <Tag className="w-4.5 h-4.5 text-indigo-600" />
                  <span>Market Prices for "{inspectingItem.name}"</span>
                </h3>
                <p className="text-xs text-slate-500 font-medium">Compare, edit or record new prices across stores.</p>
              </div>

              <button
                onClick={() => setInspectingItem(null)}
                className="p-1.5 text-slate-400 hover:text-slate-600 rounded-lg hover:bg-slate-100"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Existing Prices List */}
            <div className="space-y-2.5">
              <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                Store Prices
              </h4>

              {getItemPrices(inspectingItem.name).length === 0 ? (
                <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 text-center text-xs text-slate-500">
                  No prices recorded for this product yet. Add one below!
                </div>
              ) : (
                <div className="space-y-2 max-h-48 overflow-y-auto pr-1">
                  {getItemPrices(inspectingItem.name)
                    .sort((a, b) => a.price - b.price)
                    .map((p, idx) => (
                      <div
                        key={p.id || idx}
                        className={`flex items-center justify-between p-3 rounded-xl text-xs ${
                          idx === 0
                            ? 'bg-emerald-50 border border-emerald-200 text-emerald-900 font-semibold'
                            : 'bg-slate-50 border border-slate-200 text-slate-700'
                        }`}
                      >
                        <div className="flex items-center gap-2">
                          <span className="text-base">{p.markets?.emoji || '🏪'}</span>
                          <span className="font-bold">{p.markets?.name || 'Store'}</span>
                          {idx === 0 && (
                            <span className="text-[10px] bg-emerald-100 text-emerald-800 font-sans px-2 py-0.5 rounded-full font-bold">
                              Cheapest 🏆
                            </span>
                          )}
                        </div>

                        <div className="flex items-center gap-2">
                          <span className="font-mono font-bold text-sm">
                            {p.price} {p.currency} /{p.unit}
                          </span>

                          <button
                            onClick={() => handleStartEditModalPrice(p)}
                            className="p-1 text-slate-400 hover:text-indigo-600"
                            aria-label="Edit price"
                          >
                            <Edit3 className="w-3.5 h-3.5" />
                          </button>
                          <button
                            onClick={() => onDeletePrice(p.id)}
                            className="p-1 text-slate-400 hover:text-rose-600"
                            aria-label="Delete price"
                          >
                            <Trash2 className="w-3.5 h-3.5" />
                          </button>
                        </div>
                      </div>
                    ))}
                </div>
              )}
            </div>

            {/* Quick Price Input Form */}
            <form onSubmit={handleSaveModalPrice} className="space-y-3 pt-3 border-t border-slate-100">
              <div className="flex items-center justify-between">
                <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                  {editingModalPriceId ? 'Edit Price' : 'Add Store Price'}
                </h4>
                <button
                  type="button"
                  onClick={() => setIsNewStoreModalOpen(true)}
                  className="text-xs font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1 cursor-pointer"
                >
                  <Plus className="w-3.5 h-3.5" /> New Store
                </button>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <Select
                  value={modalMarketId}
                  onChange={(e) => setModalMarketId(e.target.value)}
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

                <Input
                  type="number"
                  step="any"
                  placeholder="Price (e.g. 3.99)"
                  value={modalPriceInput}
                  onChange={(e) => setModalPriceInput(e.target.value)}
                  className="font-mono font-bold"
                  required
                />
              </div>

              <div className="flex gap-2">
                <Select
                  value={modalCurrencyInput}
                  onChange={(e) => setModalCurrencyInput(e.target.value)}
                  className="w-24 font-bold"
                >
                  <option value="PHP">₱ PHP</option>
                  <option value="EUR">€ EUR</option>
                  <option value="USD">$ USD</option>
                </Select>

                <Select
                  value={modalUnitInput}
                  onChange={(e) => setModalUnitInput(e.target.value)}
                  className="w-24 font-bold"
                >
                  <option value="kg">/ kg</option>
                  <option value="ud">/ pc</option>
                  <option value="L">/ L</option>
                  <option value="pack">/ pack</option>
                </Select>

                <Button type="submit" variant="primary" icon={Plus} className="flex-1 justify-center">
                  {editingModalPriceId ? 'Save Edit' : 'Add Price'}
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}

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
