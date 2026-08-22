/**
 * Calcula la Tasa Metabólica Basal (TMB / BMR) usando la fórmula de Mifflin-St Jeor
 */
export function calculateBMR(weight, height, age, gender = 'male') {
  const w = parseFloat(weight) || 70;
  const h = parseFloat(height) || 175;
  const a = parseInt(age, 10) || 28;
  let tmb = 10 * w + 6.25 * h - 5 * a;
  return gender === 'female' ? tmb - 161 : tmb + 5;
}

/**
 * Calcula el TDEE de mantenimiento teórico según nivel de actividad
 */
export function calculateMaintenanceTDEE(profile = {}) {
  const { weight = 70, height = 175, age = 28, gender = 'male', activity_level = 'moderate' } = profile;
  const bmr = calculateBMR(weight, height, age, gender);
  const activityMultipliers = {
    sedentary: 1.2,
    light: 1.375,
    moderate: 1.55,
    active: 1.725,
    very_active: 1.9,
  };
  const multiplier = activityMultipliers[activity_level] || 1.45;
  return Math.round(bmr * multiplier);
}

/**
 * Calcula el Gasto Energético Diario Total Adaptativo (Adaptive TDEE / MacroFactor-Style)
 *
 * Ecuación de Balance Energético Real:
 * Gasto Real = Calorías Consumidas - (Δ Peso [kg] * 7700 kcal/kg / Días)
 *
 * Ejemplo: Si comes 1800 kcal/día y pierdes 0.5 kg en 7 días (-0.5 kg):
 * Déficit quemado de grasa = -(-0.5 * 7700 / 7) = +550 kcal/día.
 * Gasto Real (TDEE) = 1800 + 550 = 2350 kcal/día.
 */
