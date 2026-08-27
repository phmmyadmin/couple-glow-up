import React, { useState, useEffect } from 'react';
import { Calendar, Check, X, Trash2, Zap } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import {
  DAYS_OF_WEEK,
  getCurrentDayOfWeek,
  getScheduleMapping,
  saveScheduleMapping,
  setScheduleForDay,
} from '../lib/routine-scheduler';

export default function WeeklyScheduleModal({
  isOpen,
  onClose,
  routines = [],
  activeProfile,
  onScheduleUpdated,
}) {
  const [schedule, setSchedule] = useState(() => {
    return getScheduleMapping(activeProfile?.id);
  });

  // ESC key listener to close modal
  useEffect(() => {
    if (!isOpen) return;
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [isOpen, onClose]);

  if (!isOpen) return null;

  const currentDay = getCurrentDayOfWeek();

  const handleSelectRoutineForDay = (dayName, routineId) => {
    const next = setScheduleForDay(schedule, dayName, routineId || null);
    setSchedule(next);
    saveScheduleMapping(next, activeProfile?.id);
    if (onScheduleUpdated) onScheduleUpdated(next);
  };

  const handleClearDay = (dayName) => {
    handleSelectRoutineForDay(dayName, null);
  };

  return (
    <div
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200"
      onClick={onClose}
    >
      <Card
        className="w-full max-w-lg max-h-[90vh] flex flex-col p-5 sm:p-6 shadow-2xl border-slate-700/80 bg-white"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="flex items-center justify-between border-b border-slate-100 pb-4">
          <div className="flex items-center gap-2.5">
            <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
              <Calendar className="w-5 h-5" />
            </div>
            <div>
              <CardTitle className="text-lg">Weekly Routine Schedule</CardTitle>
              <p className="text-xs text-slate-500 font-medium">
                Assign your custom routines to specific days of the week.
              </p>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="p-1.5 text-slate-400 hover:text-slate-600 rounded-xl hover:bg-slate-100 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Days List */}
        <div className="overflow-y-auto py-4 space-y-3 flex-1 pr-1">
          {DAYS_OF_WEEK.map((day) => {
            const isToday = day === currentDay;
            const assignedRoutineId = schedule[day] || '';
            const assignedRoutine = routines.find((r) => r.id === assignedRoutineId);

            return (
              <div
                key={day}
                className={`p-3.5 rounded-2xl border transition-all flex flex-col sm:flex-row sm:items-center justify-between gap-3 ${
                  isToday
                    ? 'border-indigo-300 bg-indigo-50/40 shadow-xs'
                    : 'border-slate-200 bg-slate-50/50'
                }`}
              >
                <div className="flex items-center gap-2 min-w-[120px]">
                  <span className="text-sm font-bold text-slate-800">{day}</span>
                  {isToday && (
                    <span className="px-2 py-0.5 bg-indigo-600 text-white text-[10px] font-extrabold rounded-full tracking-wider uppercase">
                      Today
                    </span>
                  )}
                </div>

                <div className="flex items-center gap-2 flex-1 max-w-full sm:max-w-[280px]">
                  <select
                    value={assignedRoutineId}
                    onChange={(e) => handleSelectRoutineForDay(day, e.target.value)}
                    className="w-full bg-white border border-slate-200 rounded-xl px-3 py-2 text-xs font-semibold text-slate-800 focus:outline-none focus:border-indigo-500 transition-colors shadow-2xs"
                  >
                    <option value="">-- Rest Day / None --</option>
                    {routines.map((r) => (
                      <option key={r.id} value={r.id}>
                        {r.name} ({r.exercises?.length || 0} ex)
                      </option>
                    ))}
                  </select>

                  {assignedRoutineId && (
                    <button
                      type="button"
                      onClick={() => handleClearDay(day)}
                      title="Clear day"
                      className="p-2 text-slate-400 hover:text-rose-600 rounded-xl hover:bg-rose-50 transition-colors shrink-0"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  )}
                </div>
              </div>
            );
          })}
        </div>

        {/* Footer */}
        <div className="pt-4 border-t border-slate-100 flex justify-end gap-2">
          <Button variant="primary" onClick={onClose}>
            Done
          </Button>
        </div>
      </Card>
    </div>
  );
}
