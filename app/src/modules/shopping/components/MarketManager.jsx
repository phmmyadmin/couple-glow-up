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
    <div className="space-y-6 sm:space-y-7">
      {/* Add Market Form */}
      <Card className="p-5 sm:p-6 shadow-sm">
        <form onSubmit={handleSubmit} className="space-y-4">
          <CardTitle icon={Store}>Add Store / Market</CardTitle>

          <div className="flex gap-3">
            <Select
              aria-label="Store Icon"
              value={emojiInput}
              onChange={(e) => setEmojiInput(e.target.value)}
              className="w-24 text-base text-center font-emoji font-bold"
            >
              {EMOJI_OPTIONS.map((emoji) => (
                <option key={emoji} value={emoji}>
                  {emoji}
                </option>
              ))}
            </Select>

            <Input
              type="text"
              placeholder="Store name (e.g., Trader Joe's, Target, Local Market...)"
              aria-label="Store name"
              value={nameInput}
              onChange={(e) => setNameInput(e.target.value)}
              className="flex-1"
            />
          </div>

          <div className="flex flex-col sm:flex-row gap-3">
            <Input
              type="text"
              placeholder="Location or note (optional)"
              aria-label="Location"
              value={addressInput}
              onChange={(e) => setAddressInput(e.target.value)}
              className="flex-1"
            />

            <Button type="submit" icon={Plus} variant="primary" className="shrink-0">
              Save Store
            </Button>
          </div>
        </form>
      </Card>

      {/* Markets List */}
      <div className="space-y-4">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Your Saved Stores ({markets.length})
        </h3>

        {markets.length === 0 ? (
          <Card className="text-center py-10 space-y-3">
            <Store className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No stores registered yet.</p>
          </Card>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 sm:gap-6">
            {markets.map((market) => (
              <Card
                key={market.id}
                className="p-5 flex items-center justify-between hover:border-indigo-200 gap-3 shadow-sm"
              >
                <div className="flex items-center gap-3.5">
                  <span className="text-2xl p-2.5 bg-slate-100/90 rounded-2xl border border-slate-200 shrink-0">
                    {market.emoji || '🏪'}
                  </span>
                  <div>
                    <h4 className="text-base font-bold text-slate-900">{market.name}</h4>
                    {market.address && (
                      <p className="text-xs text-slate-500 flex items-center gap-1 mt-1 font-medium">
                        <MapPin className="w-3.5 h-3.5 text-indigo-500 shrink-0" />
                        <span>{market.address}</span>
                      </p>
                    )}
                  </div>
                </div>

                <button
                  onClick={() => confirmDelete(market)}
                  aria-label={`Delete store ${market.name}`}
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

            <div className="text-center space-y-1.5">
              <h3 className="text-base font-bold text-slate-900">Delete {deletingMarket.market.name}?</h3>
              <p className="text-xs sm:text-sm text-slate-600 font-medium">
                This store has <strong>{deletingMarket.count} associated price records</strong> in the price comparison module.
              </p>
            </div>

            <div className="flex gap-3 pt-2">
              <Button
                variant="outline"
                className="flex-1"
                onClick={() => setDeletingMarket(null)}
              >
                Cancel
              </Button>
              <Button
                variant="danger"
                className="flex-1"
                onClick={() => {
                  onDeleteMarket(deletingMarket.market.id);
                  setDeletingMarket(null);
                }}
              >
                Delete
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
