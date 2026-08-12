import React, { useState } from 'react';
import { Calendar, ChevronLeft, ChevronRight, LayoutDashboard, LineChart, User } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import MacroRing from './components/MacroRing';
import DailyTimeline from './components/DailyTimeline';
import ReportView from './components/ReportView';
import ChatInputBar from './components/ChatInputBar';
import EditDrawer from './components/EditDrawer';
import ProfileView from './components/ProfileView';

export default function FitApp({
  data,
  setData,
  selectedDate,
  setSelectedDate,
  activeProfile,
  profiles,
  onProfileChange,
  onNewProfileClick,
  isLoading,
  setIsLoading,
  loadData,
  dateInputRef,
  setToastMessage,
  addDays,
}) {
  const { t } = useTranslation();
  const [fitTab, setFitTab] = useState('dashboard'); // 'dashboard', 'report', 'profile'

  // Drawer editing state
  const [editingItem, setEditingItem] = useState(null);
  const [editingIndex, setEditingIndex] = useState(null);

  const activeDateData = data?.days?.find((d) => d.date === selectedDate);
  const totalCalories = activeDateData?.intakes?.reduce((sum, item) => sum + (item.calories || 0), 0) || 0;
  const totalProtein = activeDateData?.intakes?.reduce((sum, item) => sum + (item.protein || 0), 0) || 0;
  const totalCarbs = activeDateData?.intakes?.reduce((sum, item) => sum + (item.carbs || 0), 0) || 0;
  const totalFats = activeDateData?.intakes?.reduce((sum, item) => sum + (item.fats || 0), 0) || 0;

  const targetMacros = activeProfile?.target_macros || data?.user_profile?.target_macros || {
    calories: 1950,
    protein: 145,
    carbs: 195,
    fats: 65,
  };

  const handleDateChange = (days) => {
    setSelectedDate(addDays(selectedDate, days));
  };

  return (
    <div className="space-y-4">
      {/* Date & Sub-navigation bar */}
      <div className="bg-slate-900/60 backdrop-blur-md rounded-2xl p-3 border border-slate-800/80 shadow-lg space-y-3">
        {/* Date Selector */}
        <div className="flex items-center justify-between">
          <button
            onClick={() => handleDateChange(-1)}
            className="p-2 rounded-xl bg-slate-800/60 text-slate-300 hover:bg-slate-700 hover:text-white transition-all"
            aria-label="Previous day"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>

          <div className="flex items-center gap-2 cursor-pointer" onClick={() => dateInputRef.current?.showPicker()}>
            <Calendar className="w-4 h-4 text-emerald-400" />
            <span className="text-sm font-semibold text-slate-200">
              {selectedDate}
            </span>
            <input
              ref={dateInputRef}
              type="date"
              value={selectedDate}
              onChange={(e) => setSelectedDate(e.target.value)}
              className="sr-only"
            />
          </div>

          <button
            onClick={() => handleDateChange(1)}
            className="p-2 rounded-xl bg-slate-800/60 text-slate-300 hover:bg-slate-700 hover:text-white transition-all"
            aria-label="Next day"
          >
            <ChevronRight className="w-5 h-5" />
          </button>
        </div>

        {/* Fit Module Sub-Pills */}
        <div className="grid grid-cols-3 gap-1 bg-slate-950/60 p-1 rounded-xl border border-slate-800/50">
          <button
            onClick={() => setFitTab('dashboard')}
            className={`flex items-center justify-center gap-1.5 py-2 px-3 rounded-lg text-xs font-medium transition-all ${
              fitTab === 'dashboard'
                ? 'bg-gradient-to-r from-emerald-500 to-teal-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <LayoutDashboard className="w-3.5 h-3.5" />
            <span>{t('nav.diary', 'Diario')}</span>
          </button>

          <button
            onClick={() => setFitTab('report')}
            className={`flex items-center justify-center gap-1.5 py-2 px-3 rounded-lg text-xs font-medium transition-all ${
              fitTab === 'report'
                ? 'bg-gradient-to-r from-emerald-500 to-teal-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <LineChart className="w-3.5 h-3.5" />
            <span>{t('nav.report', 'Reporte & Progreso')}</span>
          </button>

          <button
            onClick={() => setFitTab('profile')}
            className={`flex items-center justify-center gap-1.5 py-2 px-3 rounded-lg text-xs font-medium transition-all ${
              fitTab === 'profile'
                ? 'bg-gradient-to-r from-emerald-500 to-teal-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <User className="w-3.5 h-3.5" />
            <span>{t('nav.profile', 'Perfil')}</span>
          </button>
        </div>
      </div>

      {/* Tab Content */}
      {fitTab === 'dashboard' && (
        <>
          {/* Macro Rings */}
          <MacroRing
            current={{
              calories: totalCalories,
              protein: totalProtein,
              carbs: totalCarbs,
              fats: totalFats,
            }}
            targets={targetMacros}
          />

          {/* Daily Timeline */}
          <DailyTimeline
            selectedDate={selectedDate}
            intakes={activeDateData?.intakes || []}
            data={data}
            setData={setData}
            activeProfileId={activeProfile?.id}
            setToastMessage={setToastMessage}
            onEditItem={(item, index) => {
              setEditingItem(item);
              setEditingIndex(index);
            }}
          />

          {/* Chat Input Bar */}
          <ChatInputBar
            selectedDate={selectedDate}
            data={data}
            setData={setData}
            activeProfileId={activeProfile?.id}
            isLoading={isLoading}
            setIsLoading={setIsLoading}
            setToastMessage={setToastMessage}
          />
        </>
      )}

      {fitTab === 'report' && (
        <ReportView
          data={data}
          setData={setData}
          selectedDate={selectedDate}
          activeProfile={activeProfile}
          setToastMessage={setToastMessage}
        />
      )}

      {fitTab === 'profile' && (
        <ProfileView
          profiles={profiles}
          activeProfile={activeProfile}
          onProfileChange={onProfileChange}
          onNewProfileClick={onNewProfileClick}
          onSaved={() => loadData(activeProfile?.id)}
          setToastMessage={setToastMessage}
        />
      )}

      {/* Edit Drawer */}
      {editingItem && (
        <EditDrawer
          item={editingItem}
          index={editingIndex}
          selectedDate={selectedDate}
          data={data}
          setData={setData}
          activeProfileId={activeProfile?.id}
          onClose={() => {
            setEditingItem(null);
            setEditingIndex(null);
          }}
          setToastMessage={setToastMessage}
        />
      )}
    </div>
  );
}
