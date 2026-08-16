/**
 * Generic client-side parser fallback when Gemini LLM is unavailable or fails.
 * Strips command prefixes and parses multiple food items separated by commas, newlines, +, "y", "e".
 * Supports batch cooking & portion fraction calculations (e.g., "plato de 550g de tofu, 240g avena... me como 110g", "medio ice pop").
 */

const KNOWN_UNIT_ITEMS = [
  { keys: ['ice pop', 'polo', 'helado de hielo', 'popsicle', 'flash', 'polo de limon', 'polo de fresa', 'polo de naranja', 'helado de polo'], cals: 50, prot: 0, carbs: 12, fats: 0, cat: 'other' },
  { keys: ['huevo', 'egg', 'huevos'], cals: 70, prot: 6.3, carbs: 0.5, fats: 5, cat: 'meat' },
  { keys: ['manzana', 'apple'], cals: 80, prot: 0.4, carbs: 21, fats: 0.2, cat: 'fruit' },
  { keys: ['platano', 'plátano', 'banana'], cals: 105, prot: 1.3, carbs: 27, fats: 0.3, cat: 'fruit' },
  { keys: ['naranja', 'orange'], cals: 62, prot: 1.2, carbs: 15, fats: 0.2, cat: 'fruit' },
  { keys: ['tostada', 'toast', 'rebanada de pan', 'slice of bread'], cals: 75, prot: 2.5, carbs: 14, fats: 1, cat: 'grains' },
  { keys: ['galleta', 'cookie'], cals: 50, prot: 0.7, carbs: 7, fats: 2, cat: 'bakery' },
  { keys: ['yogur', 'yogurt'], cals: 80, prot: 4, carbs: 10, fats: 2.5, cat: 'dairy' },
  { keys: ['lata de atun', 'atun en lata', 'can of tuna'], cals: 120, prot: 26, carbs: 0, fats: 1.5, cat: 'meat' },
];

