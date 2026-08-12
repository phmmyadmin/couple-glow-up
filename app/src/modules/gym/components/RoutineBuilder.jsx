import React, { useState } from 'react';
import { Plus, Trash2, Dumbbell, Play, Edit3 } from 'lucide-react';
import ExerciseLibrary from './ExerciseLibrary';

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
  const [selectedExercises, setSelectedExercises] = useState([]);
  const [isSelectingExercise, setIsSelectingExercise] = useState(false);

  const handleOpenNew = () => {
    setEditingRoutine(null);
    setRoutineName('Nueva Rutina');
    setRoutineDesc('');
    setSelectedExercises([]);
    setIsEditing(true);
  };

  const handleOpenEdit = (routine) => {
    setEditingRoutine(routine);
    setRoutineName(routine.name);
    setRoutineDesc(routine.description || '');
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
      <div className="health-card space-y-4 p-4">
        <h3 className="text-sm font-bold text-slate-900">
          {editingRoutine ? 'Editar Rutina' : 'Crear Nueva Rutina'}
        </h3>

        <form onSubmit={handleSave} className="space-y-3">
          <div>
            <label className="text-xs font-semibold text-slate-600 block mb-1">Nombre de la Rutina</label>
            <input
              type="text"
              placeholder="Ej: Push Day, Full Body A..."
              value={routineName}
              onChange={(e) => setRoutineName(e.target.value)}
              className="edit-input"
              required
            />
          </div>

          <div>
            <label className="text-xs font-semibold text-slate-600 block mb-1">Descripción / Notas</label>
            <input
              type="text"
              placeholder="Notas opcionales (ej: Enfoque en hipertrofia)"
              value={routineDesc}
              onChange={(e) => setRoutineDesc(e.target.value)}
              className="edit-input"
            />
          </div>

          {/* Routine Exercises */}
          <div className="space-y-2 pt-2">
            <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
              Ejercicios ({selectedExercises.length})
            </h4>

            {selectedExercises.map((item, idx) => (
              <div
                key={idx}
                className="bg-slate-50 border border-slate-200 rounded-xl p-2.5 flex items-center justify-between text-xs"
              >
                <div className="flex items-center gap-2">
                  <span className="font-bold text-indigo-600 font-mono">{idx + 1}.</span>
                  <span className="font-semibold text-slate-900">
                    {item.exercise?.name_es || item.exercise?.name || 'Ejercicio'}
                  </span>
                </div>

                <div className="flex items-center gap-2">
                  <span className="text-[11px] font-mono text-slate-500 bg-white border border-slate-200 px-2 py-0.5 rounded-lg">
                    {item.target_sets} series × {item.target_reps} reps
                  </span>
                  <button
                    type="button"
                    onClick={() => handleRemoveExercise(idx)}
                    className="p-1 text-slate-400 hover:text-rose-600"
                  >
                    <Trash2 className="w-3.5 h-3.5" />
                  </button>
                </div>
              </div>
            ))}

            <button
              type="button"
              onClick={() => setIsSelectingExercise(true)}
              className="w-full py-2 bg-indigo-50 border border-dashed border-indigo-300 text-indigo-700 rounded-xl text-xs font-bold flex items-center justify-center gap-1.5 hover:bg-indigo-100 transition-all"
            >
              <Plus className="w-4 h-4" />
              <span>Añadir Ejercicio a la Rutina</span>
            </button>
          </div>

          <div className="flex justify-end gap-2 pt-3">
            <button
              type="button"
              onClick={() => setIsEditing(false)}
              className="px-4 py-2 text-xs font-semibold text-slate-500 hover:text-slate-800"
            >
              Cancelar
            </button>
            <button
              type="submit"
              className="px-4 py-2 bg-indigo-600 text-white rounded-xl text-xs font-bold shadow-sm hover:bg-indigo-700"
            >
              Guardar Rutina
            </button>
          </div>
        </form>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Mis Plantillas de Rutinas ({routines.length})
        </h3>
        <button
          onClick={handleOpenNew}
          className="flex items-center gap-1 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-3 py-1.5 rounded-xl shadow-sm transition-all active:scale-95"
        >
          <Plus className="w-4 h-4" />
          <span>Nueva Rutina</span>
        </button>
      </div>

      {routines.length === 0 ? (
        <div className="health-card text-center py-8 space-y-2">
          <Dumbbell className="w-8 h-8 text-slate-300 mx-auto" />
          <p className="text-xs text-slate-400">No hay rutinas creadas aún. Crea una arriba.</p>
        </div>
      ) : (
        <div className="space-y-3">
          {routines.map((routine) => (
            <div
              key={routine.id}
              className="health-card p-4 space-y-3 hover:border-indigo-200"
            >
              <div className="flex items-start justify-between">
                <div>
                  <h4 className="text-sm font-bold text-slate-900">{routine.name}</h4>
                  {routine.description && (
                    <p className="text-xs text-slate-500 font-medium mt-0.5">
                      {routine.description}
                    </p>
                  )}
                </div>

                <div className="flex items-center gap-1">
                  <button
                    onClick={() => handleOpenEdit(routine)}
                    className="p-1.5 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-slate-100"
                  >
                    <Edit3 className="w-4 h-4" />
                  </button>
                  <button
                    onClick={() => onDeleteRoutine(routine.id)}
                    className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-slate-100"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Start Workout Button */}
              <button
                onClick={() => onStartRoutine(routine)}
                className="w-full py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-bold flex items-center justify-center gap-1.5 shadow-sm transition-all active:scale-95"
              >
                <Play className="w-3.5 h-3.5 fill-white" />
                <span>Iniciar Entrenamiento</span>
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
