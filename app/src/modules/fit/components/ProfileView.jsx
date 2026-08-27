import React, { useState, useEffect } from 'react';
import { Save, User, Activity, Target, Key, Sparkles, Smartphone, Download, CheckCircle2 } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { saveProfile } from '../../../lib/supabase';
import { calculateProfileTargets, calculateMaintenanceTDEE } from '../../../utils/profile';
import { getGeminiApiKey, setGeminiApiKey } from '../../../lib/gemini';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input, Select } from '../../../shared/ui/Input';
import { APP_VERSION, APP_BUILD, APP_RELEASE_DATE } from '../../../version';

const defaultForm = {
  name: '',
  gender: 'male',
  language: 'en',
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
  target_steps: 10000,
};

const getNormalizedProfile = (prof) => {
  if (!prof) return defaultForm;
  return {
    ...defaultForm,
    ...prof,
    language: prof.language || 'en',
    target_steps: prof.target_steps || prof.targetSteps || defaultForm.target_steps,
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
      'target_steps',
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
      setToastMessage('✨ Recalculated targets using Mifflin-St Jeor formula');
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsSaving(true);

    const payload = {
      ...formData,
      target_steps: Number(formData.target_steps) || 10000,
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
    <div className="max-w-xl mx-auto space-y-5">
      {/* 📱 1. PROMINENT NATIVE ANDROID APP DOWNLOAD CARD */}
      <Card className="p-5 sm:p-6 bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-900 text-white border border-slate-800 shadow-xl space-y-4 rounded-3xl">
        <div className="flex items-start justify-between gap-3">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-emerald-500/10 text-emerald-400 rounded-2xl border border-emerald-500/20 shrink-0">
              <Smartphone className="w-7 h-7" />
            </div>
            <div>
              <div className="flex items-center gap-2 flex-wrap">
                <h3 className="font-black text-base sm:text-lg text-white">OpenFit Native Android App</h3>
                <span className="px-2.5 py-0.5 bg-emerald-500/20 text-emerald-300 font-mono font-black text-xs rounded-full border border-emerald-500/40 shadow-xs">
                  v{APP_VERSION}
                </span>
              </div>
              <p className="text-xs text-slate-300 font-medium mt-0.5">
                Official Samsung Health & Health Connect sync, steps & offline tracking.
              </p>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs text-slate-300 pt-1">
          <div className="flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
            <span>Samsung Health / Health Connect (Android 14)</span>
          </div>
          <div className="flex items-center gap-2">
            <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
            <span>Live Step Sync & Supabase Cloud Backup</span>
          </div>
        </div>

        <div className="pt-2 space-y-2">
          <a
            href="./openfit.apk"
            download={`openfit-v${APP_VERSION}.apk`}
            className="flex items-center justify-center gap-2.5 w-full py-4 px-5 bg-emerald-500 hover:bg-emerald-400 active:scale-98 text-slate-950 rounded-2xl font-black text-sm shadow-lg transition-all text-center cursor-pointer"
          >
            <Download className="w-5 h-5 stroke-[2.5]" />
            <span>Download OpenFit APK v{APP_VERSION} (Build {APP_BUILD})</span>
          </a>
          <div className="flex items-center justify-between text-[11px] text-slate-400 px-1">
            <span>Direct download from GitHub Pages</span>
            <span className="font-mono font-bold text-emerald-400">Version: v{APP_VERSION} • {APP_RELEASE_DATE}</span>
          </div>
        </div>
      </Card>

      {/* 2. PROFILE & NUTRITION TARGETS SETTINGS CARD */}
      <Card className="p-5 sm:p-6 space-y-6 shadow-sm border border-slate-200/90">
        <div className="flex items-center justify-between border-b border-slate-100 pb-3">
          <CardTitle icon={User} className="text-lg">
            {t('profile.settings', 'Profile Settings')}
          </CardTitle>
        </div>

        <form onSubmit={handleSubmit} className="space-y-5">
          {/* Basic Information */}
          <div className="space-y-3">
            <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">
              Basic Information
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
                value={formData.language || 'en'}
                onChange={handleChange}
              >
                <option value="en">English</option>
                <option value="es">Español</option>
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

          {/* Activity & Goal Strategy */}
          <div className="pt-3 border-t border-slate-100 space-y-3">
            <CardTitle icon={Activity} className="text-sm">
              {t('profile.activityAndGoal', 'Activity & Goal')}
            </CardTitle>

            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-3.5">
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

              <Input
                label="Daily Steps Goal"
                type="number"
                name="target_steps"
                value={formData.target_steps ?? 10000}
                onChange={handleChange}
                className="font-mono font-bold"
              />
            </div>
          </div>

          {/* Fully Modifiable Nutrition Targets & Calories */}
          <div className="pt-3 border-t border-slate-100 space-y-3">
            <div className="flex items-center justify-between gap-2 flex-wrap">
              <CardTitle icon={Target} className="text-sm">
                Nutrition Targets & Macros (Customizable)
              </CardTitle>

              <button
                type="button"
                onClick={handleRecalculateFormula}
                className="text-xs text-indigo-600 hover:text-indigo-800 font-bold flex items-center gap-1.5 bg-indigo-50 hover:bg-indigo-100 px-3 py-1.5 rounded-xl border border-indigo-200 transition-all cursor-pointer"
                title="Calculate targets with Mifflin-St Jeor formula"
              >
                <Sparkles className="w-3.5 h-3.5 text-indigo-500" />
                <span>Auto-Calculate with Formula</span>
              </button>
            </div>

            <p className="text-xs text-slate-500">
              All targets are 100% editable. Adjust manually or click the button above for scientific recommendations.
            </p>

            {/* Energy Targets Grid */}
            <div className="bg-slate-50 border border-slate-200/90 rounded-2xl p-4 space-y-4 shadow-2xs">
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                <Input
                  label="Maintenance TDEE (kcal/day)"
                  type="number"
                  name="maintenance_calories"
                  value={formData.maintenance_calories ?? ''}
                  onChange={handleChange}
                  className="font-mono font-bold"
                />
                <Input
                  label="Target Calories (kcal/day)"
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
                  label="Protein (g)"
                  type="number"
                  name="target_protein"
                  value={formData.target_protein ?? ''}
                  onChange={handleChange}
                  className="font-mono font-bold"
                />
                <Input
                  label="Carbs (g)"
                  type="number"
                  name="target_carbs"
                  value={formData.target_carbs ?? ''}
                  onChange={handleChange}
                  className="font-mono font-bold"
                />
                <Input
                  label="Fats (g)"
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
                  label="🌾 Min Fiber (g)"
                  type="number"
                  name="target_fiber"
                  value={formData.target_fiber ?? 30}
                  onChange={handleChange}
                  className="font-mono font-bold"
                />
                <Input
                  label="🍬 Sugar Limit (g)"
                  type="number"
                  name="target_sugar"
                  value={formData.target_sugar ?? 50}
                  onChange={handleChange}
                  className="font-mono font-bold"
                />
                <Input
                  label="🧂 Sodium Limit (mg)"
                  type="number"
                  name="target_sodium"
                  value={formData.target_sodium ?? 2300}
                  onChange={handleChange}
                  className="font-mono font-bold"
                />
              </div>
            </div>
          </div>

          {/* Gemini AI API Key */}
          <div className="space-y-2 pt-3 border-t border-slate-100">
            <CardTitle icon={Key} className="text-sm">
              Google Gemini AI API Key
            </CardTitle>

            <p className="text-xs text-slate-500">
              Gemini AI parses meal text, photo logs, and calculates exact calories and macro distributions automatically.
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

          {/* Save Button */}
          <Button
            type="submit"
            disabled={isSaving}
            icon={Save}
            variant="primary"
            size="lg"
            className="w-full justify-center mt-3 cursor-pointer shadow-md font-bold"
          >
            {isSaving ? t('profile.saving', 'Saving...') : 'Save Profile & Targets'}
          </Button>
        </form>

        {/* Version Information */}
        <div className="text-center pt-2 pb-1 text-[11px] text-slate-400 font-medium">
          OpenFit v{APP_VERSION} (Build {APP_BUILD}) • Release {APP_RELEASE_DATE}
        </div>
      </Card>
    </div>
  );
}
