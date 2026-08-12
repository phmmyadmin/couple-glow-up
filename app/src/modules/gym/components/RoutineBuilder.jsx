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
    setRoutineName('Nueva Rutina');
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
      />
    );
  }

  if (isEditing) {
    return (
      <Card className="space-y-4 p-5">
        <h3 className="text-base font-bold text-slate-900">
          {editingRoutine ? 'Editar Rutina' : 'Crear Nueva Rutina'}
        </h3>

        <form onSubmit={handleSave} className="space-y-4">
          <Input
            label="Nombre de la Rutina"
            placeholder="Ej: Push Day, Full Body A..."
            value={routineName}
            onChange={(e) => setRoutineName(e.target.value)}
            required
          />

          <Input
            label="Descripción / Notas"
            placeholder="Notas opcionales (ej: Enfoque en hipertrofia)"
            value={routineDesc}
            onChange={(e) => setRoutineDesc(e.target.value)}
          />

          {/* Routine Color Picker */}
          <div className="space-y-1.5">
            <label className="block text-xs font-semibold text-slate-600">
              Color de Etiqueta
            </label>
            <div className="flex items-center gap-2">
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
          <div className="space-y-2.5 pt-2 border-t border-slate-200/80">
            <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
              Ejercicios Incluidos ({selectedExercises.length})
            </h4>

            {selectedExercises.map((item, idx) => (
              <div
                key={idx}
                className="bg-slate-50 border border-slate-200 rounded-2xl p-3.5 space-y-2 text-xs sm:text-sm"
              >
                <div className="flex items-center justify-between">
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
                      {item.exercise?.name_es || item.exercise?.name || 'Ejercicio'}
                    </span>
                  </div>

                  <button
                    type="button"
                    onClick={() => handleRemoveExercise(idx)}
                    aria-label="Eliminar ejercicio de la rutina"
                    className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>

                {/* Target Sets & Reps Editable Controls */}
                <div className="flex items-center gap-3 pt-1 border-t border-slate-200/60">
                  <div className="flex items-center gap-1.5">
                    <span className="text-xs text-slate-500 font-medium">Series:</span>
                    <input
                      type="number"
                      min="1"
                      max="20"
                      value={item.target_sets || 3}
                      onChange={(e) =>
                        handleUpdateItemField(idx, 'target_sets', parseInt(e.target.value, 10))
                      }
                      className="w-14 px-2 py-1 text-xs text-center font-mono font-bold rounded-lg border border-slate-200 bg-white"
                    />
                  </div>

                  <div className="flex items-center gap-1.5">
                    <span className="text-xs text-slate-500 font-medium">Reps:</span>
                    <input
                      type="number"
                      min="1"
                      max="100"
                      value={item.target_reps || 10}
                      onChange={(e) =>
                        handleUpdateItemField(idx, 'target_reps', parseInt(e.target.value, 10))
                      }
                      className="w-14 px-2 py-1 text-xs text-center font-mono font-bold rounded-lg border border-slate-200 bg-white"
                    />
                  </div>
                </div>
              </div>
            ))}

            <Button
              type="button"
              variant="secondary"
              icon={Plus}
              className="w-full justify-center"
              onClick={() => setIsSelectingExercise(true)}
            >
              Añadir Ejercicio a la Rutina
            </Button>
          </div>

          <div className="flex justify-end gap-2 pt-3">
            <Button variant="ghost" onClick={() => setIsEditing(false)}>
              Cancelar
            </Button>
            <Button type="submit" variant="primary">
              Guardar Rutina
            </Button>
          </div>
        </form>
      </Card>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Mis Plantillas de Rutinas ({routines.length})
        </h3>
        <Button variant="primary" size="sm" icon={Plus} onClick={handleOpenNew}>
          Nueva Rutina
        </Button>
      </div>

      {routines.length === 0 ? (
        <Card className="text-center py-8 space-y-2">
          <Dumbbell className="w-10 h-10 text-slate-300 mx-auto" />
          <p className="text-sm text-slate-500 font-medium">No hay rutinas creadas aún. Crea una arriba.</p>
        </Card>
      ) : (
        <div className="space-y-3">
          {routines.map((routine) => (
            <Card
              key={routine.id}
              className="space-y-3 p-4 border-l-4 hover:border-indigo-200"
              style={{ borderLeftColor: routine.color || '#6366f1' }}
            >
              <div className="flex items-start justify-between">
                <div>
                  <h4 className="text-base font-bold text-slate-900">{routine.name}</h4>
                  {routine.description && (
                    <p className="text-xs sm:text-sm text-slate-500 font-medium mt-0.5">
                      {routine.description}
                    </p>
                  )}
                  <span className="inline-block text-[11px] font-mono font-semibold text-slate-500 mt-1">
                    {routine.exercises?.length || 0} ejercicios
                  </span>
                </div>

                <div className="flex items-center gap-1">
                  <button
                    onClick={() => handleOpenEdit(routine)}
                    aria-label={`Editar rutina ${routine.name}`}
                    className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-indigo-50"
                  >
                    <Edit3 className="w-4 h-4" />
                  </button>
                  <button
                    onClick={() => onDeleteRoutine(routine.id)}
                    aria-label={`Eliminar rutina ${routine.name}`}
                    className="p-2 text-slate-400 hover:text-rose-600 rounded-xl hover:bg-rose-50"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </div>

              <Button
                variant="primary"
                icon={Play}
                className="w-full justify-center"
                onClick={() => onStartRoutine(routine)}
              >
                Iniciar Entrenamiento
              </Button>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
