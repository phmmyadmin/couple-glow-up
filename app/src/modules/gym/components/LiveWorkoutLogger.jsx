import React, { useState, useEffect } from 'react';
import { Play, Check, Plus, Trash2, Clock, Dumbbell, Award, X, ArrowUp, ArrowDown, Timer, Flame } from 'lucide-react';
import { calculate1RM } from '../lib/supabase-gym';
import ExerciseLibrary from './ExerciseLibrary';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';

export default function LiveWorkoutLogger({
  exercises,
  onSaveWorkout,
  onCancel,
  activeProfile,
  initialRoutine = null,
}) {
  const [workoutName, setWorkoutName] = useState(
    initialRoutine?.name || 'Workout of the Day'
  );
  const [secondsElapsed, setSecondsElapsed] = useState(0);
  const [workoutExercises, setWorkoutExercises] = useState([]);
  const [isSelectingExercise, setIsSelectingExercise] = useState(false);

  // Rest Timer State
  const [restTimerSeconds, setRestTimerSeconds] = useState(0);
  const [isRestTimerActive, setIsRestTimerActive] = useState(false);

  // Timer interval for main session duration
  useEffect(() => {
    const timer = setInterval(() => {
      setSecondsElapsed((prev) => prev + 1);
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  // Timer interval for rest countdown
  useEffect(() => {
    let interval = null;
    if (isRestTimerActive && restTimerSeconds > 0) {
      interval = setInterval(() => {
        setRestTimerSeconds((prev) => {
          if (prev <= 1) {
            setIsRestTimerActive(false);
            return 0;
          }
          return prev - 1;
        });
      }, 1000);
    } else if (restTimerSeconds === 0) {
      setIsRestTimerActive(false);
    }
    return () => clearInterval(interval);
  }, [isRestTimerActive, restTimerSeconds]);

  const startRestTimer = (seconds = 90) => {
    setRestTimerSeconds(seconds);
    setIsRestTimerActive(true);
  };

  const formatTimer = (totalSec) => {
    const mins = Math.floor(totalSec / 60);
    const secs = totalSec % 60;
    return `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
  };

  // Calculate live volume accumulator (kg * reps)
  const totalLiveVolumeKg = workoutExercises.reduce((sumEx, item) => {
    const exVolume = item.sets.reduce((sumSet, set) => {
      if (set.is_checked && set.weight_kg && set.reps) {
        return sumSet + set.weight_kg * set.reps;
      }
      return sumSet;
    }, 0);
    return sumEx + exVolume;
  }, 0);

  // Add exercise to active session
  const handleAddExercise = (exercise) => {
    const newEx = {
      id: Date.now().toString(),
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

  const handleMoveExercise = (index, direction) => {
    const newIdx = index + direction;
    if (newIdx < 0 || newIdx >= workoutExercises.length) return;
    const updated = [...workoutExercises];
    const temp = updated[index];
    updated[index] = updated[newIdx];
    updated[newIdx] = temp;
    setWorkoutExercises(updated);
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
          const updatedSets = item.sets.map((s) => {
            if (s.id === setId) {
              const updated = { ...s, [field]: value };
              // Auto launch rest timer if checking a set as completed
              if (field === 'is_checked' && value === true) {
                startRestTimer(defaultRestSeconds);
              }
              return updated;
            }
            return s;
          });
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

    onSaveWorkout(
      {
        profile_id: activeProfile?.id || null,
        name: workoutName,
        started_at: startedAt,
        finished_at: finishedAt,
        duration_minutes: Math.ceil(secondsElapsed / 60),
        estimated_volume_kg: totalLiveVolumeKg,
      },
      allSets
    );
  };

  if (isSelectingExercise) {
    return (
      <div className="space-y-6 sm:space-y-7">
        <div className="flex items-center justify-between">
          <h3 className="text-base font-bold text-slate-900">Select Exercise</h3>
          <button
            onClick={() => setIsSelectingExercise(false)}
            aria-label="Close exercise selector"
            className="p-1.5 text-slate-500 hover:text-slate-900 rounded-xl hover:bg-slate-100"
          >
            <X className="w-5 h-5" />
          </button>
        </div>
        <ExerciseLibrary exercises={exercises} onSelectExercise={handleAddExercise} />
      </div>
    );
  }

  // Configurable Default Rest Target
  const [defaultRestSeconds, setDefaultRestSeconds] = useState(90);
  const [isEditingTime, setIsEditingTime] = useState(false);
  const [customMinutesInput, setCustomMinutesInput] = useState('');

  const handleApplyCustomMinutes = (e) => {
    e.preventDefault();
    const mins = parseInt(customMinutesInput, 10);
    if (!isNaN(mins) && mins >= 0) {
      setSecondsElapsed(mins * 60);
    }
    setIsEditingTime(false);
  };

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Rest Timer Floating Banner */}
      {isRestTimerActive && (
        <div className="fixed top-4 left-1/2 -translate-x-1/2 z-50 bg-indigo-600 text-white px-5 py-3 rounded-2xl shadow-xl border border-indigo-400 flex items-center gap-4 animate-in fade-in slide-in-from-top-4 duration-200">
          <Timer className="w-5 h-5 text-indigo-200 animate-pulse" />
          <div className="text-xs sm:text-sm font-semibold">
            <span>Resting: </span>
            <span className="font-mono font-bold text-base text-white">{formatTimer(restTimerSeconds)}</span>
          </div>
          <div className="flex items-center gap-2 border-l border-indigo-400/50 pl-3">
            <button
              onClick={() => setRestTimerSeconds((p) => p + 30)}
              className="px-2 py-1 text-xs font-bold bg-indigo-500 hover:bg-indigo-400 rounded-lg"
            >
              +30s
            </button>
            <button
              onClick={() => setIsRestTimerActive(false)}
              className="p-1 text-indigo-200 hover:text-white"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>
      )}

      {/* Live Timer & Header Card */}
      <Card className="bg-slate-900 text-white border-slate-800 shadow-md p-5 sm:p-6 space-y-4">
        <div className="flex items-center justify-between gap-3">
          <input
            type="text"
            value={workoutName}
            aria-label="Workout name"
            onChange={(e) => setWorkoutName(e.target.value)}
            className="bg-transparent text-base sm:text-lg font-bold text-white border-b border-slate-700 focus:outline-none focus:border-indigo-400 flex-1"
          />

          <div className="flex gap-2">
            <Button variant="ghost" size="sm" className="text-slate-300 hover:text-white" onClick={onCancel}>
              Cancel
            </Button>
            <Button variant="primary" size="sm" onClick={handleFinish}>
              Finish
            </Button>
          </div>
        </div>

        {/* Live Metrics & Editable Timer Row */}
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs sm:text-sm text-slate-300 pt-3 border-t border-slate-800 font-mono">
          <div className="flex items-center gap-3">
            <span className="flex items-center gap-2">
              <Clock className="w-4 h-4 text-indigo-400" />
              <span>Time: <strong>{formatTimer(secondsElapsed)}</strong></span>
            </span>

            {!isEditingTime ? (
              <button
                type="button"
                onClick={() => {
                  setCustomMinutesInput(Math.floor(secondsElapsed / 60).toString());
                  setIsEditingTime(true);
                }}
                className="text-[11px] font-sans font-semibold text-indigo-300 hover:text-indigo-200 bg-slate-800 px-2 py-0.5 rounded border border-slate-700"
              >
                Edit Time
              </button>
            ) : (
              <form onSubmit={handleApplyCustomMinutes} className="flex items-center gap-1">
                <input
                  type="number"
                  min="0"
                  max="600"
                  value={customMinutesInput}
                  onChange={(e) => setCustomMinutesInput(e.target.value)}
                  className="w-14 px-1.5 py-0.5 text-xs text-center bg-slate-800 text-white rounded border border-indigo-500 font-mono"
                  placeholder="mins"
                />
                <span className="text-xs text-slate-400">m</span>
                <button type="submit" className="px-2 py-0.5 text-xs bg-indigo-600 rounded font-sans font-bold">
                  Set
                </button>
              </form>
            )}
          </div>

          {/* Configurable Rest Timer Target */}
          <div className="flex items-center gap-2">
            <Timer className="w-4 h-4 text-indigo-400" />
            <span className="text-slate-400 text-xs font-sans">Rest target:</span>
            <div className="flex items-center gap-1">
              {[30, 60, 90, 120, 180].map((sec) => (
                <button
                  key={sec}
                  type="button"
                  onClick={() => setDefaultRestSeconds(sec)}
                  className={`px-2 py-0.5 text-[11px] font-sans font-bold rounded transition-all ${
                    defaultRestSeconds === sec
                      ? 'bg-indigo-600 text-white'
                      : 'bg-slate-800 text-slate-400 hover:text-slate-200'
                  }`}
                >
                  {sec}s
                </button>
              ))}
            </div>
          </div>

          <span className="flex items-center gap-2 text-indigo-300">
            <Flame className="w-4 h-4 text-amber-400" />
            <span>Volume: <strong>{totalLiveVolumeKg.toLocaleString()} kg</strong></span>
          </span>
        </div>
      </Card>

      {/* Exercises List in Session */}
      {workoutExercises.length === 0 ? (
        <Card className="text-center py-10 space-y-3">
          <Dumbbell className="w-12 h-12 text-slate-300 mx-auto" />
          <p className="text-sm text-slate-500 font-medium">Add your first exercise to start logging.</p>
          <Button icon={Plus} variant="primary" onClick={() => setIsSelectingExercise(true)}>
            Add Exercise
          </Button>
        </Card>
      ) : (
        <div className="space-y-6 sm:space-y-7">
          {workoutExercises.map((item, exIdx) => {
            const exType = item.exercise.exercise_type;

            return (
              <Card key={item.id} className="space-y-4 p-5 sm:p-6 shadow-sm">
                <div className="flex items-center justify-between gap-3">
                  <div className="flex items-center gap-2">
                    {/* Reorder Arrows */}
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
                        disabled={exIdx === workoutExercises.length - 1}
                        onClick={() => handleMoveExercise(exIdx, 1)}
                        className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                      >
                        <ArrowDown className="w-3.5 h-3.5" />
                      </button>
                    </div>

                    <h4 className="text-base font-bold text-slate-900 flex items-center gap-2">
                      <span className="w-3 h-3 rounded-full bg-indigo-600"></span>
                      <span>{item.exercise.name || item.exercise.name_es}</span>
                    </h4>
                  </div>

                  <span className="text-xs text-slate-500 font-semibold capitalize">
                    {item.exercise.muscle_group}
                  </span>
                </div>

                {/* Sets Table */}
                <div className="space-y-3">
                  <div className="grid grid-cols-12 gap-2 text-xs font-bold text-slate-400 uppercase text-center px-1">
                    <span className="col-span-1">#</span>
                    <span className="col-span-3">Type</span>
                    <span className="col-span-3">
                      {exType === 'weight_reps'
                        ? 'Kg'
                        : exType === 'distance_duration'
                        ? 'Meters'
                        : 'Seconds'}
                    </span>
                    <span className="col-span-3">
                      {exType === 'weight_reps' || exType === 'reps_only' ? 'Reps' : 'Time'}
                    </span>
                    <span className="col-span-2">✓</span>
                  </div>

                  {item.sets.map((set, sIdx) => {
                    const epley1RM =
                      exType === 'weight_reps' && set.weight_kg && set.reps
                        ? calculate1RM(set.weight_kg, set.reps)
                        : null;

                    return (
                      <div
                        key={set.id}
                        className={`grid grid-cols-12 gap-2 items-center p-3 rounded-xl border text-xs sm:text-sm text-center transition-all ${
                          set.is_checked
                            ? 'bg-emerald-50/90 border-emerald-200 text-emerald-900 font-medium'
                            : 'bg-slate-50 border-slate-200 text-slate-800'
                        }`}
                      >
                        {/* Set index */}
                        <span className="col-span-1 font-mono font-bold text-slate-500 text-xs sm:text-sm">
                          {sIdx + 1}
                        </span>

                        {/* Indicator selector */}
                        <select
                          aria-label="Set Type"
                          value={set.indicator}
                          onChange={(e) =>
                            handleUpdateSet(item.id, set.id, 'indicator', e.target.value)
                          }
                          className="col-span-3 px-2 py-1.5 text-xs sm:text-sm rounded-lg border border-slate-200 bg-white font-semibold"
                        >
                          <option value="normal">Normal</option>
                          <option value="warmup">Warmup</option>
                          <option value="dropset">Drop Set</option>
                          <option value="failure">Failure</option>
                        </select>

                        {/* Primary Input */}
                        <div className="col-span-3">
                          {exType === 'weight_reps' && (
                            <input
                              type="number"
                              step="any"
                              aria-label="Weight in kg"
                              value={set.weight_kg || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'weight_kg', parseFloat(e.target.value))
                              }
                              className="w-full px-2 py-1.5 text-xs sm:text-sm text-center font-mono font-bold rounded-lg border border-slate-200 bg-white"
                            />
                          )}
                          {exType === 'distance_duration' && (
                            <input
                              type="number"
                              aria-label="Distance in meters"
                              value={set.distance_meters || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'distance_meters', parseFloat(e.target.value))
                              }
                              className="w-full px-2 py-1.5 text-xs sm:text-sm text-center font-mono font-bold rounded-lg border border-slate-200 bg-white"
                            />
                          )}
                          {(exType === 'duration_only' || exType === 'reps_only') && (
                            <span className="text-xs text-slate-400 font-mono">-</span>
                          )}
                        </div>

                        {/* Secondary Input with Discrete 1RM Badge */}
                        <div className="col-span-3 flex items-center gap-1 justify-center">
                          {(exType === 'weight_reps' || exType === 'reps_only') && (
                            <input
                              type="number"
                              aria-label="Reps"
                              value={set.reps || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'reps', parseInt(e.target.value, 10))
                              }
                              className="w-full px-2 py-1.5 text-xs sm:text-sm text-center font-mono font-bold rounded-lg border border-slate-200 bg-white"
                            />
                          )}
                          {(exType === 'distance_duration' || exType === 'duration_only') && (
                            <input
                              type="number"
                              aria-label="Duration in seconds"
                              value={set.duration_seconds || ''}
                              onChange={(e) =>
                                handleUpdateSet(item.id, set.id, 'duration_seconds', parseInt(e.target.value, 10))
                              }
                              className="w-full px-2 py-1.5 text-xs sm:text-sm text-center font-mono font-bold rounded-lg border border-slate-200 bg-white"
                            />
                          )}
                          {epley1RM > 0 && (
                            <span
                              title={`Estimated 1RM (Epley): ${epley1RM} kg`}
                              className="hidden sm:inline-flex items-center gap-0.5 text-[10px] font-mono text-indigo-700 bg-indigo-50 border border-indigo-200 px-1.5 py-0.5 rounded font-bold shrink-0"
                            >
                              <Award className="w-3 h-3 text-indigo-600" />
                              {epley1RM}k
                            </span>
                          )}
                        </div>

                        {/* Checked checkbox & Delete */}
                        <div className="col-span-2 flex items-center justify-center gap-1.5">
                          <button
                            onClick={() =>
                              handleUpdateSet(item.id, set.id, 'is_checked', !set.is_checked)
                            }
                            aria-label="Mark set as completed"
                            className={`w-8 h-8 rounded-lg flex items-center justify-center font-bold transition-all ${
                              set.is_checked
                                ? 'bg-emerald-500 text-white shadow-sm'
                                : 'bg-white border border-slate-300 text-slate-400'
                            }`}
                          >
                            <Check className="w-4 h-4" />
                          </button>
                          <button
                            onClick={() => handleDeleteSet(item.id, set.id)}
                            aria-label="Delete set"
                            className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </div>
                      </div>
                    );
                  })}
                </div>

                <Button
                  variant="secondary"
                  size="sm"
                  icon={Plus}
                  className="w-full justify-center py-2.5"
                  onClick={() => handleAddSet(item.id)}
                >
                  Add Set
                </Button>
              </Card>
            );
          })}

          <Button
            variant="outline"
            icon={Plus}
            className="w-full justify-center py-3.5 border-dashed border-indigo-300 text-indigo-700 hover:bg-indigo-50"
            onClick={() => setIsSelectingExercise(true)}
          >
            Add Another Exercise
          </Button>
        </div>
      )}
    </div>
  );
}
