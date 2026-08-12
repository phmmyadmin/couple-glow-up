import React, { useState, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Plus, Heart, Play } from 'lucide-react';

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
      window.removeEventListener('active_workout_updated', updateActiveWorkout);
      window.removeEventListener('storage', updateActiveWorkout);
    };
  }, []);

  useEffect(() => {
    let interval = null;
    if (activeWorkoutData?.startTime) {
      const updateTimer = () => {
        const secs = Math.floor((Date.now() - activeWorkoutData.startTime) / 1000);
        setFloatingSeconds(Math.max(0, secs));
      };
      updateTimer();
      interval = setInterval(updateTimer, 1000);
    }
    return () => {
      if (interval) clearInterval(interval);
    };
  }, [activeWorkoutData]);

  const [data, setData] = useState(null);
  const [selectedDate, setSelectedDate] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [toastMessage, setToastMessage] = useState(null);
  const dateInputRef = useRef(null);

  const [profiles, setProfiles] = useState([]);
  const [activeProfileId, setActiveProfileId] = useState(() => localStorage.getItem('fit_active_profile_id') || null);
  const [isNewProfileModalOpen, setIsNewProfileModalOpen] = useState(false);

  const loadData = async (forceProfileId = null) => {
    let currentProfileId = forceProfileId || activeProfileId;

    if (supabase) {
      let currentProfiles = profiles;
      if (currentProfiles.length === 0) {
        currentProfiles = await fetchProfiles();
        setProfiles(currentProfiles);
      }

      const savedId = localStorage.getItem('fit_active_profile_id');
      if (savedId && currentProfiles.some((p) => p.id === savedId)) {
        currentProfileId = savedId;
      } else if (!currentProfileId && currentProfiles.length > 0) {
        currentProfileId = currentProfiles[0].id;
      }

      if (currentProfileId) {
        setActiveProfileId(currentProfileId);
        localStorage.setItem('fit_active_profile_id', currentProfileId);
      }

      const activeProf = currentProfiles.find((p) => p.id === currentProfileId);
      if (activeProf && activeProf.language) {
        i18n.changeLanguage(activeProf.language);
      } else {
        i18n.changeLanguage('en');
      }

      if (currentProfileId) {
        const supabaseData = await fetchDailyLogsFromSupabase(currentProfileId);
        if (supabaseData) {
          setData(supabaseData);
          if (!selectedDate) {
            setSelectedDate(getLocalDateStr());
          }
          return;
        }
      }
    }

    // Fallback local
    fetch('/food_log.json?t=' + Date.now())
      .then((res) => res.json())
      .then((json) => {
        setData(json);
        if (!selectedDate) {
          setSelectedDate(getLocalDateStr());
        }
      })
      .catch((err) => console.error('Error loading food_log.json', err));
  };

  useEffect(() => {
    i18n.changeLanguage('en');
    loadData();
  }, []);

  const handleProfileChange = (newProfileId) => {
    setActiveProfileId(newProfileId);
    if (newProfileId) {
      localStorage.setItem('fit_active_profile_id', newProfileId);
    }
    const targetProfile = profiles.find((p) => p.id === newProfileId);
    if (targetProfile && targetProfile.language) {
      i18n.changeLanguage(targetProfile.language);
    } else {
      i18n.changeLanguage('en');
    }
    setData(null);
    loadData(newProfileId);
  };

  const activeProfile = profiles.find((p) => p.id === activeProfileId) || profiles[0] || null;

  return (
    <div className="app-container">
      <Toast message={toastMessage} onClose={() => setToastMessage(null)} />

      {/* App Header */}
      <header className="app-header mb-6 sm:mb-8">
        <div>
          <h1 className="app-title flex items-center gap-2">
            <span>Couple Glow Up</span>
            <Heart className="w-5 h-5 text-rose-500 fill-rose-500 inline-block" />
          </h1>

          {profiles.length > 0 && (
            <div className="flex items-center gap-2 mt-2">
              <div className="flex items-center gap-2 bg-white border border-slate-200 rounded-xl px-3 py-1.5 shadow-sm">
                <Avatar profile={activeProfile} size="sm" />
                <select
                  aria-label="Select Active Profile"
                  value={activeProfileId || ''}
                  onChange={(e) => handleProfileChange(e.target.value)}
                  className="bg-transparent text-xs font-bold text-slate-800 focus:outline-none cursor-pointer pr-1"
                >
                  {profiles.map((p) => (
                    <option key={p.id} value={p.id}>
                      {p.name}
                    </option>
                  ))}
                </select>
              </div>

              <Button
                variant="secondary"
                size="sm"
                icon={Plus}
                onClick={() => setIsNewProfileModalOpen(true)}
              >
                New
              </Button>
            </div>
          )}

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
