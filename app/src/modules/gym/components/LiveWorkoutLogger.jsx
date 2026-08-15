import React, { useState, useEffect } from 'react';
import {
  Play, Check, Plus, Trash2, Clock, Dumbbell, Award, X, ArrowUp, ArrowDown,
  Timer, Flame, Edit3, Save, Info, MoreVertical, GripVertical, RotateCcw,
  FileText, ChevronDown, User, ArrowLeft, Minus
} from 'lucide-react';
import { calculate1RM, doesSetMatchExercise } from '../lib/supabase-gym';
import ExerciseLibrary, { getMuscleGroupLabel } from './ExerciseLibrary';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';

function formatSecondsToMMSS(totalSeconds) {
  if (totalSeconds === null || totalSeconds === undefined || totalSeconds === '') return '';
  const secs = parseInt(totalSeconds, 10);
  if (isNaN(secs) || secs < 0) return '';
  const m = Math.floor(secs / 60);
  const s = secs % 60;
  return `${m}:${String(s).padStart(2, '0')}`;
}

function parseMMSSToSeconds(mmssStr) {
  if (mmssStr === null || mmssStr === undefined || mmssStr === '') return null;
  const str = String(mmssStr).trim();
  if (!str) return null;
  if (!str.includes(':')) {
    const num = parseFloat(str);
    if (isNaN(num) || num <= 0) return null;
    return num > 300 ? Math.round(num) : Math.round(num * 60);
  }
  const parts = str.split(':');
  const m = parseInt(parts[0], 10) || 0;
  const s = parseInt(parts[1], 10) || 0;
  return m * 60 + s;
}

// 2-Letter Initials Circle generator matching Hevy style (e.g. Manguito Rotador -> MR, Press Militar -> PM)
function getExerciseInitials(name) {
  if (!name) return 'EX';
  const clean = String(name).trim().replace(/[^\w\s]/gi, '');
  const words = clean.split(/\s+/).filter(Boolean);
  if (words.length === 0) return 'EX';
  if (words.length === 1) return words[0].slice(0, 2).toUpperCase();
  return (words[0][0] + words[1][0]).toUpperCase();
}

