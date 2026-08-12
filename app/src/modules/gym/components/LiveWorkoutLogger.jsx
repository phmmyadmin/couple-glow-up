import React, { useState, useEffect } from 'react';
import { Play, Check, Plus, Trash2, Clock, Dumbbell, Award, X, ArrowUp, ArrowDown, Timer, Flame, Edit3, Save, Info } from 'lucide-react';
import { calculate1RM } from '../lib/supabase-gym';
import ExerciseLibrary from './ExerciseLibrary';
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

export function getLastPerformanceForExercise(targetExercise, workouts = []) {
  if (!targetExercise || !workouts || workouts.length === 0) return null;

  const targetId = targetExercise.id;
  const targetName = (targetExercise.name || targetExercise.name_es || '').toLowerCase().trim();

  for (const w of workouts) {
    const sets = w.workout_sets || [];
    const exSets = sets.filter((s) => {
      const sId = s.exercise_id || s.exercise?.id;
      if (sId && targetId && sId === targetId) return true;
      const sName = (
        s.exercise?.name ||
        s.exercise?.name_es ||
        s.exercises?.name ||
        s.exercises?.name_es ||
        s.exercise_name ||
        ''
      ).toLowerCase().trim();
      return Boolean(sName && targetName && sName === targetName);
    });

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
          exercise_id: finalExercise.id,
          exercise: finalExercise,
          rest_seconds: item.rest_seconds !== undefined ? item.rest_seconds : (finalExercise.exercise_type === 'distance_duration' ? 0 : 90),
          lastPerformance: lastPerf,
          sets: initialSets,
        };
      });

      setWorkoutExercises(formattedEx);
    }
  }, [initialRoutine, exercises, workouts]);

  // Add exercise to active session
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
    <div className="space-y-6 sm:space-y-7">
      {isSelectingExercise ? (
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-base font-bold text-slate-900">Select Exercise for Workout</h3>
            <button
              onClick={() => setIsSelectingExercise(false)}
              aria-label="Close exercise selector"
              className="p-1.5 text-slate-500 hover:text-slate-900 rounded-xl hover:bg-slate-100"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
          <ExerciseLibrary
            exercises={exercises}
            onSelectExercise={handleAddExercise}
            onAddCustomExercise={onAddCustomExercise}
          />
        </div>
      ) : (
        <>
      {/* Rest Timer Floating Banner (Apple Minimalist Glass Card) */}
      {isRestTimerActive && (
        <div className="fixed top-4 left-1/2 -translate-x-1/2 z-50 bg-white/95 backdrop-blur-md text-slate-900 px-5 py-3 rounded-2xl shadow-xl border border-indigo-200/90 flex items-center gap-4 animate-in fade-in slide-in-from-top-4 duration-200">
          <Timer className="w-5 h-5 text-indigo-600 animate-pulse" />
          <div className="text-xs sm:text-sm font-semibold">
            <span className="text-slate-500">Rest Timer: </span>
            <span className="font-mono font-extrabold text-base text-indigo-700">{formatTimer(restTimerSeconds)}</span>
          </div>
          <div className="flex items-center gap-2 border-l border-slate-200 pl-3">
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
              <X className="w-4.5 h-4.5" />
            </button>
          </div>
        </div>
      )}

      {/* Live Session Header Card */}
      <Card className="p-5 sm:p-6 space-y-5 shadow-sm">
        <div className="flex items-center justify-between gap-3">
          <div className="flex items-center gap-2 flex-1">
            <Edit3 className="w-4 h-4 text-indigo-500 shrink-0" />
            <input
              type="text"
              value={workoutName}
              aria-label="Workout name"
              onChange={(e) => setWorkoutName(e.target.value)}
              className="text-lg sm:text-xl font-bold text-slate-900 bg-transparent border-b border-transparent hover:border-slate-300 focus:border-indigo-600 focus:outline-none flex-1 font-heading"
            />
          </div>

          <div className="flex gap-2">
            <Button variant="ghost" size="sm" onClick={handleCancelWorkout}>
              Cancel
            </Button>
            <Button variant="primary" size="sm" icon={Check} onClick={handleFinish}>
              Finish Workout
            </Button>
          </div>
        </div>

        {/* Live Metrics Row */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 pt-3 border-t border-slate-100">
          {/* Duration Badge & Edit Trigger */}
          <div className="bg-slate-50 border border-slate-200/80 p-3 rounded-xl flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Clock className="w-4 h-4 text-indigo-600" />
              <div className="text-xs">
                <span className="text-slate-500 font-medium">Duration: </span>
                <span className="font-mono font-bold text-slate-900">{formatTimer(secondsElapsed)}</span>
              </div>
            </div>
            <button
              type="button"
              onClick={() => {
                setEditMinutesInput(Math.floor(secondsElapsed / 60).toString());
                setIsEditingTimeModal(true);
              }}
              className="p-1 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-white"
              aria-label="Edit duration"
            >
              <Edit3 className="w-3.5 h-3.5" />
            </button>
          </div>

          {/* Configurable Rest Target Selector */}
          <div className="bg-slate-50 border border-slate-200/80 p-3 rounded-xl flex items-center justify-between gap-2">
            <div className="flex items-center gap-1.5 text-xs text-slate-600 font-semibold shrink-0">
              <Timer className="w-4 h-4 text-indigo-600" />
              <span>Rest target:</span>
            </div>
            <div className="flex items-center gap-1 bg-slate-200/60 p-0.5 rounded-lg overflow-x-auto">
              {[30, 60, 90, 120, 180].map((sec) => (
                <button
                  key={sec}
                  type="button"
                  onClick={() => setDefaultRestSeconds(sec)}
                  className={`px-2 py-0.5 text-[11px] font-bold rounded-md transition-all ${
                    defaultRestSeconds === sec
                      ? 'bg-white text-indigo-700 shadow-xs'
                      : 'text-slate-600 hover:text-slate-900'
                  }`}
                >
                  {sec}s
                </button>
              ))}
            </div>
          </div>

          {/* Live Volume Counter */}
          <div className="bg-amber-50 border border-amber-200/80 p-3 rounded-xl flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Flame className="w-4 h-4 text-amber-500" />
              <span className="text-xs text-amber-900 font-medium">Volume:</span>
            </div>
            <span className="font-mono font-extrabold text-sm text-amber-900">
              {totalLiveVolumeKg.toLocaleString()} kg
            </span>
          </div>
        </div>
      </Card>

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
            return (
              <Card key={item.id} className="p-5 sm:p-6 space-y-4 shadow-sm">
                <div className="flex items-center justify-between gap-3">
                  <div className="flex items-center gap-3">
                    {/* Reorder Buttons */}
                    <div className="flex flex-col gap-0.5">
                      <button
                        type="button"
                        disabled={exIdx === 0}
                        onClick={() => handleMoveExercise(exIdx, -1)}
                        className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                        aria-label="Move up"
                      >
                        <ArrowUp className="w-3.5 h-3.5" />
                      </button>
                      <button
                        type="button"
                        disabled={exIdx === workoutExercises.length - 1}
                        onClick={() => handleMoveExercise(exIdx, 1)}
                        className="p-0.5 text-slate-400 hover:text-slate-700 disabled:opacity-30"
                        aria-label="Move down"
                      >
                        <ArrowDown className="w-3.5 h-3.5" />
                      </button>
                    </div>

                    <div className="flex items-center gap-2 flex-wrap min-w-0">
                      <h4 className="text-base font-bold text-slate-900 truncate">
                        {item.exercise.name || item.exercise.name_es}
                      </h4>

                      {/* Last Performance Reference Badge */}
                      {(() => {
                        const lastPerf = item.lastPerformance || getLastPerformanceForExercise(item.exercise, workouts);
                        if (!lastPerf || !lastPerf.sets || lastPerf.sets.length === 0) return null;
                        const s0 = lastPerf.sets[0];
                        let summaryText = '';
                        if (s0.weight_kg) summaryText += `${s0.weight_kg}kg`;
                        if (s0.reps) summaryText += `${summaryText ? ' × ' : ''}${s0.reps}`;
                        if (s0.duration_seconds) summaryText += `${summaryText ? ' • ' : ''}${Math.floor(s0.duration_seconds / 60)}:${String(s0.duration_seconds % 60).padStart(2, '0')}m`;
                        if (s0.distance_meters) summaryText += `${summaryText ? ' • ' : ''}${(s0.distance_meters / 1000).toFixed(1)}km`;

                        return (
                          <span className="text-[11px] font-mono bg-indigo-50 text-indigo-700 font-bold px-2 py-0.5 rounded-md border border-indigo-100/80 flex items-center gap-1 shrink-0" title="Last performance reference">
                            <span>Last: {summaryText} ({lastPerf.dateStr})</span>
                          </span>
                        );
                      })()}

                      {/* Info / History Button */}
                      <button
                        type="button"
                        onClick={() => setSelectedExerciseForHistory(item.exercise)}
                        className="p-1 text-slate-400 hover:text-indigo-600 rounded-lg hover:bg-indigo-50 transition-colors shrink-0"
                        title="Open Exercise History & Analytics"
                      >
                        <Info className="w-4 h-4" />
                      </button>
                    </div>
                  </div>

                  <div className="flex items-center gap-2.5 flex-wrap">
                    <span className="text-xs bg-slate-100 border border-slate-200 px-2.5 py-1 rounded-lg text-slate-600 font-semibold capitalize">
                      {item.exercise.muscle_group}
                    </span>

                    {/* Per-Exercise Rest Selector */}
                    <div className="flex items-center gap-1.5 bg-slate-100 border border-slate-200/80 px-2 py-1 rounded-xl">
                      <Timer className="w-3.5 h-3.5 text-indigo-600 shrink-0" />
                      <span className="text-[11px] font-bold text-slate-600 shrink-0">Rest:</span>
                      <div className="flex items-center gap-1 bg-slate-200/60 p-0.5 rounded-lg overflow-x-auto">
                        {[0, 30, 60, 90, 120, 150, 165, 180].map((sec) => (
                          <button
                            key={sec}
                            type="button"
                            onClick={() => handleUpdateExerciseRest(exIdx, sec)}
                            className={`px-1.5 py-0.5 text-[10px] font-bold rounded transition-all ${
                              (item.rest_seconds !== undefined ? item.rest_seconds : 90) === sec
                                ? 'bg-white text-indigo-700 shadow-2xs font-extrabold'
                                : 'text-slate-500 hover:text-slate-800'
                            }`}
                          >
                            {sec === 0 ? 'Off' : `${sec}s`}
                          </button>
                        ))}
                      </div>
                    </div>

                    <button
                      onClick={() => handleRemoveExercise(exIdx)}
                      aria-label="Remove exercise from workout"
                      className="p-1.5 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>

                {/* Sets Table */}
                {(() => {
                  const exType = item.exercise?.exercise_type || 'weight_reps';
                  const isDistanceDuration = exType === 'distance_duration';
                  const isDurationOnly = exType === 'duration_only';
                  const isRepsOnly = exType === 'reps_only' || exType === 'bodyweight_reps';

                  return (
                    <div className="space-y-2.5 pt-1">
                      <div className="grid grid-cols-12 gap-2 text-xs font-bold text-slate-400 uppercase tracking-wider px-2">
                        <span className="col-span-1 text-center">Set</span>
                        <span className="col-span-2 text-center">Type</span>
                        <span className="col-span-3 text-center">
                          {isDistanceDuration ? 'Km' : isDurationOnly ? 'Time' : 'Weight (kg)'}
                        </span>
                        <span className="col-span-3 text-center">
                          {isDistanceDuration ? 'Time (mm:ss)' : isDurationOnly ? '-' : 'Reps'}
                        </span>
                        <span className="col-span-2 text-center">
                          {isDistanceDuration ? 'Speed' : isDurationOnly ? 'Time' : '1RM'}
                        </span>
                        <span className="col-span-1 text-center">Done</span>
                      </div>

                      {item.sets.map((set, setIdx) => {
                        const est1RM = calculate1RM(set.weight_kg, set.reps);
                        const ind = set.indicator || 'normal';

                        // Calculate speed or formatted duration
                        let speedOrPace = '-';
                        if (isDistanceDuration) {
                          const km = set.distance_meters ? set.distance_meters / 1000 : (set.distance_km ? parseFloat(set.distance_km) : null);
                          const secs = set.duration_seconds ? parseInt(set.duration_seconds, 10) : null;
                          if (km && secs && secs > 0) {
                            const kmh = (km / (secs / 3600)).toFixed(1);
                            speedOrPace = `${kmh} km/h`;
                          } else if (secs) {
                            speedOrPace = formatSecondsToMMSS(secs);
                          }
                        }

                        return (
                          <div
                            key={set.id}
                            className={`grid grid-cols-12 gap-2 items-center p-2 rounded-xl transition-all ${
                              set.is_checked
                                ? 'bg-emerald-50/80 border border-emerald-200'
                                : ind === 'warmup'
                                ? 'bg-amber-50/70 border border-amber-200/80'
                                : ind === 'dropset'
                                ? 'bg-purple-50/70 border border-purple-200/80'
                                : ind === 'failure'
                                ? 'bg-rose-50/70 border border-rose-200/80'
                                : 'bg-slate-50 border border-slate-200/80'
                            }`}
                          >
                            {/* Set Index + Indicator Badge */}
                            <div className="col-span-1 flex items-center justify-center gap-1 font-mono font-bold text-xs">
                              {ind === 'warmup' ? (
                                <span className="bg-amber-500 text-white text-[10px] px-1 rounded font-extrabold" title="Warmup Set">W</span>
                              ) : ind === 'dropset' ? (
                                <span className="bg-purple-600 text-white text-[10px] px-1 rounded font-extrabold" title="Drop Set">D</span>
                              ) : ind === 'failure' ? (
                                <span className="bg-rose-600 text-white text-[10px] px-1 rounded font-extrabold" title="Failure Set">F</span>
                              ) : (
                                <span className="text-slate-600">{setIdx + 1}</span>
                              )}
                            </div>

                            {/* Indicator Selector Buttons */}
                            <div className="col-span-2 flex justify-center">
                              <div className="flex items-center bg-white border border-slate-200 p-0.5 rounded-lg gap-0.5">
                                {[
                                  { key: 'normal', label: 'N', active: 'bg-slate-800 text-white' },
                                  { key: 'warmup', label: 'W', active: 'bg-amber-500 text-white font-bold' },
                                  { key: 'dropset', label: 'D', active: 'bg-purple-600 text-white font-bold' },
                                  { key: 'failure', label: 'F', active: 'bg-rose-600 text-white font-bold' },
                                ].map((b) => (
                                  <button
                                    key={b.key}
                                    type="button"
                                    onClick={() => handleUpdateSetField(exIdx, setIdx, 'indicator', b.key)}
                                    className={`w-4 h-4 text-[9px] rounded flex items-center justify-center transition-all ${
                                      ind === b.key ? b.active : 'text-slate-400 hover:text-slate-700'
                                    }`}
                                    title={`Set indicator: ${b.key}`}
                                  >
                                    {b.label}
                                  </button>
                                ))}
                              </div>
                            </div>

                            {/* Col 3: Weight (kg) OR Distance (km) */}
                            <div className="col-span-3">
                              {isDistanceDuration ? (
                                <input
                                  type="number"
                                  step="any"
                                  placeholder="0.0"
                                  value={set.distance_km !== undefined && set.distance_km !== null ? set.distance_km : set.distance_meters ? (set.distance_meters / 1000) : ''}
                                  onChange={(e) => {
                                    const val = e.target.value === '' ? null : parseFloat(e.target.value);
                                    handleUpdateSetField(exIdx, setIdx, 'distance_km', val);
                                    handleUpdateSetField(exIdx, setIdx, 'distance_meters', val !== null ? val * 1000 : null);
                                  }}
                                  className="w-full text-center py-1.5 text-xs font-mono font-bold bg-white border border-slate-200 rounded-lg focus:outline-none focus:border-indigo-500"
                                />
                              ) : (
                                <input
                                  type="number"
                                  step="any"
                                  placeholder={isRepsOnly ? '-' : '0'}
                                  disabled={isRepsOnly}
                                  value={set.weight_kg ?? ''}
                                  onChange={(e) =>
                                    handleUpdateSetField(
                                      exIdx,
                                      setIdx,
                                      'weight_kg',
                                      parseFloat(e.target.value) || 0
                                    )
                                  }
                                  className="w-full text-center py-1.5 text-xs font-mono font-bold bg-white border border-slate-200 rounded-lg focus:outline-none focus:border-indigo-500"
                                />
                              )}
                            </div>

                            {/* Col 4: Reps OR Time (mm:ss) */}
                            <div className="col-span-3">
                              {isDistanceDuration || isDurationOnly ? (
                                <input
                                  type="text"
                                  placeholder="mm:ss (e.g. 20:00)"
                                  value={set.duration_mmss !== undefined ? set.duration_mmss : formatSecondsToMMSS(set.duration_seconds)}
                                  onChange={(e) => {
                                    const textVal = e.target.value;
                                    const secs = parseMMSSToSeconds(textVal);
                                    handleUpdateSetField(exIdx, setIdx, 'duration_mmss', textVal);
                                    handleUpdateSetField(exIdx, setIdx, 'duration_seconds', secs);
                                  }}
                                  className="w-full text-center py-1.5 text-xs font-mono font-bold bg-white border border-slate-200 rounded-lg focus:outline-none focus:border-indigo-500"
                                />
                              ) : (
                                <input
                                  type="number"
                                  placeholder="10"
                                  value={set.reps ?? ''}
                                  onChange={(e) =>
                                    handleUpdateSetField(
                                      exIdx,
                                      setIdx,
                                      'reps',
                                      parseInt(e.target.value, 10) || 0
                                    )
                                  }
                                  className="w-full text-center py-1.5 text-xs font-mono font-bold bg-white border border-slate-200 rounded-lg focus:outline-none focus:border-indigo-500"
                                />
                              )}
                            </div>

                            {/* Col 5: 1RM / Speed / Time */}
                            <span className="col-span-2 text-center text-xs font-mono text-indigo-700 font-bold">
                              {isDistanceDuration ? speedOrPace : isDurationOnly ? (formatSecondsToMMSS(set.duration_seconds) || '-') : (est1RM > 0 ? `${est1RM}kg` : '-')}
                            </span>

                        <div className="col-span-1 flex justify-center">
                          <button
                            type="button"
                            onClick={() =>
                              handleUpdateSetField(
                                exIdx,
                                setIdx,
                                'is_checked',
                                !set.is_checked
                              )
                            }
                            className={`w-7 h-7 rounded-lg flex items-center justify-center transition-all ${
                              set.is_checked
                                ? 'bg-emerald-600 text-white shadow-xs'
                                : 'bg-white border-2 border-slate-300 text-transparent hover:border-emerald-600'
                            }`}
                          >
                            <Check className="w-4 h-4" />
                          </button>
                        </div>
                      </div>
                    );
                  })}
                </div>
              );
            })()}

                <div className="flex justify-between items-center pt-2">
                  <Button
                    type="button"
                    variant="secondary"
                    size="sm"
                    icon={Plus}
                    onClick={() => handleAddSet(exIdx)}
                  >
                    Add Set
                  </Button>

                  {item.sets.length > 1 && (
                    <button
                      type="button"
                      onClick={() => handleRemoveSet(exIdx, item.sets.length - 1)}
                      className="text-xs font-medium text-slate-400 hover:text-rose-600"
                    >
                      Remove Last Set
                    </button>
                  )}
                </div>
              </Card>
            );
          })}

          <Button
            variant="secondary"
            icon={Plus}
            className="w-full justify-center py-3.5 font-bold"
            onClick={() => setIsSelectingExercise(true)}
          >
            Add Another Exercise
          </Button>
        </div>
      )}

      {/* Edit Duration Modal */}
      {isEditingTimeModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <Card className="max-w-sm w-full p-6 space-y-4 shadow-xl border border-slate-200">
            <div className="flex items-center justify-between">
              <h3 className="text-base font-bold text-slate-900 flex items-center gap-2">
                <Clock className="w-4 h-4 text-indigo-600" />
                <span>Edit Workout Duration</span>
              </h3>
              <button
                onClick={() => setIsEditingTimeModal(null)}
                className="p-1 text-slate-400 hover:text-slate-600"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleApplyCustomTime} className="space-y-4">
              <Input
                label="Duration in Minutes"
                type="number"
                min="0"
                max="600"
                value={editMinutesInput}
                onChange={(e) => setEditMinutesInput(e.target.value)}
                className="font-mono font-bold"
                required
              />

              <div className="flex justify-end gap-2 pt-2">
                <Button variant="ghost" onClick={() => setIsEditingTimeModal(false)}>
                  Cancel
                </Button>
                <Button type="submit" variant="primary" icon={Save}>
                  Apply Time
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}

      {/* Exercise History Modal triggerable directly from Live Workout Logger */}
      {selectedExerciseForHistory && (
        <ExerciseLibrary
          exercises={exercises}
          workouts={workouts}
          initialSelectedHistoryExercise={selectedExerciseForHistory}
          onCloseHistoryModal={() => setSelectedExerciseForHistory(null)}
        />
      )}
        </>
      )}
    </div>
  );
}
