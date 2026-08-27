import React from 'react';
import { Heart, Apple, Dumbbell, ShoppingCart } from 'lucide-react';
import { useTranslation } from 'react-i18next';

export default function BottomNav({ activeModule, setActiveModule }) {
  const { t } = useTranslation();

  const navItems = [
    {
      id: 'fit',
      label: t('nav.fit', 'Fit'),
      icon: Apple,
    },
    {
      id: 'gym',
      label: t('nav.gym', 'Gym'),
      icon: Dumbbell,
    },
    {
      id: 'shopping',
      label: t('nav.shopping', 'Shopping'),
      icon: ShoppingCart,
    },
    {
      id: 'feed',
      label: t('nav.feed', 'Social'),
      icon: Heart,
    },
  ];

  return (
    <nav
      aria-label="Main Navigation"
      className="fixed bottom-4 left-1/2 -translate-x-1/2 z-40 w-[calc(100%-2rem)] max-w-md bg-white/95 backdrop-blur-lg border border-slate-200/90 rounded-3xl shadow-xl px-2 py-1.5"
    >
      <div className="flex items-center justify-between">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = activeModule === item.id;
          return (
            <button
              key={item.id}
              onClick={() => setActiveModule(item.id)}
              aria-label={item.label}
              aria-current={isActive ? 'page' : undefined}
              className={`flex-1 flex flex-col items-center justify-center py-1.5 px-2 rounded-2xl transition-all duration-200 select-none ${
                isActive
                  ? 'text-indigo-600 font-bold'
                  : 'text-slate-500 hover:text-slate-800 hover:bg-slate-50/80'
              }`}
            >
              <div
                className={`p-1.5 rounded-xl transition-all duration-200 ${
                  isActive
                    ? 'bg-indigo-50 text-indigo-600 shadow-xs'
                    : 'bg-transparent'
                }`}
              >
                <Icon className="w-5 h-5" />
              </div>
              <span className="text-[11px] mt-0.5 tracking-tight font-bold">
                {item.label}
              </span>
            </button>
          );
        })}
      </div>
    </nav>
  );
}
