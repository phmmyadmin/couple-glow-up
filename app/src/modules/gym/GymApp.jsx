import React, { useState, useEffect } from 'react';
import { Dumbbell, List, History, Play } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import ExerciseLibrary from './components/ExerciseLibrary';
import RoutineBuilder from './components/RoutineBuilder';
import LiveWorkoutLogger from './components/LiveWorkoutLogger';
import WorkoutHistory from './components/WorkoutHistory';

import {
  fetchExercisesFromSupabase,
  saveExerciseToSupabase,
  fetchRoutinesFromSupabase,
  saveRoutineToSupabase,
  deleteRoutineFromSupabase,
  fetchWorkoutsFromSupabase,
  saveWorkoutSessionToSupabase,
  fetchPersonalRecordsFromSupabase,
} from './lib/supabase-gym';

export default function GymApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [gymTab, setGymTab] = useState('workout'); // 'workout', 'routines', 'exercises', 'history'

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
      setToastMessage('Ejercicio guardado');
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
      setToastMessage('Rutina guardada');
    }
  };

  const handleDeleteRoutine = async (routineId) => {
    setRoutines((prev) => prev.filter((r) => r.id !== routineId));
    await deleteRoutineFromSupabase(routineId);
    if (setToastMessage) {
      setToastMessage('Rutina eliminada');
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
      setToastMessage('Entrenamiento registrado 🎉');
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

  return (
    <div className="space-y-4">
      {/* Sub-Pills in Fit-Tracker style */}
      <div className="tab-group">
        <button
          onClick={() => setGymTab('workout')}
          className={`tab-item ${gymTab === 'workout' ? 'active' : ''}`}
        >
          <Play className="w-3.5 h-3.5" />
          <span>Entrenar</span>
        </button>

        <button
          onClick={() => setGymTab('routines')}
          className={`tab-item ${gymTab === 'routines' ? 'active' : ''}`}
        >
          <List className="w-3.5 h-3.5" />
          <span>Rutinas ({routines.length})</span>
        </button>

        <button
          onClick={() => setGymTab('exercises')}
          className={`tab-item ${gymTab === 'exercises' ? 'active' : ''}`}
        >
          <Dumbbell className="w-3.5 h-3.5" />
          <span>Ejercicios</span>
        </button>

        <button
          onClick={() => setGymTab('history')}
          className={`tab-item ${gymTab === 'history' ? 'active' : ''}`}
        >
          <History className="w-3.5 h-3.5" />
          <span>Historial</span>
        </button>
      </div>

      {/* Tab Views */}
      {gymTab === 'workout' && (
        <div className="space-y-4">
          <div className="health-card text-center space-y-4 py-8">
            <div className="w-16 h-16 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center mx-auto border border-indigo-100 shadow-sm">
              <Play className="w-8 h-8 fill-indigo-600" />
            </div>
            <div>
              <h3 className="text-base font-bold text-slate-900">Iniciar Entrenamiento Libre</h3>
              <p className="text-xs text-slate-500 max-w-xs mx-auto mt-1 font-medium">
                Registra series en vivo (peso/reps, tiempo, distancia), supersets y cálculo de 1RM Epley.
              </p>
            </div>
            <button
              onClick={() => {
                setActiveRoutine(null);
                setIsLiveSessionActive(true);
              }}
              className="px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white rounded-2xl text-xs font-bold shadow-md transition-all active:scale-95 inline-flex items-center gap-2"
            >
              <Play className="w-4 h-4 fill-white" />
              <span>Empezar Entrenamiento Vacío</span>
            </button>
          </div>

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
        />
      )}
    </div>
  );
}
