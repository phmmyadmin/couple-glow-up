import React, { useState } from 'react';
import { Tag, Plus, ArrowUpDown } from 'lucide-react';

export default function PriceComparator({ markets, productPrices, onSavePrice }) {
  const [productNameInput, setProductNameInput] = useState('');
  const [selectedMarketId, setSelectedMarketId] = useState(markets[0]?.id || '');
  const [priceInput, setPriceInput] = useState('');
  const [currencyInput, setCurrencyInput] = useState('PHP');
  const [unitInput, setUnitInput] = useState('kg');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!productNameInput.trim() || !selectedMarketId || !priceInput) return;

    onSavePrice({
      product_name: productNameInput.trim(),
      market_id: selectedMarketId,
      price: parseFloat(priceInput),
      currency: currencyInput,
      unit: unitInput,
    });

    setProductNameInput('');
    setPriceInput('');
  };

  const groupedPrices = productPrices.reduce((acc, item) => {
    const key = item.product_name || item.products?.name || 'Otros';
    if (!acc[key]) acc[key] = [];
    acc[key].push(item);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      {/* Price Form */}
      <form onSubmit={handleSubmit} className="health-card space-y-3">
        <h3 className="text-xs font-bold text-slate-700 uppercase tracking-wider flex items-center gap-1.5">
          <Tag className="w-4 h-4 text-indigo-600" />
          <span>Vincular Precio por Producto</span>
        </h3>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
          <input
            type="text"
            placeholder="Nombre del producto (ej: Pechuga de pollo)"
            value={productNameInput}
            onChange={(e) => setProductNameInput(e.target.value)}
            className="edit-input"
          />

          <select
            value={selectedMarketId}
            onChange={(e) => setSelectedMarketId(e.target.value)}
            className="edit-select"
          >
            <option value="" disabled>
              Selecciona tienda...
            </option>
            {markets.map((m) => (
              <option key={m.id} value={m.id}>
                {m.emoji} {m.name}
              </option>
            ))}
          </select>
        </div>

        <div className="flex gap-2">
          <input
            type="number"
            step="any"
            placeholder="Precio (ej: 4.50)"
            value={priceInput}
            onChange={(e) => setPriceInput(e.target.value)}
            className="edit-input flex-1 font-mono"
          />

          <select
            value={currencyInput}
            onChange={(e) => setCurrencyInput(e.target.value)}
            className="edit-select w-24"
          >
            <option value="PHP">₱ PHP</option>
            <option value="EUR">€ EUR</option>
            <option value="USD">$ USD</option>
          </select>

          <select
            value={unitInput}
            onChange={(e) => setUnitInput(e.target.value)}
            className="edit-select w-20"
          >
            <option value="kg">/ kg</option>
            <option value="ud">/ ud</option>
            <option value="L">/ L</option>
            <option value="pack">/ pack</option>
          </select>

          <button
            type="submit"
            className="flex items-center gap-1 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-3.5 py-2 rounded-xl shadow-sm transition-all active:scale-95"
          >
            <Plus className="w-4 h-4" />
            <span>Guardar</span>
          </button>
        </div>
      </form>

      {/* Comparison Matrix */}
      <div className="space-y-3">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Comparativa de Precios Registrados
        </h3>

        {Object.keys(groupedPrices).length === 0 ? (
          <div className="health-card text-center py-8 space-y-2">
            <ArrowUpDown className="w-8 h-8 text-slate-300 mx-auto" />
            <p className="text-xs text-slate-400">No hay comparativas de precios aún.</p>
          </div>
        ) : (
          <div className="space-y-3">
            {Object.entries(groupedPrices).map(([productName, priceList]) => {
              const sorted = [...priceList].sort((a, b) => a.price - b.price);
              const cheapestId = sorted[0]?.id;

              return (
                <div
                  key={productName}
                  className="health-card space-y-2 p-3.5"
                >
                  <h4 className="text-xs font-bold text-slate-900 flex items-center gap-2">
                    <span>🏷️</span> {productName}
                  </h4>

                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                    {priceList.map((p) => {
                      const isCheapest = p.id === cheapestId;
                      const marketName = p.markets?.name || 'Tienda';
                      const marketEmoji = p.markets?.emoji || '🏪';

                      return (
                        <div
                          key={p.id || Math.random()}
                          className={`flex items-center justify-between p-2.5 rounded-xl text-xs ${
                            isCheapest
                              ? 'bg-emerald-50 border border-emerald-200 text-emerald-900 font-medium'
                              : 'bg-slate-50 border border-slate-200 text-slate-700'
                          }`}
                        >
                          <span className="flex items-center gap-1.5">
                            <span>{marketEmoji}</span>
                            <span className="font-semibold">{marketName}</span>
                          </span>

                          <div className="flex items-center gap-2 font-mono font-bold">
                            <span>
                              {p.price} {p.currency} <span className="text-[10px] font-normal text-slate-500">/{p.unit}</span>
                            </span>
                            {isCheapest && (
                              <span className="text-[9px] bg-emerald-100 text-emerald-700 font-sans px-1.5 py-0.5 rounded-full border border-emerald-300 font-bold">
                                🏅 Más barato
                              </span>
                            )}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
