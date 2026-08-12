import React, { useState, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Plus, Heart } from 'lucide-react';

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
