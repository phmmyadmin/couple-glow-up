import React, { useState } from 'react';
import { Plus, Check, Trash2, ShoppingBag } from 'lucide-react';
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
}) {
  const [nameInput, setNameInput] = useState('');
  const [quantityInput, setQuantityInput] = useState('1');
  const [unitInput, setUnitInput] = useState('ud');
  const [selectedCategory, setSelectedCategory] = useState('frutas');
  const [filterCategory, setFilterCategory] = useState('all');

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

                return (
                  <Card
                    key={item.id}
                    className="p-4 sm:p-5 flex items-center justify-between hover:border-indigo-200/80 gap-4 shadow-sm"
                  >
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

                    <div className="flex items-center gap-3 shrink-0">
                      {addedByProfile && <Avatar profile={addedByProfile} size="sm" />}
                      <button
                        onClick={() => onDeleteItem(item.id)}
                        aria-label={`Delete ${item.name}`}
                        className="p-2 text-slate-400 hover:text-rose-600 transition-all rounded-xl hover:bg-rose-50"
                      >
                        <Trash2 className="w-4 h-4" />
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
    </div>
  );
}
