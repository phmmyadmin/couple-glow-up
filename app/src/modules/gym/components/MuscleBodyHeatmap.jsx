import React from 'react';
import Card from '../../../shared/ui/Card';

export default function MuscleBodyHeatmap({ activeMuscles = [], title = 'Muscles Worked' }) {
  // Normalize active muscle strings
  const activeSet = new Set(activeMuscles.map((m) => String(m).toLowerCase().trim()));

  const isMuscleActive = (muscleKey) => {
    if (activeSet.has(muscleKey)) return true;
    if (muscleKey === 'chest' && activeSet.has('pecs')) return true;
    if (muscleKey === 'shoulders' && (activeSet.has('delts') || activeSet.has('shoulder'))) return true;
    if (muscleKey === 'quadriceps' && (activeSet.has('quads') || activeSet.has('legs'))) return true;
    if (muscleKey === 'hamstrings' && activeSet.has('legs')) return true;
    if (muscleKey === 'glutes' && activeSet.has('legs')) return true;
    if (muscleKey === 'calves' && activeSet.has('legs')) return true;
    if (muscleKey === 'lats' && activeSet.has('back')) return true;
    if (muscleKey === 'upper_back' && activeSet.has('back')) return true;
    if (muscleKey === 'lower_back' && activeSet.has('back')) return true;
    return false;
  };

  const activeColor = '#2563eb'; // Vibrant Blue
  const activeStroke = '#1d4ed8';
  const inactiveColor = '#e2e8f0'; // Light Slate
  const inactiveStroke = '#cbd5e1';

  const getStyle = (muscleKey) => {
    const active = isMuscleActive(muscleKey);
    return {
      fill: active ? activeColor : inactiveColor,
      stroke: active ? activeStroke : inactiveStroke,
      strokeWidth: active ? 1.5 : 1,
      transition: 'all 0.3s ease',
    };
  };

  return (
    <Card className="p-4 sm:p-5 space-y-3 shadow-sm border border-slate-200/90 rounded-2xl bg-white flex flex-col justify-between">
      <div className="flex items-center justify-between">
        <h4 className="text-sm font-extrabold text-slate-900 flex items-center gap-2">
          <span className="w-2.5 h-2.5 rounded-full bg-blue-600 animate-pulse" />
          <span>{title}</span>
        </h4>
        <span className="text-[10px] font-bold bg-blue-50 text-blue-700 px-2 py-0.5 rounded-md border border-blue-100 uppercase">
          {activeSet.size} Group{activeSet.size !== 1 ? 's' : ''}
        </span>
      </div>

      {/* Front & Back Anatomical Silhouettes */}
      <div className="flex items-center justify-center gap-6 py-2">
        {/* FRONT VIEW */}
        <div className="flex flex-col items-center gap-1">
          <span className="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Front</span>
          <svg viewBox="0 0 100 200" className="w-24 h-48 sm:w-28 sm:h-52 drop-shadow-2xs">
            {/* Head */}
            <circle cx="50" cy="18" r="10" fill="#f1f5f9" stroke="#cbd5e1" strokeWidth="1" />
            {/* Neck */}
            <rect x="47" y="27" width="6" height="7" rx="2" fill="#f1f5f9" stroke="#cbd5e1" strokeWidth="1" />

            {/* Shoulders (Deltoids) */}
            <path d="M 31 34 Q 25 36 24 45 Q 31 43 33 37 Z" style={getStyle('shoulders')} />
            <path d="M 69 34 Q 75 36 76 45 Q 69 43 67 37 Z" style={getStyle('shoulders')} />

            {/* Chest (Pectorals) */}
            <path d="M 34 37 Q 50 39 50 54 Q 35 54 34 37 Z" style={getStyle('chest')} />
            <path d="M 66 37 Q 50 39 50 54 Q 65 54 66 37 Z" style={getStyle('chest')} />

            {/* Biceps */}
            <path d="M 23 46 Q 21 58 26 64 Q 30 58 29 47 Z" style={getStyle('biceps')} />
            <path d="M 77 46 Q 79 58 74 64 Q 70 58 71 47 Z" style={getStyle('biceps')} />

            {/* Forearms */}
            <path d="M 25 66 Q 20 80 23 92 Q 27 88 28 67 Z" style={getStyle('forearms')} />
            <path d="M 75 66 Q 80 80 77 92 Q 73 88 72 67 Z" style={getStyle('forearms')} />

            {/* Abs / Core */}
            <path d="M 37 56 L 63 56 L 61 88 L 39 88 Z" style={getStyle('abs')} />

            {/* Quadriceps (Front Thighs) */}
            <path d="M 37 92 Q 35 125 43 140 Q 48 135 48 93 Z" style={getStyle('quadriceps')} />
            <path d="M 63 92 Q 65 125 57 140 Q 52 135 52 93 Z" style={getStyle('quadriceps')} />

            {/* Calves (Front Shin/Calf Side) */}
            <path d="M 38 144 Q 34 165 40 185 Q 45 180 44 144 Z" style={getStyle('calves')} />
            <path d="M 62 144 Q 66 165 60 185 Q 55 180 56 144 Z" style={getStyle('calves')} />
          </svg>
        </div>

        {/* BACK VIEW */}
        <div className="flex flex-col items-center gap-1">
          <span className="text-[10px] font-extrabold text-slate-400 uppercase tracking-wider">Back</span>
          <svg viewBox="0 0 100 200" className="w-24 h-48 sm:w-28 sm:h-52 drop-shadow-2xs">
            {/* Head */}
            <circle cx="50" cy="18" r="10" fill="#f1f5f9" stroke="#cbd5e1" strokeWidth="1" />
            {/* Neck */}
            <rect x="47" y="27" width="6" height="7" rx="2" fill="#f1f5f9" stroke="#cbd5e1" strokeWidth="1" />

            {/* Upper Back / Traps */}
            <path d="M 34 34 L 50 44 L 66 34 L 50 30 Z" style={getStyle('upper_back')} />

            {/* Lats (Latissimus Dorsi) */}
            <path d="M 32 36 L 49 46 L 40 70 L 29 50 Z" style={getStyle('lats')} />
            <path d="M 68 36 L 51 46 L 60 70 L 71 50 Z" style={getStyle('lats')} />

            {/* Lower Back */}
            <path d="M 40 70 L 60 70 L 58 88 L 42 88 Z" style={getStyle('lower_back')} />

            {/* Triceps */}
            <path d="M 23 45 Q 20 58 25 64 Q 29 58 29 46 Z" style={getStyle('triceps')} />
            <path d="M 77 45 Q 80 58 75 64 Q 71 58 71 46 Z" style={getStyle('triceps')} />

            {/* Glutes */}
            <path d="M 36 90 Q 50 88 50 108 Q 36 108 36 90 Z" style={getStyle('glutes')} />
            <path d="M 64 90 Q 50 88 50 108 Q 64 108 64 90 Z" style={getStyle('glutes')} />

            {/* Hamstrings */}
            <path d="M 36 110 Q 36 135 44 140 Q 48 135 48 110 Z" style={getStyle('hamstrings')} />
            <path d="M 64 110 Q 64 135 56 140 Q 52 135 52 110 Z" style={getStyle('hamstrings')} />

            {/* Calves (Back Calves) */}
            <path d="M 38 144 Q 33 165 40 185 Q 46 180 45 144 Z" style={getStyle('calves')} />
            <path d="M 62 144 Q 67 165 60 185 Q 54 180 55 144 Z" style={getStyle('calves')} />
          </svg>
        </div>
      </div>

      {/* Active Muscle Labels Pill Bar */}
      <div className="flex flex-wrap items-center justify-center gap-1 pt-1 border-t border-slate-100 min-h-[28px]">
        {Array.from(activeSet).length === 0 ? (
          <span className="text-[11px] text-slate-400 font-medium italic">No muscles targeted</span>
        ) : (
          Array.from(activeSet).map((mKey) => (
            <span
              key={mKey}
              className="text-[10px] bg-blue-50 text-blue-700 font-extrabold px-2 py-0.5 rounded-md border border-blue-100 capitalize"
            >
              {mKey.replace('_', ' ')}
            </span>
          ))
        )}
      </div>
    </Card>
  );
}
