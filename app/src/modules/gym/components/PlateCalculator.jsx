import React, { useState } from 'react';
import { X, Dumbbell } from 'lucide-react';
import { calculatePlates } from '../lib/plate-calculator';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';

const KG_COLORS = {
  25: 'bg-red-600',
  20: 'bg-red-500',
  15: 'bg-yellow-400',
  10: 'bg-green-500',
  5: 'bg-white border border-slate-300',
  2.5: 'bg-slate-800 text-white',
  1.25: 'bg-slate-300 text-slate-800'
};

const LBS_COLORS = {
  45: 'bg-red-500',
  35: 'bg-yellow-400',
  25: 'bg-green-500',
  10: 'bg-white border border-slate-300',
  5: 'bg-slate-800 text-white',
  2.5: 'bg-slate-300 text-slate-800'
};

export default function PlateCalculator({ onClose, initialWeight = '' }) {
  const [weight, setWeight] = useState(initialWeight || '');
  const [isLbs, setIsLbs] = useState(false);
  const barWeight = isLbs ? 45 : 20;

  const plates = calculatePlates(parseFloat(weight) || 0, barWeight, isLbs);
  const colors = isLbs ? LBS_COLORS : KG_COLORS;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/50 backdrop-blur-sm">
      <Card className="w-full max-w-md bg-white shadow-2xl relative">
        <button
          onClick={onClose}
          className="absolute top-4 right-4 p-2 text-slate-400 hover:text-slate-600 transition-colors"
        >
          <X className="w-5 h-5" />
        </button>
        
        <div className="p-6">
          <div className="flex items-center gap-3 mb-6">
            <div className="p-2 bg-indigo-100 rounded-lg text-indigo-600">
              <Dumbbell className="w-6 h-6" />
            </div>
            <CardTitle>Plate Calculator</CardTitle>
          </div>

          <div className="space-y-6">
            <div className="flex gap-4 items-end">
              <div className="flex-1">
                <label className="block text-sm font-medium text-slate-700 mb-1">
                  Target Weight
                </label>
                <Input
                  type="number"
                  value={weight}
                  onChange={(e) => setWeight(e.target.value)}
                  placeholder={`e.g. ${isLbs ? '225' : '100'}`}
                  className="text-lg"
                />
              </div>
              
              <div className="flex bg-slate-100 p-1 rounded-lg">
                <button
                  onClick={() => setIsLbs(false)}
                  className={`px-3 py-2 text-sm font-medium rounded-md transition-all ${
                    !isLbs ? 'bg-white shadow-sm text-indigo-600' : 'text-slate-500 hover:text-slate-700'
                  }`}
                >
                  KG
                </button>
                <button
                  onClick={() => setIsLbs(true)}
                  className={`px-3 py-2 text-sm font-medium rounded-md transition-all ${
                    isLbs ? 'bg-white shadow-sm text-indigo-600' : 'text-slate-500 hover:text-slate-700'
                  }`}
                >
                  LBS
                </button>
              </div>
            </div>

            <div className="bg-slate-50 rounded-xl p-6 border border-slate-100 overflow-hidden">
              <div className="text-center mb-4 text-sm text-slate-500 font-medium">
                Bar: {barWeight} {isLbs ? 'lbs' : 'kg'}
              </div>
              
              <div className="flex justify-center items-center h-24 max-w-full overflow-x-auto">
                {/* Bar */}
                <div className="w-16 h-4 bg-slate-300 rounded-l-sm" />
                <div className="w-2 h-6 bg-slate-400 rounded-sm" />
                
                {/* Plates */}
                {plates.length > 0 ? (
                  <div className="flex items-center gap-[2px] mx-1">
                    {plates.map((plate, idx) => {
                      // Determine plate size based on weight
                      let heightClass = 'h-24';
                      if (plate <= 5) heightClass = 'h-12';
                      else if (plate <= 10) heightClass = 'h-16';
                      else if (plate <= 15) heightClass = 'h-20';

                      const colorClass = colors[plate] || 'bg-slate-400';

                      return (
                        <div 
                          key={idx}
                          className={`w-4 rounded-sm flex items-center justify-center ${heightClass} ${colorClass} shadow-sm border border-black/10`}
                          title={`${plate} ${isLbs ? 'lbs' : 'kg'}`}
                        />
                      );
                    })}
                  </div>
                ) : (
                  <div className="w-16 flex items-center justify-center text-xs text-slate-400 px-2 text-center">
                    Add weight
                  </div>
                )}
                
                <div className="w-24 h-4 bg-slate-300 rounded-r-sm" />
              </div>
              
              {plates.length > 0 && (
                <div className="mt-4 flex flex-wrap gap-2 justify-center">
                  {plates.map((plate, idx) => (
                    <span key={idx} className="px-2 py-1 bg-white border border-slate-200 rounded text-xs font-medium text-slate-600 shadow-sm">
                      {plate} {isLbs ? 'lbs' : 'kg'}
                    </span>
                  ))}
                </div>
              )}
            </div>
            
            <div className="flex justify-end pt-2">
              <Button onClick={onClose} variant="primary" className="w-full sm:w-auto">
                Done
              </Button>
            </div>
          </div>
        </div>
      </Card>
    </div>
  );
}
