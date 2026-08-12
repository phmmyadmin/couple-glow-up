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
      title: `${profiles[0]?.name || 'Pablo'} completed a workout`,
      description: 'Push Day · 45 min · 7,553 kg total volume',
      emoji: '🏋️',
      created_at: new Date(Date.now() - 7200000).toISOString(),
      feed_reactions: [{ id: 'r1', emoji: '🔥', count: 1 }],
    },
    {
      id: '2',
      profile: profiles[1] || { name: 'Partner', gender: 'female' },
      event_type: 'personal_record',
      title: `🏆 ${profiles[1]?.name || 'Partner'} set a new personal record!`,
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
      title: `${activeProfile?.name || 'Partner'} posted a note`,
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
        profile: activeProfile || { name: 'Me' },
        created_at: new Date().toISOString(),
        feed_reactions: [],
      };
      setFeedEvents((prev) => [localEvent, ...prev]);
    }

    setNoteInput('');
    if (setToastMessage) {
      setToastMessage('Note posted to wall');
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
      setToastMessage('Reaction sent');
    }
  };

  return (
    <div className="space-y-6 sm:space-y-7 pb-6">
      {/* Feed Header Banner Card */}
      <Card className="bg-gradient-to-r from-indigo-50/90 via-purple-50/90 to-pink-50/90 border-indigo-100 p-5 sm:p-6 flex items-center justify-between shadow-sm">
        <div className="flex items-center gap-4">
          <div className="flex -space-x-2">
            <Avatar profile={profiles[0]} size="md" />
            <Avatar profile={profiles[1]} size="md" />
          </div>
          <div>
            <h2 className="text-base sm:text-lg font-bold text-slate-900 flex items-center gap-2">
              <span>Couple Glow Up Feed</span>
              <Heart className="w-4.5 h-4.5 text-rose-500 fill-rose-500" />
            </h2>
            <p className="text-xs sm:text-sm text-slate-500 font-semibold mt-0.5">
              Shared wall for workouts, shopping & partner achievements
            </p>
          </div>
        </div>
      </Card>

      {/* Quick Note Post Input */}
      <Card className="p-4 sm:p-5 shadow-sm">
        <form onSubmit={handlePostNote} className="flex gap-3">
          <Input
            type="text"
            placeholder="Write a note or message for your partner..."
            aria-label="Write note"
            value={noteInput}
            onChange={(e) => setNoteInput(e.target.value)}
            className="flex-1"
          />
          <Button type="submit" icon={Send} variant="primary" className="shrink-0">
            Post
          </Button>
        </form>
      </Card>

      {/* Feed Stream */}
      <div className="space-y-5 sm:space-y-6">
        {isLoading && feedEvents.length === 0 ? (
          <div className="space-y-4">
            <Skeleton className="h-32 w-full" />
            <Skeleton className="h-32 w-full" />
          </div>
        ) : feedEvents.length === 0 ? (
          <Card className="text-center py-12 space-y-3">
            <MessageSquare className="w-12 h-12 text-slate-300 mx-auto" />
            <p className="text-sm text-slate-500 font-medium">No posts on the wall yet. Write the first one above!</p>
          </Card>
        ) : (
          feedEvents.map((event) => {
            const profile = event.profiles || event.profile;
            const timeAgo = new Date(event.created_at).toLocaleTimeString('en-US', {
              hour: '2-digit',
              minute: '2-digit',
            });

            return (
              <Card key={event.id} className="p-5 sm:p-6 space-y-4 shadow-sm">
                <div className="flex items-start justify-between gap-3">
                  <div className="flex items-center gap-3.5">
                    <Avatar profile={profile} size="md" />
                    <div>
                      <h4 className="text-base font-bold text-slate-900">{event.title}</h4>
                      <span className="text-xs text-slate-400 font-medium">{timeAgo}</span>
                    </div>
                  </div>
                  <span className="text-2xl p-2 bg-slate-100/80 rounded-2xl border border-slate-200 shrink-0">
                    {event.emoji}
                  </span>
                </div>

                <p className="text-xs sm:text-sm text-slate-700 bg-slate-50/90 p-4 rounded-2xl border border-slate-200/80 font-mono font-semibold">
                  {event.description}
                </p>

                <div className="flex items-center justify-between pt-2">
                  <div className="flex items-center gap-2">
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
                        aria-label={`React with ${emoji}`}
                        className="p-2 hover:bg-slate-100 rounded-xl text-base transition-transform active:scale-125"
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
