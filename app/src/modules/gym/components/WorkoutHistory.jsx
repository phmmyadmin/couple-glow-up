import React, { useState } from 'react';
import { History, Trophy, Calendar, Clock, Flame, ChevronDown, ChevronUp, Search, Dumbbell, Trash2, Edit3, Save, X } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';
import { formatExerciseName } from '../lib/supabase-gym';
import { getMuscleGroupLabel } from './ExerciseLibrary';

export default function WorkoutHistory({
  workouts,
  personalRecords,
  onDeleteWorkout,
  onUpdateWorkout,
  initialExpandedWorkoutId = null,
}) {
  const [expandedWorkoutId, setExpandedWorkoutId] = useState(initialExpandedWorkoutId);
  const [searchFilter, setSearchFilter] = useState('');

  // Sync if initialExpandedWorkoutId changes externally
  React.useEffect(() => {
    if (initialExpandedWorkoutId) {
      setExpandedWorkoutId(initialExpandedWorkoutId);
      setSearchFilter('');
      const timer = setTimeout(() => {
        const el = document.getElementById(`workout-card-${initialExpandedWorkoutId}`);
        if (el) {
          el.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      }, 150);
      return () => clearTimeout(timer);
    }
  }, [initialExpandedWorkoutId]);

  // Editing state
  const [editingWorkout, setEditingWorkout] = useState(null);
  const [editName, setEditName] = useState('');
  const [editDuration, setEditDuration] = useState(30);

  const toggleExpand = (id) => {
    setExpandedWorkoutId((prev) => (prev === id ? null : id));
  };

  const handleStartEdit = (e, workout) => {
    e.stopPropagation();
    setEditingWorkout(workout);
    setEditName(workout.name);
    setEditDuration(workout.duration_minutes || 30);
  };

  const handleSaveEdit = (e) => {
    e.preventDefault();
    if (!editName.trim() || !editingWorkout) return;
    onUpdateWorkout(editingWorkout.id, {
      name: editName.trim(),
      duration_minutes: parseInt(editDuration, 10) || 30,
    });
    setEditingWorkout(null);
  };

  const handleDelete = (e, workout) => {
    e.stopPropagation();
    if (window.confirm(`Delete workout "${workout.name}"?`)) {
      onDeleteWorkout(workout.id);
    }
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
                    {pr.exercises?.name || pr.exercises?.name_es || 'Exercise'}
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
                id={`workout-card-${workout.id}`}
                className={`p-5 sm:p-6 space-y-4 cursor-pointer transition-all ${
                  isExpanded ? 'border-l-4 border-indigo-600 ring-2 ring-indigo-500/20 shadow-md' : 'hover:border-indigo-200 shadow-sm'
                }`}
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

                  <div className="flex items-center gap-2 shrink-0">
                    {workout.estimated_volume_kg > 0 && (
                      <span className="text-xs font-mono font-bold bg-indigo-50 text-indigo-700 px-3 py-1.5 rounded-xl border border-indigo-100 flex items-center gap-1.5">
                        <Flame className="w-4 h-4 text-indigo-500" />
                        <span>{workout.estimated_volume_kg.toLocaleString()} kg</span>
                      </span>
                    )}

                    <button
                      onClick={(e) => handleStartEdit(e, workout)}
                      aria-label="Edit workout details"
                      className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-indigo-50"
                    >
                      <Edit3 className="w-4 h-4" />
                    </button>
                    <button
                      onClick={(e) => handleDelete(e, workout)}
                      aria-label="Delete workout record"
                      className="p-2 text-slate-400 hover:text-rose-600 rounded-xl hover:bg-rose-50"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>

                {/* Expandable Breakdown of Exercises & Sets */}
                {isExpanded && (
                  <div className="pt-4 border-t border-slate-200/80 space-y-4 animate-in fade-in duration-150">
                    <h5 className="text-xs font-bold text-slate-600 uppercase tracking-wider">
                      Workout Breakdown
                    </h5>

                    {sets.length === 0 ? (
                      <p className="text-xs text-slate-400">No set details recorded for this workout.</p>
                    ) : (
                      <div className="space-y-3">
                        {(() => {
                          const groupedSets = sets.reduce((acc, set) => {
                            const rawExName =
                              set.exercises?.name ||
                              set.exercises?.name_es ||
                              set.exercise?.name ||
                              set.exercise?.name_es ||
                              set.exercise_name ||
                              'Exercise';
                            const exName = formatExerciseName(rawExName);

                            if (!acc[exName]) {
                              acc[exName] = {
                                name: exName,
                                muscle_group: set.exercises?.muscle_group || set.exercise?.muscle_group || '',
                                sets: [],
                              };
                            }
                            acc[exName].sets.push(set);
                            return acc;
                          }, {});

                          return Object.values(groupedSets).map((exGroup, groupIdx) => (
                            <div
                              key={groupIdx}
                              className="bg-slate-50 border border-slate-200/80 rounded-xl p-3.5 space-y-2.5"
                            >
                              <div className="flex items-center justify-between">
                                <h6 className="text-xs font-bold text-slate-900 flex items-center gap-2">
                                  <Dumbbell className="w-3.5 h-3.5 text-indigo-600" />
                                  <span>{exGroup.name}</span>
                                </h6>
                                {exGroup.muscle_group && (
                                  <span className="text-[10px] bg-white border border-slate-200 px-2 py-0.5 rounded-md text-slate-600 font-semibold">
                                    {getMuscleGroupLabel(exGroup.muscle_group)}
                                  </span>
                                )}
                              </div>

                              <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
                                {exGroup.sets.map((set, setIdx) => (
                                  <div
                                    key={setIdx}
                                    className="bg-white border border-slate-200/80 rounded-lg p-2 flex items-center justify-between text-xs font-mono"
                                  >
                                    <span className="text-slate-400 font-bold text-[10px]">#{setIdx + 1}</span>
                                    <span className="font-bold text-slate-800">
                                      {set.weight_kg ? `${set.weight_kg}kg ` : ''}
                                      {set.reps ? `× ${set.reps} reps ` : ''}
                                      {set.duration_seconds ? `⏱️ ${Math.floor(set.duration_seconds / 60)}:${String(set.duration_seconds % 60).padStart(2, '0')} min ` : ''}
                                      {set.distance_meters ? `📍 ${(set.distance_meters / 1000).toFixed(1)} km` : ''}
                                    </span>
                                  </div>
                                ))}
                              </div>
                            </div>
                          ));
                        })()}
                      </div>
                    )}
                  </div>
                )}
              </Card>
            );
          })}
        </div>
      )}

      {/* Edit Workout Modal */}
      {editingWorkout && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setEditingWorkout(null)}
        >
          <Card className="max-w-md w-full p-6 space-y-4 shadow-xl border border-slate-200 cursor-default" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between">
              <h3 className="text-base font-bold text-slate-900">Edit Workout Details</h3>
              <button
                onClick={() => setEditingWorkout(null)}
                className="p-1 text-slate-400 hover:text-slate-600"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveEdit} className="space-y-4">
              <Input
                label="Workout Name"
                value={editName}
                onChange={(e) => setEditName(e.target.value)}
                required
              />

              <Input
                label="Duration (minutes)"
                type="number"
                value={editDuration}
                onChange={(e) => setEditDuration(e.target.value)}
                required
              />

              <div className="flex justify-end gap-3 pt-2">
                <Button variant="ghost" onClick={() => setEditingWorkout(null)}>
                  Cancel
                </Button>
                <Button type="submit" variant="primary" icon={Save}>
                  Save Changes
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}
    </div>
  );
}
