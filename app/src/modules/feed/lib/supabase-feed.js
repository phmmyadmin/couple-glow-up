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
        onChange(payload);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}

export async function deleteFeedEventFromSupabase(eventId) {
  if (!supabase) return false;
  try {
    const { error } = await supabase
      .from('feed_events')
      .delete()
      .eq('id', eventId);

    if (error) throw error;
    return true;
  } catch (err) {
    console.error('Error deleting feed event:', err);
    return false;
  }
}

