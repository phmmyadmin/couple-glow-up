import { precacheAndRoute, cleanupOutdatedCaches } from 'workbox-precaching';

// Clean up old caches and setup precache routing
cleanupOutdatedCaches();
precacheAndRoute(self.__WB_MANIFEST || []);

// ── PUSH NOTIFICATION EVENT HANDLER ──
self.addEventListener('push', (event) => {
  if (!event.data) return;

  let data = {};
  try {
    data = event.data.json();
  } catch {
    data = { body: event.data.text() };
  }

  const title = data.title || 'Couple Glow Up ✨';
  const options = {
    body: data.body || '',
    icon: '/favicon.svg',
    badge: '/favicon.svg',
    tag: data.tag || 'glowup-notification',
    data: {
      url: data.url || './',
      event_type: data.event_type || 'general',
    },
    actions: [
      { action: 'open', title: 'Open App 📲' },
      { action: 'dismiss', title: 'Close ✖️' },
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

  if (event.action === 'dismiss') return;

  const urlToOpen = event.notification.data?.url || './';

  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((windowClients) => {
      // If PWA window is already open, focus it
      for (const client of windowClients) {
        if (client.url.includes(self.location.origin)) {
          client.focus();
          if ('navigate' in client && typeof client.navigate === 'function') {
            client.navigate(urlToOpen);
          }
          return;
        }
      }
      // Otherwise open a new window
      if (clients.openWindow) {
        return clients.openWindow(urlToOpen);
      }
    })
  );
});
