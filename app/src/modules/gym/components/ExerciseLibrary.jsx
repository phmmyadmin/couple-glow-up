import React, { useState, useEffect } from 'react';
import { Search, Plus, Dumbbell, Filter, Info, Trophy, TrendingUp, Calendar, Flame, ChevronRight, X, ExternalLink, Edit3 } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';
import { calculate1RM, doesSetMatchExercise } from '../lib/supabase-gym';
import { getExerciseMedia } from '../lib/exercise-media';
import ExerciseHistoryModal from './ExerciseHistoryModal';

const MUSCLE_GROUPS = [
  { id: 'all', label: 'All Muscles' },
  { id: 'chest', label: 'Chest' },
  { id: 'shoulders', label: 'Shoulders' },
  { id: 'biceps', label: 'Biceps' },
  { id: 'triceps', label: 'Triceps' },
  { id: 'forearms', label: 'Forearms' },
  { id: 'quadriceps', label: 'Quads' },
  { id: 'hamstrings', label: 'Hamstrings' },
  { id: 'glutes', label: 'Glutes' },
  { id: 'calves', label: 'Calves' },
  { id: 'lats', label: 'Lats' },
  { id: 'upper_back', label: 'Upper Back' },
  { id: 'lower_back', label: 'Lower Back' },
  { id: 'abdominals', label: 'Core / Abs' },
  { id: 'cardio', label: 'Cardio' },
  { id: 'other', label: 'Other' },
];

export function getMuscleGroupLabel(id) {
  if (!id) return '';
  const map = {
    chest: 'Chest',
    shoulders: 'Shoulders',
    biceps: 'Biceps',
    triceps: 'Triceps',
    forearms: 'Forearms',
    quadriceps: 'Quads',
    hamstrings: 'Hamstrings',
    glutes: 'Glutes',
    calves: 'Calves',
    lats: 'Lats',
    upper_back: 'Upper Back',
    lower_back: 'Lower Back',
    abdominals: 'Core / Abs',
    legs: 'Legs',
    back: 'Back',
    cardio: 'Cardio',
    other: 'Other',
  };
  if (map[id]) return map[id];
  return id
    .replace(/_/g, ' ')
    .replace(/\b\w/g, (l) => l.toUpperCase());
}

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

function formatChartVal(val, isVolume, exType) {
  if (isVolume) {
    if (exType === 'distance_duration') return `${val.toFixed(1)}km`;
    if (val >= 1000) return `${(val / 1000).toFixed(1)}k kg`;
    return `${Math.round(val)}kg`;
  }
  if (exType === 'distance_duration') return `${val.toFixed(1)}km/h`;
  if (exType === 'duration_only') return `${val}s`;
  return `${val}kg`;
}

