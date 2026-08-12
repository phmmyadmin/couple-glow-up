import React, { useState, useEffect } from 'react';
import { ShoppingCart, Store, Tag } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import ShoppingList from './components/ShoppingList';
import MarketManager from './components/MarketManager';
import PriceComparator from './components/PriceComparator';

import {
  fetchOrCreateActiveList,
  fetchShoppingItems,
  addShoppingItemToSupabase,
  toggleShoppingItemInSupabase,
  deleteShoppingItemFromSupabase,
  fetchMarkets,
  saveMarket,
  deleteMarketFromSupabase,
  fetchProductPrices,
  saveProductPrice,
  subscribeToShoppingItems,
} from './lib/supabase-shopping';

export default function ShoppingApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [shopTab, setShopTab] = useState('list'); // 'list', 'markets', 'prices'

  const [activeList, setActiveList] = useState(null);
  const [items, setItems] = useState([
    {
      id: 'm1',
      name: 'Pechuga de pollo',
      quantity: 1,
      unit: 'kg',
      category: 'carnes',
      is_checked: false,
      added_by: profiles[0]?.id || null,
    },
    {
      id: 'm2',
      name: 'Aguacates',
      quantity: 3,
      unit: 'ud',
      category: 'frutas',
      is_checked: true,
      checked_by: profiles[1]?.id || null,
    },
  ]);

  const [markets, setMarkets] = useState([
    { id: 'mk1', name: 'Mercadona', emoji: '🏪', address: 'Localidad' },
    { id: 'mk2', name: 'Wet Market', emoji: '🥦', address: 'Mercado local' },
  ]);

  const [productPrices, setProductPrices] = useState([
    {
      id: 'pr1',
      product_name: 'Pechuga de pollo',
      market_id: 'mk1',
      price: 6.95,
      currency: 'EUR',
      unit: 'kg',
      markets: { name: 'Mercadona', emoji: '🏪' },
    },
    {
      id: 'pr2',
      product_name: 'Pechuga de pollo',
      market_id: 'mk2',
      price: 5.50,
      currency: 'EUR',
      unit: 'kg',
      markets: { name: 'Wet Market', emoji: '🥦' },
    },
  ]);

  // Load data from Supabase if connected
  useEffect(() => {
    async function loadData() {
      const list = await fetchOrCreateActiveList();
      if (list) {
        setActiveList(list);
        const dbItems = await fetchShoppingItems(list.id);
        if (dbItems && dbItems.length > 0) {
          setItems(dbItems);
        }
      }

      const dbMarkets = await fetchMarkets();
      if (dbMarkets && dbMarkets.length > 0) {
        setMarkets(dbMarkets);
      }

      const dbPrices = await fetchProductPrices();
      if (dbPrices && dbPrices.length > 0) {
        setProductPrices(dbPrices);
      }
    }

    loadData();
  }, []);

  // Realtime subscription for shopping items
  useEffect(() => {
    if (!activeList) return;

    const unsubscribe = subscribeToShoppingItems(activeList.id, async () => {
      const updatedItems = await fetchShoppingItems(activeList.id);
      if (updatedItems) {
        setItems(updatedItems);
      }
    });

    return () => unsubscribe();
  }, [activeList]);

  // ── ITEM ACTIONS ──
  const handleAddItem = async (newItem) => {
    const itemWithList = {
      ...newItem,
      list_id: activeList?.id || null,
    };

    const saved = await addShoppingItemToSupabase(itemWithList);
    if (saved) {
      setItems((prev) => [saved, ...prev]);
    } else {
      // Local fallback
      const localItem = {
        ...newItem,
        id: Date.now().toString(),
      };
      setItems((prev) => [localItem, ...prev]);
    }

    if (setToastMessage) {
      setToastMessage('Producto añadido a la lista');
    }
  };

  const handleToggleItem = async (itemId, isChecked) => {
    // Optimistic UI update
    setItems((prev) =>
      prev.map((i) =>
        i.id === itemId
          ? {
              ...i,
              is_checked: isChecked,
              checked_by: isChecked ? activeProfile?.id || null : null,
            }
          : i
      )
    );

    await toggleShoppingItemInSupabase(itemId, isChecked, activeProfile?.id);
  };

  const handleDeleteItem = async (itemId) => {
    setItems((prev) => prev.filter((i) => i.id !== itemId));
    await deleteShoppingItemFromSupabase(itemId);
    if (setToastMessage) {
      setToastMessage('Producto eliminado');
    }
  };

  // ── MARKET ACTIONS ──
  const handleSaveMarket = async (marketObj) => {
    const saved = await saveMarket(marketObj);
    if (saved) {
      setMarkets((prev) => [...prev.filter((m) => m.id !== saved.id), saved]);
    } else {
      const local = { ...marketObj, id: Date.now().toString() };
      setMarkets((prev) => [...prev, local]);
    }
    if (setToastMessage) {
      setToastMessage('Tienda guardada');
    }
  };

  const handleDeleteMarket = async (marketId) => {
    setMarkets((prev) => prev.filter((m) => m.id !== marketId));
    await deleteMarketFromSupabase(marketId);
    if (setToastMessage) {
      setToastMessage('Tienda eliminada');
    }
  };

  // ── PRICE ACTIONS ──
  const handleSavePrice = async (priceObj) => {
    const saved = await saveProductPrice(priceObj);
    const targetMarket = markets.find((m) => m.id === priceObj.market_id);
    const priceWithRel = saved
      ? { ...saved, markets: targetMarket }
      : { ...priceObj, id: Date.now().toString(), markets: targetMarket };

    setProductPrices((prev) => [...prev.filter((p) => p.id !== priceWithRel.id), priceWithRel]);
    if (setToastMessage) {
      setToastMessage('Precio registrado');
    }
  };

  return (
    <div className="space-y-4">
      {/* Sub navigation */}
      <div className="bg-slate-900/60 backdrop-blur-md rounded-2xl p-3 border border-slate-800/80 shadow-lg">
        <div className="grid grid-cols-3 gap-1 bg-slate-950/60 p-1 rounded-xl border border-slate-800/50">
          <button
            onClick={() => setShopTab('list')}
            className={`flex items-center justify-center gap-1.5 py-2 px-3 rounded-lg text-xs font-medium transition-all ${
              shopTab === 'list'
                ? 'bg-gradient-to-r from-amber-500 to-orange-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <ShoppingCart className="w-3.5 h-3.5" />
            <span>Lista Activa</span>
          </button>

          <button
            onClick={() => setShopTab('markets')}
            className={`flex items-center justify-center gap-1.5 py-2 px-3 rounded-lg text-xs font-medium transition-all ${
              shopTab === 'markets'
                ? 'bg-gradient-to-r from-amber-500 to-orange-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <Store className="w-3.5 h-3.5" />
            <span>Mercados ({markets.length})</span>
          </button>

          <button
            onClick={() => setShopTab('prices')}
            className={`flex items-center justify-center gap-1.5 py-2 px-3 rounded-lg text-xs font-medium transition-all ${
              shopTab === 'prices'
                ? 'bg-gradient-to-r from-amber-500 to-orange-600 text-white shadow-md'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            <Tag className="w-3.5 h-3.5" />
            <span>Precios</span>
          </button>
        </div>
      </div>

      {/* Tab Views */}
      {shopTab === 'list' && (
        <ShoppingList
          items={items}
          onAddItem={handleAddItem}
          onToggleItem={handleToggleItem}
          onDeleteItem={handleDeleteItem}
          activeProfile={activeProfile}
          profiles={profiles}
          markets={markets}
        />
      )}

      {shopTab === 'markets' && (
        <MarketManager
          markets={markets}
          onSaveMarket={handleSaveMarket}
          onDeleteMarket={handleDeleteMarket}
        />
      )}

      {shopTab === 'prices' && (
        <PriceComparator
          markets={markets}
          productPrices={productPrices}
          onSavePrice={handleSavePrice}
        />
      )}
    </div>
  );
}
