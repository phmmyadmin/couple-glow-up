import React, { useState } from 'react';
import { Dumbbell, List, History, Play } from 'lucide-react';
import { useTranslation } from 'react-i18next';

export default function GymApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [gymTab, setGymTab] = useState('workout'); // 'workout', 'routines', 'exercises', 'history'

  return (
    <div className="space-y-4">
      {/* Sub navigation */}
      <div className="bg-slate-900/60 backdrop-blur-md rounded-2xl p-3 border border-slate-800/80 shadow-lg">
        <div className="grid grid-cols-4 gap-1 bg-slate-950/60 p-1 rounded-xl border border-slate-800/50">
          <button
            onClick={() => setGymTab('workout')}
            className={`flex items-center justify-center gap-1 py-2 px-2 rounded-lg text-[11px] font-medium transition-all ${
              gymTab === 'workout'
                ? 'bg-gradient-to-r from-indigo-500 to-violet-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <Play className="w-3 h-3" />
            <span>Entrenar</span>
          </button>

          <button
            onClick={() => setGymTab('routines')}
            className={`flex items-center justify-center gap-1 py-2 px-2 rounded-lg text-[11px] font-medium transition-all ${
              gymTab === 'routines'
                ? 'bg-gradient-to-r from-indigo-500 to-violet-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <List className="w-3 h-3" />
            <span>Rutinas</span>
          </button>

          <button
            onClick={() => setGymTab('exercises')}
            className={`flex items-center justify-center gap-1 py-2 px-2 rounded-lg text-[11px] font-medium transition-all ${
              gymTab === 'exercises'
                ? 'bg-gradient-to-r from-indigo-500 to-violet-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <Dumbbell className="w-3 h-3" />
            <span>Ejercicios</span>
          </button>

          <button
            onClick={() => setGymTab('history')}
            className={`flex items-center justify-center gap-1 py-2 px-2 rounded-lg text-[11px] font-medium transition-all ${
              gymTab === 'history'
                ? 'bg-gradient-to-r from-indigo-500 to-violet-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <History className="w-3 h-3" />
            <span>Historial</span>
          </button>
        </div>
      </div>

      {/* Gym Tracker preview card */}
      <div className="bg-slate-900/70 border border-slate-800 rounded-3xl p-6 text-center space-y-4">
        <div className="w-16 h-16 bg-indigo-500/10 text-indigo-400 rounded-2xl flex items-center justify-center mx-auto ring-1 ring-indigo-500/20">
          <Dumbbell className="w-8 h-8" />
        </div>
        <div>
          <h3 className="text-lg font-bold text-white">Gym Tracker (Estilo Hevy)</h3>
          <p className="text-xs text-slate-400 max-w-xs mx-auto mt-1">
            Series polimórficas (peso/reps, tiempo, distancia), supersets, 1RM Epley automático y cálculo de volumen.
          </p>
        </div>
      </div>
    </div>
  );
}
