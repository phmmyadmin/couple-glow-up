import { describe, it, expect } from 'vitest';
import { paginateItems, calculateNextPage, getPaginationMetadata } from '../useInfiniteScroll.js';

describe('useInfiniteScroll Pagination Logic Unit & Integration Tests', () => {
  it('returns empty displayed array for empty list', () => {
    const items = [];
    const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(items, 20, 1);
    expect(displayed).toHaveLength(0);
    expect(hasMore).toBe(false);
    expect(totalCount).toBe(0);
    expect(visibleCount).toBe(0);
  });

  it('displays all items on page 1 when list is smaller than pageSize', () => {
    const items = Array.from({ length: 12 }, (_, i) => `item-${i + 1}`);
    const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(items, 20, 1);
    expect(displayed).toHaveLength(12);
    expect(hasMore).toBe(false);
    expect(totalCount).toBe(12);
    expect(visibleCount).toBe(12);
  });

  it('displays exactly pageSize items on page 1 when list is larger than pageSize', () => {
    const items = Array.from({ length: 87 }, (_, i) => `exercise-${i + 1}`);
    const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(items, 20, 1);
    expect(displayed).toHaveLength(20);
    expect(displayed[0]).toBe('exercise-1');
    expect(displayed[19]).toBe('exercise-20');
    expect(hasMore).toBe(true);
    expect(totalCount).toBe(87);
    expect(visibleCount).toBe(20);
  });

  it('calculates next page and progressive cumulative expansion', () => {
    const items = Array.from({ length: 87 }, (_, i) => `exercise-${i + 1}`);
    const page2 = calculateNextPage(1, 20, items.length);
    expect(page2).toBe(2);

    const metaPage2 = getPaginationMetadata(items, 20, page2);
    expect(metaPage2.displayed).toHaveLength(40);
    expect(metaPage2.hasMore).toBe(true);

    const page5 = 5; // 5 * 20 = 100 > 87
    const metaPage5 = getPaginationMetadata(items, 20, page5);
    expect(metaPage5.displayed).toHaveLength(87);
    expect(metaPage5.hasMore).toBe(false);
    expect(metaPage5.visibleCount).toBe(87);
  });

  it('handles boundary conditions and exact multiples of pageSize', () => {
    const items = Array.from({ length: 40 }, (_, i) => `dish-${i + 1}`);
    const page2Meta = getPaginationMetadata(items, 20, 2);
    expect(page2Meta.displayed).toHaveLength(40);
    expect(page2Meta.hasMore).toBe(false);

    const nextWhenFull = calculateNextPage(2, 20, 40);
    expect(nextWhenFull).toBe(2);
  });

  it('integrates cleanly with filtering and search resetting state', () => {
    const allExercises = Array.from({ length: 150 }, (_, i) => ({
      id: `ex-${i + 1}`,
      name: i % 2 === 0 ? `Bench Press ${i}` : `Squat ${i}`,
      muscle: i % 3 === 0 ? 'chest' : 'legs',
    }));

    const filtered = allExercises.filter((e) => e.muscle === 'chest'); // 50 items
    expect(filtered).toHaveLength(50);

    const page1 = getPaginationMetadata(filtered, 20, 1);
    expect(page1.displayed).toHaveLength(20);
    expect(page1.hasMore).toBe(true);

    const page3 = getPaginationMetadata(filtered, 20, 3);
    expect(page3.displayed).toHaveLength(50);
    expect(page3.hasMore).toBe(false);
  });
});
