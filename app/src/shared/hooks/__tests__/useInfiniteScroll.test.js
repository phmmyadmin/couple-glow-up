/**
 * Test suite for useInfiniteScroll / paginateItems logic (TDD)
 */

import { paginateItems, calculateNextPage, getPaginationMetadata } from '../useInfiniteScroll.js';

function runTests() {
  console.log('🧪 Running TDD Test Suite for Infinite Scroll Pagination Logic...\n');
  let passed = 0;
  let failed = 0;

  function assert(condition, message) {
    if (condition) {
      console.log(`  ✅ PASS: ${message}`);
      passed++;
    } else {
      console.error(`  ❌ FAIL: ${message}`);
      failed++;
    }
  }

  // TEST 1: Empty list pagination
  {
    const items = [];
    const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(items, 20, 1);
    assert(displayed.length === 0, 'Empty list returns empty displayed array');
    assert(hasMore === false, 'Empty list hasMore is false');
    assert(totalCount === 0, 'Empty list totalCount is 0');
    assert(visibleCount === 0, 'Empty list visibleCount is 0');
  }

  // TEST 2: List smaller than pageSize
  {
    const items = Array.from({ length: 12 }, (_, i) => `item-${i + 1}`);
    const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(items, 20, 1);
    assert(displayed.length === 12, 'List smaller than pageSize displays all items on page 1');
    assert(hasMore === false, 'List smaller than pageSize hasMore is false');
    assert(totalCount === 12, 'totalCount matches items.length');
    assert(visibleCount === 12, 'visibleCount matches items.length');
  }

  // TEST 3: List larger than pageSize - Page 1
  {
    const items = Array.from({ length: 87 }, (_, i) => `exercise-${i + 1}`);
    const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(items, 20, 1);
    assert(displayed.length === 20, 'Page 1 displays exactly pageSize (20) items');
    assert(displayed[0] === 'exercise-1', 'First displayed item is correct');
    assert(displayed[19] === 'exercise-20', 'Last displayed item on page 1 is correct');
    assert(hasMore === true, 'hasMore is true when items remain');
    assert(totalCount === 87, 'totalCount is 87');
    assert(visibleCount === 20, 'visibleCount is 20');
  }

  // TEST 4: Calculate Next Page and progressive expansion
  {
    const items = Array.from({ length: 87 }, (_, i) => `exercise-${i + 1}`);
    const page2 = calculateNextPage(1, 20, items.length);
    assert(page2 === 2, 'calculateNextPage increments from page 1 to 2');

    const metaPage2 = getPaginationMetadata(items, 20, page2);
    assert(metaPage2.displayed.length === 40, 'Page 2 displays cumulative 40 items');
    assert(metaPage2.hasMore === true, 'Page 2 hasMore is true');

    const page5 = 5; // 5 * 20 = 100 > 87
    const metaPage5 = getPaginationMetadata(items, 20, page5);
    assert(metaPage5.displayed.length === 87, 'Last page displays all 87 items without index out of bounds');
    assert(metaPage5.hasMore === false, 'Last page hasMore is false');
    assert(metaPage5.visibleCount === 87, 'visibleCount is capped at totalCount');
  }

  // TEST 5: Boundary conditions & exact multiple of pageSize
  {
    const items = Array.from({ length: 40 }, (_, i) => `dish-${i + 1}`);
    const page2Meta = getPaginationMetadata(items, 20, 2);
    assert(page2Meta.displayed.length === 40, 'Exact multiple displays all items on page 2');
    assert(page2Meta.hasMore === false, 'Exact multiple hasMore is false on final page');

    // Trying to calculate next page when already at end
    const nextWhenFull = calculateNextPage(2, 20, 40);
    assert(nextWhenFull === 2, 'calculateNextPage does not increment beyond max pages');
  }

  // TEST 6: Filtering & Search integration (Reset state)
  {
    const allExercises = Array.from({ length: 150 }, (_, i) => ({
      id: `ex-${i + 1}`,
      name: i % 2 === 0 ? `Bench Press ${i}` : `Squat ${i}`,
      muscle: i % 3 === 0 ? 'chest' : 'legs',
    }));

    const filtered = allExercises.filter(e => e.muscle === 'chest'); // 50 items
    assert(filtered.length === 50, 'Filter correctly yields 50 chest exercises');

    // Page 1 of filtered
    const page1 = getPaginationMetadata(filtered, 20, 1);
    assert(page1.displayed.length === 20, 'Filtered items paginated correctly on page 1');
    assert(page1.hasMore === true, 'Filtered items hasMore is true on page 1');

    // Page 3 of filtered (20 * 3 = 60 > 50)
    const page3 = getPaginationMetadata(filtered, 20, 3);
    assert(page3.displayed.length === 50, 'Filtered items fully displayed on page 3');
    assert(page3.hasMore === false, 'Filtered items hasMore is false on page 3');
  }

  console.log(`\n═══════════════════════════════════════════════════════════════════`);
  console.log(`Test Summary: ${passed} passed, ${failed} failed`);
  if (failed > 0) {
    process.exit(1);
  } else {
    console.log(`🎉 All tests passed successfully!`);
  }
}

runTests();
