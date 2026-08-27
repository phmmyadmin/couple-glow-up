import React, { useState, useMemo, useEffect } from 'react';
import { X, Dumbbell, Plus, Minus, RotateCcw, Settings2 } from 'lucide-react';
import { calculatePlates } from '../lib/plate-calculator';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';

const KG_COLORS = {
  25: { bg: 'bg-red-600', text: 'text-white', border: 'border-red-700' },
  20: { bg: 'bg-blue-600', text: 'text-white', border: 'border-blue-700' },
  15: { bg: 'bg-amber-400', text: 'text-amber-950', border: 'border-amber-500' },
  10: { bg: 'bg-emerald-600', text: 'text-white', border: 'border-emerald-700' },
  5: { bg: 'bg-white', text: 'text-slate-800', border: 'border-slate-300' },
  2.5: { bg: 'bg-slate-800', text: 'text-white', border: 'border-slate-900' },
  1.25: { bg: 'bg-slate-400', text: 'text-slate-900', border: 'border-slate-500' },
};

const LBS_COLORS = {
  45: { bg: 'bg-blue-600', text: 'text-white', border: 'border-blue-700' },
  35: { bg: 'bg-amber-400', text: 'text-amber-950', border: 'border-amber-500' },
  25: { bg: 'bg-emerald-600', text: 'text-white', border: 'border-emerald-700' },
  10: { bg: 'bg-white', text: 'text-slate-800', border: 'border-slate-300' },
  5: { bg: 'bg-slate-800', text: 'text-white', border: 'border-slate-900' },
  2.5: { bg: 'bg-slate-400', text: 'text-slate-900', border: 'border-slate-500' },
};

