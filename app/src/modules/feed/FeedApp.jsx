import React, { useState, useEffect } from 'react';
import { Heart, Sparkles, Send } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import Avatar from '../../shared/Avatar';
import {
  fetchFeedEventsFromSupabase,
  createFeedEventInSupabase,
  addFeedReactionInSupabase,
  subscribeToFeedEvents,
} from './lib/supabase-feed';

export default function FeedApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [noteInput, setNoteInput] = useState('');

  const [feedEvents, setFeedEvents] = useState([
    {
      id: '1',
      profile: profiles[0] || { name: 'Pablo', gender: 'male' },
      event_type: 'workout_completed',
      title: `${profiles[0]?.name || 'Pablo'} ha completado un entrenamiento`,
      description: 'Push Day · 45 min · 7,553 kg volumen',
      emoji: '🏋️',
      created_at: new Date(Date.now() - 7200000).toISOString(),
      feed_reactions: [{ id: 'r1', emoji: '🔥', count: 1 }],
    },
    {
      id: '2',
      profile: profiles[1] || { name: 'Pareja', gender: 'female' },
      event_type: 'personal_record',
      title: `🏆 ¡${profiles[1]?.name || 'Pareja'} ha batido un récord personal!`,
      description: 'Chest Fly (Machine): 104.5 kg (1RM Epley)',
      emoji: '🏆',
      created_at: new Date(Date.now() - 18000000).toISOString(),
      feed_reactions: [{ id: 'r2', emoji: '👏', count: 2 }],
    },
  ]);

  useEffect(() => {
    async function loadFeed() {
      const dbEvents = await fetchFeedEventsFromSupabase();
      if (dbEvents && dbEvents.length > 0) {
        setFeedEvents(dbEvents);
      }
    }
    loadFeed();

    const unsubscribe = subscribeToFeedEvents(async () => {
      const updatedEvents = await fetchFeedEventsFromSupabase();
      if (updatedEvents && updatedEvents.length > 0) {
        setFeedEvents(updatedEvents);
      }
    });

    return () => unsubscribe();
  }, []);

  const handlePostNote = async (e) => {
    e.preventDefault();
    if (!noteInput.trim()) return;

    const newEventObj = {
      profile_id: activeProfile?.id || null,
      event_type: 'note',
      title: `${activeProfile?.name || 'Pareja'} ha compartido una nota`,
      description: noteInput.trim(),
      emoji: '💬',
    };

    const saved = await createFeedEventInSupabase(newEventObj);
    if (saved) {
      setFeedEvents((prev) => [saved, ...prev]);
    } else {
      const localEvent = {
        ...newEventObj,
        id: Date.now().toString(),
        profile: activeProfile || { name: 'Yo' },
        created_at: new Date().toISOString(),
        feed_reactions: [],
      };
      setFeedEvents((prev) => [localEvent, ...prev]);
    }

    setNoteInput('');
    if (setToastMessage) {
      setToastMessage('Nota publicada en el muro');
    }
  };

  const handleReaction = async (eventId, emoji) => {
    // Optimistic update
    setFeedEvents((prev) =>
      prev.map((event) => {
        if (event.id === eventId) {
          const reactions = event.feed_reactions || [];
          const existing = reactions.find((r) => r.emoji === emoji);
          let newReactions;
          if (existing) {
            newReactions = reactions.map((r) =>
              r.emoji === emoji ? { ...r, count: (r.count || 1) + 1 } : r
            );
          } else {
            newReactions = [...reactions, { id: Date.now().toString(), emoji, count: 1 }];
          }
          return { ...event, feed_reactions: newReactions };
        }
        return event;
      })
    );

    if (activeProfile?.id) {
      await addFeedReactionInSupabase(eventId, emoji, activeProfile.id);
    }

    if (setToastMessage) {
      setToastMessage('Reacción enviada');
    }
  };

  return (
    <div className="space-y-4 pb-4">
      {/* Feed Header */}
      <div className="health-card bg-gradient-to-r from-indigo-50 via-purple-50 to-pink-50 border-indigo-100 p-4 flex items-center justify-between">
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
              Muro compartido de entrenamientos, compras y récords
            </p>
          </div>
        </div>
      </div>

      {/* Quick Note Post Input */}
      <form onSubmit={handlePostNote} className="health-card p-3 flex gap-2">
        <input
          type="text"
          placeholder="Escribe un mensaje o nota para la pareja..."
          value={noteInput}
          onChange={(e) => setNoteInput(e.target.value)}
          className="edit-input flex-1 text-xs"
        />
        <button
          type="submit"
          className="px-3 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl text-xs font-semibold shadow-sm flex items-center gap-1 active:scale-95 transition-all"
        >
          <Send className="w-3.5 h-3.5" />
        </button>
      </form>

      {/* Feed Stream */}
      <div className="space-y-3">
        {feedEvents.map((event) => {
          const profile = event.profiles || event.profile;
          const timeAgo = new Date(event.created_at).toLocaleTimeString('es-ES', {
            hour: '2-digit',
            minute: '2-digit',
          });

          return (
            <div key={event.id} className="health-card p-4 space-y-3">
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-3">
                  <Avatar profile={profile} size="md" />
                  <div>
                    <h4 className="text-xs font-bold text-slate-900">{event.title}</h4>
                    <span className="text-[10px] text-slate-400 font-medium">{timeAgo}</span>
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
                  {(event.feed_reactions || []).map((r) => (
                    <span
                      key={r.id || Math.random()}
                      className="px-2.5 py-0.5 rounded-full bg-slate-100 border border-slate-200 text-xs text-slate-700 font-medium"
                    >
                      {r.emoji} <span className="text-[10px] font-bold text-indigo-600">{r.count || 1}</span>
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
          );
        })}
      </div>
    </div>
  );
}
