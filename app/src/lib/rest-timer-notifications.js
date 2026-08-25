let keepAliveAudioCtx = null;

/**
 * Returns a fully qualified absolute URL for the notification icon
 * that works correctly on localhost, custom domains, and GitHub Pages subpaths.
 */
export function getNotificationIcon() {
  try {
    if (typeof window !== 'undefined' && window.location) {
      const base = window.location.href.split('#')[0].split('?')[0];
      return new URL('./favicon.svg', base).href;
    }
  } catch (e) {}
  return './favicon.svg';
}

/**
 * Enables a silent Web Audio node to prevent mobile browsers (iOS/Android)
 * from killing the background execution while the app is backgrounded.
 */
export function enableWebAudioKeepAlive() {
  try {
    const AudioCtx = window.AudioContext || window.webkitAudioContext;
    if (AudioCtx && !keepAliveAudioCtx) {
      keepAliveAudioCtx = new AudioCtx();
      if (keepAliveAudioCtx.state === 'suspended') {
        keepAliveAudioCtx.resume().catch(() => {});
      }
      // Create a silent buffer source node
      const buffer = keepAliveAudioCtx.createBuffer(1, 1, 22050);
      const source = keepAliveAudioCtx.createBufferSource();
      source.buffer = buffer;
      source.connect(keepAliveAudioCtx.destination);
      source.start(0);
    }
  } catch (e) {}
}

export function playRestCompleteSound() {
  try {
    const AudioCtx = window.AudioContext || window.webkitAudioContext;
    if (AudioCtx) {
      const ctx = new AudioCtx();
      const playBeep = (freq, startTime, duration) => {
        const osc = ctx.createOscillator();
        const gain = ctx.createGain();
        osc.type = 'sine';
        osc.frequency.setValueAtTime(freq, startTime);
        gain.gain.setValueAtTime(0.18, startTime);
        gain.gain.exponentialRampToValueAtTime(0.001, startTime + duration);
        osc.connect(gain);
        gain.connect(ctx.destination);
        osc.start(startTime);
        osc.stop(startTime + duration);
      };
      const now = ctx.currentTime;
      playBeep(880, now, 0.15); // A5
      playBeep(880, now + 0.2, 0.15); // A5
      playBeep(1174.66, now + 0.4, 0.35); // D6
    }
  } catch (e) {}

  try {
    if (navigator.vibrate) {
      navigator.vibrate([200, 100, 200, 100, 300]);
    }
  } catch (e) {}
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

  const iconUrl = getNotificationIcon();

  try {
    const reg = await navigator.serviceWorker.ready;

    if (isFinished || remainingSeconds <= 0) {
      // Close active countdown notification
      const activeNotifications = await reg.getNotifications({ tag: 'rest-timer-active' });
      activeNotifications.forEach((n) => n.close());

      // Show Rest Completed notification with time FIRST (00:00)
      reg.showNotification('00:00 - Rest Time Over! 🔔', {
        body: exerciseName ? `Time for your next set of ${exerciseName}! 🏋️` : 'Time to start your next set! 🏋️',
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
      return;
    }

    // Ongoing countdown notification bar update with time FIRST (e.g., "01:30 - Rest Timer ⏱️")
    const mins = Math.floor(remainingSeconds / 60);
    const secs = remainingSeconds % 60;
    const formatted = `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;

    reg.showNotification(`${formatted} - Rest Timer ⏱️`, {
      body: exerciseName ? `Next set: ${exerciseName}` : 'Resting between sets...',
      icon: iconUrl,
      badge: iconUrl,
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
