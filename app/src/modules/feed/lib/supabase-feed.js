import { supabase } from '../../../lib/supabase';

export async function fetchFeedEventsFromSupabase() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('feed_events')
      .select('*, profiles(*), feed_reactions(*)')
      .order('created_at', { ascending: false })
      .limit(30);

    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching feed events:', err);
    return [];
  }
}

export async function createFeedEventInSupabase(eventObj) {
  if (!supabase) return null;
  try {
    const { data, error } = await supabase
      .from('feed_events')
      .insert(eventObj)
      .select('*, profiles(*)')
      .single();

    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error creating feed event:', err);
    return null;
  }
}

export async function addFeedReactionInSupabase(eventId, emoji, profileId) {
  if (!supabase) return null;
  try {
    const { data, error } = await supabase
      .from('feed_reactions')
      .upsert({ event_id: eventId, profile_id: profileId, emoji }, { onConflict: 'event_id,profile_id' })
      .select()
      .single();

    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error adding reaction:', err);
    return null;
  }
}

export function subscribeToFeedEvents(onChange) {
  if (!supabase) return () => {};

  const channel = supabase
    .channel('couple_feed_live')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'feed_events',
      },
      (payload) => {
        // Trigger push notification if new event is from partner
        if (payload.eventType === 'INSERT' && payload.new) {
          const newEv = payload.new;
          const activeProfileId = localStorage.getItem('fit_active_profile_id');

          if (activeProfileId && newEv.profile_id && newEv.profile_id !== activeProfileId) {
            if ('Notification' in window && Notification.permission === 'granted') {
              const title = newEv.title || 'Couple Glow Up ✨';
              const body = newEv.description || 'New feed update';

              if (navigator.serviceWorker) {
                navigator.serviceWorker.ready.then((reg) => {
                  reg.showNotification(title, {
                    body,
                    icon: '/favicon.svg',
                    badge: '/favicon.svg',
                    tag: `feed-${newEv.id}`,
                    vibrate: [100, 50, 100],
                    data: { url: './' },
                  });
                }).catch(() => {
                  new Notification(title, { body, icon: '/favicon.svg' });
                });
              } else {
                new Notification(title, { body, icon: '/favicon.svg' });
              }
            }
          }
        }

        if (onChange) onChange(payload);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}

export async function deleteFeedEventFromSupabase(eventId) {
  if (!supabase || !eventId) return false;
  try {
    if (typeof eventId === 'string' && (eventId === '1' || eventId === '2' || eventId.startsWith('local-'))) {
      return true;
    }

    const { error } = await supabase
      .from('feed_events')
      .delete()
      .eq('id', eventId);

    if (error) {
      console.error('Error deleting feed_event from Supabase:', error);
      throw error;
    }
    return true;
  } catch (err) {
    console.error('Error deleting feed event:', err);
    return false;
  }
}

