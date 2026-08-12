import React, { useState } from 'react';
import { Tag, Plus, ArrowUpDown, Award } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

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
    const key = item.product_name || item.products?.name || 'Others';
    if (!acc[key]) acc[key] = [];
    acc[key].push(item);
    return acc;
  }, {});

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Price Form */}
      <Card className="p-5 sm:p-6 shadow-sm">
        <form onSubmit={handleSubmit} className="space-y-4">
          <CardTitle icon={Tag}>Link Product Price</CardTitle>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Input
              type="text"
              placeholder="Product name (e.g., Chicken breast)"
              aria-label="Product name"
              value={productNameInput}
              onChange={(e) => setProductNameInput(e.target.value)}
            />

            <Select
              aria-label="Select Store"
              value={selectedMarketId}
              onChange={(e) => setSelectedMarketId(e.target.value)}
            >
              <option value="" disabled>
                Select Store...
              </option>
              {markets.map((m) => (
                <option key={m.id} value={m.id}>
                  {m.emoji} {m.name}
                </option>
              ))}
            </Select>
          </div>

          <div className="flex flex-col sm:flex-row gap-3">
            <Input
              type="number"
              step="any"
              placeholder="Price (e.g., 4.50)"
              aria-label="Price"
              value={priceInput}
              onChange={(e) => setPriceInput(e.target.value)}
              className="flex-1 font-mono font-bold"
            />

            <div className="flex gap-2">
              <Select
                aria-label="Currency"
                value={currencyInput}
                onChange={(e) => setCurrencyInput(e.target.value)}
                className="w-28 font-bold"
              >
                <option value="PHP">₱ PHP</option>
                <option value="EUR">€ EUR</option>
                <option value="USD">$ USD</option>
              </Select>

              <Select
                aria-label="Unit of measure"
                value={unitInput}
                onChange={(e) => setUnitInput(e.target.value)}
                className="w-24 font-bold"
              >
                <option value="kg">/ kg</option>
                <option value="ud">/ pc</option>
                <option value="L">/ L</option>
                <option value="pack">/ pack</option>
              </Select>

              <Button type="submit" icon={Plus} variant="primary" className="shrink-0">
                Save
              </Button>
            </div>
          </div>
        </form>
      </Card>

      {/* Comparison Matrix */}
      <div className="space-y-4">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Recorded Price Comparisons
        </h3>

        {Object.keys(groupedPrices).length === 0 ? (
          <Card className="text-center py-10 space-y-3">
            <ArrowUpDown className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No price comparisons recorded yet.</p>
          </Card>
        ) : (
          <div className="space-y-5 sm:space-y-6">
            {Object.entries(groupedPrices).map(([productName, priceList]) => {
              const sorted = [...priceList].sort((a, b) => a.price - b.price);
              const cheapestId = sorted[0]?.id;

              return (
                <Card key={productName} className="space-y-4 p-5 sm:p-6 shadow-sm">
                  <h4 className="text-base font-bold text-slate-900 flex items-center gap-2">
                    <span className="text-lg">🏷️</span>
                    <span>{productName}</span>
                  </h4>

                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    {priceList.map((p) => {
                      const isCheapest = p.id === cheapestId;
                      const marketName = p.markets?.name || 'Store';
                      const marketEmoji = p.markets?.emoji || '🏪';

                      return (
                        <div
                          key={p.id || Math.random()}
                          className={`flex items-center justify-between p-4 rounded-xl text-xs sm:text-sm ${
                            isCheapest
                              ? 'bg-emerald-50/90 border border-emerald-200 text-emerald-900 font-semibold shadow-xs'
                              : 'bg-slate-50 border border-slate-200 text-slate-700'
                          }`}
                        >
                          <span className="flex items-center gap-2.5">
                            <span className="text-lg">{marketEmoji}</span>
                            <span className="font-bold">{marketName}</span>
                          </span>

                          <div className="flex items-center gap-2 font-mono font-bold">
                            <span>
                              {p.price} {p.currency} <span className="text-xs font-normal text-slate-500">/{p.unit}</span>
                            </span>
                            {isCheapest && (
                              <span className="text-[10px] bg-emerald-100 text-emerald-800 font-sans px-2.5 py-1 rounded-full border border-emerald-300 font-bold flex items-center gap-1">
                                <Award className="w-3.5 h-3.5 text-emerald-600" />
                                <span>Best Price</span>
                              </span>
                            )}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </Card>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
