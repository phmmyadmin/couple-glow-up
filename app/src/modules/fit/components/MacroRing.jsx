import React from 'react';
import Card from '../../../shared/ui/Card';

export function SingleMacroRing({ value = 0, target = 100, unit = 'g', label = '', color = '#4F46E5', bgColor = '#F4F4F5' }) {
  const pct = Math.min(100, Math.round(((value || 0) / (target || 1)) * 100));
  const radius = 34;
  const circumference = 2 * Math.PI * radius;
  const strokeDashoffset = circumference - (pct / 100) * circumference;

  return (
    <div className="flex flex-col items-center gap-1.5 flex-1">
      <div className="relative w-20 h-20 sm:w-22 sm:h-22">
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
        <div className="absolute inset-0 flex flex-col items-center justify-center text-xs font-bold text-slate-900">
          <span>{Math.round(value || 0)}</span>
          <span className="text-[10px] text-slate-400 font-normal">
            /{target}{unit}
          </span>
        </div>
      </div>
      <span className="text-xs font-semibold text-slate-700">{label}</span>
    </div>
  );
}

export default function MacroRing({ current = {}, targets = {} }) {
  return (
    <Card className="p-4 sm:p-5">
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 items-center justify-between">
        <SingleMacroRing
          value={current.calories || 0}
          target={targets.calories || 2000}
          unit="kcal"
          label="Calorías"
          color="#EF4444"
          bgColor="#FEF2F2"
        />
        <SingleMacroRing
          value={current.protein || 0}
          target={targets.protein || 150}
          unit="g"
          label="Proteínas"
          color="#3B82F6"
          bgColor="#EFF6FF"
        />
        <SingleMacroRing
          value={current.carbs || 0}
          target={targets.carbs || 200}
          unit="g"
          label="Carbos"
          color="#10B981"
          bgColor="#ECFDF5"
        />
        <SingleMacroRing
          value={current.fats || 0}
          target={targets.fats || 60}
          unit="g"
          label="Grasas"
          color="#F59E0B"
          bgColor="#FFFBEB"
        />
      </div>
    </Card>
  );
}
