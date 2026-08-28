import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = (supabaseUrl && supabaseAnonKey && !supabaseUrl.includes('xyzcompany'))
  ? createClient(supabaseUrl, supabaseAnonKey)
  : null;

export async function fetchProfiles() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase.from('profiles').select('*').order('created_at', { ascending: true });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching profiles:', err);
    return [];
  }
}

export async function saveProfile(profile) {
  if (!supabase) return null;
  try {
    // Si no tiene id, lo insertamos
    if (!profile.id) {
      const { data, error } = await supabase.from('profiles').insert(profile).select().single();
      if (error) throw error;
      return data;
    }
    // Si tiene id, hacemos update
    const { data, error } = await supabase.from('profiles').update(profile).eq('id', profile.id).select().single();
    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error saving profile:', err);
    return null;
  }
}

// Standard nutritional density per 100g fallback dictionary
export const NUTRITION_PER_100G_FALLBACK = {
  'oatmeal': { fiber: 10.0, sugar: 1.0, sodium: 2 },
  'oat': { fiber: 10.0, sugar: 1.0, sodium: 2 },
  'avena': { fiber: 10.0, sugar: 1.0, sodium: 2 },
  'chickpea': { fiber: 7.6, sugar: 4.8, sodium: 24 },
  'chickpeas': { fiber: 7.6, sugar: 4.8, sodium: 24 },
  'garbanzo': { fiber: 7.6, sugar: 4.8, sodium: 24 },
  'garbanzos': { fiber: 7.6, sugar: 4.8, sodium: 24 },
  'tofu': { fiber: 1.5, sugar: 0.8, sodium: 10 },
  'carrot': { fiber: 2.8, sugar: 4.7, sodium: 69 },
  'zanahoria': { fiber: 2.8, sugar: 4.7, sodium: 69 },
  'peanut butter': { fiber: 6.0, sugar: 9.0, sodium: 400 },
  'crema de cacahuete': { fiber: 6.0, sugar: 9.0, sodium: 400 },
  'chocolate powder': { fiber: 15.0, sugar: 55.0, sodium: 120 },
  'cacao': { fiber: 15.0, sugar: 55.0, sodium: 120 },
  'condensed milk': { fiber: 14.0, sugar: 50.0, sodium: 100 },
  'potato': { fiber: 2.2, sugar: 0.8, sodium: 6 },
  'cooked potato': { fiber: 2.2, sugar: 0.8, sodium: 6 },
  'patata': { fiber: 2.2, sugar: 0.8, sodium: 6 },
  'sweet potato': { fiber: 3.0, sugar: 4.2, sodium: 55 },
  'boniato': { fiber: 3.0, sugar: 4.2, sodium: 55 },
  'rice': { fiber: 0.4, sugar: 0.1, sodium: 1 },
  'cooked rice': { fiber: 0.4, sugar: 0.1, sodium: 1 },
  'arroz': { fiber: 0.4, sugar: 0.1, sodium: 1 },
  'chia': { fiber: 34.4, sugar: 0.8, sodium: 16 },
  'chia seed': { fiber: 34.4, sugar: 0.8, sodium: 16 },
  'chia seeds': { fiber: 34.4, sugar: 0.8, sodium: 16 },
  'yogurt': { fiber: 0, sugar: 4.7, sodium: 46 },
  'natural yogurt': { fiber: 0, sugar: 4.7, sodium: 46 },
  'chicken breast': { fiber: 0, sugar: 0, sodium: 65 },
  'cooked chicken breast': { fiber: 0, sugar: 0, sodium: 70 },
  'pork stew': { fiber: 1.0, sugar: 1.5, sodium: 350 },
  'burger': { fiber: 0.5, sugar: 1.0, sodium: 450 },
  'ice pop': { fiber: 0, sugar: 12.0, sodium: 10 },
  'protein brownie': { fiber: 2.5, sugar: 8.0, sodium: 180 },
  'buko shake': { fiber: 2.0, sugar: 25.0, sodium: 60 }
};

