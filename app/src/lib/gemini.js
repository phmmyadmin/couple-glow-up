import { GoogleGenerativeAI } from '@google/generative-ai';

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

export async function parseFoodWithGemini(userText) {
  const apiKey = getGeminiApiKey();

  if (!apiKey) {
    throw new Error('Gemini API Key is missing. Please set VITE_GEMINI_API_KEY or save your API Key in Profile Settings.');
  }

  const genAI = new GoogleGenerativeAI(apiKey);

  const candidateConfigs = [
    {
      model: 'gemini-3.5-flash',
      generationConfig: {
        responseMimeType: 'application/json',
        temperature: 0.1,
        thinkingConfig: { thinkingBudget: 0 }
      }
    },
    {
      model: 'gemini-3.5-flash',
      generationConfig: {
        responseMimeType: 'application/json',
        temperature: 0.1
      }
    },
    {
      model: 'gemini-flash-lite-latest',
      generationConfig: {
        responseMimeType: 'application/json',
        temperature: 0.1
      }
    },
    {
      model: 'gemini-flash-latest',
      generationConfig: {
        responseMimeType: 'application/json',
        temperature: 0.1
      }
    },
    {
      model: 'gemini-3.6-flash',
      generationConfig: {
        responseMimeType: 'application/json',
        temperature: 0.1
      }
    }
  ];

  let lastError = null;

  for (const cfg of candidateConfigs) {
    try {
      const model = genAI.getGenerativeModel({
        model: cfg.model,
        generationConfig: cfg.generationConfig
      });

      const prompt = `
You are a precision nutritionist AI expert in calorie and macronutrient tracking.
Your SOLE task is to analyze the user's input text and extract all consumed foods into a strict JSON array.

GOLDEN RULES OF PARSING AND UNDERSTANDING:

1. "name": Standard, clean, un-nested food name ALWAYS IN SINGULAR and IN ENGLISH (e.g., "Banana", "Egg", "Tofu", "Oatmeal", "Carrot", "Chicken breast", "Milk", "Avocado", "Potato", "Apple", "Ice Pop").

2. FRACTIONAL & WORD-BASED PORTIONS ("medio", "media", "mitad", "1/2", "0.5", "cuarto"):
   - Understand fraction words in both Spanish and English:
     - "medio", "media", "mitad", "half", "0.5", "1/2" -> Set "quantity": 0.5.
     - "cuarto", "un cuarto", "0.25", "1/4" -> Set "quantity": 0.25.
     - "tres cuartos", "0.75", "3/4" -> Set "quantity": 0.75.
     - "tercio", "un tercio", "0.33", "1/3" -> Set "quantity": 0.33.
   - Clean the food name:
     - "medio ice pop" -> "Ice Pop" (quantity: 0.5)
     - "media manzana" -> "Apple" (quantity: 0.5)
     - "medio polo de limon" -> "Lemon Ice Pop" (quantity: 0.5)
   - CRITICAL: Calculate macros ACCURATELY for that specific food item and MULTIPLY BY THE FRACTIONAL QUANTITY!
     - 1 full Ice Pop / Polo de hielo (~60g) = ~50 kcal, 0g P, 12g C, 0g F.
     - Half an Ice Pop ("medio ice pop", quantity: 0.5) MUST BE: ~25 kcal, 0g P, 6g C, 0g F.
     - NEVER output 100+ kcal default values for half an ice pop or small treats!

3. NO GENERIC OR ARBITRARY DEFAULT VALUES:
   - Always base macronutrient calculations on the SPECIFIC real-world food item identified.
   - Low-calorie treats (e.g. Ice pop / Polo / Popsicle = ~45-60 kcal total per unit) must have accurate low calories (e.g. ~25 kcal for half an ice pop).

4. RECIPE & BATCH MEAL-PREP PORTION CALCULATIONS:
   - When the user lists raw ingredient weights for a recipe (e.g. 550g tofu, 240g oatmeal, 80g carrot) and specifies the eaten portion (Y, e.g. "me como 110g"):
     a) Total Batch Recipe Weight (X) = Sum of all raw ingredient weights (550 + 240 + 80 = 870g total recipe weight!).
     b) Eaten Portion Weight (Y) = 110g.
     c) Portion Factor = Y / X = 110 / 870 = 0.126437 (12.64% of the batch recipe).
     d) Multiply EACH ingredient's raw weight by the portion factor (0.126437):
        - Tofu eaten: 550g * 0.126437 = 69.5g (approx 70g)
        - Oatmeal eaten: 240g * 0.126437 = 30.3g (approx 30g)
        - Carrot eaten: 80g * 0.126437 = 10.2g (approx 10g)
     e) CRITICAL: THE SUM OF EATEN INGREDIENT GRAMS (69.5g + 30.3g + 10.2g = 110g) MUST SUM UP TO EXACTLY THE EATEN PORTION WEIGHT (110g)!
     f) ALWAYS PRESERVE INGREDIENT PROPORTIONS!
     g) Assign the same descriptive "dishName" in English to all ingredients (e.g., "Tofu, Oatmeal & Carrot Dish (110g of 870g)").

5. COOKED VS RAW STATE NUTRITION VALUES (CRITICAL!):
   - When the user logs cooked/boiled/steamed items (e.g. "arroz cocido", "arroz hervido", "arroz", "cooked rice", "boiled rice", "pasta cocida", "cooked pasta"):
     a) 100g of COOKED / BOILED White Rice ("Cooked Rice" / "Arroz cocido") = EXACTLY ~130 kcal per 100g (2.7g Protein, 28g Carbs, 0.3g Fat). NEVER use 360-370 kcal for cooked rice!
     b) Unless the user explicitly types "crudo", "seco", "raw", or "dry", ALWAYS treat rice logged in grams for a daily food log as COOKED RICE (~130 kcal / 100g).
     c) 100g of RAW / DRY Rice ("Raw Rice") = ~360 kcal.

6. "unit": 'ud' (for pieces/units), 'g' (for grams), 'ml' (for milliliters), or 'portion'.

7. "category": Choose an exact option in English snake_case:
   - "meat" (meats, poultry, fish, seafood, eggs)
   - "legumes" (lentils, chickpeas, beans, soy, tofu, tempeh, edamame)
   - "vegetables" (vegetables, carrots, salads)
   - "tubers" (potatoes, sweet potatoes, cassava)
   - "fruit" (fresh and dried fruits)
   - "bakery" (bread, pastries, cookies)
   - "fast_food" (processed foods, pizzas, burgers)
   - "dairy" (milk, yogurts, cheeses)
   - "grains" (rice, pasta, oatmeal, cereals)
   - "healthy_fats" (oils, nuts, avocado)
   - "beverages" (drinks, juices, coffee)
   - "other" (sauces, ice pops, sweets, others)

8. "fiber": Estimated dietary fiber in grams (e.g. 2.5 for an apple, 3.0 for oatmeal, 0.0 for meat/oils).
9. "sugar": Estimated total sugars in grams (e.g. 19.0 for an apple, 12.0 for ice pop, 0.0 for chicken/oil).
10. "sodium": Estimated sodium in milligrams (e.g. 70 for an egg, 450 for salted chicken/curry/bread, 1 for an apple).

EXAMPLES:

   Input: "100g arroz cocido"
   Required JSON Output (cooked rice ~130 kcal per 100g, NOT 360-370 kcal!):
   [
     {
       "name": "Cooked Rice",
       "quantity": 100,
       "unit": "g",
       "category": "grains",
       "calories": 130,
       "protein": 2.7,
       "carbs": 28.0,
       "fats": 0.3,
       "fiber": 0.4,
       "sugar": 0.1,
       "sodium": 1
     }
   ]

   Input: "medio ice pop"
   Required JSON Output (clean name, quantity 0.5, accurate half-item macros ~25 kcal):
   [
     {
       "name": "Ice Pop",
       "quantity": 0.5,
       "unit": "ud",
       "category": "other",
       "calories": 25,
       "protein": 0.0,
       "carbs": 6.0,
       "fats": 0.0,
       "fiber": 0.0,
       "sugar": 5.5,
       "sodium": 10
     }
   ]

User Input: "${userText}"

Return EXCLUSIVELY the strict JSON array:`;

      const result = await model.generateContent(prompt);
      const responseText = result.response.text();
      const cleanJsonStr = responseText
        .replace(/```json/gi, '')
        .replace(/```/g, '')
        .trim();
      const parsed = JSON.parse(cleanJsonStr);
      if (Array.isArray(parsed) && parsed.length > 0) {
        return parsed;
      }
    } catch (err) {
      console.warn(`Gemini model ${cfg.model} failed:`, err);
      lastError = err;
    }
  }

  if (lastError && (lastError.message?.includes('401') || lastError.message?.includes('invalid authentication') || lastError.message?.includes('ACCESS_TOKEN_TYPE_UNSUPPORTED'))) {
    throw new Error('Gemini API Key is invalid or unauthorized (401). Please update your Gemini API Key in Profile Settings.');
  }

  throw new Error(lastError?.message || 'Gemini AI failed to process the request.');
}
