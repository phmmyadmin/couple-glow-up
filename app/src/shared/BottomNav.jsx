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
    <nav className="fixed bottom-0 left-0 right-0 z-40 bg-white/90 backdrop-blur-md border-t border-slate-200 px-3 py-2 max-w-md mx-auto shadow-lg">
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
                  ? 'text-indigo-600 font-semibold'
                  : 'text-slate-500 hover:text-slate-800'
              }`}
            >
              <div
                className={`p-1.5 rounded-xl transition-all duration-200 ${
                  isActive
                    ? 'bg-indigo-50 text-indigo-600'
                    : 'bg-transparent'
                }`}
              >
                <Icon className="w-5 h-5" />
              </div>
              <span className="text-[11px] mt-0.5">
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
