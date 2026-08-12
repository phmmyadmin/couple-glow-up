import React, { useState } from 'react';
import { Search, Plus, Dumbbell } from 'lucide-react';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

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
    <div className="space-y-5">
      {/* Search & Filter Bar */}
      <Card className="space-y-4 p-5 sm:p-6">
        <div className="flex gap-3">
          <div className="relative flex-1">
            <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-3.5" />
            <Input
              type="text"
              placeholder="Buscar ejercicio (ej: Press de banca, Dominadas...)"
              aria-label="Buscar ejercicio"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-10"
            />
          </div>

          <Button icon={Plus} variant="primary" onClick={() => setIsModalOpen(true)} className="shrink-0">
            Crear
          </Button>
        </div>

        {/* Muscle Filter Scroll */}
        <div className="flex items-center gap-2 overflow-x-auto no-scrollbar py-1">
          {MUSCLE_GROUPS.map((m) => (
            <button
              key={m.id}
              onClick={() => setSelectedMuscle(m.id)}
              className={`px-3.5 py-2 rounded-xl text-xs font-semibold whitespace-nowrap transition-all ${
                selectedMuscle === m.id
                  ? 'bg-indigo-600 text-white shadow-sm'
                  : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
              }`}
            >
              {m.label}
            </button>
          ))}
        </div>
      </Card>

      {/* Exercises List */}
      <div className="space-y-3">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Catálogo ({filteredExercises.length})
        </h3>

        {filteredExercises.length === 0 ? (
          <Card className="text-center py-10 space-y-3">
            <Dumbbell className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No se encontraron ejercicios con este filtro.</p>
          </Card>
        ) : (
          <div className="space-y-3">
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
                <Card
                  key={exercise.id || exercise.name}
                  hover={Boolean(onSelectExercise)}
                  onClick={() => onSelectExercise && onSelectExercise(exercise)}
                  className="p-4 sm:p-5 flex items-center justify-between gap-4"
                >
                  <div className="flex items-center gap-4 min-w-0">
                    <div className="w-12 h-12 rounded-2xl bg-indigo-50 border border-indigo-100 text-indigo-600 flex items-center justify-center font-bold shrink-0">
                      <Dumbbell className="w-6 h-6" />
                    </div>
                    <div className="space-y-0.5 min-w-0">
                      <h4 className="text-base font-bold text-slate-900 truncate">
                        {exercise.name_es || exercise.name}
                      </h4>
                      <p className="text-xs text-slate-500 font-medium capitalize flex items-center gap-2">
                        <span>{exercise.muscle_group}</span>
                        <span className="text-slate-300">•</span>
                        <span className="text-indigo-600 font-mono font-semibold">{typeLabel}</span>
                      </p>
                    </div>
                  </div>

                  <span className="text-xs bg-slate-100 border border-slate-200 px-3 py-1.5 rounded-xl text-slate-700 font-semibold capitalize shrink-0">
                    {exercise.equipment_category || 'Bodyweight'}
                  </span>
                </Card>
              );
            })}
          </div>
        )}
      </div>

      {/* New Exercise Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center p-4">
          <Card className="max-w-md w-full p-6 sm:p-7 space-y-5 shadow-xl border border-slate-200">
            <h3 className="text-lg font-bold text-slate-900">Crear Ejercicio Personalizado</h3>

            <form onSubmit={handleCreateCustom} className="space-y-4">
              <Input
                label="Nombre del Ejercicio"
                placeholder="Ej: Press Francés con Mancuerna"
                value={customName}
                onChange={(e) => setCustomName(e.target.value)}
                required
              />

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <Select
                  label="Grupo Muscular"
                  value={customMuscle}
                  onChange={(e) => setCustomMuscle(e.target.value)}
                >
                  {MUSCLE_GROUPS.filter((m) => m.id !== 'all').map((m) => (
                    <option key={m.id} value={m.id}>
                      {m.label}
                    </option>
                  ))}
                </Select>

                <Select
                  label="Tipo de Medición"
                  value={customType}
                  onChange={(e) => setCustomType(e.target.value)}
                >
                  <option value="weight_reps">Peso & Repeticiones</option>
                  <option value="reps_only">Solo Repeticiones</option>
                  <option value="distance_duration">Distancia & Tiempo</option>
                  <option value="duration_only">Solo Tiempo</option>
                </Select>
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <Button variant="ghost" onClick={() => setIsModalOpen(false)}>
                  Cancelar
                </Button>
                <Button type="submit" variant="primary">
                  Guardar Ejercicio
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}
    </div>
  );
}
