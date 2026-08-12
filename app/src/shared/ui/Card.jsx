import React from 'react';

export default function Card({ children, className = '', hover = false, onClick, ...props }) {
  return (
    <div
      onClick={onClick}
      className={`bg-white rounded-2xl border border-slate-200/80 shadow-sm p-4 sm:p-5 transition-all duration-200 ${
        hover ? 'hover:shadow-md hover:border-indigo-200/80 cursor-pointer' : ''
      } ${className}`}
      {...props}
    >
      {children}
    </div>
  );
}

export function CardHeader({ children, className = '' }) {
  return (
    <div className={`flex items-center justify-between mb-3 ${className}`}>
      {children}
    </div>
  );
}

export function CardTitle({ children, className = '', icon: Icon }) {
  return (
    <h3 className={`text-sm font-bold text-slate-900 flex items-center gap-2 ${className}`}>
      {Icon && <Icon className="w-4 h-4 text-indigo-600 shrink-0" />}
      <span>{children}</span>
    </h3>
  );
}
