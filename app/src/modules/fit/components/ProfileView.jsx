import React, { useState, useEffect } from 'react';
import { Save, User, Activity, Target } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { saveProfile } from '../../../lib/supabase';
import { calculateProfileTargets } from '../../../utils/profile';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';

const defaultForm = {
  name: '',
  gender: 'male',
  language: 'es',
  age: 30,
  height: 170,
  weight: 70,
  target_weight: 65,
  activity_level: 'moderate',
  goal: 'lose',
  pace: 'moderate',
  target_calories: 2000,
  target_protein: 150,
  target_carbs: 200,
  target_fats: 60,
};

export default function ProfileView({ profile, onProfileSaved }) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState(profile || defaultForm);
  const [isSaving, setIsSaving] = useState(false);
  const [autoCalculate, setAutoCalculate] = useState(true);

  useEffect(() => {
    if (profile) {
      setFormData(profile);
    } else {
      setFormData(defaultForm);
    }
  }, [profile]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    const numFields = [
      'age',
      'height',
      'weight',
      'target_weight',
      'target_calories',
      'target_protein',
      'target_carbs',
      'target_fats',
    ];
    let finalValue = numFields.includes(name) ? Number(value) : value;

    const newForm = { ...formData, [name]: finalValue };

    if (
      autoCalculate &&
      ['age', 'height', 'weight', 'gender', 'activity_level', 'goal', 'pace'].includes(name)
    ) {
      const targets = calculateProfileTargets(newForm);
      newForm.target_calories = targets.calories;
      newForm.target_protein = targets.protein;
      newForm.target_carbs = targets.carbs;
      newForm.target_fats = targets.fats;
    }

    setFormData(newForm);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSaving(true);
    const saved = await saveProfile(formData);
    setIsSaving(false);
    if (saved && onProfileSaved) {
      onProfileSaved(saved);
    }
  };

  return (
    <Card className="max-w-xl mx-auto p-5 sm:p-6 space-y-5">
      <CardTitle icon={User} className="text-lg">
        {t('profile.settings', 'Ajustes de Perfil')}
      </CardTitle>

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Basic Info */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
          <Input
            label={t('profile.name', 'Nombre')}
            name="name"
            value={formData.name || ''}
            onChange={handleChange}
            required
          />
          <Select
            label={t('profile.gender', 'Género')}
            name="gender"
            value={formData.gender || 'male'}
            onChange={handleChange}
          >
            <option value="male">{t('profile.male', 'Hombre')}</option>
            <option value="female">{t('profile.female', 'Mujer')}</option>
          </Select>
          <Select
            label={t('profile.language', 'Idioma')}
            name="language"
            value={formData.language || 'es'}
            onChange={handleChange}
          >
            <option value="es">Español</option>
            <option value="en">English</option>
          </Select>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <Input
            label={t('profile.age', 'Edad')}
            type="number"
            name="age"
            value={formData.age || ''}
            onChange={handleChange}
            required
          />
          <Input
            label={t('profile.height', 'Altura (cm)')}
            type="number"
            name="height"
            value={formData.height || ''}
            onChange={handleChange}
            required
          />
          <Input
            label={t('profile.weight', 'Peso (kg)')}
            type="number"
            step="0.1"
            name="weight"
            value={formData.weight || ''}
            onChange={handleChange}
            required
          />
          <Input
            label={t('profile.targetWeight', 'Obj. (kg)')}
            type="number"
            step="0.1"
            name="target_weight"
            value={formData.target_weight || ''}
            onChange={handleChange}
            required
          />
        </div>

        {/* Activity & Goals */}
        <div className="pt-2 border-t border-slate-200/80">
          <CardTitle icon={Activity} className="text-sm mb-3">
            {t('profile.activityAndGoal', 'Actividad y Objetivo')}
          </CardTitle>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            <Select
              label={t('profile.activityLevel', 'Nivel Actividad')}
              name="activity_level"
              value={formData.activity_level || 'moderate'}
              onChange={handleChange}
            >
              <option value="sedentary">{t('profile.sedentary', 'Sedentario')}</option>
              <option value="light">{t('profile.light', 'Ligero')}</option>
              <option value="moderate">{t('profile.moderate', 'Moderado')}</option>
              <option value="active">{t('profile.active', 'Activo')}</option>
              <option value="very_active">{t('profile.veryActive', 'Muy Activo')}</option>
            </Select>

            <Select
              label={t('profile.goal', 'Objetivo')}
              name="goal"
              value={formData.goal || 'maintain'}
              onChange={handleChange}
            >
              <option value="lose">{t('profile.loseWeight', 'Perder Peso')}</option>
              <option value="maintain">{t('profile.maintainWeight', 'Mantener')}</option>
              <option value="gain">{t('profile.gainWeight', 'Ganar Masa')}</option>
            </Select>

            <Select
              label={t('profile.pace', 'Ritmo')}
              name="pace"
              value={formData.pace || 'moderate'}
              onChange={handleChange}
            >
              <option value="relaxed">{t('profile.paceRelaxed', 'Relajado')}</option>
              <option value="moderate">{t('profile.paceModerate', 'Moderado')}</option>
              <option value="aggressive">{t('profile.paceAggressive', 'Agresivo')}</option>
            </Select>
          </div>
        </div>

        {/* Macros */}
        <div className="pt-2 border-t border-slate-200/80 space-y-3">
          <div className="flex items-center justify-between">
            <CardTitle icon={Target} className="text-sm">
              {t('profile.dailyTargets', 'Objetivos Diarios')}
            </CardTitle>

            <label className="flex items-center gap-2 text-xs font-semibold text-slate-600 cursor-pointer">
              <input
                type="checkbox"
                checked={autoCalculate}
                onChange={(e) => setAutoCalculate(e.target.checked)}
                className="rounded text-indigo-600 focus:ring-indigo-500"
              />
              <span>{t('profile.autoCalculate', 'Auto-calcular')}</span>
            </label>
          </div>

          <div className="bg-slate-50 border border-slate-200 rounded-2xl p-4 grid grid-cols-2 sm:grid-cols-4 gap-3">
            <Input
              label="Kcal"
              type="number"
              name="target_calories"
              value={formData.target_calories}
              onChange={handleChange}
              disabled={autoCalculate}
              className="font-mono font-bold"
            />
            <Input
              label={`${t('diary.protein', 'Proteínas')} (g)`}
              type="number"
              name="target_protein"
              value={formData.target_protein}
              onChange={handleChange}
              disabled={autoCalculate}
              className="font-mono font-bold"
            />
            <Input
              label={`${t('diary.carbs', 'Carbos')} (g)`}
              type="number"
              name="target_carbs"
              value={formData.target_carbs}
              onChange={handleChange}
              disabled={autoCalculate}
              className="font-mono font-bold"
            />
            <Input
              label={`${t('diary.fats', 'Grasas')} (g)`}
              type="number"
              name="target_fats"
              value={formData.target_fats}
              onChange={handleChange}
              disabled={autoCalculate}
              className="font-mono font-bold"
            />
          </div>
        </div>

        <Button
          type="submit"
          disabled={isSaving}
          icon={Save}
          variant="primary"
          size="lg"
          className="w-full justify-center mt-2"
        >
          {isSaving ? t('profile.saving', 'Guardando...') : t('profile.saveProfile', 'Guardar Perfil')}
        </Button>
      </form>
    </Card>
  );
}
