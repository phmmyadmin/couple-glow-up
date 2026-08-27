let wakeLock = null;

export const requestWakeLock = async () => {
  if (typeof navigator !== 'undefined' && navigator.wakeLock) {
    try {
      wakeLock = await navigator.wakeLock.request('screen');
      wakeLock.addEventListener('release', () => {
        wakeLock = null;
      });
      return wakeLock;
    } catch (err) {
      console.warn('Wake Lock request failed:', err);
      return null;
    }
  }
  return null;
};

export const releaseWakeLock = async () => {
  if (wakeLock !== null) {
    try {
      await wakeLock.release();
      wakeLock = null;
    } catch (err) {
      console.warn('Wake Lock release failed:', err);
    }
  }
};
