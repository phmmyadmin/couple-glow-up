import { describe, it, expect } from 'vitest';
import { paginateItems, calculateNextPage, getPaginationMetadata } from '../../shared/hooks/useInfiniteScroll';

describe('Infinite Scroll & Progressive Pagination Flow Integration', () => {
  // Realistic exercise catalog mock (87 items)
  const fullExerciseCatalog = Array.from({ length: 87 }, (_, i) => ({
    id: `ex-${i + 1}`,
    name: `Exercise ${i + 1}`,
    muscle_group: i % 4 === 0 ? 'chest' : i % 4 === 1 ? 'back' : i % 4 === 2 ? 'legs' : 'shoulders',
    equipment: i % 2 === 0 ? 'barbell' : 'dumbbell',
  }));

  // Realistic workout history mock (244 items)
  const fullWorkoutHistory = Array.from({ length: 244 }, (_, i) => ({
    id: `w-${i + 1}`,
    name: `Workout Session ${i + 1}`,
    started_at: new Date(Date.now() - i * 86400000).toISOString(),
    sets_count: 12,
  }));

  describe('Exercise Catalog Pagination Lifecycle', () => {
    it('initializes Page 1 with exactly 20 exercises and hasMore true', () => {
      const page1 = getPaginationMetadata(fullExerciseCatalog, 20, 1);
      expect(page1.displayed.length).toBe(20);
      expect(page1.visibleCount).toBe(20);
      expect(page1.totalCount).toBe(87);
      expect(page1.hasMore).toBe(true);
      expect(page1.displayed[0].id).toBe('ex-1');
      expect(page1.displayed[19].id).toBe('ex-20');
    });

    it('progressively accumulates items on successive page requests (Scroll sequence)', () => {
      let currentPage = 1;
      const pageSize = 20;

      // User scrolls 1st time
      currentPage = calculateNextPage(currentPage, pageSize, fullExerciseCatalog.length);
      expect(currentPage).toBe(2);
      const page2 = getPaginationMetadata(fullExerciseCatalog, pageSize, currentPage);
      expect(page2.displayed.length).toBe(40);
      expect(page2.hasMore).toBe(true);

      // User scrolls 2nd time
      currentPage = calculateNextPage(currentPage, pageSize, fullExerciseCatalog.length);
      expect(currentPage).toBe(3);
      const page3 = getPaginationMetadata(fullExerciseCatalog, pageSize, currentPage);
      expect(page3.displayed.length).toBe(60);
      expect(page3.hasMore).toBe(true);

      // User scrolls 3rd time
      currentPage = calculateNextPage(currentPage, pageSize, fullExerciseCatalog.length);
      expect(currentPage).toBe(4);
      const page4 = getPaginationMetadata(fullExerciseCatalog, pageSize, currentPage);
      expect(page4.displayed.length).toBe(80);
      expect(page4.hasMore).toBe(true);

      // User scrolls 4th time (Final page: 87 items total)
      currentPage = calculateNextPage(currentPage, pageSize, fullExerciseCatalog.length);
      expect(currentPage).toBe(5);
      const page5 = getPaginationMetadata(fullExerciseCatalog, pageSize, currentPage);
      expect(page5.displayed.length).toBe(87);
      expect(page5.hasMore).toBe(false);
      expect(page5.visibleCount).toBe(87);

      // Further scrolls remain on last page
      const overScrollPage = calculateNextPage(currentPage, pageSize, fullExerciseCatalog.length);
      expect(overScrollPage).toBe(5);
    });

    it('resets correctly when search filter is applied', () => {
      // User filters for 'chest' exercises
      const chestExercises = fullExerciseCatalog.filter((e) => e.muscle_group === 'chest');
      expect(chestExercises.length).toBe(22); // 87 / 4 ~ 22

      // Page 1 of search filter
      const filteredPage1 = getPaginationMetadata(chestExercises, 20, 1);
      expect(filteredPage1.displayed.length).toBe(20);
      expect(filteredPage1.hasMore).toBe(true);

      // Page 2 of search filter
      const filteredPage2 = getPaginationMetadata(chestExercises, 20, 2);
      expect(filteredPage2.displayed.length).toBe(22);
      expect(filteredPage2.hasMore).toBe(false);
    });
  });

  describe('Large Workout History (244 Workouts) Batching', () => {
    it('handles large 244 workout dataset with 15-item batches smoothly', () => {
      const pageSize = 15;
      const total = fullWorkoutHistory.length; // 244
      const maxPages = Math.ceil(total / pageSize); // 17 pages

      expect(maxPages).toBe(17);

      const firstPage = getPaginationMetadata(fullWorkoutHistory, pageSize, 1);
      expect(firstPage.displayed.length).toBe(15);
      expect(firstPage.hasMore).toBe(true);

      const halfWay = getPaginationMetadata(fullWorkoutHistory, pageSize, 8);
      expect(halfWay.displayed.length).toBe(120);
      expect(halfWay.hasMore).toBe(true);

      const finalPage = getPaginationMetadata(fullWorkoutHistory, pageSize, 17);
      expect(finalPage.displayed.length).toBe(244);
      expect(finalPage.hasMore).toBe(false);
    });
  });

  describe('Boundary & Edge Case Handling', () => {
    it('handles empty datasets safely', () => {
      const res = getPaginationMetadata([], 20, 1);
      expect(res.displayed).toEqual([]);
      expect(res.hasMore).toBe(false);
      expect(res.totalCount).toBe(0);
      expect(res.visibleCount).toBe(0);
    });

    it('handles null or undefined datasets safely', () => {
      const res = getPaginationMetadata(null, 20, 1);
      expect(res.displayed).toEqual([]);
      expect(res.hasMore).toBe(false);
    });

    it('handles datasets with exact multiples of page size (e.g. 40 items)', () => {
      const items = Array.from({ length: 40 }, (_, i) => `item-${i}`);
      const page1 = getPaginationMetadata(items, 20, 1);
      expect(page1.hasMore).toBe(true);

      const page2 = getPaginationMetadata(items, 20, 2);
      expect(page2.displayed.length).toBe(40);
      expect(page2.hasMore).toBe(false);
    });
  });
});
