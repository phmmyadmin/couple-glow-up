import React, { useState } from 'react';
import { Calendar, ChevronLeft, ChevronRight, LayoutDashboard, LineChart, User } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import MacroRing from './components/MacroRing';
import DailyTimeline from './components/DailyTimeline';
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
              { id: 'report', label: t('nav.report', 'Report & Progress'), icon: LineChart },
              { id: 'profile', label: t('nav.profile', 'Profile'), icon: User },
            ]}
            activeTab={fitTab}
            onChange={setFitTab}
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
        </div>
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
