import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import './i18n/i18n';
import App from './App.jsx';
import { logAppErrorToSupabase } from './lib/supabase';

// Global remote error reporting to Supabase for native APK and web debugging
if (typeof window !== 'undefined') {
  window.addEventListener('error', (event) => {
    logAppErrorToSupabase('error', 'uncaught_window_error', event.message || 'Unknown window error', {
      filename: event.filename,
      lineno: event.lineno,
      colno: event.colno,
      stack: event.error?.stack,
    });
  });

  window.addEventListener('unhandledrejection', (event) => {
    logAppErrorToSupabase('error', 'unhandled_promise_rejection', event.reason?.message || String(event.reason), {
      stack: event.reason?.stack,
    });
  });
}

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>
);
