import React, { useState, useMemo } from 'react';
import { Flame, Trophy, Calendar, Clock, Info } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import {
  generateAnnualActivityMatrix,
  calculateStreakMetrics,
} from '../lib/progressive-overload';

const MONTH_NAMES = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
const DAY_LABELS = ['', 'Mon', '', 'Wed', '', 'Fri', ''];

export default function AnnualActivityMatrix({ workouts = [] }) {
  const [selectedDay, setSelectedDay] = useState(null);

  const matrix = useMemo(() => {
    return generateAnnualActivityMatrix(workouts);
  }, [workouts]);

  const metrics = useMemo(() => {
    return calculateStreakMetrics(workouts);
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

  // Determine month label positions
  const monthHeaders = useMemo(() => {
    const headers = [];
    let lastMonth = null;

    weeks.forEach((week, wIdx) => {
      const firstDay = week[0];
      if (firstDay) {
        const monthNum = parseInt(firstDay.date.slice(5, 7), 10) - 1;
        if (monthNum !== lastMonth && wIdx % 4 === 0) {
          headers.push({ weekIdx: wIdx, label: MONTH_NAMES[monthNum] });
          lastMonth = monthNum;
        }
      }
    });
    return headers;
  }, [weeks]);

  const levelStyles = [
    { bg: 'bg-slate-100 dark:bg-slate-800 border-slate-200/70', label: 'Rest Day (0)' },
    { bg: 'bg-indigo-300 dark:bg-indigo-900 border-indigo-400', label: 'Light Session (<45 min)' },
    { bg: 'bg-indigo-500 border-indigo-600', label: 'Standard Session (45-75 min)' },
    { bg: 'bg-indigo-700 border-indigo-800', label: 'Intense Session (>75 min)' },
  ];

  return (
    <Card className="p-5 sm:p-6 space-y-4 shadow-sm">
      {/* Header & Quick Streak Summary */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-slate-100 pb-4">
        <div className="flex items-center gap-2.5">
          <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
            <Flame className="w-5 h-5 fill-indigo-600 text-indigo-600" />
          </div>
          <div>
            <CardTitle className="text-base">Workout Consistency (Last 52 Weeks)</CardTitle>
            <p className="text-xs text-slate-500 font-medium">
              Year-round training frequency & session intensity.
            </p>
          </div>
        </div>

        {/* KPI Quick Badges */}
        <div className="flex items-center gap-2 flex-wrap">
          <div className="px-3 py-1 bg-amber-500/10 border border-amber-500/30 rounded-xl text-xs text-amber-900 font-bold flex items-center gap-1.5 shadow-2xs">
            <Flame className="w-3.5 h-3.5 fill-amber-500 text-amber-500" />
            <span>Streak: {metrics.currentStreak} {metrics.currentStreak === 1 ? 'day' : 'days'}</span>
          </div>

          <div className="px-3 py-1 bg-indigo-50 border border-indigo-200/80 rounded-xl text-xs text-indigo-900 font-bold flex items-center gap-1.5 shadow-2xs">
            <Calendar className="w-3.5 h-3.5 text-indigo-600" />
            <span>This week: {metrics.workoutsThisWeek}</span>
          </div>

          <div className="px-3 py-1 bg-slate-100 border border-slate-200 rounded-xl text-xs text-slate-700 font-bold flex items-center gap-1.5 shadow-2xs">
            <Clock className="w-3.5 h-3.5 text-slate-500" />
            <span>{Math.round(metrics.totalMinutesTrained / 60)} hrs total</span>
          </div>
        </div>
      </div>

      {/* Grid Container with Left Weekday Labels and Top Month Headers */}
      <div className="overflow-x-auto pb-2 pt-1">
        <div className="inline-block min-w-full">
          {/* Month Names Row */}
          <div className="flex text-[10px] font-bold text-slate-400 mb-1.5 pl-6 gap-1">
            {weeks.map((_, wIdx) => {
              const header = monthHeaders.find((h) => h.weekIdx === wIdx);
              return (
                <div key={wIdx} className="w-3.5 text-left truncate">
                  {header ? header.label : ''}
                </div>
              );
            })}
          </div>

          {/* Matrix Grid: Left Day Labels + 52 Week Columns */}
          <div className="flex gap-1.5">
            {/* Weekday labels */}
            <div className="flex flex-col gap-1 text-[9px] font-bold text-slate-400 justify-between py-0.5 select-none pr-1">
              <span>Mon</span>
              <span>Wed</span>
              <span>Fri</span>
              <span>Sun</span>
            </div>

            {/* Columns of weeks */}
            <div className="flex gap-1">
              {weeks.map((week, wIdx) => (
                <div key={wIdx} className="flex flex-col gap-1">
                  {week.map((day) => {
                    const isSelected = selectedDay?.date === day.date;
                    const style = levelStyles[day.level] || levelStyles[0];

                    return (
                      <button
                        type="button"
                        key={day.date}
                        onClick={() => setSelectedDay(day)}
                        onMouseEnter={() => setSelectedDay(day)}
                        aria-label={`${day.date}: ${day.count} workouts`}
                        className={`w-3.5 h-3.5 rounded-[3px] border transition-all duration-150 cursor-pointer ${style.bg} ${
                          isSelected
                            ? 'ring-2 ring-indigo-600 scale-125 z-10'
                            : 'hover:scale-115'
                        }`}
                      />
                    );
                  })}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Interactive Day Inspector Banner */}
      <div className="p-3 bg-slate-50 rounded-xl border border-slate-200/80 flex items-center justify-between text-xs text-slate-700">
        <div className="flex items-center gap-2">
          <Info className="w-4 h-4 text-indigo-500 shrink-0" />
          {selectedDay ? (
            <span>
              <strong>{new Date(selectedDay.date + 'T12:00:00Z').toLocaleDateString('en-US', { weekday: 'short', month: 'short', day: 'numeric', year: 'numeric' })}</strong>
              : {selectedDay.count > 0 ? (
                <span className="text-indigo-700 font-bold ml-1">
                  {selectedDay.count} workout ({Math.round(selectedDay.durationSeconds / 60)} min)
                </span>
              ) : (
                <span className="text-slate-400 ml-1">Rest Day</span>
              )}
            </span>
          ) : (
            <span className="text-slate-500 font-medium">Hover or tap on any day square to see details.</span>
          )}
        </div>

        {/* Legend */}
        <div className="flex items-center gap-1.5 text-[11px] text-slate-500 font-medium">
          <span className="text-slate-400">Less</span>
          <div className="flex items-center gap-1">
            <div title="Rest Day" className="w-2.5 h-2.5 rounded-[2px] bg-slate-100 border border-slate-200" />
            <div title="Light (<45m)" className="w-2.5 h-2.5 rounded-[2px] bg-indigo-300 border border-indigo-400" />
            <div title="Standard (45-75m)" className="w-2.5 h-2.5 rounded-[2px] bg-indigo-500 border border-indigo-600" />
            <div title="Intense (>75m)" className="w-2.5 h-2.5 rounded-[2px] bg-indigo-700 border border-indigo-800" />
          </div>
          <span className="text-indigo-700 font-bold">More</span>
        </div>
      </div>
    </Card>
  );
}
