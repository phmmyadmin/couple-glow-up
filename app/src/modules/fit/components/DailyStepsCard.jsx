import React, { useState, useEffect } from 'react';
import { Footprints, Flame, Navigation, Plus, Edit2, Check, X, Smartphone, Globe, RefreshCw, ShieldAlert, Sparkles, Download } from 'lucide-react';
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
import { APP_VERSION } from '../../../version';

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
  const [showWebSyncModal, setShowWebSyncModal] = useState(false);

  const targetSteps = activeProfile?.target_steps || 10000;
  const userWeight = activeProfile?.weight || 70;
  const userHeight = activeProfile?.height || 175;
  const isNative = isNativePlatform();

  const fetchSteps = async (showFeedback = false) => {
    if (!selectedDate) return;
    setIsSyncing(true);

    try {
      if (isNative) {
        const perm = await checkNativeStepPermissions();
        setHasNativePermission(perm.granted);
      }

      const data = await getStepData(selectedDate, activeProfile?.id);
      setSteps(data.steps || 0);
      setSource(data.source || 'none');

      if (showFeedback && setToastMessage) {
        if (data.steps > 0) {
          setToastMessage(`👣 Synced ${data.steps.toLocaleString()} steps with Samsung Health!`);
        } else {
          setToastMessage('👣 Steps synced (0 steps recorded for today).');
        }
      }
    } catch (err) {
      console.warn('Error fetching steps:', err);
    } finally {
      setIsSyncing(false);
    }
  };

  // Load steps on date or profile change
  useEffect(() => {
    fetchSteps(false);
  }, [selectedDate, activeProfile?.id]);

  const handleSyncButton = async () => {
    if (isNative) {
      if (!hasNativePermission) {
        const res = await requestNativeStepPermissions();
        if (res.granted) {
          setHasNativePermission(true);
          if (setToastMessage) setToastMessage('✅ Step sensor access granted! Syncing...');
          await fetchSteps(true);
        } else {
          if (setToastMessage) setToastMessage('⚠️ Permission was denied in Android settings.');
        }
      } else {
        await fetchSteps(true);
      }
    } else {
      setShowWebSyncModal(true);
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
                  <Smartphone className="w-3.5 h-3.5" /> Samsung Health Connected
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
            onClick={() => {
              setEditStepInput(String(steps || ''));
              setIsEditing(true);
            }}
            className="p-1.5 text-slate-400 hover:text-indigo-600 rounded-xl hover:bg-slate-100 transition-colors cursor-pointer"
            title="Edit daily steps manually"
          >
            <Edit2 className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Permission Warning Banner on Native Android */}
      {isNative && !hasNativePermission && (
        <div className="p-3.5 bg-amber-50 border border-amber-200 rounded-2xl flex items-center justify-between gap-3 text-xs text-amber-900">
          <div className="flex items-center gap-2.5">
            <ShieldAlert className="w-5 h-5 text-amber-600 shrink-0" />
            <div>
              <p className="font-bold">Step Tracking Permission Required</p>
              <p className="text-[11px] text-amber-700">Grant permission to read Samsung Health step sensor.</p>
            </div>
          </div>
          <button
            type="button"
            onClick={handleSyncButton}
            className="px-3 py-1.5 bg-amber-600 hover:bg-amber-700 text-white font-black rounded-xl text-xs transition-colors cursor-pointer shrink-0 shadow-xs"
          >
            Grant Access
          </button>
        </div>
      )}

      {/* Main Steps Display & Progress Bar */}
      <div className="space-y-2.5">
        <div className="flex items-baseline justify-between">
          <div className="flex items-baseline gap-2">
            <span className="text-3xl sm:text-4xl font-black text-slate-900 font-mono tracking-tight">
              {steps.toLocaleString()}
            </span>
            <span className="text-xs font-bold text-slate-400">
              / {targetSteps.toLocaleString()} steps
            </span>
          </div>
          <span className="text-xs font-black text-emerald-600 font-mono bg-emerald-50 px-2.5 py-1 rounded-xl border border-emerald-200">
            {progressPercent}%
          </span>
        </div>

        {/* Progress Bar */}
        <div className="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden border border-slate-200/60 p-0.5">
          <div
            className="bg-gradient-to-r from-emerald-500 to-teal-500 h-2.5 rounded-full transition-all duration-500 shadow-xs"
            style={{ width: `${Math.min(100, progressPercent)}%` }}
          />
        </div>
      </div>

      {/* 🚀 PROMINENT SYNC BUTTON */}
      <div>
        <button
          type="button"
          onClick={handleSyncButton}
          disabled={isSyncing}
          className="flex items-center justify-center gap-2 w-full py-2.5 px-4 bg-emerald-600 hover:bg-emerald-700 active:scale-98 text-white rounded-xl text-xs font-extrabold shadow-sm transition-all cursor-pointer disabled:opacity-50"
        >
          <RefreshCw className={`w-4 h-4 ${isSyncing ? 'animate-spin' : ''}`} />
          <span>{isSyncing ? 'Syncing Steps...' : 'Sync with Samsung Health'}</span>
        </button>
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

      {/* Web Sync / APK Download Information Modal */}
      {showWebSyncModal && (
        <div
          className="fixed inset-0 z-50 bg-slate-900/40 backdrop-blur-xs flex items-center justify-center p-4 cursor-pointer"
          onClick={() => setShowWebSyncModal(false)}
        >
          <Card
            className="max-w-sm w-full p-5 space-y-4 shadow-xl border border-slate-200 cursor-default rounded-2xl bg-white"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Smartphone className="w-5 h-5 text-emerald-600" />
                <CardTitle className="text-sm">Samsung Health Sync</CardTitle>
              </div>
              <button
                type="button"
                onClick={() => setShowWebSyncModal(false)}
                className="p-1 text-slate-400 hover:text-slate-600 rounded-lg"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <p className="text-xs text-slate-600 leading-relaxed">
              Real-time hardware step sensor synchronization requires the <strong>OpenFit Native Android App (APK)</strong>.
            </p>

            <div className="space-y-2 pt-1">
              <a
                href="./openfit.apk"
                download={`openfit-v${APP_VERSION}.apk`}
                className="flex items-center justify-center gap-2 w-full py-3 px-4 bg-slate-900 hover:bg-slate-800 text-white rounded-xl text-xs font-black shadow-sm transition-all text-center"
              >
                <Download className="w-4 h-4 text-emerald-400" />
                <span>Download OpenFit APK v{APP_VERSION} (Android)</span>
              </a>

              <button
                type="button"
                onClick={() => {
                  setShowWebSyncModal(false);
                  setEditStepInput(String(steps || ''));
                  setIsEditing(true);
                }}
                className="w-full py-2.5 px-4 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-xs font-bold transition-all"
              >
                Enter Steps Manually
              </button>
            </div>
          </Card>
        </div>
      )}

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
