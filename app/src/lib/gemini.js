import { GoogleGenerativeAI } from '@google/generative-ai';
import { foodCache } from './food-cache';
import { raceFoodModels } from './gemini-fast';
import { parseFoodTextLocal } from './parser';

export function getGeminiApiKey() {
  const envKey = import.meta.env.VITE_GEMINI_API_KEY;
  if (envKey && typeof envKey === 'string' && envKey.trim() && !envKey.includes('undefined')) {
    return envKey.trim();
  }
  try {
    const localKey = localStorage.getItem('glowup_gemini_api_key');
    if (localKey && typeof localKey === 'string' && localKey.trim()) {
      return localKey.trim();
    }
  } catch (e) {}
  return '';
}

export function setGeminiApiKey(keyStr) {
  try {
    if (keyStr && typeof keyStr === 'string' && keyStr.trim()) {
      localStorage.setItem('glowup_gemini_api_key', keyStr.trim());
    } else {
      localStorage.removeItem('glowup_gemini_api_key');
    }
  } catch (e) {}
}

/**
 * Compact nutritionist prompt — reduced from ~110 lines to ~45 lines.
 * Maintains accuracy for cooked/raw state, fractions, batch recipes, and micronutrients.
 */
function buildCompactPrompt(userText) {
  return `You are a precision nutritionist. Extract ALL consumed foods from user input into a strict JSON array.

RULES:
1. "name": Clean English singular name (e.g. "Banana", "Cooked Rice", "Chicken Breast").
2. Fractions: "medio/media/half"→0.5, "cuarto"→0.25. Scale macros by fraction quantity.
3. COOKED vs RAW (CRITICAL): "arroz/rice" without "crudo/raw/seco/dry" = COOKED (~130 kcal/100g, 2.7P, 28C, 0.3F). RAW rice = ~360 kcal/100g. Same for pasta: cooked ~131 kcal, raw ~355 kcal.
4. Batch recipe: If user lists ingredients + "me como Yg", calculate portion factor Y/TotalWeight and scale each ingredient proportionally. Set same "dishName" for all.
5. "unit": "ud"|"g"|"ml"|"portion". "category": "meat"|"legumes"|"vegetables"|"tubers"|"fruit"|"bakery"|"fast_food"|"dairy"|"grains"|"healthy_fats"|"beverages"|"other".
6. Include "fiber" (g), "sugar" (g), "sodium" (mg) estimates.
7. Low-cal items: Ice pop/polo ≈50 kcal total, half ≈25 kcal. NO arbitrary 100+ defaults.

EXAMPLES:
Input: "100g arroz cocido" → [{"name":"Cooked Rice","quantity":100,"unit":"g","category":"grains","calories":130,"protein":2.7,"carbs":28.0,"fats":0.3,"fiber":0.4,"sugar":0.1,"sodium":1}]
Input: "medio ice pop" → [{"name":"Ice Pop","quantity":0.5,"unit":"ud","category":"other","calories":25,"protein":0,"carbs":6,"fats":0,"fiber":0,"sugar":5.5,"sodium":10}]

User Input: "${userText}"
Return EXCLUSIVELY the strict JSON array:`;
}

export async function parseFoodWithGemini(userText) {
  // ── Layer 1: LRU Cache Hit (~0ms) ──
  const cached = foodCache.get(userText);
  if (cached) {
    return cached;
  }

  const apiKey = getGeminiApiKey();

  if (!apiKey) {
    // ── Layer 3: Offline Fallback ──
    const offlineResult = parseFoodTextLocal(userText);
    if (offlineResult && offlineResult.length > 0) {
      return offlineResult;
    }
    throw new Error('Gemini API Key is missing. Please set VITE_GEMINI_API_KEY or save your API Key in Profile Settings.');
  }

  const genAI = new GoogleGenerativeAI(apiKey);
  const prompt = buildCompactPrompt(userText);

  // ── Layer 2: Parallel Gemini Race (~300-600ms) ──
  // Fire 2 models in parallel, return the fastest valid response
  const modelCalls = [
    () => callGeminiModel(genAI, 'gemini-3.5-flash', prompt),
    () => callGeminiModel(genAI, 'gemini-flash-lite-latest', prompt),
  ];

  try {
    const result = await raceFoodModels(modelCalls);
    // Cache the successful result
    foodCache.set(userText, result);
    return result;
  } catch (raceError) {
    // All parallel models failed — check for auth errors
    const errors = raceError.errors || [raceError];
    const authError = errors.find((e) =>
      e.message?.includes('401') ||
      e.message?.includes('invalid authentication') ||
      e.message?.includes('ACCESS_TOKEN_TYPE_UNSUPPORTED')
    );

    if (authError) {
      throw new Error('Gemini API Key is invalid or unauthorized (401). Please update your Gemini API Key in Profile Settings.');
    }

    // ── Layer 3: Offline Fallback ──
    const offlineResult = parseFoodTextLocal(userText);
    if (offlineResult && offlineResult.length > 0) {
      return offlineResult;
    }

    throw new Error(raceError?.message || 'Gemini AI failed to process the request.');
  }
}

/**
 * Call a single Gemini model and parse its JSON response.
 * No thinkingConfig (avoids 400 Bad Request on standard endpoints).
 */
async function callGeminiModel(genAI, modelName, prompt) {
  const model = genAI.getGenerativeModel({
    model: modelName,
    generationConfig: {
      responseMimeType: 'application/json',
      temperature: 0.1,
    },
  });

  const result = await model.generateContent(prompt);
  const responseText = result.response.text();
  const cleanJsonStr = responseText
    .replace(/```json/gi, '')
    .replace(/```/g, '')
    .trim();
  const parsed = JSON.parse(cleanJsonStr);

  if (!Array.isArray(parsed) || parsed.length === 0) {
    throw new Error(`Model ${modelName} returned empty result`);
  }

  return parsed;
}
