import React from 'react';
import { Clock, Edit2, Trash2, Utensils, Plus, Loader2 } from 'lucide-react';
import Avatar from '../../../shared/Avatar';
import Button from '../../../shared/ui/Button';
import { getFoodEmoji } from '../../../utils/emoji';
import { getCategoryInfo } from '../../../utils/category';
import Card from '../../../shared/ui/Card';
import {
  supabase,
  deleteIntakesGroupFromSupabase,
  deleteIntakeFromSupabase,
  fetchDailyLogsFromSupabase,
  fetchPartnerIntakesForDate,
  saveIntakesToSupabase,
} from '../../../lib/supabase';

export default function DailyTimeline({
  intakes,
  selectedDate,
  data,
  setData,
  activeProfile,
  activeProfileId,
  profiles,
  setToastMessage,
  onItemClick,
  onEditItem,
  onDeleteGroup,
  onDeleteItem,
}) {
  const handleItemSelect = (item, idx) => {
    const callback = onEditItem || onItemClick;
    if (typeof callback === 'function') {
      callback(item, idx);
    }
  };

  const handleDeleteMealGroup = async (mealItems) => {
    if (!mealItems || mealItems.length === 0) return;
    if (!window.confirm('¿Borrar toda esta ingesta?')) return;

    if (typeof onDeleteGroup === 'function') {
      onDeleteGroup(mealItems);
      return;
    }

    if (supabase && activeProfileId) {
      const res = await deleteIntakesGroupFromSupabase({
        date: selectedDate,
        items: mealItems,
        profileId: activeProfileId,
      });

      if (res && res.success) {
        const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (freshData && typeof setData === 'function') setData(freshData);
      }
    } else if (typeof setData === 'function' && data) {
      const getLocalDateStr = () => {
        const d = new Date();
        const year = d.getFullYear();
        const month = String(d.getMonth() + 1).padStart(2, '0');
        const day = String(d.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
      };
      const targetDate = selectedDate || getLocalDateStr();
      const updatedLogs = [...(data.dailyLogs || [])];
      const dayIdx = updatedLogs.findIndex((l) => l.date === targetDate);
      if (dayIdx >= 0 && updatedLogs[dayIdx].intakes) {
        const idsToRemove = new Set(mealItems.map((i) => i.id).filter(Boolean));
        const updatedIntakes = updatedLogs[dayIdx].intakes.filter(
          (i, idx) => !idsToRemove.has(i.id) && !mealItems.some((m) => m.originalIndex === idx)
        );
        updatedLogs[dayIdx].intakes = updatedIntakes;
        setData({ ...data, dailyLogs: updatedLogs });
      }
    }

    if (typeof setToastMessage === 'function') {
      setToastMessage('Ingesta completa eliminada');
    }
  };

  const handleDeleteSingleItem = async (item, itemIndex, e) => {
    if (e) e.stopPropagation();
    if (!window.confirm(`¿Eliminar ${item.name || 'este alimento'}?`)) return;

    if (typeof onDeleteItem === 'function') {
      onDeleteItem(item, itemIndex);
      return;
    }

    if (supabase && activeProfileId) {
      const res = await deleteIntakeFromSupabase({
        date: selectedDate,
        index: itemIndex,
        item,
        profileId: activeProfileId,
      });

      if (res && res.success) {
        const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (freshData && typeof setData === 'function') setData(freshData);
      }
    } else if (typeof setData === 'function' && data) {
      const getLocalDateStr = () => {
        const d = new Date();
        const year = d.getFullYear();
        const month = String(d.getMonth() + 1).padStart(2, '0');
        const day = String(d.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
      };
      const targetDate = selectedDate || getLocalDateStr();
      const updatedLogs = [...(data.dailyLogs || [])];
      const dayIdx = updatedLogs.findIndex((l) => l.date === targetDate);
      if (dayIdx >= 0 && updatedLogs[dayIdx].intakes) {
        const updatedIntakes = updatedLogs[dayIdx].intakes.filter((_, i) => i !== itemIndex);
        updatedLogs[dayIdx].intakes = updatedIntakes;
        setData({ ...data, dailyLogs: updatedLogs });
      }
    }

    if (typeof setToastMessage === 'function') {
      setToastMessage('Alimento eliminado');
    }
  };
  // Partner Intakes State & Load
  const partnerProfiles = (profiles || []).filter(
    (p) => p.id !== activeProfileId && p.id !== activeProfile?.id
  );
  const [partnerIntakesMap, setPartnerIntakesMap] = React.useState({});
  const [copyingKey, setCopyingKey] = React.useState(null);

  React.useEffect(() => {
    async function loadPartnerData() {
      if (!partnerProfiles || partnerProfiles.length === 0 || !selectedDate) return;
      const map = {};
      for (const partner of partnerProfiles) {
        const pIntakes = await fetchPartnerIntakesForDate(partner.id, selectedDate);
        map[partner.id] = pIntakes;
      }
      setPartnerIntakesMap(map);
    }

    loadPartnerData();
  }, [selectedDate, activeProfileId, profiles, data]);

  const handleCopySingleItem = async (item, partnerName, key) => {
    if (!activeProfileId) return;
    setCopyingKey(key);

    try {
      const itemsToCopy = [
        {
          name: item.name,
          dish_name: item.dishName || null,
          portion_qty: item.quantity || 1,
          unit: item.unit || 'ud',
          category: item.category || 'other',
          calories: item.macros?.calories || 0,
          protein: item.macros?.protein || 0,
          carbs: item.macros?.carbs || 0,
          fats: item.macros?.fats || 0,
        },
      ];

      if (supabase) {
        await saveIntakesToSupabase({
          items: itemsToCopy,
          date: selectedDate,
          time: item.time || new Date().toTimeString().slice(0, 5),
          profileId: activeProfileId,
        });

        const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (freshData && typeof setData === 'function') {
          setData(freshData);
        }
      }

      if (typeof setToastMessage === 'function') {
        setToastMessage(`Copied ${item.name} from ${partnerName}'s diary!`);
      }
    } finally {
      setCopyingKey(null);
    }
  };

  const handleCopyMealGroup = async (mealItems, partnerName, key) => {
    if (!activeProfileId || !mealItems || mealItems.length === 0) return;
    setCopyingKey(key);

    try {
      const itemsToCopy = mealItems.map((i) => ({
        name: i.name,
        dish_name: i.dishName || null,
        portion_qty: i.quantity || 1,
        unit: i.unit || 'ud',
        category: i.category || 'other',
        calories: i.macros?.calories || 0,
        protein: i.macros?.protein || 0,
        carbs: i.carbs || 0,
        fats: i.fats || 0,
      }));

      const timeStr = mealItems[0]?.time || new Date().toTimeString().slice(0, 5);

      if (supabase) {
        await saveIntakesToSupabase({
          items: itemsToCopy,
          date: selectedDate,
          time: timeStr,
          profileId: activeProfileId,
        });

        const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (freshData && typeof setData === 'function') {
          setData(freshData);
        }
      }

      if (typeof setToastMessage === 'function') {
        setToastMessage(`Copied ${itemsToCopy.length} item(s) from ${partnerName}'s meal!`);
      }
    } finally {
      setCopyingKey(null);
    }
  };

  const handleCopyAllPartnerIntakes = async (partnerIntakes, partnerName, key) => {
    if (!activeProfileId || !partnerIntakes || partnerIntakes.length === 0) return;
    setCopyingKey(key);

    try {
      const itemsToCopy = partnerIntakes.map((i) => ({
        name: i.name,
        dish_name: i.dishName || null,
        portion_qty: i.quantity || 1,
        unit: i.unit || 'ud',
        category: i.category || 'other',
        calories: i.macros?.calories || 0,
        protein: i.macros?.protein || 0,
        carbs: i.carbs || 0,
        fats: i.fats || 0,
      }));

      if (supabase) {
        await saveIntakesToSupabase({
          items: itemsToCopy,
          date: selectedDate,
          time: new Date().toTimeString().slice(0, 5),
          profileId: activeProfileId,
        });

        const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (freshData && typeof setData === 'function') {
          setData(freshData);
        }
      }

      if (typeof setToastMessage === 'function') {
        setToastMessage(`Copied all ${itemsToCopy.length} items from ${partnerName}'s diary!`);
      }
    } finally {
      setCopyingKey(null);
    }
  };

  const getItemMacros = (item) => {
    if (!item) return { calories: 0, protein: 0, carbs: 0, fats: 0 };
    return {
      calories: item.macros?.calories ?? item.calories ?? 0,
      protein: item.macros?.protein ?? item.protein ?? 0,
      carbs: item.macros?.carbs ?? item.carbs ?? 0,
      fats: item.macros?.fats ?? item.fats ?? 0,
    };
  };

  // Safety expansion: if any intake name contains '+' or '\+', expand it into sub-items
  const expandedIntakes = [];
  intakes.forEach((item, originalIdx) => {
    const rawName = item.name || item.description || '';
    let cleanName = rawName.replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '').trim();
    const itemMacros = getItemMacros(item);

    if (cleanName.includes('+') || cleanName.includes('\\+')) {
      const parts = cleanName.split(/\\?\+/).map((p) => p.trim()).filter(Boolean);
      const count = parts.length;
      parts.forEach((part) => {
        const subName = part.replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '');
        expandedIntakes.push({
          ...item,
          time: item.time || '12:00',
          dishName: item.dishName,
          name: subName,
          quantity: 1,
          unit: 'porcion',
          category: item.category || 'other',
          macros: {
            calories: Math.round(itemMacros.calories / count),
            protein: Math.round((itemMacros.protein / count) * 10) / 10,
            carbs: Math.round((itemMacros.carbs / count) * 10) / 10,
            fats: Math.round((itemMacros.fats / count) * 10) / 10,
          },
          originalIndex: originalIdx,
        });
      });
    } else {
      expandedIntakes.push({
        ...item,
        name: cleanName,
        macros: itemMacros,
        originalIndex: originalIdx,
      });
    }
  });

  // Helper to calculate 1-hour range label from time string or ISO date string (e.g. "18:38" -> "18:00 - 19:00")
  const getHourRangeKey = (timeStr) => {
    if (!timeStr) return '12:00 - 13:00';
    let hour = 12;
    if (typeof timeStr === 'string') {
      if (timeStr.includes('T')) {
        const d = new Date(timeStr);
        if (!isNaN(d.getTime())) hour = d.getHours();
      } else {
        const parts = timeStr.split(':');
        const parsed = parseInt(parts[0], 10);
        if (!isNaN(parsed) && parsed >= 0 && parsed <= 23) hour = parsed;
      }
    }
    const startHourStr = hour.toString().padStart(2, '0');
    const nextHourStr = ((hour + 1) % 24).toString().padStart(2, '0');
    return `${startHourStr}:00 - ${nextHourStr}:00`;
  };

  const getTimeInMinutes = (timeStr) => {
    if (!timeStr) return 720;
    if (typeof timeStr === 'string' && timeStr.includes('T')) {
      const d = new Date(timeStr);
      if (!isNaN(d.getTime())) return d.getHours() * 60 + d.getMinutes();
    }
    const parts = String(timeStr).split(':');
    const h = parseInt(parts[0], 10) || 0;
    const m = parseInt(parts[1], 10) || 0;
    return h * 60 + m;
  };

  // Group strictly by 1-hour time range (hourRange)
  const groupedMealsMap = new Map();

  expandedIntakes.forEach((item) => {
    const timeStr = item.time || item.timestamp || item.created_at || '12:00';
    const hourRange = getHourRangeKey(timeStr);
    const timeMins = getTimeInMinutes(timeStr);
    const groupKey = hourRange;

    if (!groupedMealsMap.has(groupKey)) {
      groupedMealsMap.set(groupKey, {
        key: groupKey,
        timeRange: hourRange,
        maxTimeMinutes: timeMins,
        dishName: item.dishName || null,
        items: [],
      });
    }

    const group = groupedMealsMap.get(groupKey);
    if (timeMins > group.maxTimeMinutes) {
      group.maxTimeMinutes = timeMins;
    }
    if (!group.dishName && item.dishName) {
      group.dishName = item.dishName;
    }
    group.items.push(item);
  });

  const groupedMeals = Array.from(groupedMealsMap.values());

  const getFormatDisplay = (item) => {
    if (item.unit === 'g') return `${item.name} (${item.quantity}g)`;
    if (item.unit === 'ud') return `${item.name} (${item.quantity} pc)`;
    if (item.unit === 'porcion' && item.quantity !== 1) return `${item.name} (x${item.quantity})`;
    return item.name;
  };

  // Sort groupedMeals strictly from NEWEST (highest time e.g. 21:30) to OLDEST (e.g. 08:00)
  const sortedGroupedMeals = [...groupedMeals].sort(
    (a, b) => b.maxTimeMinutes - a.maxTimeMinutes
  );

  const getPartnerGroupedMeals = (partnerIntakes) => {
    if (!partnerIntakes || partnerIntakes.length === 0) return [];
    const map = new Map();

    partnerIntakes.forEach((item) => {
      const timeStr = item.time || item.timestamp || item.created_at || '12:00';
      const hourRange = getHourRangeKey(timeStr);
      const groupKey = hourRange;

      if (!map.has(groupKey)) {
        map.set(groupKey, {
          key: groupKey,
          timeRange: hourRange,
          dishName: item.dishName || null,
          items: [],
        });
      }

      const group = map.get(groupKey);
      if (!group.dishName && item.dishName) {
        group.dishName = item.dishName;
      }
      group.items.push(item);
    });

    return Array.from(map.values());
  };

  return (
    <div className="space-y-6 sm:space-y-7 my-4">
      {/* Active User Intakes */}
      {sortedGroupedMeals.length === 0 ? (
        <Card className="text-center py-10 space-y-3">
          <Utensils className="w-12 h-12 text-slate-300 mx-auto" />
          <p className="text-sm text-slate-500 font-medium">
            No food intakes recorded for this day yet. Type or dictate below to add.
          </p>
        </Card>
      ) : (
        sortedGroupedMeals.map((meal, mealIdx) => {
          const groupTotalCalories = meal.items.reduce(
            (sum, item) => sum + (item.macros?.calories || 0),
            0
          );

          return (
            <Card
              key={mealIdx}
              className="p-5 sm:p-6 border-l-4 border-l-indigo-600 space-y-4 shadow-sm"
            >
              {/* Group Header */}
              <div className="flex items-center justify-between pb-3 border-b border-slate-200/80 gap-3 flex-wrap">
                <div className="flex items-center gap-2 text-xs sm:text-sm font-bold text-indigo-600 truncate min-w-0">
                  <Clock className="w-4 h-4 shrink-0" />
                  <span className="truncate">
                    {meal.dishName ? `${meal.timeRange} • ${meal.dishName}` : `${meal.timeRange}`}
                  </span>
                </div>

                <div className="flex items-center gap-2.5 shrink-0">
                  <span className="text-xs font-bold font-mono px-3 py-1 rounded-full bg-rose-50 text-rose-600 border border-rose-200">
                    {groupTotalCalories} kcal
                  </span>
                  <span className="text-xs text-slate-500 font-medium">
                    ({meal.items.length} {meal.items.length === 1 ? 'food item' : 'food items'})
                  </span>
                  <button
                    type="button"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleDeleteMealGroup(meal.items);
                    }}
                    aria-label="Borrar ingesta completa"
                    title="Borrar ingesta completa"
                    className="p-1.5 text-slate-400 hover:text-rose-600 hover:bg-rose-50 rounded-lg transition-colors cursor-pointer"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Food Items List */}
              <div className="space-y-3">
                {meal.items.map((item, idx) => {
                  const emoji = getFoodEmoji(item.name, item.category);
                  const catInfo = getCategoryInfo(item.category);
                  const displayTitle = getFormatDisplay(item);

                  return (
                    <div
                      key={item.id || idx}
                      onClick={() => handleItemSelect(item, item.originalIndex ?? idx)}
                      className="flex items-center justify-between p-3.5 sm:p-4 rounded-2xl bg-slate-50 hover:bg-indigo-50/50 border border-slate-100 hover:border-indigo-100 transition-all cursor-pointer gap-3 group shadow-2xs"
                    >
                      <div className="flex items-center gap-3.5 min-w-0 flex-1">
                        <span className="text-2xl shrink-0">{emoji}</span>
                        <div className="min-w-0 flex-1 space-y-1">
                          <div className="flex items-center gap-2 flex-wrap">
                            <span className="font-bold text-xs sm:text-sm text-slate-900 truncate">
                              {displayTitle}
                            </span>
                            <span
                              className="text-[11px] font-semibold px-2.5 py-0.5 rounded-full whitespace-nowrap"
                              style={{ backgroundColor: catInfo.bg, color: catInfo.color }}
                            >
                              {catInfo.emoji} {catInfo.label}
                            </span>
                          </div>

                          <div className="flex flex-wrap gap-2.5 text-xs font-mono font-semibold">
                            <span className="text-rose-500">{item.macros?.calories ?? item.calories ?? 0} kcal</span>
                            <span className="text-blue-600">{item.macros?.protein ?? item.protein ?? 0}g P</span>
                            <span className="text-emerald-600">{item.macros?.carbs ?? item.carbs ?? 0}g C</span>
                            <span className="text-amber-600">{item.macros?.fats ?? item.fats ?? 0}g F</span>
                            {Boolean(item.macros?.fiber || item.fiber) && (
                              <span className="text-teal-600 font-bold">{item.macros?.fiber ?? item.fiber}g Fibra</span>
                            )}
                          </div>
                        </div>
                      </div>

                      <div className="flex items-center gap-1 shrink-0">
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            handleItemSelect(item, item.originalIndex ?? idx);
                          }}
                          className="p-1.5 text-slate-400 hover:text-indigo-600 hover:bg-indigo-50 rounded-lg transition-colors cursor-pointer"
                          title="Editar alimento"
                        >
                          <Edit2 className="w-4 h-4" />
                        </button>
                        <button
                          type="button"
                          onClick={(e) => handleDeleteSingleItem(item, item.originalIndex ?? idx, e)}
                          className="p-1.5 text-slate-400 hover:text-rose-600 hover:bg-rose-50 rounded-lg transition-colors cursor-pointer"
                          title="Eliminar alimento"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </div>
                  );
                })}
              </div>
            </Card>
          );
        })
      )}

      {/* Partner Intakes Section */}
      {partnerProfiles && partnerProfiles.length > 0 && (
        <div className="pt-6 border-t-2 border-dashed border-slate-200 space-y-5">
          {partnerProfiles.map((partner) => {
            const partnerIntakes = partnerIntakesMap[partner.id] || [];
            const partnerGrouped = getPartnerGroupedMeals(partnerIntakes);

            const allKey = `all-${partner.id}`;
            const isCopyingAll = copyingKey === allKey;

            return (
              <div key={partner.id} className="space-y-4">
                <div className="flex items-center justify-between px-1 flex-wrap gap-2">
                  <div className="flex items-center gap-2">
                    <Avatar profile={partner} size="sm" />
                    <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                      {partner.name}'s Intakes ({partnerIntakes.length})
                    </h3>
                  </div>
                  {partnerIntakes.length > 0 && (
                    <button
                      type="button"
                      disabled={Boolean(copyingKey)}
                      onClick={() => handleCopyAllPartnerIntakes(partnerIntakes, partner.name, allKey)}
                      className="text-xs font-bold text-indigo-600 hover:text-indigo-800 flex items-center gap-1.5 bg-indigo-50 hover:bg-indigo-100 px-3 py-1.5 rounded-xl transition-all cursor-pointer shadow-2xs disabled:opacity-50"
                    >
                      {isCopyingAll ? (
                        <Loader2 className="w-3.5 h-3.5 animate-spin text-indigo-600" />
                      ) : (
                        <Plus className="w-3.5 h-3.5" />
                      )}
                      <span>{isCopyingAll ? 'Copying...' : 'Copy All to My Diary'}</span>
                    </button>
                  )}
                </div>

                {partnerIntakes.length === 0 ? (
                  <Card className="p-4 text-center text-xs text-slate-400 font-medium bg-slate-50/60 border-dashed">
                    {partner.name} has not logged any food for this day yet.
                  </Card>
                ) : (
                  <div className="space-y-4">
                    {partnerGrouped.map((meal, idx) => {
                      const mealCals = meal.items.reduce((s, i) => s + (i.macros?.calories || 0), 0);
                      const groupKey = `group-${partner.id}-${meal.key}`;
                      const isCopyingGroup = copyingKey === groupKey;

                      return (
                        <Card key={idx} className="p-4 sm:p-5 bg-slate-50/90 border-slate-200/90 space-y-3 shadow-2xs">
                          <div className="flex items-center justify-between gap-3 flex-wrap border-b border-slate-200/60 pb-2.5">
                            <div className="flex items-center gap-2 text-xs sm:text-sm font-bold text-slate-700">
                              <Clock className="w-4 h-4 text-slate-400" />
                              <span>{meal.dishName ? `${meal.timeRange} • ${meal.dishName}` : meal.timeRange}</span>
                            </div>

                            <div className="flex items-center gap-2">
                              <span className="text-xs font-bold font-mono px-2.5 py-0.5 rounded-full bg-slate-200/80 text-slate-700">
                                {mealCals} kcal
                              </span>
                              <Button
                                size="sm"
                                variant="secondary"
                                icon={isCopyingGroup ? Loader2 : Plus}
                                disabled={Boolean(copyingKey)}
                                onClick={() => handleCopyMealGroup(meal.items, partner.name, groupKey)}
                                className="text-xs py-1"
                              >
                                {isCopyingGroup ? 'Copying...' : 'Copy Group'}
                              </Button>
                            </div>
                          </div>

                          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                            {meal.items.map((item, itemIdx) => {
                              const itemKey = `item-${partner.id}-${item.id || item.name}-${itemIdx}`;
                              const isCopyingItem = copyingKey === itemKey;

                              return (
                                <div
                                  key={itemIdx}
                                  className="flex items-center justify-between p-2.5 rounded-xl bg-white border border-slate-200/80 text-xs gap-2"
                                >
                                  <div className="flex items-center gap-2 min-w-0 flex-1">
                                    <span className="text-base shrink-0">{getFoodEmoji(item.name, item.category)}</span>
                                    <span className="font-bold text-slate-800 truncate">{getFormatDisplay(item)}</span>
                                    <span className="text-slate-400 font-mono text-[11px] shrink-0">
                                      {item.macros?.calories} kcal
                                    </span>
                                  </div>

                                  <button
                                    type="button"
                                    disabled={Boolean(copyingKey)}
                                    onClick={() => handleCopySingleItem(item, partner.name, itemKey)}
                                    className="p-1.5 text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 rounded-lg transition-colors cursor-pointer shrink-0 disabled:opacity-50"
                                    title="Add to my diary"
                                  >
                                    {isCopyingItem ? (
                                      <Loader2 className="w-3.5 h-3.5 animate-spin text-indigo-600" />
                                    ) : (
                                      <Plus className="w-3.5 h-3.5" />
                                    )}
                                  </button>
                                </div>
                              );
                            })}
                          </div>
                        </Card>
                      );
                    })}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
