import React from 'react';
import { Loader2, ArrowDown } from 'lucide-react';

/**
 * Reusable Sentinel Component for Infinite Scroll Pagination
 * @param {Object} props
 * @param {Function} props.sentinelRef - Ref callback from useInfiniteScroll
 * @param {boolean} props.hasMore - Whether more items are available
 * @param {number} props.visibleCount - Current number of displayed items
 * @param {number} props.totalCount - Total number of items
 * @param {Function} props.onLoadMore - Manual load more handler
 * @param {string} [props.itemLabel='items'] - e.g. 'exercises', 'dishes', 'workouts'
 */
export default function InfiniteScrollSentinel({
  sentinelRef,
  hasMore,
  visibleCount = 0,
  totalCount = 0,
  onLoadMore,
  itemLabel = 'items',
}) {
  if (totalCount <= 0) return null;

  return (
    <div className="pt-4 pb-8 flex flex-col items-center justify-center gap-3">
      {/* Visual Progress Badge */}
      <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-slate-100/80 border border-slate-200/80 text-[11px] font-semibold text-slate-600">
        <span>
          Showing <strong className="text-indigo-600 font-bold font-mono">{visibleCount}</strong> of{' '}
          <strong className="text-slate-900 font-bold font-mono">{totalCount}</strong> {itemLabel}
        </span>
      </div>

      {/* Sentinel Trigger & Loading / Manual Load Button */}
      {hasMore ? (
        <div ref={sentinelRef} className="w-full flex flex-col items-center gap-2.5 min-h-[44px] justify-center">
          <div className="flex items-center gap-2 text-xs font-semibold text-indigo-600 animate-pulse">
            <Loader2 className="w-4 h-4 animate-spin text-indigo-600" />
            <span>Loading more {itemLabel}...</span>
          </div>

          {/* Manual Load More Button fallback */}
          {onLoadMore && (
            <button
              type="button"
              onClick={onLoadMore}
              className="mt-1 px-4 py-1.5 bg-white hover:bg-slate-50 active:scale-95 border border-slate-200 rounded-xl text-xs font-bold text-slate-700 shadow-2xs transition-all flex items-center gap-1.5 cursor-pointer"
            >
              <ArrowDown className="w-3.5 h-3.5" />
              <span>Load More (+20)</span>
            </button>
          )}
        </div>
      ) : totalCount > 20 ? (
        <p className="text-[11px] font-medium text-slate-400">
          ✨ You've reached the end of all {totalCount} {itemLabel}
        </p>
      ) : null}
    </div>
  );
}
