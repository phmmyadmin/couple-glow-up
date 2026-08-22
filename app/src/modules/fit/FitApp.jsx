import React, { useState } from 'react';
import { Calendar, ChevronLeft, ChevronRight, LayoutDashboard, LineChart, User, UtensilsCrossed } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import MacroRing from './components/MacroRing';
import DailyTimeline from './components/DailyTimeline';
import DishesView from './components/DishesView';
import ReportView from './components/ReportView';
import ChatInputBar from './components/ChatInputBar';
import EditDrawer from './components/EditDrawer';
import ProfileView from './components/ProfileView';
import Tabs from '../../shared/ui/Tabs';

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
  const [fitTab, setFitTab] = useState(() => {
    return localStorage.getItem('glowup_fit_tab') || 'dashboard';
  });

  const handleFitTabChange = (tab) => {
    setFitTab(tab);
    localStorage.setItem('glowup_fit_tab', tab);
  };

  // Drawer editing state
  const [editingItem, setEditingItem] = useState(null);
  const [editingIndex, setEditingIndex] = useState(null);

  const daysList = data?.days || data?.dailyLogs || [];
  const getLocalDateStr = () => {
    const d = new Date();
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  };
  const todayStr = getLocalDateStr();
  const activeDateData = daysList.find((d) => d.date === selectedDate) || null;

  const totalCalories =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.calories ?? item.calories ?? 0),
      0
    ) || activeDateData?.dailyTotals?.calories || 0;

  const totalProtein =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.protein ?? item.protein ?? 0),
      0
    ) || activeDateData?.dailyTotals?.protein || 0;

  const totalCarbs =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.carbs ?? item.carbs ?? 0),
      0
    ) || activeDateData?.dailyTotals?.carbs || 0;

  const totalFats =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.fats ?? item.fats ?? 0),
      0
    ) || activeDateData?.dailyTotals?.fats || 0;

  const totalFiber =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.fiber ?? item.fiber ?? 0),
      0
    ) || activeDateData?.dailyTotals?.fiber || 0;

  const totalSugar =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.sugar ?? item.sugar ?? 0),
      0
    ) || activeDateData?.dailyTotals?.sugar || 0;

  const totalSodium =
    activeDateData?.intakes?.reduce(
      (sum, item) => sum + (item.macros?.sodium ?? item.sodium ?? 0),
      0
    ) || activeDateData?.dailyTotals?.sodium || 0;

  const targetMacros =
    activeProfile?.target_macros ||
    data?.userProfile?.targetMacros ||
    data?.user_profile?.target_macros || {
      calories: 1950,
      protein: 145,
      carbs: 195,
      fats: 65,
    };

  const handleDateChange = (days) => {
    setSelectedDate(addDays(selectedDate, days));
  };

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Date & Sub-navigation bar */}
      <div className="flex flex-col sm:flex-row items-center justify-between gap-4 mb-3">
        {/* Date Selector */}
        <div className="date-selector w-full sm:w-auto justify-between sm:justify-start">
          <button
            className="nav-btn"
            onClick={() => handleDateChange(-1)}
            aria-label="Previous day"
          >
            <ChevronLeft size={18} />
          </button>

          <div className="flex items-center gap-2">
            <div
              className="flex items-center gap-2 cursor-pointer"
              onClick={() => dateInputRef.current?.showPicker()}
            >
              <Calendar size={18} color="var(--color-indigo)" />
              <span>{selectedDate}</span>
              <input
                ref={dateInputRef}
                type="date"
                value={selectedDate}
                onChange={(e) => setSelectedDate(e.target.value)}
                className="sr-only"
              />
            </div>

            <button
              onClick={() => setSelectedDate(todayStr)}
              disabled={selectedDate === todayStr}
              className={`text-xs font-bold px-2.5 py-1 rounded-lg transition-all ${
                selectedDate === todayStr
                  ? 'bg-slate-100 text-slate-400 cursor-not-allowed border border-slate-200/80'
                  : 'bg-indigo-600 text-white hover:bg-indigo-700 shadow-2xs'
              }`}
            >
              Today
            </button>
          </div>

          <button
            className="nav-btn"
            onClick={() => handleDateChange(1)}
            aria-label="Next day"
          >
            <ChevronRight size={18} />
          </button>
        </div>

        {/* Sub Tabs */}
        <div className="flex-1 w-full">
          <Tabs
            items={[
              { id: 'dashboard', label: t('nav.diary', 'Diary'), icon: LayoutDashboard },
              { id: 'dishes', label: t('nav.dishes', 'Dishes'), icon: UtensilsCrossed },
              { id: 'report', label: t('nav.report', 'Report & Progress'), icon: LineChart },
              { id: 'profile', label: t('nav.profile', 'Profile'), icon: User },
            ]}
            activeTab={fitTab}
            onChange={handleFitTabChange}
          />
        </div>
      </div>

      {/* Tab Content */}
      {fitTab === 'dashboard' && (
        <div className="space-y-6 sm:space-y-7">
          {/* Macro Rings */}
          <MacroRing
            current={{
              calories: totalCalories,
              protein: totalProtein,
              carbs: totalCarbs,
              fats: totalFats,
              fiber: totalFiber,
              sugar: totalSugar,
              sodium: totalSodium,
            }}
            targets={{
              ...targetMacros,
              fiber: targetMacros.fiber || 30,
              sugar: targetMacros.sugar || 50,
              sodium: targetMacros.sodium || 2300,
            }}
          />

          {/* Chat Input Bar - Fixed right below Macro Ring */}
          <ChatInputBar
            selectedDate={selectedDate}
            data={data}
            setData={setData}
            activeProfileId={activeProfile?.id}
            isLoading={isLoading}
            setIsLoading={setIsLoading}
            setToastMessage={setToastMessage}
          />

          {/* Daily Timeline */}
          <DailyTimeline
            selectedDate={selectedDate}
            intakes={activeDateData?.intakes || []}
            data={data}
            setData={setData}
            activeProfile={activeProfile}
            activeProfileId={activeProfile?.id}
            profiles={profiles}
            setToastMessage={setToastMessage}
            onEditItem={(item, index) => {
              setEditingItem(item);
              setEditingIndex(index);
            }}
          />
        </div>
      )}

      {fitTab === 'dishes' && (
        <DishesView
          selectedDate={selectedDate}
          data={data}
          setData={setData}
          activeProfileId={activeProfile?.id}
          setToastMessage={setToastMessage}
        />
      )}

      {fitTab === 'report' && (
        <ReportView
          data={data}
          setData={setData}
          selectedDate={selectedDate}
          activeProfile={activeProfile}
          activeProfileId={activeProfile?.id}
          loadData={loadData}
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
