import React from 'react';
import { Clock, Edit2, Trash2, Utensils } from 'lucide-react';
import { getFoodEmoji } from '../../../utils/emoji';
import { getCategoryInfo } from '../../../utils/category';
import Card from '../../../shared/ui/Card';

export default function DailyTimeline({ intakes, onItemClick, onDeleteGroup }) {
  if (!intakes || intakes.length === 0) {
    return (
      <Card className="text-center py-8 space-y-2">
        <Utensils className="w-10 h-10 text-slate-300 mx-auto" />
        <p className="text-sm text-slate-500 font-medium">
          No hay comidas registradas para este día. Dicta o escribe abajo para añadir.
        </p>
      </Card>
    );
  }

  // Safety expansion: if any intake name contains '+' or '\+', expand it into sub-items
  const expandedIntakes = [];
  intakes.forEach((item, originalIdx) => {
    const rawName = item.name || item.description || '';
    let cleanName = rawName.replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '').trim();

    if (cleanName.includes('+') || cleanName.includes('\\+')) {
      const parts = cleanName.split(/\\?\+/).map((p) => p.trim()).filter(Boolean);
      const count = parts.length;
      parts.forEach((part) => {
        const subName = part.replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '');
        expandedIntakes.push({
          time: item.time || '12:00',
          dishName: item.dishName,
          name: subName,
          quantity: 1,
          unit: 'porcion',
          category: item.category || 'other',
          macros: {
            calories: Math.round(item.macros.calories / count),
            protein: Math.round((item.macros.protein / count) * 10) / 10,
            carbs: Math.round((item.macros.carbs / count) * 10) / 10,
            fats: Math.round((item.macros.fats / count) * 10) / 10,
          },
          originalIndex: originalIdx,
        });
      });
    } else {
      expandedIntakes.push({
        ...item,
        name: cleanName,
        originalIndex: originalIdx,
      });
    }
  });

  // Group by time and dishName
  const groupedMeals = [];
  let currentGroup = null;

  expandedIntakes.forEach((item) => {
    const timeKey = item.time || '12:00';
    const groupKey = item.dishName ? `${timeKey}-${item.dishName}` : timeKey;

    if (!currentGroup || currentGroup.key !== groupKey) {
      currentGroup = {
        key: groupKey,
        time: timeKey,
        dishName: item.dishName,
        items: [],
      };
      groupedMeals.push(currentGroup);
    }
    currentGroup.items.push(item);
  });

  const getFormatDisplay = (item) => {
    if (item.unit === 'g') return `${item.name} (${item.quantity}g)`;
    if (item.unit === 'ud') return `${item.name} (${item.quantity} ud)`;
    if (item.unit === 'porcion' && item.quantity !== 1) return `${item.name} (x${item.quantity})`;
    return item.name;
  };

  return (
    <div className="space-y-4">
      {groupedMeals.map((meal, mealIdx) => {
        const groupTotalCalories = meal.items.reduce(
          (sum, item) => sum + (item.macros?.calories || 0),
          0
        );

        return (
          <Card
            key={mealIdx}
            className="p-4 border-l-4 border-l-indigo-600 space-y-3"
          >
            {/* Group Header */}
            <div className="flex items-center justify-between pb-2 border-b border-slate-200/80 gap-2 flex-wrap">
              <div className="flex items-center gap-1.5 text-xs font-bold text-indigo-600 truncate min-w-0">
                <Clock className="w-4 h-4 shrink-0" />
                <span className="truncate">
                  {meal.dishName ? `${meal.time} - ${meal.dishName}` : `Toma ${meal.time}`}
                </span>
              </div>

              <div className="flex items-center gap-2 shrink-0">
                <span className="text-xs font-bold font-mono px-2.5 py-0.5 rounded-full bg-rose-50 text-rose-600 border border-rose-200">
                  {groupTotalCalories} kcal
                </span>
                <span className="text-xs text-slate-500 font-medium">
                  ({meal.items.length} {meal.items.length === 1 ? 'alimento' : 'alimentos'})
                </span>
                {onDeleteGroup && (
                  <button
                    onClick={(e) => {
                      e.stopPropagation();
                      if (window.confirm('¿Borrar todos los alimentos de esta toma?')) {
                        onDeleteGroup(meal.items);
                      }
                    }}
                    aria-label="Borrar toma completa"
                    className="p-1 text-slate-400 hover:text-rose-600 rounded-lg hover:bg-rose-50 transition-all"
                  >
                    <Trash2 className="w-4 h-4" />
                  </button>
                )}
              </div>
            </div>

            {/* Individual Items */}
            <div className="space-y-2">
              {meal.items.map((item, idx) => {
                const displayTitle = getFormatDisplay(item);
                const emoji = getFoodEmoji(item.name);
                const catInfo = getCategoryInfo(item.category);

                return (
                  <div
                    key={idx}
                    onClick={() => onItemClick && onItemClick(item, item.originalIndex)}
                    className="flex items-center justify-between p-3 rounded-xl bg-slate-50 border border-slate-200/80 hover:border-indigo-200 cursor-pointer transition-all gap-3"
                  >
                    <div className="flex items-center gap-3 min-w-0 flex-1">
                      <span className="text-xl shrink-0">{emoji}</span>
                      <div className="min-w-0 flex-1 space-y-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <span className="font-semibold text-xs sm:text-sm text-slate-900 truncate">
                            {displayTitle}
                          </span>
                          <span
                            className="text-[11px] font-semibold px-2 py-0.5 rounded-full whitespace-nowrap"
                            style={{ backgroundColor: catInfo.bg, color: catInfo.color }}
                          >
                            {catInfo.emoji} {catInfo.label}
                          </span>
                        </div>

                        <div className="flex flex-wrap gap-2 text-xs font-mono font-semibold">
                          <span className="text-rose-500">{item.macros.calories} kcal</span>
                          <span className="text-blue-600">{item.macros.protein}g P</span>
                          <span className="text-emerald-600">{item.macros.carbs}g C</span>
                          <span className="text-amber-600">{item.macros.fats}g G</span>
                        </div>
                      </div>
                    </div>

                    <Edit2 className="w-4 h-4 text-slate-400 shrink-0" />
                  </div>
                );
              })}
            </div>
          </Card>
        );
      })}
    </div>
  );
}
