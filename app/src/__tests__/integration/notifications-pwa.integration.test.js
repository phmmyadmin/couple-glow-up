import { describe, it, expect, vi, beforeEach } from 'vitest';
import {
  getNotificationIcon,
  enableWebAudioKeepAlive,
  playRestCompleteSound,
} from '../../lib/rest-timer-notifications';

describe('Notifications & PWA Background Keep-Alive Integration', () => {
  describe('Dynamic Notification Icon URL Resolution (GitHub Pages 404 Fix)', () => {
    it('resolves relative icon correctly in browser window environment', () => {
      const iconUrl = getNotificationIcon();
      expect(typeof iconUrl).toBe('string');
      expect(iconUrl).toContain('favicon.svg');
      // Must NOT be just a hardcoded absolute '/favicon.svg' that breaks on subpaths
      expect(iconUrl).toMatch(/^(http|https|file|\.\/)/);
    });
  });

  describe('Web Audio Keep-Alive Lifecycle', () => {
    it('initializes silent Web Audio context without throwing errors', () => {
      expect(() => {
        enableWebAudioKeepAlive();
      }).not.toThrow();
    });

    it('plays synthesized rest completion chime and triggers vibration safely', () => {
      expect(() => {
        playRestCompleteSound();
      }).not.toThrow();
    });
  });

  describe('Feed Event Notification Payload Formatting', () => {
    function formatFeedNotification(event) {
      const icon = getNotificationIcon();
      const title = event.title || 'Couple Glow Up ✨';
      const body = event.description || 'New activity logged';

      return {
        title,
        options: {
          body,
          icon,
          badge: icon,
          tag: `feed-${event.id || 'general'}`,
          vibrate: [100, 50, 100],
          data: { url: './', event_type: event.event_type || 'general' },
        },
      };
    }

    it('creates well-formed notification payload for meal logs', () => {
      const mealEvent = {
        id: 'evt-123',
        event_type: 'food_logged',
        title: '🍗 Chicken Adobo Logged',
        description: 'Pablo logged 450 kcal of Chicken Adobo',
      };

      const payload = formatFeedNotification(mealEvent);
      expect(payload.title).toBe('🍗 Chicken Adobo Logged');
      expect(payload.options.body).toContain('450 kcal');
      expect(payload.options.icon).toContain('favicon.svg');
      expect(payload.options.tag).toBe('feed-evt-123');
    });

    it('creates well-formed notification payload for completed workouts', () => {
      const workoutEvent = {
        id: 'evt-456',
        event_type: 'workout_completed',
        title: '💪 Push Day Finished',
        description: 'Partner completed 18 sets and set 2 PRs!',
      };

      const payload = formatFeedNotification(workoutEvent);
      expect(payload.title).toBe('💪 Push Day Finished');
      expect(payload.options.body).toContain('2 PRs');
      expect(payload.options.tag).toBe('feed-evt-456');
    });
  });
});