export function parseFoodTextLocal(text) {
  let rawText = text
    .replace(/^(?:añade|agrega|registra|hoy he comido|comí|comi|desayuné|desayune|cené|cene)\s+/i, '')
    .replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '')
    .trim();

  // 1. Detect total dish weight (X g) and eaten portion weight (Y g)
  let portionRatio = 1;
  let batchDishName = null;

  const totalWeightMatch = rawText.match(/(?:plato|receta|bowl|guiso|preparacion|preparación)?\s*(?:de\s+)?(\d+(?:\.\d+)?)\s*g(?:ramos|r)?/i);
  const eatenMatch = rawText.match(/\bme\s+(?:como|comí|comi|serví|servi)\s+(\d+(?:\.\d+)?)\s*g(?:ramos|r)?/i);

  if (totalWeightMatch && eatenMatch) {
    const totalBatchWeight = parseFloat(totalWeightMatch[1]);
    const eatenWeight = parseFloat(eatenMatch[1]);

    if (totalBatchWeight > 0 && eatenWeight > 0 && eatenWeight < totalBatchWeight * 3) {
      portionRatio = eatenWeight / totalBatchWeight;
      batchDishName = `Plato Preparado (Porción ${eatenWeight}g de ${totalBatchWeight}g)`;
    }
  }

  // 2. Clean text to extract actual ingredients
  let cleaned = rawText
    .replace(/^(?:un\s+)?(?:plato|receta|bowl|guiso|preparacion|preparación)\s+(?:de\s+)?/i, '')
    .replace(/\bme\s+(?:como|comí|comi|serví|servi)\s+\d+\s*g(?:ramos|r)?/gi, '')
    .trim();

  // Split ingredients by period, comma, semicolon, newline, "+", "y", "e"
  const rawSegments = cleaned
    .split(/[\.,;\n\+]|\s+(?:y|e)\s+/i)
    .map((s) => s.trim())
    .filter(Boolean);

  let matches = [];

  for (const seg of rawSegments) {
    let lower = seg.toLowerCase().trim();
    if (!lower || /^me\s+(?:como|comí|comi|serví|servi)/i.test(lower)) continue;

    let quantity = 1;
    let unit = 'ud';
    let cleanName = seg;

    // Detect fraction words or symbols ("medio", "media", "1/2", "0.5", "cuarto")
    let isFractionDetected = false;

    if (/^(?:medio|media|mitad\s+de|mitad|half\s+a|half)\s+(.+)$/i.test(lower)) {
      const match = lower.match(/^(?:medio|media|mitad\s+de|mitad|half\s+a|half)\s+(.+)$/i);
      quantity = 0.5;
      cleanName = match[1];
      isFractionDetected = true;
    } else if (/^(?:1\/2|0\.5)\s+(?:de\s+)?(.+)$/i.test(lower)) {
      const match = lower.match(/^(?:1\/2|0\.5)\s+(?:de\s+)?(.+)$/i);
      quantity = 0.5;
      cleanName = match[1];
      isFractionDetected = true;
    } else if (/^(?:cuarto|un\s+cuarto|1\/4|0\.25)\s+(?:de\s+)?(.+)$/i.test(lower)) {
      const match = lower.match(/^(?:cuarto|un\s+cuarto|1\/4|0\.25)\s+(?:de\s+)?(.+)$/i);
      quantity = 0.25;
      cleanName = match[1];
      isFractionDetected = true;
    } else if (/^(?:tres\s+cuartos|3\/4|0\.75)\s+(?:de\s+)?(.+)$/i.test(lower)) {
      const match = lower.match(/^(?:tres\s+cuartos|3\/4|0\.75)\s+(?:de\s+)?(.+)$/i);
      quantity = 0.75;
      cleanName = match[1];
      isFractionDetected = true;
    }

    if (!isFractionDetected) {
      // Grams match: "550g tofu" or "tofu 550g" or "240 gramos de avena"
      const gramsMatch = lower.match(/^(\d+(?:\.\d+)?)\s*g(?:ramos|r)?\s+(?:de\s+)?(.+)$/i) ||
                         lower.match(/^(.+?)\s+(\d+(?:\.\d+)?)\s*g(?:ramos|r)?$/i);

      // Qty match: "2 plátanos" or "plátano 2"
      const qtyMatch = lower.match(/^(\d+(?:\.\d+)?)\s+(?:de\s+)?(.+)$/i) ||
                       lower.match(/^(.+?)\s+(\d+(?:\.\d+)?)$/i);

      if (gramsMatch) {
        if (!isNaN(gramsMatch[1])) {
          quantity = parseFloat(gramsMatch[1]);
          cleanName = gramsMatch[2];
        } else {
          quantity = parseFloat(gramsMatch[2]);
          cleanName = gramsMatch[1];
        }
        unit = 'g';
      } else if (qtyMatch) {
        if (!isNaN(qtyMatch[1])) {
          quantity = parseFloat(qtyMatch[1]);
          cleanName = qtyMatch[2];
        } else {
          quantity = parseFloat(qtyMatch[2]);
          cleanName = qtyMatch[1];
        }
        unit = 'ud';
      }
    }

    cleanName = cleanName.replace(/^(?:de\s+)/i, '').trim();
    if (!cleanName) continue;
    cleanName = cleanName.charAt(0).toUpperCase() + cleanName.slice(1);

    // Category guessing
    let category = 'other';
    const lowerName = cleanName.toLowerCase();
    if (/tofu|seitan|seitán|tempeh|pollo|carne|pavo|ternera|cerdo|pescado|atun|atún|salmon|salmón|huevo|huevos/.test(lowerName)) {
      category = lowerName.includes('tofu') || lowerName.includes('seitan') || lowerName.includes('tempeh') ? 'legumes' : 'meat';
    } else if (/yogur|yogurt|leche|queso|kefir|kéfir/.test(lowerName)) {
      category = 'dairy';
    } else if (/platano|plátano|banana|manzana|naranja|fresa|pera|uva|fruta/.test(lowerName)) {
      category = 'fruit';
    } else if (/arroz|pan|avena|pasta|macarrones|espaguetis/.test(lowerName)) {
      category = 'grains';
    } else if (/patata|patatas|boniato|yuca/.test(lowerName)) {
      category = 'tubers';
    } else if (/ensalada|lechuga|tomate|espinacas|brócoli|brocoli|zanahoria|verdura/.test(lowerName)) {
      category = 'vegetables';
    }

    const finalQty = unit === 'g' ? Math.round(quantity * portionRatio * 10) / 10 : quantity;

    // Macro estimation per 100g based on category
    let calsPer100g = 120;
    let protPer100g = 5;
    let carbsPer100g = 15;
    let fatsPer100g = 3;

    if (category === 'legumes' || lowerName.includes('tofu')) {
      calsPer100g = 80; protPer100g = 8; carbsPer100g = 2; fatsPer100g = 4.5;
    } else if (category === 'grains' || lowerName.includes('avena')) {
      calsPer100g = 370; protPer100g = 13.5; carbsPer100g = 60; fatsPer100g = 6.5;
    } else if (category === 'vegetables' || lowerName.includes('zanahoria')) {
      calsPer100g = 40; protPer100g = 1; carbsPer100g = 9; fatsPer100g = 0.2;
    } else if (category === 'meat') {
      calsPer100g = 160; protPer100g = 22; carbsPer100g = 0; fatsPer100g = 7;
    }

    let estimatedCals = 0;
    let estimatedProt = 0;
    let estimatedCarbs = 0;
    let estimatedFats = 0;

    const knownItem = KNOWN_UNIT_ITEMS.find((k) =>
      k.keys.some((key) => lowerName.includes(key))
    );

    if (unit === 'g') {
      const factor = finalQty / 100;
      estimatedCals = Math.round(calsPer100g * factor);
      estimatedProt = Math.round(protPer100g * factor * 10) / 10;
      estimatedCarbs = Math.round(carbsPer100g * factor * 10) / 10;
      estimatedFats = Math.round(fatsPer100g * factor * 10) / 10;
    } else if (knownItem) {
      estimatedCals = Math.round(knownItem.cals * quantity);
      estimatedProt = Math.round(knownItem.prot * quantity * 10) / 10;
      estimatedCarbs = Math.round(knownItem.carbs * quantity * 10) / 10;
      estimatedFats = Math.round(knownItem.fats * quantity * 10) / 10;
      if (category === 'other' && knownItem.cat) category = knownItem.cat;
    } else {
      // Sensible category-based unit defaults (NOT hardcoded 110 cals with high protein!)
      let baseUnitCals = 65;
      let baseProt = 1.5;
      let baseCarbs = 10;
      let baseFats = 1.5;

      if (category === 'fruit') {
        baseUnitCals = 75; baseProt = 0.8; baseCarbs = 18; baseFats = 0.2;
      } else if (category === 'meat') {
        baseUnitCals = 140; baseProt = 18; baseCarbs = 0; baseFats = 7;
      } else if (category === 'bakery' || category === 'grains') {
        baseUnitCals = 90; baseProt = 2.5; baseCarbs = 16; baseFats = 1.5;
      } else if (category === 'dairy') {
        baseUnitCals = 80; baseProt = 4; baseCarbs = 9; baseFats = 2.5;
      }

      estimatedCals = Math.round(quantity * baseUnitCals);
      estimatedProt = Math.round(quantity * baseProt * 10) / 10;
      estimatedCarbs = Math.round(quantity * baseCarbs * 10) / 10;
      estimatedFats = Math.round(quantity * baseFats * 10) / 10;
    }

    matches.push({
      name: cleanName || seg,
      dishName: batchDishName,
      quantity: finalQty,
      unit: unit,
      category: category,
      calories: estimatedCals,
      protein: estimatedProt,
      carbs: estimatedCarbs,
      fats: estimatedFats,
    });
  }

  return matches;
}
