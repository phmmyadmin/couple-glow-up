import React from 'react';
import { Heart, Apple, Dumbbell, ShoppingCart } from 'lucide-react';
import { useTranslation } from 'react-i18next';

export default function BottomNav({ activeModule, setActiveModule, unreadCount = 0 }) {
  const { t } = useTranslation();

  const navItems = [
    {
      id: 'feed',
      label: t('nav.feed', 'Feed'),
      icon: Heart,
      badge: unreadCount > 0 ? unreadCount : null,
      color: 'from-pink-500 to-rose-500',
    },
    {
      id: 'fit',
      label: t('nav.fit', 'Fit Tracker'),
      icon: Apple,
      color: 'from-emerald-500 to-teal-500',
    },
    {
      id: 'gym',
      label: t('nav.gym', 'Gym Tracker'),
      icon: Dumbbell,
      color: 'from-indigo-500 to-violet-500',
    },
    {
      id: 'shopping',
      label: t('nav.shopping', 'Compras'),
      icon: ShoppingCart,
      color: 'from-amber-500 to-orange-500',
    },
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-40 bg-slate-900/90 backdrop-blur-xl border-t border-slate-800/80 px-2 py-1.5 sm:py-2 max-w-lg mx-auto shadow-2xl">
      <div className="flex items-center justify-around">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = activeModule === item.id;
          return (
            <button
              key={item.id}
              onClick={() => setActiveModule(item.id)}
              className={`relative flex flex-col items-center justify-center py-1 px-3 rounded-xl transition-all duration-200 ${
                isActive
                  ? 'text-white font-medium scale-105'
                  : 'text-slate-400 hover:text-slate-200 hover:bg-slate-800/50'
              }`}
            >
              <div
                className={`p-1.5 rounded-xl transition-all duration-200 ${
                  isActive
                    ? `bg-gradient-to-r ${item.color} shadow-lg shadow-emerald-500/20 text-white`
                    : 'bg-transparent'
                }`}
              >
                <Icon className="w-5 h-5 sm:w-6 sm:h-6" />
              </div>
              <span className={`text-[10px] sm:text-xs mt-1 transition-all ${isActive ? 'font-semibold text-white' : 'font-normal'}`}>
                {item.label}
              </span>

              {item.badge && (
                <span className="absolute top-1 right-2 w-2 h-2 bg-rose-500 rounded-full animate-ping" />
              )}
            </button>
          );
        })}
      </div>
    </nav>
  );
}
