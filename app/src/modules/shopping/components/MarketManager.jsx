import React, { useState } from 'react';
import { Store, Plus, Trash2, MapPin, AlertTriangle } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

export default function MarketManager({ markets, productPrices = [], onSaveMarket, onDeleteMarket }) {
  const [nameInput, setNameInput] = useState('');
  const [addressInput, setAddressInput] = useState('');
  const [emojiInput, setEmojiInput] = useState('🏪');

  // Deletion safeguard state
  const [deletingMarket, setDeletingMarket] = useState(null);

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

  const confirmDelete = (market) => {
    const associatedPrices = productPrices.filter((p) => p.market_id === market.id);
    if (associatedPrices.length > 0) {
      setDeletingMarket({ market, count: associatedPrices.length });
    } else {
      onDeleteMarket(market.id);
    }
  };

  return (
    <div className="space-y-4">
      {/* Add Market Form */}
      <Card>
        <form onSubmit={handleSubmit} className="space-y-3">
          <CardTitle icon={Store}>Añadir Mercado / Tienda</CardTitle>

          <div className="flex gap-2">
            <Select
              aria-label="Icono del mercado"
              value={emojiInput}
              onChange={(e) => setEmojiInput(e.target.value)}
              className="w-20 text-base text-center font-emoji"
            >
              {EMOJI_OPTIONS.map((emoji) => (
                <option key={emoji} value={emoji}>
                  {emoji}
                </option>
              ))}
            </Select>

            <Input
              type="text"
              placeholder="Nombre de la tienda (ej: Mercadona, Carrefour...)"
              aria-label="Nombre de la tienda"
              value={nameInput}
              onChange={(e) => setNameInput(e.target.value)}
              className="flex-1"
            />
          </div>

          <div className="flex gap-2">
            <Input
              type="text"
              placeholder="Ubicación u observación (opcional)"
              aria-label="Ubicación"
              value={addressInput}
              onChange={(e) => setAddressInput(e.target.value)}
              className="flex-1"
            />

            <Button type="submit" icon={Plus} variant="primary">
              Guardar
            </Button>
          </div>
        </form>
      </Card>

      {/* Markets List */}
      <div className="space-y-2.5">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Tus Tiendas Registradas ({markets.length})
        </h3>

        {markets.length === 0 ? (
          <Card className="text-center py-8 space-y-2">
            <Store className="w-10 h-10 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No hay tiendas registradas aún.</p>
          </Card>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {markets.map((market) => (
              <Card
                key={market.id}
                className="p-3.5 flex items-center justify-between hover:border-indigo-200"
              >
                <div className="flex items-center gap-3">
                  <span className="text-2xl p-2 bg-slate-100/80 rounded-2xl border border-slate-200">
                    {market.emoji || '🏪'}
                  </span>
                  <div>
                    <h4 className="text-sm font-bold text-slate-900">{market.name}</h4>
                    {market.address && (
                      <p className="text-xs text-slate-500 flex items-center gap-1 mt-0.5 font-medium">
                        <MapPin className="w-3.5 h-3.5 text-indigo-500 shrink-0" />
                        <span>{market.address}</span>
                      </p>
                    )}
                  </div>
                </div>

                <button
                  onClick={() => confirmDelete(market)}
                  aria-label={`Eliminar tienda ${market.name}`}
                  className="p-2 text-slate-400 hover:text-rose-600 transition-all rounded-xl hover:bg-rose-50"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </Card>
            ))}
          </div>
        )}
      </div>

      {/* Deletion Warning Modal */}
      {deletingMarket && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-3xl max-w-sm w-full p-6 space-y-4 shadow-xl border border-slate-200 animate-in fade-in zoom-in duration-200">
            <div className="w-12 h-12 rounded-2xl bg-amber-50 border border-amber-200 text-amber-600 flex items-center justify-center mx-auto">
              <AlertTriangle className="w-6 h-6" />
            </div>

            <div className="text-center space-y-1">
              <h3 className="text-base font-bold text-slate-900">¿Eliminar {deletingMarket.market.name}?</h3>
              <p className="text-xs text-slate-600 font-medium">
                Esta tienda tiene <strong>{deletingMarket.count} precios asociados</strong> registrados en la comparativa.
              </p>
            </div>

            <div className="flex gap-2 pt-2">
              <Button
                variant="outline"
                className="flex-1"
                onClick={() => setDeletingMarket(null)}
              >
                Cancelar
              </Button>
              <Button
                variant="danger"
                className="flex-1"
                onClick={() => {
                  onDeleteMarket(deletingMarket.market.id);
                  setDeletingMarket(null);
                }}
              >
                Eliminar
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
