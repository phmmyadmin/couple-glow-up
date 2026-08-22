let activeCountdownTimer = null;

export async function updateRestNotificationBar(remainingSeconds, isFinished = false, exerciseName = '') {
  if (!('serviceWorker' in navigator) || !('Notification' in window)) return;
  if (Notification.permission !== 'granted') return;

  try {
    const reg = await navigator.serviceWorker.ready;

    if (isFinished || remainingSeconds <= 0) {
      // Close active countdown notification
      const activeNotifications = await reg.getNotifications({ tag: 'rest-timer-active' });
      activeNotifications.forEach((n) => n.close());

      // Show Rest Completed notification with vibration pattern
      reg.showNotification('🔔 Rest Time Over!', {
        body: exerciseName ? `Time for your next set of ${exerciseName}! 🏋️` : 'Time to start your next set! 🏋️',
        icon: '/favicon.svg',
        badge: '/favicon.svg',
        tag: 'rest-timer-finished',
        renotify: true,
        vibrate: [200, 100, 200, 100, 200, 100, 300],
        data: { url: './' },
        actions: [
          { action: 'open', title: 'Open App 📲' },
          { action: 'dismiss', title: 'Dismiss ✖️' },
        ],
      });
      return;
    }

    // Ongoing countdown notification bar update
    const mins = Math.floor(remainingSeconds / 60);
    const secs = remainingSeconds % 60;
    const formatted = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;

    reg.showNotification(`⏱️ Rest Timer: ${formatted}`, {
      body: exerciseName ? `Next set: ${exerciseName}` : 'Resting between sets...',
      icon: '/favicon.svg',
      badge: '/favicon.svg',
      tag: 'rest-timer-active',
      silent: true,
      renotify: false,
      data: { url: './' },
    });
  } catch (err) {
    console.error('Error updating rest notification bar:', err);
  }
}

export async function clearRestNotificationBar() {
  if (!('serviceWorker' in navigator)) return;
  try {
    const reg = await navigator.serviceWorker.ready;
    const activeNotifications = await reg.getNotifications({ tag: 'rest-timer-active' });
    activeNotifications.forEach((n) => n.close());
  } catch {}
}
