import React, { useState, useEffect } from 'react';
import { Play, Check, Plus, Trash2, Clock, Dumbbell, Trophy, X, Flame } from 'lucide-react';
import { calculate1RM } from '../lib/supabase-gym';
import ExerciseLibrary from './ExerciseLibrary';

export default function LiveWorkoutLogger({
  exercises,
  onSaveWorkout,
  onCancel,
  activeProfile,
  initialRoutine = null,
}) {
  const [workoutName, setWorkoutName] = useState(
    initialRoutine?.name || 'Entrenamiento del día'
  );
  const [secondsElapsed, setSecondsElapsed] = useState(0);
  const [workoutExercises, setWorkoutExercises] = useState([]);
  const [isSelectingExercise, setIsSelectingExercise] = useState(false);

  // Timer interval
  useEffect(() => {
    const timer = setInterval(() => {
      setSecondsElapsed((prev) => prev + 1);
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  const formatTimer = (totalSec) => {
    const mins = Math.floor(totalSec / 60);
    const secs = totalSec % 60;
    return `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
  };

  // Add exercise to active session
  const handleAddExercise = (exercise) => {
    const newEx = {
      id: exercise.id,
      exercise: exercise,
      sets: [
        {
          id: Date.now().toString(),
          indicator: 'normal',
          weight_kg: 20,
          reps: 10,
          duration_seconds: 60,
          distance_meters: 1000,
          is_checked: false,
        },
      ],
    };
    setWorkoutExercises((prev) => [...prev, newEx]);
    setIsSelectingExercise(false);
  };

  // Set management helpers
  const handleAddSet = (exerciseId) => {
    setWorkoutExercises((prev) =>
      prev.map((item) => {
        if (item.id === exerciseId) {
          const lastSet = item.sets[item.sets.length - 1];
          const newSet = {
            id: Date.now().toString(),
            indicator: 'normal',
            weight_kg: lastSet ? lastSet.weight_kg : 20,
            reps: lastSet ? lastSet.reps : 10,
            duration_seconds: lastSet ? lastSet.duration_seconds : 60,
            distance_meters: lastSet ? lastSet.distance_meters : 1000,
            is_checked: false,
          };
          return { ...item, sets: [...item.sets, newSet] };
        }
        return item;
      })
    );
  };

  const handleUpdateSet = (exerciseId, setId, field, value) => {
    setWorkoutExercises((prev) =>
      prev.map((item) => {
        if (item.id === exerciseId) {
          const updatedSets = item.sets.map((s) =>
            s.id === setId ? { ...s, [field]: value } : s
          );
          return { ...item, sets: updatedSets };
        }
        return item;
      })
    );
  };

  const handleDeleteSet = (exerciseId, setId) => {
    setWorkoutExercises((prev) =>
      prev.map((item) => {
        if (item.id === exerciseId) {
          return { ...item, sets: item.sets.filter((s) => s.id !== setId) };
        }
        return item;
      })
    );
  };

  const handleFinish = () => {
    const startedAt = new Date(Date.now() - secondsElapsed * 1000).toISOString();
    const finishedAt = new Date().toISOString();

    // Flatten all completed sets
    const allSets = [];
    workoutExercises.forEach((item) => {
      item.sets.forEach((set) => {
        allSets.push({
          exercise_id: item.exercise.id,
          indicator: set.indicator,
          weight_kg: set.weight_kg,
          reps: set.reps,
          duration_seconds: set.duration_seconds,
          distance_meters: set.distance_meters,
          is_checked: set.is_checked,
        });
      });
    });

    onSaveWorkout({
      profile_id: activeProfile?.id || null,
      name: workoutName,
      started_at: startedAt,
      finished_at: finishedAt,
      duration_minutes: Math.ceil(secondsElapsed / 60),
    }, allSets);
  };

  if (isSelectingExercise) {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h3 className="text-sm font-bold text-slate-900">Seleccionar Ejercicio</h3>
          <button
            onClick={() => setIsSelectingExercise(false)}
            className="p-1 text-slate-500 hover:text-slate-900"
          >
            <X className="w-5 h-5" />
          </button>
        </div>
        <ExerciseLibrary exercises={exercises} onSelectExercise={handleAddExercise} />
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {/* Live Timer Bar */}
      <div className="health-card bg-slate-900 text-white p-4 flex items-center justify-between border-slate-800 shadow-md">
        <div>
          <input
            type="text"
            value={workoutName}
            onChange={(e) => setWorkoutName(e.target.value)}
            className="bg-transparent text-sm font-bold text-white border-b border-slate-700 focus:outline-none focus:border-indigo-400"
          />
          <p className="text-[11px] text-slate-400 font-mono mt-0.5 flex items-center gap-1">
            <Clock className="w-3 h-3 text-indigo-400" />
            <span>Tiempo: {formatTimer(secondsElapsed)}</span>
          </p>
        </div>

        <div className="flex gap-2">
          <button
            onClick={onCancel}
            className="px-3 py-1.5 bg-slate-800 text-slate-300 rounded-xl text-xs font-semibold hover:bg-slate-700"
          >
            Cancelar
          </button>
          <button
            onClick={handleFinish}
            className="px-3.5 py-1.5 bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl text-xs font-bold shadow-sm"
          >
            Finalizar
          </button>
        </div>
      </div>

      {/* Exercises List in Session */}
      {workoutExercises.length === 0 ? (
        <div className="health-card text-center py-10 space-y-3">
          <Dumbbell className="w-10 h-10 text-slate-300 mx-auto" />
          <p className="text-xs text-slate-500 font-medium">Añade tu primer ejercicio para empezar el entrenamiento.</p>
          <button
            onClick={() => setIsSelectingExercise(true)}
            className="px-4 py-2 bg-indigo-600 text-white rounded-xl text-xs font-semibold inline-flex items-center gap-1.5 shadow-sm"
          >
            <Plus className="w-4 h-4" />
            <span>Añadir Ejercicio</span>
          </button>
        </div>
      ) : (
        <div className="space-y-4">
          {workoutExercises.map((item) => {
            const exType = item.exercise.exercise_type;

            return (
              <div key={item.id} className="health-card space-y-3 p-4">
                <div className="flex items-center justify-between">
                  <h4 className="text-xs font-bold text-slate-900 flex items-center gap-2">
                    <span className="w-2 h-2 rounded-full bg-indigo-600"></span>
                    <span>{item.exercise.name_es || item.exercise.name}</span>
                  </h4>
                  <span className="text-[10px] text-slate-500 font-mono capitalize">
                    {item.exercise.muscle_group}
                  </span>
                </div>

                {/* Sets Table */}
                <div className="space-y-2">
                  <div className="grid grid-cols-12 gap-1 text-[10px] font-bold text-slate-400 uppercase text-center px-1">
                    <span className="col-span-2">Serie</span>
                    <span className="col-span-3">Tipo</span>
                    <span className="col-span-3">
                      {exType === 'weight_reps'
                        ? 'Kg'
                        : exType === 'distance_duration'
                        ? 'Metros'
                        : 'Segundos'}
                    </span>
                    <span className="col-span-2">
                      {exType === 'weight_reps' || exType === 'reps_only' ? 'Reps' : 'Tiempo'}
                    </span>
                    <span className="col-span-2">✓</span>
                  </div>

                  {item.sets.map((set, sIdx) => {
                    const epley1RM =
                      exType === 'weight_reps'
                        ? calculate1RM(set.weight_kg, set.reps)
                        : null;

                    return (
                      <div
                        key={set.id}
                        className={`grid grid-cols-12 gap-1 items-center p-1.5 rounded-xl border text-xs text-center transition-all ${
                          set.is_checked
                            ? 'bg-emerald-50 border-emerald-200 text-emerald-900'
                            : 'bg-slate-50 border-slate-200 text-slate-800'
                        }`}
                      >
                        {/* Set index */}
                        <span className="col-span-2 font-mono font-bold text-slate-500">
                          {sIdx + 1}
                        </span>

                        {/* Indicator selector */}
                        <select
                          value={set.indicator}
                          onChange={(e) =>
                            handleUpdateSet(item.id, set.id, 'indicator', e.target.value)
                          }
                          className="col-span-3 edit-select p-1 text-[10px] text-center"
                        >
                          <option value="normal">Normal</option>
                          <option value="warmup">W (Calent.)</option>
                          <option value="dropset">D (Drop)</option>
                          <option value="failure">F (Fallo)</option>
                        </select>

                        {/* Primary Input */}
                        <div className="col-span-3">
                          {exType === 'weight_reps' && (
                            <input
                              type="number"
                              step="any"
                              value={set.weight_kg || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'weight_kg', parseFloat(e.target.value))
                              }
                              className="edit-input p-1 text-center font-mono text-xs"
                            />
                          )}
                          {exType === 'distance_duration' && (
                            <input
                              type="number"
                              value={set.distance_meters || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'distance_meters', parseFloat(e.target.value))
                              }
                              className="edit-input p-1 text-center font-mono text-xs"
                            />
                          )}
                          {(exType === 'duration_only' || exType === 'reps_only') && (
                            <span className="text-[10px] text-slate-400 font-mono">-</span>
                          )}
                        </div>

                        {/* Secondary Input */}
                        <div className="col-span-2">
                          {(exType === 'weight_reps' || exType === 'reps_only') && (
                            <input
                              type="number"
                              value={set.reps || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'reps', parseInt(e.target.value, 10))
                              }
                              className="edit-input p-1 text-center font-mono text-xs"
                            />
                          )}
                          {(exType === 'distance_duration' || exType === 'duration_only') && (
                            <input
                              type="number"
                              value={set.duration_seconds || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'duration_seconds', parseInt(e.target.value, 10))
                              }
                              className="edit-input p-1 text-center font-mono text-xs"
                            />
                          )}
                        </div>

                        {/* Checked checkbox */}
                        <div className="col-span-2 flex items-center justify-center gap-1">
                          <button
                            onClick={() =>
                              handleUpdateSet(item.id, set.id, 'is_checked', !set.is_checked)
                            }
                            className={`w-6 h-6 rounded-lg flex items-center justify-center font-bold text-xs transition-all ${
                              set.is_checked
                                ? 'bg-emerald-500 text-white'
                                : 'bg-white border border-slate-300 text-slate-400'
                            }`}
                          >
                            <Check className="w-3.5 h-3.5" />
                          </button>
                          <button
                            onClick={() => handleDeleteSet(item.id, set.id)}
                            className="p-1 text-slate-400 hover:text-rose-600"
                          >
                            <Trash2 className="w-3 h-3" />
                          </button>
                        </div>

                        {/* Live 1RM Epley preview */}
                        {epley1RM > 0 && (
                          <div className="col-span-12 text-[10px] text-indigo-600 font-mono text-right pr-2 pt-0.5">
                            Est. 1RM (Epley): <strong>{epley1RM} kg</strong>
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>

                <button
                  onClick={() => handleAddSet(item.id)}
                  className="w-full py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-semibold rounded-xl flex items-center justify-center gap-1 border border-slate-200"
                >
                  <Plus className="w-3.5 h-3.5" />
                  <span>Añadir Serie</span>
                </button>
              </div>
            );
          })}

          <button
            onClick={() => setIsSelectingExercise(true)}
            className="w-full py-3 bg-indigo-50 border border-dashed border-indigo-300 text-indigo-700 rounded-2xl text-xs font-bold flex items-center justify-center gap-1.5 hover:bg-indigo-100 transition-all shadow-sm"
          >
            <Plus className="w-4 h-4" />
            <span>Añadir Otro Ejercicio</span>
          </button>
        </div>
      )}
    </div>
  );
}
