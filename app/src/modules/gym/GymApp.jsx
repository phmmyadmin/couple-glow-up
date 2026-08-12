import React, { useState } from 'react';
import { Dumbbell, List, History, Play } from 'lucide-react';
import { useTranslation } from 'react-i18next';

export default function GymApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [gymTab, setGymTab] = useState('workout'); // 'workout', 'routines', 'exercises', 'history'

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
          <span>Rutinas</span>
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

      {/* Gym Tracker preview card */}
      <div className="health-card text-center space-y-4 py-8">
        <div className="w-16 h-16 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center mx-auto border border-indigo-100 shadow-sm">
          <Dumbbell className="w-8 h-8" />
        </div>
        <div>
          <h3 className="text-base font-bold text-slate-900">Gym Tracker (Estilo Hevy)</h3>
          <p className="text-xs text-slate-500 max-w-xs mx-auto mt-1 font-medium">
            Series polimórficas (peso/reps, tiempo, distancia), supersets, 1RM Epley automático y cálculo de volumen.
          </p>
        </div>
      </div>
    </div>
  );
}
