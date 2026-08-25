import { describe, it, expect } from 'vitest';
import { getNutritionalFallbackForFood } from '../../lib/supabase';

// Helper matching DishesView portion calculation logic
function calculateDishTotals(ingredients = []) {
  return ingredients.reduce(
    (acc, ing) => {
      const qty = Number(ing.quantity) || 0;
      const cals = Number(ing.calories) || 0;
      const prot = Number(ing.protein) || 0;
      const carbs = Number(ing.carbs) || 0;
      const fats = Number(ing.fats) || 0;
      const fiber = Number(ing.fiber) || 0;
      const sugar = Number(ing.sugar) || 0;
      const sodium = Number(ing.sodium) || 0;

      return {
        totalGrams: acc.totalGrams + (ing.unit === 'g' || ing.unit === 'ml' ? qty : qty * 100),
        calories: acc.calories + cals,
        protein: Math.round((acc.protein + prot) * 10) / 10,
        carbs: Math.round((acc.carbs + carbs) * 10) / 10,
        fats: Math.round((acc.fats + fats) * 10) / 10,
        fiber: Math.round((acc.fiber + fiber) * 10) / 10,
        sugar: Math.round((acc.sugar + sugar) * 10) / 10,
        sodium: acc.sodium + sodium,
      };
    },
    { totalGrams: 0, calories: 0, protein: 0, carbs: 0, fats: 0, fiber: 0, sugar: 0, sodium: 0 }
  );
}

function scaleRecipePortion(dish, eatenWeightGrams) {
  const totals = calculateDishTotals(dish.ingredients);
  const totalGrams = totals.totalGrams || 100;
  const ratio = eatenWeightGrams / totalGrams;

  return dish.ingredients.map((ing) => {
    const scaledQty = Math.round((Number(ing.quantity) || 1) * ratio * 10) / 10;
    const scaledCals = Math.round((Number(ing.calories) || 0) * ratio);
    const scaledProt = Math.round((Number(ing.protein) || 0) * ratio * 10) / 10;
    const scaledCarbs = Math.round((Number(ing.carbs) || 0) * ratio * 10) / 10;
    const scaledFats = Math.round((Number(ing.fats) || 0) * ratio * 10) / 10;
    const scaledFiber = Math.round((Number(ing.fiber) || 0) * ratio * 10) / 10;
    const scaledSugar = Math.round((Number(ing.sugar) || 0) * ratio * 10) / 10;
    const scaledSodium = Math.round((Number(ing.sodium) || 0) * ratio);

    return {
      name: ing.name,
      quantity: scaledQty,
      calories: scaledCals,
      protein: scaledProt,
      carbs: scaledCarbs,
      fats: scaledFats,
      fiber: scaledFiber,
      sugar: scaledSugar,
      sodium: scaledSodium,
    };
  });
}

