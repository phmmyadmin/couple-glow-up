import React, { useState } from 'react';
import { Plus, Check, Trash2, ShoppingBag, Sparkles, Filter, Store } from 'lucide-react';
import Avatar from '../../../shared/Avatar';

const CATEGORIES = [
  { id: 'all', label: 'Todos', emoji: '🛒' },
  { id: 'frutas', label: 'Frutas & Verduras', emoji: '🥑' },
  { id: 'carnes', label: 'Carnes & Pescado', emoji: '🍗' },
  { id: 'lacteos', label: 'Lácteos & Huevos', emoji: '🧀' },
  { id: 'panaderia', label: 'Pan & Cereales', emoji: '🍞' },
  { id: 'bebidas', label: 'Bebidas', emoji: '🧃' },
  { id: 'limpieza', label: 'Limpieza & Hogar', emoji: '🧹' },
  { id: 'other', label: 'Otros', emoji: '📦' },
];

export default function ShoppingList({
  items,
  onAddItem,
  onToggleItem,
  onDeleteItem,
  activeProfile,
  profiles,
  markets,
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
    <div className="space-y-4">
      {/* Quick Add Form */}
      <form onSubmit={handleAdd} className="bg-slate-900/80 backdrop-blur-md border border-slate-800 rounded-2xl p-3 shadow-lg space-y-2">
        <div className="flex gap-2">
          <input
            type="text"
            placeholder="Añadir producto (ej: Pechuga de pollo, Leche...)"
            value={nameInput}
            onChange={(e) => setNameInput(e.target.value)}
            className="flex-1 bg-slate-950/80 border border-slate-800 rounded-xl px-3 py-2 text-xs font-medium text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 transition-colors"
          />
          <input
            type="number"
            min="0.1"
            step="any"
            value={quantityInput}
            onChange={(e) => setQuantityInput(e.target.value)}
            className="w-14 bg-slate-950/80 border border-slate-800 rounded-xl px-2 py-2 text-xs font-mono text-center text-white focus:outline-none focus:border-amber-500"
          />
          <select
            value={unitInput}
            onChange={(e) => setUnitInput(e.target.value)}
            className="bg-slate-950/80 border border-slate-800 rounded-xl px-2 py-2 text-xs font-medium text-slate-300 focus:outline-none focus:border-amber-500"
          >
            <option value="ud">ud</option>
            <option value="kg">kg</option>
            <option value="g">g</option>
            <option value="L">L</option>
            <option value="pack">pack</option>
          </select>
        </div>

        <div className="flex items-center justify-between pt-1">
          {/* Category Selector Pills */}
          <div className="flex items-center gap-1 overflow-x-auto no-scrollbar py-0.5 max-w-[260px] sm:max-w-xs">
            {CATEGORIES.filter((c) => c.id !== 'all').map((cat) => (
              <button
                key={cat.id}
                type="button"
                onClick={() => setSelectedCategory(cat.id)}
                className={`px-2 py-1 rounded-lg text-[10px] font-medium whitespace-nowrap transition-all ${
                  selectedCategory === cat.id
                    ? 'bg-amber-500/20 text-amber-300 border border-amber-500/40'
                    : 'bg-slate-800/40 text-slate-400 hover:text-slate-200'
                }`}
              >
                {cat.emoji} {cat.label}
              </button>
            ))}
          </div>

          <button
            type="submit"
            className="flex items-center gap-1.5 bg-gradient-to-r from-amber-500 to-orange-600 hover:from-amber-400 hover:to-orange-500 text-white font-semibold text-xs px-3 py-1.5 rounded-xl shadow-md transition-all active:scale-95"
          >
            <Plus className="w-4 h-4" />
            <span>Añadir</span>
          </button>
        </div>
      </form>

      {/* Category Filter Scroll */}
      <div className="flex items-center gap-1.5 overflow-x-auto no-scrollbar py-1">
        {CATEGORIES.map((cat) => (
          <button
            key={cat.id}
            onClick={() => setFilterCategory(cat.id)}
            className={`px-2.5 py-1 rounded-full text-xs font-medium whitespace-nowrap transition-all ${
              filterCategory === cat.id
                ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20'
                : 'bg-slate-900/60 border border-slate-800 text-slate-400 hover:text-slate-200'
            }`}
          >
            {cat.emoji} {cat.label}
          </button>
        ))}
      </div>

      {/* List Content */}
      <div className="space-y-4">
        {/* Pending Items */}
        <div className="space-y-2">
          <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider px-1 flex items-center justify-between">
            <span>Por Comprar ({pendingItems.length})</span>
            {pendingItems.length === 0 && <span className="text-emerald-400 text-[11px] lowercase font-normal">¡Todo completado! 🎉</span>}
          </h3>

          {pendingItems.length === 0 ? (
            <div className="bg-slate-900/40 border border-dashed border-slate-800 rounded-2xl p-6 text-center space-y-2">
              <ShoppingBag className="w-8 h-8 text-slate-600 mx-auto" />
              <p className="text-xs text-slate-500">No hay productos pendientes en la lista.</p>
            </div>
          ) : (
            <div className="space-y-1.5">
              {pendingItems.map((item) => {
                const addedByProfile = profiles.find((p) => p.id === item.added_by);
                const catObj = CATEGORIES.find((c) => c.id === item.category);

                return (
                  <div
                    key={item.id}
                    className="group flex items-center justify-between bg-slate-900/80 hover:bg-slate-900 border border-slate-800 rounded-2xl p-3 shadow-sm transition-all"
                  >
                    <div className="flex items-center gap-3 flex-1 min-w-0">
                      <button
                        onClick={() => onToggleItem(item.id, true)}
                        className="w-6 h-6 rounded-xl border-2 border-slate-700 hover:border-amber-500 flex items-center justify-center transition-all bg-slate-950/50"
                      >
                        <Check className="w-3.5 h-3.5 text-transparent group-hover:text-amber-500/50" />
                      </button>

                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2">
                          <span className="text-sm">{catObj?.emoji || '📦'}</span>
                          <span className="text-xs font-semibold text-slate-100 truncate">
                            {item.name}
                          </span>
                          <span className="text-[11px] font-mono text-amber-400 bg-amber-500/10 px-1.5 py-0.2 rounded">
                            {item.quantity} {item.unit}
                          </span>
                        </div>
                      </div>
                    </div>

                    <div className="flex items-center gap-2">
                      {addedByProfile && <Avatar profile={addedByProfile} size="sm" />}
                      <button
                        onClick={() => onDeleteItem(item.id)}
                        className="opacity-0 group-hover:opacity-100 p-1.5 text-slate-500 hover:text-rose-400 transition-all rounded-lg hover:bg-slate-800"
                        title="Eliminar"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        {/* Checked Items */}
        {checkedItems.length > 0 && (
          <div className="space-y-2 pt-2 border-t border-slate-800/80">
            <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
              Comprados ({checkedItems.length})
            </h3>

            <div className="space-y-1.5 opacity-65">
              {checkedItems.map((item) => {
                const checkedByProfile = profiles.find((p) => p.id === item.checked_by);
                const catObj = CATEGORIES.find((c) => c.id === item.category);

                return (
                  <div
                    key={item.id}
                    className="group flex items-center justify-between bg-slate-950/50 border border-slate-900 rounded-2xl p-2.5 transition-all"
                  >
                    <div className="flex items-center gap-3 flex-1 min-w-0">
                      <button
                        onClick={() => onToggleItem(item.id, false)}
                        className="w-6 h-6 rounded-xl bg-emerald-500/20 border border-emerald-500/40 text-emerald-400 flex items-center justify-center transition-all"
                      >
                        <Check className="w-3.5 h-3.5" />
                      </button>

                      <div className="flex items-center gap-2 flex-1 min-w-0 line-through text-slate-400">
                        <span className="text-sm">{catObj?.emoji || '📦'}</span>
                        <span className="text-xs font-medium truncate">{item.name}</span>
                        <span className="text-[10px] font-mono opacity-70">
                          {item.quantity} {item.unit}
                        </span>
                      </div>
                    </div>

                    <div className="flex items-center gap-2">
                      {checkedByProfile && <Avatar profile={checkedByProfile} size="sm" />}
                      <button
                        onClick={() => onDeleteItem(item.id)}
                        className="p-1.5 text-slate-600 hover:text-rose-400 transition-all rounded-lg"
                      >
                        <Trash2 className="w-3.5 h-3.5" />
                      </button>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