export function getNutritionalFallbackForFood(foodName, quantityGrams = 100) {
  const cleanName = (foodName || '').toLowerCase().trim();
  const qty = Number(quantityGrams) > 0 ? Number(quantityGrams) : 100;

  for (const [key, val] of Object.entries(NUTRITION_PER_100G_FALLBACK)) {
    if (cleanName.includes(key)) {
      return {
        fiber: Math.round((val.fiber * (qty / 100)) * 10) / 10,
        sugar: Math.round((val.sugar * (qty / 100)) * 10) / 10,
        sodium: Math.round(val.sodium * (qty / 100)),
      };
    }
  }

  return { fiber: 0, sugar: 0, sodium: 0 };
}

export async function fetchDailyLogsFromSupabase(profileId) {
  if (!supabase || !profileId) return null;

  try {
    const { data: logs, error: logsErr } = await supabase
      .from('daily_logs')
      .select('*, intakes(*)')
      .eq('profile_id', profileId)
      .gte('date', new Date(Date.now() - 90 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]);

    if (logsErr) throw logsErr;

    const { data: profile } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', profileId)
      .maybeSingle();

    const { data: weights } = await supabase
      .from('weight_logs')
      .select('*')
      .eq('profile_id', profileId)
      .order('date', { ascending: true });

    const formattedLogs = (logs || []).map(l => {
      // Sort intakes by created_at descending (newest first)
      const rawIntakes = [...(l.intakes || [])].sort((a, b) => 
        (b.created_at || b.time || '').localeCompare(a.created_at || a.time || '')
      );

      const parsedIntakes = rawIntakes.map(i => {
        const qty = Number(i.quantity) || 100;
        const fallbackNut = getNutritionalFallbackForFood(i.name, qty);

        const fiber = (i.fiber !== undefined && i.fiber !== null && Number(i.fiber) > 0) ? Number(i.fiber) : fallbackNut.fiber;
        const sugar = (i.sugar !== undefined && i.sugar !== null && Number(i.sugar) > 0) ? Number(i.sugar) : fallbackNut.sugar;
        const sodium = (i.sodium !== undefined && i.sodium !== null && Number(i.sodium) > 0) ? Number(i.sodium) : fallbackNut.sodium;

        return {
          id: i.id,
          time: i.time || '12:00',
          name: i.name,
          dishName: i.dish_name,
          quantity: i.quantity,
          unit: i.unit,
          category: i.category || 'other',
          calories: i.calories,
          protein: i.protein,
          carbs: i.carbs,
          fats: i.fats,
          fiber,
          sugar,
          sodium,
          macros: {
            calories: i.calories,
            protein: i.protein,
            carbs: i.carbs,
            fats: i.fats,
            fiber,
            sugar,
            sodium,
          }
        };
      });

      return {
        date: l.date,
        intakes: parsedIntakes,
        dailyTotals: {
          calories: l.calories,
          protein: l.protein,
          carbs: l.carbs,
          fats: l.fats,
          fiber: parsedIntakes.reduce((sum, item) => sum + (item.fiber || 0), 0),
          sugar: parsedIntakes.reduce((sum, item) => sum + (item.sugar || 0), 0),
          sodium: parsedIntakes.reduce((sum, item) => sum + (item.sodium || 0), 0),
        }
      };
    });

    // Sort logs by date ascending
    formattedLogs.sort((a, b) => a.date.localeCompare(b.date));

    const targetMacros = {
      calories: Number(profile?.target_calories) || Number(profile?.target_macros?.calories) || 2000,
      protein: Number(profile?.target_protein) || Number(profile?.target_macros?.protein) || 150,
      carbs: Number(profile?.target_carbs) || Number(profile?.target_macros?.carbs) || 200,
      fats: Number(profile?.target_fats) || Number(profile?.target_macros?.fats) || 60,
      fiber: Number(profile?.target_fiber) || Number(profile?.target_macros?.fiber) || 30,
      sugar: Number(profile?.target_sugar) || Number(profile?.target_macros?.sugar) || 50,
      sodium: Number(profile?.target_sodium) || Number(profile?.target_macros?.sodium) || 2300,
    };

    return {
      userProfile: {
        name: profile?.name || 'User',
        gender: profile?.gender || 'male',
        age: profile?.age || 25,
        height: profile?.height || 170,
        weight: profile?.weight || 70,
        targetWeight: profile?.target_weight || 65,
        maintenanceCalories: profile?.maintenance_calories || 2450,
        targetMacros,
        target_macros: targetMacros,
      },
      dailyLogs: formattedLogs,
      weightLogs: (weights || []).map(w => ({
        date: w.date,
        time: w.time,
        weight: w.weight
      }))
    };
  } catch (err) {
    console.error('Error fetching daily logs from Supabase:', err);
    return null;
  }
}

