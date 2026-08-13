/**
 * Generic client-side parser fallback when Gemini LLM is unavailable or fails.
 * Strips command prefixes and parses multiple food items separated by commas, newlines, +, "y", "e".
 */
export function parseFoodTextLocal(text) {
  let cleaned = text
    .replace(/^(?:añade|agrega|registra|hoy he comido|comí|comi|desayuné|desayune|cené|cene)\s+/i, '')
    .replace(/^(?:Comida|Desayuno|Cena|Snack|Merienda)\s*\d*:\s*/i, '')
    .trim();

  // Split by commas, semicolons, newlines, +, " y ", " e "
  const rawSegments = cleaned.split(/[,;\n\+]|\s+(?:y|e)\s+/i).map(s => s.trim()).filter(Boolean);
  let matches = [];

  for (const seg of rawSegments) {
    let lower = seg.toLowerCase().trim();
    if (!lower) continue;

    let quantity = 1;
    let unit = 'ud';
    let cleanName = seg;

    // Check grams pattern: "100g pollo" or "pollo 100g" or "100 gramos de yogurt"
    const gramsMatch = lower.match(/^(\d+(?:\.\d+)?)\s*g(?:ramos)?\s+(?:de\s+)?(.+)$/i) ||
                       lower.match(/^(.+?)\s+(\d+(?:\.\d+)?)\s*g(?:ramos)?$/i);

    // Check unit pattern: "2 plátanos" or "plátano 2" or "1 platano"
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

    cleanName = cleanName.replace(/^(?:de\s+)/i, '').trim();
    cleanName = cleanName.charAt(0).toUpperCase() + cleanName.slice(1);

    // Category guessing
    let category = 'other';
    const lowerName = cleanName.toLowerCase();
    if (/pollo|carne|pavo|ternera|cerdo|pescado|atun|atún|salmon|salmón|huevo|huevos/.test(lowerName)) {
      category = 'meat';
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

    // Generic estimation based on unit type and quantity
    const baseCalsPerUnit = unit === 'g' ? 1.2 : 110;
    const estimatedCals = Math.round(quantity * baseCalsPerUnit);

    matches.push({
      name: cleanName || seg,
      quantity: quantity,
      unit: unit,
      category: category,
      calories: estimatedCals,
      protein: Math.round((estimatedCals * 0.25 / 4) * 10) / 10,
      carbs: Math.round((estimatedCals * 0.45 / 4) * 10) / 10,
      fats: Math.round((estimatedCals * 0.30 / 9) * 10) / 10
    });
  }

  return matches;
}
