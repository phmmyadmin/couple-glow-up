import React, { useState } from 'react';
import { Search, Plus, Dumbbell, Filter, Info, Trophy, TrendingUp, Calendar, Flame, ChevronRight, X, ExternalLink } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';
import { calculate1RM } from '../lib/supabase-gym';

const MUSCLE_GROUPS = [
  { id: 'all', label: 'All Muscles' },
  { id: 'chest', label: 'Chest' },
  { id: 'back', label: 'Back' },
  { id: 'legs', label: 'Legs' },
  { id: 'shoulders', label: 'Shoulders' },
  { id: 'biceps', label: 'Biceps' },
  { id: 'triceps', label: 'Triceps' },
  { id: 'abdominals', label: 'Core' },
  { id: 'cardio', label: 'Cardio' },
  { id: 'other', label: 'Other' },
];

const EQUIPMENT_TYPES = [
  { id: 'all', label: 'All Equipment' },
  { id: 'barbell', label: '🏋️ Barbell' },
  { id: 'dumbbell', label: '🏋️‍♂️ Dumbbell' },
  { id: 'machine', label: '⚙️ Machine' },
  { id: 'cable', label: '🔌 Cable' },
  { id: 'bodyweight', label: '🤸 Bodyweight' },
  { id: 'kettlebell', label: '🔔 Kettlebell' },
  { id: 'smith_machine', label: '🏗️ Smith Machine' },
  { id: 'other', label: '📦 Other' },
];

