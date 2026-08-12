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
} from './lib/supabase-gym';

export default function GymApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [gymTab, setGymTab] = useState('workout');

  const [exercises, setExercises] = useState([]);
  const [routines, setRoutines] = useState([]);
  const [workouts, setWorkouts] = useState([]);
  const [personalRecords, setPersonalRecords] = useState([]);

  // Active workout logging session state
  const [isLiveSessionActive, setIsLiveSessionActive] = useState(false);
  const [activeRoutine, setActiveRoutine] = useState(null);

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
        setWorkouts(dbWorkouts);

        const dbPRs = await fetchPersonalRecordsFromSupabase(activeProfile.id);
        setPersonalRecords(dbPRs);
      }
    }

    loadGymData();
  }, [activeProfile]);

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
    const saved = await saveWorkoutSessionToSupabase(workoutObj, sets);
    if (saved) {
      setWorkouts((prev) => [saved, ...prev]);
    } else {
      const localW = {
        ...workoutObj,
        id: Date.now().toString(),
        workout_sets: sets,
      };
      setWorkouts((prev) => [localW, ...prev]);
    }

    setIsLiveSessionActive(false);
    setActiveRoutine(null);

    if (setToastMessage) {
      setToastMessage('Workout saved 🎉');
    }
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

  if (isLiveSessionActive) {
    return (
      <LiveWorkoutLogger
        exercises={exercises}
        onSaveWorkout={handleSaveWorkout}
        onCancel={() => setIsLiveSessionActive(false)}
        activeProfile={activeProfile}
        initialRoutine={activeRoutine}
      />
    );
  }

  const tabItems = [
    { id: 'workout', label: 'Workout', icon: Play },
    { id: 'routines', label: 'Routines', icon: List, badge: routines.length },
    { id: 'exercises', label: 'Exercises', icon: Dumbbell },
    { id: 'history', label: 'History', icon: History, badge: workouts.length },
  ];

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Gym Sub-Tabs */}
      <Tabs items={tabItems} activeTab={gymTab} onChange={setGymTab} />

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
        />
      )}

      {gymTab === 'exercises' && (
        <ExerciseLibrary
          exercises={exercises}
          onAddCustomExercise={handleAddCustomExercise}
        />
      )}

      {gymTab === 'history' && (
        <WorkoutHistory
          workouts={workouts}
          personalRecords={personalRecords}
          onDeleteWorkout={handleDeleteWorkout}
          onUpdateWorkout={handleUpdateWorkout}
        />
      )}
    </div>
  );
}
