import React, { useState } from 'react';
import { ChevronLeft, ChevronRight, Calendar as CalendarIcon, ExternalLink } from 'lucide-react';
import Card from '../../../shared/ui/Card';

export default function WorkoutCalendar({ workouts = [], onSelectWorkout }) {
  const [currentDate, setCurrentDate] = useState(() => new Date());
  const [selectedDayWorkouts, setSelectedDayWorkouts] = useState(null);

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();

  const monthName = currentDate.toLocaleDateString('en-US', {
    month: 'long',
    year: 'numeric',
  });

  const handlePrevMonth = () => {
    setCurrentDate(new Date(year, month - 1, 1));
    setSelectedDayWorkouts(null);
  };

  const handleNextMonth = () => {
    setCurrentDate(new Date(year, month + 1, 1));
    setSelectedDayWorkouts(null);
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
      if (selectedDayWorkouts?.dateStr === cell.dateObj.toDateString()) {
        setSelectedDayWorkouts(null);
      } else {
        setSelectedDayWorkouts({
          dateObj: cell.dateObj,
          dateStr: cell.dateObj.toDateString(),
          workouts: dayWorkouts,
        });
      }
    } else {
      setSelectedDayWorkouts(null);
    }
  };

  const DAY_LABELS = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  return (
    <Card className="p-5 sm:p-6 space-y-4 shadow-sm border border-slate-200/90 rounded-2xl bg-white relative">
      {/* Header Row */}
      <div className="flex items-center justify-between">
        <h3 className="text-base sm:text-lg font-extrabold text-slate-900 flex items-center gap-2">
          <CalendarIcon className="w-5 h-5 text-blue-600" />
          <span>Calendar</span>
        </h3>

        {/* Month Navigation */}
        <div className="flex items-center gap-2">
          <button
            type="button"
            onClick={handlePrevMonth}
            className="p-1.5 text-slate-500 hover:text-slate-900 rounded-xl hover:bg-slate-100 transition-colors"
            aria-label="Previous Month"
          >
            <ChevronLeft className="w-5 h-5" />
          </button>

          <span className="text-sm font-bold text-slate-800 font-sans min-w-[110px] text-center capitalize">
            {monthName}
          </span>

          <button
            type="button"
            onClick={handleNextMonth}
            className="p-1.5 text-slate-500 hover:text-slate-900 rounded-xl hover:bg-slate-100 transition-colors"
            aria-label="Next Month"
          >
            <ChevronRight className="w-5 h-5" />
          </button>
        </div>
      </div>

      {/* Days of Week Header Row */}
      <div className="grid grid-cols-7 text-center border-b border-slate-100 pb-2">
        {DAY_LABELS.map((dayLabel, idx) => (
          <span key={idx} className="text-xs font-extrabold text-slate-400">
            {dayLabel}
          </span>
        ))}
      </div>

      {/* Calendar Grid */}
      <div className="grid grid-cols-7 gap-y-2 text-center items-center">
        {calendarGrid.map((cell, idx) => {
          const dayWorkouts = getWorkoutsForDate(cell.dateObj);
          const hasWorkout = dayWorkouts.length > 0;
          const today = isToday(cell.dateObj);
          const isSelected = selectedDayWorkouts?.dateStr === cell.dateObj.toDateString();

          return (
            <div key={idx} className="flex flex-col items-center justify-center p-0.5 relative">
              <button
                type="button"
                onClick={() => handleDayClick(cell)}
                disabled={!cell.isCurrentMonth && !hasWorkout}
                className={`w-9 h-9 rounded-full text-xs font-bold flex items-center justify-center transition-all ${
                  hasWorkout
                    ? 'bg-blue-600 text-white font-extrabold shadow-sm hover:bg-blue-700 hover:scale-105 cursor-pointer ring-2 ring-blue-200'
                    : today
                    ? 'border-2 border-blue-600 text-blue-600 font-extrabold'
                    : cell.isCurrentMonth
                    ? 'text-slate-700 hover:bg-slate-100'
                    : 'text-slate-300'
                } ${isSelected ? 'ring-4 ring-blue-300 scale-110' : ''}`}
              >
                {cell.day}
              </button>
            </div>
          );
        })}
      </div>

      {/* Selected Day Workout Popover Tooltip Card (Hevy Style) */}
      {selectedDayWorkouts && (
        <div className="bg-slate-50 border border-blue-200 rounded-2xl p-4 space-y-3 shadow-md animate-in fade-in slide-in-from-top-2 duration-200">
          <div className="flex items-center justify-between">
            <span className="text-xs font-extrabold text-blue-600 uppercase tracking-wider">
              {selectedDayWorkouts.dateObj.toLocaleDateString('en-US', {
                weekday: 'short',
                month: 'short',
                day: 'numeric',
              })}
            </span>
            <span className="text-[11px] bg-blue-100 text-blue-800 font-bold px-2 py-0.5 rounded-full">
              {selectedDayWorkouts.workouts.length} Workout{selectedDayWorkouts.workouts.length > 1 ? 's' : ''}
            </span>
          </div>

          <div className="space-y-2">
            {selectedDayWorkouts.workouts.map((w) => {
              const durMin = w.duration_minutes || Math.floor((w.duration_seconds || 0) / 60) || 30;
              const dateFormatted = new Date(w.started_at).toLocaleDateString('en-US', {
                day: '2-digit',
                month: 'short',
                year: 'numeric',
              });

              return (
                <div
                  key={w.id}
                  className="bg-white border border-slate-200 rounded-xl p-3 flex items-center justify-between gap-3 shadow-2xs"
                >
                  <div>
                    <h5 className="font-extrabold text-slate-900 text-sm">{w.name}</h5>
                    <p className="text-xs text-slate-500 font-medium">
                      {durMin > 60 ? `${Math.floor(durMin / 60)}h ${durMin % 60}min` : `${durMin}min`} · {dateFormatted}
                    </p>
                  </div>

                  <button
                    type="button"
                    onClick={() => {
                      if (onSelectWorkout) onSelectWorkout(w.id);
                    }}
                    className="flex items-center gap-1 text-xs font-extrabold text-blue-600 hover:text-blue-800 bg-blue-50 hover:bg-blue-100 px-3 py-1.5 rounded-lg transition-colors shrink-0"
                  >
                    <span>View workout</span>
                    <ExternalLink className="w-3.5 h-3.5" />
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
