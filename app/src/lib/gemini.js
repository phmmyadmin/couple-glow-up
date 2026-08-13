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
   - When the user lists raw ingredient weights for a recipe (e.g. 550g tofu, 240g oatmeal, 80g carrot) and specifies the eaten portion (Y, e.g. "me como 110g"):
     a) Total Batch Recipe Weight (X) = Sum of all raw ingredient weights (550 + 240 + 80 = 870g total recipe weight!).
     b) Eaten Portion Weight (Y) = 110g.
     c) Portion Factor = Y / X = 110 / 870 = 0.126437 (12.64% of the batch recipe).
     d) Multiply EACH ingredient's raw weight by the portion factor (0.126437):
        - Tofu eaten: 550g * 0.126437 = 69.5g (approx 70g)
        - Oatmeal eaten: 240g * 0.126437 = 30.3g (approx 30g)
        - Carrot eaten: 80g * 0.126437 = 10.2g (approx 10g)
     e) CRITICAL: THE SUM OF EATEN INGREDIENT GRAMS (69.5g + 30.3g + 10.2g = 110g) MUST SUM UP TO EXACTLY THE EATEN PORTION WEIGHT (110g)!
     f) ALWAYS PRESERVE INGREDIENT PROPORTIONS: Since 550g Tofu > 240g Oatmeal in the recipe, the eaten Tofu (69.5g) MUST be greater than eaten Oatmeal (30.3g)!
     g) Assign the same descriptive "dishName" in English to all ingredients (e.g., "Tofu, Oatmeal & Carrot Dish (110g of 870g)").

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

   Input: "plato de 550 gramos de tofu, 240 gramos de oats, 80 grams of carrots. Me como 110 gramos"
   Explanation: Total batch weight = 550g tofu + 240g oats + 80g carrots = 870g. Eaten portion = 110g (Factor = 110 / 870 = 0.1264).
   Required JSON Output (ingredient portion grams sum up to 110g, preserving Tofu > Oats ratio):
   [
     {
       "name": "Tofu",
       "dishName": "Tofu, Oatmeal & Carrot Dish (110g of 870g)",
       "quantity": 69.5,
       "unit": "g",
       "category": "legumes",
       "calories": 56,
       "protein": 5.6,
       "carbs": 1.4,
       "fats": 3.1
     },
     {
       "name": "Oatmeal",
       "dishName": "Tofu, Oatmeal & Carrot Dish (110g of 870g)",
       "quantity": 30.3,
       "unit": "g",
       "category": "grains",
       "calories": 112,
       "protein": 4.1,
       "carbs": 18.2,
       "fats": 2.0
     },
     {
       "name": "Carrot",
       "dishName": "Tofu, Oatmeal & Carrot Dish (110g of 870g)",
       "quantity": 10.2,
       "unit": "g",
       "category": "vegetables",
       "calories": 4,
       "protein": 0.1,
       "carbs": 0.9,
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
