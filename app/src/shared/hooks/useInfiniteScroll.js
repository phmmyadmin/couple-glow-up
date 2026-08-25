import { useState, useEffect, useRef, useCallback } from 'react';

/**
 * Pure helper function to paginate items up to a given page.
 * @param {Array} items
 * @param {number} pageSize
 * @param {number} page
 * @returns {Array}
 */
export function paginateItems(items = [], pageSize = 20, page = 1) {
  if (!Array.isArray(items)) return [];
  const limit = Math.max(0, page * pageSize);
  return items.slice(0, limit);
}

/**
 * Pure helper function to calculate the next page number.
 * @param {number} currentPage
 * @param {number} pageSize
 * @param {number} totalItems
 * @returns {number}
 */
export function calculateNextPage(currentPage = 1, pageSize = 20, totalItems = 0) {
  const maxPage = Math.max(1, Math.ceil(totalItems / pageSize));
  if (currentPage >= maxPage) return currentPage;
  return currentPage + 1;
}

/**
 * Pure helper to compute complete pagination metadata.
 * @param {Array} items
 * @param {number} pageSize
 * @param {number} page
 * @returns {Object}
 */
export function getPaginationMetadata(items = [], pageSize = 20, page = 1) {
  if (!Array.isArray(items) || items.length === 0) {
    return {
      displayed: [],
      hasMore: false,
      totalCount: 0,
      visibleCount: 0,
      page: 1,
      maxPage: 1,
    };
  }

  const totalCount = items.length;
  const maxPage = Math.max(1, Math.ceil(totalCount / pageSize));
  const validPage = Math.min(Math.max(1, page), maxPage);
  const visibleCount = Math.min(validPage * pageSize, totalCount);
  const displayed = items.slice(0, visibleCount);
  const hasMore = visibleCount < totalCount;

  return {
    displayed,
    hasMore,
    totalCount,
    visibleCount,
    page: validPage,
    maxPage,
  };
}

/**
 * React Hook for Progressive / Infinite Scroll Pagination
 * @param {Object} options
 * @param {Array} options.items - The full list of items (filtered or raw)
 * @param {number} [options.pageSize=20] - Number of items to reveal per chunk
 * @param {Array} [options.resetDependencies=[]] - State variables (e.g. search, filters) that should reset page back to 1
 * @param {number} [options.threshold=0.1] - IntersectionObserver threshold
 * @returns {Object}
 */
export function useInfiniteScroll({
  items = [],
  pageSize = 20,
  resetDependencies = [],
  threshold = 0.1,
} = {}) {
  const [page, setPage] = useState(1);
  const observerRef = useRef(null);

  // Reset page to 1 whenever resetDependencies (search, filters, etc.) change
  useEffect(() => {
    setPage(1);
  }, resetDependencies);

  const { displayed, hasMore, totalCount, visibleCount } = getPaginationMetadata(
    items,
    pageSize,
    page
  );

  const loadMore = useCallback(() => {
    setPage((prevPage) => calculateNextPage(prevPage, pageSize, items?.length || 0));
  }, [pageSize, items?.length]);

  const reset = useCallback(() => {
    setPage(1);
  }, []);

  // Sentinel ref callback for auto-loading on scroll using IntersectionObserver
  const sentinelRef = useCallback(
    (node) => {
      if (observerRef.current) {
        observerRef.current.disconnect();
      }

      if (!node || !hasMore) return;

      if (typeof window !== 'undefined' && 'IntersectionObserver' in window) {
        observerRef.current = new IntersectionObserver(
          (entries) => {
            const first = entries[0];
            if (first && first.isIntersecting) {
              loadMore();
            }
          },
          {
            root: null,
            rootMargin: '250px', // Pre-fetch 250px before reaching the bottom
            threshold,
          }
        );

        observerRef.current.observe(node);
      }
    },
    [hasMore, loadMore, threshold]
  );

  return {
    displayedItems: displayed,
    hasMore,
    totalCount,
    visibleCount,
    page,
    loadMore,
    reset,
    sentinelRef,
  };
}

export default useInfiniteScroll;
