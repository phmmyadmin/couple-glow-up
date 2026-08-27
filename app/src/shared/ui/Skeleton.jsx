import React from 'react';

/**
 * Base Shimmer Skeleton Element
 */
export default function Skeleton({ className = '', variant = 'rounded' }) {
  const variantStyles = {
    rounded: 'rounded-xl',
    circle: 'rounded-full',
    rect: 'rounded-none',
    pill: 'rounded-full',
  };

  return (
    <div
      className={`animate-pulse bg-gradient-to-r from-slate-200/80 via-slate-100/90 to-slate-200/80 bg-[length:200%_100%] ${
        variantStyles[variant] || 'rounded-xl'
      } ${className}`}
    />
  );
}

export function SkeletonCard({ className = '' }) {
  return (
    <div className={`bg-white rounded-3xl border border-slate-200/80 p-5 space-y-4 shadow-xs animate-pulse ${className}`}>
      <div className="flex items-center justify-between">
        <div className="h-4 bg-slate-200 rounded-lg w-1/3" />
        <div className="h-7 w-7 bg-slate-200 rounded-full" />
      </div>
      <div className="h-3.5 bg-slate-200/70 rounded-lg w-2/3" />
      <div className="h-12 bg-slate-100 rounded-2xl w-full" />
    </div>
  );
}

/**
 * Premium Loading Skeleton for Fit Dashboard
 */
export function FitModuleSkeleton() {
  return (
    <div className="space-y-4 max-w-xl mx-auto animate-pulse">
      {/* 1. Date Picker Bar Skeleton */}
      <div className="flex items-center justify-between bg-white px-4 py-2.5 rounded-2xl border border-slate-200/80 shadow-xs">
        <div className="w-8 h-8 rounded-xl bg-slate-200" />
        <div className="flex items-center gap-2">
          <div className="w-4 h-4 rounded bg-slate-200" />
          <div className="w-32 h-4 rounded-lg bg-slate-200" />
        </div>
        <div className="w-8 h-8 rounded-xl bg-slate-200" />
      </div>

      {/* 2. Macro Rings Card Skeleton */}
      <div className="bg-white rounded-3xl border border-slate-200/90 p-5 sm:p-6 space-y-5 shadow-xs">
        <div className="flex items-center justify-between border-b border-slate-100 pb-3">
          <div className="w-36 h-4 rounded-lg bg-slate-200" />
          <div className="w-16 h-5 rounded-full bg-slate-100" />
        </div>

        {/* 4 Macro Rings Grid */}
        <div className="grid grid-cols-4 gap-2 sm:gap-4 items-center justify-items-center">
          {/* Main Calories Ring */}
          <div className="flex flex-col items-center gap-2">
            <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-full border-4 border-slate-100 bg-slate-50 flex items-center justify-center">
              <div className="w-10 h-4 rounded bg-slate-200" />
            </div>
            <div className="w-14 h-3 rounded bg-slate-200" />
          </div>

          {/* Protein Ring */}
          <div className="flex flex-col items-center gap-2">
            <div className="w-16 h-16 sm:w-18 sm:h-18 rounded-full border-3 border-slate-100 bg-slate-50 flex items-center justify-center">
              <div className="w-8 h-3 rounded bg-slate-200" />
            </div>
            <div className="w-12 h-3 rounded bg-slate-200" />
          </div>

          {/* Carbs Ring */}
          <div className="flex flex-col items-center gap-2">
            <div className="w-16 h-16 sm:w-18 sm:h-18 rounded-full border-3 border-slate-100 bg-slate-50 flex items-center justify-center">
              <div className="w-8 h-3 rounded bg-slate-200" />
            </div>
            <div className="w-12 h-3 rounded bg-slate-200" />
          </div>

          {/* Fats Ring */}
          <div className="flex flex-col items-center gap-2">
            <div className="w-16 h-16 sm:w-18 sm:h-18 rounded-full border-3 border-slate-100 bg-slate-50 flex items-center justify-center">
              <div className="w-8 h-3 rounded bg-slate-200" />
            </div>
            <div className="w-12 h-3 rounded bg-slate-200" />
          </div>
        </div>
      </div>

      {/* 3. Fast AI Chat Input Bar Skeleton */}
      <div className="h-14 bg-white rounded-2xl border border-slate-200/90 shadow-xs flex items-center px-4 justify-between">
        <div className="w-5 h-5 rounded-lg bg-slate-200" />
        <div className="w-1/2 h-3.5 rounded-lg bg-slate-200/70" />
        <div className="w-8 h-8 rounded-xl bg-slate-200" />
      </div>

      {/* 4. Daily Steps Card Skeleton */}
      <div className="bg-white rounded-3xl border border-slate-200/90 p-5 space-y-4 shadow-xs">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2.5">
            <div className="w-9 h-9 rounded-xl bg-emerald-100/60" />
            <div className="space-y-1.5">
              <div className="w-28 h-3.5 rounded bg-slate-200" />
              <div className="w-20 h-2.5 rounded bg-slate-100" />
            </div>
          </div>
          <div className="w-7 h-7 rounded-xl bg-slate-100" />
        </div>

        {/* Progress gauge */}
        <div className="space-y-2">
          <div className="flex justify-between items-baseline">
            <div className="w-24 h-7 rounded-lg bg-slate-200" />
            <div className="w-12 h-4 rounded-full bg-slate-100" />
          </div>
          <div className="w-full h-3 rounded-full bg-slate-100" />
        </div>

        {/* 2 metrics boxes */}
        <div className="grid grid-cols-2 gap-3 pt-1">
          <div className="h-16 rounded-2xl bg-slate-50 border border-slate-100" />
          <div className="h-16 rounded-2xl bg-slate-50 border border-slate-100" />
        </div>
      </div>

      {/* 5. Daily Timeline Meals Skeleton */}
      <div className="space-y-3">
        {[1, 2, 3].map((meal) => (
          <div key={meal} className="bg-white rounded-2xl border border-slate-200/80 p-4 space-y-3 shadow-xs">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <div className="w-6 h-6 rounded-lg bg-slate-100" />
                <div className="w-24 h-3.5 rounded bg-slate-200" />
              </div>
              <div className="w-16 h-3 rounded bg-slate-100" />
            </div>
            <div className="h-10 rounded-xl bg-slate-50 border border-slate-100" />
          </div>
        ))}
      </div>
    </div>
  );
}

