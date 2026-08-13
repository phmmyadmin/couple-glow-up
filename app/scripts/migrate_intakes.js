import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

// Read .env manually
const envPath = path.resolve(process.cwd(), '.env');
const envContent = fs.readFileSync(envPath, 'utf8');

const env = {};
envContent.split('\n').forEach((line) => {
  const parts = line.split('=');
  if (parts.length >= 2) {
    env[parts[0].trim()] = parts.slice(1).join('=').trim();
  }
});

const supabaseUrl = env.VITE_SUPABASE_URL;
const supabaseAnonKey = env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('Missing Supabase credentials in .env');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

const SPANISH_TO_ENGLISH_MAP = {
  // Fruits
  'plátano': 'Banana',
  'platano': 'Banana',
  'plátanos': 'Banana',
  'platanos': 'Banana',
  'banana': 'Banana',
  'bananas': 'Banana',
  'manzana': 'Apple',
  'manzanas': 'Apple',
  'naranja': 'Orange',
  'naranjas': 'Orange',
  'fresa': 'Strawberry',
  'fresas': 'Strawberry',
  'pera': 'Pear',
  'peras': 'Pear',
  'uva': 'Grape',
  'uvas': 'Grape',
  'aguacate': 'Avocado',
  'limón': 'Lemon',
  'limon': 'Lemon',

  // Proteins & Meat
  'huevo': 'Egg',
  'huevos': 'Egg',
  'huevo cocido': 'Egg',
  'huevos cocidos': 'Egg',
  'huevo frito': 'Fried Egg',
  'huevos fritos': 'Fried Egg',
  'tofu': 'Tofu',
  'tofu firm': 'Firm Tofu',
  'seitan': 'Seitan',
  'seitán': 'Seitan',
  'tempeh': 'Tempeh',
  'pollo': 'Chicken breast',
  'pechuga de pollo': 'Chicken breast',
  'pechuga pollo': 'Chicken breast',
  'carne de vacuno': 'Beef',
  'ternera': 'Beef',
  'carne picada': 'Minced beef',
  'pavo': 'Turkey',
  'pechuga de pavo': 'Turkey breast',
  'cerdo': 'Pork',
  'pescado': 'Fish',
  'atún': 'Tuna',
  'atun': 'Tuna',
  'atún en lata': 'Canned tuna',
  'salmón': 'Salmon',
  'salmon': 'Salmon',

  // Dairy & Alternatives
  'yogur': 'Yogurt',
  'yogurt': 'Yogurt',
  'yogur natural': 'Natural yogurt',
  'yogurt natural': 'Natural yogurt',
  'leche': 'Milk',
  'leche entera': 'Whole milk',
  'leche desnatada': 'Skimmed milk',
  'queso': 'Cheese',
  'queso fresco': 'Fresh cheese',
  'kefir': 'Kefir',
  'kéfir': 'Kefir',

  // Grains & Carbs
  'avena': 'Oatmeal',
  'avena integral': 'Oatmeal',
  'arroz': 'Rice',
  'arroz blanco': 'White rice',
  'arroz integral': 'Brown rice',
  'pan': 'Bread',
  'pan integral': 'Whole wheat bread',
  'pan de molde': 'Sliced bread',
  'pasta': 'Pasta',
  'macarrones': 'Macaroni',
  'espaguetis': 'Spaghetti',
  'cereales': 'Cereal',

  // Tubers & Vegetables
  'patata': 'Potato',
  'patatas': 'Potato',
  'patata cocida': 'Boiled potato',
  'patatas cocidas': 'Boiled potato',
  'boniato': 'Sweet potato',
  'yuca': 'Cassava',
  'zanahoria': 'Carrot',
  'zanahorias': 'Carrot',
  'ensalada': 'Salad',
  'lechuga': 'Lettuce',
  'tomate': 'Tomato',
  'tomates': 'Tomato',
  'espinacas': 'Spinach',
  'brócoli': 'Broccoli',
  'brocoli': 'Broccoli',
  'verdura': 'Vegetables',
  'verduras': 'Vegetables',

  // Legumes & Healthy Fats & Liquids
  'garbanzos': 'Chickpeas',
  'lentejas': 'Lentils',
  'alubias': 'Beans',
  'soja': 'Soybeans',
  'aceite de oliva': 'Olive oil',
  'aceite': 'Oil',
  'frutos secos': 'Nuts',
  'nueces': 'Walnuts',
  'almendras': 'Almonds',
  'mantequilla de cacahuete': 'Peanut butter',
  'crema de cacahuete': 'Peanut butter',
  'café': 'Coffee',
  'cafe': 'Coffee',
  'té': 'Tea',
  'te': 'Tea',
  'agua': 'Water',
  'zumo': 'Juice',
  'zumo de naranja': 'Orange juice'
};

function translateText(val) {
  if (!val || typeof val !== 'string') return val;
  let text = val.trim();
  const lower = text.toLowerCase();

  if (SPANISH_TO_ENGLISH_MAP[lower]) {
    return SPANISH_TO_ENGLISH_MAP[lower];
  }

  let updated = text;
  // Replace words
  for (const [es, en] of Object.entries(SPANISH_TO_ENGLISH_MAP)) {
    const reg = new RegExp(`\\b${es}\\b`, 'gi');
    if (reg.test(updated)) {
      updated = updated.replace(reg, en);
    }
  }

  // Common replacements for dish titles like "Plato de..." -> "Dish of..."
  updated = updated
    .replace(/^Plato de\s+/i, 'Dish of ')
    .replace(/\bde\b/gi, 'of')
    .replace(/\by\b/gi, '&')
    .replace(/\bPorción\b/gi, 'Portion')
    .replace(/\bporción\b/gi, 'portion');

  return updated.charAt(0).toUpperCase() + updated.slice(1);
}

async function runMigration() {
  console.log('Fetching intakes from Supabase...');
  const { data: intakes, error } = await supabase.from('intakes').select('*');

  if (error) {
    console.error('Error fetching intakes:', error);
    process.exit(1);
  }

  console.log(`Found ${intakes.length} intake rows.`);
  let updatedCount = 0;

  for (const row of intakes) {
    const translatedName = translateText(row.name);
    const translatedDish = translateText(row.dish_name);

    if (translatedName !== row.name || translatedDish !== row.dish_name) {
      console.log(`[Updating #${row.id}]: "${row.name}" -> "${translatedName}" | Dish: "${row.dish_name}" -> "${translatedDish}"`);

      const { error: updateErr } = await supabase
        .from('intakes')
        .update({
          name: translatedName,
          dish_name: translatedDish
        })
        .eq('id', row.id);

      if (updateErr) {
        console.error(`Failed to update intake #${row.id}:`, updateErr);
      } else {
        updatedCount++;
      }
    }
  }

  console.log(`✅ Migration complete! ${updatedCount} intakes updated to English.`);
}

runMigration();
