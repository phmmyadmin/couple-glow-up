import React from 'react';
import { CheckCircle2 } from 'lucide-react';

export default function Toast({ message }) {
  if (!message) return null;

  return (
    <div className="fixed top-5 left-1/2 -translate-x-1/2 z-50 animate-bounce">
      <div className="bg-emerald-500 text-white font-medium px-4 py-2 rounded-full shadow-lg flex items-center gap-2 text-sm border border-emerald-400">
        <CheckCircle2 className="w-4 h-4" />
        <span>{message}</span>
      </div>
    </div>
  );
}