export async function fetchPartnerIntakesForDate(partnerProfileId, dateStr) {
  if (!supabase || !partnerProfileId || !dateStr) return [];
  try {
    const { data: log, error } = await supabase
      .from('daily_logs')
      .select('*, intakes(*)')
      .eq('profile_id', partnerProfileId)
      .eq('date', dateStr)
      .maybeSingle();

    if (error || !log || !log.intakes) return [];

    return (log.intakes || []).map((i) => {
      const qty = Number(i.quantity) || 100;
      const fallbackNut = getNutritionalFallbackForFood(i.name, qty);

      const fiber = (i.fiber !== undefined && i.fiber !== null && Number(i.fiber) > 0) ? Number(i.fiber) : fallbackNut.fiber;
      const sugar = (i.sugar !== undefined && i.sugar !== null && Number(i.sugar) > 0) ? Number(i.sugar) : fallbackNut.sugar;
      const sodium = (i.sodium !== undefined && i.sodium !== null && Number(i.sodium) > 0) ? Number(i.sodium) : fallbackNut.sodium;

      return {
        id: i.id,
        time: i.time || '12:00',
        name: i.name,
        dishName: i.dish_name,
        quantity: i.quantity,
        unit: i.unit,
        category: i.category || 'other',
        fiber,
        sugar,
        sodium,
        macros: {
          calories: i.calories,
          protein: i.protein,
          carbs: i.carbs,
          fats: i.fats,
          fiber,
          sugar,
          sodium,
        },
      };
    });
  } catch (err) {
    console.error('Error fetching partner intakes for date:', err);
    return [];
  }
}

export async function saveIntakesToSupabase({ date, items, profileId }) {
  if (!supabase || !profileId) return null;

  try {
    let { data: dayLog } = await supabase
      .from('daily_logs')
      .select('*')
      .eq('date', date)
      .eq('profile_id', profileId)
      .maybeSingle();

    if (!dayLog) {
      const { data: newLog, error: createErr } = await supabase
        .from('daily_logs')
        .insert({ date, profile_id: profileId, calories: 0, protein: 0, carbs: 0, fats: 0 })
        .select()
        .single();
      if (createErr) throw createErr;
      dayLog = newLog;
    }

    const now = new Date();
    const timeStr = `${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`;

    const intakeRows = items.map(i => {
      const isGramCategory = ['meat','grains','tubers','legumes','vegetables','healthy_fats'].includes(i.category);
      const resolvedUnit = (i.unit && i.unit !== 'porcion') 
        ? i.unit 
        : (((i.quantity || i.portion_qty) > 5) || isGramCategory ? 'g' : 'ud');
      
      const itemName = i.name || i.parsed_name || i.raw_text || 'Food Item';
      const qty = Number(i.portion_qty || i.quantity) || (resolvedUnit === 'g' ? 100 : 1);
      const fallbackNut = getNutritionalFallbackForFood(itemName, qty);

      const resolvedFiber = (i.fiber !== undefined && i.fiber !== null && Number(i.fiber) > 0)
        ? Number(i.fiber)
        : (i.macros?.fiber !== undefined && Number(i.macros.fiber) > 0 ? Number(i.macros.fiber) : fallbackNut.fiber);

      const resolvedSugar = (i.sugar !== undefined && i.sugar !== null && Number(i.sugar) > 0)
        ? Number(i.sugar)
        : (i.macros?.sugar !== undefined && Number(i.macros.sugar) > 0 ? Number(i.macros.sugar) : fallbackNut.sugar);

      const resolvedSodium = (i.sodium !== undefined && i.sodium !== null && Number(i.sodium) > 0)
        ? Number(i.sodium)
        : (i.macros?.sodium !== undefined && Number(i.macros.sodium) > 0 ? Number(i.macros.sodium) : fallbackNut.sodium);

      return {
        daily_log_id: dayLog.id,
        profile_id: profileId,
        date: date,
        time: timeStr,
        name: itemName,
        dish_name: i.dish_name || i.dishName || null,
        quantity: qty,
        unit: resolvedUnit,
        category: i.category || 'other',
        calories: i.calories ?? i.macros?.calories ?? 0,
        protein: i.protein ?? i.macros?.protein ?? 0,
        carbs: i.carbs ?? i.macros?.carbs ?? 0,
        fats: i.fats ?? i.macros?.fats ?? 0,
        fiber: resolvedFiber,
        sugar: resolvedSugar,
        sodium: resolvedSodium,
      };
    });

    const { error: insertErr } = await supabase.from('intakes').insert(intakeRows);
    if (insertErr) throw insertErr;

    await updateDailyLogTotals(date, profileId);
    await saveToCatalog(items);

    // Publish feed event for food intake
    try {
      const { data: prof } = await supabase.from('profiles').select('name').eq('id', profileId).maybeSingle();
      const foodNames = items.map((i) => i.name).join(', ');
      const totalCals = items.reduce((sum, i) => sum + (i.calories || i.macros?.calories || 0), 0);
      const desc = totalCals > 0 ? `${foodNames} (${Math.round(totalCals)} kcal)` : foodNames;

      await supabase.from('feed_events').insert({
        profile_id: profileId,
        event_type: 'food_intake_logged',
        title: `🥗 ${prof?.name || 'Partner'} logged food`,
        description: desc,
        emoji: '🍱',
      });
    } catch (feedErr) {
      console.error('Error publishing food intake to feed:', feedErr);
    }

    return { success: true, addedItems: items };
  } catch (err) {
    console.error('Supabase save error:', err);
    return null;
  }
}