export default function PlateCalculator({ onClose, initialWeight = '' }) {
  const [weight, setWeight] = useState(() => (initialWeight ? String(initialWeight) : '100'));
  const [isLbs, setIsLbs] = useState(false);
  const [barWeight, setBarWeight] = useState(20);
  const [use25kgPlates, setUse25kgPlates] = useState(false);

  // Sync when initialWeight changes
  useEffect(() => {
    if (initialWeight) {
      setWeight(String(initialWeight));
    }
  }, [initialWeight]);

  // Adjust bar weight default when switching units
  const handleUnitToggle = (toLbs) => {
    setIsLbs(toLbs);
    setBarWeight(toLbs ? 45 : 20);
  };

  // ESC key listener
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onClose]);

  const numWeight = useMemo(() => {
    const parsed = parseFloat(weight);
    return isNaN(parsed) || parsed < 0 ? 0 : parsed;
  }, [weight]);

  const plates = useMemo(() => {
    return calculatePlates(numWeight, barWeight, isLbs, use25kgPlates);
  }, [numWeight, barWeight, isLbs, use25kgPlates]);

  const colors = isLbs ? LBS_COLORS : KG_COLORS;

  const handleQuickAdjust = (delta) => {
    const next = Math.max(barWeight, Math.round((numWeight + delta) * 10) / 10);
    setWeight(String(next));
  };

  const handlePreset = (val) => {
    setWeight(String(val));
  };

  // Group plates by denomination (e.g. 2 × 20kg, 1 × 5kg)
  const groupedPlates = useMemo(() => {
    const map = {};
    plates.forEach((p) => {
      map[p] = (map[p] || 0) + 1;
    });
    return Object.entries(map).map(([p, count]) => ({
      weight: parseFloat(p),
      count,
    }));
  }, [plates]);

  const weightPerSide = numWeight > barWeight ? (numWeight - barWeight) / 2 : 0;
  const presets = isLbs ? [135, 185, 225, 275, 315] : [60, 80, 100, 120, 140];
  const barOptions = isLbs ? [45, 35, 25, 15] : [20, 15, 10, 0];

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-xs animate-in fade-in duration-150"
      onClick={onClose}
    >
      <Card
        className="w-full max-w-md bg-white shadow-2xl p-5 sm:p-6 space-y-4 border border-slate-200"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-center justify-between border-b border-slate-100 pb-3">
          <div className="flex items-center gap-2.5">
            <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
              <Dumbbell className="w-5 h-5" />
            </div>
            <div>
              <CardTitle className="text-base">Barbell Plate Calculator</CardTitle>
              <p className="text-xs text-slate-500 font-medium">Exact plates to load on each side.</p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="p-1.5 text-slate-400 hover:text-slate-600 rounded-xl hover:bg-slate-100 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Input & Unit Switcher */}
        <div className="flex gap-3 items-end">
          <div className="flex-1 space-y-1">
            <label className="block text-xs font-bold text-slate-700">Target Total Weight</label>
            <div className="relative">
              <input
                type="number"
                step="any"
                min="0"
                max="1000"
                value={weight}
                onChange={(e) => setWeight(e.target.value)}
                onFocus={(e) => e.target.select()}
                placeholder={isLbs ? '225' : '100'}
                className="w-full px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl text-base font-extrabold text-slate-900 font-mono focus:outline-none focus:border-indigo-500 focus:bg-white transition-colors"
              />
              <span className="absolute right-3.5 top-2.5 text-xs font-bold text-slate-400 font-mono">
                {isLbs ? 'LBS' : 'KG'}
              </span>
            </div>
          </div>

          {/* Unit Toggle */}
          <div className="flex bg-slate-100 p-1 rounded-xl border border-slate-200/80">
            <button
              type="button"
              onClick={() => handleUnitToggle(false)}
              className={`px-3 py-1.5 text-xs font-bold rounded-lg transition-all ${
                !isLbs ? 'bg-white shadow-xs text-indigo-600' : 'text-slate-500 hover:text-slate-800'
              }`}
            >
              KG
            </button>
            <button
              type="button"
              onClick={() => handleUnitToggle(true)}
              className={`px-3 py-1.5 text-xs font-bold rounded-lg transition-all ${
                isLbs ? 'bg-white shadow-xs text-indigo-600' : 'text-slate-500 hover:text-slate-800'
              }`}
            >
              LBS
            </button>
          </div>
        </div>

        {/* Bar Weight & Options Selector */}
        <div className="flex items-center justify-between gap-2 bg-slate-50 p-2.5 rounded-xl border border-slate-200/70 text-xs">
          <div className="flex items-center gap-1.5">
            <span className="font-bold text-slate-500">Bar Weight:</span>
            <div className="flex gap-1">
              {barOptions.map((b) => (
                <button
                  key={b}
                  type="button"
                  onClick={() => setBarWeight(b)}
                  className={`px-2 py-0.5 rounded-md font-mono font-bold text-xs transition-colors ${
                    barWeight === b
                      ? 'bg-indigo-600 text-white shadow-2xs'
                      : 'bg-white text-slate-600 border border-slate-200 hover:bg-slate-100'
                  }`}
                >
                  {b}{isLbs ? 'lb' : 'k'}
                </button>
              ))}
            </div>
          </div>

          {!isLbs && (
            <label className="flex items-center gap-1 cursor-pointer text-slate-600 text-[11px] font-medium">
              <input
                type="checkbox"
                checked={use25kgPlates}
                onChange={(e) => setUse25kgPlates(e.target.checked)}
                className="rounded text-indigo-600 focus:ring-indigo-500 w-3.5 h-3.5"
              />
              <span>Use 25kg</span>
            </label>
          )}
        </div>

        {/* Quick Delta Increments */}
        <div className="flex items-center gap-1.5 flex-wrap">
          <span className="text-[11px] font-bold text-slate-400 mr-1">Quick:</span>
          {[-10, -2.5, +2.5, +5, +10, +20].map((d) => (
            <button
              key={d}
              type="button"
              onClick={() => handleQuickAdjust(d)}
              className="px-2 py-1 bg-slate-100 hover:bg-indigo-50 hover:text-indigo-600 text-slate-700 font-mono font-bold text-[11px] rounded-lg border border-slate-200/80 transition-colors cursor-pointer"
            >
              {d > 0 ? `+${d}` : d}
            </button>
          ))}
        </div>

        {/* Bar Visualizer */}
        <div className="bg-slate-900 rounded-2xl p-4 border border-slate-800 text-white space-y-2.5">
          <div className="flex items-center justify-between text-xs text-slate-300">
            <span>Bar: <strong>{barWeight} {isLbs ? 'lbs' : 'kg'}</strong></span>
            <span>Per Side: <strong className="text-indigo-400 font-mono text-sm">{weightPerSide.toFixed(1)} {isLbs ? 'lbs' : 'kg'}</strong></span>
          </div>

          {/* Barbell graphic */}
          <div className="flex items-center justify-center h-24 max-w-full overflow-x-auto py-1">
            {/* Left Bar Collar */}
            <div className="w-10 h-3 bg-slate-500 rounded-l-xs shrink-0" />
            <div className="w-2 h-9 bg-slate-400 rounded-xs shrink-0" />

            {/* Plates */}
            {plates.length > 0 ? (
              <div className="flex items-center gap-1 mx-1.5">
                {plates.map((plate, idx) => {
                  let heightClass = 'h-20';
                  if (plate <= 2.5) heightClass = 'h-8';
                  else if (plate <= 5) heightClass = 'h-12';
                  else if (plate <= 10) heightClass = 'h-15';
                  else if (plate <= 15) heightClass = 'h-18';

                  const col = colors[plate] || { bg: 'bg-slate-400', text: 'text-white', border: 'border-slate-500' };

                  return (
                    <div
                      key={idx}
                      className={`w-5 rounded-xs flex items-center justify-center text-[10px] font-black font-mono select-none ${heightClass} ${col.bg} ${col.text} border ${col.border} shadow-md`}
                      title={`${plate} ${isLbs ? 'lbs' : 'kg'}`}
                    >
                      <span className="rotate-90 text-[8px]">{plate}</span>
                    </div>
                  );
                })}
              </div>
            ) : (
              <div className="px-4 text-xs font-semibold text-slate-500 italic">
                {numWeight <= barWeight ? 'Target is ≤ bar weight' : 'No plates required'}
              </div>
            )}

            {/* Right Bar Sleeve */}
            <div className="w-20 h-3 bg-slate-500 rounded-r-xs shrink-0" />
          </div>

          {/* Grouped Plates Summary (e.g. 2 × 20kg + 1 × 5kg) */}
          {groupedPlates.length > 0 && (
            <div className="pt-2 border-t border-slate-800 flex items-center justify-between flex-wrap gap-1.5 text-xs">
              <span className="text-slate-400">Load per side:</span>
              <div className="flex items-center gap-1.5 flex-wrap">
                {groupedPlates.map((gp, idx) => (
                  <span
                    key={idx}
                    className="px-2 py-0.5 bg-slate-800 border border-slate-700 text-indigo-300 font-mono font-bold rounded-md"
                  >
                    {gp.count > 1 ? `${gp.count} × ` : ''}{gp.weight}{isLbs ? ' lbs' : ' kg'}
                  </span>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Quick Presets */}
        <div className="flex items-center justify-between gap-2 text-xs pt-0.5">
          <span className="text-slate-400 font-medium">Presets:</span>
          <div className="flex items-center gap-1.5 flex-wrap">
            {presets.map((p) => (
              <button
                key={p}
                type="button"
                onClick={() => handlePreset(p)}
                className="px-2.5 py-1 bg-slate-100 hover:bg-indigo-50 text-slate-700 hover:text-indigo-600 font-mono font-bold rounded-lg border border-slate-200 transition-colors cursor-pointer"
              >
                {p}{isLbs ? 'lb' : 'k'}
              </button>
            ))}
          </div>
        </div>

        {/* Footer */}
        <div className="pt-2 border-t border-slate-100 flex justify-end">
          <Button variant="primary" onClick={onClose} className="w-full sm:w-auto font-bold">
            Done
          </Button>
        </div>
      </Card>
    </div>
  );
}
