import React, { useState } from 'react';
import { Plus, Trash2, Dumbbell, Play, Edit3, ArrowUp, ArrowDown } from 'lucide-react';
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
    setSelectedExercises(routine.exercises || []);
    setIsEditing(true);
  };

  const handleAddExerciseToRoutine = (exercise) => {
    const newItem = {
      exercise_id: exercise.id,
      exercise: exercise,
      target_sets: 3,
      target_reps: 10,
      rest_seconds: 90,
    };
    setSelectedExercises((prev) => [...prev, newItem]);
    setIsSelectingExercise(false);
  };

  const handleUpdateItemField = (index, field, value) => {
    setSelectedExercises((prev) =>
      prev.map((item, idx) => (idx === index ? { ...item, [field]: value } : item))
    );
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

  const handleSave = (e) => {
    e.preventDefault();
    if (!routineName.trim()) return;

    onSaveRoutine({
      id: editingRoutine?.id || null,
      name: routineName.trim(),
      description: routineDesc.trim() || null,
      color: routineColor,
      exercises: selectedExercises,
    });

    setIsEditing(false);
  };

  if (isSelectingExercise) {
    return (
      <ExerciseLibrary
        exercises={exercises}
        onSelectExercise={handleAddExerciseToRoutine}
        onAddCustomExercise={onAddCustomExercise}
      />
    );
  }

  if (isEditing) {
    return (
      <Card className="space-y-5 p-5 sm:p-6 shadow-sm">
        <h3 className="text-base font-bold text-slate-900">
          {editingRoutine ? 'Edit Routine' : 'Create New Routine'}
        </h3>

        <form onSubmit={handleSave} className="space-y-4">
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

          {/* Routine Exercises List */}
          <div className="space-y-3 pt-3 border-t border-slate-200/80">
            <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
              Included Exercises ({selectedExercises.length})
            </h4>

            {selectedExercises.map((item, idx) => (
              <div
                key={idx}
                className="bg-slate-50 border border-slate-200 rounded-2xl p-4 space-y-3 text-xs sm:text-sm"
              >
                <div className="flex items-center justify-between gap-3">
                  <div className="flex items-center gap-2">
                    {/* Reorder Buttons */}
                    <div className="flex flex-col gap-0.5">
                      <button
                        type="button"
                        disabled={idx === 0}
                        onClick={() => handleMoveExercise(idx, -1)}
                        className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                      >
                        <ArrowUp className="w-3.5 h-3.5" />
                      </button>
                      <button
                        type="button"
                        disabled={idx === selectedExercises.length - 1}
                        onClick={() => handleMoveExercise(idx, 1)}
                        className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                      >
                        <ArrowDown className="w-3.5 h-3.5" />
                      </button>
                    </div>

                    <span className="font-bold text-indigo-600 font-mono">{idx + 1}.</span>
                    <span className="font-bold text-slate-900">
                      {item.exercise?.name || item.exercise?.name_es || 'Exercise'}
                    </span>
                  </div>

                  <button
                    type="button"
                    onClick={() => handleRemoveExercise(idx)}
                    aria-label="Remove exercise from routine"
                    className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>

                {/* Target Sets & Reps Editable Controls */}
                <div className="flex flex-wrap items-center gap-4 pt-2 border-t border-slate-200/60">
                  {/* Sets Control */}
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-slate-600 font-semibold">Sets:</span>
                    <div className="flex items-center rounded-lg border border-slate-200 bg-white overflow-hidden shadow-2xs">
                      <button
                        type="button"
                        onClick={() =>
                          handleUpdateItemField(idx, 'target_sets', Math.max(1, (item.target_sets || 3) - 1))
                        }
                        className="px-2 py-1 text-slate-500 hover:bg-slate-100 font-bold"
                      >
                        -
                      </button>
                      <input
                        type="number"
                        min="1"
                        max="20"
                        value={item.target_sets || 3}
                        onChange={(e) =>
                          handleUpdateItemField(idx, 'target_sets', parseInt(e.target.value, 10) || 1)
                        }
                        className="w-12 py-1 text-xs text-center font-mono font-bold focus:outline-none"
                      />
                      <button
                        type="button"
                        onClick={() =>
                          handleUpdateItemField(idx, 'target_sets', (item.target_sets || 3) + 1)
                        }
                        className="px-2 py-1 text-slate-500 hover:bg-slate-100 font-bold"
                      >
                        +
                      </button>
                    </div>
                  </div>

                  {/* Reps Control */}
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-slate-600 font-semibold">Reps:</span>
                    <div className="flex items-center rounded-lg border border-slate-200 bg-white overflow-hidden shadow-2xs">
                      <button
                        type="button"
                        onClick={() =>
                          handleUpdateItemField(idx, 'target_reps', Math.max(1, (item.target_reps || 10) - 1))
                        }
                        className="px-2 py-1 text-slate-500 hover:bg-slate-100 font-bold"
                      >
                        -
                      </button>
                      <input
                        type="number"
                        min="1"
                        max="100"
                        value={item.target_reps || 10}
                        onChange={(e) =>
                          handleUpdateItemField(idx, 'target_reps', parseInt(e.target.value, 10) || 1)
                        }
                        className="w-12 py-1 text-xs text-center font-mono font-bold focus:outline-none"
                      />
                      <button
                        type="button"
                        onClick={() =>
                          handleUpdateItemField(idx, 'target_reps', (item.target_reps || 10) + 1)
                        }
                        className="px-2 py-1 text-slate-500 hover:bg-slate-100 font-bold"
                      >
                        +
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            ))}

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
    );
  }

  return (
    <div className="space-y-6 sm:space-y-7">
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
          <p className="text-sm text-slate-500 font-medium">No routine templates created yet. Create one above.</p>
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
    </div>
  );
}
