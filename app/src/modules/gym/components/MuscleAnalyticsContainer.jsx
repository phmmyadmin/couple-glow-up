import React, { useState } from 'react';
import Card from '../../../shared/ui/Card';
import MuscleBodyHeatmap from './MuscleBodyHeatmap';
import MuscleRadarChart from './MuscleRadarChart';

export default function MuscleAnalyticsContainer({
  workouts = [],
  exercises = [],
  selectedCalendarDay = null,
}) {
  const [activeTab, setActiveTab] = useState('heatmap'); // 'heatmap' | 'radar'

  // Derive targetWorkouts based on selected day or last 7 days default
  const targetWorkouts = React.useMemo(() => {
    if (selectedCalendarDay && Array.isArray(selectedCalendarDay.workouts)) {
      return selectedCalendarDay.workouts;
    } else {
      const sevenDaysAgo = Date.now() - 7 * 24 * 60 * 60 * 1000;
      return workouts.filter((w) => new Date(w.started_at).getTime() >= sevenDaysAgo);
    }
  }, [selectedCalendarDay, workouts]);

  // Derive active muscle list for Heatmap
  const activeMuscles = React.useMemo(() => {
    const muscleSet = new Set();
    targetWorkouts.forEach((w) => {
      (w.workout_sets || []).forEach((s) => {
        const exId = s.exercise_id;
        const matchedEx = exercises.find((e) => e.id === exId) || s.exercises || s.exercise;
        if (matchedEx?.muscle_group) {
          muscleSet.add(matchedEx.muscle_group);
        }
        if (Array.isArray(matchedEx?.other_muscles)) {
          matchedEx.other_muscles.forEach((m) => muscleSet.add(m));
        }
      });
    });
    return Array.from(muscleSet);
  }, [targetWorkouts, exercises]);

  const titleText = selectedCalendarDay
    ? `Muscles (${selectedCalendarDay.dateFormatted})`
    : 'Muscles Worked (Last 7 Days)';

  return (
    <Card className="p-4 sm:p-5 space-y-4 shadow-sm border border-slate-200/90 rounded-2xl bg-white flex flex-col justify-between h-full">
      {/* Header Bar with Segmented Tabs */}
      <div className="flex flex-wrap items-center justify-between gap-2 border-b border-slate-100 pb-3">
        <div className="flex items-center gap-2">
          <span className="w-2.5 h-2.5 rounded-full bg-blue-600 animate-pulse" />
          <h4 className="text-xs sm:text-sm font-extrabold text-slate-900 truncate">{titleText}</h4>
        </div>

        {/* Tab Switcher */}
        <div className="flex bg-slate-100 p-1 rounded-xl gap-1">
          <button
            type="button"
            onClick={() => setActiveTab('heatmap')}
            className={`px-3 py-1 text-xs font-extrabold rounded-lg transition-all cursor-pointer ${
              activeTab === 'heatmap'
                ? 'bg-white text-indigo-700 shadow-2xs'
                : 'text-slate-500 hover:text-slate-800'
            }`}
          >
            🧘 Heatmap
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('radar')}
            className={`px-3 py-1 text-xs font-extrabold rounded-lg transition-all cursor-pointer ${
              activeTab === 'radar'
                ? 'bg-white text-indigo-700 shadow-2xs'
                : 'text-slate-500 hover:text-slate-800'
            }`}
          >
            🕸️ Radar
          </button>
        </div>
      </div>

      {/* Content Body: Heatmap or Radar */}
      <div className="flex-1 flex flex-col justify-center">
        {activeTab === 'heatmap' ? (
          <MuscleBodyHeatmap activeMuscles={activeMuscles} title={titleText} hideHeader />
        ) : (
          <MuscleRadarChart targetWorkouts={targetWorkouts} exercises={exercises} />
        )}
      </div>
    </Card>
  );
}
