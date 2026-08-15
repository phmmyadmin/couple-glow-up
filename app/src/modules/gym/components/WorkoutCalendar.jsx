import React, { useState } from 'react';
import { ChevronLeft, ChevronRight, Calendar as CalendarIcon, ExternalLink, X } from 'lucide-react';
import Card from '../../../shared/ui/Card';

export default function WorkoutCalendar({
  workouts = [],
  onSelectWorkout,
  onDaySelect,
  selectedDay,
}) {
  const [currentDate, setCurrentDate] = useState(() => new Date());

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();

  const monthName = currentDate.toLocaleDateString('en-US', {
    month: 'short',
    year: 'numeric',
  });

  const handlePrevMonth = () => {
    setCurrentDate(new Date(year, month - 1, 1));
    if (onDaySelect) onDaySelect(null);
  };

  const handleNextMonth = () => {
    setCurrentDate(new Date(year, month + 1, 1));
    if (onDaySelect) onDaySelect(null);
  };

  // Generate 7-column Monday-to-Sunday grid
  const firstDayOfMonth = new Date(year, month, 1);
  let startDayOfWeek = firstDayOfMonth.getDay() - 1; // 0 = Mon, 6 = Sun
  if (startDayOfWeek === -1) startDayOfWeek = 6;

  const daysInCurrentMonth = new Date(year, month + 1, 0).getDate();
  const daysInPrevMonth = new Date(year, month, 0).getDate();

  const calendarGrid = [];

  // Previous month trailing days
  for (let i = startDayOfWeek - 1; i >= 0; i--) {
    const dayNum = daysInPrevMonth - i;
    calendarGrid.push({
      day: dayNum,
      isCurrentMonth: false,
      dateObj: new Date(year, month - 1, dayNum),
    });
  }

  // Current month days
  for (let d = 1; d <= daysInCurrentMonth; d++) {
    calendarGrid.push({
      day: d,
      isCurrentMonth: true,
      dateObj: new Date(year, month, d),
    });
  }

  // Next month leading days (fill up to complete weeks)
  const totalCells = Math.ceil(calendarGrid.length / 7) * 7;
  const remainingCells = totalCells - calendarGrid.length;
  for (let n = 1; n <= remainingCells; n++) {
    calendarGrid.push({
      day: n,
      isCurrentMonth: false,
      dateObj: new Date(year, month + 1, n),
    });
  }

  // Check if date is today
  const isToday = (dateObj) => {
    const today = new Date();
    return (
      dateObj.getFullYear() === today.getFullYear() &&
      dateObj.getMonth() === today.getMonth() &&
      dateObj.getDate() === today.getDate()
    );
  };

  // Map workouts by YYYY-MM-DD
  const getWorkoutsForDate = (dateObj) => {
    const dateStr = `${dateObj.getFullYear()}-${dateObj.getMonth()}-${dateObj.getDate()}`;
    return workouts.filter((w) => {
      const wDate = new Date(w.started_at);
      const wDateStr = `${wDate.getFullYear()}-${wDate.getMonth()}-${wDate.getDate()}`;
      return wDateStr === dateStr;
    });
  };

  const handleDayClick = (cell) => {
    const dayWorkouts = getWorkoutsForDate(cell.dateObj);
    if (dayWorkouts.length > 0) {
      if (selectedDay?.dateStr === cell.dateObj.toDateString()) {
        if (onDaySelect) onDaySelect(null);
      } else {
        const payload = {
          dateObj: cell.dateObj,
          dateStr: cell.dateObj.toDateString(),
          dateFormatted: cell.dateObj.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }),
          workouts: dayWorkouts,
        };
        if (onDaySelect) onDaySelect(payload);
      }
    } else {
      if (onDaySelect) onDaySelect(null);
    }
  };

  const DAY_LABELS = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  return (
    <Card className="p-3.5 sm:p-4 space-y-2.5 shadow-sm border border-slate-200/90 rounded-2xl bg-white flex flex-col justify-between">
      <div>
        {/* Compact Header Row */}
        <div className="flex items-center justify-between pb-1">
          <h3 className="text-sm font-extrabold text-slate-900 flex items-center gap-1.5">
            <CalendarIcon className="w-4 h-4 text-blue-600" />
            <span>Calendar</span>
          </h3>

          {/* Month Navigation */}
          <div className="flex items-center gap-1">
            <button
              type="button"
              onClick={handlePrevMonth}
              className="p-1 text-slate-400 hover:text-slate-900 rounded-lg hover:bg-slate-100 transition-colors"
              aria-label="Previous Month"
            >
              <ChevronLeft className="w-4 h-4" />
            </button>

            <span className="text-xs font-bold text-slate-800 font-sans min-w-[85px] text-center capitalize">
              {monthName}
            </span>

            <button
              type="button"
              onClick={handleNextMonth}
              className="p-1 text-slate-400 hover:text-slate-900 rounded-lg hover:bg-slate-100 transition-colors"
              aria-label="Next Month"
            >
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Days of Week Header Row */}
        <div className="grid grid-cols-7 text-center border-b border-slate-100 pb-1.5 pt-1">
          {DAY_LABELS.map((dayLabel, idx) => (
            <span key={idx} className="text-[11px] font-extrabold text-slate-400">
              {dayLabel}
            </span>
          ))}
        </div>

        {/* Compact Calendar Grid */}
        <div className="grid grid-cols-7 gap-y-1 text-center items-center pt-1.5">
          {calendarGrid.map((cell, idx) => {
            const dayWorkouts = getWorkoutsForDate(cell.dateObj);
            const hasWorkout = dayWorkouts.length > 0;
            const today = isToday(cell.dateObj);
            const isSelected = selectedDay?.dateStr === cell.dateObj.toDateString();

            return (
              <div key={idx} className="flex flex-col items-center justify-center p-0.5">
                <button
                  type="button"
                  onClick={() => handleDayClick(cell)}
                  disabled={!cell.isCurrentMonth && !hasWorkout}
                  className={`w-7 h-7 sm:w-8 sm:h-8 rounded-full text-xs font-bold flex items-center justify-center transition-all ${
                    hasWorkout
                      ? 'bg-blue-600 text-white font-extrabold shadow-2xs hover:bg-blue-700 hover:scale-105 cursor-pointer ring-1.5 ring-blue-300'
                      : today
                      ? 'border border-blue-600 text-blue-600 font-extrabold'
                      : cell.isCurrentMonth
                      ? 'text-slate-700 hover:bg-slate-100'
                      : 'text-slate-300'
                  } ${isSelected ? 'ring-3 ring-blue-400 scale-110' : ''}`}
                >
                  {cell.day}
                </button>
              </div>
            );
          })}
        </div>
      </div>

      {/* Selected Day Workout Popover Tooltip */}
      {selectedDay && (
        <div className="bg-slate-50 border border-blue-200 rounded-xl p-2.5 space-y-2 shadow-xs mt-1">
          <div className="flex items-center justify-between">
            <span className="text-[11px] font-extrabold text-blue-600 uppercase tracking-wider">
              {selectedDay.dateFormatted}
            </span>
            <button
              onClick={() => onDaySelect(null)}
              className="text-slate-400 hover:text-slate-700 p-0.5"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          </div>

          <div className="space-y-1.5">
            {selectedDay.workouts.map((w) => {
              const durMin = w.duration_minutes || Math.floor((w.duration_seconds || 0) / 60) || 30;

              return (
                <div
                  key={w.id}
                  className="bg-white border border-slate-200 rounded-lg p-2 flex items-center justify-between gap-2 text-xs"
                >
                  <div className="min-w-0">
                    <h5 className="font-extrabold text-slate-900 truncate">{w.name}</h5>
                    <p className="text-[10px] text-slate-500">{durMin} min</p>
                  </div>

                  <button
                    type="button"
                    onClick={() => {
                      if (onSelectWorkout) onSelectWorkout(w.id);
                    }}
                    className="flex items-center gap-1 text-[11px] font-extrabold text-blue-600 hover:text-blue-800 bg-blue-50 hover:bg-blue-100 px-2 py-1 rounded-md transition-colors shrink-0"
                  >
                    <span>View</span>
                    <ExternalLink className="w-3 h-3" />
                  </button>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </Card>
  );
}
