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
    <div className="space-y-4">
      {/* Search & Filter Bar */}
      <Card className="space-y-3 p-4">
        <div className="flex gap-2">
          <div className="relative flex-1">
            <Search className="w-4 h-4 text-slate-400 absolute left-3 top.1/2 top-3" />
            <Input
              type="text"
              placeholder="Buscar ejercicio (ej: Press de banca, Dominadas...)"
              aria-label="Buscar ejercicio"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-9"
            />
          </div>

          <Button icon={Plus} variant="primary" onClick={() => setIsModalOpen(true)}>
            Crear
          </Button>
        </div>

        {/* Muscle Filter Scroll */}
        <div className="flex items-center gap-1.5 overflow-x-auto no-scrollbar py-0.5">
          {MUSCLE_GROUPS.map((m) => (
            <button
              key={m.id}
              onClick={() => setSelectedMuscle(m.id)}
              className={`px-3 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition-all ${
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
      <div className="space-y-2.5">
        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider px-1">
          Catálogo ({filteredExercises.length})
        </h3>

        {filteredExercises.length === 0 ? (
          <Card className="text-center py-8 space-y-2">
            <Dumbbell className="w-10 h-10 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No se encontraron ejercicios con este filtro.</p>
          </Card>
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
                <Card
                  key={exercise.id || exercise.name}
                  hover={Boolean(onSelectExercise)}
                  onClick={() => onSelectExercise && onSelectExercise(exercise)}
                  className="p-3.5 flex items-center justify-between"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-2xl bg-indigo-50 border border-indigo-100 text-indigo-600 flex items-center justify-center font-bold text-sm shrink-0">
                      <Dumbbell className="w-5 h-5" />
                    </div>
                    <div>
                      <h4 className="text-sm font-bold text-slate-900">
                        {exercise.name_es || exercise.name}
                      </h4>
                      <p className="text-xs text-slate-500 font-medium capitalize mt-0.5 flex items-center gap-2">
                        <span>{exercise.muscle_group}</span>
                        <span className="text-slate-300">•</span>
                        <span className="text-indigo-600 font-mono font-semibold">{typeLabel}</span>
                      </p>
                    </div>
                  </div>

                  <span className="text-xs bg-slate-100 border border-slate-200 px-2.5 py-1 rounded-xl text-slate-700 font-semibold capitalize">
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
          <Card className="max-w-md w-full p-6 space-y-4 shadow-xl border border-slate-200">
            <h3 className="text-base font-bold text-slate-900">Crear Ejercicio Personalizado</h3>

            <form onSubmit={handleCreateCustom} className="space-y-3">
              <Input
                label="Nombre del Ejercicio"
                placeholder="Ej: Press Francés con Mancuerna"
                value={customName}
                onChange={(e) => setCustomName(e.target.value)}
                required
              />

              <div className="grid grid-cols-2 gap-3">
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

              <div className="flex justify-end gap-2 pt-2">
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