export default function ExerciseLibrary({
  exercises,
  workouts = [],
  personalRecords = [],
  onAddCustomExercise,
  onSelectExercise,
  onGoToWorkout,
}) {
  const [search, setSearch] = useState('');
  const [selectedMuscle, setSelectedMuscle] = useState('all');
  const [selectedEquipment, setSelectedEquipment] = useState('all');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedExerciseForHistory, setSelectedExerciseForHistory] = useState(null);

  // New custom exercise state
  const [customName, setCustomName] = useState('');
  const [customMuscle, setCustomMuscle] = useState('chest');
  const [customSecondaryMuscles, setCustomSecondaryMuscles] = useState([]);
  const [customType, setCustomType] = useState('weight_reps');
  const [customEquipment, setCustomEquipment] = useState('dumbbell');

  // Parse other_muscles whether it comes as array or JSON string
  const parseOtherMuscles = (e) => {
    const raw = e.other_muscles;
    if (!raw) return [];
    if (Array.isArray(raw)) return raw;
    try {
      return JSON.parse(raw);
    } catch {
      return [];
    }
  };

  const filteredExercises = exercises.filter((e) => {
    const matchesSearch =
      (e.name || e.name_es || '').toLowerCase().includes(search.toLowerCase());
    const secondaries = parseOtherMuscles(e);
    const matchesMuscle =
      selectedMuscle === 'all' ||
      e.muscle_group === selectedMuscle ||
      secondaries.includes(selectedMuscle);

    const eqLower = (e.equipment_category || e.equipment || '').toLowerCase();
    const matchesEquipment =
      selectedEquipment === 'all' ||
      eqLower === selectedEquipment ||
      (selectedEquipment === 'other' &&
        !['barbell', 'dumbbell', 'machine', 'cable', 'bodyweight', 'kettlebell', 'smith_machine'].includes(eqLower));

    return matchesSearch && matchesMuscle && matchesEquipment;
  });

  const handleCreateCustom = (e) => {
    e.preventDefault();
    if (!customName.trim()) return;

    if (onAddCustomExercise) {
      onAddCustomExercise({
        name: customName.trim(),
        name_es: customName.trim(),
        muscle_group: customMuscle,
        other_muscles: customSecondaryMuscles,
        exercise_type: customType,
        equipment_category: customEquipment,
        is_custom: true,
      });
    }

    setCustomName('');
    setCustomSecondaryMuscles([]);
    setIsModalOpen(false);
  };

  const toggleSecondaryMuscle = (muscleId) => {
    if (customSecondaryMuscles.includes(muscleId)) {
      setCustomSecondaryMuscles(customSecondaryMuscles.filter((id) => id !== muscleId));
    } else {
      setCustomSecondaryMuscles([...customSecondaryMuscles, muscleId]);
    }
  };

  // Compute history statistics for selected exercise
  const getExerciseHistoryData = (exId) => {
    if (!exId || !workouts.length) return { historySessions: [], max1RM: 0, maxWeight: 0, maxVolume: 0, chartPoints: [] };

    const sessions = [];

    // Filter workouts that contain this exercise
    workouts.forEach((w) => {
      const setsForEx = (w.workout_sets || []).filter(
        (s) => s.exercise_id === exId || s.exercises?.id === exId
      );

      if (setsForEx.length > 0) {
        let best1RM = 0;
        let bestWeight = 0;
        let totalVolume = 0;

        setsForEx.forEach((s) => {
          const wKg = parseFloat(s.weight_kg) || 0;
          const r = parseInt(s.reps, 10) || 0;
          if (wKg > bestWeight) bestWeight = wKg;
          const est1RM = calculate1RM(wKg, r);
          if (est1RM > best1RM) best1RM = est1RM;
          totalVolume += wKg * r;
        });

        sessions.push({
          workoutId: w.id,
          workoutName: w.name,
          date: w.started_at,
          sets: setsForEx,
          best1RM,
          bestWeight,
          totalVolume,
        });
      }
    });

    // Sort chronologically for chart
    const chronologicalSessions = [...sessions].sort(
      (a, b) => new Date(a.date) - new Date(b.date)
    );

    let globalMax1RM = 0;
    let globalMaxWeight = 0;
    let globalMaxVolume = 0;

    chronologicalSessions.forEach((s) => {
      if (s.best1RM > globalMax1RM) globalMax1RM = s.best1RM;
      if (s.bestWeight > globalMaxWeight) globalMaxWeight = s.bestWeight;
      if (s.totalVolume > globalMaxVolume) globalMaxVolume = s.totalVolume;
    });

    const chartPoints = chronologicalSessions.map((s, idx) => ({
      index: idx,
      dateLabel: new Date(s.date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' }),
      val1RM: s.best1RM,
      volume: s.totalVolume,
      workoutId: s.workoutId,
    }));

    return {
      historySessions: sessions.reverse(), // Newest first for list
      max1RM: globalMax1RM,
      maxWeight: globalMaxWeight,
      maxVolume: globalMaxVolume,
      chartPoints,
    };
  };

  return (
    <div className="space-y-5">
      {/* Search & Dual Filter Bar */}
      <Card className="space-y-4 p-5 sm:p-6 shadow-sm">
        <div className="flex gap-3">
          <div className="relative flex-1">
            <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-3.5" />
            <Input
              type="text"
              placeholder="Search exercise (e.g., Bench Press, Pull-ups...)"
              aria-label="Search exercise"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-10"
            />
          </div>

          <Button icon={Plus} variant="primary" onClick={() => setIsModalOpen(true)} className="shrink-0">
            Create
          </Button>
        </div>

        {/* Muscle Filter Scroll */}
        <div className="space-y-2 pt-1 border-t border-slate-100">
          <div className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1">
            {MUSCLE_GROUPS.map((m) => (
              <button
                key={m.id}
                onClick={() => setSelectedMuscle(m.id)}
                className={`px-3.5 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition-all ${
                  selectedMuscle === m.id
                    ? 'bg-indigo-600 text-white shadow-sm'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                }`}
              >
                {m.label}
              </button>
            ))}
          </div>

          {/* Equipment Filter Scroll */}
          <div className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1">
            {EQUIPMENT_TYPES.map((eq) => (
              <button
                key={eq.id}
                onClick={() => setSelectedEquipment(eq.id)}
                className={`px-3 py-1 rounded-xl text-xs font-medium whitespace-nowrap transition-all border ${
                  selectedEquipment === eq.id
                    ? 'bg-indigo-50 text-indigo-700 border-indigo-200 font-bold shadow-xs'
                    : 'bg-white text-slate-600 border-slate-200 hover:bg-slate-50'
                }`}
              >
                {eq.label}
              </button>
            ))}
          </div>
        </div>
      </Card>

      {/* Exercises List */}
      <div className="space-y-3">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Catalog ({filteredExercises.length})
        </h3>

        {filteredExercises.length === 0 ? (
          <Card className="text-center py-10 space-y-3 shadow-sm">
            <Dumbbell className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No exercises found matching these filters.</p>
          </Card>
        ) : (
          <div className="space-y-3">
            {filteredExercises.map((exercise) => {
              const typeLabel =
                exercise.exercise_type === 'weight_reps'
                  ? 'Weight × Reps'
                  : exercise.exercise_type === 'reps_only'
                  ? 'Reps Only'
                  : exercise.exercise_type === 'distance_duration'
                  ? 'Distance & Time'
                  : 'Duration';

              const secondaryList = parseOtherMuscles(exercise);

              return (
                <Card
                  key={exercise.id || exercise.name}
                  hover={true}
                  onClick={() => {
                    if (onSelectExercise) {
                      onSelectExercise(exercise);
                    } else {
                      setSelectedExerciseForHistory(exercise);
                    }
                  }}
                  className="p-4 sm:p-5 flex items-center justify-between gap-4 shadow-sm group"
                >
                  <div className="flex items-center gap-4 min-w-0">
                    <div className="w-12 h-12 rounded-2xl bg-indigo-50 border border-indigo-100 text-indigo-600 flex items-center justify-center font-bold shrink-0 group-hover:bg-indigo-600 group-hover:text-white transition-all">
                      <Dumbbell className="w-6 h-6" />
                    </div>
                    <div className="space-y-1 min-w-0">
                      <h4 className="text-base font-bold text-slate-900 truncate">
                        {exercise.name || exercise.name_es}
                      </h4>
                      <div className="flex flex-wrap items-center gap-1.5 text-xs text-slate-500 font-medium">
                        <span className="bg-indigo-50 text-indigo-700 font-bold px-2 py-0.5 rounded-md capitalize border border-indigo-100">
                          {exercise.muscle_group}
                        </span>

                        {secondaryList.length > 0 && (
                          <div className="flex items-center gap-1">
                            <span className="text-slate-400 font-bold">+</span>
                            {secondaryList.map((sec) => (
                              <span
                                key={sec}
                                className="bg-slate-100 text-slate-600 px-1.5 py-0.5 rounded text-[11px] font-semibold capitalize border border-slate-200/60"
                              >
                                {sec}
                              </span>
                            ))}
                          </div>
                        )}

                        <span className="text-slate-300">•</span>
                        <span className="text-indigo-600 font-mono font-semibold">{typeLabel}</span>
                      </div>
                    </div>
                  </div>

                  <div className="flex items-center gap-2 shrink-0">
                    <span className="text-xs bg-slate-100 border border-slate-200 px-3 py-1.5 rounded-xl text-slate-700 font-semibold capitalize">
                      {exercise.equipment_category || exercise.equipment || 'Bodyweight'}
                    </span>
                    <button
                      type="button"
                      onClick={(e) => {
                        e.stopPropagation();
                        setSelectedExerciseForHistory(exercise);
                      }}
                      className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-indigo-50"
                      title="View Exercise History & Charts"
                    >
                      <Info className="w-4.5 h-4.5" />
                    </button>
                  </div>
                </Card>
              );
            })}
          </div>
        )}
      </div>

      {/* Exercise History & Analytics Modal */}
      {selectedExerciseForHistory && (() => {
        const exData = getExerciseHistoryData(selectedExerciseForHistory.id);
        const hasHistory = exData.historySessions.length > 0;

        // SVG Chart coordinates calculation
        const maxVal = Math.max(...exData.chartPoints.map((p) => p.val1RM), 1);
        const minVal = Math.min(...exData.chartPoints.map((p) => p.val1RM), 0);
        const range = Math.max(maxVal - minVal, 10);

        const points = exData.chartPoints.map((p, idx) => {
          const x = exData.chartPoints.length === 1 ? 150 : 20 + (idx / (exData.chartPoints.length - 1)) * 260;
          const y = 130 - ((p.val1RM - minVal) / range) * 90;
          return { x, y, ...p };
        });

        const svgPathStr = points.length > 0
          ? points.reduce((acc, pt, i) => (i === 0 ? `M ${pt.x} ${pt.y}` : `${acc} L ${pt.x} ${pt.y}`), '')
          : '';

        return (
          <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
            <Card className="max-w-lg w-full p-6 space-y-5 shadow-2xl border border-slate-200 max-h-[90vh] overflow-y-auto">
              <div className="flex items-start justify-between gap-3 border-b border-slate-100 pb-4">
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 rounded-2xl bg-indigo-600 text-white flex items-center justify-center font-bold shadow-md">
                    <Dumbbell className="w-6 h-6" />
                  </div>
                  <div>
                    <h3 className="text-lg font-bold text-slate-900">
                      {selectedExerciseForHistory.name || selectedExerciseForHistory.name_es}
                    </h3>
                    <div className="flex items-center gap-2 text-xs text-slate-500 capitalize font-medium mt-0.5">
                      <span className="font-semibold text-indigo-600">{selectedExerciseForHistory.muscle_group}</span>
                      <span>•</span>
                      <span>{selectedExerciseForHistory.equipment_category || 'Bodyweight'}</span>
                    </div>
                  </div>
                </div>

                <button
                  onClick={() => setSelectedExerciseForHistory(null)}
                  className="p-1.5 text-slate-400 hover:text-slate-700 rounded-xl hover:bg-slate-100"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>

              {/* Personal Record Badges Row */}
              <div className="grid grid-cols-3 gap-2.5">
                <div className="bg-gradient-to-br from-indigo-50 to-purple-50 border border-indigo-100 p-3 rounded-xl text-center">
                  <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-wider block">Best 1RM</span>
                  <span className="font-mono font-extrabold text-base text-indigo-900">
                    {exData.max1RM > 0 ? `${exData.max1RM} kg` : '-'}
                  </span>
                </div>

                <div className="bg-gradient-to-br from-emerald-50 to-teal-50 border border-emerald-100 p-3 rounded-xl text-center">
                  <span className="text-[10px] font-bold text-emerald-600 uppercase tracking-wider block">Max Weight</span>
                  <span className="font-mono font-extrabold text-base text-emerald-900">
                    {exData.maxWeight > 0 ? `${exData.maxWeight} kg` : '-'}
                  </span>
                </div>

                <div className="bg-gradient-to-br from-amber-50 to-orange-50 border border-amber-100 p-3 rounded-xl text-center">
                  <span className="text-[10px] font-bold text-amber-600 uppercase tracking-wider block">Sessions</span>
                  <span className="font-mono font-extrabold text-base text-amber-900">
                    {exData.historySessions.length}
                  </span>
                </div>
              </div>

              {/* SVG 1RM Progression Chart */}
              {exData.chartPoints.length > 1 ? (
                <div className="bg-slate-50 border border-slate-200/80 rounded-2xl p-4 space-y-2">
                  <div className="flex items-center justify-between text-xs font-bold text-slate-600">
                    <span className="flex items-center gap-1.5">
                      <TrendingUp className="w-4 h-4 text-indigo-600" />
                      <span>1RM Progression</span>
                    </span>
                    <span className="font-mono text-indigo-700">{exData.max1RM} kg peak</span>
                  </div>

                  <div className="h-36 w-full pt-2">
                    <svg viewBox="0 0 300 150" className="w-full h-full overflow-visible">
                      <defs>
                        <linearGradient id="chartGrad" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="0%" stopColor="#6366f1" stopOpacity="0.3" />
                          <stop offset="100%" stopColor="#6366f1" stopOpacity="0.0" />
                        </linearGradient>
                      </defs>

                      {/* Area Fill */}
                      {points.length > 0 && (
                        <path
                          d={`${svgPathStr} L ${points[points.length - 1].x} 140 L ${points[0].x} 140 Z`}
                          fill="url(#chartGrad)"
                        />
                      )}

                      {/* Line */}
                      <path
                        d={svgPathStr}
                        fill="none"
                        stroke="#6366f1"
                        strokeWidth="3"
                        strokeLinecap="round"
                      />

                      {/* Points */}
                      {points.map((pt) => (
                        <g key={pt.index} className="group cursor-pointer">
                          <circle
                            cx={pt.x}
                            cy={pt.y}
                            r="5"
                            className="fill-white stroke-indigo-600 stroke-[3] group-hover:r-7 transition-all"
                          />
                          <text
                            x={pt.x}
                            y={pt.y - 10}
                            textAnchor="middle"
                            className="text-[9px] font-mono font-bold fill-indigo-900 opacity-90"
                          >
                            {pt.val1RM}kg
                          </text>
                        </g>
                      ))}
                    </svg>
                  </div>
                </div>
              ) : null}

              {/* History Log List */}
              <div className="space-y-3 pt-2">
                <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                  Past Workout Sessions ({exData.historySessions.length})
                </h4>

                {!hasHistory ? (
                  <div className="text-center py-6 bg-slate-50 border border-slate-200/60 rounded-2xl text-xs text-slate-400">
                    No workout sessions recorded for this exercise yet.
                  </div>
                ) : (
                  <div className="space-y-3 max-h-60 overflow-y-auto pr-1">
                    {exData.historySessions.map((session, idx) => (
                      <div
                        key={idx}
                        className="bg-slate-50 border border-slate-200/80 rounded-xl p-3.5 space-y-2.5 text-xs"
                      >
                        <div className="flex items-center justify-between">
                          <div>
                            <span className="font-bold text-slate-900 block">{session.workoutName}</span>
                            <span className="text-[11px] text-slate-500 font-medium">
                              {new Date(session.date).toLocaleDateString('en-US', {
                                month: 'short',
                                day: 'numeric',
                                year: 'numeric',
                              })}
                            </span>
                          </div>

                          <div className="flex items-center gap-2">
                            <span className="font-mono font-bold text-slate-600 bg-white border border-slate-200 px-2 py-0.5 rounded-lg">
                              Vol: {session.totalVolume} kg
                            </span>

                            {onGoToWorkout && (
                              <button
                                type="button"
                                onClick={() => {
                                  setSelectedExerciseForHistory(null);
                                  onGoToWorkout(session.workoutId);
                                }}
                                className="p-1 text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-lg flex items-center gap-1 font-semibold"
                                title="Go to Workout in History"
                              >
                                <span>View</span>
                                <ExternalLink className="w-3.5 h-3.5" />
                              </button>
                            )}
                          </div>
                        </div>

                        {/* Sets Breakdown */}
                        <div className="grid grid-cols-2 sm:grid-cols-3 gap-1.5 pt-1">
                          {session.sets.map((s, sIdx) => (
                            <div
                              key={sIdx}
                              className="bg-white border border-slate-200 px-2.5 py-1 rounded-lg font-mono text-[11px] flex justify-between items-center"
                            >
                              <span className="text-slate-400 font-bold">#{sIdx + 1}</span>
                              <span className="font-bold text-slate-800">
                                {s.weight_kg ? `${s.weight_kg}kg × ` : ''}
                                {s.reps ? `${s.reps}` : ''}
                              </span>
                            </div>
                          ))}
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              <div className="flex justify-end pt-2 border-t border-slate-100">
                <Button variant="ghost" onClick={() => setSelectedExerciseForHistory(null)}>
                  Close
                </Button>
              </div>
            </Card>
          </div>
        );
      })()}

      {/* New Exercise Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <Card className="max-w-md w-full p-6 sm:p-7 space-y-5 shadow-xl border border-slate-200 max-h-[90vh] overflow-y-auto">
            <h3 className="text-lg font-bold text-slate-900">Create Custom Exercise</h3>

            <form onSubmit={handleCreateCustom} className="space-y-4">
              <Input
                label="Exercise Name"
                placeholder="e.g., Dumbbell French Press"
                value={customName}
                onChange={(e) => setCustomName(e.target.value)}
                required
              />

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <Select
                  label="Primary Muscle"
                  value={customMuscle}
                  onChange={(e) => {
                    setCustomMuscle(e.target.value);
                    setCustomSecondaryMuscles((prev) => prev.filter((m) => m !== e.target.value));
                  }}
                >
                  {MUSCLE_GROUPS.filter((m) => m.id !== 'all').map((m) => (
                    <option key={m.id} value={m.id}>
                      {m.label}
                    </option>
                  ))}
                </Select>

                <Select
                  label="Equipment"
                  value={customEquipment}
                  onChange={(e) => setCustomEquipment(e.target.value)}
                >
                  {EQUIPMENT_TYPES.filter((eq) => eq.id !== 'all').map((eq) => (
                    <option key={eq.id} value={eq.id}>
                      {eq.label}
                    </option>
                  ))}
                </Select>
              </div>

              {/* Secondary Muscle Matrix Multi-select */}
              <div className="space-y-1.5">
                <label className="block text-xs sm:text-sm font-semibold text-slate-700">
                  Secondary Muscles (Optional)
                </label>
                <div className="flex flex-wrap gap-1.5 p-2.5 bg-slate-50 border border-slate-200 rounded-xl">
                  {MUSCLE_GROUPS.filter((m) => m.id !== 'all' && m.id !== customMuscle).map((m) => {
                    const isSelected = customSecondaryMuscles.includes(m.id);
                    return (
                      <button
                        key={m.id}
                        type="button"
                        onClick={() => toggleSecondaryMuscle(m.id)}
                        className={`px-2.5 py-1 rounded-lg text-xs font-semibold transition-all border ${
                          isSelected
                            ? 'bg-indigo-600 text-white border-indigo-600 shadow-2xs'
                            : 'bg-white text-slate-600 border-slate-200 hover:bg-slate-100'
                        }`}
                      >
                        {isSelected ? `✓ ${m.label}` : m.label}
                      </button>
                    );
                  })}
                </div>
              </div>

              <Select
                label="Measurement Type"
                value={customType}
                onChange={(e) => setCustomType(e.target.value)}
              >
                <option value="weight_reps">Weight & Repetitions</option>
                <option value="reps_only">Repetitions Only</option>
                <option value="distance_duration">Distance & Time</option>
                <option value="duration_only">Time Only</option>
              </Select>

              <div className="flex justify-end gap-3 pt-2">
                <Button variant="ghost" onClick={() => setIsModalOpen(false)}>
                  Cancel
                </Button>
                <Button type="submit" variant="primary">
                  Save Exercise
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}
    </div>
  );
}
