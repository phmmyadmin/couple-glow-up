import { GoogleGenerativeAI } from '@google/generative-ai';

const apiKey = import.meta.env.VITE_GEMINI_API_KEY;
const isValidApiKey = apiKey && typeof apiKey === 'string' && apiKey.startsWith('AIzaSy');
const genAI = isValidApiKey ? new GoogleGenerativeAI(apiKey) : null;

export async function parseFoodWithGemini(userText) {
  if (!genAI || !isValidApiKey) {
    console.info('VITE_GEMINI_API_KEY no configurada o no válida (debe empezar por AIzaSy...). Usando parser nutricional inteligente.');
    return null;
  }

  const modelsToTry = [
    'gemini-1.5-flash',
    'gemini-2.0-flash',
    'gemini-flash-latest'
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
   CRÍTICO - PORCIONES DE PLATOS/RECETAS PREPARADAS:
   Si el usuario indica que preparó un plato/receta de un peso total X (ej: 555g) y que solo consume una porción Y (ej: 130g), DEBES CALCULAR LA FRACCIÓN PROPORCIONAL (Y / X = 130 / 555 = 0.234) Y MULTIPLICAR LA CANTIDAD Y LOS MACRONUTRIENTES DE CADA INGREDIENTE POR ESA FRACCIÓN PROPORCIONAL.
   - Ejemplo: "de un plato de 555g de avena (con 240g avena y 80g zanahoria) me como 130g"
     -> Fracción consumida: 130 / 555 = 0.2342
     -> Avena consumida: 240g * 0.2342 = 56.2g
     -> Zanahoria consumida: 80g * 0.2342 = 18.7g
     -> Asigna dishName: "Plato de Avena y Zanahoria (Porción 130g de 555g)"
3. "unit": 'ud' (para piezas/unidades), 'g' (para gramos), 'ml' (para mililitros) o 'porcion'.
4. "category": OBLIGATORIO. Categoriza el alimento en una de las siguientes opciones exactas en formato English snake_case:
   - "meat" (Carnes, aves, pescados, mariscos, huevos)
   - "legumes" (Lentejas, garbanzos, alubias, soja, tofu)
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
   - Ejemplo 2: "de un plato de 555g con 240g avena y 80g zanahoria me como 130g" -> 
     Genera 2 objetos ajustados proporcionalmente a la porción de 130g:
     - Avena: quantity: 56.2, unit: "g", category: "grains", calories: 218, protein: 7.6, carbs: 37.6, fats: 3.9, dishName: "Plato de Avena y Zanahoria (130g/555g)"
     - Zanahoria: quantity: 18.7, unit: "g", category: "vegetables", calories: 8, protein: 0.2, carbs: 1.8, fats: 0.0, dishName: "Plato de Avena y Zanahoria (130g/555g)"
6. Para textos con múltiples ingredientes (ej: "2 huevos cocidos y 50g de avena"), genera un objeto independiente por cada alimento.
7. "dishName": (Opcional). Si los alimentos forman parte de un plato compuesto, combo o receta (ej: "Plato de Avena y Zanahoria" o "Ensalada César con pollo"), asigna el nombre del plato general a "dishName".

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
      // Silently try next model fallback if 404 or unsupported
    }
  }

  console.info('Gemini API unreachable. Usando parser nutricional genérico.');
  return null;
}