/**
 * Premium Loading Skeleton for Gym Module
 */
export function GymModuleSkeleton() {
  return (
    <div className="space-y-5 max-w-xl mx-auto animate-pulse">
      {/* Active routine / Start workout banner */}
      <div className="bg-gradient-to-br from-slate-900 to-indigo-950 rounded-3xl p-6 text-white space-y-4 shadow-lg">
        <div className="flex justify-between items-start">
          <div className="space-y-2">
            <div className="w-24 h-3.5 rounded bg-slate-700" />
            <div className="w-48 h-6 rounded-lg bg-slate-600" />
          </div>
          <div className="w-10 h-10 rounded-2xl bg-slate-800" />
        </div>
        <div className="w-full h-12 rounded-2xl bg-emerald-500/30" />
      </div>

      {/* Weekly Schedule pill row */}
      <div className="flex items-center justify-between gap-1.5 overflow-x-auto py-1">
        {['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day, idx) => (
          <div key={idx} className="flex-1 min-w-[42px] h-16 rounded-2xl bg-white border border-slate-200/80 flex flex-col items-center justify-center gap-1.5">
            <div className="w-4 h-2.5 rounded bg-slate-200" />
            <div className="w-6 h-4 rounded bg-slate-100" />
          </div>
        ))}
      </div>

      {/* Workout History Cards */}
      <div className="space-y-3 pt-2">
        <div className="w-32 h-4 rounded bg-slate-300 mb-2" />
        {[1, 2, 3].map((w) => (
          <div key={w} className="bg-white rounded-3xl border border-slate-200/80 p-5 space-y-3.5 shadow-xs">
            <div className="flex items-center justify-between">
              <div className="space-y-1.5">
                <div className="w-40 h-4 rounded bg-slate-200" />
                <div className="w-24 h-2.5 rounded bg-slate-100" />
              </div>
              <div className="w-14 h-5 rounded-full bg-indigo-50" />
            </div>
            <div className="flex gap-2">
              <div className="w-16 h-6 rounded-lg bg-slate-100" />
              <div className="w-16 h-6 rounded-lg bg-slate-100" />
              <div className="w-16 h-6 rounded-lg bg-slate-100" />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

/**
 * Premium Loading Skeleton for Shopping Module
 */
export function ShoppingModuleSkeleton() {
  return (
    <div className="space-y-4 max-w-xl mx-auto animate-pulse">
      {/* Supermarket selector pills */}
      <div className="flex gap-2 overflow-x-auto pb-1">
        {[1, 2, 3].map((m) => (
          <div key={m} className="h-10 w-28 rounded-2xl bg-white border border-slate-200/80 shrink-0" />
        ))}
      </div>

      {/* Add item input skeleton */}
      <div className="h-12 bg-white rounded-2xl border border-slate-200/80 shadow-xs" />

      {/* Shopping List grouped categories */}
      <div className="space-y-4 pt-2">
        {[1, 2].map((cat) => (
          <div key={cat} className="space-y-2">
            <div className="w-24 h-3.5 rounded bg-slate-300 ml-1" />
            <div className="bg-white rounded-3xl border border-slate-200/80 divide-y divide-slate-100 overflow-hidden shadow-xs">
              {[1, 2, 3].map((item) => (
                <div key={item} className="p-4 flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="w-5 h-5 rounded-md bg-slate-200" />
                    <div className="w-32 h-3.5 rounded bg-slate-200" />
                  </div>
                  <div className="flex items-center gap-2">
                    <div className="w-12 h-6 rounded-lg bg-slate-100" />
                    <div className="w-14 h-6 rounded-lg bg-emerald-50" />
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

/**
 * Premium Loading Skeleton for Feed / Wall Module
 */
export function FeedModuleSkeleton() {
  return (
    <div className="space-y-4 max-w-xl mx-auto animate-pulse">
      {/* Create note card skeleton */}
      <div className="bg-white rounded-3xl border border-slate-200/80 p-5 space-y-3 shadow-xs">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-slate-200" />
          <div className="flex-1 h-10 rounded-2xl bg-slate-100" />
        </div>
      </div>

      {/* Feed post cards */}
      <div className="space-y-4 pt-1">
        {[1, 2, 3].map((post) => (
          <div key={post} className="bg-white rounded-3xl border border-slate-200/80 p-5 sm:p-6 space-y-4 shadow-xs">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-slate-200" />
                <div className="space-y-1">
                  <div className="w-28 h-3.5 rounded bg-slate-200" />
                  <div className="w-16 h-2.5 rounded bg-slate-100" />
                </div>
              </div>
              <div className="w-14 h-5 rounded-full bg-slate-100" />
            </div>
            <div className="space-y-2">
              <div className="w-full h-3.5 rounded bg-slate-100" />
              <div className="w-4/5 h-3.5 rounded bg-slate-100" />
            </div>
            <div className="flex gap-2 pt-1 border-t border-slate-100">
              <div className="w-16 h-7 rounded-xl bg-rose-50" />
              <div className="w-16 h-7 rounded-xl bg-amber-50" />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