export function calculateAdaptiveTDEE({
  userProfile = {},
  dailyLogs = [],
  weightHistory = [],
}) {
  const {
    weight = 70,
    height = 175,
    age = 28,
    gender = 'male',
    activity_level = 'moderate',
    maintenanceCalories: currentMaint,
  } = userProfile || {};

  const bmr = calculateBMR(weight, height, age, gender);
  const baselineTDEE = calculateMaintenanceTDEE({ weight, height, age, gender, activity_level });
  const activeMaintenance = currentMaint && currentMaint >= 1400 ? currentMaint : baselineTDEE;

  if (!weightHistory || weightHistory.length === 0) {
    return {
      adaptiveTDEE: activeMaintenance,
      isReliable: false,
      weeklyLossRateKg: 0,
      movingAverage7d: weight,
      diffTdee: 0,
      baselineTDEE,
    };
  }

  // Ordenar historial cronológicamente
  const sortedWeights = [...weightHistory].sort((a, b) =>
    `${a.date} ${a.time || ''}`.localeCompare(`${b.date} ${b.time || ''}`)
  );

  // Media móvil de los últimos 7 pesajes
  const recent7 = sortedWeights.slice(-7);
  const ma7 = recent7.reduce((acc, curr) => acc + curr.weight, 0) / recent7.length;

  // Media móvil de la semana anterior (ventana de 7 a 14 pesajes atrás)
  const prev7 = sortedWeights.length > 7 ? sortedWeights.slice(-14, -7) : [];
  const prevMa7 =
    prev7.length > 0
      ? prev7.reduce((acc, curr) => acc + curr.weight, 0) / prev7.length
      : sortedWeights[0].weight;

  const weeklyLossRateKg = Math.round((ma7 - prevMa7) * 100) / 100;

  // Si no hay suficientes días de datos o historial temporal corto
  const firstDate = new Date(sortedWeights[0].date);
  const lastDate = new Date(sortedWeights[sortedWeights.length - 1].date);
  const daysSpan = Math.max(1, Math.round((lastDate - firstDate) / (1000 * 60 * 60 * 24)));

  if (daysSpan < 5 || !dailyLogs || dailyLogs.length < 3) {
    return {
      adaptiveTDEE: activeMaintenance,
      isReliable: false,
      weeklyLossRateKg,
      movingAverage7d: Math.round(ma7 * 10) / 10,
      diffTdee: 0,
      baselineTDEE,
    };
  }

  // Calorías medias diarias consumidas
  const recentLogs = dailyLogs.slice(-14);
  const totalLoggedCalories = recentLogs.reduce(
    (acc, log) => acc + (log.dailyTotals?.calories || 0),
    0
  );
  const avgDailyCalories = totalLoggedCalories / Math.max(1, recentLogs.length);

  // Δ Peso total en kg (Negativo = pérdida, Positivo = ganancia)
  const totalWeightDeltaKg = sortedWeights[sortedWeights.length - 1].weight - sortedWeights[0].weight;

  // Déficit diario quemado de grasa (Signo corregido: perder peso suma gasto)
  // Usamos 7700 kcal/kg pero suavizamos si el ritmo es mayor a 1kg/semana (por agua/glucógeno)
  const effectiveKcalPerKg = Math.abs(weeklyLossRateKg) > 1.2 ? 6000 : 7700;
  const dailyDeficitBurnedKcal = (-1 * totalWeightDeltaKg * effectiveKcalPerKg) / daysSpan;

  // TDEE empírico crudo
  const rawEmpiricalTdee = avgDailyCalories + dailyDeficitBurnedKcal;

  // Convergencia bayesiana / Damping con la línea base para evitar saltos bruscos
  const confidence = Math.min(0.75, Math.max(0.25, daysSpan / 21));
  const blendedTdee = Math.round(confidence * rawEmpiricalTdee + (1 - confidence) * baselineTDEE);

  // Límites fisiológicos seguros (1.15 * BMR a 2.2 * BMR)
  const minSafeTdee = Math.round(bmr * 1.15);
  const maxSafeTdee = Math.round(bmr * 2.2);
  const boundedTdee = Math.max(minSafeTdee, Math.min(maxSafeTdee, blendedTdee));

  return {
    adaptiveTDEE: boundedTdee,
    isReliable: daysSpan >= 7 && dailyLogs.length >= 5,
    weeklyLossRateKg,
    movingAverage7d: Math.round(ma7 * 10) / 10,
    diffTdee: boundedTdee - activeMaintenance,
    baselineTDEE,
  };
}

/**
 * Calcula el TDEE y Macros objetivo basado en el perfil
 */
export function calculateProfileTargets(profile) {
  const { weight, height, age, gender, activity_level, goal, pace = 'moderate' } = profile;

  if (!weight || !height || !age || !gender) {
    return { calories: 2000, protein: 150, carbs: 200, fats: 60 };
  }

  const maintenanceCalories = calculateMaintenanceTDEE(profile);

  let offset = 0;
  if (goal === 'lose') {
    if (pace === 'relaxed') offset = -300;
    else if (pace === 'aggressive') offset = -750;
    else offset = -500;
  } else if (goal === 'gain') {
    if (pace === 'relaxed') offset = 200;
    else if (pace === 'aggressive') offset = 500;
    else offset = 350;
  }

  let targetCalories = maintenanceCalories + offset;

  // Límite de seguridad mínimo
  if (gender === 'male' && targetCalories < 1500) targetCalories = 1500;
  if (gender === 'female' && targetCalories < 1200) targetCalories = 1200;

  const protein = Math.round(weight * 2.2);
  const proteinCalories = protein * 4;

  const fatsCalories = targetCalories * 0.25;
  const fats = Math.round(fatsCalories / 9);

  const carbsCalories = targetCalories - proteinCalories - fatsCalories;
  const carbs = Math.round(Math.max(0, carbsCalories / 4));

  return {
    calories: Math.round(targetCalories),
    protein,
    carbs,
    fats,
  };
}
