import React, { useState } from 'react';
import { History, Trophy, Calendar, Clock, Flame, ChevronDown, ChevronUp, Search, Dumbbell, Trash2, Edit3, Save, X } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';
import { formatExerciseName, doesSetMatchExercise } from '../lib/supabase-gym';
import { getExerciseMedia } from '../lib/exercise-media';
import { getMuscleGroupLabel } from './ExerciseLibrary';
import ExerciseHistoryModal from './ExerciseHistoryModal';
import WorkoutCalendar from './WorkoutCalendar';
import MuscleAnalyticsContainer from './MuscleAnalyticsContainer';
import AnnualActivityMatrix from './AnnualActivityMatrix';
import useInfiniteScroll from '../../../shared/hooks/useInfiniteScroll';
import InfiniteScrollSentinel from '../../../shared/ui/InfiniteScrollSentinel';

export default function WorkoutHistory({
  workouts,
  exercises = [],
  personalRecords,
  onDeleteWorkout,
  onUpdateWorkout,
  initialExpandedWorkoutId = null,
}) {
  const [expandedWorkoutId, setExpandedWorkoutId] = useState(initialExpandedWorkoutId);
  const [searchFilter, setSearchFilter] = useState('');
  const [selectedExerciseForHistory, setSelectedExerciseForHistory] = useState(null);
  const [editingWorkout, setEditingWorkout] = useState(null);
  const [editName, setEditName] = useState('');
  const [editDuration, setEditDuration] = useState(30);
  const [selectedCalendarDay, setSelectedCalendarDay] = useState(null);

  // Compute active muscles:
  // If selectedCalendarDay is set -> extract muscles of workouts on that day.
  // Else (default) -> extract muscles of workouts over the last 7 days!
  const activeMuscles = React.useMemo(() => {
    let targetWorkouts = [];

    if (selectedCalendarDay && Array.isArray(selectedCalendarDay.workouts)) {
      targetWorkouts = selectedCalendarDay.workouts;
    } else {
      const sevenDaysAgo = Date.now() - 7 * 24 * 60 * 60 * 1000;
      targetWorkouts = workouts.filter((w) => new Date(w.started_at).getTime() >= sevenDaysAgo);
    }

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
  }, [selectedCalendarDay, workouts, exercises]);

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

  // Handle Escape key to close modals
  React.useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') {
        if (selectedExerciseForHistory) {
          setSelectedExerciseForHistory(null);
        } else if (editingWorkout) {
          setEditingWorkout(null);
        }
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [selectedExerciseForHistory, editingWorkout]);

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

  const handleScrollToWorkout = (workoutId) => {
    setSearchFilter('');
    setTimeout(() => {
      const el = document.getElementById(`workout-card-${workoutId}`);
      if (el) {
        el.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
    }, 50);
  };

  const filteredWorkouts = workouts.filter((w) =>
    w.name.toLowerCase().includes(searchFilter.toLowerCase())
  );

  const {
    displayedItems: paginatedWorkouts,
    hasMore,
    totalCount,
    visibleCount,
    loadMore,
    sentinelRef,
  } = useInfiniteScroll({
    items: filteredWorkouts,
    pageSize: 15,
    resetDependencies: [searchFilter, selectedCalendarDay],
  });

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* 2-Column Grid: Compact Calendar + Muscle Body Heatmap */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 items-stretch">
        <WorkoutCalendar
          workouts={workouts}
          selectedDay={selectedCalendarDay}
          onDaySelect={(dayData) => setSelectedCalendarDay(dayData)}
          onSelectWorkout={handleScrollToWorkout}
        />

        <MuscleAnalyticsContainer
          workouts={workouts}
          exercises={exercises}
          selectedCalendarDay={selectedCalendarDay}
        />
      </div>

      {/* 52-Week GitHub-Style Activity Consistency Matrix */}
      {workouts.length > 0 && <AnnualActivityMatrix workouts={workouts} />}

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
          {paginatedWorkouts.map((workout) => {
            const dateObj = new Date(workout.started_at);
            const dateStr = dateObj.toLocaleDateString('en-US', {
              weekday: 'short',
              day: 'numeric',
              month: 'short',
              year: 'numeric',
            });
            const timeStr = dateObj.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
            const sets = workout.workout_sets || [];
            const totalPRs = sets.filter((s) => s.is_pr).length;

            const groupedSets = sets.reduce((acc, set) => {
              const rawExName =
                set.exercises?.name ||
                set.exercises?.name_es ||
                set.exercise?.name ||
                set.exercise?.name_es ||
                set.exercise_name ||
                'Exercise';
              const exName = formatExerciseName(rawExName);
              const key = set.exercise_id || exName;

              if (!acc[key]) {
                acc[key] = {
                  name: exName,
                  muscle_group: set.exercises?.muscle_group || set.exercise?.muscle_group || '',
                  sets: [],
                };
              }
              acc[key].sets.push(set);
              return acc;
            }, {});

            return (
              <Card
                key={workout.id}
                id={`workout-card-${workout.id}`}
                className="p-5 sm:p-6 space-y-4 shadow-sm border-slate-200/90 rounded-2xl bg-white hover:border-indigo-200 transition-all"
              >
                {/* 1. Hevy User & Workout Header */}
                <div className="flex items-start justify-between gap-3">
                  <div className="flex items-center gap-3 min-w-0">
                    <div className="w-10 h-10 rounded-full bg-gradient-to-tr from-indigo-600 to-violet-500 text-white font-extrabold text-xs flex items-center justify-center shrink-0 shadow-xs font-mono">
                      PM
                    </div>
                    <div className="min-w-0">
                      <h4 className="font-extrabold text-slate-900 text-base sm:text-lg leading-tight truncate">
                        {workout.name}
                      </h4>
                      <div className="flex items-center gap-2 text-xs text-slate-400 font-medium mt-0.5">
                        <Calendar className="w-3.5 h-3.5 text-indigo-500 shrink-0" />
                        <span>{dateStr} at {timeStr}</span>
                      </div>
                    </div>
                  </div>

                  {/* Actions Header */}
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      onClick={(e) => handleStartEdit(e, workout)}
                      aria-label="Edit workout details"
                      className="p-2 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-slate-100 transition-colors"
                      title="Edit Workout"
                    >
                      <Edit3 className="w-4 h-4" />
                    </button>
                    <button
                      onClick={(e) => handleDelete(e, workout)}
                      aria-label="Delete workout record"
                      className="p-2 text-slate-400 hover:text-rose-600 rounded-xl hover:bg-rose-50 transition-colors"
                      title="Delete Workout"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>
                </div>

                {/* 2. Top Summary Statistics Bar */}
                <div className="grid grid-cols-3 sm:grid-cols-4 gap-2 bg-slate-50/80 border border-slate-100 p-3 rounded-xl">
                  <div className="space-y-0.5 text-center">
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Time</span>
                    <span className="text-xs sm:text-sm font-extrabold text-slate-800 font-mono flex items-center justify-center gap-1">
                      <Clock className="w-3.5 h-3.5 text-indigo-500" />
                      {workout.duration_minutes || 30} min
                    </span>
                  </div>
                  <div className="space-y-0.5 text-center">
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Volume</span>
                    <span className="text-xs sm:text-sm font-extrabold text-slate-800 font-mono flex items-center justify-center gap-1">
                      <Flame className="w-3.5 h-3.5 text-amber-500" />
                      {(workout.estimated_volume_kg || 0).toLocaleString()} kg
                    </span>
                  </div>
                  <div className="space-y-0.5 text-center">
                    <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Sets</span>
                    <span className="text-xs sm:text-sm font-extrabold text-slate-800 font-mono flex items-center justify-center gap-1">
                      <Dumbbell className="w-3.5 h-3.5 text-emerald-500" />
                      {sets.length} sets
                    </span>
                  </div>
                  {totalPRs > 0 && (
                    <div className="space-y-0.5 text-center col-span-3 sm:col-span-1">
                      <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">PRs</span>
                      <span className="text-xs sm:text-sm font-extrabold text-amber-600 font-mono flex items-center justify-center gap-1">
                        <Trophy className="w-3.5 h-3.5 text-amber-500" />
                        {totalPRs} PRs
                      </span>
                    </div>
                  )}
                </div>

                {/* 3. Hevy Exercise Breakdown Feed */}
                <div className="space-y-3 pt-2">
                  {Object.values(groupedSets).map((exGroup, groupIdx) => {
                    const media = getExerciseMedia(exGroup.name);
                    return (
                      <div
                        key={groupIdx}
                        className="space-y-2 border-b border-slate-100 last:border-0 pb-3.5 last:pb-0"
                      >
                        <div className="flex items-center justify-between gap-2">
                          <div className="flex items-center gap-2 min-w-0 flex-1">
                            <div
                              onClick={() => setSelectedExerciseForHistory(exGroup.exerciseObj || { id: exGroup.id, name: exGroup.name, muscle_group: exGroup.muscle_group })}
                              className="w-9 h-9 rounded-xl bg-slate-100 border border-slate-200/80 flex items-center justify-center overflow-hidden shrink-0 shadow-2xs cursor-pointer hover:border-indigo-300 transition-all"
                              title="Click to view technique GIF & history"
                            >
                              {media?.gifUrl ? (
                                <img
                                  src={media.gifUrl}
                                  alt={exGroup.name}
                                  className="w-full h-full object-cover"
                                  loading="lazy"
                                  onError={(e) => {
                                    if (media.imgUrl) e.target.src = media.imgUrl;
                                    else e.target.style.display = 'none';
                                  }}
                                />
                              ) : (
                                <Dumbbell className="w-4 h-4 text-slate-500" />
                              )}
                            </div>

                            <h5
                              onClick={() => setSelectedExerciseForHistory(exGroup.exerciseObj || { id: exGroup.id, name: exGroup.name, muscle_group: exGroup.muscle_group })}
                              className="text-sm font-extrabold text-indigo-600 hover:text-indigo-800 leading-snug break-words cursor-pointer hover:underline"
                              title="Click to view Exercise Performance History"
                            >
                              {exGroup.sets.length}x {exGroup.name}
                            </h5>
                          </div>

                          {exGroup.muscle_group && (
                            <span className="text-[10px] bg-slate-100 text-slate-600 font-bold px-2 py-0.5 rounded-md uppercase shrink-0">
                              {getMuscleGroupLabel(exGroup.muscle_group)}
                            </span>
                          )}
                        </div>

                      {/* Set Details List */}
                      <div className="space-y-1.5 pl-1">
                        {exGroup.sets.map((set, setIdx) => {
                          const setLabel =
                            set.indicator === 'warmup'
                              ? 'W'
                              : set.indicator === 'drop'
                              ? 'D'
                              : set.indicator === 'failure'
                              ? 'F'
                              : `${setIdx + 1}`;

                          return (
                            <div
                              key={setIdx}
                              className="flex items-center gap-3 text-xs font-mono text-slate-600"
                            >
                              <span className={`w-5 h-5 rounded text-[10px] font-extrabold flex items-center justify-center shrink-0 ${
                                set.indicator === 'warmup'
                                  ? 'bg-amber-100 text-amber-800'
                                  : set.indicator === 'drop'
                                  ? 'bg-purple-100 text-purple-800'
                                  : set.indicator === 'failure'
                                  ? 'bg-rose-100 text-rose-800'
                                  : 'bg-slate-100 text-slate-600'
                              }`}>
                                {setLabel}
                              </span>

                              <span className="font-bold text-slate-800">
                                {set.weight_kg ? `${set.weight_kg} kg` : ''}
                                {set.reps ? ` × ${set.reps} reps` : ''}
                                {set.duration_seconds ? ` ⏱️ ${Math.floor(set.duration_seconds / 60)}:${String(set.duration_seconds % 60).padStart(2, '0')} min` : ''}
                                {set.distance_meters ? ` 📍 ${(set.distance_meters / 1000).toFixed(1)} km` : ''}
                              </span>

                              {set.rpe && (
                                <span className="text-[10px] bg-slate-100 text-slate-700 font-bold px-1.5 py-0.5 rounded font-sans">
                                  @{set.rpe}
                                </span>
                              )}

                              {set.is_pr && (
                                <span className="text-[10px] bg-amber-100 text-amber-800 font-bold px-1.5 py-0.5 rounded font-sans flex items-center gap-0.5">
                                  <Trophy className="w-3 h-3 text-amber-600" /> PR
                                </span>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  );
                })}
              </div>
              </Card>
            );
          })}
        </div>
      )}

      {/* Infinite Scroll Sentinel for Workouts */}
      {filteredWorkouts.length > 0 && (
        <InfiniteScrollSentinel
          sentinelRef={sentinelRef}
          hasMore={hasMore}
          visibleCount={visibleCount}
          totalCount={totalCount}
          onLoadMore={loadMore}
          itemLabel="workout sessions"
        />
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

      {/* Exercise Performance History Modal */}
      {selectedExerciseForHistory && (
        <ExerciseHistoryModal
          exercise={selectedExerciseForHistory}
          workouts={workouts}
          exercises={exercises}
          onGoToWorkout={(workoutId) => {
            setSelectedExerciseForHistory(null);
            setExpandedWorkoutId(workoutId);
            setTimeout(() => {
              const el = document.getElementById(`workout-card-${workoutId}`);
              if (el) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }, 100);
          }}
          onClose={() => setSelectedExerciseForHistory(null)}
        />
      )}
    </div>
  );
}
