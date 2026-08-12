import React from 'react';

export default function Tabs({ items, activeTab, onChange, className = '' }) {
  return (
    <div
      className={`flex items-center gap-1.5 bg-slate-100/90 p-1.5 rounded-2xl overflow-x-auto no-scrollbar border border-slate-200/60 ${className}`}
    >
      {items.map((tab) => {
        const Icon = tab.icon;
        const isActive = activeTab === tab.id;
        return (
          <button
            key={tab.id}
            type="button"
            onClick={() => onChange(tab.id)}
            className={`flex-1 min-w-max flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-xs sm:text-sm font-bold transition-all duration-200 select-none ${
              isActive
                ? 'bg-white text-indigo-600 shadow-sm border border-slate-200/80'
                : 'text-slate-500 hover:text-slate-800 hover:bg-white/50'
            }`}
          >
            {Icon && <Icon className="w-4 h-4 shrink-0" />}
            <span>{tab.label}</span>
            {tab.badge !== undefined && (
              <span className="ml-1 px-2 py-0.5 text-[11px] rounded-full bg-indigo-100 text-indigo-700 font-mono font-bold">
                {tab.badge}
              </span>
            )}
          </button>
        );
      })}
    </div>
  );
}
