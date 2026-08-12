import React from 'react';
import { History, Dumbbell, Trophy, Calendar, Clock, Flame } from 'lucide-react';
import Card from '../../../shared/ui/Card';

export default function WorkoutHistory({ workouts, personalRecords }) {
  return (
    <div className="space-y-4">
      {/* Personal Records Highlight Card */}
      {personalRecords.length > 0 && (
        <Card className="bg-gradient-to-r from-indigo-50/80 via-purple-50/80 to-pink-50/80 border-indigo-100 p-5 space-y-3">
          <h3 className="text-xs font-bold text-indigo-900 uppercase tracking-wider flex items-center gap-2">
            <Trophy className="w-4 h-4 text-indigo-600" />
            <span>Récords Personales ({personalRecords.length})</span>
          </h3>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 pt-1">
            {personalRecords.slice(0, 4).map((pr) => (
              <div
                key={pr.id}
                className="bg-white/90 border border-indigo-100 p-3 rounded-xl flex items-center justify-between text-xs sm:text-sm shadow-xs"
              >
                <div>
                  <h4 className="font-bold text-slate-900">
                    {pr.exercises?.name_es || pr.exercises?.name || 'Ejercicio'}
                  </h4>
                  <span className="text-xs text-slate-500 font-mono capitalize">
                    {pr.record_type.replace('_', ' ')}
                  </span>
                </div>
                <span className="font-mono font-extrabold text-indigo-700 bg-indigo-50 px-2.5 py-1 rounded-lg border border-indigo-200">
                  {pr.value} {pr.record_type.includes('duration') ? 's' : 'kg'}
                </span>
              </div>
            ))}
          </div>
        </Card>
      )}

      {/* Past Workouts Feed */}
      <div className="space-y-3">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Historial de Entrenamientos ({workouts.length})
        </h3>

        {workouts.length === 0 ? (
          <Card className="text-center py-8 space-y-2">
            <History className="w-10 h-10 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No se ha registrado ningún entrenamiento aún.</p>
          </Card>
        ) : (
          <div className="space-y-3">
            {workouts.map((workout) => {
              const dateStr = new Date(workout.started_at).toLocaleDateString('es-ES', {
                weekday: 'short',
                day: 'numeric',
                month: 'short',
              });

              return (
                <Card key={workout.id} className="p-4 space-y-3">
                  <div className="flex items-start justify-between">
                    <div>
                      <h4 className="text-base font-bold text-slate-900">{workout.name}</h4>
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
                      <span className="text-xs font-mono font-bold bg-indigo-50 text-indigo-700 px-3 py-1.5 rounded-xl border border-indigo-100 flex items-center gap-1.5">
                        <Flame className="w-4 h-4 text-indigo-500" />
                        <span>{workout.estimated_volume_kg.toLocaleString()} kg</span>
                      </span>
                    )}
                  </div>
                </Card>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
}
