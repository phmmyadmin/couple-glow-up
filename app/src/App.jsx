import React, { useState, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Plus, Heart, Play, Sparkles } from 'lucide-react';

import FitApp from './modules/fit/FitApp';
import ShoppingApp from './modules/shopping/ShoppingApp';
import GymApp from './modules/gym/GymApp';
import FeedApp from './modules/feed/FeedApp';

import BottomNav from './shared/BottomNav';
import Toast from './shared/Toast';
import NotificationPrompt from './shared/NotificationPrompt';
import Avatar from './shared/Avatar';
import NewProfileModal from './modules/fit/components/NewProfileModal';

import Button from './shared/ui/Button';
import {
  supabase,
  fetchDailyLogsFromSupabase,
  fetchProfiles,
  subscribeToIntakes,
  subscribeToDailyLogs,
  subscribeToWeightLogs,
} from './lib/supabase';
import { subscribeToFeedEvents } from './modules/feed/lib/supabase-feed';
import { playRestCompleteSound, getNotificationIcon } from './lib/rest-timer-notifications';
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
  const [data, setData] = useState(null);
  const [selectedDate, setSelectedDate] = useState('');
  const [activeModule, setActiveModule] = useState(() => {
    return localStorage.getItem('glowup_active_module') || 'fit';
  });

  const handleSetActiveModule = (mod) => {
    setActiveModule(mod);
    localStorage.setItem('glowup_active_module', mod);
  };

  const [isLoading, setIsLoading] = useState(false);
  const [toastMessage, setToastMessage] = useState(null);
  const dateInputRef = useRef(null);

  // Profiles State
  const [profiles, setProfiles] = useState([]);
  const [activeProfileId, setActiveProfileId] = useState(() => localStorage.getItem('fit_active_profile_id') || null);
  const [isNewProfileModalOpen, setIsNewProfileModalOpen] = useState(false);

  const loadData = async (forceProfileId = null) => {
    let currentProfileId = forceProfileId || activeProfileId;

    if (supabase) {
      const currentProfiles = await fetchProfiles();
      if (currentProfiles && currentProfiles.length > 0) {
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

  // Realtime Subscriptions for Fit / Nutrition Module
  useEffect(() => {
    if (!activeProfileId) return;

    const unsubIntakes = subscribeToIntakes(async () => {
      if (activeProfileId) {
        const supabaseData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (supabaseData) setData(supabaseData);
      }
    });

    const unsubLogs = subscribeToDailyLogs(async () => {
      if (activeProfileId) {
        const supabaseData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (supabaseData) setData(supabaseData);
      }
    });

    const unsubWeight = subscribeToWeightLogs(async () => {
      if (activeProfileId) {
        const supabaseData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (supabaseData) setData(supabaseData);
      }
    });

    const unsubFeed = subscribeToFeedEvents((payload) => {
      if (payload.eventType === 'INSERT' && payload.new) {
        const newEv = payload.new;
        if (newEv.profile_id && newEv.profile_id !== activeProfileId) {
          const title = newEv.title || 'Couple Glow Up ✨';
          const body = newEv.description || 'New partner update!';

          // 1. Play alert chime
          playRestCompleteSound();

          // 2. Show in-app Toast banner
          setToastMessage(`🔔 ${title}: ${body}`);

          // 3. Trigger OS System Notification
          if ('Notification' in window && Notification.permission === 'granted') {
            const iconUrl = getNotificationIcon();
            if (navigator.serviceWorker) {
              navigator.serviceWorker.ready.then((reg) => {
                reg.showNotification(title, {
                  body,
                  icon: iconUrl,
                  badge: iconUrl,
                  tag: `feed-${newEv.id}`,
                  vibrate: [200, 100, 200],
                  data: { url: './' },
                });
              }).catch(() => {
                new Notification(title, { body, icon: iconUrl });
              });
            } else {
              new Notification(title, { body, icon: iconUrl });
            }
          }
        }
      }
    });

    return () => {
      unsubIntakes();
      unsubLogs();
      unsubWeight();
      unsubFeed();
    };
  }, [activeProfileId]);

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
  const [floatingRestSeconds, setFloatingRestSeconds] = useState(0);

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

        if (activeWorkoutData?.restEndTime) {
          const rem = Math.max(0, Math.ceil((activeWorkoutData.restEndTime - Date.now()) / 1000));
          setFloatingRestSeconds(rem);
        } else {
          setFloatingRestSeconds(0);
        }
      };
      updateTimer();
      interval = setInterval(updateTimer, 1000);
    }
    return () => {
      if (interval) clearInterval(interval);
    };
  }, [activeWorkoutData]);

  return (
    <div className="app-container">
      <Toast message={toastMessage} onClose={() => setToastMessage(null)} />

      {/* Sleek, Compact Header: Logo Left, Profiles Right */}
      <header className="app-header mb-4 sm:mb-5 pt-1 pb-3 border-b border-slate-100 flex items-center justify-between gap-3">
        {/* Left: OpenFit Logo Badge */}
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-2xl bg-gradient-to-r from-indigo-50 via-slate-50 to-blue-50 border border-indigo-100/80 shadow-2xs shrink-0">
          <Sparkles className="w-4 h-4 text-indigo-600" />
          <span className="text-sm font-black bg-gradient-to-r from-indigo-600 to-blue-700 bg-clip-text text-transparent tracking-tight font-heading">
            OpenFit
          </span>
        </div>

        {/* Right: Notification Badge & Profile Selector */}
        <div className="flex items-center gap-2 shrink-0">
          <NotificationPrompt activeProfile={activeProfile} setToastMessage={setToastMessage} />

          {profiles.length > 0 && (
            <div className="flex items-center gap-1.5 bg-slate-50 border border-slate-200/90 rounded-2xl px-2.5 py-1 shadow-2xs shrink-0">
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
              <div className="flex items-center gap-2 text-[11px] font-mono font-bold">
                <span className="text-emerald-400">
                  ⏱️ {Math.floor(floatingSeconds / 60).toString().padStart(2, '0')}:{(floatingSeconds % 60).toString().padStart(2, '0')}
                </span>
                {floatingRestSeconds > 0 && (
                  <span className="bg-indigo-500/30 text-indigo-300 border border-indigo-500/40 px-1.5 py-0.2 rounded-md animate-pulse">
                    Rest: {Math.floor(floatingRestSeconds / 60).toString().padStart(2, '0')}:{(floatingRestSeconds % 60).toString().padStart(2, '0')}
                  </span>
                )}
                <span className="text-slate-400">
                  • {activeWorkoutData.workoutExercises?.length || 0} exercises
                </span>
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
