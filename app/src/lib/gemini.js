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
Eres un nutricionista experto en conteo de calorías y macronutrientes.
Analiza el siguiente texto de comida del usuario y devuelve un array JSON estricto con los alimentos parseados.

Reglas estrictas de parseo para CUALQUIER alimento del mundo:
1. "name": Nombre estándar, limpio y unificado del alimento OBLIGATORIAMENTE EN SINGULAR y en español con tildes (ej: "Plátano" en vez de "platanos" o "banana", "Huevo" en vez de "huevos" o "huevos cocidos", "Hamburguesa" en vez de "mini burgers", "Yogur natural" en vez de "yogurt", "Patata" en vez de "patatas", "Pollo" en vez de "tu pollo").
2. "quantity": Número exacto de unidades o gramos especificados. 
   CRÍTICO - PORCIONES DE PLATOS/RECETAS PREPARADAS CON MÚLTIPLES INGREDIENTES:
   Si el usuario indica que preparó un plato/receta de un peso total X (ej: 550g) compuesto por varios ingredientes (ej: 550g tofu/plato total, 240g avena, 80g zanahoria) y que solo consume una porción Y (ej: 110g):
   - DEBES CALCULAR LA FRACCIÓN PROPORCIONAL: Factor = Y / X (ej: 110 / 550 = 0.2, es decir el 20%).
   - DEBES GENERAR UN OBJETO INDEPENDIENTE POR CADA INGREDIENTE MULTIPLICANDO SU CANTIDAD Y SUS MACRONUTRIENTES POR ESA FRACCIÓN PROPORCIONAL.
   - Ejemplo: "plato de 550g (o 550g tofu, 240g avena, 80g zanahoria), me como 110g" ->
     -> Fracción = 110 / 550 = 0.2
     -> Tofu consumido: 550g * 0.2 = 110g
     -> Avena consumida: 240g * 0.2 = 48g
     -> Zanahoria consumida: 80g * 0.2 = 16g
     -> Asigna a todos dishName: "Plato de Tofu, Avena y Zanahoria (110g de 550g)"
3. "unit": 'ud' (para piezas/unidades), 'g' (para gramos), 'ml' (para mililitros) o 'porcion'.
4. "category": OBLIGATORIO. Categoriza el alimento en una de las siguientes opciones exactas en formato English snake_case:
   - "meat" (Carnes, aves, pescados, mariscos, huevos)
   - "legumes" (Lentejas, garbanzos, alubias, soja, tofu, tempeh)
   - "vegetables" (Verduras, hortalizas, ensaladas)
   - "tubers" (Patatas, boniatos, camotes, yuca, tubérculos)
   - "fruit" (Frutas frescas y secas)
   - "bakery" (Bollería, donuts, croissants, galletas, pasteles, magdalenas, bizcochos)
   - "fast_food" (Comida rápida, ultraprocesados, fritos, pizzas, hamburguesas)
   - "dairy" (Leche, yogures, quesos)
   - "grains" (Pan, arroz, pasta, avena, cereales)
   - "healthy_fats" (Aceites, frutos secos, aguacate)
   - "beverages" (Bebidas, zumos, batidos, café)
   - "other" (Otros / Salsas / Platos variados)
5. "calories", "protein", "carbs", "fats": Debes calcular el TOTAL de macronutrientes para LA PORCIÓN EXACTA CONSUMIDA por el usuario.
   - Ejemplo 1: "2 huevos cocidos" -> quantity: 2, unit: "ud", category: "meat", calories: 155, protein: 13.0, carbs: 1.1, fats: 11.0.
   - Ejemplo 2: "plato de 550g de tofu, 240g avena, 80g zanahoria. Me como 110g" -> 
     Genera 3 objetos ajustados al 20% (110g/550g = 0.2):
     - Tofu: quantity: 110, unit: "g", category: "legumes", calories: 88, protein: 8.8, carbs: 2.2, fats: 5.0, dishName: "Plato de Tofu, Avena y Zanahoria (110g/550g)"
     - Avena: quantity: 48, unit: "g", category: "grains", calories: 178, protein: 6.5, carbs: 28.8, fats: 3.1, dishName: "Plato de Tofu, Avena y Zanahoria (110g/550g)"
     - Zanahoria: quantity: 16, unit: "g", category: "vegetables", calories: 6, protein: 0.2, carbs: 1.4, fats: 0.0, dishName: "Plato de Tofu, Avena y Zanahoria (110g/550g)"
6. Para textos con múltiples ingredientes (ej: "2 huevos cocidos y 50g de avena"), genera un objeto independiente por cada alimento.
7. "dishName": (Opcional). Si los alimentos forman parte de un plato compuesto, combo o receta (ej: "Plato de Tofu, Avena y Zanahoria"), asigna el nombre del plato general a "dishName".

Texto del usuario: "${userText}"

Devuelve ÚNICAMENTE la estructura JSON en este formato:
[
  {
    "name": "Nombre Alimento",
    "dishName": "Nombre del plato (opcional)",
    "quantity": 1,
    "unit": "ud|g|porcion|ml",
    "category": "meat|legumes|vegetables|fruit|fast_food|dairy|grains|healthy_fats|beverages|other",
    "calories": 100,
    "protein": 10,
    "carbs": 15,
    "fats": 2
  }
]
`;

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
