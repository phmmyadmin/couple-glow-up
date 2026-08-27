import React, { useState, useEffect } from 'react';
import { Save, User, Activity, Target, Key, Sparkles, RefreshCw, Smartphone, Download } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { saveProfile } from '../../../lib/supabase';
import { calculateProfileTargets, calculateMaintenanceTDEE } from '../../../utils/profile';
import { getGeminiApiKey, setGeminiApiKey } from '../../../lib/gemini';
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
  maintenance_calories: 2450,
  target_calories: 2000,
  target_protein: 150,
  target_carbs: 200,
  target_fats: 60,
  target_fiber: 30,
  target_sugar: 50,
  target_sodium: 2300,
};

const getNormalizedProfile = (prof) => {
  if (!prof) return defaultForm;
  return {
    ...defaultForm,
    ...prof,
    maintenance_calories:
      prof.maintenance_calories ||
      prof.maintenanceCalories ||
      defaultForm.maintenance_calories,
    target_calories:
      prof.target_calories ||
      prof.target_macros?.calories ||
      defaultForm.target_calories,
    target_protein:
      prof.target_protein ||
      prof.target_macros?.protein ||
      defaultForm.target_protein,
    target_carbs:
      prof.target_carbs ||
      prof.target_macros?.carbs ||
      defaultForm.target_carbs,
    target_fats:
      prof.target_fats ||
      prof.target_macros?.fats ||
      defaultForm.target_fats,
    target_fiber:
      prof.target_fiber ||
      prof.target_macros?.fiber ||
      defaultForm.target_fiber,
    target_sugar:
      prof.target_sugar ||
      prof.target_macros?.sugar ||
      defaultForm.target_sugar,
    target_sodium:
      prof.target_sodium ||
      prof.target_macros?.sodium ||
      defaultForm.target_sodium,
  };
};

