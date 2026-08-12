import React, { useState } from 'react';
import { Search, Plus, Dumbbell, Filter, Info, Trophy, TrendingUp, Calendar, Flame, ChevronRight, X, ExternalLink, Edit3 } from 'lucide-react';
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
  onEditExercise,
  onSelectExercise,
  onGoToWorkout,
}) {
  const [search, setSearch] = useState('');
  const [selectedMuscle, setSelectedMuscle] = useState('all');
  const [selectedEquipment, setSelectedEquipment] = useState('all');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedExerciseForHistory, setSelectedExerciseForHistory] = useState(null);

  // Edit Exercise Modal State
  const [editingExerciseModal, setEditingExerciseModal] = useState(null);
  const [editName, setEditName] = useState('');
  const [editMuscle, setEditMuscle] = useState('chest');
  const [editSecondaryMuscles, setEditSecondaryMuscles] = useState([]);
  const [editType, setEditType] = useState('weight_reps');
  const [editEquip, setEditEquip] = useState('dumbbell');

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

  const handleOpenEditModal = (ex) => {
    setEditingExerciseModal(ex);
    setEditName(ex.name || ex.name_es || '');
    setEditMuscle(ex.muscle_group || 'chest');
    setEditSecondaryMuscles(parseOtherMuscles(ex));
    setEditType(ex.exercise_type || 'weight_reps');
    setEditEquip(ex.equipment_category || ex.equipment || 'dumbbell');
  };

  const handleSaveEditedExercise = (e) => {
    e.preventDefault();
    if (!editName.trim() || !editingExerciseModal) return;

    if (onEditExercise) {
      onEditExercise({
        ...editingExerciseModal,
        name: editName.trim(),
        name_es: editName.trim(),
        muscle_group: editMuscle,
        other_muscles: editSecondaryMuscles,
        exercise_type: editType,
        equipment_category: editEquip,
      });
    }

    setEditingExerciseModal(null);
  };

  const handleCreateCustom = (e) => {
    e.preventDefault();
    if (!customName.trim()) return;

    onAddCustomExercise({
      name: customName.trim(),
      name_es: customName.trim(),
      muscle_group: customMuscle,
      other_muscles: customSecondaryMuscles,
      exercise_type: customType,
      equipment_category: customEquipment,
      is_custom: true,
    });

    setCustomName('');
    setCustomSecondaryMuscles([]);
    setIsModalOpen(false);
  };

  // Exercise History helper calculation
  const getExerciseHistoryData = (exId) => {
    const targetEx = exercises.find((e) => e.id === exId);
    if (!targetEx) return { historySessions: [], maxWeight: 0, peak1RM: 0, chartPoints: [] };

    const historySessions = [];
    const chartPoints = [];

    // Reverse workouts chronological order for chart
    const chronWorkouts = [...workouts].sort(
      (a, b) => new Date(a.started_at) - new Date(b.started_at)
    );

    chronWorkouts.forEach((w) => {
      const sets = w.workout_sets || [];
      const exSets = sets.filter(
        (s) =>
          s.exercise_id === exId ||
          s.exercise?.id === exId ||
          s.exercise?.name?.toLowerCase() === targetEx.name?.toLowerCase()
      );

      if (exSets.length > 0) {
        let sessionMaxWeight = 0;
        let sessionPeak1RM = 0;

        exSets.forEach((s) => {
          const wKg = parseFloat(s.weight_kg) || 0;
          const reps = parseInt(s.reps, 10) || 0;
          if (wKg > sessionMaxWeight) sessionMaxWeight = wKg;

          const est = calculate1RM(wKg, reps);
          if (est > sessionPeak1RM) sessionPeak1RM = est;
        });

        historySessions.push({
          workoutId: w.id,
          workoutName: w.name,
          date: new Date(w.started_at).toLocaleDateString('en-US', {
            month: 'short',
            day: 'numeric',
            year: 'numeric',
          }),
          setsCount: exSets.length,
          maxWeight: sessionMaxWeight,
          peak1RM: sessionPeak1RM,
          sets: exSets,
        });

        if (sessionPeak1RM > 0) {
          chartPoints.push({
            date: new Date(w.started_at).toLocaleDateString('en-US', {
              month: 'short',
              day: 'numeric',
            }),
            val1RM: sessionPeak1RM,
          });
        }
      }
    });

    const overallMaxWeight = Math.max(...historySessions.map((s) => s.maxWeight), 0);
    const overallPeak1RM = Math.max(...historySessions.map((s) => s.peak1RM), 0);

    return {
      historySessions: historySessions.reverse(),
      maxWeight: overallMaxWeight,
      peak1RM: overallPeak1RM,
      chartPoints,
    };
  };

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Header Controls */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-4">
        <div className="space-y-1">
          <h3 className="text-lg font-bold text-slate-900">Exercise Catalog</h3>
          <p className="text-xs sm:text-sm text-slate-500 font-medium">
            Browse {exercises.length} exercises or create your own custom exercise.
          </p>
        </div>

        <Button icon={Plus} variant="primary" onClick={() => setIsModalOpen(true)}>
          New Exercise
        </Button>
      </div>

      {/* Filters & Search Bar */}
      <Card className="p-4 space-y-4 shadow-2xs">
        <div className="relative">
          <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-1/2 -translate-y-1/2" />
          <input
            type="text"
            placeholder="Search exercises by name..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-xs sm:text-sm font-medium focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500"
          />
        </div>

        {/* Primary Muscle Group Filter */}
        <div className="space-y-2">
          <label className="block text-[11px] font-bold text-slate-400 uppercase tracking-wider">
            Muscle Group
          </label>
          <div className="flex items-center gap-1.5 overflow-x-auto pb-1 scrollbar-none">
            {MUSCLE_GROUPS.map((m) => (
              <button
                key={m.id}
                onClick={() => setSelectedMuscle(m.id)}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-all shrink-0 ${
                  selectedMuscle === m.id
                    ? 'bg-indigo-600 text-white shadow-2xs'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200/70'
                }`}
              >
                {m.label}
              </button>
            ))}
          </div>
        </div>

        {/* Equipment Filter */}
        <div className="space-y-2 pt-1 border-t border-slate-100">
          <label className="block text-[11px] font-bold text-slate-400 uppercase tracking-wider">
            Equipment
          </label>
          <div className="flex items-center gap-1.5 overflow-x-auto pb-1 scrollbar-none">
            {EQUIPMENT_TYPES.map((e) => (
              <button
                key={e.id}
                onClick={() => setSelectedEquipment(e.id)}
                className={`px-3 py-1.5 rounded-xl text-xs font-semibold transition-all shrink-0 ${
                  selectedEquipment === e.id
                    ? 'bg-slate-900 text-white shadow-2xs'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200/70'
                }`}
              >
                {e.label}
              </button>
            ))}
          </div>
        </div>
      </Card>

      {/* Exercise List */}
      <div className="space-y-3">
        <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Exercises ({filteredExercises.length})
        </h4>

        {filteredExercises.length === 0 ? (
          <Card className="text-center py-12 space-y-3">
            <Dumbbell className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No exercises found matching your filters.</p>
          </Card>
        ) : (
          <div className="grid grid-cols-1 gap-3">
            {filteredExercises.map((exercise) => {
              const secondaryList = parseOtherMuscles(exercise);

              let typeLabel = 'Weight & Reps';
              if (exercise.exercise_type === 'reps_only') typeLabel = 'Reps Only';
              if (exercise.exercise_type === 'duration_only') typeLabel = 'Duration';
              if (exercise.exercise_type === 'distance_duration') typeLabel = 'Distance & Time';

              return (
                <Card
                  key={exercise.id}
                  className="p-4 sm:p-5 flex items-center justify-between gap-4 hover:border-indigo-200 transition-all cursor-pointer group shadow-2xs"
                  onClick={() => onSelectExercise && onSelectExercise(exercise)}
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

                  <div className="flex items-center gap-1.5 shrink-0">
                    <span className="text-xs bg-slate-100 border border-slate-200 px-3 py-1.5 rounded-xl text-slate-700 font-semibold capitalize">
                      {exercise.equipment_category || exercise.equipment || 'Bodyweight'}
                    </span>
                    
                    {/* Edit Exercise Button */}
                    <button
                      type="button"
                      onClick={(e) => {
                        e.stopPropagation();
                        handleOpenEditModal(exercise);
                      }}
                      className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-indigo-50 transition-colors"
                      title="Edit Exercise Details"
                    >
                      <Edit3 className="w-4 h-4" />
                    </button>

                    {/* Exercise History & Analytics Info Button */}
                    <button
                      type="button"
                      onClick={(e) => {
                        e.stopPropagation();
                        setSelectedExerciseForHistory(exercise);
                      }}
                      className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-indigo-50 transition-colors"
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

      {/* Edit Exercise Modal */}
      {editingExerciseModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <Card className="max-w-md w-full p-6 space-y-5 shadow-2xl border border-slate-200">
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Edit3 className="w-5 h-5 text-indigo-600" />
                <span>Edit Exercise Details</span>
              </h3>
              <button
                onClick={() => setEditingExerciseModal(null)}
                className="p-1 text-slate-400 hover:text-slate-700 rounded-lg"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveEditedExercise} className="space-y-4">
              <Input
                label="Exercise Name"
                value={editName}
                onChange={(e) => setEditName(e.target.value)}
                required
              />

              <Select
                label="Primary Muscle Group"
                value={editMuscle}
                onChange={(e) => setEditMuscle(e.target.value)}
              >
                {MUSCLE_GROUPS.filter((m) => m.id !== 'all').map((m) => (
                  <option key={m.id} value={m.id}>
                    {m.label}
                  </option>
                ))}
              </Select>

              {/* Secondary Muscles Multi-Select */}
              <div className="space-y-1.5">
                <label className="block text-xs sm:text-sm font-semibold text-slate-700">
                  Secondary Muscles (Optional)
                </label>
                <div className="flex flex-wrap gap-1.5 p-2 bg-slate-50 border border-slate-200 rounded-xl">
                  {MUSCLE_GROUPS.filter((m) => m.id !== 'all' && m.id !== editMuscle).map((m) => {
                    const isSelected = editSecondaryMuscles.includes(m.id);
                    return (
                      <button
                        key={m.id}
                        type="button"
                        onClick={() => {
                          if (isSelected) {
                            setEditSecondaryMuscles((prev) => prev.filter((id) => id !== m.id));
                          } else {
                            setEditSecondaryMuscles((prev) => [...prev, m.id]);
                          }
                        }}
                        className={`px-2.5 py-1 text-xs font-semibold rounded-lg transition-all ${
                          isSelected
                            ? 'bg-indigo-600 text-white shadow-2xs'
                            : 'bg-white text-slate-600 border border-slate-200 hover:bg-slate-100'
                        }`}
                      >
                        {isSelected ? `✓ ${m.label}` : `+ ${m.label}`}
                      </button>
                    );
                  })}
                </div>
              </div>

              <Select
                label="Exercise Type"
                value={editType}
                onChange={(e) => setEditType(e.target.value)}
              >
                <option value="weight_reps">Weight & Reps</option>
                <option value="reps_only">Reps Only</option>
                <option value="duration_only">Duration Only</option>
                <option value="distance_duration">Distance & Duration (Cardio / Cycling)</option>
              </Select>

              <Select
                label="Equipment Category"
                value={editEquip}
                onChange={(e) => setEditEquip(e.target.value)}
              >
                {EQUIPMENT_TYPES.filter((e) => e.id !== 'all').map((e) => (
                  <option key={e.id} value={e.id}>
                    {e.label}
                  </option>
                ))}
              </Select>

              <div className="flex justify-end gap-3 pt-3 border-t border-slate-100">
                <Button variant="ghost" onClick={() => setEditingExerciseModal(null)}>
                  Cancel
                </Button>
                <Button type="submit" variant="primary">
                  Save Changes
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}

      {/* Exercise History & Analytics Modal */}
      {selectedExerciseForHistory && (() => {
        const exData = getExerciseHistoryData(selectedExerciseForHistory.id);
        const hasHistory = exData.historySessions.length > 0;

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
                <div>
                  <div className="flex items-center gap-2">
                    <h3 className="text-lg font-bold text-slate-900">
                      {selectedExerciseForHistory.name || selectedExerciseForHistory.name_es}
                    </h3>
                    <span className="text-xs bg-indigo-50 text-indigo-700 font-bold px-2.5 py-0.5 rounded-md capitalize border border-indigo-100">
                      {selectedExerciseForHistory.muscle_group}
                    </span>
                  </div>
                  <p className="text-xs text-slate-500 font-medium mt-1">
                    Exercise performance analytics & session log
                  </p>
                </div>

                <button
                  onClick={() => setSelectedExerciseForHistory(null)}
                  className="p-1 text-slate-400 hover:text-slate-700 rounded-lg"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>

              {/* Stats Overview Grid */}
              <div className="grid grid-cols-3 gap-3">
                <div className="bg-indigo-50/60 border border-indigo-100 rounded-xl p-3 text-center">
                  <span className="text-[10px] font-bold text-indigo-600 uppercase tracking-wider block">Peak 1RM</span>
                  <span className="text-base font-extrabold text-indigo-900 font-mono">
                    {exData.peak1RM > 0 ? `${exData.peak1RM} kg` : '-'}
                  </span>
                </div>
                <div className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 text-center">
                  <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">Max Weight</span>
                  <span className="text-base font-extrabold text-slate-800 font-mono">
                    {exData.maxWeight > 0 ? `${exData.maxWeight} kg` : '-'}
                  </span>
                </div>
                <div className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 text-center">
                  <span className="text-[10px] font-bold text-slate-500 uppercase tracking-wider block">Sessions</span>
                  <span className="text-base font-extrabold text-slate-800 font-mono">
                    {exData.historySessions.length}
                  </span>
                </div>
              </div>

              {/* SVG Progression Chart */}
              {hasHistory && exData.chartPoints.length > 0 && (
                <div className="bg-slate-900 text-white rounded-2xl p-4 space-y-2 shadow-inner">
                  <div className="flex items-center justify-between text-xs">
                    <span className="font-bold flex items-center gap-1.5 text-indigo-400">
                      <TrendingUp className="w-4 h-4" />
                      <span>1RM Progression</span>
                    </span>
                    <span className="text-slate-400 text-[11px]">
                      {exData.chartPoints[0].date} — {exData.chartPoints[exData.chartPoints.length - 1].date}
                    </span>
                  </div>

                  <div className="h-36 w-full pt-2">
                    <svg className="w-full h-full overflow-visible" viewBox="0 0 300 150">
                      {/* Grid Lines */}
                      <line x1="20" y1="30" x2="280" y2="30" stroke="#334155" strokeDasharray="3 3" strokeWidth="1" />
                      <line x1="20" y1="75" x2="280" y2="75" stroke="#334155" strokeDasharray="3 3" strokeWidth="1" />
                      <line x1="20" y1="120" x2="280" y2="120" stroke="#334155" strokeDasharray="3 3" strokeWidth="1" />

                      {/* SVG Line */}
                      {svgPathStr && (
                        <path
                          d={svgPathStr}
                          fill="none"
                          stroke="#6366f1"
                          strokeWidth="3"
                          strokeLinecap="round"
                          strokeLinejoin="round"
                        />
                      )}

                      {/* SVG Data Points */}
                      {points.map((pt, idx) => (
                        <g key={idx}>
                          <circle cx={pt.x} cy={pt.y} r="5" fill="#818cf8" stroke="#ffffff" strokeWidth="2" />
                          <text
                            x={pt.x}
                            y={pt.y - 9}
                            textAnchor="middle"
                            fill="#cbd5e1"
                            fontSize="10"
                            fontWeight="bold"
                            fontFamily="monospace"
                          >
                            {pt.val1RM}kg
                          </text>
                        </g>
                      ))}
                    </svg>
                  </div>
                </div>
              )}

              {/* History Log */}
              <div className="space-y-3 pt-2">
                <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                  Past Workout Sessions ({exData.historySessions.length})
                </h4>

                {!hasHistory ? (
                  <p className="text-xs text-slate-400 py-3 text-center font-medium">
                    No workout sessions logged for this exercise yet.
                  </p>
                ) : (
                  <div className="space-y-2.5">
                    {exData.historySessions.map((session, sIdx) => (
                      <div
                        key={sIdx}
                        className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 flex items-center justify-between text-xs"
                      >
                        <div className="space-y-1">
                          <div className="flex items-center gap-2">
                            <span className="font-bold text-slate-900">{session.workoutName}</span>
                            <span className="text-[11px] text-slate-500">{session.date}</span>
                          </div>
                          <div className="text-[11px] text-slate-500 font-mono">
                            {session.setsCount} sets • Max: <span className="font-bold text-slate-700">{session.maxWeight}kg</span> • Peak 1RM: <span className="font-bold text-indigo-600">{session.peak1RM}kg</span>
                          </div>
                        </div>

                        {onGoToWorkout && (
                          <button
                            type="button"
                            onClick={() => {
                              setSelectedExerciseForHistory(null);
                              onGoToWorkout(session.workoutId);
                            }}
                            className="flex items-center gap-1 text-xs font-bold text-indigo-600 hover:text-indigo-800 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1.5 rounded-lg transition-colors"
                            title="Go to Workout in History"
                          >
                            <span>View</span>
                            <ExternalLink className="w-3.5 h-3.5" />
                          </button>
                        )}
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </Card>
          </div>
        );
      })()}

      {/* Create Custom Exercise Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <Card className="max-w-md w-full p-6 space-y-5 shadow-2xl border border-slate-200">
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <h3 className="text-base font-bold text-slate-900">Create Custom Exercise</h3>
              <button
                onClick={() => setIsModalOpen(false)}
                className="p-1 text-slate-400 hover:text-slate-700 rounded-lg"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleCreateCustom} className="space-y-4">
              <Input
                label="Exercise Name"
                placeholder="e.g., Incline Dumbbell Fly..."
                value={customName}
                onChange={(e) => setCustomName(e.target.value)}
                required
              />

              <Select
                label="Primary Muscle Group"
                value={customMuscle}
                onChange={(e) => setCustomMuscle(e.target.value)}
              >
                {MUSCLE_GROUPS.filter((m) => m.id !== 'all').map((m) => (
                  <option key={m.id} value={m.id}>
                    {m.label}
                  </option>
                ))}
              </Select>

              {/* Secondary Muscles Multi-Select */}
              <div className="space-y-1.5">
                <label className="block text-xs sm:text-sm font-semibold text-slate-700">
                  Secondary Muscles (Optional)
                </label>
                <div className="flex flex-wrap gap-1.5 p-2 bg-slate-50 border border-slate-200 rounded-xl">
                  {MUSCLE_GROUPS.filter((m) => m.id !== 'all' && m.id !== customMuscle).map((m) => {
                    const isSelected = customSecondaryMuscles.includes(m.id);
                    return (
                      <button
                        key={m.id}
                        type="button"
                        onClick={() => {
                          if (isSelected) {
                            setCustomSecondaryMuscles((prev) => prev.filter((id) => id !== m.id));
                          } else {
                            setCustomSecondaryMuscles((prev) => [...prev, m.id]);
                          }
                        }}
                        className={`px-2.5 py-1 text-xs font-semibold rounded-lg transition-all ${
                          isSelected
                            ? 'bg-indigo-600 text-white shadow-2xs'
                            : 'bg-white text-slate-600 border border-slate-200 hover:bg-slate-100'
                        }`}
                      >
                        {isSelected ? `✓ ${m.label}` : `+ ${m.label}`}
                      </button>
                    );
                  })}
                </div>
              </div>

              <Select
                label="Exercise Type"
                value={customType}
                onChange={(e) => setCustomType(e.target.value)}
              >
                <option value="weight_reps">Weight & Reps</option>
                <option value="reps_only">Reps Only</option>
                <option value="duration_only">Duration Only</option>
                <option value="distance_duration">Distance & Duration (Cardio / Cycling)</option>
              </Select>

              <Select
                label="Equipment Category"
                value={customEquipment}
                onChange={(e) => setCustomEquipment(e.target.value)}
              >
                {EQUIPMENT_TYPES.filter((e) => e.id !== 'all').map((e) => (
                  <option key={e.id} value={e.id}>
                    {e.label}
                  </option>
                ))}
              </Select>

              <div className="flex justify-end gap-3 pt-3 border-t border-slate-100">
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
