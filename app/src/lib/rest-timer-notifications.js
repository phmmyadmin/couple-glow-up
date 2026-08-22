let silentAudioCtx = null;

function enableWebAudioKeepAlive() {
  try {
    if (!silentAudioCtx) {
      const AudioCtx = window.AudioContext || window.webkitAudioContext;
      if (AudioCtx) {
        silentAudioCtx = new AudioCtx();
      }
    }
    if (silentAudioCtx && silentAudioCtx.state === 'suspended') {
      silentAudioCtx.resume();
    }
    if (silentAudioCtx) {
      const buffer = silentAudioCtx.createBuffer(1, 1, 22050);
      const source = silentAudioCtx.createBufferSource();
      source.buffer = buffer;
      source.connect(silentAudioCtx.destination);
      source.start(0);
    }
  } catch (e) {
    // Ignore audio context errors
  }
}

export async function startBackgroundRestTimer(restEndTime, exerciseName = '') {
  if (!('serviceWorker' in navigator) || !('Notification' in window)) return;
  if (Notification.permission !== 'granted') return;

  // Activate silent Web Audio keep-alive node to prevent mobile OS from freezing JS execution while minimized
  enableWebAudioKeepAlive();

  try {
    const reg = await navigator.serviceWorker.ready;

    // Send background timer message to Service Worker with timestamp
    if (navigator.serviceWorker.controller) {
      navigator.serviceWorker.controller.postMessage({
        type: 'START_REST_TIMER',
        restEndTime,
        exerciseName,
      });
    }

    // Initial notification bar update with time FIRST
    const remainingSeconds = Math.max(0, Math.ceil((restEndTime - Date.now()) / 1000));
    updateRestNotificationBar(remainingSeconds, false, exerciseName);
  } catch (err) {
    console.error('Error starting background rest timer:', err);
  }
}

export async function updateRestNotificationBar(remainingSeconds, isFinished = false, exerciseName = '') {
  if (!('serviceWorker' in navigator) || !('Notification' in window)) return;
  if (Notification.permission !== 'granted') return;

  try {
    const reg = await navigator.serviceWorker.ready;

    if (isFinished || remainingSeconds <= 0) {
      // Close active countdown notification
      const activeNotifications = await reg.getNotifications({ tag: 'rest-timer-active' });
      activeNotifications.forEach((n) => n.close());

      // Show Rest Completed notification with time FIRST (00:00)
      reg.showNotification('00:00 - Rest Time Over! 🔔', {
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

    // Ongoing countdown notification bar update with time FIRST (e.g., "01:30 - Rest Timer ⏱️")
    const mins = Math.floor(remainingSeconds / 60);
    const secs = remainingSeconds % 60;
    const formatted = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;

    reg.showNotification(`${formatted} - Rest Timer ⏱️`, {
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
    // Cancel background timer in Service Worker
    if (navigator.serviceWorker.controller) {
      navigator.serviceWorker.controller.postMessage({
        type: 'CANCEL_REST_TIMER',
      });
    }

    const reg = await navigator.serviceWorker.ready;
    const activeNotifications = await reg.getNotifications({ tag: 'rest-timer-active' });
    activeNotifications.forEach((n) => n.close());
  } catch {}
}
