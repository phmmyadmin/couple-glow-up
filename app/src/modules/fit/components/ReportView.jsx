import React, { useState, useMemo } from 'react';
import { 
  Scale, Plus, Trash2, TrendingDown, TrendingUp, Target, 
  Flame, ChevronLeft, ChevronRight, PieChart, X, Check, 
  Calendar, Award, Activity, Sparkles, Zap
} from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { supabase, saveWeightToSupabase, deleteWeightFromSupabase, fetchDailyLogsFromSupabase } from '../../../lib/supabase';
import { getCategoryInfo } from '../../../utils/category';

export default function ReportView({ data, setData, activeProfileId, activeProfile, onUpdateProfile, selectedDate, onSelectDate, onUpdateCategory, setToastMessage }) {
  const { t, i18n } = useTranslation();
  const locale = i18n.language.startsWith('es') ? 'es-ES' : 'en-US';

  // Sub-section filter pills for fast navigation
  const [activeSection, setActiveSection] = useState('all'); // 'all', 'weight', 'weekly', 'monthly', 'history'

  // Weigh-in Form State
  const todayStr = new Date().toISOString().slice(0, 10);
  const currentTimeStr = new Date().toTimeString().slice(0, 5);
  const [inputDate, setInputDate] = useState(todayStr);
  const [inputTime, setInputTime] = useState(currentTimeStr);
  const [inputWeight, setInputWeight] = useState('');
  const [isSubmittingWeight, setIsSubmittingWeight] = useState(false);
  const [weightFeedback, setWeightFeedback] = useState(null);
  const [showWeightForm, setShowWeightForm] = useState(false);

  // Weekly Chart State
  const [activeMacro, setActiveMacro] = useState('calories');
  const [weekOffset, setWeekOffset] = useState(0);
  const [selectedCategoryModal, setSelectedCategoryModal] = useState(null);

  // Monthly Report State
  const [selectedMonthIndex, setSelectedMonthIndex] = useState(0);

  // Profile data
  const { userProfile, dailyLogs = [] } = data || {};
  const { maintenanceCalories = 2450, targetMacros = { calories: 2000, protein: 150, carbs: 200, fats: 60 }, weightLog } = userProfile || {};

  const startWeight = weightLog?.startWeight || 73.0;
  const targetWeight = weightLog?.targetWeight || 68.0;
  const history = weightLog?.history || [];

  // Cumulative Deficit Calculation
  const getCumulativeDeficitUpToDate = (targetDate = null) => {
    let totalDeficit = 0;
    dailyLogs.forEach(log => {
      if (!targetDate || log.date <= targetDate) {
        const dayCalories = log.dailyTotals?.calories || 0;
        const dayDeficit = maintenanceCalories - dayCalories;
        totalDeficit += dayDeficit;
      }
    });
    return totalDeficit;
  };

  const allTimeDeficit = getCumulativeDeficitUpToDate();
  const allTimeEstimatedLostKg = allTimeDeficit > 0 ? (allTimeDeficit / 7700) : 0;
  const currentEstimatedWeight = startWeight - allTimeEstimatedLostKg;

  const latestRealEntry = history.length > 0 ? history[history.length - 1] : null;
  const latestRealWeight = latestRealEntry ? latestRealEntry.weight : startWeight;

  // 7-Day Moving Average & Adaptive TDEE Engine (MacroFactor-style)
  const { movingAverage7d, prevMovingAverage7d, adaptiveTDEE, adaptiveDiff, weeklyLossRateKg } = useMemo(() => {
    if (!history || history.length === 0) {
      return { movingAverage7d: startWeight, prevMovingAverage7d: startWeight, adaptiveTDEE: null, adaptiveDiff: 0, weeklyLossRateKg: 0 };
    }

    const sorted = [...history].sort((a, b) => `${a.date} ${a.time || ''}`.localeCompare(`${b.date} ${b.time || ''}`));
    const recentWeights = sorted.slice(-7);
    const sum7 = recentWeights.reduce((acc, curr) => acc + curr.weight, 0);
    const ma7 = sum7 / recentWeights.length;

    const prevWeights = sorted.length > 7 ? sorted.slice(-14, -7) : [];
    const prevMa7 = prevWeights.length > 0 ? prevWeights.reduce((acc, curr) => acc + curr.weight, 0) / prevWeights.length : sorted[0].weight;

    const weeklyDeltaKg = ma7 - prevMa7;

    let estAdaptiveTdee = null;
    let diffTdee = 0;
    if (dailyLogs && dailyLogs.length >= 3 && sorted.length >= 2) {
      const recentLogs = dailyLogs.slice(-14);
      const totalCals = recentLogs.reduce((acc, l) => acc + (l.dailyTotals?.calories || 0), 0);
      const avgCals = totalCals / recentLogs.length;

      const firstDate = new Date(sorted[0].date);
      const lastDate = new Date(sorted[sorted.length - 1].date);
      const daysSpan = Math.max(1, Math.round((lastDate - firstDate) / (1000 * 60 * 60 * 24)));
      const totalWeightDelta = sorted[sorted.length - 1].weight - sorted[0].weight;
      const dailyCalDelta = (totalWeightDelta * 7700) / daysSpan;

      estAdaptiveTdee = Math.round(avgCals + dailyCalDelta);
      estAdaptiveTdee = Math.max(1200, Math.min(4500, estAdaptiveTdee));
      diffTdee = estAdaptiveTdee - maintenanceCalories;
    }

    return {
      movingAverage7d: Math.round(ma7 * 10) / 10,
      prevMovingAverage7d: Math.round(prevMa7 * 10) / 10,
      adaptiveTDEE: estAdaptiveTdee,
      adaptiveDiff: diffTdee,
      weeklyLossRateKg: Math.round(weeklyDeltaKg * 100) / 100,
    };
  }, [history, startWeight, dailyLogs, maintenanceCalories]);

  const [isApplyingAdaptiveTdee, setIsApplyingAdaptiveTdee] = useState(false);

  const handleApplyAdaptiveTdee = async () => {
    if (!adaptiveTDEE) return;
    const profId = activeProfileId || activeProfile?.id;
    setIsApplyingAdaptiveTdee(true);

    try {
      const currentDeficit = (userProfile?.maintenanceCalories || 2450) - (targetMacros?.calories || 2000);
      const newDeficit = Math.max(200, currentDeficit);
      const newTargetCalories = Math.max(1200, adaptiveTDEE - newDeficit);
      const currentWeight = movingAverage7d || latestRealWeight || 70;
      const newProtein = Math.round(currentWeight * 2.2);
      const remainingCals = newTargetCalories - (newProtein * 4);
      const newCarbs = Math.max(50, Math.round((remainingCals * 0.6) / 4));
      const newFats = Math.max(30, Math.round((remainingCals * 0.4) / 9));

      const updatedUserProfile = {
        ...userProfile,
        maintenanceCalories: adaptiveTDEE,
        targetMacros: {
          calories: newTargetCalories,
          protein: newProtein,
          carbs: newCarbs,
          fats: newFats,
        },
      };

      if (supabase && profId) {
        await supabase.from('profiles').update({
          maintenance_calories: adaptiveTDEE,
          target_calories: newTargetCalories,
          target_protein: newProtein,
          target_carbs: newCarbs,
          target_fats: newFats,
        }).eq('id', profId);
      }

      if (typeof setData === 'function' && data) {
        setData({
          ...data,
          userProfile: updatedUserProfile,
        });
      }

      if (typeof onUpdateProfile === 'function') {
        onUpdateProfile(updatedUserProfile);
      }

      if (typeof setToastMessage === 'function') {
        setToastMessage(`✨ Adaptive TDEE applied: ${adaptiveTDEE} kcal maintenance!`);
      }
    } catch (err) {
      console.error('Error applying adaptive TDEE:', err);
    } finally {
      setIsApplyingAdaptiveTdee(false);
    }
  };

  const weightDiffVsEstimated = latestRealWeight - currentEstimatedWeight;
  const remainingToGoal = Math.max(0, latestRealWeight - targetWeight);
  const totalGoalToLose = startWeight - targetWeight;
  const progressPercent = totalGoalToLose > 0 ? Math.min(100, Math.max(0, ((startWeight - latestRealWeight) / totalGoalToLose) * 100)) : 0;

  // Estimated Days to Goal Calculation
  const dailyTargetDeficit = Math.max(200, maintenanceCalories - (targetMacros.calories || 2000));
  const kcalRemainingToBurn = remainingToGoal * 7700;
  const daysToGoal = remainingToGoal > 0 ? Math.ceil(kcalRemainingToBurn / dailyTargetDeficit) : 0;
  
  const estimatedGoalDateObj = new Date();
  estimatedGoalDateObj.setDate(estimatedGoalDateObj.getDate() + daysToGoal);
  const formattedGoalDate = estimatedGoalDateObj.toLocaleDateString(locale, { day: 'numeric', month: 'short' });

  // Monthly Data Grouping
  const monthlyStats = useMemo(() => {
    const stats = {};
    dailyLogs.forEach(log => {
      const parts = log.date.split('-');
      if (parts.length === 3) {
        const year = parts[0];
        const monthNum = parseInt(parts[1], 10);
        const dateObj = new Date(year, monthNum - 1, 1);
        const monthNameStr = dateObj.toLocaleDateString(locale, { month: 'long', year: 'numeric' });
        const monthName = monthNameStr.charAt(0).toUpperCase() + monthNameStr.slice(1);
        const monthKey = `${year}-${parts[1]}`;
        
        if (!stats[monthKey]) {
          stats[monthKey] = {
            name: monthName,
            key: monthKey,
            daysLogged: 0,
            totalCaloriesConsumed: 0,
            maintenanceCaloriesPerDay: maintenanceCalories,
            intakesCount: 0
          };
        }
        
        stats[monthKey].daysLogged += 1;
        stats[monthKey].totalCaloriesConsumed += (log.dailyTotals?.calories || 0);
        stats[monthKey].intakesCount += (log.intakes?.length || 0);
      }
    });

    return Object.values(stats).sort((a, b) => b.key.localeCompare(a.key));
  }, [dailyLogs, maintenanceCalories, locale]);

  const currentMonthData = monthlyStats[selectedMonthIndex] || monthlyStats[0] || {
    name: 'Current Month',
    daysLogged: 0,
    totalCaloriesConsumed: 0,
    maintenanceCaloriesPerDay: maintenanceCalories,
  };

  const currentMonthMaintenance = currentMonthData.daysLogged * (currentMonthData.maintenanceCaloriesPerDay || maintenanceCalories);
  const currentMonthDeficit = currentMonthMaintenance - currentMonthData.totalCaloriesConsumed;
  const currentMonthAvgCalories = currentMonthData.daysLogged > 0 ? Math.round(currentMonthData.totalCaloriesConsumed / currentMonthData.daysLogged) : 0;
  const currentMonthEstimatedLostKg = currentMonthDeficit > 0 ? (currentMonthDeficit / 7700) : 0;

  // Weekly Data Configuration
  const macrosConfig = {
    calories: { label: t('diary.calories', 'Calories'), color: 'var(--color-calories)', target: targetMacros.calories },
    protein: { label: t('diary.protein', 'Protein'), color: 'var(--color-protein)', target: targetMacros.protein },
    carbs: { label: t('diary.carbs', 'Carbs'), color: 'var(--color-carbs)', target: targetMacros.carbs },
    fats: { label: t('diary.fats', 'Fats'), color: 'var(--color-fats)', target: targetMacros.fats }
  };
  const currentConfig = macrosConfig[activeMacro] || macrosConfig.calories;

  // Helper to add days to ISO date string (YYYY-MM-DD)
  const addDaysToIso = (dateStr, days) => {
    if (!dateStr) return '';
    const parts = dateStr.split('-');
    if (parts.length !== 3) return dateStr;
    const d = new Date(parseInt(parts[0], 10), parseInt(parts[1], 10) - 1, parseInt(parts[2], 10));
    d.setDate(d.getDate() + days);
    const y = d.getFullYear();
    const m = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${y}-${m}-${day}`;
  };

  // Weekly Data Grouping (7 calendar days sliding window per weekOffset)
  const visibleDays = useMemo(() => {
    const baseDate = selectedDate || new Date().toISOString().slice(0, 10);
    const weekEndDateStr = addDaysToIso(baseDate, -1 * weekOffset * 7);

    const days = [];
    for (let i = 6; i >= 0; i--) {
      const dateStr = addDaysToIso(weekEndDateStr, -i);
      const existingLog = dailyLogs.find((l) => l.date === dateStr);
      if (existingLog) {
        days.push(existingLog);
      } else {
        days.push({
          date: dateStr,
          dailyTotals: { calories: 0, protein: 0, carbs: 0, fats: 0 },
          intakes: [],
        });
      }
    }
    return days;
  }, [selectedDate, weekOffset, dailyLogs]);

  const maxWeekOffset = useMemo(() => {
    if (!dailyLogs || dailyLogs.length === 0) return 12;
    const sorted = [...dailyLogs].sort((a, b) => a.date.localeCompare(b.date));
    const earliestDate = sorted[0].date;
    const baseDate = selectedDate || new Date().toISOString().slice(0, 10);
    const diffMs = new Date(baseDate).getTime() - new Date(earliestDate).getTime();
    const diffDays = Math.max(0, Math.floor(diffMs / (1000 * 60 * 60 * 24)));
    return Math.max(12, Math.ceil(diffDays / 7) + 2);
  }, [dailyLogs, selectedDate]);

  const formatShortDate = (dateStr) => {
    if (!dateStr) return '';
    const parts = dateStr.split('-');
    if (parts.length !== 3) return dateStr;
    const d = new Date(parts[0], parseInt(parts[1], 10) - 1, parts[2]);
    return d.toLocaleDateString(locale, { day: 'numeric', month: 'short' });
  };
  
  const dateRangeStr = visibleDays.length > 0 
    ? `${formatShortDate(visibleDays[0].date)} - ${formatShortDate(visibleDays[visibleDays.length - 1].date)}`
    : '';

  // Handlers
  const handleAddWeight = async (e) => {
    e.preventDefault();
    if (!inputWeight || isNaN(inputWeight) || parseFloat(inputWeight) <= 0) return;

    const profId = activeProfileId || activeProfile?.id;
    setIsSubmittingWeight(true);
    try {
      if (supabase && profId) {
        const res = await saveWeightToSupabase({ date: inputDate, time: inputTime, weight: parseFloat(inputWeight), profileId: profId });
        if (res && res.success) {
          const freshData = await fetchDailyLogsFromSupabase(profId);
          if (freshData && typeof setData === 'function') {
            setData(freshData);
          }
          if (freshData && typeof onUpdateProfile === 'function') {
            onUpdateProfile(freshData.userProfile);
          }
          setInputWeight('');
          const successMsg = t('toast.weightSaved', '⚖️ Weight recorded!');
          setWeightFeedback(successMsg);
          if (typeof setToastMessage === 'function') setToastMessage(successMsg);
          setTimeout(() => setWeightFeedback(null), 3000);
          setShowWeightForm(false);
          return;
        }
      }

      // Local fallback
      const newEntry = { date: inputDate, time: inputTime, weight: parseFloat(inputWeight) };
      const updatedHistory = [...history.filter(h => !(h.date === inputDate && h.time === inputTime)), newEntry];
      updatedHistory.sort((a, b) => `${a.date} ${a.time}`.localeCompare(`${b.date} ${b.time}`));

      const updatedUserProfile = {
        ...userProfile,
        weightLog: { ...weightLog, history: updatedHistory }
      };

      if (typeof setData === 'function' && data) {
        setData({
          ...data,
          userProfile: updatedUserProfile,
        });
      }

      if (typeof onUpdateProfile === 'function') {
        onUpdateProfile(updatedUserProfile);
      }

      setInputWeight('');
      const successMsg = t('toast.weightSaved', '⚖️ Weight recorded!');
      setWeightFeedback(successMsg);
      if (typeof setToastMessage === 'function') setToastMessage(successMsg);
      setTimeout(() => setWeightFeedback(null), 3000);
      setShowWeightForm(false);
    } catch (err) {
      console.error('Error adding weight:', err);
    } finally {
      setIsSubmittingWeight(false);
    }
  };

  const handleDeleteWeight = async (item, index) => {
    const profId = activeProfileId || activeProfile?.id;
    try {
      if (supabase && profId) {
        const res = await deleteWeightFromSupabase({ date: item.date, time: item.time, profileId: profId });
        if (res && res.success) {
          const freshData = await fetchDailyLogsFromSupabase(profId);
          if (freshData && typeof setData === 'function') {
            setData(freshData);
          }
          if (freshData && typeof onUpdateProfile === 'function') {
            onUpdateProfile(freshData.userProfile);
          }
          const delMsg = t('toast.weightDeleted', '🗑️ Weight entry deleted');
          setWeightFeedback(delMsg);
          if (typeof setToastMessage === 'function') setToastMessage(delMsg);
          setTimeout(() => setWeightFeedback(null), 3000);
          return;
        }
      }

      const updatedHistory = history.filter((_, i) => i !== index);
      const updatedUserProfile = {
        ...userProfile,
        weightLog: { ...weightLog, history: updatedHistory }
      };

      if (typeof setData === 'function' && data) {
        setData({
          ...data,
          userProfile: updatedUserProfile,
        });
      }

      if (typeof onUpdateProfile === 'function') {
        onUpdateProfile(updatedUserProfile);
      }

      const delMsg = t('toast.weightDeleted', '🗑️ Weight entry deleted');
      setWeightFeedback(delMsg);
      if (typeof setToastMessage === 'function') setToastMessage(delMsg);
      setTimeout(() => setWeightFeedback(null), 3000);
    } catch (err) {
      console.error('Error deleting weight:', err);
    }
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem', marginTop: '1.25rem', animation: 'fadeIn 0.3s ease' }}>
      
      {/* Sub-navigation Filter Bar */}
      <div style={{
        display: 'flex',
        gap: '0.4rem',
        background: 'var(--bg-card)',
        padding: '0.4rem',
        borderRadius: '16px',
        border: '1px solid var(--border-light)',
        overflowX: 'auto',
        scrollbarWidth: 'none'
      }}>
        <button
          onClick={() => setActiveSection('all')}
          style={{
            background: activeSection === 'all' ? 'var(--color-indigo)' : 'transparent',
            color: activeSection === 'all' ? '#FFF' : 'var(--text-muted)',
            border: 'none',
            padding: '0.5rem 0.85rem',
            borderRadius: '12px',
            fontWeight: 600,
            fontSize: '0.82rem',
            cursor: 'pointer',
            whiteSpace: 'nowrap',
            transition: 'all 0.2s ease'
          }}
        >
          {t('report.monthlySummary')} & {t('nav.progress')}
        </button>

        <button
          onClick={() => setActiveSection('weekly')}
          style={{
            background: activeSection === 'weekly' ? 'var(--color-indigo)' : 'transparent',
            color: activeSection === 'weekly' ? '#FFF' : 'var(--text-muted)',
            border: 'none',
            padding: '0.5rem 0.85rem',
            borderRadius: '12px',
            fontWeight: 600,
            fontSize: '0.82rem',
            cursor: 'pointer',
            whiteSpace: 'nowrap',
            transition: 'all 0.2s ease'
          }}
        >
          {t('trends.weeklyTrend')}
        </button>

        <button
          onClick={() => setActiveSection('monthly')}
          style={{
            background: activeSection === 'monthly' ? 'var(--color-indigo)' : 'transparent',
            color: activeSection === 'monthly' ? '#FFF' : 'var(--text-muted)',
            border: 'none',
            padding: '0.5rem 0.85rem',
            borderRadius: '12px',
            fontWeight: 600,
            fontSize: '0.82rem',
            cursor: 'pointer',
            whiteSpace: 'nowrap',
            transition: 'all 0.2s ease'
          }}
        >
          {t('report.monthlyReport')}
        </button>

        <button
          onClick={() => setActiveSection('history')}
          style={{
            background: activeSection === 'history' ? 'var(--color-indigo)' : 'transparent',
            color: activeSection === 'history' ? '#FFF' : 'var(--text-muted)',
            border: 'none',
            padding: '0.5rem 0.85rem',
            borderRadius: '12px',
            fontWeight: 600,
            fontSize: '0.82rem',
            cursor: 'pointer',
            whiteSpace: 'nowrap',
            transition: 'all 0.2s ease'
          }}
        >
          {t('progress.history')}
        </button>
      </div>

      {/* SECTION 1: MASTER GOAL & WEIGHT KPI STRIP */}
      {(activeSection === 'all' || activeSection === 'weight') && (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
          
          {/* Main Progress Bar & Weigh-in Trigger Card */}
          <div className="health-card">
            <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem', gap: '1rem' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                <div style={{ background: 'var(--color-protein-bg)', padding: '0.65rem', borderRadius: '14px' }}>
                  <Award color="var(--color-protein)" size={24} />
                </div>
                <div>
                  <h2 style={{ fontSize: '1.2rem', margin: 0, fontWeight: 700 }}>
                    {t('progress.goal')}: {targetWeight} kg
                  </h2>
                  <span style={{ fontSize: '0.82rem', color: 'var(--text-muted)', display: 'block', marginTop: '0.2rem' }}>
                    {remainingToGoal > 0 ? (
                      <>
                        <strong>{remainingToGoal.toFixed(1)} kg</strong> restantes ({progressPercent.toFixed(0)}%) • 🚀 <strong>~{daysToGoal} días restantes</strong> (Meta: {formattedGoalDate})
                      </>
                    ) : (
                      <>🎉 ¡Objetivo de peso alcanzado!</>
                    )}
                  </span>
                </div>
              </div>

              <button
                onClick={() => setShowWeightForm(!showWeightForm)}
                style={{
                  background: showWeightForm ? 'var(--bg-subtle)' : 'var(--color-indigo)',
                  color: showWeightForm ? 'var(--text-main)' : '#FFF',
                  border: 'none',
                  padding: '0.6rem 1.1rem',
                  borderRadius: '12px',
                  fontWeight: 600,
                  fontSize: '0.85rem',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.4rem',
                  boxShadow: showWeightForm ? 'none' : '0 4px 12px rgba(99, 102, 241, 0.25)',
                  transition: 'all 0.2s ease'
                }}
              >
                {showWeightForm ? <X size={16} /> : <Plus size={16} />}
                {t('progress.logRealWeight')}
              </button>
            </div>

            {/* Visual Goal Progress Bar */}
            <div style={{ height: '14px', background: 'var(--border-light)', borderRadius: '7px', overflow: 'hidden', position: 'relative' }}>
              <div style={{ width: `${progressPercent}%`, height: '100%', background: 'linear-gradient(90deg, var(--color-protein), #a855f7)', borderRadius: '7px', transition: 'width 1s ease' }} />
            </div>

            {/* Weigh-in Form Drawer */}
            {showWeightForm && (
              <form onSubmit={handleAddWeight} style={{ marginTop: '1.25rem', paddingTop: '1.25rem', borderTop: '1px solid var(--border-subtle)', display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(140px, 1fr))', gap: '1rem', alignItems: 'end' }}>
                <div>
                  <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.4rem', fontWeight: 500 }}>
                    {t('progress.date')}
                  </label>
                  <input
                    type="date"
                    value={inputDate}
                    onChange={(e) => setInputDate(e.target.value)}
                    className="edit-input"
                    required
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.4rem', fontWeight: 500 }}>
                    {t('progress.time')}
                  </label>
                  <input
                    type="time"
                    value={inputTime}
                    onChange={(e) => setInputTime(e.target.value)}
                    className="edit-input"
                    required
                  />
                </div>

                <div>
                  <label style={{ display: 'block', fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.4rem', fontWeight: 500 }}>
                    {t('progress.scaleWeight')}
                  </label>
                  <input
                    type="number"
                    step="0.1"
                    placeholder="Ej: 71.5"
                    value={inputWeight}
                    onChange={(e) => setInputWeight(e.target.value)}
                    className="edit-input"
                    required
                  />
                </div>

                <button
                  type="submit"
                  disabled={isSubmittingWeight}
                  style={{
                    padding: '0.75rem 1.25rem',
                    borderRadius: '12px',
                    border: 'none',
                    background: 'var(--color-indigo)',
                    color: '#FFF',
                    fontWeight: 600,
                    cursor: isSubmittingWeight ? 'not-allowed' : 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    gap: '0.4rem',
                    height: '44px'
                  }}
                >
                  <Check size={18} />
                  {t('progress.saveWeight')}
                </button>
              </form>
            )}

            {weightFeedback && (
              <div style={{ marginTop: '0.75rem', color: 'var(--color-carbs)', fontSize: '0.85rem', fontWeight: 600, display: 'flex', alignItems: 'center', gap: '0.3rem' }}>
                <Check size={16} /> {weightFeedback}
              </div>
            )}
          </div>

          {/* Adaptive TDEE Intelligence Card (MacroFactor Style) */}
          {adaptiveTDEE && (
            <div className="p-4 rounded-2xl bg-gradient-to-r from-indigo-50 via-purple-50 to-pink-50 border border-indigo-100/90 shadow-2xs space-y-2.5">
              <div className="flex items-center justify-between gap-2 flex-wrap">
                <div className="flex items-center gap-2">
                  <Sparkles className="w-5 h-5 text-indigo-600" />
                  <h4 className="font-extrabold text-slate-900 text-sm">Adaptive TDEE Intelligence</h4>
                </div>
                <span className="text-xs font-mono font-extrabold text-indigo-700 bg-white/90 px-2.5 py-1 rounded-lg border border-indigo-200 shadow-2xs">
                  Estimated TDEE: {adaptiveTDEE} kcal/day
                </span>
              </div>
              <p className="text-xs text-slate-600 leading-relaxed">
                Based on your 7-day weight trend ({weeklyLossRateKg >= 0 ? `+${weeklyLossRateKg}` : weeklyLossRateKg} kg/week) and logged calorie intake, your actual energy expenditure is estimated at <strong>{adaptiveTDEE} kcal</strong> (profile set to {maintenanceCalories} kcal).
              </p>
              <div className="flex items-center gap-2 pt-0.5">
                <button
                  type="button"
                  onClick={handleApplyAdaptiveTdee}
                  disabled={isApplyingAdaptiveTdee}
                  className="px-3.5 py-1.5 bg-indigo-600 hover:bg-indigo-700 text-white font-bold text-xs rounded-xl shadow-2xs transition-all flex items-center gap-1.5 cursor-pointer"
                >
                  <Check className="w-3.5 h-3.5" />
                  {isApplyingAdaptiveTdee ? 'Applying...' : `Apply Adaptive Maintenance (${adaptiveTDEE} kcal)`}
                </button>
              </div>
            </div>
          )}

          {/* Master 4 KPI Grid (Zero duplication) */}
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1rem' }}>
            
            {/* KPI 1: 7-Day Trend Weight */}
            <div className="health-card" style={{ padding: '1.25rem', textAlign: 'center' }}>
              <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '0.4rem' }}>
                Tendencia 7D (Media Móvil)
              </div>
              <div style={{ fontSize: '1.7rem', fontWeight: 800, color: 'var(--color-indigo)' }}>
                {movingAverage7d} <span style={{ fontSize: '0.9rem', fontWeight: 500, color: 'var(--text-muted)' }}>kg</span>
              </div>
              <div style={{ fontSize: '0.73rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                Última báscula: {latestRealWeight} kg ({latestRealEntry ? latestRealEntry.date : t('progress.initialWeight')})
              </div>
              {weeklyLossRateKg !== 0 && (
                <div style={{ fontSize: '0.72rem', fontWeight: 700, color: weeklyLossRateKg <= 0 ? 'var(--color-carbs)' : '#f59e0b', marginTop: '0.25rem' }}>
                  {weeklyLossRateKg > 0 ? `+${weeklyLossRateKg}` : weeklyLossRateKg} kg / semana
                </div>
              )}
            </div>

            {/* KPI 2: Estimated Weight */}
            <div className="health-card" style={{ padding: '1.25rem', textAlign: 'center' }}>
              <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '0.4rem' }}>
                {t('progress.estimatedWeight')}
              </div>
              <div style={{ fontSize: '1.7rem', fontWeight: 800, color: 'var(--color-protein)' }}>
                {currentEstimatedWeight.toFixed(1)} <span style={{ fontSize: '0.9rem', fontWeight: 500, color: 'var(--text-muted)' }}>kg</span>
              </div>
              <div style={{ fontSize: '0.73rem', color: 'var(--color-carbs)', marginTop: '0.25rem', fontWeight: 600 }}>
                -{allTimeEstimatedLostKg.toFixed(1)} kg grasa teóricos
              </div>
            </div>

            {/* KPI 3: Deviation */}
            <div className="health-card" style={{ padding: '1.25rem', textAlign: 'center' }}>
              <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '0.4rem' }}>
                {t('progress.deviation')}
              </div>
              <div style={{ fontSize: '1.7rem', fontWeight: 800, color: weightDiffVsEstimated <= 0 ? 'var(--color-carbs)' : '#f59e0b' }}>
                {weightDiffVsEstimated > 0 ? `+${weightDiffVsEstimated.toFixed(1)}` : weightDiffVsEstimated.toFixed(1)} <span style={{ fontSize: '0.9rem', fontWeight: 500, color: 'var(--text-muted)' }}>kg</span>
              </div>
              <div style={{ fontSize: '0.73rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                {weightDiffVsEstimated <= 0 ? t('progress.aheadOfDeficit') : t('progress.slightDifference')}
              </div>
            </div>

            {/* KPI 4: Total Cumulative Deficit */}
            <div className="health-card" style={{ padding: '1.25rem', textAlign: 'center' }}>
              <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '0.4rem' }}>
                {t('report.totalDeficit')}
              </div>
              <div style={{ fontSize: '1.7rem', fontWeight: 800, color: allTimeDeficit >= 0 ? 'var(--color-carbs)' : 'var(--color-calories)' }}>
                {allTimeDeficit > 0 ? `-${allTimeDeficit.toLocaleString()}` : `+${Math.abs(allTimeDeficit).toLocaleString()}`} <span style={{ fontSize: '0.9rem', fontWeight: 500, color: 'var(--text-muted)' }}>kcal</span>
              </div>
              <div style={{ fontSize: '0.73rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                Acumulado histórico total
              </div>
            </div>

          </div>
        </div>
      )}

      {/* SECTION 2: WEEKLY CHART & CATEGORY FREQUENCY */}
      {(activeSection === 'all' || activeSection === 'weekly') && (
        <div className="health-card">
          <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem', gap: '1rem' }}>
            <h2 style={{ fontFamily: 'var(--font-heading)', fontSize: '1.2rem', display: 'flex', alignItems: 'center', gap: '0.5rem', margin: 0, fontWeight: 700 }}>
              <TrendingUp size={20} color={currentConfig.color} />
              {t('trends.weeklyTrend')}
            </h2>
            
            <div style={{ display: 'flex', gap: '0.35rem', background: 'var(--bg-subtle)', padding: '4px', borderRadius: 'var(--radius-md)', maxWidth: '100%', overflowX: 'auto', scrollbarWidth: 'none' }}>
              {Object.entries(macrosConfig).map(([key, config]) => (
                <button
                  key={key}
                  onClick={() => setActiveMacro(key)}
                  style={{
                    background: activeMacro === key ? 'var(--bg-surface)' : 'transparent',
                    color: activeMacro === key ? config.color : 'var(--text-muted)',
                    border: 'none',
                    padding: '0.35rem 0.65rem',
                    borderRadius: '8px',
                    fontWeight: 600,
                    fontSize: '0.78rem',
                    cursor: 'pointer',
                    whiteSpace: 'nowrap',
                    boxShadow: activeMacro === key ? '0 2px 4px rgba(0,0,0,0.05)' : 'none'
                  }}
                >
                  {config.label}
                </button>
              ))}
            </div>
          </div>

          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
            <button 
              onClick={() => setWeekOffset(prev => Math.min(maxWeekOffset, prev + 1))}
              disabled={weekOffset >= maxWeekOffset}
              style={{ background: 'none', border: 'none', cursor: weekOffset >= maxWeekOffset ? 'not-allowed' : 'pointer', color: 'var(--text-muted)' }}
            >
              <ChevronLeft size={20} />
            </button>
            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
              <span style={{ fontSize: '0.9rem', fontWeight: 700, color: 'var(--text-main)' }}>
                {dateRangeStr}
              </span>
              <span style={{ fontSize: '0.8rem', fontWeight: 500, color: 'var(--text-muted)' }}>
                {t('trends.target')}: {currentConfig.target} {activeMacro === 'calories' ? 'kcal' : 'g'}
              </span>
            </div>
            <button 
              onClick={() => setWeekOffset(prev => Math.max(0, prev - 1))}
              disabled={weekOffset === 0}
              style={{ background: 'none', border: 'none', cursor: weekOffset === 0 ? 'not-allowed' : 'pointer', color: 'var(--text-muted)' }}
            >
              <ChevronRight size={20} />
            </button>
          </div>

          {/* Bar Chart Visualizer */}
          <div style={{ display: 'flex', alignItems: 'flex-end', justifyContent: 'space-between', height: 210, gap: '0.35rem', paddingTop: '1rem' }}>
            {visibleDays.map((d, idx) => {
              const val = d.dailyTotals?.[activeMacro] || 0;
              const target = currentConfig.target;
              const pPct = Math.min(100, Math.round((val / target) * 100));
              const isSelected = d.date === selectedDate;
              
              let targetMet = false;
              if (activeMacro === 'calories') {
                targetMet = val > 0 && val <= target + 100;
              } else {
                targetMet = val >= target * 0.85;
              }

              const formattedLabel = formatShortDate(d.date);

              return (
                <div 
                  key={d.date} 
                  onClick={() => onSelectDate && onSelectDate(d.date)}
                  style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '0.5rem', cursor: 'pointer' }}
                >
                  <span style={{ fontSize: '0.68rem', fontWeight: 600, color: isSelected ? 'var(--text-main)' : 'var(--text-muted)' }}>
                    {val > 0 ? (activeMacro === 'calories' ? Math.round(val) : `${Math.round(val)}g`) : '-'}
                  </span>
                  
                  <div style={{ width: '100%', maxWidth: '32px', height: '140px', background: 'var(--bg-subtle)', borderRadius: '8px', display: 'flex', alignItems: 'flex-end', overflow: 'hidden', padding: '2px' }}>
                    <div 
                      style={{ 
                        width: '100%', 
                        height: `${pPct}%`, 
                        borderRadius: '6px',
                        background: isSelected 
                          ? currentConfig.color 
                          : targetMet ? currentConfig.color : '#9CA3AF',
                        opacity: isSelected ? 1 : 0.7,
                        transition: 'height 0.5s ease, background 0.3s ease'
                      }}
                    />
                  </div>
                  <span style={{ fontSize: '0.68rem', fontWeight: isSelected ? 700 : 500, color: isSelected ? 'var(--text-main)' : 'var(--text-muted)', whiteSpace: 'nowrap' }}>
                    {formattedLabel}
                  </span>
                </div>
              );
            })}
          </div>

          {/* Food Categories Breakdown */}
          {(() => {
            const categoryStats = {};
            visibleDays.forEach((dayLog) => {
              (dayLog.intakes || []).forEach((item) => {
                const catKey = (item.category || 'other').toLowerCase().trim();
                if (!categoryStats[catKey]) {
                  categoryStats[catKey] = {
                    key: catKey,
                    totalCount: 0,
                    totalCalories: 0,
                    foodItems: {}
                  };
                }
                categoryStats[catKey].totalCount += 1;
                categoryStats[catKey].totalCalories += item.macros?.calories || 0;

                const rawName = item.name || 'Alimento';
                let cleanName = rawName.replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '').trim();
                if (!categoryStats[catKey].foodItems[cleanName]) {
                  categoryStats[catKey].foodItems[cleanName] = {
                    name: cleanName,
                    count: 0,
                    totalCalories: 0,
                    categoryKey: catKey,
                    rawItems: []
                  };
                }
                categoryStats[catKey].foodItems[cleanName].count += 1;
                categoryStats[catKey].foodItems[cleanName].totalCalories += (item.macros?.calories || 0);
                categoryStats[catKey].foodItems[cleanName].rawItems.push(item);
              });
            });

            const sortedCategories = Object.values(categoryStats).sort((a, b) => b.totalCount - a.totalCount);

            return (
              <div style={{ marginTop: '2rem', paddingTop: '1.25rem', borderTop: '1px solid var(--border-subtle)' }}>
                <h3 style={{ fontFamily: 'var(--font-heading)', fontSize: '1.05rem', display: 'flex', alignItems: 'center', gap: '0.4rem', marginBottom: '1rem', color: 'var(--text-main)', margin: 0 }}>
                  <PieChart size={18} color="var(--color-indigo)" />
                  {t('trends.categoryFrequency')} ({dateRangeStr})
                </h3>

                {sortedCategories.length === 0 ? (
                  <div style={{ fontSize: '0.85rem', color: 'var(--text-muted)', textAlign: 'center', padding: '1rem' }}>
                    {t('trends.noWeeklyFoods')}
                  </div>
                ) : (
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(130px, 1fr))', gap: '0.65rem', marginTop: '0.85rem' }}>
                    {sortedCategories.map((catStat) => {
                      const catInfo = getCategoryInfo(catStat.key);
                      return (
                        <div
                          key={catStat.key}
                          onClick={() => setSelectedCategoryModal(catStat)}
                          style={{
                            background: 'var(--bg-subtle)',
                            border: '1px solid var(--border-subtle)',
                            borderRadius: 'var(--radius-md)',
                            padding: '0.75rem 0.85rem',
                            cursor: 'pointer',
                            transition: 'all 0.15s ease',
                            display: 'flex',
                            flexDirection: 'column',
                            justifyContent: 'space-between',
                            gap: '0.4rem'
                          }}
                          title={t('trends.clickDetails')}
                        >
                          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                            <span style={{ fontSize: '1.3rem' }}>{catInfo.emoji}</span>
                            <span style={{
                              fontSize: '0.72rem',
                              fontWeight: 700,
                              background: catInfo.bg,
                              color: catInfo.color,
                              padding: '0.1rem 0.45rem',
                              borderRadius: '10px'
                            }}>
                              {catStat.totalCount} {catStat.totalCount === 1 ? t('trends.time') : t('trends.times')}
                            </span>
                          </div>
                          <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: 'var(--text-main)' }}>
                              {catInfo.label}
                            </div>
                            <div style={{ fontSize: '0.73rem', color: 'var(--text-muted)' }}>
                              {catStat.totalCalories} kcal
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            );
          })()}
        </div>
      )}

      {/* SECTION 3: MONTHLY BREAKDOWN */}
      {(activeSection === 'all' || activeSection === 'monthly') && (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.25rem' }}>
          
          {/* Month Navigator */}
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', background: 'var(--bg-card)', padding: '1rem', borderRadius: '16px', border: '1px solid var(--border-light)' }}>
            <button className="nav-btn" onClick={() => setSelectedMonthIndex(prev => Math.min(monthlyStats.length - 1, prev + 1))} disabled={selectedMonthIndex === monthlyStats.length - 1}>
              <ChevronLeft size={20} />
            </button>
            <h2 style={{ margin: 0, fontSize: '1.2rem', fontWeight: 700 }}>{currentMonthData.name}</h2>
            <button className="nav-btn" onClick={() => setSelectedMonthIndex(prev => Math.max(0, prev - 1))} disabled={selectedMonthIndex === 0}>
              <ChevronRight size={20} />
            </button>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '1.25rem' }}>
            
            {/* Monthly Deficit Card */}
            <div className="health-card" style={{ position: 'relative', overflow: 'hidden' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.25rem' }}>
                <div style={{ background: 'rgba(255, 107, 107, 0.15)', padding: '0.6rem', borderRadius: '12px' }}>
                  <Flame color="#ff6b6b" size={24} />
                </div>
                <div>
                  <h3 style={{ fontSize: '1.1rem', margin: 0, fontWeight: 700 }}>{t('report.totalDeficit')}</h3>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>{t('report.loggedDays')}: {currentMonthData.daysLogged}</div>
                </div>
              </div>

              <div style={{ fontSize: '2.2rem', fontWeight: 800, color: currentMonthDeficit >= 0 ? 'var(--color-carbs)' : 'var(--color-calories)', marginBottom: '0.5rem' }}>
                {currentMonthDeficit > 0 ? `-${currentMonthDeficit.toLocaleString()}` : `+${Math.abs(currentMonthDeficit).toLocaleString()}`} <span style={{ fontSize: '1rem', fontWeight: 500, color: 'var(--text-muted)' }}>kcal</span>
              </div>

              <div style={{ display: 'flex', gap: '1.5rem', marginTop: '1rem', paddingTop: '1rem', borderTop: '1px solid var(--border-light)', fontSize: '0.85rem' }}>
                <div>
                  <span style={{ color: 'var(--text-muted)' }}>{t('report.avgCalories')}: </span>
                  <strong style={{ color: 'var(--text-main)' }}>{currentMonthAvgCalories} kcal/día</strong>
                </div>
              </div>
            </div>

            {/* Monthly Estimated Weight Change */}
            <div className="health-card" style={{ position: 'relative', overflow: 'hidden' }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.25rem' }}>
                <div style={{ background: 'var(--color-indigo-subtle)', padding: '0.6rem', borderRadius: '12px' }}>
                  <TrendingDown color="var(--color-indigo)" size={24} />
                </div>
                <div>
                  <h3 style={{ fontSize: '1.1rem', margin: 0, fontWeight: 700 }}>{t('report.estimatedChange')}</h3>
                  <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>Equivalencia ~7,700 kcal / kg</div>
                </div>
              </div>

              <div style={{ fontSize: '2.2rem', fontWeight: 800, color: currentMonthDeficit >= 0 ? 'var(--color-carbs)' : 'var(--color-calories)', marginBottom: '0.5rem' }}>
                {currentMonthDeficit >= 0 ? `-${currentMonthEstimatedLostKg.toFixed(2)}` : `+${Math.abs(currentMonthEstimatedLostKg).toFixed(2)}`} <span style={{ fontSize: '1rem', fontWeight: 500, color: 'var(--text-muted)' }}>kg grasa</span>
              </div>
            </div>

          </div>
        </div>
      )}

      {/* SECTION 4: SCALE WEIGHT HISTORY TABLE */}
      {(activeSection === 'all' || activeSection === 'history') && (
        <div className="health-card">
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '1.25rem' }}>
            <TrendingDown size={20} color="var(--color-indigo)" />
            <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 700 }}>{t('progress.history')}</h3>
          </div>

          {history.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '2rem 0', color: 'var(--text-muted)', fontSize: '0.9rem' }}>
              {t('progress.noWeights')}
            </div>
          ) : (
            <div style={{ overflowX: 'auto' }}>
              <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '0.9rem' }}>
                <thead>
                  <tr style={{ borderBottom: '1px solid var(--border-light)', color: 'var(--text-muted)' }}>
                    <th style={{ padding: '0.75rem 0.5rem', fontWeight: 600 }}>{t('progress.dateTime')}</th>
                    <th style={{ padding: '0.75rem 0.5rem', fontWeight: 600 }}>{t('progress.realWeight')}</th>
                    <th style={{ padding: '0.75rem 0.5rem', fontWeight: 600 }}>{t('progress.estimatedThatDay')}</th>
                    <th style={{ padding: '0.75rem 0.5rem', fontWeight: 600 }}>{t('progress.difference')}</th>
                    <th style={{ padding: '0.75rem 0.5rem', fontWeight: 600, textAlign: 'right' }}>{t('progress.action')}</th>
                  </tr>
                </thead>
                <tbody>
                  {history.map((item, idx) => ({ item, originalIndex: idx }))
                    .reverse()
                    .map(({ item, originalIndex }) => {
                    const dayDeficit = getCumulativeDeficitUpToDate(item.date);
                    const dayEstimatedWeight = startWeight - (dayDeficit > 0 ? (dayDeficit / 7700) : 0);
                    const diff = item.weight - dayEstimatedWeight;

                    return (
                      <tr key={`${item.date}-${item.time || originalIndex}`} style={{ borderBottom: '1px solid var(--border-light)' }}>
                        <td style={{ padding: '0.75rem 0.5rem', fontWeight: 600 }}>
                          {item.date} <span style={{ color: 'var(--text-muted)', fontSize: '0.85rem' }}>({item.time || '08:00'})</span>
                        </td>
                        <td style={{ padding: '0.75rem 0.5rem', fontWeight: 700, color: 'var(--color-indigo)' }}>{item.weight} kg</td>
                        <td style={{ padding: '0.75rem 0.5rem', color: 'var(--color-protein)' }}>{dayEstimatedWeight.toFixed(1)} kg</td>
                        <td style={{ padding: '0.75rem 0.5rem', fontWeight: 600, color: diff <= 0 ? 'var(--color-carbs)' : '#f59e0b' }}>
                          {diff > 0 ? `+${diff.toFixed(1)}` : diff.toFixed(1)} kg
                        </td>
                        <td style={{ padding: '0.75rem 0.5rem', textAlign: 'right' }}>
                          <button
                            onClick={() => handleDeleteWeight(item, originalIndex)}
                            style={{
                              background: 'transparent',
                              border: 'none',
                              color: 'var(--text-muted)',
                              cursor: 'pointer',
                              padding: '0.3rem',
                              borderRadius: '6px'
                            }}
                            title="Eliminar pesaje"
                          >
                            <Trash2 size={16} color="#ff6b6b" />
                          </button>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}

      {/* Category Breakdown Modal */}
      {selectedCategoryModal && (() => {
        const catInfo = getCategoryInfo(selectedCategoryModal.key);
        const foodList = Object.values(selectedCategoryModal.foodItems).sort((a, b) => b.count - a.count);
        return (
          <div className="bottom-sheet-overlay" onClick={() => setSelectedCategoryModal(null)}>
            <div className="bottom-sheet" onClick={(e) => e.stopPropagation()}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.25rem' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                  <span style={{ fontSize: '1.6rem' }}>{catInfo.emoji}</span>
                  <div>
                    <h3 style={{ fontFamily: 'var(--font-heading)', fontSize: '1.15rem', fontWeight: 700, margin: 0 }}>
                      {catInfo.label}
                    </h3>
                    <div style={{ fontSize: '0.78rem', color: 'var(--text-muted)' }}>
                      {selectedCategoryModal.totalCount} {selectedCategoryModal.totalCount === 1 ? t('trends.time') : t('trends.times')} ({selectedCategoryModal.totalCalories} kcal)
                    </div>
                  </div>
                </div>
                <button
                  onClick={() => setSelectedCategoryModal(null)}
                  style={{ background: 'var(--bg-subtle)', border: 'none', borderRadius: '50%', width: 32, height: 32, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' }}
                >
                  <X size={18} color="var(--text-muted)" />
                </button>
              </div>

              <div style={{ maxHeight: '360px', overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '0.55rem' }}>
                {foodList.map((food, idx) => (
                  <div key={idx} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0.65rem 0.85rem', background: 'var(--bg-subtle)', borderRadius: 'var(--radius-md)' }}>
                    <div>
                      <div style={{ fontWeight: 600, fontSize: '0.88rem' }}>{food.name}</div>
                      <div style={{ fontSize: '0.73rem', color: 'var(--text-muted)' }}>{food.count} {food.count === 1 ? t('trends.time') : t('trends.times')}</div>
                    </div>
                    <div style={{ fontWeight: 700, color: 'var(--color-calories)', fontSize: '0.88rem' }}>
                      {food.totalCalories} kcal
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        );
      })()}

    </div>
  );
}