describe('Nutrition & Recipe Batch Scaling Integration', () => {
  describe('Batch Recipe Math & Macro Totals', () => {
    const mealPrepBatch = {
      name: 'Chicken Rice & Broccoli Meal Prep (4 Portions)',
      ingredients: [
        { name: 'Cooked Chicken Breast', quantity: 400, unit: 'g', calories: 660, protein: 124, carbs: 0, fats: 14.4, fiber: 0, sugar: 0, sodium: 1400 },
        { name: 'Cooked White Rice', quantity: 600, unit: 'g', calories: 780, protein: 16.2, carbs: 168, fats: 1.8, fiber: 2.4, sugar: 0.6, sodium: 6 },
        { name: 'Steamed Broccoli', quantity: 200, unit: 'g', calories: 70, protein: 5.6, carbs: 14, fats: 0.8, fiber: 5.2, sugar: 3.4, sodium: 60 },
      ],
    };

    it('accurately sums total batch weight and macros', () => {
      const totals = calculateDishTotals(mealPrepBatch.ingredients);
      expect(totals.totalGrams).toBe(1200); // 400g + 600g + 200g
      expect(totals.calories).toBe(1510);   // 660 + 780 + 70
      expect(totals.protein).toBe(145.8);   // 124 + 16.2 + 5.6
      expect(totals.carbs).toBe(182);       // 0 + 168 + 14
      expect(totals.fats).toBe(17);         // 14.4 + 1.8 + 0.8
      expect(totals.fiber).toBe(7.6);
      expect(totals.sodium).toBe(1466);
    });

    it('scales portion accurately when eating a single portion (300g of 1200g = 25%)', () => {
      const singlePortionItems = scaleRecipePortion(mealPrepBatch, 300);
      const totalPortionCals = singlePortionItems.reduce((sum, item) => sum + item.calories, 0);
      const totalPortionProt = singlePortionItems.reduce((sum, item) => sum + item.protein, 0);
      const totalPortionCarbs = singlePortionItems.reduce((sum, item) => sum + item.carbs, 0);

      // 25% of 1510 = 377.5 kcal -> rounded integers sum ~378
      expect(totalPortionCals).toBeGreaterThanOrEqual(376);
      expect(totalPortionCals).toBeLessThanOrEqual(379);

      // 25% of 145.8g protein = 36.45g -> scaled rounded sum ~36.5g
      expect(totalPortionProt).toBeCloseTo(36.5, 1);

      // 25% of 182g carbs = 45.5g
      expect(totalPortionCarbs).toBeCloseTo(45.5, 1);
    });

    it('preserves micronutrients (fiber, sugar, sodium) proportionally upon scaling', () => {
      const halfBatchItems = scaleRecipePortion(mealPrepBatch, 600); // 50%
      const halfSodium = halfBatchItems.reduce((sum, i) => sum + i.sodium, 0);
      const halfFiber = halfBatchItems.reduce((sum, i) => sum + i.fiber, 0);

      expect(halfSodium).toBe(733); // 1466 / 2
      expect(halfFiber).toBeCloseTo(3.8, 1); // 7.6 / 2
    });
  });

  describe('Nutritional Fallback Lookup Engine (Micronutrients)', () => {
    it('returns accurate micronutrients for oats / avena', () => {
      const oatsNut = getNutritionalFallbackForFood('avena', 100);
      expect(oatsNut.fiber).toBe(10.0);
      expect(oatsNut.sugar).toBe(1.0);
      expect(oatsNut.sodium).toBe(2);
    });

    it('returns accurate micronutrients for peanut butter / crema de cacahuete', () => {
      const pbNut = getNutritionalFallbackForFood('crema de cacahuete', 50); // 50g = half
      expect(pbNut.fiber).toBe(3.0);
      expect(pbNut.sugar).toBe(4.5);
      expect(pbNut.sodium).toBe(200);
    });

    it('returns accurate micronutrients for cooked chicken breast', () => {
      const chickenNut = getNutritionalFallbackForFood('cooked chicken breast', 100);
      expect(chickenNut.fiber).toBe(0);
      expect(chickenNut.sugar).toBe(0);
      expect(chickenNut.sodium).toBeGreaterThanOrEqual(65);
    });

    it('returns safe defaults for unknown food names', () => {
      const unknownNut = getNutritionalFallbackForFood('unregistered exotic food item', 100);
      expect(unknownNut).toEqual({ fiber: 0, sugar: 0, sodium: 0 });
    });
  });

  describe('Daily Diary Meal Macro Summation', () => {
    it('aggregates daily intake logs across meals correctly', () => {
      const dayMeals = [
        { meal_type: 'breakfast', calories: 450, protein: 30, carbs: 50, fats: 12 },
        { meal_type: 'lunch', calories: 650, protein: 45, carbs: 70, fats: 18 },
        { meal_type: 'dinner', calories: 500, protein: 40, carbs: 40, fats: 15 },
        { meal_type: 'snack', calories: 200, protein: 15, carbs: 20, fats: 5 },
      ];

      const dailyTotal = dayMeals.reduce(
        (acc, m) => ({
          calories: acc.calories + m.calories,
          protein: acc.protein + m.protein,
          carbs: acc.carbs + m.carbs,
          fats: acc.fats + m.fats,
        }),
        { calories: 0, protein: 0, carbs: 0, fats: 0 }
      );

      expect(dailyTotal.calories).toBe(1800);
      expect(dailyTotal.protein).toBe(130);
      expect(dailyTotal.carbs).toBe(180);
      expect(dailyTotal.fats).toBe(50);
    });
  });
});
