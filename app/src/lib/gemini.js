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

2. INTERPRETACIÓN Y CÁLCULO DE PLATOS Y RECETAS (MEAL-PREP / PORCIONES):
   - Cuando el usuario describa un plato/receta indicando su PESO TOTAL PREPARADO X (ej: 550g) y enumere sus ingredientes (ej: 240g avena, 80g zanahoria y tofu = 230g tofu para sumar los 550g del plato), Y al final indique el peso de la porción que consume Y (ej: 110g):
     a) Peso total del plato en báscula = 550g.
     b) Peso consumido real = 110g.
     c) Factor de porción consumida = 110 / 550 = 0.2 (es decir, consumió exactamente el 20% del plato).
     d) LA SUMA DE LOS GRAMOS DE LOS INGREDIENTES EN LA PORCIÓN CONSUMIDA DEBE SUMAR EXACTAMENTE EL PESO CONSUMIDO (110g)!
     e) En la receta de 550g, si hay 240g avena y 80g zanahoria, el ingrediente principal (Tofu) pesa en la receta entera: 550g - 240g - 80g = 230g tofu.
     f) Aplicando el 20% a cada ingrediente para obtener la porción de 110g consumida:
        - Tofu consumido: 230g * 0.2 = 46g
        - Avena consumida: 240g * 0.2 = 48g
        - Zanahoria consumida: 80g * 0.2 = 16g
        - SUMA TOTAL DE INGREDIENTES CONSUMIDOS: 46g + 48g + 16g = 110g EXACTOS.
     g) Asigna a todos estos ingredientes el mismo "dishName" descriptivo (ej: "Plato de Tofu, Avena y Zanahoria (110g de 550g)").

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
   Explicación: El plato entero de 550g contiene 230g tofu, 240g avena y 80g zanahoria. El usuario consume 110g (el 20%).
   Respuesta requerida (los 3 alimentos suman EXACTAMENTE los 110g consumidos):
   [
     {
       "name": "Tofu",
       "dishName": "Plato de Tofu, Avena y Zanahoria (110g de 550g)",
       "quantity": 46,
       "unit": "g",
       "category": "legumes",
       "calories": 37,
       "protein": 3.7,
       "carbs": 0.9,
       "fats": 2.1
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
