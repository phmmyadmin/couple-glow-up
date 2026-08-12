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
      <form onSubmit={handleSubmit} className="bg-slate-900/80 border border-slate-800 rounded-2xl p-4 shadow-lg space-y-3">
        <h3 className="text-xs font-bold text-slate-300 uppercase tracking-wider flex items-center gap-1.5">
          <Store className="w-4 h-4 text-amber-400" />
          <span>Añadir Mercado / Tienda</span>
        </h3>

        <div className="flex gap-2">
          {/* Emoji selector */}
          <select
            value={emojiInput}
            onChange={(e) => setEmojiInput(e.target.value)}
            className="bg-slate-950/80 border border-slate-800 rounded-xl px-2 py-2 text-base focus:outline-none focus:border-amber-500"
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
            className="flex-1 bg-slate-950/80 border border-slate-800 rounded-xl px-3 py-2 text-xs font-medium text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 transition-colors"
          />
        </div>

        <div className="flex gap-2">
          <input
            type="text"
            placeholder="Ubicación u observación (opcional)"
            value={addressInput}
            onChange={(e) => setAddressInput(e.target.value)}
            className="flex-1 bg-slate-950/80 border border-slate-800 rounded-xl px-3 py-2 text-xs font-medium text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 transition-colors"
          />

          <button
            type="submit"
            className="flex items-center gap-1.5 bg-gradient-to-r from-amber-500 to-orange-600 hover:from-amber-400 hover:to-orange-500 text-white font-semibold text-xs px-4 py-2 rounded-xl shadow-md transition-all active:scale-95"
          >
            <Plus className="w-4 h-4" />
            <span>Guardar</span>
          </button>
        </div>
      </form>

      {/* Markets List */}
      <div className="space-y-2">
        <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider px-1">
          Tus Tiendas Registradas ({markets.length})
        </h3>

        {markets.length === 0 ? (
          <div className="bg-slate-900/40 border border-dashed border-slate-800 rounded-2xl p-6 text-center space-y-2">
            <Store className="w-8 h-8 text-slate-600 mx-auto" />
            <p className="text-xs text-slate-500">No hay tiendas registradas aún. Añade una arriba.</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
            {markets.map((market) => (
              <div
                key={market.id}
                className="bg-slate-900/80 border border-slate-800 rounded-2xl p-3 flex items-center justify-between shadow-sm hover:border-slate-700 transition-all"
              >
                <div className="flex items-center gap-2.5">
                  <span className="text-xl p-2 bg-slate-950/60 rounded-xl border border-slate-800">
                    {market.emoji || '🏪'}
                  </span>
                  <div>
                    <h4 className="text-xs font-bold text-slate-100">{market.name}</h4>
                    {market.address && (
                      <p className="text-[10px] text-slate-400 flex items-center gap-1 mt-0.5">
                        <MapPin className="w-3 h-3 text-amber-500" />
                        <span>{market.address}</span>
                      </p>
                    )}
                  </div>
                </div>

                <button
                  onClick={() => onDeleteMarket(market.id)}
                  className="p-1.5 text-slate-500 hover:text-rose-400 transition-all rounded-lg hover:bg-slate-800"
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