export async function saveWeightToSupabase({ date, time, weight, profileId }) {
  if (!supabase || !profileId) return null;

  try {
    const entryTime = time || '08:00';
    await supabase.from('weight_logs').delete().eq('date', date).eq('time', entryTime).eq('profile_id', profileId);
    
    const { error } = await supabase
      .from('weight_logs')
      .insert({ date, time: entryTime, weight: parseFloat(weight), profile_id: profileId });

    if (error) throw error;
    return { success: true };
  } catch (err) {
    console.error('Supabase weight save error:', err);
    return null;
  }
}

export async function deleteWeightFromSupabase({ date, time, profileId }) {
  if (!supabase || !profileId) return null;

  try {
    const query = supabase.from('weight_logs').delete().eq('date', date).eq('profile_id', profileId);
    if (time) query.eq('time', time);
    const { error } = await query;
    if (error) throw error;
    return { success: true };
  } catch (err) {
    console.error('Supabase weight delete error:', err);
    return null;
  }
}

export async function deleteIntakeFromSupabase({ date, index, item, profileId }) {
  if (!supabase || !profileId) return null;

  try {
    let targetId = item?.id;

    if (!targetId) {
      const { data: dayLog } = await supabase
        .from('daily_logs')
        .select('*, intakes(*)')
        .eq('date', date)
        .eq('profile_id', profileId)
        .maybeSingle();

      if (!dayLog || !dayLog.intakes) return null;

      const sorted = [...dayLog.intakes].sort((a, b) => 
        (a.created_at || '').localeCompare(b.created_at || '')
      );
      if (sorted[index]) {
        targetId = sorted[index].id;
      }
    }

    if (!targetId) return null;

    const { error: delErr } = await supabase
      .from('intakes')
      .delete()
      .eq('id', targetId);

    if (delErr) throw delErr;

    await updateDailyLogTotals(date, profileId);

    return { success: true };
  } catch (err) {
    console.error('Supabase delete intake error:', err);
    return null;
  }
}

