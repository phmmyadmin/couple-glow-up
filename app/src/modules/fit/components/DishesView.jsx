import React, { useState, useEffect } from 'react';
import {
  UtensilsCrossed,
  Plus,
  Search,
  Sparkles,
  Trash2,
  Edit2,
  Clock,
  ChevronRight,
  BookOpen,
  Check,
  X,
  Loader2,
  Calculator,
  PlusCircle,
  Calendar,
  Flame,
  Scale,
} from 'lucide-react';
import Card from '../../../shared/ui/Card';
import Button from '../../../shared/ui/Button';
import { Input } from '../../../shared/ui/Input';
import { parseFoodWithGemini } from '../../../lib/gemini';
import { parseFoodTextLocal } from '../../../lib/parser';
import { getFoodEmoji } from '../../../utils/emoji';
import { getCategoryInfo } from '../../../utils/category';
import {
  supabase,
  saveIntakesToSupabase,
  fetchDailyLogsFromSupabase,
  saveToCatalog,
} from '../../../lib/supabase';

const LOCAL_DISHES_KEY = 'glowup_custom_dishes';

export default function DishesView({
  selectedDate,
  data,
  setData,
  activeProfileId,
  setToastMessage,
}) {
  const [dishes, setDishes] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');
  const [isEditorOpen, setIsEditorOpen] = useState(false);
  const [editingDish, setEditingDish] = useState(null);

  // AI Ingredient Prompt & Loading state
  const [aiInputText, setAiInputText] = useState('');
  const [isAiLoading, setIsAiLoading] = useState(false);

  // Portion Logging Modal state
  const [loggingDish, setLoggingDish] = useState(null);
  const [portionGrams, setPortionGrams] = useState(100);

  // Handle Escape key to close open modals
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') {
        if (loggingDish) {
          setLoggingDish(null);
        } else if (isEditorOpen) {
          setIsEditorOpen(false);
        }
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [loggingDish, isEditorOpen]);

  // Load custom dishes from Supabase / localStorage
  useEffect(() => {
    loadDishes();
  }, [activeProfileId]);

  const loadDishes = async () => {
    let loadedDishes = [];
    if (supabase && activeProfileId) {
      try {
        const { data: dbDishes, error } = await supabase
          .from('custom_dishes')
          .select('*')
          .eq('profile_id', activeProfileId)
          .order('created_at', { ascending: false });

        if (!error && dbDishes && dbDishes.length > 0) {
          loadedDishes = dbDishes.map((d) => ({
            ...d,
            ingredients: Array.isArray(d.ingredients) ? d.ingredients : [],
          }));
        }
      } catch (e) {
        // Silently fallback if custom_dishes table doesn't exist yet
      }
    }

    if (loadedDishes.length === 0) {
      try {
        const localStr = localStorage.getItem(`${LOCAL_DISHES_KEY}_${activeProfileId || 'default'}`);
        if (localStr) {
          loadedDishes = JSON.parse(localStr);
        }
      } catch (e) {}
    }

    setDishes(loadedDishes);
  };

  const saveDishesState = async (updatedDishes) => {
    setDishes(updatedDishes);

    try {
      localStorage.setItem(
        `${LOCAL_DISHES_KEY}_${activeProfileId || 'default'}`,
        JSON.stringify(updatedDishes)
      );
    } catch (e) {}

    if (supabase && activeProfileId) {
      for (const dish of updatedDishes) {
        try {
          const { error } = await supabase.from('custom_dishes').upsert(
            {
              id: dish.id,
              profile_id: activeProfileId,
              name: dish.name,
              servings: 1,
              total_weight_grams: dish.totalWeightGrams || 0,
              ingredients: dish.ingredients || [],
              updated_at: new Date().toISOString(),
            },
            { onConflict: 'id' }
          );

          if (error) {
            // If custom_dishes table does not exist, save ingredients to catalog tables
            if (Array.isArray(dish.ingredients) && dish.ingredients.length > 0) {
              await saveToCatalog(
                dish.ingredients.map((ing) => ({
                  ...ing,
                  dishName: dish.name,
                }))
              );
            }
          }
        } catch (e) {
          // Silently handle missing table error
        }
      }
    }
  };

  const handleCreateNew = () => {
    setEditingDish({
      id: `dish_${Date.now()}`,
      name: '',
      ingredients: [],
    });
    setAiInputText('');
    setIsEditorOpen(true);
  };

  const handleEditDish = (dish) => {
    setEditingDish(JSON.parse(JSON.stringify(dish)));
    setAiInputText('');
    setIsEditorOpen(true);
  };

  const handleDeleteDish = async (dishId, e) => {
    if (e) e.stopPropagation();
    if (!window.confirm('Delete this saved dish?')) return;

    const updated = dishes.filter((d) => d.id !== dishId);
    await saveDishesState(updated);

    if (supabase && activeProfileId) {
      try {
        await supabase.from('custom_dishes').delete().eq('id', dishId);
      } catch (err) {}
    }

    if (typeof setToastMessage === 'function') {
      setToastMessage('Dish deleted');
    }
  };

  // Helper to extract or calculate base per-unit macros (per 1 unit/gram)
  const getBasePerUnit = (ing) => {
    const qty = Number(ing.quantity) > 0 ? Number(ing.quantity) : 1;
    const baseCals = ing.baseCals !== undefined ? ing.baseCals : (Number(ing.calories) || 0) / qty;
    const baseProt = ing.baseProt !== undefined ? ing.baseProt : (Number(ing.protein) || 0) / qty;
    const baseCarbs = ing.baseCarbs !== undefined ? ing.baseCarbs : (Number(ing.carbs) || 0) / qty;
    const baseFats = ing.baseFats !== undefined ? ing.baseFats : (Number(ing.fats) || 0) / qty;

    return { baseCals, baseProt, baseCarbs, baseFats };
  };

  // Process AI ingredients input for editingDish
  const handleParseAiIngredients = async (e) => {
    if (e) e.preventDefault();
    if (!aiInputText.trim()) return;

    setIsAiLoading(true);
    try {
      let parsed = await parseFoodWithGemini(aiInputText);
      if (!parsed || parsed.length === 0) {
        parsed = parseFoodTextLocal(aiInputText);
      }

      if (parsed && parsed.length > 0) {
        const newIngredients = parsed.map((item, idx) => {
          const qty = item.quantity || 100;
          const cals = Math.round(item.calories ?? item.macros?.calories ?? 0);
          const prot = Math.round(((item.protein ?? item.macros?.protein ?? 0)) * 10) / 10;
          const carbs = Math.round(((item.carbs ?? item.macros?.carbs ?? 0)) * 10) / 10;
          const fats = Math.round(((item.fats ?? item.macros?.fats ?? 0)) * 10) / 10;

          return {
            id: `ing_${Date.now()}_${idx}`,
            name: item.name || 'Ingredient',
            quantity: qty,
            unit: item.unit || 'g',
            category: item.category || 'other',
            calories: cals,
            protein: prot,
            carbs: carbs,
            fats: fats,
            baseCals: qty > 0 ? cals / qty : 0,
            baseProt: qty > 0 ? prot / qty : 0,
            baseCarbs: qty > 0 ? carbs / qty : 0,
            baseFats: qty > 0 ? fats / qty : 0,
          };
        });

        setEditingDish((prev) => {
          const currentIngs = prev?.ingredients || [];
          return {
            ...prev,
            ingredients: [...currentIngs, ...newIngredients],
          };
        });

        setAiInputText('');
        if (typeof setToastMessage === 'function') {
          setToastMessage(`✨ Added ${parsed.length} ingredient(s) with AI macros`);
        }
      }
    } catch (err) {
      console.error('Error parsing AI ingredients:', err);
    } finally {
      setIsAiLoading(false);
    }
  };

  // Add custom manual blank ingredient row
  const handleAddManualIngredient = () => {
    const qty = 100;
    const cals = 100;
    const prot = 5;
    const carbs = 10;
    const fats = 2;

    const newIng = {
      id: `ing_${Date.now()}`,
      name: '',
      quantity: qty,
      unit: 'g',
      category: 'other',
      calories: cals,
      protein: prot,
      carbs: carbs,
      fats: fats,
      baseCals: cals / qty,
      baseProt: prot / qty,
      baseCarbs: carbs / qty,
      baseFats: fats / qty,
    };
    setEditingDish((prev) => ({
      ...prev,
      ingredients: [...(prev?.ingredients || []), newIng],
    }));
  };

  // Update ingredient property & recalculate macros & dish totals in real-time
  const handleUpdateIngredient = (ingId, field, value) => {
    setEditingDish((prev) => {
      const updatedIngs = (prev?.ingredients || []).map((ing) => {
        if (ing.id !== ingId) return ing;

        const { baseCals, baseProt, baseCarbs, baseFats } = getBasePerUnit(ing);

        if (field === 'quantity') {
          if (value === '' || value === null) {
            return { ...ing, quantity: '' };
          }

          const newQty = Number(value);
          if (isNaN(newQty) || newQty < 0) {
            return { ...ing, quantity: value };
          }

          return {
            ...ing,
            quantity: newQty,
            baseCals,
            baseProt,
            baseCarbs,
            baseFats,
            calories: Math.round(baseCals * newQty),
            protein: Math.round(baseProt * newQty * 10) / 10,
            carbs: Math.round(baseCarbs * newQty * 10) / 10,
            fats: Math.round(baseFats * newQty * 10) / 10,
          };
        }

        if (field === 'calories' || field === 'protein' || field === 'carbs' || field === 'fats') {
          if (value === '' || value === null) {
            return { ...ing, [field]: '' };
          }

          const numVal = Number(value);
          const currentQty = Number(ing.quantity) > 0 ? Number(ing.quantity) : 1;

          const updatedIng = {
            ...ing,
            [field]: isNaN(numVal) ? value : numVal,
          };

          if (field === 'calories') updatedIng.baseCals = numVal / currentQty;
          if (field === 'protein') updatedIng.baseProt = numVal / currentQty;
          if (field === 'carbs') updatedIng.baseCarbs = numVal / currentQty;
          if (field === 'fats') updatedIng.baseFats = numVal / currentQty;

          return updatedIng;
        }

        return {
          ...ing,
          [field]: value,
        };
      });

      return { ...prev, ingredients: updatedIngs };
    });
  };

  // Delete single ingredient row
  const handleRemoveIngredient = (ingId) => {
    setEditingDish((prev) => ({
      ...prev,
      ingredients: (prev?.ingredients || []).filter((i) => i.id !== ingId),
    }));
  };

  // Calculate totals for a dish object
  const getDishTotals = (dish) => {
    const ings = dish?.ingredients || [];
    const totals = ings.reduce(
      (acc, ing) => ({
        calories: acc.calories + (Number(ing.calories) || 0),
        protein: acc.protein + (Number(ing.protein) || 0),
        carbs: acc.carbs + (Number(ing.carbs) || 0),
        fats: acc.fats + (Number(ing.fats) || 0),
        grams: acc.grams + (ing.unit === 'g' ? Number(ing.quantity) || 0 : 0),
      }),
      { calories: 0, protein: 0, carbs: 0, fats: 0, grams: 0 }
    );

    return {
      calories: Math.round(totals.calories),
      protein: Math.round(totals.protein * 10) / 10,
      carbs: Math.round(totals.carbs * 10) / 10,
      fats: Math.round(totals.fats * 10) / 10,
      totalGrams: totals.grams > 0 ? totals.grams : 100,
    };
  };

  // Save full dish
  const handleSaveDishSubmit = async (e) => {
    if (e) e.preventDefault();
    if (!editingDish.name.trim()) {
      alert('Please enter a dish name.');
      return;
    }
    if (!editingDish.ingredients || editingDish.ingredients.length === 0) {
      alert('Please add at least one ingredient.');
      return;
    }

    const totals = getDishTotals(editingDish);

    const finalDish = {
      ...editingDish,
      name: editingDish.name.trim(),
      totalWeightGrams: totals.totalGrams,
    };

    const existingIdx = dishes.findIndex((d) => d.id === finalDish.id);
    let updatedList = [];
    if (existingIdx >= 0) {
      updatedList = [...dishes];
      updatedList[existingIdx] = finalDish;
    } else {
      updatedList = [finalDish, ...dishes];
    }

    await saveDishesState(updatedList);
    setIsEditorOpen(false);
    setEditingDish(null);

    if (typeof setToastMessage === 'function') {
      setToastMessage(`🍲 Saved dish "${finalDish.name}" (${totals.totalGrams}g total)`);
    }
  };

  // Open Log Portion modal
  const handleOpenLogPortion = (dish) => {
    const totals = getDishTotals(dish);
    setLoggingDish(dish);
    setPortionGrams(100);
  };

  // Submit eaten portion to Diary
  const handleConfirmLogPortion = async () => {
    if (!loggingDish) return;
    const totals = getDishTotals(loggingDish);
    const eatenWeight = Number(portionGrams) || 100;
    const totalGrams = totals.totalGrams || 100;
    const ratio = eatenWeight / totalGrams;

    const dishNameDesc = `${loggingDish.name} (${eatenWeight}g of ${totalGrams}g)`;

    // Scale ingredient items for diary
    const diaryItems = loggingDish.ingredients.map((ing) => {
      const scaledQty = Math.round((Number(ing.quantity) || 1) * ratio * 10) / 10;
      const scaledCals = Math.round((Number(ing.calories) || 0) * ratio);
      const scaledProt = Math.round((Number(ing.protein) || 0) * ratio * 10) / 10;
      const scaledCarbs = Math.round((Number(ing.carbs) || 0) * ratio * 10) / 10;
      const scaledFats = Math.round((Number(ing.fats) || 0) * ratio * 10) / 10;

      return {
        name: ing.name,
        dishName: dishNameDesc,
        quantity: scaledQty,
        unit: ing.unit || 'g',
        category: ing.category || 'other',
        calories: scaledCals,
        protein: scaledProt,
        carbs: scaledCarbs,
        fats: scaledFats,
        macros: {
          calories: scaledCals,
          protein: scaledProt,
          carbs: scaledCarbs,
          fats: scaledFats,
        },
      };
    });

    const getLocalDateStr = () => {
      const d = new Date();
      const year = d.getFullYear();
      const month = String(d.getMonth() + 1).padStart(2, '0');
      const day = String(d.getDate()).padStart(2, '0');
      return `${year}-${month}-${day}`;
    };

    const targetDate = selectedDate || getLocalDateStr();

    if (supabase && activeProfileId) {
      const result = await saveIntakesToSupabase({
        date: targetDate,
        items: diaryItems,
        profileId: activeProfileId,
      });

      if (result && result.success) {
        const freshData = await fetchDailyLogsFromSupabase(activeProfileId);
        if (freshData && typeof setData === 'function') {
          setData(freshData);
        }
      }
    } else if (typeof setData === 'function' && data) {
      const updatedLogs = [...(data.dailyLogs || [])];
      const dayIdx = updatedLogs.findIndex((l) => l.date === targetDate);

      if (dayIdx >= 0) {
        const existingIntakes = updatedLogs[dayIdx].intakes || [];
        updatedLogs[dayIdx] = {
          ...updatedLogs[dayIdx],
          intakes: [...existingIntakes, ...diaryItems],
        };
      } else {
        updatedLogs.push({
          date: targetDate,
          intakes: diaryItems,
          dailyTotals: { calories: 0, protein: 0, carbs: 0, fats: 0 },
        });
      }

      setData({
        ...data,
        dailyLogs: updatedLogs,
      });
    }

    const totalEatenCals = diaryItems.reduce((s, i) => s + i.calories, 0);
    setLoggingDish(null);

    if (typeof setToastMessage === 'function') {
      setToastMessage(`🍱 Added ${eatenWeight}g of "${loggingDish.name}" (${totalEatenCals} kcal) to Diary`);
    }
  };

  const filteredDishes = dishes.filter((d) =>
    d.name.toLowerCase().includes(searchQuery.toLowerCase())
  );

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Top Header Banner */}
      <Card className="p-5 sm:p-6 bg-gradient-to-r from-indigo-900 via-indigo-800 to-slate-900 text-white rounded-2xl shadow-md border border-indigo-700/50 space-y-2">
        <div className="flex items-center justify-between gap-4">
          <h2 className="text-xl sm:text-2xl font-extrabold flex items-center gap-2.5">
            <UtensilsCrossed className="w-6 h-6 text-indigo-400 shrink-0" />
            <span>Saved Dishes & Recipes</span>
          </h2>
          <span className="text-xs font-bold bg-indigo-950/80 text-indigo-200 px-3 py-1 rounded-full border border-indigo-700/60 font-mono">
            {filteredDishes.length} Saved
          </span>
        </div>
        <p className="text-xs sm:text-sm text-indigo-200/90 max-w-xl">
          Create multi-ingredient recipes with AI macro calculations. Total weight is automatically summed so you can easily log any portion in grams to your diary.
        </p>
      </Card>

      {/* Top Action Bar: Search Input + Perfectly Aligned Create Button */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center justify-between gap-3">
        <div className="relative flex-1">
          <Search className="w-4 h-4 text-slate-400 absolute left-3.5 top-3" />
          <input
            type="text"
            placeholder="Search saved dishes..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full bg-white border border-slate-200/90 rounded-2xl pl-10 pr-4 py-2.5 text-xs sm:text-sm text-slate-900 placeholder-slate-400 focus:outline-hidden focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100 shadow-2xs transition-all"
          />
        </div>

        <button
          type="button"
          onClick={handleCreateNew}
          className="bg-indigo-600 hover:bg-indigo-700 active:scale-[0.98] text-white font-extrabold text-xs sm:text-sm px-5 py-2.5 rounded-2xl flex items-center justify-center gap-2 shadow-sm hover:shadow transition-all shrink-0 cursor-pointer border-none"
        >
          <Plus className="w-4.5 h-4.5 stroke-[2.5]" />
          <span>Create New Dish</span>
        </button>
      </div>

      {/* Dishes List Grid */}
      {filteredDishes.length === 0 ? (
        <Card className="text-center py-12 space-y-4 border-dashed border-2 border-slate-200">
          <BookOpen className="w-12 h-12 text-slate-300 mx-auto" />
          <div className="space-y-1">
            <h3 className="text-base font-extrabold text-slate-800">No Dishes Found</h3>
            <p className="text-xs text-slate-500 max-w-md mx-auto">
              {searchQuery ? `No dish matches "${searchQuery}"` : 'Create your first custom dish or meal prep recipe using AI macro parsing.'}
            </p>
          </div>

          {!searchQuery && (
            <Button onClick={handleCreateNew} className="bg-indigo-600 hover:bg-indigo-700 text-white font-extrabold mx-auto">
              <Plus className="w-4 h-4 mr-1.5" />
              Create First Dish
            </Button>
          )}
        </Card>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 sm:gap-5">
          {filteredDishes.map((dish) => {
            const totals = getDishTotals(dish);
            const per100gCals = Math.round((totals.calories / totals.totalGrams) * 100) || 0;

            return (
              <Card
                key={dish.id}
                className="p-5 space-y-4 border border-slate-200/90 rounded-2xl shadow-xs hover:border-indigo-200 hover:shadow-md transition-all flex flex-col justify-between bg-white"
              >
                <div className="space-y-3">
                  {/* Dish Title & Actions */}
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <h3 className="text-base font-extrabold text-slate-900 group-hover:text-indigo-600 transition-colors">
                        {dish.name}
                      </h3>
                      <p className="text-xs text-slate-500 font-medium flex items-center gap-2 pt-0.5">
                        <Scale className="w-3.5 h-3.5 text-indigo-600 shrink-0" />
                        <span className="font-extrabold text-slate-800 font-mono">{totals.totalGrams}g Total Batch</span>
                        <span>•</span>
                        <span className="font-mono">~{per100gCals} kcal / 100g</span>
                      </p>
                    </div>

                    <div className="flex items-center gap-1 shrink-0">
                      <button
                        type="button"
                        onClick={() => handleEditDish(dish)}
                        className="p-1.5 text-slate-400 hover:text-indigo-600 hover:bg-indigo-50 rounded-lg transition-colors"
                        title="Edit Dish"
                      >
                        <Edit2 className="w-4 h-4" />
                      </button>
                      <button
                        type="button"
                        onClick={(e) => handleDeleteDish(dish.id, e)}
                        className="p-1.5 text-slate-400 hover:text-rose-600 hover:bg-rose-50 rounded-lg transition-colors"
                        title="Delete Dish"
                      >
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  </div>

                  {/* Total Batch Macro Badges Grid */}
                  <div className="bg-slate-50 border border-slate-100 rounded-xl p-3 grid grid-cols-4 gap-2 text-center">
                    <div>
                      <span className="block text-[10px] font-extrabold text-slate-400 uppercase">Total Cals</span>
                      <span className="text-sm font-extrabold text-rose-600 font-mono">{totals.calories}</span>
                      <span className="text-[9px] text-slate-400 block font-mono">kcal</span>
                    </div>
                    <div>
                      <span className="block text-[10px] font-extrabold text-slate-400 uppercase">Protein</span>
                      <span className="text-sm font-extrabold text-blue-600 font-mono">{totals.protein}g</span>
                      <span className="text-[9px] text-slate-400 block font-mono">prot</span>
                    </div>
                    <div>
                      <span className="block text-[10px] font-extrabold text-slate-400 uppercase">Carbs</span>
                      <span className="text-sm font-extrabold text-emerald-600 font-mono">{totals.carbs}g</span>
                      <span className="text-[9px] text-slate-400 block font-mono">carbs</span>
                    </div>
                    <div>
                      <span className="block text-[10px] font-extrabold text-slate-400 uppercase">Fats</span>
                      <span className="text-sm font-extrabold text-amber-600 font-mono">{totals.fats}g</span>
                      <span className="text-[9px] text-slate-400 block font-mono">fats</span>
                    </div>
                  </div>

                  {/* Ingredients Preview Accordion List */}
                  <div className="space-y-1.5 pt-1">
                    <span className="text-[11px] font-extrabold text-slate-400 uppercase tracking-wider block">
                      Ingredients ({dish.ingredients.length})
                    </span>
                    <div className="space-y-1 max-h-36 overflow-y-auto pr-1">
                      {dish.ingredients.map((ing, idx) => {
                        const emoji = getFoodEmoji(ing.name, ing.category);
                        return (
                          <div
                            key={ing.id || idx}
                            className="text-xs bg-slate-50/80 border border-slate-100/80 rounded-lg p-2 flex items-center justify-between gap-2"
                          >
                            <span className="font-bold text-slate-800 truncate flex items-center gap-1.5">
                              <span>{emoji}</span>
                              <span className="truncate">{ing.name}</span>
                            </span>
                            <span className="text-slate-500 font-mono shrink-0">
                              {ing.quantity}{ing.unit} ({ing.calories} kcal)
                            </span>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                </div>

                {/* Log to Diary Primary Action */}
                <div className="pt-3 border-t border-slate-100 flex items-center justify-between gap-3">
                  <span className="text-xs font-bold text-slate-500 font-mono">
                    Batch: {totals.totalGrams}g
                  </span>
                  <Button
                    onClick={() => handleOpenLogPortion(dish)}
                    className="bg-indigo-600 hover:bg-indigo-700 text-white font-extrabold text-xs px-3.5 py-1.5 rounded-xl shadow-2xs flex items-center gap-1.5"
                  >
                    <Plus className="w-3.5 h-3.5" />
                    <span>Log Portion to Diary</span>
                  </Button>
                </div>
              </Card>
            );
          })}
        </div>
      )}

      {/* DISH CREATION / EDITING MODAL */}
      {isEditorOpen && editingDish && (
        <div
          onClick={(e) => {
            if (e.target === e.currentTarget) setIsEditorOpen(false);
          }}
          className="fixed inset-0 bg-slate-900/60 backdrop-blur-xs z-50 flex items-center justify-center p-3 sm:p-4 overflow-y-auto animate-in fade-in duration-200"
        >
          <div className="bg-white rounded-3xl max-w-2xl w-full max-h-[92vh] flex flex-col shadow-2xl border border-slate-200 overflow-hidden">
            {/* Modal Header */}
            <div className="p-5 border-b border-slate-100 flex items-center justify-between bg-slate-50/80 shrink-0">
              <div className="flex items-center gap-2.5">
                <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
                  <UtensilsCrossed className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="text-base sm:text-lg font-extrabold text-slate-900">
                    {editingDish.name ? `Edit "${editingDish.name}"` : 'Create Custom Dish'}
                  </h3>
                  <p className="text-xs text-slate-500">
                    Add ingredients via AI or manually. Total dish weight is auto-calculated from ingredient quantities.
                  </p>
                </div>
              </div>

              <button
                type="button"
                onClick={() => setIsEditorOpen(false)}
                className="p-1.5 text-slate-400 hover:text-slate-700 hover:bg-slate-200/60 rounded-xl transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Modal Scrollable Body */}
            <div className="p-5 space-y-5 overflow-y-auto flex-1">
              {/* Dish Name Input */}
              <div className="space-y-1">
                <label className="text-xs font-extrabold text-slate-700 uppercase tracking-wider block">
                  Dish / Recipe Name
                </label>
                <input
                  type="text"
                  placeholder="e.g. Tofu & Oat Meal Prep Bowl"
                  value={editingDish.name}
                  onChange={(e) => setEditingDish({ ...editingDish, name: e.target.value })}
                  className="w-full bg-slate-50 border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm font-bold text-slate-900 focus:outline-hidden focus:border-indigo-500 focus:bg-white"
                />
              </div>

              {/* AI Quick Ingredient Parser Bar */}
              <Card className="p-4 bg-gradient-to-r from-indigo-50/90 to-purple-50/90 border border-indigo-100 rounded-2xl space-y-2.5">
                <div className="flex items-center justify-between">
                  <label className="text-xs font-extrabold text-indigo-950 flex items-center gap-1.5">
                    <Sparkles className="w-4 h-4 text-indigo-600" />
                    <span>Calculate Ingredients via AI</span>
                  </label>
                  <span className="text-[10px] text-indigo-700/80 font-medium">Type raw ingredients & quantities</span>
                </div>

                <form onSubmit={handleParseAiIngredients} className="flex gap-2">
                  <input
                    type="text"
                    placeholder="e.g. 550g tofu, 240g avena, 80g zanahoria"
                    value={aiInputText}
                    onChange={(e) => setAiInputText(e.target.value)}
                    className="flex-1 bg-white border border-indigo-200 rounded-xl px-3.5 py-2 text-xs font-medium text-slate-900 placeholder-slate-400 focus:outline-hidden focus:border-indigo-500"
                  />

                  <Button
                    type="submit"
                    disabled={isAiLoading || !aiInputText.trim()}
                    className="bg-indigo-600 hover:bg-indigo-700 text-white font-extrabold text-xs px-4 rounded-xl shrink-0 flex items-center gap-1.5"
                  >
                    {isAiLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Sparkles className="w-4 h-4" />}
                    <span>Calculate</span>
                  </Button>
                </form>
              </Card>

              {/* Ingredients Table */}
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h4 className="text-xs font-extrabold text-slate-700 uppercase tracking-wider flex items-center gap-2">
                    <span>Ingredients ({editingDish.ingredients?.length || 0})</span>
                    <span className="text-[11px] font-bold text-indigo-600 bg-indigo-50 px-2 py-0.5 rounded-full border border-indigo-100">
                      {getDishTotals(editingDish).totalGrams}g Total Weight
                    </span>
                  </h4>
                  <button
                    type="button"
                    onClick={handleAddManualIngredient}
                    className="text-xs font-extrabold text-indigo-600 hover:text-indigo-800 flex items-center gap-1 cursor-pointer"
                  >
                    <PlusCircle className="w-4 h-4" />
                    <span>Add Row</span>
                  </button>
                </div>

                {(!editingDish.ingredients || editingDish.ingredients.length === 0) ? (
                  <div className="text-center py-6 bg-slate-50 border border-slate-200/80 rounded-2xl space-y-1">
                    <p className="text-xs text-slate-500 font-medium">No ingredients added yet.</p>
                    <p className="text-[11px] text-slate-400">Use the AI box above or click "Add Row" to enter ingredients manually.</p>
                  </div>
                ) : (
                  <div className="space-y-2.5 max-h-72 overflow-y-auto pr-1">
                    {editingDish.ingredients.map((ing, idx) => (
                      <div
                        key={ing.id || idx}
                        className="bg-slate-50 border border-slate-200 rounded-2xl p-3 space-y-2 shadow-2xs"
                      >
                        {/* Top row: Name + Qty + Unit + Delete */}
                        <div className="grid grid-cols-12 gap-2 items-center">
                          <input
                            type="text"
                            placeholder="Ingredient name"
                            value={ing.name}
                            onChange={(e) => handleUpdateIngredient(ing.id, 'name', e.target.value)}
                            className="col-span-5 bg-white border border-slate-200 rounded-lg px-2.5 py-1 text-xs font-bold text-slate-900 focus:outline-hidden focus:border-indigo-500"
                          />

                          <input
                            type="number"
                            placeholder="Qty"
                            value={ing.quantity}
                            onFocus={(e) => e.target.select()}
                            onChange={(e) => handleUpdateIngredient(ing.id, 'quantity', e.target.value)}
                            className="col-span-3 bg-white border border-slate-200 rounded-lg px-2 py-1 text-xs font-bold font-mono text-slate-900 focus:outline-hidden focus:border-indigo-500"
                          />

                          <select
                            value={ing.unit}
                            onChange={(e) => handleUpdateIngredient(ing.id, 'unit', e.target.value)}
                            className="col-span-3 bg-white border border-slate-200 rounded-lg px-1.5 py-1 text-xs font-bold text-slate-700 focus:outline-hidden"
                          >
                            <option value="g">g</option>
                            <option value="ud">ud</option>
                            <option value="ml">ml</option>
                            <option value="porcion">porcion</option>
                          </select>

                          <button
                            type="button"
                            onClick={() => handleRemoveIngredient(ing.id)}
                            className="col-span-1 text-slate-400 hover:text-rose-600 p-1 flex items-center justify-center cursor-pointer"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </div>

                        {/* Bottom row: Editable Macros Grid (Calories, Protein, Carbs, Fats) */}
                        <div className="grid grid-cols-4 gap-2 pt-1 border-t border-slate-200/60 text-center">
                          <div>
                            <span className="text-[9px] font-bold text-rose-500 block">Kcal</span>
                            <input
                              type="number"
                              value={ing.calories}
                              onFocus={(e) => e.target.select()}
                              onChange={(e) => handleUpdateIngredient(ing.id, 'calories', e.target.value)}
                              className="w-full bg-white border border-slate-200 rounded-md px-1 py-0.5 text-xs font-extrabold font-mono text-center text-rose-600"
                            />
                          </div>

                          <div>
                            <span className="text-[9px] font-bold text-blue-500 block">Prot (g)</span>
                            <input
                              type="number"
                              step="0.1"
                              value={ing.protein}
                              onFocus={(e) => e.target.select()}
                              onChange={(e) => handleUpdateIngredient(ing.id, 'protein', e.target.value)}
                              className="w-full bg-white border border-slate-200 rounded-md px-1 py-0.5 text-xs font-extrabold font-mono text-center text-blue-600"
                            />
                          </div>

                          <div>
                            <span className="text-[9px] font-bold text-emerald-500 block">Carbs (g)</span>
                            <input
                              type="number"
                              step="0.1"
                              value={ing.carbs}
                              onFocus={(e) => e.target.select()}
                              onChange={(e) => handleUpdateIngredient(ing.id, 'carbs', e.target.value)}
                              className="w-full bg-white border border-slate-200 rounded-md px-1 py-0.5 text-xs font-extrabold font-mono text-center text-emerald-600"
                            />
                          </div>

                          <div>
                            <span className="text-[9px] font-bold text-amber-500 block">Fat (g)</span>
                            <input
                              type="number"
                              step="0.1"
                              value={ing.fats}
                              onFocus={(e) => e.target.select()}
                              onChange={(e) => handleUpdateIngredient(ing.id, 'fats', e.target.value)}
                              className="w-full bg-white border border-slate-200 rounded-md px-1 py-0.5 text-xs font-extrabold font-mono text-center text-amber-600"
                            />
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* Total Live Dish Summary Card */}
              {editingDish.ingredients?.length > 0 && (
                <Card className="p-4 bg-slate-900 text-white rounded-2xl space-y-2 shadow-inner">
                  <div className="flex items-center justify-between text-xs font-extrabold text-slate-300">
                    <span>Total Dish Batch Macros</span>
                    <span className="font-mono text-indigo-300">
                      {getDishTotals(editingDish).totalGrams}g Total Weight
                    </span>
                  </div>

                  <div className="grid grid-cols-4 gap-2 text-center pt-1 border-t border-slate-800">
                    <div>
                      <span className="text-base font-extrabold font-mono text-rose-400">
                        {getDishTotals(editingDish).calories}
                      </span>
                      <span className="text-[9px] text-slate-400 block uppercase font-bold">Calories</span>
                    </div>

                    <div>
                      <span className="text-base font-extrabold font-mono text-blue-400">
                        {getDishTotals(editingDish).protein}g
                      </span>
                      <span className="text-[9px] text-slate-400 block uppercase font-bold">Protein</span>
                    </div>

                    <div>
                      <span className="text-base font-extrabold font-mono text-emerald-400">
                        {getDishTotals(editingDish).carbs}g
                      </span>
                      <span className="text-[9px] text-slate-400 block uppercase font-bold">Carbs</span>
                    </div>

                    <div>
                      <span className="text-base font-extrabold font-mono text-amber-400">
                        {getDishTotals(editingDish).fats}g
                      </span>
                      <span className="text-[9px] text-slate-400 block uppercase font-bold">Fats</span>
                    </div>
                  </div>
                </Card>
              )}
            </div>

            {/* Modal Footer */}
            <div className="p-4 border-t border-slate-100 bg-slate-50 flex items-center justify-end gap-2 shrink-0">
              <Button
                type="button"
                onClick={() => setIsEditorOpen(false)}
                className="bg-slate-200 text-slate-700 hover:bg-slate-300 font-extrabold text-xs"
              >
                Cancel
              </Button>

              <Button
                type="button"
                onClick={handleSaveDishSubmit}
                className="bg-indigo-600 hover:bg-indigo-700 text-white font-extrabold text-xs px-5 flex items-center gap-1.5"
              >
                <Check className="w-4 h-4" />
                <span>Save Dish</span>
              </Button>
            </div>
          </div>
        </div>
      )}

      {/* LOG PORTION TO DIARY MODAL */}
      {loggingDish && (
        <div
          onClick={(e) => {
            if (e.target === e.currentTarget) setLoggingDish(null);
          }}
          className="fixed inset-0 bg-slate-900/60 backdrop-blur-xs z-50 flex items-center justify-center p-4 animate-in fade-in duration-200"
        >
          <div className="bg-white rounded-3xl max-w-md w-full p-6 space-y-5 shadow-2xl border border-slate-200">
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <div className="flex items-center gap-2">
                <UtensilsCrossed className="w-5 h-5 text-indigo-600" />
                <h3 className="text-base font-extrabold text-slate-900">Log Dish Portion to Diary</h3>
              </div>
              <button
                type="button"
                onClick={() => setLoggingDish(null)}
                className="p-1 text-slate-400 hover:text-slate-700 cursor-pointer"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            <div className="space-y-4">
              <div>
                <h4 className="font-extrabold text-slate-900 text-base">{loggingDish.name}</h4>
                <p className="text-xs text-slate-500 font-medium pt-0.5">
                  Total Batch Weight: <span className="font-bold text-slate-800 font-mono">{getDishTotals(loggingDish).totalGrams}g</span>
                </p>
              </div>

              {/* Grams Input */}
              <div className="space-y-1.5 bg-slate-50 p-4 border border-slate-200/80 rounded-2xl">
                <label className="text-xs font-extrabold text-slate-700 uppercase tracking-wider flex items-center justify-between">
                  <span>How many grams did you eat?</span>
                  <span className="text-indigo-600 font-mono text-[11px]">
                    {Math.round(((Number(portionGrams) || 0) / getDishTotals(loggingDish).totalGrams) * 100)}% of batch
                  </span>
                </label>
                <div className="relative">
                  <input
                    type="number"
                    min="1"
                    placeholder="e.g. 110"
                    value={portionGrams}
                    onFocus={(e) => e.target.select()}
                    onChange={(e) => setPortionGrams(e.target.value)}
                    className="w-full bg-white border border-slate-300 rounded-xl pl-4 pr-12 py-2.5 text-lg font-extrabold font-mono text-slate-900 focus:outline-hidden focus:border-indigo-500 shadow-2xs"
                  />
                  <span className="absolute right-4 top-3 text-xs font-bold text-slate-400 font-mono">grams</span>
                </div>
              </div>

              {/* Eaten Portion Macros Preview Card */}
              {(() => {
                const totals = getDishTotals(loggingDish);
                const eatenGrams = Number(portionGrams) || 100;
                const ratio = eatenGrams / (totals.totalGrams || 100);

                const eatenCals = Math.round(totals.calories * ratio);
                const eatenProt = Math.round(totals.protein * ratio * 10) / 10;
                const eatenCarbs = Math.round(totals.carbs * ratio * 10) / 10;
                const eatenFats = Math.round(totals.fats * ratio * 10) / 10;

                return (
                  <div className="bg-indigo-50/70 border border-indigo-100 rounded-2xl p-4 space-y-2">
                    <span className="text-[11px] font-extrabold text-indigo-900 uppercase block tracking-wider">
                      Eaten Portion Macros Preview ({eatenGrams}g)
                    </span>
                    <div className="grid grid-cols-4 gap-2 text-center">
                      <div>
                        <span className="text-sm font-extrabold font-mono text-rose-600 block">{eatenCals}</span>
                        <span className="text-[9px] font-bold text-slate-500">kcal</span>
                      </div>
                      <div>
                        <span className="text-sm font-extrabold font-mono text-blue-600 block">{eatenProt}g</span>
                        <span className="text-[9px] font-bold text-slate-500">prot</span>
                      </div>
                      <div>
                        <span className="text-sm font-extrabold font-mono text-emerald-600 block">{eatenCarbs}g</span>
                        <span className="text-[9px] font-bold text-slate-500">carbs</span>
                      </div>
                      <div>
                        <span className="text-sm font-extrabold font-mono text-amber-600 block">{eatenFats}g</span>
                        <span className="text-[9px] font-bold text-slate-500">fats</span>
                      </div>
                    </div>
                  </div>
                );
              })()}
            </div>

            <div className="flex items-center justify-end gap-2 pt-2 border-t border-slate-100">
              <Button
                onClick={() => setLoggingDish(null)}
                className="bg-slate-100 text-slate-700 hover:bg-slate-200 font-extrabold text-xs"
              >
                Cancel
              </Button>
              <Button
                onClick={handleConfirmLogPortion}
                className="bg-indigo-600 hover:bg-indigo-700 text-white font-extrabold text-xs px-5 flex items-center gap-1.5"
              >
                <Plus className="w-4 h-4" />
                <span>Log {portionGrams || 100}g to Diary</span>
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
