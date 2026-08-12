import React, { useState, useEffect } from 'react';
import { Dumbbell, List, History, Play } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import ExerciseLibrary from './components/ExerciseLibrary';
import RoutineBuilder from './components/RoutineBuilder';
import LiveWorkoutLogger from './components/LiveWorkoutLogger';
import WorkoutHistory from './components/WorkoutHistory';
import Tabs from '../../shared/ui/Tabs';
import Card from '../../shared/ui/Card';
import Button from '../../shared/ui/Button';

import {
  fetchExercisesFromSupabase,
  saveExerciseToSupabase,
  fetchRoutinesFromSupabase,
  saveRoutineToSupabase,
  deleteRoutineFromSupabase,
  fetchWorkoutsFromSupabase,
  saveWorkoutSessionToSupabase,
  deleteWorkoutFromSupabase,
  updateWorkoutInSupabase,
  fetchPersonalRecordsFromSupabase,
  evaluateAndSavePRs,
} from './lib/supabase-gym';

export default function GymApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [gymTab, setGymTab] = useState(() => {
    return localStorage.getItem('glowup_gym_tab') || 'workout';
  });

  const handleGymTabChange = (tab) => {
    setGymTab(tab);
    localStorage.setItem('glowup_gym_tab', tab);
  };

  const [exercises, setExercises] = useState([]);
  const [routines, setRoutines] = useState([]);
  const [workouts, setWorkouts] = useState([]);
  const [personalRecords, setPersonalRecords] = useState([]);

  // Active workout logging session state
  const [activeWorkoutState, setActiveWorkoutState] = useState(() => {
    try {
      const saved = localStorage.getItem('couple_glow_up_active_workout');
      return saved ? JSON.parse(saved) : null;
    } catch {
      return null;
    }
  });

  const [isLiveSessionActive, setIsLiveSessionActive] = useState(() => {
    try {
      return Boolean(localStorage.getItem('couple_glow_up_active_workout'));
    } catch {
      return false;
    }
  });

  const [activeRoutine, setActiveRoutine] = useState(null);
  const [targetWorkoutId, setTargetWorkoutId] = useState(null);

  // Pending offline workouts queue
  const [pendingOfflineWorkouts, setPendingOfflineWorkouts] = useState(() => {
    try {
      return JSON.parse(localStorage.getItem('couple_glow_up_pending_workouts') || '[]');
    } catch {
      return [];
    }
  });

  // Listen to active workout updates
  useEffect(() => {
    const handleActiveUpdate = () => {
      try {
        const raw = localStorage.getItem('couple_glow_up_active_workout');
        if (raw) {
          setActiveWorkoutState(JSON.parse(raw));
          setIsLiveSessionActive(true);
        } else {
          setActiveWorkoutState(null);
          setIsLiveSessionActive(false);
        }
      } catch {
        setActiveWorkoutState(null);
        setIsLiveSessionActive(false);
      }
    };

    window.addEventListener('active_workout_updated', handleActiveUpdate);
    return () => window.removeEventListener('active_workout_updated', handleActiveUpdate);
  }, []);

  useEffect(() => {
    async function loadGymData() {
      const dbEx = await fetchExercisesFromSupabase();
      if (dbEx && dbEx.length > 0) {
        setExercises(dbEx);
      }

      if (activeProfile?.id) {
        const dbRoutines = await fetchRoutinesFromSupabase(activeProfile.id);
        setRoutines(dbRoutines);

        const dbWorkouts = await fetchWorkoutsFromSupabase(activeProfile.id);
        if (dbWorkouts) {
          // Merge with pending offline workouts if any
          const pending = JSON.parse(localStorage.getItem('couple_glow_up_pending_workouts') || '[]');
          setWorkouts([...pending, ...dbWorkouts]);
        }

        const dbPRs = await fetchPersonalRecordsFromSupabase(activeProfile.id);
        setPersonalRecords(dbPRs);
      }
    }

    loadGymData();
  }, [activeProfile]);

  // Sync offline workouts handler
  const handleSyncOfflineWorkouts = async () => {
    const pending = JSON.parse(localStorage.getItem('couple_glow_up_pending_workouts') || '[]');
    if (pending.length === 0) return;

    let syncedCount = 0;
    const remaining = [];

    for (const item of pending) {
      const { id, is_offline_pending, workout_sets, ...meta } = item;
      const saved = await saveWorkoutSessionToSupabase(meta, workout_sets || []);
      if (saved) {
        syncedCount++;
      } else {
        remaining.push(item);
      }
    }

    localStorage.setItem('couple_glow_up_pending_workouts', JSON.stringify(remaining));
    setPendingOfflineWorkouts(remaining);

    if (activeProfile?.id) {
      const fresh = await fetchWorkoutsFromSupabase(activeProfile.id);
      if (fresh) setWorkouts(fresh);
    }

    if (setToastMessage) {
      setToastMessage(`✅ ${syncedCount} offline workout(s) synced to cloud!`);
    }
  };

  // ── EXERCISE HANDLERS ──
  const handleAddCustomExercise = async (newEx) => {
    const saved = await saveExerciseToSupabase(newEx);
    if (saved) {
      setExercises((prev) => [saved, ...prev]);
    } else {
      const localEx = { ...newEx, id: Date.now().toString() };
      setExercises((prev) => [localEx, ...prev]);
    }
    if (setToastMessage) {
      setToastMessage('Exercise saved');
    }
  };

  // ── ROUTINE HANDLERS ──
  const handleSaveRoutine = async (routineObj) => {
    const payload = {
      ...routineObj,
      profile_id: activeProfile?.id || null,
    };
    const saved = await saveRoutineToSupabase(payload);
    if (saved) {
      setRoutines((prev) => [...prev.filter((r) => r.id !== saved.id), saved]);
    } else {
      const localR = { ...routineObj, id: Date.now().toString() };
      setRoutines((prev) => [...prev, localR]);
    }
    if (setToastMessage) {
      setToastMessage('Routine saved');
    }
  };

  const handleDeleteRoutine = async (routineId) => {
    setRoutines((prev) => prev.filter((r) => r.id !== routineId));
    await deleteRoutineFromSupabase(routineId);
    if (setToastMessage) {
      setToastMessage('Routine deleted');
    }
  };

  const handleStartRoutine = (routine) => {
    setActiveRoutine(routine);
    setIsLiveSessionActive(true);
  };

  // ── WORKOUT HANDLERS ──
  const handleSaveWorkout = async (workoutObj, sets) => {
    localStorage.removeItem('couple_glow_up_active_workout');
    window.dispatchEvent(new Event('active_workout_updated'));

    let saved = null;
    if (navigator.onLine) {
      saved = await saveWorkoutSessionToSupabase(workoutObj, sets);
    }

    if (!saved) {
      // Offline fallback save
      const offlineItem = {
        ...workoutObj,
        id: `offline-${Date.now()}`,
        is_offline_pending: true,
        workout_sets: sets,
      };

      const existing = JSON.parse(localStorage.getItem('couple_glow_up_pending_workouts') || '[]');
      existing.unshift(offlineItem);
      localStorage.setItem('couple_glow_up_pending_workouts', JSON.stringify(existing));
      setPendingOfflineWorkouts(existing);

      setWorkouts((prev) => [offlineItem, ...prev]);

      setIsLiveSessionActive(false);
      setActiveRoutine(null);
      setActiveWorkoutState(null);

      if (setToastMessage) {
        setToastMessage('📶 Connection offline: Workout saved locally! Click Sync when online.');
      }
      return;
    }

    // Standard online save success
    setWorkouts((prev) => [saved, ...prev]);

    // Evaluate PRs
    const newPRs = await evaluateAndSavePRs(activeProfile?.id, sets, saved.id);
    if (newPRs.length > 0) {
      setPersonalRecords((prev) => {
        const updated = [...prev];
        for (const pr of newPRs) {
          const idx = updated.findIndex(
            (p) => p.exercise_id === pr.exercise_id && p.record_type === pr.record_type
          );
          if (idx >= 0) updated[idx] = pr;
          else updated.unshift(pr);
        }
        return updated;
      });
      if (setToastMessage) {
        setToastMessage(`🏆 ${newPRs.length} new PR${newPRs.length > 1 ? 's' : ''}! 🎉 Workout saved!`);
      }
    } else if (setToastMessage) {
      setToastMessage('Workout saved 🎉');
    }

    setIsLiveSessionActive(false);
    setActiveRoutine(null);
    setActiveWorkoutState(null);
  };

  const handleDeleteWorkout = async (workoutId) => {
    setWorkouts((prev) => prev.filter((w) => w.id !== workoutId));
    await deleteWorkoutFromSupabase(workoutId);
    if (setToastMessage) {
      setToastMessage('Workout deleted');
    }
  };

  const handleUpdateWorkout = async (workoutId, updates) => {
    setWorkouts((prev) =>
      prev.map((w) => (w.id === workoutId ? { ...w, ...updates } : w))
    );
    await updateWorkoutInSupabase(workoutId, updates);
    if (setToastMessage) {
      setToastMessage('Workout updated');
    }
  };

  const handleEditExercise = async (updatedEx) => {
    const saved = await saveExerciseToSupabase(updatedEx);
    if (saved) {
      setExercises((prev) => prev.map((e) => (e.id === saved.id ? saved : e)));
    } else {
      setExercises((prev) => prev.map((e) => (e.id === updatedEx.id ? updatedEx : e)));
    }
    if (setToastMessage) {
      setToastMessage('Exercise updated successfully');
    }
  };

  const handleGoToWorkout = (workoutId) => {
    setTargetWorkoutId(workoutId);
    handleGymTabChange('history');
  };

  const tabItems = [
    { id: 'workout', label: 'Workout', icon: Play },
    { id: 'routines', label: 'Routines', icon: List, badge: routines.length },
    { id: 'exercises', label: 'Exercises', icon: Dumbbell },
    { id: 'history', label: 'History', icon: History, badge: workouts.length },
  ];

  if (isLiveSessionActive) {
    return (
      <LiveWorkoutLogger
        exercises={exercises}
        onSaveWorkout={handleSaveWorkout}
        onCancel={() => {
          setIsLiveSessionActive(false);
          setActiveWorkoutState(null);
          localStorage.removeItem('couple_glow_up_active_workout');
          window.dispatchEvent(new Event('active_workout_updated'));
        }}
        activeProfile={activeProfile}
        initialRoutine={activeRoutine}
        initialWorkoutState={activeWorkoutState}
        onAddCustomExercise={handleAddCustomExercise}
      />
    );
  }

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Offline Pending Workouts Alert Banner */}
      {pendingOfflineWorkouts.length > 0 && (
        <div className="bg-amber-500/10 border border-amber-500/30 p-3.5 rounded-2xl flex items-center justify-between gap-3 text-xs sm:text-sm font-semibold text-amber-900 shadow-2xs">
          <div className="flex items-center gap-2 min-w-0">
            <span className="text-base shrink-0">📶</span>
            <span className="truncate">
              You have <strong>{pendingOfflineWorkouts.length}</strong> workout(s) saved locally offline.
            </span>
          </div>
          <Button
            variant="secondary"
            size="sm"
            onClick={handleSyncOfflineWorkouts}
            className="bg-amber-500 hover:bg-amber-600 text-white font-bold border-amber-600 shrink-0"
          >
            Sync to Cloud Now
          </Button>
        </div>
      )}

      {/* Gym Sub-Tabs */}
      <Tabs items={tabItems} activeTab={gymTab} onChange={handleGymTabChange} />

      {/* Tab Views */}
      {gymTab === 'workout' && (
        <div className="space-y-6 sm:space-y-7">
          <Card className="text-center space-y-4 py-10 shadow-sm">
            <div className="w-16 h-16 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center mx-auto border border-indigo-100 shadow-sm">
              <Play className="w-8 h-8 fill-indigo-600" />
            </div>
            <div>
              <h3 className="text-base font-bold text-slate-900">Start Free Workout</h3>
              <p className="text-xs sm:text-sm text-slate-500 max-w-sm mx-auto mt-1 font-medium">
                Log live sets (weight/reps, time, distance), rest timers & live volume.
              </p>
            </div>
            <Button
              size="lg"
              icon={Play}
              onClick={() => {
                setActiveRoutine(null);
                setIsLiveSessionActive(true);
              }}
            >
              Start Empty Workout
            </Button>
          </Card>

          <RoutineBuilder
            routines={routines}
            exercises={exercises}
            onSaveRoutine={handleSaveRoutine}
            onDeleteRoutine={handleDeleteRoutine}
            onStartRoutine={handleStartRoutine}
            onAddCustomExercise={handleAddCustomExercise}
          />
        </div>
      )}

      {gymTab === 'routines' && (
        <RoutineBuilder
          routines={routines}
          exercises={exercises}
          onSaveRoutine={handleSaveRoutine}
          onDeleteRoutine={handleDeleteRoutine}
          onStartRoutine={handleStartRoutine}
          onAddCustomExercise={handleAddCustomExercise}
        />
      )}

      {gymTab === 'exercises' && (
        <ExerciseLibrary
          exercises={exercises}
          workouts={workouts}
          personalRecords={personalRecords}
          onAddCustomExercise={handleAddCustomExercise}
          onEditExercise={handleEditExercise}
          onGoToWorkout={handleGoToWorkout}
        />
      )}

      {gymTab === 'history' && (
        <WorkoutHistory
          workouts={workouts}
          personalRecords={personalRecords}
          onDeleteWorkout={handleDeleteWorkout}
          onUpdateWorkout={handleUpdateWorkout}
          initialExpandedWorkoutId={targetWorkoutId}
        />
      )}
    </div>
  );
}
