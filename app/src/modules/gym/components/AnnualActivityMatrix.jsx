import React, { useMemo } from 'react';
import { Calendar, Flame } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import { generateAnnualActivityMatrix } from '../lib/progressive-overload';

export default function AnnualActivityMatrix({ workouts = [] }) {
  const matrix = useMemo(() => {
    return generateAnnualActivityMatrix(workouts);
  }, [workouts]);

  // Group days into columns of 7 (weeks)
  const weeks = useMemo(() => {
    const res = [];
    let currentWeek = [];
    for (const day of matrix.days) {
      currentWeek.push(day);
      if (currentWeek.length === 7) {
        res.push(currentWeek);
        currentWeek = [];
      }
    }
    if (currentWeek.length > 0) res.push(currentWeek);
    return res;
  }, [matrix.days]);

  const levelColors = [
    'bg-slate-100 border-slate-200/60 dark:bg-slate-800 dark:border-slate-700', // 0
    'bg-indigo-200 border-indigo-300 dark:bg-indigo-900 dark:border-indigo-800', // 1
    'bg-indigo-500 border-indigo-600 text-white', // 2
    'bg-indigo-700 border-indigo-800 text-white', // 3 (high intensity)
  ];

  return (
    <Card className="p-4 sm:p-5 space-y-3.5 shadow-sm">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Flame className="w-4 h-4 text-amber-500" />
          <CardTitle className="text-sm">Consistency Heatmap (Last 52 Weeks)</CardTitle>
        </div>
        <span className="text-xs font-bold text-slate-500">
          <strong>{workouts.length}</strong> total workouts
        </span>
      </div>

      {/* Horizontal Scrollable Grid */}
      <div className="overflow-x-auto pb-2 pt-1">
        <div className="inline-flex gap-1 min-w-full">
          {weeks.map((week, wIdx) => (
            <div key={wIdx} className="flex flex-col gap-1">
              {week.map((day) => (
                <div
                  key={day.date}
                  title={`${day.date}: ${day.count} workout(s) (${Math.round(day.durationSeconds / 60)} min)`}
                  className={`w-3 h-3 rounded-[3px] border transition-transform hover:scale-125 cursor-pointer ${
                    levelColors[day.level] || levelColors[0]
                  }`}
                />
              ))}
            </div>
          ))}
        </div>
      </div>

      {/* Legend */}
      <div className="flex items-center justify-between text-[11px] text-slate-400 font-medium pt-1 border-t border-slate-100">
        <span>Less</span>
        <div className="flex items-center gap-1">
          <div className="w-2.5 h-2.5 rounded-[2px] bg-slate-100 border border-slate-200" />
          <div className="w-2.5 h-2.5 rounded-[2px] bg-indigo-200 border border-indigo-300" />
          <div className="w-2.5 h-2.5 rounded-[2px] bg-indigo-500 border border-indigo-600" />
          <div className="w-2.5 h-2.5 rounded-[2px] bg-indigo-700 border border-indigo-800" />
        </div>
        <span>More Intensity</span>
      </div>
    </Card>
  );
}
