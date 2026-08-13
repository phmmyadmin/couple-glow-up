import React, { useState, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Plus, Heart, Play, Sparkles } from 'lucide-react';

import FitApp from './modules/fit/FitApp';
import ShoppingApp from './modules/shopping/ShoppingApp';
import GymApp from './modules/gym/GymApp';
import FeedApp from './modules/feed/FeedApp';

import BottomNav from './shared/BottomNav';
import Toast from './shared/Toast';
import Avatar from './shared/Avatar';
import NewProfileModal from './modules/fit/components/NewProfileModal';

import Button from './shared/ui/Button';
import { supabase, fetchDailyLogsFromSupabase, fetchProfiles } from './lib/supabase';
import './index.css';

const getLocalDateStr = () => {
  const d = new Date();
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};

const addDays = (dateStr, days) => {
  if (!dateStr) return getLocalDateStr();
  const [y, m, d] = dateStr.split('-').map(Number);
  const date = new Date(y, m - 1, d);
  date.setDate(date.getDate() + days);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};

export default function App() {
  const { t, i18n } = useTranslation();
  const [activeModule, setActiveModule] = useState(() => {
    return localStorage.getItem('glowup_active_module') || 'fit';
  });

  const handleSetActiveModule = (mod) => {
    setActiveModule(mod);
    localStorage.setItem('glowup_active_module', mod);
  };

  // Floating Active Workout Bar State
  const [activeWorkoutData, setActiveWorkoutData] = useState(() => {
    try {
      const raw = localStorage.getItem('couple_glow_up_active_workout');
      return raw ? JSON.parse(raw) : null;
    } catch {
      return null;
    }
  });

  const [floatingSeconds, setFloatingSeconds] = useState(0);

  useEffect(() => {
    const updateActiveWorkout = () => {
      try {
        const raw = localStorage.getItem('couple_glow_up_active_workout');
        setActiveWorkoutData(raw ? JSON.parse(raw) : null);
      } catch {
        setActiveWorkoutData(null);
      }
    };

    window.addEventListener('active_workout_updated', updateActiveWorkout);
    window.addEventListener('storage', updateActiveWorkout);
    return () => {
      if (interval) clearInterval(interval);
    };
  }, [activeWorkoutData]);

  return (
    <div className="app-container">
      <Toast message={toastMessage} onClose={() => setToastMessage(null)} />

      {/* Sleek, Compact & Cute Header */}
      <header className="app-header mb-4 sm:mb-5 pt-1 pb-3 border-b border-slate-100 flex items-center justify-between gap-3">
        {/* Left: Title & Profile Selector */}
        <div className="flex flex-wrap items-center gap-2.5 sm:gap-3">
          <h1 className="text-base sm:text-lg font-black text-slate-900 tracking-tight flex items-center gap-1.5 font-heading">
            <span>Couple Glow Up</span>
            <span className="inline-flex items-center justify-center w-5 h-5 rounded-full bg-rose-50 border border-rose-200 text-rose-500 shadow-2xs">
              <Heart className="w-3 h-3 fill-rose-500 text-rose-500 animate-pulse" />
            </span>
          </h1>

          {profiles.length > 0 && (
            <div className="flex items-center gap-1.5 bg-slate-50 border border-slate-200/90 rounded-2xl px-2.5 py-1 shadow-2xs">
              <Avatar profile={activeProfile} size="xs" />
              <select
                aria-label="Select Active Profile"
                value={activeProfileId || ''}
                onChange={(e) => handleProfileChange(e.target.value)}
                className="bg-transparent text-xs font-extrabold text-slate-800 focus:outline-none cursor-pointer pr-1"
              >
                {profiles.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.name}
                  </option>
                ))}
              </select>

              <button
                type="button"
                onClick={() => setIsNewProfileModalOpen(true)}
                className="p-1 rounded-lg text-indigo-600 hover:bg-indigo-50 font-bold text-xs flex items-center gap-0.5 transition-colors cursor-pointer"
                title="Add new profile"
              >
                <Plus className="w-3.5 h-3.5" />
              </button>
            </div>
          )}
        </div>

        {/* Right: Cute Compact App Logo Badge */}
        <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-2xl bg-gradient-to-r from-indigo-50 via-rose-50 to-amber-50 border border-indigo-100/80 shadow-2xs shrink-0">
          <Sparkles className="w-3.5 h-3.5 text-indigo-500" />
          <span className="text-xs font-black bg-gradient-to-r from-indigo-600 to-rose-600 bg-clip-text text-transparent">
            GlowUp ✨
          </span>
        </div>
      </header>

      {/* Main Content Area */}
      <main className="mt-6 mb-8 space-y-6 sm:space-y-7">
        {activeModule === 'feed' && (
          <FeedApp
            activeProfile={activeProfile}
            profiles={profiles}
            setToastMessage={setToastMessage}
          />
        )}

        {activeModule === 'fit' && (
          <FitApp
            data={data}
            setData={setData}
            selectedDate={selectedDate}
            setSelectedDate={setSelectedDate}
            activeProfile={activeProfile}
            profiles={profiles}
            onProfileChange={handleProfileChange}
            onNewProfileClick={() => setIsNewProfileModalOpen(true)}
            isLoading={isLoading}
            setIsLoading={setIsLoading}
            loadData={loadData}
            dateInputRef={dateInputRef}
            setToastMessage={setToastMessage}
            addDays={addDays}
          />
        )}

        {activeModule === 'gym' && (
          <GymApp
            activeProfile={activeProfile}
            profiles={profiles}
            setToastMessage={setToastMessage}
          />
        )}

        {activeModule === 'shopping' && (
          <ShoppingApp
            activeProfile={activeProfile}
            profiles={profiles}
            setToastMessage={setToastMessage}
          />
        )}
      </main>

      {/* Floating Active Workout Bar when navigating to other modules */}
      {activeModule !== 'gym' && activeWorkoutData && (
        <div className="fixed bottom-20 left-1/2 -translate-x-1/2 z-40 w-[92%] max-w-md bg-slate-900/95 text-white backdrop-blur-lg border border-slate-700/80 shadow-2xl p-3 rounded-2xl flex items-center justify-between gap-3 animate-in fade-in slide-in-from-bottom-4 duration-200">
          <div className="flex items-center gap-3 min-w-0">
            <div className="relative flex items-center justify-center shrink-0">
              <span className="animate-ping absolute inline-flex h-3.5 w-3.5 rounded-full bg-emerald-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-3 w-3 bg-emerald-500"></span>
            </div>
            <div className="min-w-0">
              <div className="text-xs font-bold truncate text-slate-100">
                {activeWorkoutData.workoutName || 'Active Workout'}
              </div>
              <div className="text-[11px] font-mono font-bold text-emerald-400">
                ⏱️ {Math.floor(floatingSeconds / 60).toString().padStart(2, '0')}:{(floatingSeconds % 60).toString().padStart(2, '0')} • {activeWorkoutData.workoutExercises?.length || 0} exercises
              </div>
            </div>
          </div>

          <button
            type="button"
            onClick={() => handleSetActiveModule('gym')}
            className="px-3.5 py-1.5 bg-indigo-600 hover:bg-indigo-500 text-white text-xs font-bold rounded-xl transition-all flex items-center gap-1.5 shrink-0 shadow-sm cursor-pointer"
          >
            <Play className="w-3.5 h-3.5 fill-current" />
            <span>Resume</span>
          </button>
        </div>
      )}

      {/* Global Bottom Navigation */}
      <BottomNav activeModule={activeModule} setActiveModule={handleSetActiveModule} />

      {/* New Profile Modal */}
      <NewProfileModal
        isOpen={isNewProfileModalOpen}
        onClose={() => setIsNewProfileModalOpen(false)}
        onCreated={(newProfile) => {
          setProfiles((prev) => [...prev, newProfile]);
          handleProfileChange(newProfile.id);
        }}
        setToastMessage={setToastMessage}
      />
    </div>
  );
}
