import React, { useState } from 'react';
import { Tag, Store, Plus, ArrowUpDown } from 'lucide-react';

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

  // Group prices by product_name
  const groupedPrices = productPrices.reduce((acc, item) => {
    const key = item.product_name || item.products?.name || 'Otros';
    if (!acc[key]) acc[key] = [];
    acc[key].push(item);
    return acc;
  }, {});

  return (
    <div className="space-y-4">
      {/* Price Form */}
      <form onSubmit={handleSubmit} className="bg-slate-900/80 border border-slate-800 rounded-2xl p-4 shadow-lg space-y-3">
        <h3 className="text-xs font-bold text-slate-300 uppercase tracking-wider flex items-center gap-1.5">
          <Tag className="w-4 h-4 text-amber-400" />
          <span>Vincular Precio por Producto</span>
        </h3>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
          <input
            type="text"
            placeholder="Nombre del producto (ej: Pechuga de pollo)"
            value={productNameInput}
            onChange={(e) => setProductNameInput(e.target.value)}
            className="bg-slate-950/80 border border-slate-800 rounded-xl px-3 py-2 text-xs font-medium text-white placeholder-slate-500 focus:outline-none focus:border-amber-500"
          />

          <select
            value={selectedMarketId}
            onChange={(e) => setSelectedMarketId(e.target.value)}
            className="bg-slate-950/80 border border-slate-800 rounded-xl px-3 py-2 text-xs font-medium text-slate-200 focus:outline-none focus:border-amber-500"
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
            className="flex-1 bg-slate-950/80 border border-slate-800 rounded-xl px-3 py-2 text-xs font-mono text-white placeholder-slate-500 focus:outline-none focus:border-amber-500"
          />

          <select
            value={currencyInput}
            onChange={(e) => setCurrencyInput(e.target.value)}
            className="bg-slate-950/80 border border-slate-800 rounded-xl px-2 py-2 text-xs font-semibold text-slate-300"
          >
            <option value="PHP">₱ PHP</option>
            <option value="EUR">€ EUR</option>
            <option value="USD">$ USD</option>
          </select>

          <select
            value={unitInput}
            onChange={(e) => setUnitInput(e.target.value)}
            className="bg-slate-950/80 border border-slate-800 rounded-xl px-2 py-2 text-xs font-semibold text-slate-300"
          >
            <option value="kg">/ kg</option>
            <option value="ud">/ ud</option>
            <option value="L">/ L</option>
            <option value="pack">/ pack</option>
          </select>

          <button
            type="submit"
            className="flex items-center gap-1 bg-gradient-to-r from-amber-500 to-orange-600 hover:from-amber-400 hover:to-orange-500 text-white font-semibold text-xs px-3 py-2 rounded-xl shadow-md transition-all active:scale-95"
          >
            <Plus className="w-4 h-4" />
            <span>Guardar</span>
          </button>
        </div>
      </form>

      {/* Comparison Matrix */}
      <div className="space-y-3">
        <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider px-1">
          Comparativa de Precios Registrados
        </h3>

        {Object.keys(groupedPrices).length === 0 ? (
          <div className="bg-slate-900/40 border border-dashed border-slate-800 rounded-2xl p-6 text-center space-y-2">
            <ArrowUpDown className="w-8 h-8 text-slate-600 mx-auto" />
            <p className="text-xs text-slate-500">No hay comparativas de precios aún.</p>
          </div>
        ) : (
          <div className="space-y-3">
            {Object.entries(groupedPrices).map(([productName, priceList]) => {
              // Find cheapest
              const sorted = [...priceList].sort((a, b) => a.price - b.price);
              const cheapestId = sorted[0]?.id;

              return (
                <div
                  key={productName}
                  className="bg-slate-900/80 border border-slate-800 rounded-2xl p-3.5 space-y-2 shadow-sm"
                >
                  <h4 className="text-xs font-bold text-slate-100 flex items-center gap-2">
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
                          className={`flex items-center justify-between p-2 rounded-xl text-xs ${
                            isCheapest
                              ? 'bg-emerald-500/10 border border-emerald-500/30 text-emerald-300'
                              : 'bg-slate-950/60 border border-slate-800/80 text-slate-300'
                          }`}
                        >
                          <span className="flex items-center gap-1.5">
                            <span>{marketEmoji}</span>
                            <span className="font-medium">{marketName}</span>
                          </span>

                          <div className="flex items-center gap-2 font-mono font-bold">
                            <span>
                              {p.price} {p.currency} <span className="text-[10px] font-normal text-slate-400">/{p.unit}</span>
                            </span>
                            {isCheapest && (
                              <span className="text-[9px] bg-emerald-500/20 text-emerald-400 font-sans px-1.5 py-0.5 rounded-full border border-emerald-500/40">
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
