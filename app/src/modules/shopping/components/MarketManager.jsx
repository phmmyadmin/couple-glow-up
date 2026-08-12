import React, { useState } from 'react';
import { Store, Plus, Trash2, MapPin } from 'lucide-react';

export default function MarketManager({ markets, onSaveMarket, onDeleteMarket }) {
  const [nameInput, setNameInput] = useState('');
  const [addressInput, setAddressInput] = useState('');
  const [emojiInput, setEmojiInput] = useState('🏪');

  const EMOJI_OPTIONS = ['🏪', '🛒', '🥦', '🥩', '🥖', '🏬', '📍'];

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!nameInput.trim()) return;

    onSaveMarket({
      name: nameInput.trim(),
      address: addressInput.trim() || null,
      emoji: emojiInput,
    });

    setNameInput('');
    setAddressInput('');
  };

  return (
    <div className="space-y-4">
      {/* Add Market Form */}
      <form onSubmit={handleSubmit} className="health-card space-y-3">
        <h3 className="text-xs font-bold text-slate-700 uppercase tracking-wider flex items-center gap-1.5">
          <Store className="w-4 h-4 text-indigo-600" />
          <span>Añadir Mercado / Tienda</span>
        </h3>

        <div className="flex gap-2">
          <select
            value={emojiInput}
            onChange={(e) => setEmojiInput(e.target.value)}
            className="edit-select w-16 text-base text-center"
          >
            {EMOJI_OPTIONS.map((emoji) => (
              <option key={emoji} value={emoji}>
                {emoji}
              </option>
            ))}
          </select>

          <input
            type="text"
            placeholder="Nombre de la tienda (ej: Mercadona, Carrefour...)"
            value={nameInput}
            onChange={(e) => setNameInput(e.target.value)}
            className="edit-input flex-1"
          />
        </div>

        <div className="flex gap-2">
          <input
            type="text"
            placeholder="Ubicación u observación (opcional)"
            value={addressInput}
            onChange={(e) => setAddressInput(e.target.value)}
            className="edit-input flex-1"
          />

          <button
            type="submit"
            className="flex items-center gap-1.5 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-4 py-2 rounded-xl shadow-sm transition-all active:scale-95"
          >
            <Plus className="w-4 h-4" />
            <span>Guardar</span>
          </button>
        </div>
      </form>

      {/* Markets List */}
      <div className="space-y-2">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Tus Tiendas Registradas ({markets.length})
        </h3>

        {markets.length === 0 ? (
          <div className="health-card text-center py-8 space-y-2">
            <Store className="w-8 h-8 text-slate-300 mx-auto" />
            <p className="text-xs text-slate-400">No hay tiendas registradas aún.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
            {markets.map((market) => (
              <div
                key={market.id}
                className="health-card p-3 flex items-center justify-between hover:border-indigo-200"
              >
                <div className="flex items-center gap-2.5">
                  <span className="text-xl p-2 bg-slate-100 rounded-xl border border-slate-200">
                    {market.emoji || '🏪'}
                  </span>
                  <div>
                    <h4 className="text-xs font-bold text-slate-900">{market.name}</h4>
                    {market.address && (
                      <p className="text-[10px] text-slate-500 flex items-center gap-1 mt-0.5">
                        <MapPin className="w-3 h-3 text-indigo-500" />
                        <span>{market.address}</span>
                      </p>
                    )}
                  </div>
                </div>

                <button
                  onClick={() => onDeleteMarket(market.id)}
                  className="p-1.5 text-slate-400 hover:text-rose-600 transition-all rounded-lg hover:bg-slate-100"
                  title="Eliminar tienda"
                >
                  <Trash2 className="w-3.5 h-3.5" />
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
