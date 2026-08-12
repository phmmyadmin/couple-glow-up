import React, { useState } from 'react';
import { Plus, Trash2, Dumbbell, Play, Edit3 } from 'lucide-react';
import ExerciseLibrary from './ExerciseLibrary';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';

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
      <Card className="space-y-4 p-5">
        <h3 className="text-base font-bold text-slate-900">
          {editingRoutine ? 'Editar Rutina' : 'Crear Nueva Rutina'}
        </h3>

        <form onSubmit={handleSave} className="space-y-3">
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

          {/* Routine Exercises */}
          <div className="space-y-2.5 pt-2">
            <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
              Ejercicios Incluidos ({selectedExercises.length})
            </h4>

            {selectedExercises.map((item, idx) => (
              <div
                key={idx}
                className="bg-slate-50 border border-slate-200 rounded-xl p-3 flex items-center justify-between text-xs sm:text-sm"
              >
                <div className="flex items-center gap-2">
                  <span className="font-bold text-indigo-600 font-mono">{idx + 1}.</span>
                  <span className="font-semibold text-slate-900">
                    {item.exercise?.name_es || item.exercise?.name || 'Ejercicio'}
                  </span>
                </div>

                <div className="flex items-center gap-2">
                  <span className="text-xs font-mono text-slate-600 bg-white border border-slate-200 px-2.5 py-1 rounded-lg font-semibold">
                    {item.target_sets} series × {item.target_reps} reps
                  </span>
                  <button
                    type="button"
                    onClick={() => handleRemoveExercise(idx)}
                    aria-label="Eliminar ejercicio de la rutina"
                    className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
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
            <Card key={routine.id} className="space-y-3 p-4 hover:border-indigo-200">
              <div className="flex items-start justify-between">
                <div>
                  <h4 className="text-base font-bold text-slate-900">{routine.name}</h4>
                  {routine.description && (
                    <p className="text-xs sm:text-sm text-slate-500 font-medium mt-0.5">
                      {routine.description}
                    </p>
                  )}
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
