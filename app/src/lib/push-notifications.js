import { supabase } from './supabase';

const VAPID_PUBLIC_KEY = import.meta.env.VITE_VAPID_PUBLIC_KEY || 'BCBBmmGjmFu96QOKLiLKc9Z11G0giyH9ysLB0y93pCeQ-AVoGf6aditjLAduD-Puetp-eP25V8IehU3bpAJJOB0';

function urlBase64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - (base64String.length % 4)) % 4);
  const base64 = (base64String + padding).replace(/-/g, '+').replace(/_/g, '/');
  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);
  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

export async function isPushSupported() {
  return (
    'serviceWorker' in navigator &&
    'PushManager' in window &&
    'Notification' in window
  );
}

export async function getPushPermissionState() {
  if (!('Notification' in window)) return 'unsupported';
  return Notification.permission;
}

export async function subscribeUserToPush(profileId) {
  if (!(await isPushSupported())) {
    console.warn('Push notifications are not supported in this browser.');
    return { success: false, reason: 'unsupported' };
  }

  try {
    const permission = await Notification.requestPermission();
    if (permission !== 'granted') {
      return { success: false, reason: 'permission_denied' };
    }

    const registration = await navigator.serviceWorker.ready.catch(() => null);
    let subscription = null;

    if (registration && registration.pushManager) {
      try {
        subscription = await registration.pushManager.getSubscription();

        if (!subscription && VAPID_PUBLIC_KEY) {
          const convertedVapidKey = urlBase64ToUint8Array(VAPID_PUBLIC_KEY);
          subscription = await registration.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: convertedVapidKey,
          });
        }
      } catch (pushErr) {
        console.warn('PushManager subscription warning (falling back to standard notification permissions):', pushErr);
      }
    }

    if (subscription) {
      const subJson = subscription.toJSON();
      const endpoint = subJson.endpoint;
      const p256dh = subJson.keys?.p256dh;
      const auth = subJson.keys?.auth;

      if (supabase && profileId && endpoint && p256dh && auth) {
        const { error } = await supabase.from('push_subscriptions').upsert(
          {
            profile_id: profileId,
            endpoint,
            p256dh,
            auth,
            user_agent: navigator.userAgent,
            updated_at: new Date().toISOString(),
          },
          { onConflict: 'profile_id,endpoint' }
        );

        if (error) {
          console.error('Error saving push subscription to Supabase:', error);
        }
      }
    }

    return { success: true, permission: 'granted', subscription };
  } catch (err) {
    console.error('Error subscribing to push notifications:', err);
    return { success: false, reason: err.message };
  }
}

export async function unsubscribeUserFromPush(profileId) {
  if (!(await isPushSupported())) return false;

  try {
    const registration = await navigator.serviceWorker.ready;
    const subscription = await registration.pushManager.getSubscription();

    if (subscription) {
      const endpoint = subscription.endpoint;
      await subscription.unsubscribe();

      if (supabase && profileId && endpoint) {
        await supabase
          .from('push_subscriptions')
          .delete()
          .eq('profile_id', profileId)
          .eq('endpoint', endpoint);
      }
    }
    return true;
  } catch (err) {
    console.error('Error unsubscribing from push:', err);
    return false;
  }
}
