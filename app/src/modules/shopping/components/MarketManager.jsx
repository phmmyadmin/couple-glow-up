import React, { useState, useEffect } from 'react';
import { Store, Plus, Trash2, MapPin, AlertTriangle, Edit3, X, Check } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

export default function MarketManager({ markets, productPrices = [], onSaveMarket, onDeleteMarket }) {
  const [nameInput, setNameInput] = useState('');
  const [addressInput, setAddressInput] = useState('');
  const [emojiInput, setEmojiInput] = useState('🏪');

  // Edit Store Modal state
  const [editingMarket, setEditingMarket] = useState(null);
  const [editNameInput, setEditNameInput] = useState('');
  const [editAddressInput, setEditAddressInput] = useState('');
  const [editEmojiInput, setEditEmojiInput] = useState('🏪');

  // Deletion safeguard state
  const [deletingMarket, setDeletingMarket] = useState(null);

  // ESC key listener to close modals
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') {
        if (editingMarket) setEditingMarket(null);
        if (deletingMarket) setDeletingMarket(null);
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [editingMarket, deletingMarket]);

  const EMOJI_OPTIONS = ['🏪', '🛒', '🥦', '🥩', '🥖', '🏬', '📍'];

  const handleOpenEditModal = (market) => {
    setEditingMarket(market);
    setEditNameInput(market.name || '');
    setEditAddressInput(market.address || '');
    setEditEmojiInput(market.emoji || '🏪');
  };

  const handleSaveEditMarket = (e) => {
    e.preventDefault();
    if (!editingMarket || !editNameInput.trim()) return;

    onSaveMarket({
      id: editingMarket.id,
      name: editNameInput.trim(),
      address: editAddressInput.trim() || null,
      emoji: editEmojiInput,
    });

    setEditingMarket(null);
  };

  const handleAddSubmit = (e) => {
    e.preventDefault();
    if (!nameInput.trim()) return;

    onSaveMarket({
      name: nameInput.trim(),
      address: addressInput.trim() || null,
      emoji: emojiInput,
    });

    setNameInput('');
    setAddressInput('');
    setEmojiInput('🏪');
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
        <form onSubmit={handleAddSubmit} className="space-y-4">
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
              required
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

                <div className="flex items-center gap-1.5 shrink-0">
                  <button
                    onClick={() => handleOpenEditModal(market)}
                    aria-label={`Edit store ${market.name}`}
                    className="p-2 text-slate-400 hover:text-indigo-600 transition-all rounded-xl hover:bg-indigo-50 cursor-pointer"
                    title="Edit store"
                  >
                    <Edit3 className="w-4 h-4" />
                  </button>
                  <button
                    onClick={() => confirmDelete(market)}
                    aria-label={`Delete store ${market.name}`}
                    className="p-2 text-slate-400 hover:text-rose-600 transition-all rounded-xl hover:bg-rose-50 cursor-pointer"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </Card>
            ))}
          </div>
        )}
      </div>

      {/* Edit Store Modal */}
      {editingMarket && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setEditingMarket(null)}
        >
          <Card
            className="max-w-md w-full p-6 space-y-4 shadow-2xl border border-slate-200 cursor-default"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Edit3 className="w-5 h-5 text-indigo-600" />
                <span>Edit Store</span>
              </h3>
              <button
                type="button"
                onClick={() => setEditingMarket(null)}
                className="p-1.5 text-slate-400 hover:text-slate-600 rounded-lg hover:bg-slate-100 cursor-pointer"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveEditMarket} className="space-y-4">
              <div className="flex gap-3">
                <Select
                  aria-label="Store Icon"
                  value={editEmojiInput}
                  onChange={(e) => setEditEmojiInput(e.target.value)}
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
                  placeholder="Store name"
                  aria-label="Store name"
                  value={editNameInput}
                  onChange={(e) => setEditNameInput(e.target.value)}
                  required
                  className="flex-1"
                />
              </div>

              <Input
                type="text"
                placeholder="Location or note (optional)"
                aria-label="Location"
                value={editAddressInput}
                onChange={(e) => setEditAddressInput(e.target.value)}
                className="w-full"
              />

              <div className="flex gap-2 pt-2 border-t border-slate-100">
                <Button type="button" variant="secondary" onClick={() => setEditingMarket(null)} className="flex-1 justify-center">
                  Cancel
                </Button>
                <Button type="submit" variant="primary" icon={Check} className="flex-1 justify-center">
                  Save Changes
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}

      {/* Deletion Warning Modal */}
      {deletingMarket && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setDeletingMarket(null)}
        >
          <div
            className="bg-white rounded-3xl max-w-sm w-full p-6 space-y-4 shadow-xl border border-slate-200 animate-in fade-in zoom-in duration-200 cursor-default"
            onClick={(e) => e.stopPropagation()}
          >
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
