import React, { useState } from 'react';
import { Plus, Trash2, Dumbbell, Play, Edit3, ArrowUp, ArrowDown, Timer, ChevronRight } from 'lucide-react';
import ExerciseLibrary from './ExerciseLibrary';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';

const ROUTINE_COLORS = [
  '#6366f1', // Indigo
  '#ec4899', // Pink
  '#10b981', // Emerald
  '#f59e0b', // Amber
  '#3b82f6', // Blue
  '#8b5cf6', // Purple
];

const SET_INDICATORS = [
  { key: 'normal', label: 'N', bg: 'bg-slate-100 text-slate-700', activeBg: 'bg-slate-900 text-white' },
  { key: 'warmup', label: 'W', bg: 'bg-amber-50 text-amber-700', activeBg: 'bg-amber-500 text-white' },
  { key: 'dropset', label: 'D', bg: 'bg-purple-50 text-purple-700', activeBg: 'bg-purple-600 text-white font-bold' },
  { key: 'failure', label: 'F', bg: 'bg-rose-50 text-rose-700', activeBg: 'bg-rose-600 text-white font-bold' },
];

export default function RoutineBuilder({
  routines,
  exercises,
  onSaveRoutine,
  onDeleteRoutine,
  onStartRoutine,
  onAddCustomExercise,
}) {
  const [isEditing, setIsEditing] = useState(false);
  const [editingRoutine, setEditingRoutine] = useState(null);
  const [routineName, setRoutineName] = useState('');
  const [routineDesc, setRoutineDesc] = useState('');
  const [routineColor, setRoutineColor] = useState('#6366f1');
  const [selectedExercises, setSelectedExercises] = useState([]);
  const [isSelectingExercise, setIsSelectingExercise] = useState(false);

  const handleOpenNew = () => {
    setEditingRoutine(null);
    setRoutineName('New Routine');
    setRoutineDesc('');
    setRoutineColor('#6366f1');
    setSelectedExercises([]);
    setIsEditing(true);
  };

  const handleOpenEdit = (routine) => {
    setEditingRoutine(routine);
    setRoutineName(routine.name);
    setRoutineDesc(routine.description || '');
    setRoutineColor(routine.color || '#6366f1');

    // Normalize exercises and ensure each exercise has a sets array
    const normalized = (routine.exercises || []).map((item) => {
      let sets = item.sets;
      if (!Array.isArray(sets) || sets.length === 0) {
        const count = parseInt(item.target_sets, 10) || 3;
        sets = Array.from({ length: count }).map(() => ({
          indicator: 'normal',
          weight_kg: item.target_weight !== undefined ? item.target_weight : '',
          reps: item.target_reps !== undefined ? item.target_reps : 10,
        }));
      }
      return {
        ...item,
        sets: sets,
        rest_seconds: item.rest_seconds || 90,
      };
    });

    setSelectedExercises(normalized);
    setIsEditing(true);
  };

  const handleAddExerciseToRoutine = (exercise) => {
    const newItem = {
      exercise_id: exercise.id,
      exercise: exercise,
      rest_seconds: 90,
      sets: [
        { indicator: 'normal', weight_kg: '', reps: 10 },
        { indicator: 'normal', weight_kg: '', reps: 10 },
        { indicator: 'normal', weight_kg: '', reps: 10 },
      ],
    };
    setSelectedExercises((prev) => [...prev, newItem]);
    setIsSelectingExercise(false);
  };

  const handleMoveExercise = (index, direction) => {
    const newIdx = index + direction;
    if (newIdx < 0 || newIdx >= selectedExercises.length) return;
    const updated = [...selectedExercises];
    const temp = updated[index];
    updated[index] = updated[newIdx];
    updated[newIdx] = temp;
    setSelectedExercises(updated);
  };

  const handleRemoveExercise = (idx) => {
    setSelectedExercises((prev) => prev.filter((_, i) => i !== idx));
  };

  const handleUpdateItemRest = (exIdx, restSec) => {
    setSelectedExercises((prev) =>
      prev.map((item, i) => (i === exIdx ? { ...item, rest_seconds: restSec } : item))
    );
  };

  // Set-level handlers
  const handleAddSetToExercise = (exIdx) => {
    setSelectedExercises((prev) =>
      prev.map((item, i) => {
        if (i !== exIdx) return item;
        const lastSet = item.sets[item.sets.length - 1];
        const newSet = {
          indicator: lastSet?.indicator || 'normal',
          weight_kg: lastSet?.weight_kg !== undefined ? lastSet.weight_kg : '',
          reps: lastSet?.reps !== undefined ? lastSet.reps : 10,
        };
        return { ...item, sets: [...(item.sets || []), newSet] };
      })
    );
  };

  const handleRemoveSetFromExercise = (exIdx, setIdx) => {
    setSelectedExercises((prev) =>
      prev.map((item, i) => {
        if (i !== exIdx) return item;
        const updatedSets = item.sets.filter((_, sI) => sI !== setIdx);
        return { ...item, sets: updatedSets };
      })
    );
  };

  const handleUpdateSetField = (exIdx, setIdx, field, val) => {
    setSelectedExercises((prev) =>
      prev.map((item, i) => {
        if (i !== exIdx) return item;
        const updatedSets = item.sets.map((s, sI) =>
          sI === setIdx ? { ...s, [field]: val } : s
        );
        return { ...item, sets: updatedSets };
      })
    );
  };

  const handleSave = (e) => {
    e.preventDefault();
    if (!routineName.trim()) return;

    // Clean exercises for saving
    const cleanedExercises = selectedExercises.map((item) => ({
      exercise_id: item.exercise_id || item.exercise?.id,
      exercise: item.exercise,
      rest_seconds: item.rest_seconds || 90,
      target_sets: item.sets?.length || 3,
      target_reps: item.sets?.[0]?.reps || 10,
      sets: item.sets || [],
    }));

    onSaveRoutine({
      id: editingRoutine?.id || null,
      name: routineName.trim(),
      description: routineDesc.trim() || null,
      color: routineColor,
      exercises: cleanedExercises,
    });

    setIsEditing(false);
  };

  return (
    <div className="space-y-6 sm:space-y-7">
      {isSelectingExercise ? (
        <ExerciseLibrary
          exercises={exercises}
          onSelectExercise={handleAddExerciseToRoutine}
          onAddCustomExercise={onAddCustomExercise}
        />
      ) : isEditing ? (
        <Card className="space-y-5 p-5 sm:p-6 shadow-sm">
          <h3 className="text-base font-bold text-slate-900">
            {editingRoutine ? 'Edit Routine Template' : 'Create New Routine Template'}
          </h3>

          <form onSubmit={handleSave} className="space-y-5">
            <Input
              label="Routine Name"
              placeholder="e.g., Push Day, Full Body A..."
              value={routineName}
              onChange={(e) => setRoutineName(e.target.value)}
              required
            />

            <Input
              label="Description / Notes"
              placeholder="Optional notes (e.g., Hypertrophy focus)"
              value={routineDesc}
              onChange={(e) => setRoutineDesc(e.target.value)}
            />

            {/* Routine Color Picker */}
            <div className="space-y-2">
              <label className="block text-xs sm:text-sm font-semibold text-slate-700">
                Tag Color
              </label>
              <div className="flex items-center gap-3">
                {ROUTINE_COLORS.map((c) => (
                  <button
                    key={c}
                    type="button"
                    onClick={() => setRoutineColor(c)}
                    className={`w-7 h-7 rounded-xl transition-all ${
                      routineColor === c
                        ? 'ring-2 ring-indigo-500 ring-offset-2 scale-110'
                        : 'opacity-80 hover:opacity-100'
                    }`}
                    style={{ backgroundColor: c }}
                  />
                ))}
              </div>
            </div>

            {/* Routine Exercises List with Interactive Sets */}
            <div className="space-y-4 pt-3 border-t border-slate-200/80">
              <div className="flex items-center justify-between">
                <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                  Included Exercises ({selectedExercises.length})
                </h4>
              </div>

              {selectedExercises.map((item, exIdx) => {
                const exName = item.exercise?.name || item.exercise?.name_es || item.title || item.name || 'Exercise';
                const exType = item.exercise?.exercise_type || 'weight_reps';
                const isRepsOnly = exType === 'reps_only';
                const isDurationOnly = exType === 'duration_only';

                return (
                  <div
                    key={exIdx}
                    className="bg-slate-50/80 border border-slate-200 rounded-2xl p-4 space-y-3.5 text-xs sm:text-sm"
                  >
                    {/* Header: Exercise Name & Move/Delete Controls */}
                    <div className="flex items-center justify-between gap-3">
                      <div className="flex items-center gap-2">
                        {/* Reorder Buttons */}
                        <div className="flex flex-col gap-0.5">
                          <button
                            type="button"
                            disabled={exIdx === 0}
                            onClick={() => handleMoveExercise(exIdx, -1)}
                            className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                          >
                            <ArrowUp className="w-3.5 h-3.5" />
                          </button>
                          <button
                            type="button"
                            disabled={exIdx === selectedExercises.length - 1}
                            onClick={() => handleMoveExercise(exIdx, 1)}
                            className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                          >
                            <ArrowDown className="w-3.5 h-3.5" />
                          </button>
                        </div>

                        <span className="font-bold text-indigo-600 font-mono">{exIdx + 1}.</span>
                        <span className="font-bold text-slate-900 text-sm">{exName}</span>
                      </div>

                      <button
                        type="button"
                        onClick={() => handleRemoveExercise(exIdx)}
                        aria-label="Remove exercise from routine"
                        className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>

                    {/* Interactive Sets Table */}
                    <div className="space-y-2 pt-1">
                      {/* Sets Table Header */}
                      <div className="grid grid-cols-12 gap-2 text-[11px] font-bold text-slate-400 uppercase tracking-wider px-1">
                        <span className="col-span-2 text-center">SET</span>
                        <span className="col-span-3 text-center">TYPE</span>
                        <span className="col-span-3 text-center">{isDurationOnly ? 'SEC' : 'KG'}</span>
                        <span className="col-span-3 text-center">REPS</span>
                        <span className="col-span-1"></span>
                      </div>

                      {/* Set Rows */}
                      {(item.sets || []).map((s, setIdx) => (
                        <div
                          key={setIdx}
                          className="grid grid-cols-12 gap-2 items-center bg-white p-2 rounded-xl border border-slate-200/90 shadow-2xs"
                        >
                          {/* Set Index */}
                          <div className="col-span-2 text-center font-mono font-bold text-slate-700 text-xs">
                            {setIdx + 1}
                          </div>

                          {/* Set Indicator Button Toggle */}
                          <div className="col-span-3 flex justify-center">
                            <div className="flex items-center bg-slate-100 p-0.5 rounded-lg gap-0.5">
                              {SET_INDICATORS.map((ind) => (
                                <button
                                  key={ind.key}
                                  type="button"
                                  onClick={() => handleUpdateSetField(exIdx, setIdx, 'indicator', ind.key)}
                                  className={`w-5 h-5 text-[10px] font-bold rounded-md transition-all ${
                                    (s.indicator || 'normal') === ind.key ? ind.activeBg : 'text-slate-400 hover:text-slate-700'
                                  }`}
                                  title={`Set type: ${ind.key}`}
                                >
                                  {ind.label}
                                </button>
                              ))}
                            </div>
                          </div>

                          {/* Weight (KG) / Duration */}
                          <div className="col-span-3">
                            <input
                              type="number"
                              step="any"
                              placeholder={isRepsOnly ? '-' : '0'}
                              disabled={isRepsOnly}
                              value={s.weight_kg !== undefined && s.weight_kg !== null ? s.weight_kg : ''}
                              onChange={(e) =>
                                handleUpdateSetField(
                                  exIdx,
                                  setIdx,
                                  'weight_kg',
                                  e.target.value === '' ? '' : parseFloat(e.target.value) || 0
                                )
                              }
                              className="w-full py-1 px-2 text-xs text-center font-mono font-bold border border-slate-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-indigo-500 disabled:bg-slate-100 disabled:text-slate-400"
                            />
                          </div>

                          {/* Reps */}
                          <div className="col-span-3">
                            <input
                              type="number"
                              placeholder={isDurationOnly ? '-' : '10'}
                              disabled={isDurationOnly}
                              value={s.reps !== undefined && s.reps !== null ? s.reps : ''}
                              onChange={(e) =>
                                handleUpdateSetField(
                                  exIdx,
                                  setIdx,
                                  'reps',
                                  e.target.value === '' ? '' : parseInt(e.target.value, 10) || 0
                                )
                              }
                              className="w-full py-1 px-2 text-xs text-center font-mono font-bold border border-slate-200 rounded-lg focus:outline-none focus:ring-1 focus:ring-indigo-500 disabled:bg-slate-100 disabled:text-slate-400"
                            />
                          </div>

                          {/* Remove Set Button */}
                          <div className="col-span-1 flex justify-center">
                            <button
                              type="button"
                              onClick={() => handleRemoveSetFromExercise(exIdx, setIdx)}
                              className="p-1 text-slate-300 hover:text-rose-600 rounded-md hover:bg-rose-50 transition-colors"
                              title="Delete set"
                            >
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </div>
                        </div>
                      ))}

                      {/* Add Set Button & Rest Time Picker */}
                      <div className="flex flex-wrap items-center justify-between gap-2 pt-1.5">
                        <button
                          type="button"
                          onClick={() => handleAddSetToExercise(exIdx)}
                          className="flex items-center gap-1 text-xs font-bold text-indigo-600 hover:text-indigo-800 bg-indigo-50 hover:bg-indigo-100 px-3 py-1.5 rounded-lg transition-colors"
                        >
                          <Plus className="w-3.5 h-3.5" />
                          <span>Add Set</span>
                        </button>

                        {/* Rest Timer Selector */}
                        <div className="flex items-center gap-1.5">
                          <span className="text-[11px] font-semibold text-slate-500 flex items-center gap-1">
                            <Timer className="w-3.5 h-3.5 text-indigo-600" />
                            <span>Rest:</span>
                          </span>
                          <div className="flex items-center gap-1 bg-slate-200/70 p-0.5 rounded-lg">
                            {[0, 30, 60, 90, 120, 150, 180].map((sec) => (
                              <button
                                key={sec}
                                type="button"
                                onClick={() => handleUpdateItemRest(exIdx, sec)}
                                className={`px-1.5 py-0.5 text-[10px] font-bold rounded-md transition-all ${
                                  (item.rest_seconds || 90) === sec
                                    ? 'bg-white text-indigo-700 shadow-xs'
                                    : 'text-slate-600 hover:text-slate-900'
                                }`}
                              >
                                {sec}s
                              </button>
                            ))}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                );
              })}

              <Button
                type="button"
                variant="secondary"
                icon={Plus}
                className="w-full justify-center py-3"
                onClick={() => setIsSelectingExercise(true)}
              >
                Add Exercise to Routine
              </Button>
            </div>

            <div className="flex justify-end gap-3 pt-3">
              <Button variant="ghost" onClick={() => setIsEditing(false)}>
                Cancel
              </Button>
              <Button type="submit" variant="primary">
                Save Routine
              </Button>
            </div>
          </form>
        </Card>
      ) : (
        <>
          <div className="flex items-center justify-between">
            <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
              My Routine Templates ({routines.length})
            </h3>
            <Button variant="primary" size="sm" icon={Plus} onClick={handleOpenNew}>
              New Routine
            </Button>
          </div>

          {routines.length === 0 ? (
            <Card className="text-center py-10 space-y-3">
              <Dumbbell className="w-12 h-12 text-slate-300 mx-auto" />
              <p className="text-sm text-slate-500 font-medium">
                No routine templates created yet. Create one above.
              </p>
            </Card>
          ) : (
            <div className="space-y-5 sm:space-y-6">
              {routines.map((routine) => (
                <Card
                  key={routine.id}
                  className="space-y-4 p-5 sm:p-6 border-l-4 hover:border-indigo-200 shadow-sm"
                  style={{ borderLeftColor: routine.color || '#6366f1' }}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <h4 className="text-base font-bold text-slate-900">{routine.name}</h4>
                      {routine.description && (
                        <p className="text-xs sm:text-sm text-slate-500 font-medium mt-1">
                          {routine.description}
                        </p>
                      )}
                      <span className="inline-block text-xs font-mono font-semibold text-slate-500 mt-2">
                        {routine.exercises?.length || 0} exercises
                      </span>
                    </div>

                    <div className="flex items-center gap-1.5 shrink-0">
                      <button
                        onClick={() => handleOpenEdit(routine)}
                        aria-label={`Edit routine ${routine.name}`}
                        className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-indigo-50"
                      >
                        <Edit3 className="w-4 h-4" />
                      </button>
                      <button
                        onClick={() => onDeleteRoutine(routine.id)}
                        aria-label={`Delete routine ${routine.name}`}
                        className="p-2 text-slate-400 hover:text-rose-600 rounded-xl hover:bg-rose-50"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </div>

                  {/* Exercises Preview Chips */}
                  {routine.exercises && routine.exercises.length > 0 && (
                    <div className="flex flex-wrap gap-1.5 pt-1">
                      {routine.exercises.slice(0, 6).map((exItem, eIdx) => {
                        const name =
                          exItem.exercise?.name || exItem.exercise?.name_es || exItem.title || 'Exercise';
                        const setsCount = exItem.sets?.length || exItem.target_sets || 3;
                        return (
                          <span
                            key={eIdx}
                            className="bg-slate-100 text-slate-700 text-[11px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1"
                          >
                            <span>{name}</span>
                            <span className="text-slate-400 font-mono text-[10px]">({setsCount}s)</span>
                          </span>
                        );
                      })}
                      {routine.exercises.length > 6 && (
                        <span className="text-[11px] font-medium text-slate-400 self-center">
                          +{routine.exercises.length - 6} more
                        </span>
                      )}
                    </div>
                  )}

                  <Button
                    variant="primary"
                    icon={Play}
                    className="w-full justify-center py-3"
                    onClick={() => onStartRoutine(routine)}
                  >
                    Start Workout
                  </Button>
                </Card>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}
