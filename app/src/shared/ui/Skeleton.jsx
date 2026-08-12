import React from 'react';

export default function Skeleton({ className = '' }) {
  return (
    <div className={`animate-pulse bg-slate-200/80 rounded-xl ${className}`} />
  );
}

export function SkeletonCard() {
  return (
    <div className="bg-white rounded-2xl border border-slate-200/80 p-5 space-y-3 shadow-sm animate-pulse">
      <div className="flex items-center justify-between">
        <div className="h-4 bg-slate-200 rounded-lg w-1/3" />
        <div className="h-6 w-6 bg-slate-200 rounded-full" />
      </div>
      <div className="h-3 bg-slate-200 rounded-lg w-2/3" />
      <div className="h-10 bg-slate-100 rounded-xl w-full" />
    </div>
  );
}
