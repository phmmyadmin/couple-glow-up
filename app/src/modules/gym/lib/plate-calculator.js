export const calculatePlates = (targetWeight, barWeight = 20, isLbs = false) => {
  if (targetWeight <= barWeight) return [];

  let weightPerSide = (targetWeight - barWeight) / 2;
  const plates = [];
  
  // Standard kg plates or lbs plates
  const availablePlates = isLbs 
    ? [45, 35, 25, 10, 5, 2.5] 
    : [20, 15, 10, 5, 2.5, 1.25];

  for (const plate of availablePlates) {
    while (weightPerSide >= plate) {
      plates.push(plate);
      weightPerSide -= plate;
      // Handle floating point precision issues
      weightPerSide = Math.round(weightPerSide * 100) / 100;
    }
  }

  return plates;
};
