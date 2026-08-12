import React, { useState } from 'react';
import { Search, Plus, Dumbbell, Filter } from 'lucide-react';

const MUSCLE_GROUPS = [
  { id: 'all', label: 'Todos' },
  { id: 'chest', label: 'Pecho' },
  { id: 'back', label: 'Espalda' },
  { id: 'legs', label: 'Piernas' },
  { id: 'shoulders', label: 'Hombros' },
  { id: 'biceps', label: 'Bíceps' },
  { id: 'triceps', label: 'Tríceps' },
  { id: 'abdominals', label: 'Core' },
  { id: 'cardio', label: 'Cardio' },
  { id: 'other', label: 'Otros' },
];

export default function ExerciseLibrary({ exercises, onAddCustomExercise, onSelectExercise }) {
  const [search, setSearch] = useState('');
  const [selectedMuscle, setSelectedMuscle] = useState('all');
  const [isModalOpen, setIsModalOpen] = useState(false);

  // New custom exercise state
  const [customName, setCustomName] = useState('');
  const [customMuscle, setCustomMuscle] = useState('chest');
  const [customType, setCustomType] = useState('weight_reps');
  const [customEquipment, setCustomEquipment] = useState('dumbbell');

  const filteredExercises = exercises.filter((e) => {
    const matchesSearch =
      (e.name_es || e.name).toLowerCase().includes(search.toLowerCase()) ||
      e.name.toLowerCase().includes(search.toLowerCase());
    const matchesMuscle = selectedMuscle === 'all' || e.muscle_group === selectedMuscle;
    return matchesSearch && matchesMuscle;
  });

  const handleCreateCustom = (e) => {
    e.preventDefault();
    if (!customName.trim()) return;

    onAddCustomExercise({
      name: customName.trim(),
      name_es: customName.trim(),
      muscle_group: customMuscle,
      exercise_type: customType,
      equipment_category: customEquipment,
      is_custom: true,
    });

    setCustomName('');
    setIsModalOpen(false);
  };

  return (
    <div className="space-y-4">
      {/* Search & Filter Bar */}
      <div className="health-card space-y-3 p-3.5">
        <div className="flex gap-2">
          <div className="relative flex-1">
            <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
            <input
              type="text"
              placeholder="Buscar ejercicio (ej: Press de banca, Dominadas...)"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="edit-input pl-9 text-xs"
            />
          </div>

          <button
            onClick={() => setIsModalOpen(true)}
            className="flex items-center gap-1 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-3 py-2 rounded-xl shadow-sm transition-all active:scale-95 whitespace-nowrap"
          >
            <Plus className="w-4 h-4" />
            <span>Crear</span>
          </button>
        </div>

        {/* Muscle Filter Scroll */}
        <div className="flex items-center gap-1.5 overflow-x-auto no-scrollbar py-0.5">
          {MUSCLE_GROUPS.map((m) => (
            <button
              key={m.id}
              onClick={() => setSelectedMuscle(m.id)}
              className={`px-3 py-1 rounded-full text-xs font-medium whitespace-nowrap transition-all ${
                selectedMuscle === m.id
                  ? 'bg-indigo-600 text-white font-semibold shadow-sm'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              {m.label}
            </button>
          ))}
        </div>
      </div>

      {/* Exercises List */}
      <div className="space-y-2">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Catálogo ({filteredExercises.length})
        </h3>

        {filteredExercises.length === 0 ? (
          <div className="health-card text-center py-8 space-y-2">
            <Dumbbell className="w-8 h-8 text-slate-300 mx-auto" />
            <p className="text-xs text-slate-400">No se encontraron ejercicios con este filtro.</p>
          </div>
        ) : (
          <div className="space-y-2">
            {filteredExercises.map((exercise) => {
              const typeLabel =
                exercise.exercise_type === 'weight_reps'
                  ? 'Peso × Reps'
                  : exercise.exercise_type === 'reps_only'
                  ? 'Solo Reps'
                  : exercise.exercise_type === 'distance_duration'
                  ? 'Distancia & Tiempo'
                  : 'Tiempo';

              return (
                <div
                  key={exercise.id || exercise.name}
                  onClick={() => onSelectExercise && onSelectExercise(exercise)}
                  className={`health-card p-3 flex items-center justify-between transition-all ${
                    onSelectExercise ? 'cursor-pointer hover:border-indigo-300 hover:bg-indigo-50/40' : ''
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <div className="w-9 h-9 rounded-xl bg-indigo-50 border border-indigo-100 text-indigo-600 flex items-center justify-center font-bold text-sm">
                      <Dumbbell className="w-4 h-4" />
                    </div>
                    <div>
                      <h4 className="text-xs font-bold text-slate-900">
                        {exercise.name_es || exercise.name}
                      </h4>
                      <p className="text-[11px] text-slate-500 font-medium capitalize mt-0.5 flex items-center gap-2">
                        <span>{exercise.muscle_group}</span>
                        <span className="text-slate-300">•</span>
                        <span className="text-indigo-600 font-mono text-[10px]">{typeLabel}</span>
                      </p>
                    </div>
                  </div>

                  <span className="text-[10px] bg-slate-100 border border-slate-200 px-2 py-0.5 rounded-full text-slate-600 font-semibold capitalize">
                    {exercise.equipment_category || 'Bodyweight'}
                  </span>
                </div>
              );
            })}
          </div>
        )}
      </div>

      {/* New Exercise Modal */}
      {isModalOpen && (
        <div className="bottom-sheet-overlay">
          <div className="bottom-sheet space-y-4">
            <h3 className="text-sm font-bold text-slate-900">Crear Nuevo Ejercicio Personalizado</h3>

            <form onSubmit={handleCreateCustom} className="space-y-3">
              <div>
                <label className="text-xs font-semibold text-slate-600 block mb-1">Nombre del Ejercicio</label>
                <input
                  type="text"
                  placeholder="Ej: Press Francés con Mancuerna"
                  value={customName}
                  onChange={(e) => setCustomName(e.target.value)}
                  className="edit-input"
                  required
                />
              </div>

              <div className="grid grid-cols-2 gap-2">
                <div>
                  <label className="text-xs font-semibold text-slate-600 block mb-1">Grupo Muscular</label>
                  <select
                    value={customMuscle}
                    onChange={(e) => setCustomMuscle(e.target.value)}
                    className="edit-select"
                  >
                    {MUSCLE_GROUPS.filter((m) => m.id !== 'all').map((m) => (
                      <option key={m.id} value={m.id}>
                        {m.label}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="text-xs font-semibold text-slate-600 block mb-1">Tipo de Medición</label>
                  <select
                    value={customType}
                    onChange={(e) => setCustomType(e.target.value)}
                    className="edit-select"
                  >
                    <option value="weight_reps">Peso & Repeticiones</option>
                    <option value="reps_only">Solo Repeticiones</option>
                    <option value="distance_duration">Distancia & Tiempo</option>
                    <option value="duration_only">Solo Tiempo</option>
                  </select>
                </div>
              </div>

              <div className="flex justify-end gap-2 pt-2">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 text-xs font-semibold text-slate-500 hover:text-slate-800"
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  className="px-4 py-2 bg-indigo-600 text-white rounded-xl text-xs font-semibold shadow-sm hover:bg-indigo-700"
                >
                  Guardar Ejercicio
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
