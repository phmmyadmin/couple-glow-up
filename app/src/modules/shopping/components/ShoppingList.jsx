import React, { useState } from 'react';
import { Plus, Check, Trash2, ShoppingBag } from 'lucide-react';
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
      {/* Quick Add Form Card */}
      <form onSubmit={handleAdd} className="health-card space-y-3">
        <div className="flex gap-2">
          <input
            type="text"
            placeholder="Añadir producto (ej: Pechuga de pollo, Leche...)"
            value={nameInput}
            onChange={(e) => setNameInput(e.target.value)}
            className="edit-input flex-1"
          />
          <input
            type="number"
            min="0.1"
            step="any"
            value={quantityInput}
            onChange={(e) => setQuantityInput(e.target.value)}
            className="edit-input w-16 text-center font-mono"
          />
          <select
            value={unitInput}
            onChange={(e) => setUnitInput(e.target.value)}
            className="edit-select w-20"
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
          <div className="flex items-center gap-1 overflow-x-auto no-scrollbar py-0.5 max-w-[240px] sm:max-w-xs">
            {CATEGORIES.filter((c) => c.id !== 'all').map((cat) => (
              <button
                key={cat.id}
                type="button"
                onClick={() => setSelectedCategory(cat.id)}
                className={`px-2.5 py-1 rounded-lg text-[11px] font-medium whitespace-nowrap transition-all ${
                  selectedCategory === cat.id
                    ? 'bg-indigo-50 text-indigo-600 font-semibold border border-indigo-200'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                }`}
              >
                {cat.emoji} {cat.label}
              </button>
            ))}
          </div>

          <button
            type="submit"
            className="flex items-center gap-1 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-3.5 py-2 rounded-xl shadow-sm transition-all active:scale-95"
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
            className={`px-3 py-1 rounded-full text-xs font-medium whitespace-nowrap transition-all ${
              filterCategory === cat.id
                ? 'bg-indigo-600 text-white font-semibold shadow-sm'
                : 'bg-white border border-slate-200 text-slate-600 hover:bg-slate-50'
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
          <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1 flex items-center justify-between">
            <span>Por Comprar ({pendingItems.length})</span>
            {pendingItems.length === 0 && <span className="text-emerald-600 text-[11px] lowercase font-normal">¡Todo completado! 🎉</span>}
          </h3>

          {pendingItems.length === 0 ? (
            <div className="health-card text-center py-8 space-y-2">
              <ShoppingBag className="w-8 h-8 text-slate-300 mx-auto" />
              <p className="text-xs text-slate-400">No hay productos pendientes en la lista.</p>
            </div>
          ) : (
            <div className="space-y-2">
              {pendingItems.map((item) => {
                const addedByProfile = profiles.find((p) => p.id === item.added_by);
                const catObj = CATEGORIES.find((c) => c.id === item.category);

                return (
                  <div
                    key={item.id}
                    className="health-card p-3 flex items-center justify-between hover:border-indigo-200"
                  >
                    <div className="flex items-center gap-3 flex-1 min-w-0">
                      <button
                        onClick={() => onToggleItem(item.id, true)}
                        className="w-6 h-6 rounded-lg border-2 border-slate-300 hover:border-indigo-600 flex items-center justify-center transition-all bg-white"
                      >
                        <Check className="w-3.5 h-3.5 text-transparent hover:text-indigo-600" />
                      </button>

                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2">
                          <span className="text-sm">{catObj?.emoji || '📦'}</span>
                          <span className="text-xs font-semibold text-slate-900 truncate">
                            {item.name}
                          </span>
                          <span className="text-[11px] font-mono text-indigo-600 bg-indigo-50 px-1.5 py-0.2 rounded font-medium">
                            {item.quantity} {item.unit}
                          </span>
                        </div>
                      </div>
                    </div>

                    <div className="flex items-center gap-2">
                      {addedByProfile && <Avatar profile={addedByProfile} size="sm" />}
                      <button
                        onClick={() => onDeleteItem(item.id)}
                        className="p-1.5 text-slate-400 hover:text-rose-600 transition-all rounded-lg hover:bg-slate-100"
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
          <div className="space-y-2 pt-2 border-t border-slate-200">
            <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider px-1">
              Comprados ({checkedItems.length})
            </h3>

            <div className="space-y-2 opacity-75">
              {checkedItems.map((item) => {
                const checkedByProfile = profiles.find((p) => p.id === item.checked_by);
                const catObj = CATEGORIES.find((c) => c.id === item.category);

                return (
                  <div
                    key={item.id}
                    className="health-card p-3 flex items-center justify-between bg-slate-50 border-slate-200"
                  >
                    <div className="flex items-center gap-3 flex-1 min-w-0">
                      <button
                        onClick={() => onToggleItem(item.id, false)}
                        className="w-6 h-6 rounded-lg bg-emerald-500 text-white flex items-center justify-center transition-all"
                      >
                        <Check className="w-3.5 h-3.5" />
                      </button>

                      <div className="flex items-center gap-2 flex-1 min-w-0 line-through text-slate-400">
                        <span className="text-sm">{catObj?.emoji || '📦'}</span>
                        <span className="text-xs font-medium truncate">{item.name}</span>
                        <span className="text-[10px] font-mono opacity-75">
                          {item.quantity} {item.unit}
                        </span>
                      </div>
                    </div>

                    <div className="flex items-center gap-2">
                      {checkedByProfile && <Avatar profile={checkedByProfile} size="sm" />}
                      <button
                        onClick={() => onDeleteItem(item.id)}
                        className="p-1.5 text-slate-400 hover:text-rose-600 transition-all rounded-lg"
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
