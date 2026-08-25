import React, { useState, useEffect } from 'react';
import { Bell, BellOff, BellRing, Check, Sparkles, AlertCircle } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import Button from './ui/Button';
import Card from './ui/Card';
import {
  isPushSupported,
  getPushPermissionState,
  subscribeUserToPush,
  unsubscribeUserFromPush,
} from '../lib/push-notifications';

export default function NotificationPrompt({ activeProfile, setToastMessage }) {
  const { t } = useTranslation();
  const [supported, setSupported] = useState(false);
  const [permission, setPermission] = useState('default');
  const [isSubscribed, setIsSubscribed] = useState(false);
  const [loading, setLoading] = useState(false);
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    async function checkState() {
      const isSupp = await isPushSupported();
      setSupported(isSupp);
      if (isSupp) {
        const perm = await getPushPermissionState();
        setPermission(perm);
        setIsSubscribed(perm === 'granted');
      }
    }

    checkState();
  }, [activeProfile]);

  const handleSubscribe = async () => {
    if (!activeProfile?.id) {
      if (setToastMessage) setToastMessage('⚠️ Please select a profile first');
      return;
    }

    setLoading(true);
    const res = await subscribeUserToPush(activeProfile.id);
    setLoading(false);

    if (res.success) {
      setIsSubscribed(true);
      setPermission('granted');
      setShowModal(false);
      if (setToastMessage) setToastMessage('🔔 Push notifications enabled successfully!');
    } else {
      if (res.reason === 'permission_denied') {
        setPermission('denied');
        if (setToastMessage) setToastMessage('❌ Notification permission denied in browser.');
      } else {
        if (setToastMessage) setToastMessage(`⚠️ Could not enable: ${res.reason}`);
      }
    }
  };

  const handleUnsubscribe = async () => {
    setLoading(true);
    const success = await unsubscribeUserFromPush(activeProfile?.id);
    setLoading(false);

    if (success) {
      setIsSubscribed(false);
      if (setToastMessage) setToastMessage('🔕 Push notifications disabled');
    }
  };

  const handleTestNotification = async () => {
    if (!('serviceWorker' in navigator)) return;

    try {
      const reg = await navigator.serviceWorker.ready;
      reg.showNotification('Couple Glow Up ✨', {
        body: 'Push notifications working 100%! 🚀',
        icon: '/favicon.svg',
        badge: '/favicon.svg',
        tag: 'test-push',
        vibrate: [100, 50, 100],
      });
      if (setToastMessage) setToastMessage('🎉 Test notification sent!');
    } catch (err) {
      console.error('Error sending test notification:', err);
    }
  };

  if (!supported) return null;

  return (
    <>
      {/* Header Quick Badge Button */}
      <button
        type="button"
        onClick={() => setShowModal(true)}
        className={`p-1.5 rounded-xl border flex items-center gap-1.5 text-xs font-bold transition-all shadow-2xs cursor-pointer ${
          isSubscribed
            ? 'bg-emerald-50 text-emerald-700 border-emerald-200 hover:bg-emerald-100'
            : permission === 'denied'
            ? 'bg-rose-50 text-rose-600 border-rose-200 opacity-80'
            : 'bg-amber-50 text-amber-700 border-amber-200 hover:bg-amber-100 animate-pulse'
        }`}
        title="Configure Push Notifications"
      >
        {isSubscribed ? (
          <BellRing className="w-3.5 h-3.5 text-emerald-600" />
        ) : (
          <Bell className="w-3.5 h-3.5 text-amber-600" />
        )}
        <span className="hidden sm:inline">
          {isSubscribed ? 'Notifications 🟢' : 'Enable Push 🔔'}
        </span>
      </button>

      {/* Settings / Prompt Modal */}
      {showModal && (
        <div className="fixed inset-0 z-50 bg-slate-900/60 backdrop-blur-xs flex items-center justify-center p-4">
          <Card className="max-w-md w-full p-6 space-y-5 bg-white rounded-3xl shadow-xl relative animate-in fade-in zoom-in duration-200">
            <div className="flex items-center justify-between border-b border-slate-100 pb-3">
              <div className="flex items-center gap-2">
                <div className="w-9 h-9 rounded-2xl bg-gradient-to-br from-indigo-500 to-rose-500 text-white flex items-center justify-center shadow-xs">
                  <BellRing className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="text-base font-bold text-slate-900">Push Notifications</h3>
                  <p className="text-xs text-slate-500 font-medium">Couple Glow Up ✨</p>
                </div>
              </div>
              <button
                onClick={() => setShowModal(false)}
                className="text-slate-400 hover:text-slate-600 text-xl font-bold p-1"
              >
                ×
              </button>
            </div>

            <div className="space-y-3 text-xs sm:text-sm text-slate-600">
              <p>
                Get instant alerts on your device when your partner:
              </p>
              <ul className="space-y-2 bg-slate-50 p-3.5 rounded-2xl border border-slate-100 font-medium text-slate-700">
                <li className="flex items-center gap-2">
                  <span>🏋️</span> Completes a workout or breaks a PR
                </li>
                <li className="flex items-center gap-2">
                  <span>🛒</span> Adds to or completes the shopping list
                </li>
                <li className="flex items-center gap-2">
                  <span>🥗</span> Logs daily meals or macro updates
                </li>
              </ul>
            </div>

            {/* Status & Actions */}
            <div className="pt-2 space-y-3">
              {permission === 'denied' ? (
                <div className="bg-rose-50 text-rose-700 p-3 rounded-2xl border border-rose-200 text-xs flex items-start gap-2">
                  <AlertCircle className="w-4 h-4 shrink-0 mt-0.5" />
                  <div>
                    <strong>Permission Denied:</strong> Notifications are blocked in your browser settings. Please enable notification permissions for this site.
                  </div>
                </div>
              ) : isSubscribed ? (
                <div className="space-y-2">
                  <div className="bg-emerald-50 text-emerald-700 p-3 rounded-2xl border border-emerald-200 text-xs flex items-center justify-between">
                    <span className="font-bold flex items-center gap-1.5">
                      <Check className="w-4 h-4 text-emerald-600" /> Notifications Active
                    </span>
                    <button
                      onClick={handleTestNotification}
                      className="px-2.5 py-1 bg-emerald-600 text-white rounded-xl font-bold hover:bg-emerald-700 transition-colors shadow-2xs"
                    >
                      Test Push 🚀
                    </button>
                  </div>
                  <Button
                    variant="secondary"
                    size="sm"
                    className="w-full text-rose-600 hover:bg-rose-50 border-rose-200"
                    onClick={handleUnsubscribe}
                    disabled={loading}
                  >
                    Disable Push Notifications
                  </Button>
                </div>
              ) : (
                <Button
                  size="lg"
                  className="w-full bg-gradient-to-r from-indigo-600 to-rose-600 hover:from-indigo-700 hover:to-rose-700 text-white font-bold"
                  onClick={handleSubscribe}
                  disabled={loading}
                >
                  {loading ? 'Enabling...' : 'Enable Push Notifications 🔔'}
                </Button>
              )}
            </div>
          </Card>
        </div>
      )}
    </>
  );
}
