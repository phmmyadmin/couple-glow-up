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

      {/* Daily Dietary Fiber Tracker Bar */}
      <div className="mt-5 pt-4 border-t border-slate-100 flex flex-col sm:flex-row sm:items-center justify-between gap-2.5">
        <div className="flex items-center gap-2">
          <span className="text-sm">🌾</span>
          <div>
            <span className="text-xs font-bold text-slate-800">Dietary Fiber</span>
            <span className="text-[11px] text-slate-400 block sm:inline sm:ml-2">
              (Target: {targets.fiber || 30}g/day)
            </span>
          </div>
        </div>
        <div className="flex items-center gap-3 min-w-[140px] sm:min-w-[180px]">
          <div className="flex-1 h-2.5 bg-slate-100 rounded-full overflow-hidden">
            <div
              className="h-full bg-teal-500 rounded-full transition-all duration-500"
              style={{
                width: `${Math.min(100, Math.round(((current.fiber || 0) / (targets.fiber || 30)) * 100))}%`,
              }}
            />
          </div>
          <span className="text-xs font-mono font-extrabold text-slate-700 shrink-0">
            {Math.round((current.fiber || 0) * 10) / 10} / {targets.fiber || 30}g
          </span>
        </div>
      </div>
    </Card>
  );
}
