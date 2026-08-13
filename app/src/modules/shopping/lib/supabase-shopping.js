import { supabase } from '../../../lib/supabase';

// ── MARKETS ──
export async function fetchMarkets() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('markets')
      .select('*')
      .order('name', { ascending: true });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching markets:', err);
    return [];
  }
}

export async function saveMarket(market) {
  if (!supabase) return null;
  try {
    if (!market.id) {
      const { data, error } = await supabase
        .from('markets')
        .insert(market)
        .select()
        .single();
      if (error) throw error;
      return data;
    } else {
      const { data, error } = await supabase
        .from('markets')
        .update(market)
        .eq('id', market.id)
        .select()
        .single();
      if (error) throw error;
      return data;
    }
  } catch (err) {
    console.error('Error saving market:', err);
    return null;
  }
}

export async function deleteMarketFromSupabase(id) {
  if (!supabase || !id) return false;
  try {
    // If local mock ID, no DB deletion needed
    if (typeof id === 'string' && id.startsWith('mk')) {
      return true;
    }

    // 1. Delete associated product prices for this market
    const { error: pricesErr } = await supabase
      .from('product_prices')
      .delete()
      .eq('market_id', id);

    if (pricesErr) {
      console.warn('Warning deleting product_prices for market:', pricesErr);
    }

    // 2. Delete market record
    const { data, error } = await supabase
      .from('markets')
      .delete()
      .eq('id', id)
      .select();

    if (error) {
      console.error('Supabase error deleting market:', error);
      throw error;
    }

    console.log('Market deleted from Supabase:', data);
    return true;
  } catch (err) {
    console.error('Error deleting market from Supabase:', err);
    return false;
  }
}


// ── SHOPPING LIST & ITEMS ──
export async function fetchOrCreateActiveList() {
  if (!supabase) return null;
  try {
    const { data, error } = await supabase
      .from('shopping_lists')
      .select('*')
      .eq('is_active', true)
      .order('created_at', { ascending: false })
      .limit(1);

    if (error) throw error;

    if (data && data.length > 0) {
      return data[0];
    }

    // Create default active list
    const { data: newList, error: createErr } = await supabase
      .from('shopping_lists')
      .insert({ name: 'Lista de la compra', is_active: true })
      .select()
      .single();

    if (createErr) throw createErr;
    return newList;
  } catch (err) {
    console.error('Error fetching/creating active shopping list:', err);
    return null;
  }
}

export async function fetchShoppingItems(listId) {
  if (!supabase || !listId) return [];
  try {
    const { data, error } = await supabase
      .from('shopping_items')
      .select('*, products(*)')
      .eq('list_id', listId)
      .order('is_checked', { ascending: true })
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching shopping items:', err);
    return [];
  }
}

export async function addShoppingItemToSupabase(item) {
  if (!supabase) return null;
  try {
    const { data, error } = await supabase
      .from('shopping_items')
      .insert(item)
      .select('*, products(*)')
      .single();
    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error adding shopping item:', err);
    return null;
  }
}

export async function toggleShoppingItemInSupabase(itemId, isChecked, profileId) {
  if (!supabase) return null;
  try {
    const payload = {
      is_checked: isChecked,
      checked_by: isChecked ? profileId : null,
      checked_at: isChecked ? new Date().toISOString() : null,
    };

    const { data, error } = await supabase
      .from('shopping_items')
      .update(payload)
      .eq('id', itemId)
      .select()
      .single();

    if (error) throw error;
    return data;
  } catch (err) {
    console.error('Error toggling shopping item:', err);
    return null;
  }
}

export async function deleteShoppingItemFromSupabase(itemId) {
  if (!supabase) return false;
  try {
    const { error } = await supabase.from('shopping_items').delete().eq('id', itemId);
    if (error) throw error;
    return true;
  } catch (err) {
    console.error('Error deleting shopping item:', err);
    return false;
  }
}


// ── PRODUCTS & PRICES ──
export async function fetchProducts() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('products')
      .select('*')
      .order('name', { ascending: true });
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching products:', err);
    return [];
  }
}

export async function fetchProductPrices() {
  if (!supabase) return [];
  try {
    const { data, error } = await supabase
      .from('product_prices')
      .select('*, products(*), markets(*)');
    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error('Error fetching product prices:', err);
    return [];
  }
}

export async function saveProductPrice(priceObj) {
  if (!supabase) return null;
  try {
    if (!priceObj.id) {
      const { data, error } = await supabase
        .from('product_prices')
        .insert(priceObj)
        .select('*, markets(*)')
        .single();
      if (error) throw error;
      return data;
    } else {
      const { data, error } = await supabase
        .from('product_prices')
        .update(priceObj)
        .eq('id', priceObj.id)
        .select('*, markets(*)')
        .single();
      if (error) throw error;
      return data;
    }
  } catch (err) {
    console.error('Error saving product price:', err);
    return null;
  }
}

export async function deleteProductPriceFromSupabase(priceId) {
  if (!supabase || !priceId) return false;
  try {
    const { error } = await supabase.from('product_prices').delete().eq('id', priceId);
    if (error) throw error;
    return true;
  } catch (err) {
    console.error('Error deleting product price:', err);
    return false;
  }
}

// ── REALTIME SUBSCRIPTION HELPER ──
export function subscribeToShoppingItems(listId, onChange) {
  if (!supabase || !listId) return () => {};

  const channel = supabase
    .channel(`shopping_list_${listId}`)
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'shopping_items',
        filter: `list_id=eq.${listId}`,
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
