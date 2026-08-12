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
      <div className="bg-gradient-to-r from-pink-500/10 via-rose-500/10 to-amber-500/10 border border-pink-500/20 rounded-3xl p-4 flex items-center justify-between shadow-lg">
        <div className="flex items-center gap-3">
          <div className="flex -space-x-2">
            <Avatar profile={profiles[0]} size="md" />
            <Avatar profile={profiles[1]} size="md" />
          </div>
          <div>
            <h2 className="text-sm font-bold text-white flex items-center gap-1.5">
              Couple Glow Up Feed <Heart className="w-3.5 h-3.5 text-pink-400 fill-pink-400" />
            </h2>
            <p className="text-[11px] text-slate-400">
              Muro compartido de logros, entrenamientos y comidas
            </p>
          </div>
        </div>
      </div>

      <div className="space-y-3">
        {feedEvents.map((event) => (
          <div
            key={event.id}
            className="bg-slate-900/70 backdrop-blur-md border border-slate-800/80 rounded-2xl p-4 space-y-3 shadow-lg"
          >
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3">
                <Avatar profile={event.profile} size="md" />
                <div>
                  <h4 className="text-xs font-semibold text-slate-200">{event.title}</h4>
                  <span className="text-[10px] text-slate-400">{event.created_at}</span>
                </div>
              </div>
              <span className="text-xl p-1 bg-slate-800/50 rounded-xl border border-slate-700/40">
                {event.emoji}
              </span>
            </div>

            <p className="text-xs text-slate-300 bg-slate-950/50 p-2.5 rounded-xl border border-slate-800/40 font-mono">
              {event.description}
            </p>

            <div className="flex items-center justify-between pt-1">
              <div className="flex items-center gap-1.5">
                {event.reactions.map((r) => (
                  <span key={r.id} className="px-2 py-0.5 rounded-full bg-slate-800 text-xs text-slate-300">
                    {r.emoji} <span className="text-[10px] font-bold text-pink-400">{r.count}</span>
                  </span>
                ))}
              </div>

              <div className="flex items-center gap-1">
                {['❤️', '🔥', '👏', '💪'].map((emoji) => (
                  <button
                    key={emoji}
                    onClick={() => handleReaction(event.id, emoji)}
                    className="p-1 hover:bg-slate-800 rounded text-sm"
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
