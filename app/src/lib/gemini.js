import { GoogleGenerativeAI } from '@google/generative-ai';

const apiKey = import.meta.env.VITE_GEMINI_API_KEY;
const genAI = apiKey && typeof apiKey === 'string' && apiKey.trim() ? new GoogleGenerativeAI(apiKey.trim()) : null;

export async function parseFoodWithGemini(userText) {
  if (!genAI || !apiKey) {
    return null;
  }

  const modelsToTry = [
    'gemini-flash-latest',
    'gemini-flash-lite-latest',
    'gemini-2.5-flash',
    'gemini-pro-latest'
  ];

  for (const modelName of modelsToTry) {
    try {
      const model = genAI.getGenerativeModel({
        model: modelName,
        generationConfig: { responseMimeType: 'application/json' }
      });

      const prompt = `
You are a precision nutritionist AI expert in calorie and macronutrient tracking.
Your SOLE task is to analyze the user's input text and extract all consumed foods into a strict JSON array.

GOLDEN RULES OF PARSING AND UNDERSTANDING:

1. "name": Standard, clean, un-nested food name ALWAYS IN SINGULAR and IN ENGLISH (e.g., "Banana", "Egg", "Tofu", "Oatmeal", "Carrot", "Chicken breast", "Milk", "Avocado", "Potato", "Apple").

2. RECIPE & BATCH MEAL-PREP PORTION CALCULATIONS:
   - When the user describes a recipe/meal-prep dish specifying the TOTAL PREPARED WEIGHT (X, e.g. 550g) and lists its ingredients (e.g. 240g oatmeal, 80g carrot, and tofu = 230g tofu to sum 550g total), AND specifies the eaten portion weight (Y, e.g. 110g):
     a) Total prepared dish weight = 550g.
     b) Eaten portion weight = 110g.
     c) Portion Factor = Y / X = 110 / 550 = 0.2 (20% of the total dish).
     d) CRITICAL: THE SUM OF INGREDIENT GRAMS IN THE EATEN PORTION MUST SUM UP TO EXACTLY THE EATEN PORTION WEIGHT (110g)!
     e) In the 550g recipe, if there is 240g oatmeal and 80g carrot, the primary ingredient (Tofu) weighs in the raw recipe: 550g - 240g - 80g = 230g tofu.
     f) Applying 0.2 (20%) factor to each ingredient for the 110g portion:
        - Tofu eaten: 230g * 0.2 = 46g
        - Oatmeal eaten: 240g * 0.2 = 48g
        - Carrot eaten: 80g * 0.2 = 16g
        - TOTAL SUM OF PORTION INGREDIENTS: 46g + 48g + 16g = 110g EXACTLY.
     g) Assign the same descriptive "dishName" in English to all ingredients (e.g., "Tofu, Oatmeal & Carrot Dish (110g of 550g)").

3. "unit": 'ud' (for pieces/units), 'g' (for grams), 'ml' (for milliliters), or 'portion'.

4. "category": Choose an exact option in English snake_case:
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
   - "other" (sauces, others)

5. DIRECT EXAMPLES:

   Input: "plato de 550 gramos de tofu, 240 gramos de avena, 80 gramos de zanahoria. Me como 110 gramos"
   Explanation: Total 550g dish contains 230g tofu, 240g oatmeal, 80g carrot. User eats 110g (20%).
   Required JSON Output (ingredients sum up to 110g, all names in English):
   [
     {
       "name": "Tofu",
       "dishName": "Tofu, Oatmeal & Carrot Dish (110g of 550g)",
       "quantity": 46,
       "unit": "g",
       "category": "legumes",
       "calories": 37,
       "protein": 3.7,
       "carbs": 0.9,
       "fats": 2.1
     },
     {
       "name": "Oatmeal",
       "dishName": "Tofu, Oatmeal & Carrot Dish (110g of 550g)",
       "quantity": 48,
       "unit": "g",
       "category": "grains",
       "calories": 178,
       "protein": 6.5,
       "carbs": 28.8,
       "fats": 3.1
     },
     {
       "name": "Carrot",
       "dishName": "Tofu, Oatmeal & Carrot Dish (110g of 550g)",
       "quantity": 16,
       "unit": "g",
       "category": "vegetables",
       "calories": 6,
       "protein": 0.2,
       "carbs": 1.4,
       "fats": 0.0
     }
   ]

   Input: "2 huevos cocidos y 1 platano"
   Required JSON Output (names in English):
   [
     {
       "name": "Egg",
       "quantity": 2,
       "unit": "ud",
       "category": "meat",
       "calories": 155,
       "protein": 13.0,
       "carbs": 1.1,
       "fats": 11.0
     },
     {
       "name": "Banana",
       "quantity": 1,
       "unit": "ud",
       "category": "fruit",
       "calories": 89,
       "protein": 1.1,
       "carbs": 22.8,
       "fats": 0.3
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
      // Catch network / auth error and continue silently to next model / local parser
    }
  }

  return null;
}