export async function updateIntakeInSupabase({ date, index, item, quantity, macros, category, time, profileId }) {
  if (!supabase || !profileId) return null;

  try {
    let targetId = item?.id;

    if (!targetId) {
      const { data: dayLog } = await supabase
        .from('daily_logs')
        .select('*, intakes(*)')
        .eq('date', date)
        .eq('profile_id', profileId)
        .maybeSingle();

      if (!dayLog || !dayLog.intakes) return null;

      const sorted = [...dayLog.intakes].sort((a, b) => 
        (a.created_at || '').localeCompare(b.created_at || '')
      );
      if (sorted[index]) {
        targetId = sorted[index].id;
      }
    }

    if (!targetId) return null;

    const updatePayload = {
      quantity: quantity,
      calories: macros.calories,
      protein: macros.protein,
      carbs: macros.carbs,
      fats: macros.fats,
      fiber: macros.fiber !== undefined ? macros.fiber : 0,
      sugar: macros.sugar !== undefined ? macros.sugar : 0,
      sodium: macros.sodium !== undefined ? macros.sodium : 0,
    };

    if (category) updatePayload.category = category;
    if (time) updatePayload.time = time;

    const { error: updateErr } = await supabase
      .from('intakes')
      .update(updatePayload)
      .eq('id', targetId);

    if (updateErr) throw updateErr;

    await updateDailyLogTotals(date, profileId);

    return { success: true };
  } catch (err) {
    console.error('Supabase update intake error:', err);
    return null;
  }
}

async function updateDailyLogTotals(date, profileId) {
  const { data: allIntakes } = await supabase
    .from('intakes')
    .select('*')
    .eq('date', date)
    .eq('profile_id', profileId);

  const totals = (allIntakes || []).reduce((acc, curr) => ({
    calories: Math.round(acc.calories + curr.calories),
    protein: Math.round((acc.protein + curr.protein) * 10) / 10,
    carbs: Math.round((acc.carbs + curr.carbs) * 10) / 10,
    fats: Math.round((acc.fats + curr.fats) * 10) / 10
  }), { calories: 0, protein: 0, carbs: 0, fats: 0 });

  await supabase
    .from('daily_logs')
    .update(totals)
    .eq('date', date)
    .eq('profile_id', profileId);
}

export async function deleteIntakesGroupFromSupabase({ date, items, profileId }) {
  if (!supabase || !profileId || !items || items.length === 0) return null;

  try {
    const idsToDelete = items.map(i => i.id).filter(Boolean);

    if (idsToDelete.length > 0) {
      const { error } = await supabase.from('intakes').delete().in('id', idsToDelete);
      if (error) throw error;
    } else {
      const timeVal = items[0].time;
      const dishVal = items[0].dishName;
      let query = supabase.from('intakes').delete().eq('date', date).eq('profile_id', profileId);
      if (timeVal) query = query.eq('time', timeVal);
      if (dishVal) query = query.eq('dish_name', dishVal);
      const { error } = await query;
      if (error) throw error;
    }

    await updateDailyLogTotals(date, profileId);
    return { success: true };
  } catch (err) {
    console.error('Error deleting intake group from Supabase:', err);
    return null;
  }
}

