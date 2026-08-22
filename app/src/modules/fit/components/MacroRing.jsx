import React from 'react';
import Card from '../../../shared/ui/Card';

export function SingleMacroRing({ value = 0, target = 100, unit = 'g', label = '', color = '#4F46E5', bgColor = '#F4F4F5' }) {
  const pct = Math.min(100, Math.round(((value || 0) / (target || 1)) * 100));
  const radius = 34;
  const circumference = 2 * Math.PI * radius;
  const strokeDashoffset = circumference - (pct / 100) * circumference;

  return (
    <div className="flex flex-col items-center gap-2 flex-1">
      <div className="relative w-20 h-20 sm:w-24 sm:h-24">
        <svg className="w-full h-full" viewBox="0 0 88 88">
          <circle
            cx="44"
            cy="44"
            r={radius}
            stroke={bgColor}
            strokeWidth="8"
            fill="transparent"
          />
          <circle
            cx="44"
            cy="44"
            r={radius}
            stroke={color}
            strokeWidth="8"
            fill="transparent"
            strokeDasharray={circumference}
            strokeDashoffset={strokeDashoffset}
            strokeLinecap="round"
            style={{ transition: 'stroke-dashoffset 0.6s ease' }}
            transform="rotate(-90 44 44)"
          />
        </svg>
        <div className="absolute inset-0 flex flex-col items-center justify-center text-xs sm:text-sm font-bold text-slate-900">
          <span>{Math.round(value || 0)}</span>
          <span className="text-[10px] text-slate-400 font-normal">
            /{target}{unit}
          </span>
        </div>
      </div>
      <span className="text-xs sm:text-sm font-bold text-slate-700">{label}</span>
    </div>
  );
}

export default function MacroRing({ current = {}, targets = {} }) {
  return (
    <Card className="p-5 sm:p-7">
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-6 items-center justify-between">
        <SingleMacroRing
          value={current.calories || 0}
          target={targets.calories || 2000}
          unit="kcal"
          label="Calories"
          color="#EF4444"
          bgColor="#FEF2F2"
        />
        <SingleMacroRing
          value={current.protein || 0}
          target={targets.protein || 150}
          unit="g"
          label="Protein"
          color="#3B82F6"
          bgColor="#EFF6FF"
        />
        <SingleMacroRing
          value={current.carbs || 0}
          target={targets.carbs || 200}
          unit="g"
          label="Carbs"
          color="#10B981"
          bgColor="#ECFDF5"
        />
        <SingleMacroRing
          value={current.fats || 0}
          target={targets.fats || 60}
          unit="g"
          label="Fats"
          color="#F59E0B"
          bgColor="#FFFBEB"
        />
      </div>

      {/* Daily Micronutrient & Health Bars (Fiber, Sugar, Sodium) */}
      <div className="mt-5 pt-4 border-t border-slate-100 grid grid-cols-1 sm:grid-cols-3 gap-3 sm:gap-4">
        {/* Fiber */}
        <div className="bg-slate-50 border border-slate-100 p-2.5 rounded-xl space-y-1.5 shadow-2xs">
          <div className="flex items-center justify-between text-xs">
            <span className="font-bold text-slate-800 flex items-center gap-1.5">
              <span>🌾</span> Fiber
            </span>
            <span className="font-mono font-extrabold text-teal-700">
              {Math.round((current.fiber || 0) * 10) / 10} / {targets.fiber || 30}g
            </span>
          </div>
          <div className="w-full h-2 bg-slate-200/80 rounded-full overflow-hidden">
            <div
              className="h-full bg-teal-500 rounded-full transition-all duration-500"
              style={{
                width: `${Math.min(100, Math.round(((current.fiber || 0) / (targets.fiber || 30)) * 100))}%`,
              }}
            />
          </div>
        </div>

        {/* Sugar */}
        <div className="bg-slate-50 border border-slate-100 p-2.5 rounded-xl space-y-1.5 shadow-2xs">
          <div className="flex items-center justify-between text-xs">
            <span className="font-bold text-slate-800 flex items-center gap-1.5">
              <span>🍬</span> Sugar
            </span>
            <span className="font-mono font-extrabold text-pink-700">
              {Math.round((current.sugar || 0) * 10) / 10} / {targets.sugar || 50}g
            </span>
          </div>
          <div className="w-full h-2 bg-slate-200/80 rounded-full overflow-hidden">
            <div
              className={`h-full rounded-full transition-all duration-500 ${
                (current.sugar || 0) > (targets.sugar || 50) ? 'bg-rose-500' : 'bg-pink-400'
              }`}
              style={{
                width: `${Math.min(100, Math.round(((current.sugar || 0) / (targets.sugar || 50)) * 100))}%`,
              }}
            />
          </div>
        </div>

        {/* Sodium */}
        <div className="bg-slate-50 border border-slate-100 p-2.5 rounded-xl space-y-1.5 shadow-2xs">
          <div className="flex items-center justify-between text-xs">
            <span className="font-bold text-slate-800 flex items-center gap-1.5">
              <span>🧂</span> Sodium
            </span>
            <span className="font-mono font-extrabold text-indigo-700">
              {Math.round(current.sodium || 0)} / {targets.sodium || 2300}mg
            </span>
          </div>
          <div className="w-full h-2 bg-slate-200/80 rounded-full overflow-hidden">
            <div
              className={`h-full rounded-full transition-all duration-500 ${
                (current.sodium || 0) > (targets.sodium || 2300) ? 'bg-amber-500' : 'bg-indigo-400'
              }`}
              style={{
                width: `${Math.min(100, Math.round(((current.sodium || 0) / (targets.sodium || 2300)) * 100))}%`,
              }}
            />
          </div>
        </div>
      </div>
    </Card>
  );
}
