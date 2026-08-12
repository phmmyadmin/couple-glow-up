import React, { useState } from 'react';
import { History, Trophy, Calendar, Clock, Flame, ChevronDown, ChevronUp, Search, Dumbbell } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import { Input } from '../../../shared/ui/Input';

export default function WorkoutHistory({ workouts, personalRecords }) {
  const [expandedWorkoutId, setExpandedWorkoutId] = useState(null);
  const [searchFilter, setSearchFilter] = useState('');

  const toggleExpand = (id) => {
    setExpandedWorkoutId((prev) => (prev === id ? null : id));
  };

  const filteredWorkouts = workouts.filter((w) =>
    w.name.toLowerCase().includes(searchFilter.toLowerCase())
  );

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Personal Records Highlight Card */}
      {personalRecords.length > 0 && (
        <Card className="bg-gradient-to-r from-indigo-50/80 via-purple-50/80 to-pink-50/80 border-indigo-100 p-5 sm:p-6 space-y-4 shadow-sm">
          <h3 className="text-xs font-bold text-indigo-900 uppercase tracking-wider flex items-center gap-2">
            <Trophy className="w-4.5 h-4.5 text-indigo-600" />
            <span>Personal Records ({personalRecords.length})</span>
          </h3>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-1">
            {personalRecords.slice(0, 4).map((pr) => (
              <div
                key={pr.id}
                className="bg-white/90 border border-indigo-100 p-3.5 rounded-xl flex items-center justify-between text-xs sm:text-sm shadow-xs"
              >
                <div>
                  <h4 className="font-bold text-slate-900">
                    {pr.exercises?.name_es || pr.exercises?.name || 'Exercise'}
                  </h4>
                  <span className="text-xs text-slate-500 font-mono capitalize">
                    {pr.record_type.replace('_', ' ')}
                  </span>
                </div>
                <span className="font-mono font-extrabold text-indigo-700 bg-indigo-50 px-3 py-1 rounded-lg border border-indigo-200">
                  {pr.value} {pr.record_type.includes('duration') ? 's' : 'kg'}
                </span>
              </div>
            ))}
          </div>
        </Card>
      )}

      {/* Filter & Search Header */}
      <div className="flex items-center justify-between gap-3 px-1">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
          Workout History ({filteredWorkouts.length})
        </h3>
      </div>

      {workouts.length > 0 && (
        <div className="relative">
          <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-3.5" />
          <Input
            type="text"
            placeholder="Filter history by name..."
            value={searchFilter}
            onChange={(e) => setSearchFilter(e.target.value)}
            className="pl-10"
          />
        </div>
      )}

      {/* Past Workouts Feed */}
      {filteredWorkouts.length === 0 ? (
        <Card className="text-center py-10 space-y-3">
          <History className="w-12 h-12 text-slate-300 mx-auto" />
          <p className="text-sm text-slate-500 font-medium">No workout sessions logged yet.</p>
        </Card>
      ) : (
        <div className="space-y-5 sm:space-y-6">
          {filteredWorkouts.map((workout) => {
            const dateStr = new Date(workout.started_at).toLocaleDateString('en-US', {
              weekday: 'short',
              day: 'numeric',
              month: 'short',
            });
            const isExpanded = expandedWorkoutId === workout.id;
            const sets = workout.workout_sets || [];

            return (
              <Card
                key={workout.id}
                className="p-5 sm:p-6 space-y-4 cursor-pointer hover:border-indigo-200 shadow-sm"
                onClick={() => toggleExpand(workout.id)}
              >
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <h4 className="text-base sm:text-lg font-bold text-slate-900 flex items-center gap-2">
                      <span>{workout.name}</span>
                      {isExpanded ? (
                        <ChevronUp className="w-4 h-4 text-indigo-600" />
                      ) : (
                        <ChevronDown className="w-4 h-4 text-slate-400" />
                      )}
                    </h4>
                    <div className="flex items-center gap-3 text-xs sm:text-sm text-slate-500 font-medium mt-1">
                      <span className="flex items-center gap-1.5">
                        <Calendar className="w-4 h-4 text-indigo-500" />
                        <span>{dateStr}</span>
                      </span>
                      <span>•</span>
                      <span className="flex items-center gap-1.5">
                        <Clock className="w-4 h-4 text-indigo-500" />
                        <span>{workout.duration_minutes || 30} min</span>
                      </span>
                    </div>
                  </div>

                  {workout.estimated_volume_kg > 0 && (
                    <span className="text-xs font-mono font-bold bg-indigo-50 text-indigo-700 px-3 py-1.5 rounded-xl border border-indigo-100 flex items-center gap-1.5 shrink-0">
                      <Flame className="w-4 h-4 text-indigo-500" />
                      <span>{workout.estimated_volume_kg.toLocaleString()} kg</span>
                    </span>
                  )}
                </div>

                {/* Expandable Breakdown of Exercises & Sets */}
                {isExpanded && (
                  <div className="pt-4 border-t border-slate-200/80 space-y-3 animate-in fade-in duration-150">
                    <h5 className="text-xs font-bold text-slate-600 uppercase tracking-wider">
                      Workout Breakdown
                    </h5>

                    {sets.length === 0 ? (
                      <p className="text-xs text-slate-400">No set details recorded for this workout.</p>
                    ) : (
                      <div className="space-y-2.5">
                        {sets.map((set, idx) => (
                          <div
                            key={idx}
                            className="bg-slate-50 border border-slate-200/80 rounded-xl p-3 flex items-center justify-between text-xs sm:text-sm font-mono"
                          >
                            <span className="font-bold text-slate-900 font-sans flex items-center gap-2">
                              <Dumbbell className="w-4 h-4 text-indigo-600" />
                              <span>{set.exercises?.name_es || set.exercises?.name || `Set ${idx + 1}`}</span>
                            </span>
                            <span className="text-slate-700 font-semibold bg-white border border-slate-200 px-2.5 py-1 rounded-lg shadow-xs">
                              {set.weight_kg ? `${set.weight_kg} kg × ` : ''}
                              {set.reps ? `${set.reps} reps` : ''}
                              {set.duration_seconds ? `${set.duration_seconds}s` : ''}
                            </span>
                          </div>
                        ))}
                      </div>
                    )}
                  </div>
                )}
              </Card>
            );
          })}
        </div>
      )}
    </div>
  );
}