export async function fetchCatalog() {
  if (!supabase) return { ingredients: [], dishes: [] };
  try {
    let ingredientsData = null;
    let dishesData = null;

    try {
      const resIng = await supabase.from('ingredients').select('*').order('name');
      ingredientsData = resIng.data;
    } catch (e) {}

    try {
      const resDish = await supabase.from('dishes').select('*, dish_ingredients(*, ingredients(*))').order('name');
      dishesData = resDish.data;
    } catch (e) {}

    let ingredients = ingredientsData || [];
    let dishes = (dishesData || []).map(d => ({
      ...d,
      components: (d.dish_ingredients || []).map(di => ({
        name: di.ingredients?.name || 'Ingrediente',
        category: di.ingredients?.category || 'other',
        unit: di.unit || di.ingredients?.unit || 'g',
        quantity: di.quantity || 100,
        calories: Math.round((di.ingredients?.calories || 0) * (di.quantity || 100) / 100),
        protein: Math.round(((di.ingredients?.protein || 0) * (di.quantity || 100) / 100) * 10) / 10,
        carbs: Math.round(((di.ingredients?.carbs || 0) * (di.quantity || 100) / 100) * 10) / 10,
        fats: Math.round(((di.ingredients?.fats || 0) * (di.quantity || 100) / 100) * 10) / 10
      }))
    }));

    // Always fetch intakes to enrich catalog with any recent dishes/ingredients logged in intakes
    try {
      const { data: intakesData } = await supabase.from('intakes').select('name, category, unit, calories, protein, carbs, fats, dish_name').limit(500);
      if (intakesData && intakesData.length > 0) {
        const uniqueIngMap = new Map();
        const uniqueDishMap = new Map();

        // Prepopulate with existing
        ingredients.forEach(ing => ing.name && uniqueIngMap.set(ing.name.trim().toLowerCase(), ing));
        dishes.forEach(d => d.name && uniqueDishMap.set(d.name.trim().toLowerCase(), d));

        intakesData.forEach(item => {
          if (item.name && !uniqueIngMap.has(item.name.trim().toLowerCase())) {
            uniqueIngMap.set(item.name.trim().toLowerCase(), {
              name: item.name.trim(),
              category: item.category || 'other',
              unit: item.unit || 'g',
              calories: item.calories || 0,
              protein: item.protein || 0,
              carbs: item.carbs || 0,
              fats: item.fats || 0
            });
          }
          if (item.dish_name && item.dish_name.trim()) {
            const dishKey = item.dish_name.trim().toLowerCase();
            if (!uniqueDishMap.has(dishKey)) {
              uniqueDishMap.set(dishKey, { name: item.dish_name.trim(), components: [] });
            }
            const existingComponents = uniqueDishMap.get(dishKey).components || [];
            if (!existingComponents.some(c => c.name === item.name)) {
              existingComponents.push({
                name: item.name,
                category: item.category || 'other',
                unit: item.unit || 'g',
                quantity: 1,
                calories: item.calories || 0,
                protein: item.protein || 0,
                carbs: item.carbs || 0,
                fats: item.fats || 0
              });
              uniqueDishMap.get(dishKey).components = existingComponents;
            }
          }
        });

        ingredients = Array.from(uniqueIngMap.values());
        dishes = Array.from(uniqueDishMap.values());
      }
    } catch (e) {}

    return { ingredients, dishes };
  } catch (err) {
    console.error('Error fetching catalog:', err);
    return { ingredients: [], dishes: [] };
  }
}

export async function saveToCatalog(items) {
  if (!supabase || !items || items.length === 0) return;
  try {
    for (const item of items) {
      let savedIng = null;
      if (item.name) {
        const ingRow = {
          name: item.name.trim(),
          category: item.category || 'other',
          unit: item.unit || 'g',
          calories: item.macros?.calories || item.calories || 0,
          protein: item.macros?.protein || item.protein || 0,
          carbs: item.macros?.carbs || item.carbs || 0,
          fats: item.macros?.fats || item.fats || 0
        };
        try {
          const { data } = await supabase.from('ingredients').upsert(ingRow, { onConflict: 'name' }).select().maybeSingle();
          savedIng = data;
        } catch (e) {}
      }

      if (item.dishName && item.dishName.trim()) {
        try {
          const { data: savedDish } = await supabase.from('dishes').upsert({ name: item.dishName.trim() }, { onConflict: 'name' }).select().maybeSingle();
          
          if (savedDish && savedIng) {
            await supabase.from('dish_ingredients').upsert({
              dish_id: savedDish.id,
              ingredient_id: savedIng.id,
              quantity: item.quantity || 100,
              unit: item.unit || 'g'
            });
          }
        } catch (e) {}
      }
    }
  } catch (err) {
    console.error('Error saving to catalog:', err);
  }
}

const normalizeStr = (str) =>
  str ? str.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").trim() : "";

