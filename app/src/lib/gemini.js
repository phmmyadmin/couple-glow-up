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
Eres un nutricionista de precisión experto en conteo de calorías y macronutrientes.
Tu ÚNICA tarea es analizar el texto introducido por el usuario y extraer los alimentos consumidos en una estructura JSON estricta.

REGLAS DE ORO DE ENTENDIMIENTO Y PARSEO:

1. "name": Nombre estándar, limpio y en SINGULAR del alimento en español (ej: "Plátano", "Huevo", "Tofu", "Avena", "Zanahoria", "Pechuga de pollo").

2. INTERPRETACÓN Y CÁLCULO DE PLATOS Y RECETAS (MEAL-PREP / PORCIONES):
   - Cuando el usuario describa una receta, guiso o mezcla indicando los pesos o ingredientes totales (ej: "550g de tofu, 240g de avena, 80g de zanahoria" o "plato de 550g con..."), Y al final indique que solo consume una porción (ej: "me como 110g", "comí 200g", "serví 1/3"):
     a) Calcula el PESO TOTAL PREPARADO (X). Si hay varios ingredientes en gramos, X es la suma de los gramos de los ingredientes o el peso global indicado (ej: 550g).
     b) Identifica el PESO CONSUMIDO REAL (Y) (ej: 110g).
     c) CALCULA EL FACTOR PROPORCIONAL: Factor = Y / X (ej: 110 / 550 = 0.2).
     d) GENERA UN OBJETO INDEPENDIENTE EN EL ARRAY PARA CADA INGREDIENTE.
     e) MULTIPLICACIÓN EXPLICITA:
        - quantity = cantidad_ingrediente * Factor (ej: 550g * 0.2 = 110g tofu; 240g * 0.2 = 48g avena; 80g * 0.2 = 16g zanahoria).
        - calories = calorías_totales_de_esa_cantidad_proporcional.
        - protein, carbs, fats = macronutrientes_exactos_de_esa_cantidad_proporcional.
     f) Asigna a todos estos ingredientes el mismo "dishName" descriptivo (ej: "Plato de Tofu, Avena y Zanahoria (110g de 550g)").

3. "unit": 'ud' (para piezas o unidades), 'g' (para gramos), 'ml' (para mililitros) o 'porcion'.

4. "category": Elige una opción exacta en English snake_case:
   - "meat" (carnes, aves, pescados, mariscos, huevos)
   - "legumes" (lentejas, garbanzos, alubias, soja, tofu, tempeh, edamame)
   - "vegetables" (verduras, hortalizas, zanahorias, ensaladas)
   - "tubers" (patatas, boniatos, yuca)
   - "fruit" (frutas frescas y secas)
   - "bakery" (panes, bollería, galletas)
   - "fast_food" (ultraprocesados, pizzas, hamburguesas)
   - "dairy" (leche, yogures, quesos)
   - "grains" (arroz, pasta, avena, cereales)
   - "healthy_fats" (aceites, frutos secos, aguacate)
   - "beverages" (bebidas, zumos, café)
   - "other" (salsas, otros)

5. EJEMPLOS DIRECTOS:

   Entrada: "plato de 550 gramos de tofu, 240 gramos de avena, 80 gramos de zanahoria. Me como 110 gramos"
   Respuesta requerida (3 objetos al 20%):
   [
     {
       "name": "Tofu",
       "dishName": "Plato de Tofu, Avena y Zanahoria (110g de 550g)",
       "quantity": 110,
       "unit": "g",
       "category": "legumes",
       "calories": 88,
       "protein": 8.8,
       "carbs": 2.2,
       "fats": 5.0
     },
     {
       "name": "Avena",
       "dishName": "Plato de Tofu, Avena y Zanahoria (110g de 550g)",
       "quantity": 48,
       "unit": "g",
       "category": "grains",
       "calories": 178,
       "protein": 6.5,
       "carbs": 28.8,
       "fats": 3.1
     },
     {
       "name": "Zanahoria",
       "dishName": "Plato de Tofu, Avena y Zanahoria (110g de 550g)",
       "quantity": 16,
       "unit": "g",
       "category": "vegetables",
       "calories": 6,
       "protein": 0.2,
       "carbs": 1.4,
       "fats": 0.0
     }
   ]

   Entrada: "2 huevos cocidos y 1 platano"
   Respuesta requerida:
   [
     {
       "name": "Huevo",
       "quantity": 2,
       "unit": "ud",
       "category": "meat",
       "calories": 155,
       "protein": 13.0,
       "carbs": 1.1,
       "fats": 11.0
     },
     {
       "name": "Plátano",
       "quantity": 1,
       "unit": "ud",
       "category": "fruit",
       "calories": 89,
       "protein": 1.1,
       "carbs": 22.8,
       "fats": 0.3
     }
   ]

Texto del usuario: "${userText}"

Devuelve EXCLUSIVAMENTE el array JSON estricto:`;

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
