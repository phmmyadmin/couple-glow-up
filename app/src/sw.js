import { precacheAndRoute, cleanupOutdatedCaches } from 'workbox-precaching';

// Clean up old caches and setup precache routing
cleanupOutdatedCaches();
precacheAndRoute(self.__WB_MANIFEST || []);

// Helper to compute absolute icon URL relative to SW location (safe on subpaths & GitHub Pages)
function getSwIconUrl() {
  try {
    return new URL('./favicon.svg', self.location.href).href;
  } catch (e) {
    return './favicon.svg';
  }
}

// ── SW REST TIMER BACKGROUND MANAGER ──
let swRestTimeout = null;

self.addEventListener('message', (event) => {
  if (!event.data || !event.data.type) return;

  if (event.data.type === 'START_REST_TIMER') {
    const { restEndTime, exerciseName } = event.data;
    if (swRestTimeout) clearTimeout(swRestTimeout);

    const delay = Math.max(0, restEndTime - Date.now());
    const iconUrl = getSwIconUrl();

    // 1. Try OS Native Scheduled Notification Trigger (Chrome / Android / W3C standard)
    if ('showTrigger' in Notification.prototype && typeof TimestampTrigger !== 'undefined') {
      try {
        self.registration.showNotification('00:00 - Rest Time Over! 🔔', {
          body: exerciseName ? `Time for your next set of ${exerciseName}! 🏋️` : 'Time for your next set! 🏋️',
          icon: iconUrl,
          badge: iconUrl,
          tag: 'rest-timer-finished',
          showTrigger: new TimestampTrigger(restEndTime),
          renotify: true,
          vibrate: [200, 100, 200, 100, 200, 100, 300],
          data: { url: './' },
          actions: [
            { action: 'open', title: 'Open App 📲' },
            { action: 'dismiss', title: 'Dismiss ✖️' },
          ],
        });
        return;
      } catch (err) {
        console.warn('TimestampTrigger schedule failed, falling back to SW timer:', err);
      }
    }

    // 2. Fallback SW background timer
    swRestTimeout = setTimeout(() => {
      self.registration.getNotifications({ tag: 'rest-timer-active' }).then((active) => {
        active.forEach((n) => n.close());
      });

      self.registration.showNotification('00:00 - Rest Time Over! 🔔', {
        body: exerciseName ? `Time for your next set of ${exerciseName}! 🏋️` : 'Time for your next set! 🏋️',
        icon: iconUrl,
        badge: iconUrl,
        tag: 'rest-timer-finished',
        renotify: true,
        vibrate: [200, 100, 200, 100, 200, 100, 300],
        data: { url: './' },
        actions: [
          { action: 'open', title: 'Open App 📲' },
          { action: 'dismiss', title: 'Dismiss ✖️' },
        ],
      });
    }, delay);
  }

  if (event.data.type === 'CANCEL_REST_TIMER') {
    if (swRestTimeout) {
      clearTimeout(swRestTimeout);
      swRestTimeout = null;
    }
    self.registration.getNotifications({ tag: 'rest-timer-active' }).then((active) => {
      active.forEach((n) => n.close());
    });
    self.registration.getNotifications({ tag: 'rest-timer-finished' }).then((finished) => {
      finished.forEach((n) => {
        if ('showTrigger' in n) n.close();
      });
    });
  }
});

// ── PUSH NOTIFICATION EVENT HANDLER ──
self.addEventListener('push', (event) => {
  if (!event.data) return;

  let data = {};
  try {
    data = event.data.json();
  } catch {
    data = { body: event.data.text() };
  }

  const iconUrl = getSwIconUrl();
  const title = data.title || 'Couple Glow Up ✨';
  const options = {
    body: data.body || '',
    icon: iconUrl,
    badge: iconUrl,
    tag: data.tag || 'glowup-notification',
    data: {
      url: data.url || './',
      event_type: data.event_type || 'general',
    },
    actions: [
      { action: 'open', title: 'Open App 📲' },
      { action: 'dismiss', title: 'Dismiss ✖️' },
    ],
    vibrate: [100, 50, 100],
    renotify: true,
  };

  event.waitUntil(
    self.registration.showNotification(title, options)
  );
});

// ── NOTIFICATION CLICK EVENT HANDLER ──
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  if (event.action === 'dismiss') {
    return;
  }

  // Focus existing open tab or open a new one
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
      for (const client of clientList) {
        if (client.url && 'focus' in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        const targetUrl = (event.notification.data && event.notification.data.url) || './';
        return clients.openWindow(targetUrl);
      }
    })
  );
});