export default function ProfileView({
  profile,
  activeProfile,
  onProfileSaved,
  onSaved,
  setToastMessage,
}) {
  const { t } = useTranslation();
  const targetProf = profile || activeProfile;
  const [formData, setFormData] = useState(() => getNormalizedProfile(targetProf));
  const [isSaving, setIsSaving] = useState(false);
  const [geminiKeyInput, setGeminiKeyInput] = useState(() => getGeminiApiKey());

  useEffect(() => {
    const current = profile || activeProfile;
    setFormData(getNormalizedProfile(current));
  }, [profile, activeProfile]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    const numFields = [
      'age',
      'height',
      'weight',
      'target_weight',
      'maintenance_calories',
      'target_calories',
      'target_protein',
      'target_carbs',
      'target_fats',
      'target_fiber',
      'target_sugar',
      'target_sodium',
    ];
    const finalValue = numFields.includes(name) ? (value === '' ? '' : Number(value)) : value;
    setFormData((prev) => ({ ...prev, [name]: finalValue }));
  };

  const handleRecalculateFormula = () => {
    const maint = calculateMaintenanceTDEE(formData);
    const targets = calculateProfileTargets(formData);
    setFormData((prev) => ({
      ...prev,
      maintenance_calories: maint,
      target_calories: targets.calories,
      target_protein: targets.protein,
      target_carbs: targets.carbs,
      target_fats: targets.fats,
    }));
    if (typeof setToastMessage === 'function') {
      setToastMessage('✨ Valores recalculados según fórmula Mifflin-St Jeor');
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSaving(true);

    const payload = {
      ...formData,
      target_calories: Number(formData.target_calories) || 2000,
      target_protein: Number(formData.target_protein) || 150,
      target_carbs: Number(formData.target_carbs) || 200,
      target_fats: Number(formData.target_fats) || 60,
      target_fiber: Number(formData.target_fiber) || 30,
      target_sugar: Number(formData.target_sugar) || 50,
      target_sodium: Number(formData.target_sodium) || 2300,
      target_macros: {
        calories: Number(formData.target_calories) || 2000,
        protein: Number(formData.target_protein) || 150,
        carbs: Number(formData.target_carbs) || 200,
        fats: Number(formData.target_fats) || 60,
        fiber: Number(formData.target_fiber) || 30,
        sugar: Number(formData.target_sugar) || 50,
        sodium: Number(formData.target_sodium) || 2300,
      },
    };

    const saved = await saveProfile(payload);
    setIsSaving(false);

    if (saved) {
      if (onProfileSaved) onProfileSaved(saved);
      if (onSaved) onSaved(saved);
      if (setToastMessage) setToastMessage(t('toast.profileSaved', 'Profile saved successfully'));
    }
  };

  return (
    <Card className="max-w-xl mx-auto p-5 sm:p-6 space-y-6">
      <div className="flex items-center justify-between border-b border-slate-100 pb-3">
        <CardTitle icon={User} className="text-lg">
          {t('profile.settings', 'Profile Settings')}
        </CardTitle>
      </div>

      <form onSubmit={handleSubmit} className="space-y-5">
        {/* 1. Basic Information */}
        <div className="space-y-3">
          <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">
            Información Básica
          </h4>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3.5">
            <Input
              label={t('profile.name', 'Name')}
              name="name"
              value={formData.name || ''}
              onChange={handleChange}
              required
            />
            <Select
              label={t('profile.gender', 'Gender')}
              name="gender"
              value={formData.gender || 'male'}
              onChange={handleChange}
            >
              <option value="male">{t('profile.male', 'Male')}</option>
              <option value="female">{t('profile.female', 'Female')}</option>
            </Select>
            <Select
              label={t('profile.language', 'Language')}
              name="language"
              value={formData.language || 'es'}
              onChange={handleChange}
            >
              <option value="es">Español</option>
              <option value="en">English</option>
            </Select>
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3.5">
            <Input
              label={t('profile.age', 'Age')}
              type="number"
              name="age"
              value={formData.age ?? ''}
              onChange={handleChange}
              required
            />
            <Input
              label={t('profile.height', 'Height (cm)')}
              type="number"
              name="height"
              value={formData.height ?? ''}
              onChange={handleChange}
              required
            />
            <Input
              label={t('profile.weight', 'Weight (kg)')}
              type="number"
              step="0.1"
              name="weight"
              value={formData.weight ?? ''}
              onChange={handleChange}
              required
            />
            <Input
              label={t('profile.targetWeight', 'Target (kg)')}
              type="number"
              step="0.1"
              name="target_weight"
              value={formData.target_weight ?? ''}
              onChange={handleChange}
              required
            />
          </div>
        </div>

        {/* 2. Activity & Goal Strategy */}
        <div className="pt-3 border-t border-slate-100 space-y-3">
          <CardTitle icon={Activity} className="text-sm">
            {t('profile.activityAndGoal', 'Activity & Goal')}
          </CardTitle>

          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3.5">
            <Select
              label={t('profile.activityLevel', 'Activity Level')}
              name="activity_level"
              value={formData.activity_level || 'moderate'}
              onChange={handleChange}
            >
              <option value="sedentary">{t('profile.sedentary', 'Sedentary')}</option>
              <option value="light">{t('profile.light', 'Light')}</option>
              <option value="moderate">{t('profile.moderate', 'Moderate')}</option>
              <option value="active">{t('profile.active', 'Active')}</option>
              <option value="very_active">{t('profile.veryActive', 'Very Active')}</option>
            </Select>

            <Select
              label={t('profile.goal', 'Goal')}
              name="goal"
              value={formData.goal || 'lose'}
              onChange={handleChange}
            >
              <option value="lose">{t('profile.loseWeight', 'Lose Weight')}</option>
              <option value="maintain">{t('profile.maintainWeight', 'Maintain')}</option>
              <option value="gain">{t('profile.gainWeight', 'Gain Muscle')}</option>
            </Select>

            <Select
              label={t('profile.pace', 'Pace')}
              name="pace"
              value={formData.pace || 'moderate'}
              onChange={handleChange}
            >
              <option value="relaxed">{t('profile.paceRelaxed', 'Relaxed')}</option>
              <option value="moderate">{t('profile.paceModerate', 'Moderate')}</option>
              <option value="aggressive">{t('profile.paceAggressive', 'Aggressive')}</option>
            </Select>
          </div>
        </div>

        {/* 3. Fully Modifiable Nutrition Targets & Calories */}
        <div className="pt-3 border-t border-slate-100 space-y-3">
          <div className="flex items-center justify-between gap-2 flex-wrap">
            <CardTitle icon={Target} className="text-sm">
              Objetivos Nutricionales y Macros (Personalizables)
            </CardTitle>

            <button
              type="button"
              onClick={handleRecalculateFormula}
              className="text-xs text-indigo-600 hover:text-indigo-800 font-bold flex items-center gap-1.5 bg-indigo-50 hover:bg-indigo-100 px-3 py-1.5 rounded-xl border border-indigo-200 transition-all cursor-pointer"
              title="Calcular valores sugeridos con Mifflin-St Jeor"
            >
              <Sparkles className="w-3.5 h-3.5 text-indigo-500" />
              <span>Autocalcular con Fórmula</span>
            </button>
          </div>

          <p className="text-xs text-slate-500">
            Todos los valores son 100% editables. Puedes ajustarlos a mano o pulsar el botón superior para calcular la recomendación científica.
          </p>

          {/* Energy Targets Grid */}
          <div className="bg-slate-50 border border-slate-200/90 rounded-2xl p-4 space-y-4 shadow-2xs">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
              <Input
                label="TDEE Mantenimiento (kcal/día)"
                type="number"
                name="maintenance_calories"
                value={formData.maintenance_calories ?? ''}
                onChange={handleChange}
                className="font-mono font-bold"
              />
              <Input
                label="Calorías Objetivo (kcal/día)"
                type="number"
                name="target_calories"
                value={formData.target_calories ?? ''}
                onChange={handleChange}
                className="font-mono font-bold"
              />
            </div>

            {/* Primary Macros */}
            <div className="grid grid-cols-3 gap-3 pt-2 border-t border-slate-200/60">
              <Input
                label="Proteína (g)"
                type="number"
                name="target_protein"
                value={formData.target_protein ?? ''}
                onChange={handleChange}
                className="font-mono font-bold"
              />
              <Input
                label="Carbos (g)"
                type="number"
                name="target_carbs"
                value={formData.target_carbs ?? ''}
                onChange={handleChange}
                className="font-mono font-bold"
              />
              <Input
                label="Grasas (g)"
                type="number"
                name="target_fats"
                value={formData.target_fats ?? ''}
                onChange={handleChange}
                className="font-mono font-bold"
              />
            </div>

            {/* Health & Micronutrients */}
            <div className="grid grid-cols-3 gap-3 pt-2 border-t border-slate-200/60">
              <Input
                label="🌾 Fibra Mín (g)"
                type="number"
                name="target_fiber"
                value={formData.target_fiber ?? 30}
                onChange={handleChange}
                className="font-mono font-bold"
              />
              <Input
                label="🍬 Límite Azúcar (g)"
                type="number"
                name="target_sugar"
                value={formData.target_sugar ?? 50}
                onChange={handleChange}
                className="font-mono font-bold"
              />
              <Input
                label="🧂 Límite Sodio (mg)"
                type="number"
                name="target_sodium"
                value={formData.target_sodium ?? 2300}
                onChange={handleChange}
                className="font-mono font-bold"
              />
            </div>
          </div>
        </div>

        {/* 4. Gemini AI API Key */}
        <div className="space-y-2 pt-3 border-t border-slate-100">
          <CardTitle icon={Key} className="text-sm">
            Google Gemini AI API Key
          </CardTitle>

          <p className="text-xs text-slate-500">
            Gemini AI parses meal text, photo logs, and calculates exact calories and macro distributions.
          </p>

          <div className="flex items-center gap-2">
            <Input
              type="password"
              placeholder="AIzaSy..."
              value={geminiKeyInput}
              onChange={(e) => {
                setGeminiKeyInput(e.target.value);
                setGeminiApiKey(e.target.value);
              }}
              className="font-mono text-xs flex-1"
            />
            <Button
              type="button"
              variant="secondary"
              size="sm"
              onClick={() => {
                setGeminiApiKey(geminiKeyInput);
                if (typeof setToastMessage === 'function') {
                  setToastMessage('✅ Gemini API Key saved to local storage.');
                }
              }}
            >
              Save Key
            </Button>
          </div>
        </div>

        {/* 5. Native Android App (.APK) Download */}
        <div className="space-y-2 pt-3 border-t border-slate-100">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <Smartphone className="w-4 h-4 text-emerald-600" />
              <span className="text-xs font-bold text-slate-800">Native Android App (APK)</span>
            </div>
            <span className="text-[10px] font-bold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-md border border-emerald-200">
              Samsung Health Sync
            </span>
          </div>

          <p className="text-xs text-slate-500">
            Install the native OpenFit Android app on your phone for direct Samsung Health / Health Connect step sync and Home Screen widgets.
          </p>

          <a
            href="./openfit.apk"
            download="openfit.apk"
            className="flex items-center justify-center gap-2 w-full py-2.5 px-4 bg-slate-900 hover:bg-slate-800 text-white rounded-xl text-xs font-extrabold shadow-sm transition-all text-center"
          >
            <Download className="w-4 h-4" />
            <span>Download OpenFit Android APK</span>
          </a>
        </div>

        {/* Save Button */}
        <Button
          type="submit"
          disabled={isSaving}
          icon={Save}
          variant="primary"
          size="lg"
          className="w-full justify-center mt-3 cursor-pointer shadow-md"
        >
          {isSaving ? t('profile.saving', 'Saving...') : 'Save Profile & Targets'}
        </Button>
      </form>
    </Card>
  );
}
