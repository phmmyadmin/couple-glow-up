import React, { useState, useEffect } from 'react';
import {
  Play, Check, Plus, Trash2, Clock, Dumbbell, Award, X, ArrowUp, ArrowDown,
  Timer, Flame, Edit3, Save, Info, MoreVertical, GripVertical, RotateCcw,
  FileText, ChevronDown, User, ArrowLeft, Minus
} from 'lucide-react';
import { calculate1RM, doesSetMatchExercise } from '../lib/supabase-gym';
import { updateRestNotificationBar, clearRestNotificationBar } from '../../../lib/rest-timer-notifications';
import ExerciseLibrary, { getMuscleGroupLabel } from './ExerciseLibrary';
import ExerciseHistoryModal from './ExerciseHistoryModal';
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

export function getLastPerformanceForExercise(targetExercise, workouts = [], catalogExercises = []) {
  if (!targetExercise || !workouts || workouts.length === 0) return null;

  for (const w of workouts) {
    const sets = w.workout_sets || w.sets || [];
    const exSets = sets.filter((s) => doesSetMatchExercise(s, targetExercise, catalogExercises));

    if (exSets.length > 0) {
      console.log('🎯 [LAST PERF FOUND]', { target: targetExercise.name, workoutName: w.name, setsCount: exSets.length, sampleSet: exSets[0] });
      return {
        workoutName: w.name,
        dateStr: new Date(w.started_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric' }),
        sets: exSets,
      };
    }
  }

  console.log('⚠️ [LAST PERF NOT FOUND]', { target: targetExercise.name, workoutsChecked: workouts.length });
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

  // Context Menu & Reorder Mode & Rest Target Edit States
  const [menuExerciseIndex, setMenuExerciseIndex] = useState(null);
  const [isReorderMode, setIsReorderMode] = useState(false);
  const [draggedItemIndex, setDraggedItemIndex] = useState(null);
  const [editingRestForExerciseIndex, setEditingRestForExerciseIndex] = useState(null);

  // Rest Timer State
  const [restTimerSeconds, setRestTimerSeconds] = useState(0);
  const [isRestTimerActive, setIsRestTimerActive] = useState(false);
  const [defaultRestSeconds, setDefaultRestSeconds] = useState(90);

  const restEndTimeRef = React.useRef(
    initialWorkoutState?.restEndTime || null
  );

  // Duration Edit Modal State
  const [isEditingTimeModal, setIsEditingTimeModal] = useState(false);
  const [editMinutesInput, setEditMinutesInput] = useState('');

  // Main session duration & rest timer updater (Timestamp-delta based for mobile screen lock support)
  useEffect(() => {
    const updateTimers = () => {
      // 1. Update session duration timer
      if (startTimeRef.current) {
        setSecondsElapsed(Math.max(0, Math.floor((Date.now() - startTimeRef.current) / 1000)));
      }

      // 2. Update rest countdown timer
      if (isRestTimerActive && restEndTimeRef.current) {
        const remaining = Math.max(0, Math.ceil((restEndTimeRef.current - Date.now()) / 1000));
        setRestTimerSeconds(remaining);

        // Find active exercise name for notification context
        const currentExName = workoutExercises[0]?.exercise?.name || workoutExercises[0]?.exercise?.name_es || '';
        updateRestNotificationBar(remaining, remaining <= 0, currentExName);

        if (remaining <= 0) {
          setIsRestTimerActive(false);
          restEndTimeRef.current = null;
        }
      }
    };

    updateTimers();
    const timer = setInterval(updateTimers, 1000);

    const handleVisibilityOrFocus = () => {
      updateTimers();
    };

    document.addEventListener('visibilitychange', handleVisibilityOrFocus);
    window.addEventListener('focus', handleVisibilityOrFocus);

    return () => {
      clearInterval(timer);
      document.removeEventListener('visibilitychange', handleVisibilityOrFocus);
      window.removeEventListener('focus', handleVisibilityOrFocus);
    };
  }, [isRestTimerActive, workoutExercises]);

  // Auto-persist active workout state to localStorage
  useEffect(() => {
    if (workoutExercises.length > 0 || workoutName) {
      const stateToSave = {
        workoutName,
        startTime: startTimeRef.current,
        secondsElapsed,
        restEndTime: restEndTimeRef.current,
        workoutExercises,
        activeRoutine: initialRoutine,
        lastUpdated: Date.now(),
      };
      localStorage.setItem('couple_glow_up_active_workout', JSON.stringify(stateToSave));
      window.dispatchEvent(new Event('active_workout_updated'));
    }
  }, [workoutName, secondsElapsed, workoutExercises, initialRoutine]);

  const startRestTimer = (seconds = defaultRestSeconds) => {
    if (seconds <= 0) {
      setIsRestTimerActive(false);
      restEndTimeRef.current = null;
      setRestTimerSeconds(0);
      clearRestNotificationBar();
      return;
    }
    restEndTimeRef.current = Date.now() + seconds * 1000;
    setRestTimerSeconds(seconds);
    setIsRestTimerActive(true);
    const currentExName = workoutExercises[0]?.exercise?.name || workoutExercises[0]?.exercise?.name_es || '';
    updateRestNotificationBar(seconds, false, currentExName);
  };

  const handleAdd30sRest = () => {
    if (restEndTimeRef.current) {
      restEndTimeRef.current += 30 * 1000;
    } else {
      restEndTimeRef.current = Date.now() + 30 * 1000;
    }
    const remaining = Math.max(0, Math.ceil((restEndTimeRef.current - Date.now()) / 1000));
    setRestTimerSeconds(remaining);
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
        return sumSet + parseFloat(set.weight_kg) * parseInt(set.reps, 10);
      }
      return sumSet;
    }, 0);
    return sumEx + exVolume;
  }, 0);

  // Calculate total completed sets
  const totalCompletedSets = workoutExercises.reduce((sumEx, item) => {
    return sumEx + (item.sets || []).filter((s) => s.is_checked).length;
  }, 0);

  // Handle Escape key to close open modals/sheets
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') {
        if (selectedExerciseForHistory) {
          setSelectedExerciseForHistory(null);
        } else if (editingRestForExerciseIndex !== null) {
          setEditingRestForExerciseIndex(null);
        } else if (menuExerciseIndex !== null) {
          setMenuExerciseIndex(null);
        } else if (isSelectingExercise) {
          setIsSelectingExercise(false);
        } else if (isReorderMode) {
          setIsReorderMode(false);
        } else if (isEditingTimeModal) {
          setIsEditingTimeModal(false);
        }
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [
    selectedExerciseForHistory,
    editingRestForExerciseIndex,
    menuExerciseIndex,
    isSelectingExercise,
    isReorderMode,
    isEditingTimeModal,
  ]);

  // Pre-fill exercises if started from routine
  useEffect(() => {
    const rawExercises = initialRoutine?.exercises || initialRoutine?.items || [];
    if (initialRoutine && rawExercises.length > 0 && workoutExercises.length === 0 && !initialWorkoutState) {
      setWorkoutName(initialRoutine.name || 'Workout of the Day');

      const formattedEx = rawExercises.map((item, idx) => {
        let matchedEx = null;

        if (item.exercise_id || item.exercise?.id) {
          const exId = item.exercise_id || item.exercise?.id;
          matchedEx = exercises?.find((e) => e.id === exId);
        }

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

        const lastPerf = getLastPerformanceForExercise(finalExercise, workouts, exercises);

        let initialSets = [];
        if (Array.isArray(item.sets) && item.sets.length > 0) {
          initialSets = item.sets.map((s, setIdx) => {
            const prevSet = lastPerf?.sets?.[setIdx] || lastPerf?.sets?.[lastPerf.sets.length - 1];
            const weightVal = (s.weight_kg !== undefined && s.weight_kg !== '' && s.weight_kg !== 0)
              ? s.weight_kg
              : (prevSet?.weight_kg ?? '');
            const repsVal = (s.reps !== undefined && s.reps !== '' && s.reps !== 0)
              ? s.reps
              : (prevSet?.reps ?? '');

            return {
              id: `${Date.now()}-${idx}-${setIdx}`,
              indicator: s.indicator || s.set_type || 'normal',
              weight_kg: weightVal,
              reps: repsVal,
              duration_seconds: s.duration_seconds || prevSet?.duration_seconds || null,
              distance_meters: s.distance_meters || prevSet?.distance_meters || null,
              distance_km: s.distance_km || prevSet?.distance_km || null,
              is_checked: false,
            };
          });
        } else {
          const targetSetsCount = parseInt(item.target_sets, 10) || (lastPerf?.sets.length || 3);
          initialSets = Array.from({ length: targetSetsCount }).map((_, setIdx) => {
            const prevSet = lastPerf?.sets?.[setIdx] || lastPerf?.sets?.[lastPerf.sets.length - 1];
            return {
              id: `${Date.now()}-${idx}-${setIdx}`,
              indicator: 'normal',
              weight_kg: prevSet?.weight_kg ?? '',
              reps: prevSet?.reps ?? '',
              duration_seconds: prevSet?.duration_seconds || null,
              distance_meters: prevSet?.distance_meters || null,
              distance_km: prevSet?.distance_km || null,
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

      console.log('⚡ [LIVE LOGGER] Formatted initialRoutine exercises:', formattedEx);
      setWorkoutExercises(formattedEx);
    }
  }, [initialRoutine, exercises, workouts]);

  // Re-hydrate lastPerformance and pre-fill set values whenever workouts array updates
  useEffect(() => {
    if (!workouts || workouts.length === 0) return;

    setWorkoutExercises((prev) => {
      if (prev.length === 0) return prev;

      console.log('🔄 [LIVE LOGGER] Evaluating re-hydration for active exercises...', { activeCount: prev.length, workoutsCount: workouts.length });

      let hasChanges = false;
      const updated = prev.map((item) => {
        const freshPerf = getLastPerformanceForExercise(item.exercise, workouts, exercises);

        if (!freshPerf || !freshPerf.sets || freshPerf.sets.length === 0) {
          return item;
        }

        const isUnfilled = item.sets.every(
          (s) => !s.is_checked && (s.weight_kg === undefined || s.weight_kg === null || s.weight_kg === '')
        );

        if (!item.lastPerformance || isUnfilled) {
          hasChanges = true;
          const rehydratedSets = freshPerf.sets.map((prevSet, sIdx) => ({
            id: `${Date.now()}-${sIdx}`,
            indicator: prevSet.indicator || 'normal',
            weight_kg: prevSet.weight_kg ?? '',
            reps: prevSet.reps ?? '',
            duration_seconds: prevSet.duration_seconds || null,
            distance_meters: prevSet.distance_meters || null,
            distance_km: prevSet.distance_km || null,
            is_checked: false,
          }));

          console.log('✨ [LIVE LOGGER] Complete re-hydration of sets for exercise:', item.exercise.name, freshPerf);

          return {
            ...item,
            lastPerformance: freshPerf,
            sets: rehydratedSets,
          };
        }

        let setsNeedUpdating = false;
        const updatedSets = item.sets.map((s, setIdx) => {
          const prevSet = freshPerf.sets[setIdx] || freshPerf.sets[freshPerf.sets.length - 1];
          const shouldFillWeight = (s.weight_kg === undefined || s.weight_kg === null || s.weight_kg === '') && (prevSet?.weight_kg !== undefined && prevSet?.weight_kg !== null && prevSet?.weight_kg !== '');
          const shouldFillReps = (s.reps === undefined || s.reps === null || s.reps === '') && (prevSet?.reps !== undefined && prevSet?.reps !== null && prevSet?.reps !== '');

          if (shouldFillWeight || shouldFillReps) {
            setsNeedUpdating = true;
            return {
              ...s,
              weight_kg: shouldFillWeight ? prevSet.weight_kg : s.weight_kg,
              reps: shouldFillReps ? prevSet.reps : s.reps,
            };
          }
          return s;
        });

        if (setsNeedUpdating) {
          hasChanges = true;
          console.log('✨ [LIVE LOGGER] Partial pre-fill for exercise:', item.exercise.name, freshPerf);
          return {
            ...item,
            lastPerformance: freshPerf,
            sets: updatedSets,
          };
        }

        return item;
      });

      return hasChanges ? updated : prev;
    });
  }, [workouts, exercises]);

  // Handle exercise selection or replacement
  const handleAddOrReplaceExercise = (exercise) => {
    if (replaceExerciseIndex !== null) {
      setWorkoutExercises((prev) =>
        prev.map((item, idx) => {
          if (idx === replaceExerciseIndex) {
            const lastPerf = getLastPerformanceForExercise(exercise, workouts, exercises);
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
    const lastPerf = getLastPerformanceForExercise(exercise, workouts, exercises);
    console.log('➕ [LIVE LOGGER] handleAddExercise called:', { name: exercise.name, lastPerfFound: Boolean(lastPerf) });

    let initialSets = [];
    if (lastPerf && lastPerf.sets && lastPerf.sets.length > 0) {
      initialSets = lastPerf.sets.map((prevSet, sIdx) => ({
        id: `${Date.now()}-${sIdx}`,
        indicator: prevSet.indicator || 'normal',
        weight_kg: prevSet.weight_kg ?? '',
        reps: prevSet.reps ?? '',
        duration_seconds: prevSet.duration_seconds || null,
        distance_meters: prevSet.distance_meters || null,
        distance_km: prevSet.distance_km || null,
        is_checked: false,
      }));
    } else {
      initialSets = [
        {
          id: Date.now().toString(),
          indicator: 'normal',
          weight_kg: '',
          reps: '',
          duration_seconds: null,
          distance_meters: null,
          distance_km: null,
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

  // Drag and drop reordering handlers
  const handleDragStart = (e, index) => {
    setDraggedItemIndex(index);
    e.dataTransfer.effectAllowed = 'move';
  };

  const handleDragOver = (e, index) => {
    e.preventDefault();
    e.dataTransfer.dropEffect = 'move';
  };

  const handleDrop = (e, targetIndex) => {
    e.preventDefault();
    if (draggedItemIndex === null || draggedItemIndex === targetIndex) return;

    setWorkoutExercises((prev) => {
      const updated = [...prev];
      const [draggedItem] = updated.splice(draggedItemIndex, 1);
      updated.splice(targetIndex, 0, draggedItem);
      return updated;
    });

    setDraggedItemIndex(null);
  };

  const handleAddSet = (exIndex) => {
    setWorkoutExercises((prev) => {
      return prev.map((item, idx) => {
        if (idx === exIndex) {
          const currentSets = item.sets || [];
          const lastSetInCurrentSession = currentSets[currentSets.length - 1];
          const lastPerf = item.lastPerformance || getLastPerformanceForExercise(item.exercise, workouts, exercises);
          const nextPerfSet = lastPerf?.sets?.[currentSets.length] || lastPerf?.sets?.[lastPerf.sets.length - 1];

          const defaultWeight = (lastSetInCurrentSession?.weight_kg !== undefined && lastSetInCurrentSession?.weight_kg !== '')
            ? lastSetInCurrentSession.weight_kg
            : (nextPerfSet?.weight_kg ?? '');

          const defaultReps = (lastSetInCurrentSession?.reps !== undefined && lastSetInCurrentSession?.reps !== '')
            ? lastSetInCurrentSession.reps
            : (nextPerfSet?.reps ?? '');

          const newSet = {
            id: Date.now().toString(),
            indicator: lastSetInCurrentSession?.indicator || 'normal',
            weight_kg: defaultWeight,
            reps: defaultReps,
            duration_seconds: lastSetInCurrentSession?.duration_seconds || nextPerfSet?.duration_seconds || null,
            distance_km: lastSetInCurrentSession?.distance_km || nextPerfSet?.distance_km || null,
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
              // Auto launch rest timer and auto-fill previous kg/reps if checking set while empty
              if (field === 'is_checked' && value === true) {
                const lastPerf = item.lastPerformance || getLastPerformanceForExercise(item.exercise, workouts, exercises);
                const prevSet = lastPerf?.sets?.[sIdx] || lastPerf?.sets?.[0];

                if ((updated.weight_kg === undefined || updated.weight_kg === null || updated.weight_kg === '') && prevSet?.weight_kg) {
                  updated.weight_kg = prevSet.weight_kg;
                }
                if ((updated.reps === undefined || updated.reps === null || updated.reps === '') && prevSet?.reps) {
                  updated.reps = prevSet.reps;
                }

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
      clearRestNotificationBar();
      localStorage.removeItem('couple_glow_up_active_workout');
      window.dispatchEvent(new Event('active_workout_updated'));
      onCancel();
    }
  };

  const handleApplyCustomTime = (e) => {
    if (e) e.preventDefault();
    const mins = parseInt(editMinutesInput, 10);
    if (!isNaN(mins) && mins >= 0) {
      const newSecs = mins * 60;
      setSecondsElapsed(newSecs);
      startTimeRef.current = Date.now() - newSecs * 1000;
    }
    setIsEditingTimeModal(false);
  };

  const handleFinish = () => {
    clearRestNotificationBar();
    localStorage.removeItem('couple_glow_up_active_workout');
    window.dispatchEvent(new Event('active_workout_updated'));

    const allSets = [];
    workoutExercises.forEach((item) => {
      item.sets.forEach((s) => {
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

  return (
    <div className="space-y-6 sm:space-y-7 pb-12">
      {isSelectingExercise ? (
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <h3 className="text-base font-bold text-slate-900">
              {replaceExerciseIndex !== null ? 'Replace Exercise' : 'Select Exercise'}
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
                  onClick={handleAdd30sRest}
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

          {/* Hevy-Style Live Session Header Card */}
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
                  Finish
                </Button>
              </div>
            </div>

            {/* Sub-Header Metrics Row (Hevy Style) */}
            <div className="grid grid-cols-4 items-center pt-3 border-t border-slate-100 text-xs">
              <div
                onClick={() => {
                  setEditMinutesInput(String(Math.max(1, Math.round(secondsElapsed / 60))));
                  setIsEditingTimeModal(true);
                }}
                className="cursor-pointer group select-none"
                title="Click to edit workout duration"
              >
                <span className="text-[11px] font-medium text-slate-400 flex items-center gap-1">
                  <span>Duration</span>
                  <Edit3 className="w-3 h-3 text-slate-400 group-hover:text-indigo-600 transition-colors" />
                </span>
                <span className="font-mono font-extrabold text-indigo-600 text-sm group-hover:underline">
                  {formatTimer(secondsElapsed)}
                </span>
              </div>

              <div className="text-center">
                <span className="text-[11px] font-medium text-slate-400 block">Volume</span>
                <span className="font-mono font-extrabold text-slate-900 text-sm">{totalLiveVolumeKg.toLocaleString()} kg</span>
              </div>

              <div className="text-center">
                <span className="text-[11px] font-medium text-slate-400 block">Sets</span>
                <span className="font-mono font-extrabold text-slate-900 text-sm">{totalCompletedSets}</span>
              </div>

              <div className="flex justify-end">
                <div className="w-8 h-8 rounded-xl bg-slate-100 border border-slate-200/80 text-slate-600 flex items-center justify-center shrink-0" title="Muscles Targeted">
                  <User className="w-4.5 h-4.5" />
                </div>
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
                const restSecs = item.rest_seconds !== undefined ? item.rest_seconds : 90;

                return (
                  <Card key={item.id} className="p-4 sm:p-5 space-y-4 shadow-xs border-slate-200/90">
                    {/* Hevy Exercise Header Row */}
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex items-start gap-3 flex-1 min-w-0">
                        {/* Circular Initials Avatar Badge */}
                        <div
                          onClick={() => setSelectedExerciseForHistory(item.exercise)}
                          className="w-10 h-10 rounded-full bg-slate-200/80 border border-slate-300/60 text-slate-700 font-extrabold text-xs flex items-center justify-center shrink-0 mt-0.5 shadow-2xs font-mono cursor-pointer hover:bg-indigo-100 hover:text-indigo-700 transition-colors"
                          title="Click to open Exercise History & Analytics"
                        >
                          {initials}
                        </div>

                        <div className="space-y-1 flex-1 min-w-0">
                          <h4
                            onClick={() => setSelectedExerciseForHistory(item.exercise)}
                            className="text-base sm:text-lg font-extrabold text-indigo-600 hover:text-indigo-800 leading-snug break-words cursor-pointer hover:underline"
                            title="Click to open Exercise History & Analytics"
                          >
                            {exName}
                          </h4>

                          {/* Configurable Rest Target Line */}
                          <button
                            type="button"
                            onClick={() => setEditingRestForExerciseIndex(exIdx)}
                            className="flex items-center gap-1.5 text-xs font-bold text-indigo-600 hover:text-indigo-800 transition-colors pt-0.5"
                          >
                            <Timer className="w-3.5 h-3.5" />
                            <span>
                              Rest: {restSecs === 0 ? 'OFF' : `${restSecs}s`}
                            </span>
                          </button>
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

                    {/* Hevy Sets Table */}
                    <div className="space-y-2 pt-2 border-t border-slate-100">
                      <div className="grid grid-cols-12 gap-1 sm:gap-2 text-[11px] font-bold text-slate-400 uppercase tracking-wider px-1">
                        <span className="col-span-2 text-center">SET</span>
                        <span className="col-span-3 text-center">PREVIOUS</span>
                        <span className="col-span-3 text-center">{isDistanceDuration ? 'KM' : isDurationOnly ? 'TIME' : 'KG'}</span>
                        <span className="col-span-2 text-center">{isDistanceDuration ? 'TIME' : isDurationOnly ? '-' : 'REPS'}</span>
                        <span className="col-span-1 text-center">✓</span>
                        <span className="col-span-1 text-center"></span>
                      </div>

                      {item.sets.map((set, setIdx) => {
                        const lastPerf = item.lastPerformance || getLastPerformanceForExercise(item.exercise, workouts, exercises);
                        const prevSet = lastPerf?.sets?.[setIdx] || lastPerf?.sets?.[0];
                        let prevText = '-';
                        if (prevSet) {
                          if (prevSet.weight_kg && prevSet.reps) prevText = `${prevSet.weight_kg}kg × ${prevSet.reps}`;
                          else if (prevSet.reps) prevText = `× ${prevSet.reps}`;
                          else if (prevSet.duration_seconds) prevText = `${prevSet.duration_seconds}s`;
                        }

                        const placeholderWeight = prevSet?.weight_kg !== undefined && prevSet?.weight_kg !== null && prevSet?.weight_kg !== ''
                          ? String(prevSet.weight_kg)
                          : '0';
                        const placeholderReps = prevSet?.reps !== undefined && prevSet?.reps !== null && prevSet?.reps !== ''
                          ? String(prevSet.reps)
                          : '0';

                        return (
                          <div
                            key={set.id || `set-${exIdx}-${setIdx}`}
                            className={`grid grid-cols-12 gap-1 sm:gap-2 items-center p-1.5 sm:p-2 rounded-xl border transition-all ${
                              set.is_checked
                                ? 'bg-emerald-50/50 border-emerald-200/70'
                                : 'bg-white border-slate-200/80'
                            }`}
                          >
                            {/* Explicit Set Type Dropdown & Number (2 cols) */}
                            <div className="col-span-2 flex items-center justify-center">
                              <select
                                value={set.indicator || 'normal'}
                                onChange={(e) => handleUpdateSetField(exIdx, setIdx, 'indicator', e.target.value)}
                                className={`text-[11px] sm:text-xs font-mono font-extrabold px-1 sm:px-2 py-1 rounded-lg border appearance-none text-center cursor-pointer focus:outline-none transition-all shadow-2xs ${
                                  set.indicator === 'warmup'
                                    ? 'bg-amber-100 border-amber-300 text-amber-900 font-extrabold'
                                    : set.indicator === 'drop'
                                    ? 'bg-purple-100 border-purple-300 text-purple-900 font-extrabold'
                                    : set.indicator === 'failure'
                                    ? 'bg-rose-100 border-rose-300 text-rose-900 font-extrabold'
                                    : 'bg-slate-100 border-slate-200 text-slate-700 hover:border-slate-300'
                                }`}
                                title="Set Type: Normal (1, 2, 3), Warmup (W), Drop Set (D), Failure (F)"
                              >
                                <option value="normal">{setIdx + 1}</option>
                                <option value="warmup">W</option>
                                <option value="drop">D</option>
                                <option value="failure">F</option>
                              </select>
                            </div>

                            {/* Previous Performance (3 cols) */}
                            <div className="col-span-3 text-center text-[10px] sm:text-xs text-slate-400 font-mono font-medium truncate">
                              {prevText}
                            </div>

                            {/* KG / Value Input (3 cols) */}
                            <div className="col-span-3">
                              <input
                                type="number"
                                step="any"
                                placeholder={placeholderWeight}
                                value={set.weight_kg ?? set.distance_km ?? set.duration_seconds ?? ''}
                                onFocus={(e) => e.target.select()}
                                onChange={(e) => handleUpdateSetField(exIdx, setIdx, 'weight_kg', e.target.value)}
                                className="w-full text-center py-1 sm:py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-xs font-bold text-slate-900 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-mono placeholder:text-slate-300"
                              />
                            </div>

                            {/* REPS Input (2 cols) */}
                            <div className="col-span-2">
                              <input
                                type="number"
                                placeholder={placeholderReps}
                                value={set.reps ?? ''}
                                onFocus={(e) => e.target.select()}
                                onChange={(e) => handleUpdateSetField(exIdx, setIdx, 'reps', e.target.value)}
                                className="w-full text-center py-1 sm:py-1.5 bg-slate-50 border border-slate-200 rounded-lg text-xs font-bold text-slate-900 focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 font-mono placeholder:text-slate-300"
                              />
                            </div>

                            {/* Checkmark Completion Button (1 col) */}
                            <div className="col-span-1 flex justify-center">
                              <button
                                type="button"
                                onClick={() => handleUpdateSetField(exIdx, setIdx, 'is_checked', !set.is_checked)}
                                className={`w-6 h-6 sm:w-7 sm:h-7 rounded-lg flex items-center justify-center transition-all ${
                                  set.is_checked
                                    ? 'bg-emerald-500 text-white shadow-2xs scale-105'
                                    : 'bg-slate-100 border border-slate-200 text-slate-400 hover:border-slate-300'
                                }`}
                              >
                                <Check className="w-3.5 h-3.5 sm:w-4 sm:h-4 stroke-[3]" />
                              </button>
                            </div>

                            {/* Delete Individual Set Button (1 col) */}
                            <div className="col-span-1 flex justify-center">
                              <button
                                type="button"
                                onClick={() => handleRemoveSet(exIdx, setIdx)}
                                className="p-0.5 text-slate-300 hover:text-rose-600 rounded-lg transition-colors"
                                title="Delete Set"
                              >
                                <Trash2 className="w-3.5 h-3.5" />
                              </button>
                            </div>
                          </div>
                        );
                      })}

                      {/* + Add Set Full-Width Pill Button */}
                      <button
                        type="button"
                        onClick={() => handleAddSet(exIdx)}
                        className="w-full mt-2 py-2.5 bg-slate-100 hover:bg-slate-200/80 text-slate-800 font-bold text-xs rounded-xl flex items-center justify-center gap-1.5 transition-colors border border-slate-200/60"
                      >
                        <Plus className="w-4 h-4" />
                        <span>Add Set</span>
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

      {/* Rest Target Selector Modal */}
      {editingRestForExerciseIndex !== null && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-end sm:items-center justify-center p-0 sm:p-4 cursor-pointer animate-in fade-in duration-150"
          onClick={() => setEditingRestForExerciseIndex(null)}
        >
          <div
            className="w-full max-w-xs bg-white rounded-t-3xl sm:rounded-2xl p-5 space-y-4 shadow-2xl border border-slate-200 cursor-default animate-in slide-in-from-bottom duration-200"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-slate-100 pb-2">
              <h3 className="font-bold text-slate-900 text-sm">Select Rest Target</h3>
              <button onClick={() => setEditingRestForExerciseIndex(null)} className="p-1 text-slate-400 hover:text-slate-700">
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="grid grid-cols-3 gap-2">
              {[0, 30, 60, 90, 120, 150, 180, 240, 300].map((sec) => (
                <button
                  key={sec}
                  type="button"
                  onClick={() => {
                    handleUpdateExerciseRest(editingRestForExerciseIndex, sec);
                    setEditingRestForExerciseIndex(null);
                  }}
                  className={`py-2.5 px-3 rounded-xl text-xs font-bold border transition-all ${
                    (workoutExercises[editingRestForExerciseIndex]?.rest_seconds ?? 90) === sec
                      ? 'bg-indigo-600 text-white border-indigo-600 shadow-xs'
                      : 'bg-slate-50 border-slate-200/80 text-slate-700 hover:bg-slate-100'
                  }`}
                >
                  {sec === 0 ? 'OFF' : `${sec}s`}
                </button>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* Exercise 3-Dots Context Menu Bottom Sheet */}
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

            {/* Option 1: Reorder */}
            <button
              type="button"
              onClick={() => {
                setMenuExerciseIndex(null);
                setIsReorderMode(true);
              }}
              className="w-full flex items-center gap-3 p-3.5 text-slate-800 hover:bg-slate-100 rounded-xl text-sm font-bold transition-colors"
            >
              <GripVertical className="w-5 h-5 text-slate-600" />
              <span>Reorder</span>
            </button>

            {/* Option 2: Replace Exercise */}
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
              <span>Replace Exercise</span>
            </button>

            {/* Option 4: Remove Exercise */}
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
              <span>Remove Exercise</span>
            </button>
          </div>
        </div>
      )}

      {/* Interactive Drag & Drop Reorder View Modal */}
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
            <h3 className="text-lg font-bold text-slate-900">Reorder Exercises</h3>
            <div className="w-9" />
          </div>

          {/* List of exercises to reorder */}
          <div className="space-y-3 flex-1">
            {workoutExercises.map((item, exIdx) => {
              const exName = item.exercise.name || item.exercise.name_es;
              const initials = getExerciseInitials(exName);
              const isBeingDragged = draggedItemIndex === exIdx;

              return (
                <div
                  key={item.id}
                  draggable
                  onDragStart={(e) => handleDragStart(e, exIdx)}
                  onDragOver={(e) => handleDragOver(e, exIdx)}
                  onDrop={(e) => handleDrop(e, exIdx)}
                  className={`flex items-center justify-between p-3.5 bg-slate-50 border border-slate-200/80 rounded-2xl shadow-2xs cursor-grab active:cursor-grabbing transition-all ${
                    isBeingDragged ? 'opacity-40 scale-95 border-indigo-400' : 'hover:border-slate-300'
                  }`}
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
                    <GripVertical className="w-5 h-5 text-slate-400 ml-1 cursor-grab" />
                  </div>
                </div>
              );
            })}
          </div>

          {/* Bottom Primary Done Button */}
          <Button
            variant="primary"
            size="lg"
            className="w-full justify-center py-3.5 rounded-2xl font-extrabold text-base bg-indigo-600 hover:bg-indigo-700 text-white shadow-md"
            onClick={() => setIsReorderMode(false)}
          >
            Done
          </Button>
        </div>
      )}

      {/* Exercise History & Charts Modal */}
      {selectedExerciseForHistory && (
        <ExerciseHistoryModal
          exercise={selectedExerciseForHistory}
          workouts={workouts}
          exercises={exercises}
          onClose={() => setSelectedExerciseForHistory(null)}
        />
      )}

      {/* Time Edit Modal */}
      {isEditingTimeModal && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-xs flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setIsEditingTimeModal(false)}
        >
          <Card
            className="max-w-xs w-full p-5 space-y-4 shadow-xl border border-slate-200 cursor-default rounded-2xl bg-white"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between">
              <CardTitle icon={Clock}>Edit Session Duration</CardTitle>
              <button
                type="button"
                onClick={() => setIsEditingTimeModal(false)}
                className="p-1 text-slate-400 hover:text-slate-600 rounded-lg"
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
                onFocus={(e) => e.target.select()}
                placeholder="e.g. 45"
                autoFocus
                required
                className="font-mono font-bold text-center text-lg"
              />
              <div className="flex justify-end gap-2 pt-1">
                <Button type="button" variant="ghost" size="sm" onClick={() => setIsEditingTimeModal(false)}>
                  Cancel
                </Button>
                <Button variant="primary" size="sm" type="submit" icon={Save}>
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
