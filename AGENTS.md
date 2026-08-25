# 🤖 Directrices de Trabajo y Desarrollo (AGENTS.md)

Este documento define los estándares arquitectónicos, de calidad de código y las directivas obligatorias para todos los agentes y desarrolladores que trabajen en el proyecto **Couple Glow Up**.

---

## 📜 1. Directiva TDD Obligatoria (Test-Driven Development)

> [!IMPORTANT]
> **Es obligatorio aplicar Test-Driven Development (TDD)** en toda lógica de integración crítica (IA/Gemini, FSRS, Supabase Cloud Sync, cálculos nutricionales, fórmulas de 1RM, algoritmos de sobrecarga progresiva y paginación infinita).

### Protocolo de Pruebas:
1. **Red ➔ Green ➔ Refactor:**
   - Escribir primero las pruebas unitarias o de integración en `src/__tests__/integration/` o `src/shared/hooks/__tests__/`.
   - Ejecutar `npm test` (con Vitest) para verificar la fase de fallo controlada.
   - Implementar la funcionalidad mínima necesaria para pasar las pruebas.
   - Refactorizar manteniendo el 100% de tests en verde.
2. **Verificación Previa a Commit/Push/PR:**
   - Todos los tests unitarios y de integración deben pasar al 100% (`npm test`).
   - La compilación de producción debe finalizar con 0 errores (`npm run build`).
   - El hook `pre-push` de Git (`.githooks/pre-push`) validará automáticamente ambas condiciones antes de permitir cualquier subida a remoto.

---

## 🏗️ 2. Arquitectura y Convenciones de Código

### Idioma & Localización:
* **UI de la aplicación:** 100% en inglés (`en.json` / strings nativos en inglés).
* **Comunicación con el usuario:** En español.

### PWA & Compatibilidad con GitHub Pages:
* La aplicación se despliega estáticamente en GitHub Pages bajo una subruta (`/couple-glow-up/`).
* **Regla estricta de rutas de recursos:** Nunca usar rutas absolutas directas como `icon: '/favicon.svg'`. Utilizar siempre resolución dinámica relativa segura (ej. `getNotificationIcon()` o `new URL('./favicon.svg', base).href`) para evitar errores 404.

### Módulos Principales:
* **Fit Tracker:** Registro de comidas con IA Gemini, diario por comidas, recetas/platos multi-ingrediente (`DishesView`) y cálculo de macros escalados con preservación de micronutrientes (Fibra, Azúcar, Sodio).
* **Gym & Workouts:** Historial de sesiones, catálogo de ejercicios con GIFs animados, cálculo de 1RM (Epley), recomendaciones de sobrecarga progresiva inteligente, mapa de calor muscular y temporizador de descanso sincronizado con Web Audio Keep-Alive.
* **Shopping:** Lista de compras sincronizada en pareja, comparador de precios multi-supermercado (`PriceComparator`) y catálogo maestro de productos.
* **Feed & Social:** Eventos de actividad compartidos y notificaciones push en tiempo real vía Supabase Realtime y Web Push.

---

## 🧪 3. Comandos de Verificación Rápida

```bash
npm test          # Ejecuta las suites completas de Vitest
npm test:watch    # Modo interactivo TDD durante el desarrollo
npm run build     # Compilación y empaquetado PWA
npm run lint      # Análisis estático de código con Oxlint
npm run setup:hooks # Enlaza .githooks/pre-push en nuevos clones
```
