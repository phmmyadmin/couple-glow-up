import React, { useState, useEffect } from 'react';
import { Footprints, Flame, Navigation, Plus, Edit2, Check, X, Smartphone, Globe, RefreshCw, ShieldAlert } from 'lucide-react';
import Card, { CardTitle } from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import {
  getStepData,
  saveManualSteps,
  calculateStepCalories,
  calculateStepDistanceKm,
  getStepProgressPercent,
  isNativePlatform,
  checkNativeStepPermissions,
  requestNativeStepPermissions,
} from '../../../lib/health-connect';

export default function DailyStepsCard({
  selectedDate,
  activeProfile,
  setToastMessage,
}) {
  const [steps, setSteps] = useState(0);
  const [source, setSource] = useState('none');
  const [isEditing, setIsEditing] = useState(false);
  const [editStepInput, setEditStepInput] = useState('');
  const [isSyncing, setIsSyncing] = useState(false);
  const [hasNativePermission, setHasNativePermission] = useState(true);

  const targetSteps = activeProfile?.target_steps || 10000;
  const userWeight = activeProfile?.weight || 70;
  const userHeight = activeProfile?.height || 175;
  const isNative = isNativePlatform();

  const fetchSteps = async () => {
    if (!selectedDate) return;
    setIsSyncing(true);

    if (isNative) {
      const perm = await checkNativeStepPermissions();
      setHasNativePermission(perm.granted);
    }

    const data = await getStepData(selectedDate, activeProfile?.id);
    setSteps(data.steps || 0);
    setSource(data.source || 'none');
    setIsSyncing(false);
  };

  // Load steps on date or profile change
  useEffect(() => {
    fetchSteps();
  }, [selectedDate, activeProfile?.id]);

  const handleRequestPermission = async () => {
    const res = await requestNativeStepPermissions();
    if (res.granted) {
      setHasNativePermission(true);
      if (setToastMessage) setToastMessage('✅ Step tracking permission granted!');
      await fetchSteps();
    } else {
      if (setToastMessage) setToastMessage('⚠️ Permission was denied in Android settings.');
    }
  };

  const calories = calculateStepCalories(steps, userWeight);
  const distanceKm = calculateStepDistanceKm(steps, userHeight);
  const progressPercent = getStepProgressPercent(steps, targetSteps);

  const handleSaveEdit = async (e) => {
    if (e) e.preventDefault();
    const newSteps = parseInt(editStepInput, 10);
    if (!isNaN(newSteps) && newSteps >= 0) {
      await saveManualSteps(selectedDate, newSteps, activeProfile?.id);
      setSteps(newSteps);
      setSource('local');
      if (setToastMessage) setToastMessage(`👣 Updated steps to ${newSteps.toLocaleString()}`);
    }
    setIsEditing(false);
  };

  const handleQuickAdd = async (delta) => {
    const next = Math.max(0, steps + delta);
    await saveManualSteps(selectedDate, next, activeProfile?.id);
    setSteps(next);
    setSource('local');
    if (setToastMessage) setToastMessage(`👣 Added +${delta.toLocaleString()} steps!`);
  };

  return (
    <Card className="p-5 space-y-4 shadow-sm border border-slate-200/90">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2.5">
          <div className="p-2 bg-emerald-50 text-emerald-600 rounded-xl">
            <Footprints className="w-5 h-5" />
          </div>
          <div>
            <CardTitle className="text-base">Daily Steps & Activity</CardTitle>
            <div className="flex items-center gap-1.5 text-xs text-slate-500 font-medium">
              {isNative ? (
                <span className="flex items-center gap-1 text-emerald-700 font-semibold">
                  <Smartphone className="w-3.5 h-3.5" /> Samsung Health Sync
                </span>
              ) : (
                <span className="flex items-center gap-1 text-slate-500">
                  <Globe className="w-3.5 h-3.5" /> OpenFit Step Tracker
                </span>
              )}
            </div>
          </div>
        </div>

        {/* Action Buttons */}
        <div className="flex items-center gap-1">
          <button
            type="button"
            onClick={fetchSteps}
            disabled={isSyncing}
            className="p-1.5 text-slate-400 hover:text-emerald-600 rounded-xl hover:bg-slate-100 transition-colors cursor-pointer disabled:opacity-50"
            title="Sync latest steps"
          >
            <RefreshCw className={`w-4 h-4 ${isSyncing ? 'animate-spin text-emerald-600' : ''}`} />
          </button>
          <button
            type="button"
            onClick={() => {
              setEditStepInput(String(steps || ''));
              setIsEditing(true);
            }}
            className="p-1.5 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-slate-100 transition-colors cursor-pointer"
            title="Edit daily steps"
          >
            <Edit2 className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Permission Warning Banner on Native Android */}
      {isNative && !hasNativePermission && (
        <div className="p-3 bg-amber-50 border border-amber-200 rounded-xl flex items-center justify-between gap-3 text-xs text-amber-900">
          <div className="flex items-center gap-2">
            <ShieldAlert className="w-4 h-4 text-amber-600 shrink-0" />
            <span className="font-medium">Step sensor permission is required.</span>
          </div>
          <button
            type="button"
            onClick={handleRequestPermission}
            className="px-2.5 py-1 bg-amber-600 text-white font-bold rounded-lg text-xs hover:bg-amber-700 transition-colors cursor-pointer shrink-0"
          >
            Grant Access
          </button>
        </div>
      )}

      {/* Main Steps Display & Progress Bar */}
      <div className="space-y-2.5">
        <div className="flex items-baseline justify-between">
          <div className="flex items-baseline gap-2">
            <span className="text-3xl font-black text-slate-900 font-mono tracking-tight">
              {steps.toLocaleString()}
            </span>
            <span className="text-xs font-bold text-slate-400">
              / {targetSteps.toLocaleString()} steps
            </span>
          </div>
          <span className="text-xs font-black text-emerald-600 font-mono bg-emerald-50 px-2 py-0.5 rounded-lg border border-emerald-100">
            {progressPercent}%
          </span>
        </div>

        {/* Progress Bar */}
        <div className="w-full bg-slate-100 rounded-full h-3 overflow-hidden border border-slate-200/60">
          <div
            className="bg-gradient-to-r from-emerald-500 to-teal-500 h-3 rounded-full transition-all duration-500"
            style={{ width: `${Math.min(100, progressPercent)}%` }}
          />
        </div>
      </div>

      {/* Secondary Metrics: Calories & Distance */}
      <div className="grid grid-cols-2 gap-3 pt-1">
        <div className="bg-slate-50 border border-slate-200/80 rounded-2xl p-3 flex items-center gap-3">
          <div className="p-2 bg-amber-100 text-amber-600 rounded-xl">
            <Flame className="w-4 h-4 fill-amber-500 text-amber-500" />
          </div>
          <div>
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
              Step Calories
            </span>
            <span className="text-sm font-extrabold text-slate-800 font-mono">
              {calories.toLocaleString()} <span className="text-xs font-normal text-slate-500 font-sans">kcal</span>
            </span>
          </div>
        </div>

        <div className="bg-slate-50 border border-slate-200/80 rounded-2xl p-3 flex items-center gap-3">
          <div className="p-2 bg-indigo-100 text-indigo-600 rounded-xl">
            <Navigation className="w-4 h-4 text-indigo-600" />
          </div>
          <div>
            <span className="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">
              Distance
            </span>
            <span className="text-sm font-extrabold text-slate-800 font-mono">
              {distanceKm} <span className="text-xs font-normal text-slate-500 font-sans">km</span>
            </span>
          </div>
        </div>
      </div>

      {/* Quick Add Buttons for Adjustments */}
      <div className="flex items-center gap-1.5 flex-wrap pt-1 border-t border-slate-100 text-xs">
        <span className="text-[11px] font-bold text-slate-400 mr-1">Quick Add:</span>
        {[+1000, +2500, +5000].map((delta) => (
          <button
            key={delta}
            type="button"
            onClick={() => handleQuickAdd(delta)}
            className="px-2.5 py-1 bg-slate-100 hover:bg-emerald-50 hover:text-emerald-700 text-slate-700 font-mono font-bold text-[11px] rounded-lg border border-slate-200/80 transition-colors cursor-pointer"
          >
            +{delta.toLocaleString()}
          </button>
        ))}
      </div>

      {/* Manual Step Edit Modal */}
      {isEditing && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-xs flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setIsEditing(false)}
        >
          <Card
            className="max-w-xs w-full p-5 space-y-4 shadow-xl border border-slate-200 cursor-default rounded-2xl bg-white"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between">
              <CardTitle icon={Footprints}>Edit Daily Steps</CardTitle>
              <button
                type="button"
                onClick={() => setIsEditing(false)}
                className="p-1 text-slate-400 hover:text-slate-600 rounded-lg"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <form onSubmit={handleSaveEdit} className="space-y-4">
              <div>
                <label className="block text-xs font-bold text-slate-700 mb-1">Total Steps Count</label>
                <input
                  type="number"
                  min="0"
                  max="100000"
                  value={editStepInput}
                  onChange={(e) => setEditStepInput(e.target.value)}
                  onFocus={(e) => e.target.select()}
                  placeholder="e.g. 10000"
                  autoFocus
                  required
                  className="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-300 rounded-xl text-lg font-extrabold font-mono text-center text-slate-900 focus:outline-none focus:border-emerald-500 focus:bg-white"
                />
              </div>

              <div className="flex justify-end gap-2 pt-1">
                <Button type="button" variant="ghost" size="sm" onClick={() => setIsEditing(false)}>
                  Cancel
                </Button>
                <Button variant="primary" size="sm" type="submit" icon={Check}>
                  Save Steps
                </Button>
              </div>
            </form>
          </Card>
        </div>
      )}
    </Card>
  );
}
