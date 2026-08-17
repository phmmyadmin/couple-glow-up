import React from 'react';

export function computeMuscleSetsMap(targetWorkouts = [], exercises = []) {
  const map = {
    chest: 0,
    shoulders: 0,
    biceps: 0,
    triceps: 0,
    abs: 0,
    quads: 0,
    hamstrings: 0,
    glutes: 0,
    back: 0,
    calves: 0,
  };

  targetWorkouts.forEach((w) => {
    (w.workout_sets || []).forEach((s) => {
      const exId = s.exercise_id;
      const matchedEx = exercises.find((e) => e.id === exId) || s.exercises || s.exercise;
      const main = String(matchedEx?.muscle_group || '').toLowerCase().trim();

      const assignSets = (mStr, val) => {
        if (!mStr) return;
        if (/chest|pecs|pecho/.test(mStr)) map.chest += val;
        else if (/shoulder|delts|hombro|deltoide/.test(mStr)) map.shoulders += val;
        else if (/bicep|brazo|arms/.test(mStr) && !mStr.includes('tri')) map.biceps += val;
        else if (/tricep/.test(mStr)) map.triceps += val;
        else if (/abs|abdom|core|obliq|oblicu/.test(mStr)) map.abs += val;
        else if (/quad|cuad|pierna|leg/.test(mStr) && !/hamstring|isquio|femoral|glute|calf|gemelo/.test(mStr)) map.quads += val;
        else if (/hamstring|isquio|femoral/.test(mStr)) map.hamstrings += val;
        else if (/glute|glúte/.test(mStr)) map.glutes += val;
        else if (/lat|back|dorsal|trape|lumbar|espalda/.test(mStr)) map.back += val;
        else if (/calf|calves|gemelo|pantorrilla/.test(mStr)) map.calves += val;
      };

      assignSets(main, 1);

      if (Array.isArray(matchedEx?.other_muscles)) {
        matchedEx.other_muscles.forEach((sec) => assignSets(String(sec).toLowerCase().trim(), 0.5));
      }
    });
  });

  return map;
}

export default function MuscleRadarChart({ targetWorkouts = [], exercises = [] }) {
  const setsMap = React.useMemo(() => computeMuscleSetsMap(targetWorkouts, exercises), [targetWorkouts, exercises]);

  const axes = [
    { key: 'chest', label: 'Chest' },
    { key: 'shoulders', label: 'Shoulders' },
    { key: 'biceps', label: 'Biceps' },
    { key: 'triceps', label: 'Triceps' },
    { key: 'abs', label: 'Abs / Core' },
    { key: 'quads', label: 'Quads' },
    { key: 'hamstrings', label: 'Hamstrings' },
    { key: 'glutes', label: 'Glutes' },
    { key: 'back', label: 'Back' },
    { key: 'calves', label: 'Calves' },
  ];

  const totalSets = Object.values(setsMap).reduce((a, b) => a + b, 0);
  const maxSetsRecorded = Math.max(...Object.values(setsMap), 1);
  const maxScale = Math.max(10, Math.ceil(maxSetsRecorded / 5) * 5); // Multiples of 5 (min 10)

  const cx = 110;
  const cy = 105;
  const radius = 68;
  const n = axes.length;

  // Calculate polygon points
  const points = axes.map((axis, i) => {
    const angle = (i * 2 * Math.PI) / n - Math.PI / 2;
    const value = setsMap[axis.key] || 0;
    const r = (value / maxScale) * radius;
    const x = cx + r * Math.cos(angle);
    const y = cy + r * Math.sin(angle);
    return { x, y, value, angle, label: axis.label };
  });

  const polygonPath = points.map((p) => `${p.x},${p.y}`).join(' ');

  // Concentric grid rings
  const rings = [0.25, 0.5, 0.75, 1];

  return (
    <div className="flex flex-col items-center justify-between h-full py-1">
      <div className="relative w-full flex items-center justify-center">
        <svg viewBox="0 0 220 210" className="w-56 h-56 sm:w-64 sm:h-64 drop-shadow-2xs overflow-visible">
          {/* Grid Rings */}
          {rings.map((ringFactor, rIdx) => {
            const r = radius * ringFactor;
            const ringPoints = axes
              .map((_, i) => {
                const angle = (i * 2 * Math.PI) / n - Math.PI / 2;
                return `${cx + r * Math.cos(angle)},${cy + r * Math.sin(angle)}`;
              })
              .join(' ');
            return (
              <polygon
                key={rIdx}
                points={ringPoints}
                fill="none"
                stroke="#e2e8f0"
                strokeWidth="1"
                strokeDasharray={rIdx < 3 ? '2 2' : 'none'}
              />
            );
          })}

          {/* Radial Spokes & Outer Labels */}
          {axes.map((axis, i) => {
            const angle = (i * 2 * Math.PI) / n - Math.PI / 2;
            const x2 = cx + radius * Math.cos(angle);
            const y2 = cy + radius * Math.sin(angle);

            // Label positioning offset
            const labelR = radius + 16;
            const lx = cx + labelR * Math.cos(angle);
            const ly = cy + labelR * Math.sin(angle);

            let textAnchor = 'middle';
            if (Math.cos(angle) > 0.2) textAnchor = 'start';
            else if (Math.cos(angle) < -0.2) textAnchor = 'end';

            const val = setsMap[axis.key] || 0;
            const isActive = val > 0;

            return (
              <g key={axis.key}>
                <line x1={cx} y1={cy} x2={x2} y2={y2} stroke="#cbd5e1" strokeWidth="1" />
                <text
                  x={lx}
                  y={ly + 3}
                  textAnchor={textAnchor}
                  className={`text-[9px] font-extrabold transition-colors ${
                    isActive ? 'fill-blue-700' : 'fill-slate-400'
                  }`}
                >
                  {axis.label}
                  {isActive && <tspan className="fill-blue-600 font-mono font-bold"> ({val}s)</tspan>}
                </text>
              </g>
            );
          })}

          {/* Data Filled Polygon */}
          {totalSets > 0 && (
            <polygon
              points={polygonPath}
              fill="#2563eb"
              fillOpacity="0.3"
              stroke="#1d4ed8"
              strokeWidth="2"
              className="transition-all duration-500 ease-out"
            />
          )}

          {/* Vertex Points */}
          {points.map((p, i) => {
            if (p.value === 0) return null;
            return (
              <g key={i}>
                <circle cx={p.x} cy={p.y} r="4" fill="#2563eb" stroke="#ffffff" strokeWidth="2" />
              </g>
            );
          })}

          {/* Center Dot */}
          <circle cx={cx} cy={cy} r="2.5" fill="#94a3b8" />
        </svg>
      </div>

      {/* Summary Footer */}
      <div className="flex items-center justify-between w-full pt-2 border-t border-slate-100 text-xs text-slate-500 font-medium">
        <span>Total Volume: <strong className="text-slate-800 font-mono">{totalSets} sets</strong></span>
        <span className="text-[10px] text-slate-400">Max Scale: {maxScale} sets</span>
      </div>
    </div>
  );
}