export default function ExerciseLibrary({
  exercises,
  workouts = [],
  personalRecords = [],
  onAddCustomExercise,
  onEditExercise,
  onSelectExercise,
  onGoToWorkout,
  initialSelectedHistoryExercise = null,
  onCloseHistoryModal = null,
}) {
  const [search, setSearch] = useState('');
  const [selectedMuscle, setSelectedMuscle] = useState('all');
  const [selectedEquipment, setSelectedEquipment] = useState('all');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedExerciseForHistory, setSelectedExerciseForHistory] = useState(
    initialSelectedHistoryExercise || null
  );
  const [chartMetric, setChartMetric] = useState('max');

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
      secondaries.includes(selectedMuscle) ||
      (selectedMuscle === 'quadriceps' && e.muscle_group === 'legs') ||
      (selectedMuscle === 'hamstrings' && e.muscle_group === 'legs') ||
      (selectedMuscle === 'glutes' && e.muscle_group === 'legs') ||
      (selectedMuscle === 'calves' && e.muscle_group === 'legs') ||
      (selectedMuscle === 'lats' && e.muscle_group === 'back') ||
      (selectedMuscle === 'upper_back' && e.muscle_group === 'back') ||
      (selectedMuscle === 'lower_back' && e.muscle_group === 'back');

    const eqLower = (e.equipment_category || e.equipment || '').toLowerCase();
    const matchesEquipment =
      selectedEquipment === 'all' ||
      eqLower === selectedEquipment ||
      (selectedEquipment === 'other' &&
        !['barbell', 'dumbbell', 'machine', 'cable', 'bodyweight', 'kettlebell', 'smith_machine'].includes(eqLower));

    return matchesSearch && matchesMuscle && matchesEquipment;
  });

  // Handle Escape key to close modals
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') {
        if (selectedExerciseForHistory) {
          setSelectedExerciseForHistory(null);
        } else if (editingExerciseModal) {
          setEditingExerciseModal(null);
        } else if (isModalOpen) {
          setIsModalOpen(false);
        }
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [selectedExerciseForHistory, editingExerciseModal, isModalOpen]);

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

    const exType = targetEx.exercise_type || 'weight_reps';
    const isDist = exType === 'distance_duration';
    const isDur = exType === 'duration_only';
    const isReps = exType === 'reps_only' || exType === 'bodyweight_reps';

    const historySessions = [];
    const chartPoints = [];

    // Sort workouts newest to oldest so latest session is first
    const sortedWorkouts = [...workouts].sort(
      (a, b) => new Date(b.started_at) - new Date(a.started_at)
    );

    sortedWorkouts.forEach((w) => {
      const sets = w.workout_sets || [];
      const exSets = sets.filter((s) => doesSetMatchExercise(s, targetEx, exercises));

      if (exSets.length > 0) {
        let sessionMaxWeight = 0;
        let sessionPeak1RM = 0;
        let sessionMaxDist = 0;
        let sessionPeakSpeed = 0;
        let sessionMaxDuration = 0;
        let sessionMaxReps = 0;
        let sessionTotalVolumeKg = 0;
        let sessionTotalDistKm = 0;

        exSets.forEach((s) => {
          const wKg = parseFloat(s.weight_kg) || 0;
          const reps = parseInt(s.reps, 10) || 0;
          const distM = parseFloat(s.distance_meters) || (parseFloat(s.distance_km) * 1000) || 0;
          const durS = parseInt(s.duration_seconds, 10) || 0;

          sessionTotalVolumeKg += wKg * reps;

          if (wKg > sessionMaxWeight) sessionMaxWeight = wKg;
          if (reps > sessionMaxReps) sessionMaxReps = reps;
          if (durS > sessionMaxDuration) sessionMaxDuration = durS;

          const distKm = distM / 1000;
          sessionTotalDistKm += distKm;
          if (distKm > sessionMaxDist) sessionMaxDist = distKm;

          if (distKm > 0 && durS > 0) {
            const speed = distKm / (durS / 3600);
            if (speed > sessionPeakSpeed) sessionPeakSpeed = speed;
          }

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
          maxDist: sessionMaxDist,
          peakSpeed: sessionPeakSpeed,
          maxDuration: sessionMaxDuration,
          maxReps: sessionMaxReps,
          totalVolumeKg: sessionTotalVolumeKg,
          totalDistKm: sessionTotalDistKm,
          sets: exSets,
        });

        const valForChart = isDist ? sessionPeakSpeed : isDur ? sessionMaxDuration : isReps ? sessionMaxReps : sessionPeak1RM;
        const volumeForChart = isDist ? sessionTotalDistKm : isDur ? sessionMaxDuration : isReps ? sessionMaxReps : sessionTotalVolumeKg;

        chartPoints.push({
          date: new Date(w.started_at).toLocaleDateString('en-US', {
            month: 'short',
            day: 'numeric',
          }),
          val1RM: parseFloat(valForChart.toFixed(1)),
          valVolume: parseFloat(volumeForChart.toFixed(1)),
        });
      }
    });

    const overallMaxWeight = Math.max(...historySessions.map((s) => s.maxWeight), 0);
    const overallPeak1RM = Math.max(...historySessions.map((s) => s.peak1RM), 0);
    const overallMaxDist = Math.max(...historySessions.map((s) => s.maxDist), 0);
    const overallPeakSpeed = Math.max(...historySessions.map((s) => s.peakSpeed), 0);
    const overallMaxDuration = Math.max(...historySessions.map((s) => s.maxDuration), 0);
    const overallMaxReps = Math.max(...historySessions.map((s) => s.maxReps), 0);

    return {
      historySessions,
      maxWeight: overallMaxWeight,
      peak1RM: overallPeak1RM,
      maxDistanceKm: overallMaxDist,
      peakSpeedKmh: overallPeakSpeed,
      maxDurationSec: overallMaxDuration,
      maxReps: overallMaxReps,
      exType,
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

              const media = getExerciseMedia(exercise.name || exercise.name_es);

              return (
                <Card
                  key={exercise.id}
                  className="p-4 sm:p-5 space-y-3 hover:border-indigo-200 transition-all cursor-pointer group shadow-2xs"
                  onClick={() => onSelectExercise && onSelectExercise(exercise)}
                >
                  {/* Top Row: Exercise Thumbnail/Icon + Full Width Name + Action Buttons */}
                  <div className="flex items-start justify-between gap-3">
                    <div className="flex items-start gap-3 min-w-0 flex-1">
                      <div className="w-11 h-11 rounded-xl bg-indigo-50/80 border border-indigo-100/90 flex items-center justify-center overflow-hidden shrink-0 mt-0.5 shadow-2xs group-hover:border-indigo-300 transition-all">
                        {media?.imgUrl ? (
                          <img
                            src={media.imgUrl}
                            alt={exercise.name}
                            className="w-full h-full object-cover"
                            loading="lazy"
                            onError={(e) => {
                              e.target.style.display = 'none';
                            }}
                          />
                        ) : (
                          <Dumbbell className="w-5 h-5 text-indigo-600" />
                        )}
                      </div>
                      <div className="space-y-0.5 flex-1 min-w-0">
                        <h4 className="text-base sm:text-lg font-bold text-slate-900 leading-snug break-words">
                          {exercise.name || exercise.name_es}
                        </h4>
                      </div>
                    </div>

                    {/* Action Buttons */}
                    <div className="flex items-center gap-1 shrink-0">
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
                  </div>

                  {/* Bottom Row: Metadata & Muscle Group Badges */}
                  <div className="flex flex-wrap items-center gap-1.5 pt-2 border-t border-slate-100 text-xs text-slate-500 font-medium">
                    <span className="bg-indigo-50 text-indigo-700 font-bold px-2.5 py-1 rounded-lg border border-indigo-100/80">
                      {getMuscleGroupLabel(exercise.muscle_group)}
                    </span>

                    {secondaryList.length > 0 && (
                      <div className="flex items-center gap-1 flex-wrap">
                        <span className="text-slate-400 font-bold text-[11px]">+</span>
                        {secondaryList.map((sec) => (
                          <span
                            key={sec}
                            className="bg-slate-100 text-slate-600 px-2 py-0.5 rounded-lg text-[11px] font-semibold border border-slate-200/60"
                          >
                            {getMuscleGroupLabel(sec)}
                          </span>
                        ))}
                      </div>
                    )}

                    <span className="bg-slate-100 text-slate-700 px-2.5 py-1 rounded-lg text-xs font-semibold border border-slate-200/80 capitalize">
                      {exercise.equipment_category || exercise.equipment || 'Bodyweight'}
                    </span>

                    <span className="text-indigo-600 font-mono font-semibold text-xs ml-auto">
                      {typeLabel}
                    </span>
                  </div>
                </Card>
              );
            })}
          </div>
        )}
      </div>

      {/* Edit Exercise Modal */}
      {editingExerciseModal && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4"
          onClick={() => setEditingExerciseModal(null)}
        >
          <Card className="max-w-md w-full p-6 space-y-5 shadow-2xl border border-slate-200" onClick={(e) => e.stopPropagation()}>
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
      {selectedExerciseForHistory && (
        <ExerciseHistoryModal
          exercise={selectedExerciseForHistory}
          workouts={workouts}
          exercises={exercises}
          onGoToWorkout={onGoToWorkout}
          onClose={() => {
            setSelectedExerciseForHistory(null);
            if (onCloseHistoryModal) onCloseHistoryModal();
          }}
        />
      )}

      {/* Create Custom Exercise Modal */}
      {isModalOpen && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setIsModalOpen(false)}
        >
          <Card className="max-w-md w-full p-6 space-y-5 shadow-2xl border border-slate-200 cursor-default" onClick={(e) => e.stopPropagation()}>
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
