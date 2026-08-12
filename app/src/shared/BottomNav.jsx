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
    },
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
      label: t('nav.shopping', 'Compras'),
      icon: ShoppingCart,
    },
  ];

  return (
    <nav
      aria-label="Navegación principal"
      className="fixed bottom-0 left-0 right-0 z-40 bg-white/95 backdrop-blur-md border-t border-slate-200/80 shadow-lg"
    >
      <div className="max-w-4xl mx-auto px-4 py-2 flex items-center justify-around">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = activeModule === item.id;
          return (
            <button
              key={item.id}
              onClick={() => setActiveModule(item.id)}
              aria-label={item.label}
              aria-current={isActive ? 'page' : undefined}
              className={`relative flex flex-col items-center justify-center py-1 px-4 rounded-2xl transition-all duration-200 ${
                isActive
                  ? 'text-indigo-600 font-bold'
                  : 'text-slate-500 hover:text-slate-800'
              }`}
            >
              <div
                className={`p-1.5 rounded-xl transition-all duration-200 ${
                  isActive
                    ? 'bg-indigo-50 text-indigo-600 shadow-sm'
                    : 'bg-transparent'
                }`}
              >
                <Icon className="w-5 h-5" />
              </div>
              <span className="text-[11px] sm:text-xs mt-0.5 tracking-tight">
                {item.label}
              </span>

              {item.badge && (
                <span className="absolute top-1 right-3 w-2 h-2 bg-rose-500 rounded-full animate-ping" />
              )}
            </button>
          );
        })}
      </div>
    </nav>
  );
}
