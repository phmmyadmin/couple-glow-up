export const calculatePlates = (targetWeight, barWeight = 20, isLbs = false, include25kg = false) => {
  const numTarget = parseFloat(targetWeight);
  const numBar = parseFloat(barWeight) || (isLbs ? 45 : 20);

  if (isNaN(numTarget) || isNaN(numBar) || numTarget <= numBar || numTarget > 2000) {
    return [];
  }

  let weightPerSide = (numTarget - numBar) / 2;
  const plates = [];
  
  // Standard plate denominations (20kg standard base plate, 25kg optional)
  const availablePlates = isLbs 
    ? [45, 35, 25, 10, 5, 2.5] 
    : (include25kg ? [25, 20, 15, 10, 5, 2.5, 1.25] : [20, 15, 10, 5, 2.5, 1.25]);

  for (const plate of availablePlates) {
    let count = 0;
    while (weightPerSide >= plate && count < 30) {
      plates.push(plate);
      weightPerSide -= plate;
      weightPerSide = Math.round(weightPerSide * 1000) / 1000;
      count++;
    }
  }

  return plates;
};
