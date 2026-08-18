import React, { useState, useEffect } from 'react';
import { ShoppingCart, Store, Tag } from 'lucide-react';
import { useTranslation } from 'react-i18next';

import ShoppingList from './components/ShoppingList';
import MarketManager from './components/MarketManager';
import PriceComparator from './components/PriceComparator';
import Tabs from '../../shared/ui/Tabs';

import {
  fetchOrCreateActiveList,
  fetchShoppingItems,
  addShoppingItemToSupabase,
  toggleShoppingItemInSupabase,
  deleteShoppingItemFromSupabase,
  updateShoppingItemInSupabase,
  updateProductNameAndPricesInSupabase,
  fetchMarkets,
  saveMarket,
  deleteMarketFromSupabase,
  fetchProductPrices,
  saveProductPrice,
  deleteProductPriceFromSupabase,
  subscribeToShoppingItems,
  subscribeToProductPrices,
  subscribeToMarkets,
} from './lib/supabase-shopping';
import { createFeedEventInSupabase } from '../feed/lib/supabase-feed';

export default function ShoppingApp({ activeProfile, profiles, setToastMessage }) {
  const { t } = useTranslation();
  const [shopTab, setShopTab] = useState(() => {
    return localStorage.getItem('glowup_shop_tab') || 'list';
  });

  const handleShopTabChange = (tab) => {
    setShopTab(tab);
    localStorage.setItem('glowup_shop_tab', tab);
  };

  const [activeList, setActiveList] = useState(null);
  const [items, setItems] = useState([
    {
      id: 'm1',
      name: 'Chicken breast',
      quantity: 1,
      unit: 'kg',
      category: 'carnes',
      is_checked: false,
      added_by: profiles[0]?.id || null,
    },
    {
      id: 'm2',
      name: 'Avocados',
      quantity: 3,
      unit: 'ud',
      category: 'frutas',
      is_checked: true,
      checked_by: profiles[1]?.id || null,
    },
  ]);

  const [markets, setMarkets] = useState([
    { id: 'mk1', name: 'Supermarket A', emoji: '🏪', address: 'Downtown' },
    { id: 'mk2', name: 'Wet Market', emoji: '🥦', address: 'Local market' },
  ]);

  const [productPrices, setProductPrices] = useState([
    {
      id: 'pr1',
      product_name: 'Chicken breast',
      market_id: 'mk1',
      price: 280,
      currency: 'PHP',
      unit: 'kg',
      markets: { name: 'Supermarket A', emoji: '🏪' },
    },
    {
      id: 'pr2',
      product_name: 'Chicken breast',
      market_id: 'mk2',
      price: 220,
      currency: 'PHP',
      unit: 'kg',
      markets: { name: 'Wet Market', emoji: '🥦' },
    },
  ]);

  useEffect(() => {
    async function loadData() {
      const list = await fetchOrCreateActiveList();
      if (list) {
        setActiveList(list);
        const dbItems = await fetchShoppingItems(list.id);
        if (Array.isArray(dbItems)) {
          setItems(dbItems);
        }
      }

      const dbMarkets = await fetchMarkets();
      if (Array.isArray(dbMarkets)) {
        setMarkets(dbMarkets);
      }

      const dbPrices = await fetchProductPrices();
      if (Array.isArray(dbPrices)) {
        setProductPrices(dbPrices);
      }
    }

    loadData();
  }, []);

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

  useEffect(() => {
    const unsubPrices = subscribeToProductPrices(async () => {
      const dbPrices = await fetchProductPrices();
      if (Array.isArray(dbPrices)) setProductPrices(dbPrices);
    });

    const unsubMarkets = subscribeToMarkets(async () => {
      const dbMarkets = await fetchMarkets();
      if (Array.isArray(dbMarkets)) setMarkets(dbMarkets);
    });

    return () => {
      unsubPrices();
      unsubMarkets();
    };
  }, []);

  const handleAddItem = async (newItem) => {
    const itemWithList = {
      ...newItem,
      list_id: activeList?.id || null,
    };

    const saved = await addShoppingItemToSupabase(itemWithList);
    if (saved) {
      setItems((prev) => [saved, ...prev]);
    } else {
      const localItem = {
        ...newItem,
        id: Date.now().toString(),
      };
      setItems((prev) => [localItem, ...prev]);
    }

    const qtyStr = newItem.quantity ? ` (${newItem.quantity} ${newItem.unit || 'ud'})` : '';
    await createFeedEventInSupabase({
      profile_id: activeProfile?.id || null,
      event_type: 'shopping_item_added',
      title: `🛒 ${activeProfile?.name || 'Partner'} added to shopping list`,
      description: `${newItem.name}${qtyStr}`,
      emoji: '🛒',
    });

    if (setToastMessage) {
      setToastMessage('Item added to list');
    }
  };

  const handleToggleItem = async (itemId, isChecked) => {
    const targetItem = items.find((i) => i.id === itemId);

    setItems((prev) => {
      const nextItems = prev.map((i) =>
        i.id === itemId
          ? {
              ...i,
              is_checked: isChecked,
              checked_by: isChecked ? activeProfile?.id || null : null,
            }
          : i
      );

      const remainingUnchecked = nextItems.filter((i) => !i.is_checked);
      if (isChecked && nextItems.length > 0 && remainingUnchecked.length === 0) {
        createFeedEventInSupabase({
          profile_id: activeProfile?.id || null,
          event_type: 'shopping_list_completed',
          title: `🎉 ${activeProfile?.name || 'Partner'} completed the shopping list!`,
          description: `All ${nextItems.length} items bought 🎉`,
          emoji: '🛍️',
        });
      }

      return nextItems;
    });

    await toggleShoppingItemInSupabase(itemId, isChecked, activeProfile?.id);

    if (isChecked && targetItem) {
      await createFeedEventInSupabase({
        profile_id: activeProfile?.id || null,
        event_type: 'shopping_item_checked',
        title: `✅ ${activeProfile?.name || 'Partner'} bought an item`,
        description: `Bought: ${targetItem.name}`,
        emoji: '✅',
      });
    }
  };

  const handleDeleteItem = async (itemId) => {
    const targetItem = items.find((i) => i.id === itemId);
    setItems((prev) => prev.filter((i) => i.id !== itemId));
    await deleteShoppingItemFromSupabase(itemId);

    if (targetItem) {
      await createFeedEventInSupabase({
        profile_id: activeProfile?.id || null,
        event_type: 'shopping_item_removed',
        title: `🗑️ ${activeProfile?.name || 'Partner'} removed an item from shopping list`,
        description: `Removed: ${targetItem.name}`,
        emoji: '🗑️',
      });
    }

    if (setToastMessage) {
      setToastMessage('Item deleted');
    }
  };

  const handleUpdateItem = async (itemId, itemPayload) => {
    const targetItem = items.find((i) => i.id === itemId);
    const oldName = targetItem?.name;

    setItems((prev) =>
      prev.map((i) => (i.id === itemId ? { ...i, ...itemPayload } : i))
    );

    await updateShoppingItemInSupabase(itemId, itemPayload);

    if (itemPayload.name && oldName && itemPayload.name !== oldName) {
      await updateProductNameAndPricesInSupabase(oldName, itemPayload.name, itemPayload.unit);
      const dbPrices = await fetchProductPrices();
      if (Array.isArray(dbPrices)) {
        setProductPrices(dbPrices);
      }
    }

    if (setToastMessage) {
      setToastMessage('Item updated');
    }
  };

  const handleRenameProduct = async (oldName, newName, newUnit) => {
    if (!oldName || !newName) return;

    setProductPrices((prev) =>
      prev.map((p) => {
        const pName = p.product_name || p.products?.name;
        if (pName && pName.toLowerCase().trim() === oldName.toLowerCase().trim()) {
          return {
            ...p,
            product_name: newName,
            unit: newUnit || p.unit,
          };
        }
        return p;
      })
    );

    setItems((prev) =>
      prev.map((i) => {
        if (i.name && i.name.toLowerCase().trim() === oldName.toLowerCase().trim()) {
          return {
            ...i,
            name: newName,
            unit: newUnit || i.unit,
          };
        }
        return i;
      })
    );

    await updateProductNameAndPricesInSupabase(oldName, newName, newUnit);

    if (setToastMessage) {
      setToastMessage('Product updated');
    }
  };

  const handleSaveMarket = async (marketObj) => {
    const saved = await saveMarket(marketObj);
    const finalMarket = saved || { ...marketObj, id: Date.now().toString() };
    setMarkets((prev) => [...prev.filter((m) => m.id !== finalMarket.id), finalMarket]);
    if (setToastMessage) {
      setToastMessage('Store saved successfully');
    }
    return finalMarket;
  };

  const handleDeleteMarket = async (marketId) => {
    setMarkets((prev) => prev.filter((m) => m.id !== marketId));
    setProductPrices((prev) => prev.filter((p) => p.market_id !== marketId && p.markets?.id !== marketId));
    await deleteMarketFromSupabase(marketId);
    if (setToastMessage) {
      setToastMessage('Store and associated prices deleted');
    }
  };

  const handleSavePrice = async (priceObj) => {
    const saved = await saveProductPrice(priceObj);
    const targetMarket = markets.find((m) => m.id === priceObj.market_id);
    const priceWithRel = saved
      ? { ...saved, markets: targetMarket }
      : { ...priceObj, id: Date.now().toString(), markets: targetMarket };

    setProductPrices((prev) => [...prev.filter((p) => p.id !== priceWithRel.id), priceWithRel]);
    if (setToastMessage) {
      setToastMessage('Price recorded');
    }
  };

  const handleDeletePrice = async (priceId) => {
    setProductPrices((prev) => prev.filter((p) => p.id !== priceId));
    await deleteProductPriceFromSupabase(priceId);
    if (setToastMessage) {
      setToastMessage('Price deleted');
    }
  };

  const tabItems = [
    { id: 'list', label: 'Active List', icon: ShoppingCart, badge: items.filter((i) => !i.is_checked).length },
    { id: 'markets', label: 'Stores', icon: Store, badge: markets.length },
    { id: 'prices', label: 'Price Comparison', icon: Tag },
  ];

  return (
    <div className="space-y-6 sm:space-y-7">
      {/* Sub Tabs */}
      <Tabs items={tabItems} activeTab={shopTab} onChange={handleShopTabChange} />

      {/* Tab Views */}
      {shopTab === 'list' && (
        <ShoppingList
          items={items}
          onAddItem={handleAddItem}
          onToggleItem={handleToggleItem}
          onDeleteItem={handleDeleteItem}
          onUpdateItem={handleUpdateItem}
          activeProfile={activeProfile}
          profiles={profiles}
          markets={markets}
          productPrices={productPrices}
          onSavePrice={handleSavePrice}
          onDeletePrice={handleDeletePrice}
          onSaveMarket={handleSaveMarket}
        />
      )}

      {shopTab === 'markets' && (
        <MarketManager
          markets={markets}
          productPrices={productPrices}
          onSaveMarket={handleSaveMarket}
          onDeleteMarket={handleDeleteMarket}
        />
      )}

      {shopTab === 'prices' && (
        <PriceComparator
          items={items}
          markets={markets}
          productPrices={productPrices}
          onSavePrice={handleSavePrice}
          onDeletePrice={handleDeletePrice}
          onSaveMarket={handleSaveMarket}
          onRenameProduct={handleRenameProduct}
        />
      )}
    </div>
  );
}