export async function applyCatalogMacros(items) {
  if (!items || items.length === 0) return items;
  try {
    const { ingredients = [], dishes = [] } = await fetchCatalog();
    const resultItems = [];

    for (const item of items) {
      const cleanItemName = normalizeStr(item.name);
      const cleanDishName = normalizeStr(item.dishName);

      // 1. Check if matches a Dish in DB catalog
      const matchedDish = dishes.find(d => 
        (cleanDishName && normalizeStr(d.name) === cleanDishName) || 
        (cleanItemName && normalizeStr(d.name) === cleanItemName)
      );

      if (matchedDish && matchedDish.components && matchedDish.components.length > 0) {
        const qtyMultiplier = item.quantity || 1;
        matchedDish.components.forEach(comp => {
          resultItems.push({
            dishName: matchedDish.name,
            name: comp.name,
            category: comp.category || 'other',
            unit: comp.unit || 'g',
            quantity: comp.quantity * qtyMultiplier,
            calories: Math.round(comp.calories * qtyMultiplier),
            protein: Math.round(comp.protein * qtyMultiplier * 10) / 10,
            carbs: Math.round(comp.carbs * qtyMultiplier * 10) / 10,
            fats: Math.round(comp.fats * qtyMultiplier * 10) / 10,
            isFromDb: true
          });
        });
        continue;
      }

      // 2. Check if matches an Ingredient in DB catalog
      const matchedIng = ingredients.find(ing => normalizeStr(ing.name) === cleanItemName);

      if (matchedIng) {
        const qty = item.quantity || 100;
        const unit = item.unit || matchedIng.unit || 'g';

        let factor = 1;
        if (unit === 'g' || unit === 'ml') {
          factor = qty / 100;
        } else {
          factor = qty;
        }

        resultItems.push({
          ...item,
          name: matchedIng.name,
          category: matchedIng.category || item.category || 'other',
          unit: unit,
          quantity: qty,
          calories: Math.round((matchedIng.calories || 0) * factor),
          protein: Math.round(((matchedIng.protein || 0) * factor) * 10) / 10,
          carbs: Math.round(((matchedIng.carbs || 0) * factor) * 10) / 10,
          fats: Math.round(((matchedIng.fats || 0) * factor) * 10) / 10,
          isFromDb: true
        });
        continue;
      }

      // 3. Fallback: Not in DB catalog, keep AI generated macros
      resultItems.push(item);
    }

    return resultItems;
  } catch (err) {
    console.error('Error applying catalog macros:', err);
    return items;
  }
}

// ── REALTIME SUBSCRIPTION HELPERS FOR FIT MODULE ──
export function subscribeToIntakes(onChange) {
  if (!supabase) return () => {};

  const channel = supabase
    .channel('fit_intakes_live')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'intakes',
      },
      (payload) => {
        if (onChange) onChange(payload);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}

export function subscribeToDailyLogs(onChange) {
  if (!supabase) return () => {};

  const channel = supabase
    .channel('fit_daily_logs_live')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'daily_logs',
      },
      (payload) => {
        if (onChange) onChange(payload);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}

export function subscribeToWeightLogs(onChange) {
  if (!supabase) return () => {};

  const channel = supabase
    .channel('fit_weight_logs_live')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'weight_logs',
      },
      (payload) => {
        if (onChange) onChange(payload);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}

export async function saveDailyStepsToSupabase(dateStr, steps, profileId) {
  if (!supabase || !profileId || !dateStr) return null;
  try {
    const s = Math.max(0, parseInt(steps, 10) || 0);
    const { data, error } = await supabase
      .from('daily_logs')
      .upsert(
        {
          profile_id: profileId,
          date: dateStr,
          steps: s,
        },
        { onConflict: 'profile_id,date' }
      )
      .select()
      .maybeSingle();

    if (error) {
      console.warn('Note on Supabase daily_logs steps sync:', error.message);
    }
    return data;
  } catch (err) {
    console.warn('Error saving daily steps to Supabase:', err);
    return null;
  }
}

export async function logAppErrorToSupabase(level = 'error', source = 'app', message = '', context = {}) {
  if (!supabase) return;
  try {
    const payload = {
      level,
      source,
      message: String(message),
      context: typeof context === 'object' && context !== null ? context : { value: String(context) },
      user_agent: typeof navigator !== 'undefined' ? navigator.userAgent : null,
      created_at: new Date().toISOString(),
    };

    await supabase.from('app_logs').insert(payload);
  } catch (err) {
    console.warn('Remote logging to app_logs error:', err);
  }
}



