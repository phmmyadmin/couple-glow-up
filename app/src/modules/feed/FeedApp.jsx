import React, { useState } from 'react';
import { Heart } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import Avatar from '../../shared/Avatar';

export default function FeedApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();

  const [feedEvents, setFeedEvents] = useState([
    {
      id: '1',
      profile: profiles[0] || { name: 'Pablo', gender: 'male' },
      event_type: 'workout_completed',
      title: `${profiles[0]?.name || 'Pablo'} ha completado un entrenamiento`,
      description: 'Push Day · 45 min · 7,553 kg volumen',
      emoji: '🏋️',
      created_at: 'Hace 2 horas',
      reactions: [{ id: 'r1', emoji: '🔥', count: 1 }],
    },
    {
      id: '2',
      profile: profiles[1] || { name: 'Pareja', gender: 'female' },
      event_type: 'personal_record',
      title: `🏆 ¡${profiles[1]?.name || 'Pareja'} ha batido un récord personal!`,
      description: 'Chest Fly (Machine): 104.5 kg (1RM Epley)',
      emoji: '🏆',
      created_at: 'Hace 5 horas',
      reactions: [{ id: 'r2', emoji: '👏', count: 2 }],
    },
  ]);

  const handleReaction = (eventId, emoji) => {
    setFeedEvents((prev) =>
      prev.map((event) => {
        if (event.id === eventId) {
          const existing = event.reactions.find((r) => r.emoji === emoji);
          let newReactions;
          if (existing) {
            newReactions = event.reactions.map((r) =>
              r.emoji === emoji ? { ...r, count: r.count + 1 } : r
            );
          } else {
            newReactions = [...event.reactions, { id: Date.now().toString(), emoji, count: 1 }];
          }
          return { ...event, reactions: newReactions };
        }
        return event;
      })
    );
    if (setToastMessage) {
      setToastMessage('Reacción enviada');
    }
  };

  return (
    <div className="space-y-4 pb-4">
      <div className="health-card bg-gradient-to-r from-indigo-50 to-pink-50 border-indigo-100 p-4 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="flex -space-x-2">
            <Avatar profile={profiles[0]} size="md" />
            <Avatar profile={profiles[1]} size="md" />
          </div>
          <div>
            <h2 className="text-sm font-bold text-slate-900 flex items-center gap-1.5">
              Couple Glow Up Feed <Heart className="w-3.5 h-3.5 text-rose-500 fill-rose-500" />
            </h2>
            <p className="text-[11px] text-slate-500 font-medium">
              Muro compartido de logros, entrenamientos y comidas
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-3">
        {feedEvents.map((event) => (
          <div key={event.id} className="health-card p-4 space-y-3">
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3">
                <Avatar profile={event.profile} size="md" />
                <div>
                  <h4 className="text-xs font-bold text-slate-900">{event.title}</h4>
                  <span className="text-[10px] text-slate-400 font-medium">{event.created_at}</span>
                </div>
              </div>
              <span className="text-xl p-1 bg-slate-100 rounded-xl border border-slate-200">
                {event.emoji}
              </span>
            </div>

            <p className="text-xs text-slate-700 bg-slate-50 p-2.5 rounded-xl border border-slate-200 font-mono">
              {event.description}
            </p>

            <div className="flex items-center justify-between pt-1">
              <div className="flex items-center gap-1.5">
                {event.reactions.map((r) => (
                  <span key={r.id} className="px-2.5 py-0.5 rounded-full bg-slate-100 border border-slate-200 text-xs text-slate-700 font-medium">
                    {r.emoji} <span className="text-[10px] font-bold text-indigo-600">{r.count}</span>
                  </span>
                ))}
              </div>

              <div className="flex items-center gap-1">
                {['❤️', '🔥', '👏', '💪'].map((emoji) => (
                  <button
                    key={emoji}
                    onClick={() => handleReaction(event.id, emoji)}
                    className="p-1 hover:bg-slate-100 rounded-lg text-sm transition-transform active:scale-125"
                  >
                    {emoji}
                  </button>
                ))}
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
