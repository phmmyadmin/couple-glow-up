import React, { useState, useEffect } from 'react';
import { Heart, Send, MessageSquare } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import Avatar from '../../shared/Avatar';
import Card from '../../shared/ui/Card';
import Button from '../../shared/ui/Button';
import { Input } from '../../shared/ui/Input';
import Skeleton from '../../shared/ui/Skeleton';
import {
  fetchFeedEventsFromSupabase,
  createFeedEventInSupabase,
  addFeedReactionInSupabase,
  subscribeToFeedEvents,
} from './lib/supabase-feed';

export default function FeedApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [noteInput, setNoteInput] = useState('');
  const [isLoading, setIsLoading] = useState(true);

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
      setIsLoading(true);
      const dbEvents = await fetchFeedEventsFromSupabase();
      if (dbEvents && dbEvents.length > 0) {
        setFeedEvents(dbEvents);
      }
      setIsLoading(false);
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
      setFeedEvents((prev) => [saved, ...prev.filter((e) => e.id !== saved.id)]);
    } else {
      const localEvent = {
        ...newEventObj,
        id: `local-${Date.now()}`,
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
            newReactions = [...reactions, { id: `react-${Date.now()}`, emoji, count: 1 }];
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
      {/* Feed Header Banner Card */}
      <Card className="bg-gradient-to-r from-indigo-50/90 via-purple-50/90 to-pink-50/90 border-indigo-100 p-5 flex items-center justify-between">
        <div className="flex items-center gap-3.5">
          <div className="flex -space-x-2">
            <Avatar profile={profiles[0]} size="md" />
            <Avatar profile={profiles[1]} size="md" />
          </div>
          <div>
            <h2 className="text-base font-bold text-slate-900 flex items-center gap-1.5">
              <span>Couple Glow Up Feed</span>
              <Heart className="w-4 h-4 text-rose-500 fill-rose-500" />
            </h2>
            <p className="text-xs text-slate-500 font-semibold mt-0.5">
              Muro compartido de entrenamientos, compras y logros en pareja
            </p>
          </div>
        </div>
      </Card>

      {/* Quick Note Post Input */}
      <Card className="p-3.5">
        <form onSubmit={handlePostNote} className="flex gap-2">
          <Input
            type="text"
            placeholder="Escribe una nota o mensaje para tu pareja..."
            aria-label="Escribir nota"
            value={noteInput}
            onChange={(e) => setNoteInput(e.target.value)}
            className="flex-1"
          />
          <Button type="submit" icon={Send} variant="primary">
            Publicar
          </Button>
        </form>
      </Card>

      {/* Feed Stream */}
      <div className="space-y-3">
        {isLoading && feedEvents.length === 0 ? (
          <div className="space-y-3">
            <Skeleton className="h-28 w-full" />
            <Skeleton className="h-28 w-full" />
          </div>
        ) : feedEvents.length === 0 ? (
          <Card className="text-center py-10 space-y-2">
            <MessageSquare className="w-10 h-10 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">Aún no hay publicaciones en el muro. ¡Escribe la primera arriba!</p>
          </Card>
        ) : (
          feedEvents.map((event) => {
            const profile = event.profiles || event.profile;
            const timeAgo = new Date(event.created_at).toLocaleTimeString('es-ES', {
              hour: '2-digit',
              minute: '2-digit',
            });

            return (
              <Card key={event.id} className="p-4 sm:p-5 space-y-3">
                <div className="flex items-start justify-between">
                  <div className="flex items-center gap-3">
                    <Avatar profile={profile} size="md" />
                    <div>
                      <h4 className="text-sm font-bold text-slate-900">{event.title}</h4>
                      <span className="text-xs text-slate-400 font-medium">{timeAgo}</span>
                    </div>
                  </div>
                  <span className="text-2xl p-1.5 bg-slate-100/80 rounded-2xl border border-slate-200">
                    {event.emoji}
                  </span>
                </div>

                <p className="text-xs sm:text-sm text-slate-700 bg-slate-50/80 p-3 rounded-xl border border-slate-200/80 font-mono font-medium">
                  {event.description}
                </p>

                <div className="flex items-center justify-between pt-1">
                  <div className="flex items-center gap-1.5">
                    {(event.feed_reactions || []).map((r) => (
                      <span
                        key={r.id || Math.random()}
                        className="px-3 py-1 rounded-full bg-slate-100 border border-slate-200 text-xs text-slate-700 font-semibold"
                      >
                        {r.emoji} <span className="text-xs font-extrabold text-indigo-600">{r.count || 1}</span>
                      </span>
                    ))}
                  </div>

                  <div className="flex items-center gap-1">
                    {['❤️', '🔥', '👏', '💪'].map((emoji) => (
                      <button
                        key={emoji}
                        onClick={() => handleReaction(event.id, emoji)}
                        aria-label={`Reaccionar con ${emoji}`}
                        className="p-1.5 hover:bg-slate-100 rounded-xl text-base transition-transform active:scale-125"
                      >
                        {emoji}
                      </button>
                    ))}
                  </div>
                </div>
              </Card>
            );
          })
        )}
      </div>
    </div>
  );
}
