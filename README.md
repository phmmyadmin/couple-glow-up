# Couple Glow Up ✨

App integral y colaborativa para parejas: Nutrición & Déficit Calórico (Fit), Listas de la Compra Compartidas (Shopping), Registro de Entrenamiento estilo Hevy (Gym) y Feed Social con Notificaciones Push en tiempo real.

## Características

- 🥗 **Fit Tracker:** Registro nutricional con IA (Google Gemini), cálculo de macros, déficit calórico acumulado, media móvil de peso y TDEE adaptativo.
- 🏋️ **Gym Logger:** Registro de series en vivo con RPE/RIR, detección automática de récords personales (1RM Epley), historial por ejercicio, radar muscular y temporizador de descanso con notificaciones push en segundo plano.
- 🛒 **Shopping:** Lista de la compra compartida en tiempo real (Supabase Realtime) con organizador por supermercados y comparativa de precios.
- 💬 **Couple Feed & Push:** Feed social de logros mutuos y notificaciones push PWA nativas W3C (VAPID) inmediatas entre dispositivos.

## Tech Stack

- **Frontend:** React 19, Vite, Tailwind CSS, Lucide Icons, i18next
- **PWA & Offline:** vite-plugin-pwa, Service Worker personalizado (injectManifest), Web Push API
- **Backend & Sync:** Supabase (PostgreSQL, Row Level Security, Realtime Channels)
- **IA:** Google Generative AI (Gemini Flash)
