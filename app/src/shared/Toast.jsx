import React, { useEffect } from 'react';
import { CheckCircle2 } from 'lucide-react';

export default function Toast({ message, onClose, duration = 2500 }) {
  useEffect(() => {
    if (!message) return;

    const timer = setTimeout(() => {
      if (onClose) {
        onClose();
      }
    }, duration);

    return () => clearTimeout(timer);
  }, [message, duration, onClose]);

  if (!message) return null;

  return (
    <div className="fixed top-5 left-1/2 -translate-x-1/2 z-50 animate-in fade-in slide-in-from-top-4 duration-200 pointer-events-none">
      <div className="bg-slate-900/90 backdrop-blur-md text-white font-semibold px-4 py-2.5 rounded-2xl shadow-xl flex items-center gap-2.5 text-xs sm:text-sm border border-slate-700/80">
        <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
        <span>{message}</span>
      </div>
    </div>
  );
}