export function getLastPerformanceForExercise(targetExercise, workouts = []) {
  if (!targetExercise || !workouts || workouts.length === 0) return null;

  for (const w of workouts) {
    const sets = w.workout_sets || [];
    const exSets = sets.filter((s) => doesSetMatchExercise(s, targetExercise));

    if (exSets.length > 0) {
      return {
        workoutName: w.name,
        dateStr: new Date(w.started_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric' }),
        sets: exSets,
      };
    }
  }

  return null;
}

export default function LiveWorkoutLogger({
  exercises,
  workouts = [],
  onSaveWorkout,
  onCancel,
  activeProfile,
  initialRoutine = null,
  initialWorkoutState = null,
  onAddCustomExercise,
}) {
  const [selectedExerciseForHistory, setSelectedExerciseForHistory] = useState(null);
  const [workoutName, setWorkoutName] = useState(() => {
    return initialWorkoutState?.workoutName || initialRoutine?.name || 'Workout of the Day';
  });

  const startTimeRef = React.useRef(
    initialWorkoutState?.startTime || Date.now()
  );

  const [secondsElapsed, setSecondsElapsed] = useState(() => {
    if (initialWorkoutState?.startTime) {
      return Math.max(0, Math.floor((Date.now() - initialWorkoutState.startTime) / 1000));
    }
    return initialWorkoutState?.secondsElapsed || 0;
  });

  const [workoutExercises, setWorkoutExercises] = useState(() => {
    return initialWorkoutState?.workoutExercises || [];
  });

  const [isSelectingExercise, setIsSelectingExercise] = useState(false);
  const [replaceExerciseIndex, setReplaceExerciseIndex] = useState(null);

  // Context Menu Bottom Sheet & Reorder Mode States (Hevy Screenshots 1 & 3)
  const [menuExerciseIndex, setMenuExerciseIndex] = useState(null);
  const [isReorderMode, setIsReorderMode] = useState(false);

  // Rest Timer State
  const [restTimerSeconds, setRestTimerSeconds] = useState(0);
  const [isRestTimerActive, setIsRestTimerActive] = useState(false);
  const [defaultRestSeconds, setDefaultRestSeconds] = useState(90);

  // Duration Edit Modal / Inline State
  const [isEditingTimeModal, setIsEditingTimeModal] = useState(false);
  const [editMinutesInput, setEditMinutesInput] = useState('');

  // Timer interval for main session duration
  useEffect(() => {
    const timer = setInterval(() => {
      setSecondsElapsed(Math.max(0, Math.floor((Date.now() - startTimeRef.current) / 1000)));
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  // Auto-persist active workout state to localStorage
  useEffect(() => {
    if (workoutExercises.length > 0 || workoutName) {
      const stateToSave = {
        workoutName,
        startTime: startTimeRef.current,
        secondsElapsed,
        workoutExercises,
        activeRoutine: initialRoutine,
        lastUpdated: Date.now(),
      };
      localStorage.setItem('couple_glow_up_active_workout', JSON.stringify(stateToSave));
      window.dispatchEvent(new Event('active_workout_updated'));
    }
  }, [workoutName, secondsElapsed, workoutExercises, initialRoutine]);

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

  const startRestTimer = (seconds = defaultRestSeconds) => {
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

  // Calculate total completed sets
  const totalCompletedSets = workoutExercises.reduce((sumEx, item) => {
    return sumEx + (item.sets || []).filter((s) => s.is_checked).length;
  }, 0);

  // Pre-fill exercises if started from routine
  useEffect(() => {
    const rawExercises = initialRoutine?.exercises || initialRoutine?.items || [];
    if (initialRoutine && rawExercises.length > 0 && workoutExercises.length === 0 && !initialWorkoutState) {
      setWorkoutName(initialRoutine.name || 'Workout of the Day');

      const formattedEx = rawExercises.map((item, idx) => {
        let matchedEx = null;

        // 1. Try matching by exercise_id
        if (item.exercise_id || item.exercise?.id) {
          const exId = item.exercise_id || item.exercise?.id;
          matchedEx = exercises?.find((e) => e.id === exId);
        }

        // 2. Try matching by name / name_es
        if (!matchedEx) {
          const targetName = (
            item.exercise?.name ||
            item.exercise?.name_es ||
            item.exercise_title ||
            item.title ||
            item.name ||
            item.es_title ||
            ''
          )
            .toLowerCase()
            .trim();

          if (targetName) {
            matchedEx = exercises?.find(
              (e) =>
                (e.name && e.name.toLowerCase().trim() === targetName) ||
                (e.name_es && e.name_es.toLowerCase().trim() === targetName)
            );
          }
        }

        const finalExercise = matchedEx
          ? { ...(item.exercise || {}), ...matchedEx }
          : item.exercise || {
              id: item.exercise_id || `ex-${idx}`,
              name: item.exercise_title || item.title || item.name || item.es_title || 'Exercise',
              name_es: item.es_title || item.exercise_title || item.title || item.name || 'Ejercicio',
              muscle_group: item.muscle_group || 'other',
              exercise_type: item.exercise_type || 'weight_reps',
              equipment_category: item.equipment_category || 'dumbbell',
            };

        const lastPerf = getLastPerformanceForExercise(finalExercise, workouts);

        let initialSets = [];
        if (Array.isArray(item.sets) && item.sets.length > 0) {
          initialSets = item.sets.map((s, setIdx) => {
            const lastSet = lastPerf?.sets[setIdx] || lastPerf?.sets[0];
            const weightVal = (s.weight_kg !== undefined && s.weight_kg !== '' && s.weight_kg !== 0)
              ? s.weight_kg
              : (lastSet?.weight_kg !== undefined ? lastSet.weight_kg : '');
            const repsVal = (s.reps !== undefined && s.reps !== '' && s.reps !== 0)
              ? s.reps
              : (lastSet?.reps !== undefined ? lastSet.reps : '');

            return {
              id: `${Date.now()}-${idx}-${setIdx}`,
              indicator: s.indicator || s.set_type || lastSet?.indicator || 'normal',
              weight_kg: weightVal,
              reps: repsVal,
              duration_seconds: s.duration_seconds || lastSet?.duration_seconds || null,
              distance_meters: s.distance_meters || lastSet?.distance_meters || null,
              distance_km: s.distance_km !== undefined ? s.distance_km : (s.distance_meters ? s.distance_meters / 1000 : (lastSet?.distance_meters ? lastSet.distance_meters / 1000 : null)),
              is_checked: false,
            };
          });
        } else {
          const targetSetsCount = parseInt(item.target_sets, 10) || (lastPerf?.sets.length || 3);
          const isDist = finalExercise.exercise_type === 'distance_duration';
          const isDur = finalExercise.exercise_type === 'duration_only';

          initialSets = Array.from({ length: targetSetsCount }).map((_, setIdx) => {
            const lastSet = lastPerf?.sets[setIdx] || lastPerf?.sets[0];
            return {
              id: `${Date.now()}-${idx}-${setIdx}`,
              indicator: lastSet?.indicator || 'normal',
              weight_kg: isDist || isDur ? '' : (item.target_weight || lastSet?.weight_kg || 20),
              reps: isDist || isDur ? '' : (item.target_reps || lastSet?.reps || 10),
              duration_seconds: isDist ? (lastSet?.duration_seconds || 1200) : isDur ? (lastSet?.duration_seconds || 60) : null,
              distance_meters: isDist ? (lastSet?.distance_meters || 5000) : null,
              distance_km: isDist ? ((lastSet?.distance_meters || 5000) / 1000) : null,
              is_checked: false,
            };
          });
        }

        return {
          id: `${Date.now()}-${idx}`,
          exercise_id: finalExercise.id,
          exercise: finalExercise,
          notes: item.notes || '',
          rest_seconds: item.rest_seconds !== undefined ? item.rest_seconds : (finalExercise.exercise_type === 'distance_duration' ? 0 : 90),
          lastPerformance: lastPerf,
          sets: initialSets,
        };
      });

      setWorkoutExercises(formattedEx);
    }
  }, [initialRoutine, exercises, workouts]);

  // Handle exercise selection or replacement
  const handleAddOrReplaceExercise = (exercise) => {
    if (replaceExerciseIndex !== null) {
      setWorkoutExercises((prev) =>
        prev.map((item, idx) => {
          if (idx === replaceExerciseIndex) {
            const lastPerf = getLastPerformanceForExercise(exercise, workouts);
            return {
              ...item,
              exercise_id: exercise.id,
              exercise: exercise,
              lastPerformance: lastPerf,
            };
          }
          return item;
        })
      );
      setReplaceExerciseIndex(null);
    } else {
      handleAddExercise(exercise);
    }
    setIsSelectingExercise(false);
  };

  // Add new exercise to active session
  const handleAddExercise = (exercise) => {
    const isDist = exercise.exercise_type === 'distance_duration';
    const isDur = exercise.exercise_type === 'duration_only';
    const lastPerf = getLastPerformanceForExercise(exercise, workouts);

    let initialSets = [];
    if (lastPerf && lastPerf.sets.length > 0) {
      initialSets = lastPerf.sets.map((s, sIdx) => ({
        id: `${Date.now()}-${sIdx}`,
        indicator: s.indicator || 'normal',
        weight_kg: s.weight_kg !== undefined && s.weight_kg !== null ? s.weight_kg : '',
        reps: s.reps !== undefined && s.reps !== null ? s.reps : '',
        duration_seconds: s.duration_seconds || (isDur ? 60 : null),
        distance_meters: s.distance_meters || (isDist ? 5000 : null),
        distance_km: s.distance_meters ? s.distance_meters / 1000 : (s.distance_km || null),
        is_checked: false,
      }));
    } else {
      initialSets = [
        {
          id: Date.now().toString(),
          indicator: 'normal',
          weight_kg: isDist || isDur ? '' : 20,
          reps: isDist || isDur ? '' : 10,
          duration_seconds: isDist ? 1200 : isDur ? 60 : null,
          distance_meters: isDist ? 5000 : null,
          distance_km: isDist ? 5 : null,
          is_checked: false,
        },
      ];
    }

    const newEx = {
      id: Date.now().toString(),
      exercise: exercise,
      notes: '',
      rest_seconds: isDist ? 0 : 90,
      lastPerformance: lastPerf,
      sets: initialSets,
    };
    setWorkoutExercises((prev) => [...prev, newEx]);
    setIsSelectingExercise(false);
  };

  const handleUpdateExerciseRest = (exIndex, restSecs) => {
    setWorkoutExercises((prev) =>
      prev.map((item, idx) => (idx === exIndex ? { ...item, rest_seconds: restSecs } : item))
    );
  };

  const handleUpdateExerciseNotes = (exIndex, notesText) => {
    setWorkoutExercises((prev) =>
      prev.map((item, idx) => (idx === exIndex ? { ...item, notes: notesText } : item))
    );
  };

  const handleRemoveExercise = (exIndex) => {
    setWorkoutExercises((prev) => prev.filter((_, idx) => idx !== exIndex));
  };

  const handleMoveExercise = (exIndex, direction) => {
    const targetIdx = exIndex + direction;
    if (targetIdx < 0 || targetIdx >= workoutExercises.length) return;
    setWorkoutExercises((prev) => {
      const copy = [...prev];
      const temp = copy[exIndex];
      copy[exIndex] = copy[targetIdx];
      copy[targetIdx] = temp;
      return copy;
    });
  };

  const handleAddSet = (exIndex) => {
    setWorkoutExercises((prev) => {
      return prev.map((item, idx) => {
        if (idx === exIndex) {
          const lastSet = item.sets[item.sets.length - 1];
          const newSet = {
            id: Date.now().toString(),
            indicator: 'normal',
            weight_kg: lastSet ? lastSet.weight_kg : 20,
            reps: lastSet ? lastSet.reps : 10,
            is_checked: false,
          };
          return { ...item, sets: [...item.sets, newSet] };
        }
        return item;
      });
    });
  };

  const handleRemoveSet = (exIndex, setIndex) => {
    setWorkoutExercises((prev) => {
      return prev.map((item, idx) => {
        if (idx === exIndex) {
          return {
            ...item,
            sets: item.sets.filter((_, sIdx) => sIdx !== setIndex),
          };
        }
        return item;
      });
    });
  };

  const handleUpdateSetField = (exIndex, setIndex, field, value) => {
    setWorkoutExercises((prev) => {
      return prev.map((item, idx) => {
        if (idx === exIndex) {
          const updatedSets = item.sets.map((s, sIdx) => {
            if (sIdx === setIndex) {
              const updated = { ...s, [field]: value };
              // Auto launch rest timer using exercise-specific rest target
              if (field === 'is_checked' && value === true) {
                startRestTimer(item.rest_seconds || defaultRestSeconds || 90);
              }
              return updated;
            }
            return s;
          });
          return { ...item, sets: updatedSets };
        }
        return item;
      });
    });
  };

  const handleCancelWorkout = () => {
    if (window.confirm('Are you sure you want to cancel this workout? Progress will be lost.')) {
      localStorage.removeItem('couple_glow_up_active_workout');
      window.dispatchEvent(new Event('active_workout_updated'));
      onCancel();
    }
  };

  const handleFinish = () => {
    localStorage.removeItem('couple_glow_up_active_workout');
    window.dispatchEvent(new Event('active_workout_updated'));

    const allSets = [];
    workoutExercises.forEach((item) => {
      item.sets.forEach((s) => {
        // Include set if checked OR if it has any non-zero values entered
        const hasValue =
          s.is_checked ||
          (s.weight_kg !== undefined && parseFloat(s.weight_kg) > 0) ||
          (s.reps !== undefined && parseInt(s.reps, 10) > 0) ||
          Boolean(s.duration_seconds) ||
          Boolean(s.distance_meters);

        if (hasValue) {
          allSets.push({
            ...s,
            exercise_id: item.exercise.id,
            exercise: item.exercise,
            exercises: item.exercise,
          });
        }
      });
    });

    const durationMins = Math.max(1, Math.round(secondsElapsed / 60));

    onSaveWorkout(
      {
        name: workoutName,
        profile_id: activeProfile?.id || null,
        duration_minutes: durationMins,
        started_at: new Date(startTimeRef.current).toISOString(),
        finished_at: new Date().toISOString(),
        estimated_volume_kg: totalLiveVolumeKg,
      },
      allSets
    );
  };

  const handleApplyCustomTime = (e) => {
    e.preventDefault();
    const mins = parseInt(editMinutesInput, 10);
    if (!isNaN(mins) && mins >= 0) {
      setSecondsElapsed(mins * 60);
    }
    setIsEditingTimeModal(false);
  };

  return (
    <div className="space-y-6 sm:space-y-7 pb-12">
      {isSelectingExercise ? (
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-base font-bold text-slate-900">
              {replaceExerciseIndex !== null ? 'Reemplazar Ejercicio' : 'Seleccionar Ejercicio'}
            </h3>
            <button
              onClick={() => {
                setIsSelectingExercise(false);
                setReplaceExerciseIndex(null);
              }}
              className="text-xs font-bold text-slate-500 hover:text-slate-800"
            >
              Cancel
            </button>
          </div>
          <ExerciseLibrary
            exercises={exercises}
            onSelectExercise={handleAddOrReplaceExercise}
            onAddCustomExercise={onAddCustomExercise}
          />
        </div>
      ) : (
        <>
          {/* Rest Timer Floating Banner */}
          {isRestTimerActive && (
            <div className="fixed top-4 left-4 right-4 sm:left-1/2 sm:-translate-x-1/2 sm:w-auto max-w-md mx-auto z-50 bg-white/95 backdrop-blur-md text-slate-900 px-4 py-2.5 sm:px-5 sm:py-3 rounded-2xl shadow-xl border border-indigo-200/90 flex items-center justify-between gap-3 animate-in fade-in slide-in-from-top-4 duration-200">
              <div className="flex items-center gap-2.5 min-w-0">
                <Timer className="w-4 h-4 sm:w-5 sm:h-5 text-indigo-600 animate-pulse shrink-0" />
                <div className="text-xs sm:text-sm font-semibold truncate">
                  <span className="text-slate-500">Rest: </span>
                  <span className="font-mono font-extrabold text-sm sm:text-base text-indigo-700">{formatTimer(restTimerSeconds)}</span>
                </div>
              </div>
              <div className="flex items-center gap-2 border-l border-slate-200 pl-2.5 shrink-0">
                <Button
                  variant="secondary"
                  size="sm"
                  className="py-1 px-2.5 text-xs font-bold"
                  onClick={() => setRestTimerSeconds((p) => p + 30)}
                >
                  +30s
                </Button>
                <button
                  onClick={() => setIsRestTimerActive(false)}
                  className="p-1 text-slate-400 hover:text-slate-700"
                  aria-label="Dismiss rest timer"
                >
                  <X className="w-4 h-4" />
                </button>
              </div>
            </div>
          )}

          {/* Hevy-Style Live Session Header Card (Screenshots 2 & 4) */}
          <div className="bg-white border border-slate-200/90 rounded-2xl p-4 sm:p-5 space-y-4 shadow-xs">
            {/* Header Row */}
            <div className="flex items-center justify-between gap-3">
              <div className="flex items-center gap-2 flex-1 min-w-0">
                <ChevronDown className="w-5 h-5 text-slate-400 shrink-0" />
                <input
                  type="text"
                  value={workoutName}
                  aria-label="Workout name"
                  onChange={(e) => setWorkoutName(e.target.value)}
                  className="text-lg sm:text-xl font-extrabold text-slate-900 bg-transparent border-b border-transparent hover:border-slate-300 focus:border-indigo-600 focus:outline-none w-full font-heading truncate"
                />
              </div>

              <div className="flex items-center gap-2 shrink-0">
                <button
                  type="button"
                  onClick={() => setIsRestTimerActive(true)}
                  className="p-2 text-slate-500 hover:text-indigo-600 rounded-xl hover:bg-slate-100 transition-colors relative"
                  title="Rest Timer"
                >
                  <Timer className="w-5 h-5" />
                  {isRestTimerActive && (
                    <span className="absolute top-1 right-1 w-2 h-2 bg-indigo-600 rounded-full animate-ping" />
                  )}
                </button>

                <Button
                  variant="ghost"
                  size="sm"
                  onClick={handleCancelWorkout}
                  className="text-slate-500 hover:text-slate-900"
                >
                  Cancel
                </Button>

                <Button
                  variant="primary"
                  size="sm"
                  icon={Check}
                  onClick={handleFinish}
                  className="rounded-xl px-4 py-2 bg-indigo-600 hover:bg-indigo-700 font-extrabold shadow-sm"
                >
                  Terminar
                </Button>
              </div>
            </div>

            {/* Sub-Header Metrics Row */}
            <div className="flex items-center justify-between pt-3 border-t border-slate-100 text-xs text-slate-600 font-semibold">
              <div className="flex items-center gap-6">
                <div>
                  <span className="text-[11px] font-medium text-slate-400 block">Duración</span>
                  <span className="font-mono font-extrabold text-indigo-600 text-sm">{formatTimer(secondsElapsed)}</span>
                </div>

                <div>
                  <span className="text-[11px] font-medium text-slate-400 block">Volumen</span>
                  <span className="font-mono font-extrabold text-slate-900 text-sm">{totalLiveVolumeKg.toLocaleString()} kg</span>
                </div>

                <div>
                  <span className="text-[11px] font-medium text-slate-400 block">Series</span>
                  <span className="font-mono font-extrabold text-slate-900 text-sm">{totalCompletedSets}</span>
                </div>
              </div>

              {/* Muscle Silhouette Icon */}
              <div className="w-9 h-9 rounded-xl bg-slate-100 border border-slate-200/80 text-slate-600 flex items-center justify-center shrink-0">
                <User className="w-5 h-5" />
              </div>
            </div>
          </div>

          {/* Exercises List in Session */}
          {workoutExercises.length === 0 ? (
            <Card className="text-center py-10 space-y-3 shadow-sm">
              <Dumbbell className="w-12 h-12 text-slate-300 mx-auto" />
              <p className="text-sm text-slate-500 font-medium">Add your first exercise to start logging.</p>
              <Button icon={Plus} variant="primary" onClick={() => setIsSelectingExercise(true)}>
                Add Exercise
              </Button>
            </Card>
          ) : (
            <div className="space-y-5 sm:space-y-6">
              {workoutExercises.map((item, exIdx) => {
                const exName = item.exercise.name || item.exercise.name_es;
                const initials = getExerciseInitials(exName);
                const exType = item.exercise?.exercise_type || 'weight_reps';
                const isDistanceDuration = exType === 'distance_duration';
                const isDurationOnly = exType === 'duration_only';

                return (
                  <Card key={item.id} className="p-4 sm:p-5 space-y-4 shadow-xs border-slate-200/90">
                    {/* Hevy Exercise Header Row (Screenshots 2 & 4) */}
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex items-start gap-3 flex-1 min-w-0">
                        {/* Circular Initials Avatar Badge (e.g. MR, PM, RE) */}
                        <div className="w-10 h-10 rounded-full bg-slate-200/80 border border-slate-300/60 text-slate-700 font-extrabold text-xs flex items-center justify-center shrink-0 mt-0.5 shadow-2xs font-mono">
                          {initials}
                        </div>

                        <div className="space-y-1 flex-1 min-w-0">
                          <h4 className="text-base sm:text-lg font-extrabold text-indigo-600 hover:text-indigo-700 leading-snug break-words">
                            {exName}
                          </h4>

                          {/* Exercise Notes Line */}
                          <input
                            type="text"
                            placeholder="Agregar notas aquí..."
                            value={item.notes || ''}
                            onChange={(e) => handleUpdateExerciseNotes(exIdx, e.target.value)}
                            className="text-xs text-slate-500 placeholder-slate-400 bg-transparent focus:outline-none focus:border-b focus:border-indigo-400 w-full py-0.5"
                          />

                          {/* Configurable Rest Target Line */}
                          <div className="flex items-center gap-1.5 text-xs font-bold text-indigo-600 pt-0.5">
                            <Timer className="w-3.5 h-3.5" />
                            <span>
                              Descanso:{' '}
                              {(item.rest_seconds !== undefined ? item.rest_seconds : 90) === 0
                                ? 'APAGADO'
                                : `${item.rest_seconds !== undefined ? item.rest_seconds : 90}s`}
                            </span>
                          </div>
                        </div>
                      </div>

                      {/* 3-Dots Context Menu Button */}
                      <button
                        type="button"
                        onClick={() => setMenuExerciseIndex(exIdx)}
                        className="p-1.5 text-slate-400 hover:text-slate-700 rounded-xl hover:bg-slate-100 transition-colors shrink-0"
                        title="Exercise Options"
                      >
                        <MoreVertical className="w-5 h-5" />
                      </button>
                    </div>

                    {/* Hevy Sets Table (Screenshots 2 & 4) */}
                    <div className="space-y-2 pt-2 border-t border-slate-100">
                      <div className="grid grid-cols-12 gap-2 text-[11px] font-bold text-slate-400 uppercase tracking-wider px-1">
                        <span className="col-span-2 text-left">SERIE</span>
                        <span className="col-span-3 text-center">ANTERIOR</span>
                        <span className="col-span-3 text-center">{isDistanceDuration ? 'KM' : isDurationOnly ? 'TIEMPO' : 'KG'}</span>
                        <span className="col-span-3 text-center">{isDistanceDuration ? 'TIEMPO' : isDurationOnly ? '-' : 'REPS'}</span>
                        <span className="col-span-1 text-center">✓</span>
                      </div>

                      {item.sets.map((set, setIdx) => {
                        const lastPerf = item.lastPerformance || getLastPerformanceForExercise(item.exercise, workouts);
                        const prevSet = lastPerf?.sets?.[setIdx];
                        let prevText = '-';
                        if (prevSet) {
                          if (prevSet.weight_kg && prevSet.reps) prevText = `${prevSet.weight_kg}kg × ${prevSet.reps}`;
                          else if (prevSet.reps) prevText = `× ${prevSet.reps}`;
                          else if (prevSet.duration_seconds) prevText = `${prevSet.duration_seconds}s`;
                        }

                        return (
                          <div
                            key={set.id || `set-${exIdx}-${setIdx}`}
                            className={`grid grid-cols-12 gap-2 items-center p-2 rounded-xl border transition-all ${
                              set.is_checked
                                ? 'bg-emerald-50/50 border-emerald-200/70'
                                : 'bg-white border-slate-200/80'
                            }`}
                          >
                            {/* Set Number */}
                            <div className="col-span-2 flex items-center gap-1 font-mono font-extrabold text-slate-700 text-xs">
                              <span>{setIdx + 1}</span>
                              {set.indicator && set.indicator !== 'normal' && (
                                <span className="text-[10px] uppercase px-1 py-0.2 bg-amber-100 text-amber-800 rounded font-bold">
                                  {set.indicator[0]}
                                </span>
                              )}
                            </div>

                            {/* Previous Performance */}
                            <div className="col-span-3 text-center text-xs text-slate-400 font-mono font-medium truncate">
                              {prevText}
                            </div>

                            {/* KG / Value Input */}
                            <div className="col-span-3">
                              <input
                                type="number"
                                step="any"
                                placeholder="0"
                                value={set.weight_kg ?? set.distance_km ?? set.duration_seconds ?? ''}
                                onChange={(e) => handleUpdateSetField(exIdx, setIdx, 'weight_kg', e.target.value)}
                                className="w-full text-center py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-xs font-bold text-slate-900 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-mono"
                              />
                            </div>

                            {/* REPS Input */}
                            <div className="col-span-3">
                              <input
                                type="number"
                                placeholder="0"
                                value={set.reps ?? ''}
                                onChange={(e) => handleUpdateSetField(exIdx, setIdx, 'reps', e.target.value)}
                                className="w-full text-center py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-xs font-bold text-slate-900 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-mono"
                              />
                            </div>

                            {/* Checkmark Completion Button */}
                            <div className="col-span-1 flex justify-center">
                              <button
                                type="button"
                                onClick={() => handleUpdateSetField(exIdx, setIdx, 'is_checked', !set.is_checked)}
                                className={`w-7 h-7 rounded-lg flex items-center justify-center transition-all ${
                                  set.is_checked
                                    ? 'bg-emerald-500 text-white shadow-2xs scale-105'
                                    : 'bg-slate-100 border border-slate-200 text-slate-400 hover:border-slate-300'
                                }`}
                              >
                                <Check className="w-4 h-4 stroke-[3]" />
                              </button>
                            </div>
                          </div>
                        );
                      })}

                      {/* + Agregar Serie Full-Width Pill Button (Screenshots 2 & 4) */}
                      <button
                        type="button"
                        onClick={() => handleAddSet(exIdx)}
                        className="w-full mt-2 py-2.5 bg-slate-100 hover:bg-slate-200/80 text-slate-800 font-bold text-xs rounded-xl flex items-center justify-center gap-1.5 transition-colors border border-slate-200/60"
                      >
                        <Plus className="w-4 h-4" />
                        <span>Agregar Serie</span>
                      </button>
                    </div>
                  </Card>
                );
              })}

              <Button
                type="button"
                variant="secondary"
                icon={Plus}
                className="w-full justify-center py-3.5 rounded-2xl font-bold"
                onClick={() => setIsSelectingExercise(true)}
              >
                Add Exercise
              </Button>
            </div>
          )}
        </>
      )}

      {/* Exercise 3-Dots Context Menu Bottom Sheet (Screenshot 3) */}
      {menuExerciseIndex !== null && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-end sm:items-center justify-center p-0 sm:p-4 cursor-pointer animate-in fade-in duration-150"
          onClick={() => setMenuExerciseIndex(null)}
        >
          <div
            className="w-full max-w-md bg-white rounded-t-3xl sm:rounded-2xl p-5 space-y-2 shadow-2xl border border-slate-200 cursor-default animate-in slide-in-from-bottom duration-200"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Grab Handle Bar */}
            <div className="w-12 h-1 bg-slate-200 rounded-full mx-auto mb-2" />

            {/* Option 1: Reordenar */}
            <button
              type="button"
              onClick={() => {
                setMenuExerciseIndex(null);
                setIsReorderMode(true);
              }}
              className="w-full flex items-center gap-3 p-3.5 text-slate-800 hover:bg-slate-100 rounded-xl text-sm font-bold transition-colors"
            >
              <GripVertical className="w-5 h-5 text-slate-600" />
              <span>Reordenar</span>
            </button>

            {/* Option 2: Reemplazar Ejercicio */}
            <button
              type="button"
              onClick={() => {
                const idx = menuExerciseIndex;
                setMenuExerciseIndex(null);
                setReplaceExerciseIndex(idx);
                setIsSelectingExercise(true);
              }}
              className="w-full flex items-center gap-3 p-3.5 text-slate-800 hover:bg-slate-100 rounded-xl text-sm font-bold transition-colors"
            >
              <RotateCcw className="w-5 h-5 text-slate-600" />
              <span>Reemplazar Ejercicio</span>
            </button>

            {/* Option 3: Agregar a Superserie */}
            <button
              type="button"
              onClick={() => {
                setMenuExerciseIndex(null);
              }}
              className="w-full flex items-center gap-3 p-3.5 text-slate-800 hover:bg-slate-100 rounded-xl text-sm font-bold transition-colors"
            >
              <Plus className="w-5 h-5 text-slate-600" />
              <span>Agregar a Superserie</span>
            </button>

            {/* Option 4: Eliminar Ejercicio */}
            <button
              type="button"
              onClick={() => {
                const idx = menuExerciseIndex;
                setMenuExerciseIndex(null);
                handleRemoveExercise(idx);
              }}
              className="w-full flex items-center gap-3 p-3.5 text-rose-600 hover:bg-rose-50 rounded-xl text-sm font-bold transition-colors pt-3 border-t border-slate-100"
            >
              <Trash2 className="w-5 h-5 text-rose-600" />
              <span>Eliminar Ejercicio</span>
            </button>
          </div>
        </div>
      )}

      {/* Dedicated Reorder View Modal (Screenshot 1) */}
      {isReorderMode && (
        <div className="fixed inset-0 z-50 bg-white flex flex-col p-4 sm:p-6 space-y-5 animate-in fade-in duration-150 overflow-y-auto">
          {/* Reorder Header */}
          <div className="flex items-center justify-between border-b border-slate-100 pb-3">
            <button
              type="button"
              onClick={() => setIsReorderMode(false)}
              className="p-2 text-slate-600 hover:text-slate-900 rounded-xl hover:bg-slate-100"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <h3 className="text-lg font-bold text-slate-900">Reordenar</h3>
            <div className="w-9" />
          </div>

          {/* List of exercises to reorder */}
          <div className="space-y-3 flex-1">
            {workoutExercises.map((item, exIdx) => {
              const exName = item.exercise.name || item.exercise.name_es;
              const initials = getExerciseInitials(exName);
              return (
                <div
                  key={item.id}
                  className="flex items-center justify-between p-3.5 bg-slate-50 border border-slate-200/80 rounded-2xl shadow-2xs"
                >
                  <div className="flex items-center gap-3 min-w-0 flex-1">
                    {/* Red Minus Remove Circle */}
                    <button
                      type="button"
                      onClick={() => handleRemoveExercise(exIdx)}
                      className="w-6 h-6 rounded-full bg-rose-500 text-white flex items-center justify-center shrink-0 hover:bg-rose-600"
                    >
                      <Minus className="w-3.5 h-3.5 stroke-[3]" />
                    </button>

                    {/* Circular Initials Avatar */}
                    <div className="w-9 h-9 rounded-full bg-slate-200 border border-slate-300/60 text-slate-700 font-extrabold text-xs flex items-center justify-center shrink-0 font-mono">
                      {initials}
                    </div>

                    {/* Exercise Name */}
                    <span className="font-bold text-slate-900 text-sm truncate">
                      {exName}
                    </span>
                  </div>

                  {/* Up/Down / Drag Handles */}
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      type="button"
                      disabled={exIdx === 0}
                      onClick={() => handleMoveExercise(exIdx, -1)}
                      className="p-1 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                    >
                      <ArrowUp className="w-4 h-4" />
                    </button>
                    <button
                      type="button"
                      disabled={exIdx === workoutExercises.length - 1}
                      onClick={() => handleMoveExercise(exIdx, 1)}
                      className="p-1 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                    >
                      <ArrowDown className="w-4 h-4" />
                    </button>
                    <GripVertical className="w-5 h-5 text-slate-400 ml-1" />
                  </div>
                </div>
              );
            })}
          </div>

          {/* Bottom Primary Ok Button */}
          <Button
            variant="primary"
            size="lg"
            className="w-full justify-center py-3.5 rounded-2xl font-extrabold text-base bg-indigo-600 hover:bg-indigo-700 text-white shadow-md"
            onClick={() => setIsReorderMode(false)}
          >
            Ok
          </Button>
        </div>
      )}

      {/* Exercise History & Charts Modal */}
      {selectedExerciseForHistory && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4"
          onClick={() => setSelectedExerciseForHistory(null)}
        >
          <div
            className="bg-white rounded-3xl p-5 sm:p-6 max-w-lg w-full max-h-[85vh] overflow-y-auto space-y-4 shadow-2xl border border-slate-200"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-2xl bg-indigo-50 border border-indigo-100 text-indigo-600 flex items-center justify-center font-bold">
                  <Dumbbell className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="font-bold text-slate-900 text-base sm:text-lg">
                    {selectedExerciseForHistory.name || selectedExerciseForHistory.name_es}
                  </h3>
                  <span className="text-xs text-indigo-600 font-semibold capitalize">
                    {getMuscleGroupLabel(selectedExerciseForHistory.muscle_group)}
                  </span>
                </div>
              </div>
              <button
                onClick={() => setSelectedExerciseForHistory(null)}
                className="p-1.5 text-slate-400 hover:text-slate-700 rounded-xl hover:bg-slate-100"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="space-y-4 pt-1">
              <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">
                Performance History Across Workouts
              </h4>
              {(() => {
                const matchedWorkouts = workouts.filter((w) =>
                  (w.workout_sets || []).some((s) => doesSetMatchExercise(s, selectedExerciseForHistory))
                );

                if (matchedWorkouts.length === 0) {
                  return (
                    <div className="text-center py-8 text-slate-400 text-sm">
                      No logged workout history found for this exercise.
                    </div>
                  );
                }

                return (
                  <div className="space-y-3">
                    {matchedWorkouts.slice(0, 10).map((w) => {
                      const sets = (w.workout_sets || []).filter((s) =>
                        doesSetMatchExercise(s, selectedExerciseForHistory)
                      );

                      return (
                        <div key={w.id} className="bg-slate-50 border border-slate-200/80 p-3 rounded-2xl space-y-2">
                          <div className="flex items-center justify-between text-xs font-bold text-slate-700">
                            <span>{w.name}</span>
                            <span className="text-slate-400 font-normal">
                              {new Date(w.started_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
                            </span>
                          </div>

                          <div className="flex flex-wrap gap-1.5">
                            {sets.map((s, idx) => (
                              <span key={idx} className="bg-white border border-slate-200 text-slate-800 font-mono text-[11px] font-bold px-2 py-0.5 rounded-md shadow-2xs">
                                {s.weight_kg ? `${s.weight_kg}kg × ` : ''}{s.reps ? `${s.reps}` : ''}
                              </span>
                            ))}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                );
              })()}
            </div>
          </div>
        </div>
      )}

      {/* Time Edit Modal */}
      {isEditingTimeModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4">
          <Card className="max-w-xs w-full p-5 space-y-4 shadow-xl">
            <CardTitle>Edit Session Duration</CardTitle>
            <form onSubmit={handleApplyCustomTime} className="space-y-4">
              <Input
                label="Duration in Minutes"
                type="number"
                min="0"
                value={editMinutesInput}
                onChange={(e) => setEditMinutesInput(e.target.value)}
                placeholder="e.g. 45"
                autoFocus
              />
              <div className="flex justify-end gap-2">
                <Button variant="ghost" size="sm" onClick={() => setIsEditingTimeModal(false)}>
                  Cancel
                </Button>
                <Button variant="primary" size="sm" type="submit">
                  Save
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}
    </div>
  );
}
