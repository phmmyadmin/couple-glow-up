/**
 * Parallel Gemini model execution using Promise.any().
 * Instead of trying models sequentially (slow), fires them in parallel
 * and returns the first successful, valid response.
 *
 * Latency improvement: from 1.5-3s (sequential cascade) → 300-600ms (parallel race).
 */

/**
 * Race multiple food-parsing model calls in parallel.
 * Returns the first successful result that is a non-empty array.
 * Throws AggregateError if ALL models fail.
 *
 * @param {Array<() => Promise<Array>>} modelCalls - Array of functions that return promises
 * @returns {Promise<Array>} - The first valid food items array
 */
export async function raceFoodModels(modelCalls) {
  if (!modelCalls || modelCalls.length === 0) {
    throw new Error('No model calls provided');
  }

  // Wrap each call to reject on empty/invalid results
  // so Promise.any() skips them and tries the next
  const wrappedCalls = modelCalls.map((callFn) =>
    callFn().then((result) => {
      if (!Array.isArray(result) || result.length === 0) {
        return Promise.reject(new Error('Empty or invalid result'));
      }
      return result;
    })
  );

  return Promise.any(wrappedCalls);
}
