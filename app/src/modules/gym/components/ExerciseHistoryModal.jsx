import React, { useState, useEffect } from 'react';
import { X, Dumbbell, TrendingUp, Trophy, Calendar } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import { doesSetMatchExercise, formatExerciseName } from '../lib/supabase-gym';
import { getMuscleGroupLabel } from './ExerciseLibrary';

export default function ExerciseHistoryModal({
  exercise,
  workouts = [],
  exercises = [],
  onClose,
}) {
  const [chartMetric, setChartMetric] = useState('max'); // 'max' or 'volume'

  // Handle ESC key to close modal
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [onClose]);

  if (!exercise) return null;

  // Calculate 1RM (Epley formula)
  const calculate1RM = (weight, reps) => {
    const w = parseFloat(weight) || 0;
    const r = parseInt(reps, 10) || 0;
    if (w <= 0 || r <= 0) return 0;
    if (r === 1) return Math.round(w);
    return Math.round(w * (1 + r / 30));
  };

  // Helper to format values on chart nodes
  const formatChartVal = (val, isVolume, exType) => {
    if (!val || isNaN(val)) return '0';
    if (exType === 'distance_duration') return isVolume ? `${val.toFixed(1)}k` : `${val.toFixed(1)}k/h`;
    if (exType === 'duration_only') return `${val}s`;
    if (exType === 'reps_only') return `${val}r`;
    return isVolume ? (val >= 1000 ? `${(val / 1000).toFixed(1)}k` : `${val}k`) : `${val}k`;
  };

  // Build History Data
  const targetEx = exercises.find((e) => e.id === exercise.id) || exercise;
  const exType = targetEx.exercise_type || exercise.exercise_type || 'weight_reps';

  const historySessions = [];
  const chartPoints = [];

  const sortedWorkouts = [...workouts].sort(
    (a, b) => new Date(b.started_at) - new Date(a.started_at)
  );

  let peak1RM = 0;
  let maxWeight = 0;
  let peakSpeedKmh = 0;
  let maxDistanceKm = 0;
  let maxDurationSec = 0;

  sortedWorkouts.forEach((w) => {
    const sets = w.workout_sets || [];
    const exSets = sets.filter((s) => doesSetMatchExercise(s, targetEx, exercises));

    if (exSets.length > 0) {
      let sessionMaxWeight = 0;
      let sessionMax1RM = 0;
      let sessionVolume = 0;
      let sessionMaxSpeed = 0;
      let sessionDistanceM = 0;
      let sessionDurationS = 0;

      exSets.forEach((s) => {
        const wKg = parseFloat(s.weight_kg) || 0;
        const reps = parseInt(s.reps, 10) || 0;
        const durSec = parseInt(s.duration_seconds, 10) || 0;
        const distM = parseFloat(s.distance_meters) || 0;

        if (wKg > sessionMaxWeight) sessionMaxWeight = wKg;
        if (wKg > maxWeight) maxWeight = wKg;

        const est1RM = calculate1RM(wKg, reps);
        if (est1RM > sessionMax1RM) sessionMax1RM = est1RM;
        if (est1RM > peak1RM) peak1RM = est1RM;

        sessionVolume += wKg * reps;

        if (durSec > sessionDurationS) sessionDurationS = durSec;
        if (durSec > maxDurationSec) maxDurationSec = durSec;

        if (distM > sessionDistanceM) sessionDistanceM = distM;
        if (distM / 1000 > maxDistanceKm) maxDistanceKm = distM / 1000;

        if (distM > 0 && durSec > 0) {
          const speedKmh = (distM / 1000) / (durSec / 3600);
          if (speedKmh > sessionMaxSpeed) sessionMaxSpeed = speedKmh;
          if (speedKmh > peakSpeedKmh) peakSpeedKmh = speedKmh;
        }
      });

      const dateStr = new Date(w.started_at).toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
      });

      historySessions.push({
        id: w.id,
        workoutName: w.name,
        date: dateStr,
        fullDate: new Date(w.started_at).toLocaleDateString('en-US', {
          month: 'short',
          day: 'numeric',
          year: 'numeric',
        }),
        sets: exSets,
        sessionMaxWeight,
        sessionMax1RM,
        sessionVolume,
        sessionMaxSpeed,
        sessionDistanceKm: sessionDistanceM / 1000,
        sessionDurationSec: sessionDurationS,
      });

      let val1RM = sessionMax1RM;
      let valVol = sessionVolume;

      if (exType === 'distance_duration') {
        val1RM = sessionMaxSpeed;
        valVol = sessionDistanceM / 1000;
      } else if (exType === 'duration_only') {
        val1RM = sessionDurationS;
        valVol = sessionDurationS;
      } else if (exType === 'reps_only') {
        const maxR = Math.max(...exSets.map((s) => parseInt(s.reps, 10) || 0), 0);
        val1RM = maxR;
        valVol = exSets.reduce((sum, s) => sum + (parseInt(s.reps, 10) || 0), 0);
      }

      chartPoints.push({
        date: dateStr,
        val1RM,
        valVolume: valVol,
      });
    }
  });

  chartPoints.reverse();

  const hasHistory = historySessions.length > 0;
  const activeMetric = chartMetric || 'max';
  const rawValues = chartPoints.map((p) => (activeMetric === 'volume' ? p.valVolume : p.val1RM));
  const maxVal = Math.max(...rawValues, 1);
  const minVal = Math.min(...rawValues, 0);
  const range = Math.max(maxVal - minVal, 10);

  const pointSpacing = 55;
  const svgWidth = Math.max(320, chartPoints.length * pointSpacing);

  const points = chartPoints.map((p, idx) => {
    const rawVal = activeMetric === 'volume' ? p.valVolume : p.val1RM;
    const targetVal = typeof rawVal === 'number' && !isNaN(rawVal) ? rawVal : 0;
    const x = chartPoints.length === 1 ? svgWidth / 2 : 35 + idx * pointSpacing;
    const rawY = 125 - ((targetVal - minVal) / range) * 85;
    const y = isFinite(rawY) ? rawY : 125;
    return { x, y, targetVal, date: p.date };
  });

  const svgPathStr =
    points.length > 0
      ? points.reduce((acc, pt, i) => (i === 0 ? `M ${pt.x} ${pt.y}` : `${acc} L ${pt.x} ${pt.y}`), '')
      : '';

  const areaPathStr =
    points.length > 1 ? `${svgPathStr} L ${points[points.length - 1].x} 125 L ${points[0].x} 125 Z` : '';

  return (
    <div
      className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
      onClick={onClose}
    >
      <Card
        className="max-w-lg w-full p-5 sm:p-6 space-y-5 shadow-2xl border border-slate-200 max-h-[90vh] overflow-y-auto cursor-default"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header Row */}
        <div className="flex items-start justify-between gap-3 border-b border-slate-100 pb-4">
          <div>
            <div className="flex items-center gap-2">
              <h3 className="text-lg font-extrabold text-slate-900 leading-tight">
                {targetEx.name || targetEx.name_es || exercise.name}
              </h3>
              {targetEx.muscle_group && (
                <span className="text-xs bg-indigo-50 text-indigo-700 font-bold px-2.5 py-0.5 rounded-md border border-indigo-100 shrink-0">
                  {getMuscleGroupLabel(targetEx.muscle_group)}
                </span>
              )}
            </div>
            <p className="text-xs text-slate-500 font-medium mt-1">
              Exercise performance analytics & workout history
            </p>
          </div>

          <button
            onClick={onClose}
            className="p-1.5 text-slate-400 hover:text-slate-700 rounded-xl hover:bg-slate-100 transition-colors shrink-0"
            title="Close (ESC)"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Overview Key Metrics Grid */}
        <div className="grid grid-cols-3 gap-3">
          {exType === 'distance_duration' ? (
            <>
              <div className="bg-indigo-50/60 border border-indigo-100 rounded-xl p-3 text-center">
                <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-wider block">Peak Speed</span>
                <span className="text-base font-extrabold text-indigo-900 font-mono">
                  {peakSpeedKmh > 0 ? `${peakSpeedKmh.toFixed(1)} km/h` : '-'}
                </span>
              </div>
              <div className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 text-center">
                <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">Max Distance</span>
                <span className="text-base font-extrabold text-slate-800 font-mono">
                  {maxDistanceKm > 0 ? `${maxDistanceKm.toFixed(1)} km` : '-'}
                </span>
              </div>
            </>
          ) : exType === 'duration_only' ? (
            <>
              <div className="bg-indigo-50/60 border border-indigo-100 rounded-xl p-3 text-center">
                <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-wider block">Max Duration</span>
                <span className="text-base font-extrabold text-indigo-900 font-mono">
                  {maxDurationSec > 0 ? `${Math.floor(maxDurationSec / 60)}:${String(maxDurationSec % 60).padStart(2, '0')} min` : '-'}
                </span>
              </div>
              <div className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 text-center">
                <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">Max Set</span>
                <span className="text-base font-extrabold text-slate-800 font-mono">
                  {maxDurationSec > 0 ? `${maxDurationSec}s` : '-'}
                </span>
              </div>
            </>
          ) : (
            <>
              <div className="bg-indigo-50/60 border border-indigo-100 rounded-xl p-3 text-center">
                <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-wider block">Peak 1RM</span>
                <span className="text-base font-extrabold text-indigo-900 font-mono">
                  {peak1RM > 0 ? `${peak1RM} kg` : '-'}
                </span>
              </div>
              <div className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 text-center">
                <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">Max Weight</span>
                <span className="text-base font-extrabold text-slate-800 font-mono">
                  {maxWeight > 0 ? `${maxWeight} kg` : '-'}
                </span>
              </div>
            </>
          )}
          <div className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 text-center">
            <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">Sessions</span>
            <span className="text-base font-extrabold text-slate-800 font-mono">
              {historySessions.length}
            </span>
          </div>
        </div>

        {/* SVG Progression Chart with Metric Switcher */}
        {hasHistory && chartPoints.length > 0 && (
          <div className="bg-slate-50 border border-slate-200/90 rounded-2xl p-4 space-y-3 shadow-2xs">
            <div className="flex items-center justify-between gap-2 text-xs flex-wrap">
              <span className="font-bold flex items-center gap-1.5 text-indigo-700">
                <TrendingUp className="w-4 h-4 text-indigo-600" />
                <span>
                  {activeMetric === 'volume'
                    ? exType === 'distance_duration'
                      ? 'Total Distance per Workout (km)'
                      : 'Total Volume per Workout (kg)'
                    : exType === 'distance_duration'
                    ? 'Peak Speed (km/h)'
                    : exType === 'duration_only'
                    ? 'Max Duration'
                    : exType === 'reps_only'
                    ? 'Max Reps'
                    : 'Peak 1RM (kg)'}
                </span>
              </span>

              {/* Metric Toggle */}
              <div className="flex items-center bg-slate-200/70 p-0.5 rounded-xl border border-slate-300/60 text-[10px] font-bold">
                <button
                  type="button"
                  onClick={() => setChartMetric('max')}
                  className={`px-2.5 py-1 rounded-lg transition-all ${
                    activeMetric === 'max'
                      ? 'bg-indigo-600 text-white font-extrabold shadow-2xs'
                      : 'text-slate-600 hover:text-slate-900'
                  }`}
                >
                  {exType === 'distance_duration' ? 'Speed' : '1RM / Max'}
                </button>
                <button
                  type="button"
                  onClick={() => setChartMetric('volume')}
                  className={`px-2.5 py-1 rounded-lg transition-all ${
                    activeMetric === 'volume'
                      ? 'bg-indigo-600 text-white font-extrabold shadow-2xs'
                      : 'text-slate-600 hover:text-slate-900'
                  }`}
                >
                  Volume
                </button>
              </div>
            </div>

            <div className="overflow-x-auto scrollbar-thin pb-2 pt-1">
              <svg className="h-44 overflow-visible" style={{ width: `${svgWidth}px` }} viewBox={`0 0 ${svgWidth} 160`}>
                <defs>
                  <linearGradient id="lightChartGrad" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stopColor="#6366f1" stopOpacity="0.22" />
                    <stop offset="100%" stopColor="#6366f1" stopOpacity="0.0" />
                  </linearGradient>
                </defs>

                {/* Grid Lines */}
                <line x1="20" y1="30" x2={svgWidth - 20} y2="30" stroke="#e2e8f0" strokeDasharray="4 4" strokeWidth="1" />
                <line x1="20" y1="75" x2={svgWidth - 20} y2="75" stroke="#e2e8f0" strokeDasharray="4 4" strokeWidth="1" />
                <line x1="20" y1="120" x2={svgWidth - 20} y2="120" stroke="#e2e8f0" strokeDasharray="4 4" strokeWidth="1" />

                {/* Area Fill */}
                {areaPathStr && <path d={areaPathStr} fill="url(#lightChartGrad)" />}

                {/* SVG Line */}
                {svgPathStr && (
                  <path
                    d={svgPathStr}
                    fill="none"
                    stroke="#4f46e5"
                    strokeWidth="3.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                )}

                {/* SVG Data Nodes */}
                {points.map((pt, idx) => {
                  const formattedVal = formatChartVal(pt.targetVal, activeMetric === 'volume', exType);
                  const isLatest = idx === points.length - 1;

                  return (
                    <g key={idx}>
                      <circle
                        cx={pt.x}
                        cy={pt.y}
                        r={isLatest ? '5.5' : '4.5'}
                        fill={isLatest ? '#4f46e5' : '#6366f1'}
                        stroke="#ffffff"
                        strokeWidth="2.5"
                      />
                      <text
                        x={pt.x}
                        y={pt.y - 10}
                        textAnchor="middle"
                        fill="#334155"
                        fontSize="10"
                        fontWeight="700"
                        fontFamily="monospace"
                      >
                        {formattedVal}
                      </text>
                      <text
                        x={pt.x}
                        y="145"
                        textAnchor="middle"
                        fill="#94a3b8"
                        fontSize="10"
                        fontWeight="600"
                      >
                        {pt.date}
                      </text>
                    </g>
                  );
                })}
              </svg>
            </div>
          </div>
        )}

        {/* Sessions History List */}
        <div className="space-y-3 pt-1">
          <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">
            Performance History Across Workouts
          </h4>

          {!hasHistory ? (
            <div className="text-center py-8 text-slate-400 text-sm">
              No logged workout history found for this exercise.
            </div>
          ) : (
            <div className="space-y-3">
              {historySessions.map((session) => (
                <div
                  key={session.id}
                  className="bg-slate-50 border border-slate-200/80 p-3.5 rounded-2xl space-y-2"
                >
                  <div className="flex items-center justify-between text-xs font-bold text-slate-800">
                    <span>{session.workoutName}</span>
                    <span className="text-slate-400 font-normal">{session.fullDate}</span>
                  </div>

                  <div className="flex flex-wrap gap-1.5">
                    {session.sets.map((s, idx) => {
                      const label =
                        s.indicator === 'warmup'
                          ? 'W'
                          : s.indicator === 'drop'
                          ? 'D'
                          : s.indicator === 'failure'
                          ? 'F'
                          : `${idx + 1}`;

                      return (
                        <div
                          key={idx}
                          className="bg-white border border-slate-200 text-slate-800 font-mono text-[11px] font-bold px-2 py-1 rounded-lg shadow-2xs flex items-center gap-1.5"
                        >
                          <span className="text-slate-400 text-[10px]">{label}:</span>
                          <span>
                            {s.weight_kg ? `${s.weight_kg}kg ` : ''}
                            {s.reps ? `× ${s.reps}` : ''}
                            {s.duration_seconds ? ` ⏱${s.duration_seconds}s` : ''}
                            {s.distance_meters ? ` 📍${(s.distance_meters / 1000).toFixed(1)}km` : ''}
                          </span>
                          {s.is_pr && (
                            <span className="text-[9px] bg-amber-100 text-amber-800 px-1 py-0.2 rounded font-sans flex items-center gap-0.5">
                              <Trophy className="w-2.5 h-2.5 text-amber-600" /> PR
                            </span>
                          )}
                        </div>
                      );
                    })}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </Card>
    </div>
  );
}
