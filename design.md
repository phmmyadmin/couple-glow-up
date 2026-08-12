# Couple Glow Up - Design & UX Audit (design.md)

## 1. Análisis del Problema Actual ("El diseño se ve horrible")

Tras una auditoría completa del código y la comparación con la aplicación original de Fit Tracker, se ha detectado una **fractura arquitectónica en el sistema de diseño**. La app actual se siente como "dos aplicaciones distintas pegadas". A continuación, los hallazgos:

### A. Inconsistencias del Sistema de Diseño (CSS vs Tailwind)
- **Choque Híbrido:** Fit Tracker usaba un sistema de diseño altamente cohesivo con CSS puro (`index.css` definiendo `.health-card`, `.tab-group` y variables CSS semánticas). Los nuevos módulos (Gym, Shopping, Feed) ignoran este CSS y usan clases utilitarias de Tailwind v4, creando una fragmentación visual.
- **Sobrescritura de Componentes:** La clase `.health-card` original tiene un padding fijo de `1.5rem`. Sin embargo, los componentes nuevos sobrescriben esto con utilidades de Tailwind (`className="health-card p-3"` o `p-4`), rompiendo el ritmo del espaciado (spacing rhythm).
- **Tamaño de Iconos:** En la app original, los iconos de `lucide-react` se dimensionaban por props (`size={16}` o `size={18}`). Los nuevos componentes mezclan esto con clases de Tailwind (`w-4 h-4`, `w-3.5 h-3.5`), causando desalineaciones sutiles.

### B. Patrones de Botones (Falta de Uniformidad)
No hay un componente unificado para los botones. Actualmente existen al menos 5 patrones compitiendo:
1. Botones de navegación heredados (`.nav-btn` en `FitApp.jsx`).
2. Píldoras de pestañas heredadas (`.tab-item`).
3. Botones con estilos en línea (ej. el botón "+ Nuevo" en `App.jsx`).
4. Botones de acción Tailwind (ej. `px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white rounded-2xl` en Gym/Feed).
5. Botones de icono utilitarios (ej. `p-1.5 text-slate-400 hover:text-rose-600 rounded-lg` en Shopping).

### C. Uso de Tokens de Color
- **Variables CSS vs. Tailwind:** La app original establecía colores semánticos como `var(--bg-app)`, `var(--text-main)`, y `var(--color-indigo)`. Los nuevos módulos ignoran esto y usan las paletas hardcodeadas de Tailwind (`slate`, `indigo`, `emerald`, `rose`).
- **Pérdida de Acentos Semánticos:** Los anillos de macros originales usaban colores semánticos (`var(--color-protein)`, `var(--color-carbs)`). Los nuevos módulos no consumen estos tokens, desconectando el lenguaje de colores en toda la app.

### D. Auditoría Tipográfica
- **Cambio Drástico de Escala:** Fit Tracker era amplio y aireado (fuentes entre `0.9rem` y `1.8rem`). Los módulos nuevos abusan de micro-textos densos (`text-xs`, `text-[11px]`, `text-[10px]`), haciendo que el Feed y Shopping sean difíciles de leer en comparación con el Dashboard de Fit.
- **Pesos de Fuente (Font Weights):** Tailwind aplica `font-bold` y `font-semibold` de manera aleatoria, chocando a veces con las fuentes base heredadas de `index.css` (`Outfit` para títulos, `Inter` para cuerpo).

### E. Espaciado y Diseño (Layout)
- **Grid vs Flex:** Los módulos heredados usaban `.form-grid-2`, `.form-grid-3`. Los nuevos usan combinaciones aleatorias de flex y `space-y-*` de Tailwind.
- **Problema de Ancho Máximo (Max Width):** `.app-container` tiene `max-width: 900px` centrado. Sin embargo, el nuevo `BottomNav.jsx` tiene un límite forzado de `max-w-md` (448px). En escritorio/tablet, el contenido principal se expande a 900px pero la navegación inferior queda recortada y pequeña en el centro.

### F. Brechas de UX y Funcionalidad
- **Accesibilidad (a11y):** Los nuevos formularios en `ShoppingList` no usan etiquetas `<label>`, dependiendo solo de placeholders. Muchos botones de icono de Tailwind (eliminar, tachar) no tienen `aria-label`.
- **Estados Vacíos (Empty States):** Mientras Shopping tiene estados vacíos, a `FeedApp` y a algunas pestañas de `GymApp` les faltan.
- **Estados de Carga (Loading States):** No hay uso de *skeleton loaders*. FitApp tiene un estado `isLoading` pero no se propaga bien a los nuevos módulos.
- **Optimistic UI Bugs:** En `FeedApp`, al añadir una nota se usa un ID local (`Date.now()`). Si la respuesta de Realtime llega al mismo tiempo, las reacciones se desincronizan por choque de IDs.
- **Eliminación en Cascada:** Eliminar un mercado en Shopping no advierte de los precios guardados vinculados a ese `market_id`, pudiendo dejar datos huérfanos.

---

## 2. Plan de Acción y Mejora (Refactorización)

Para arreglar el diseño y tener una verdadera aplicación unificada y Premium, ejecutaremos este plan:

### FASE 1: Unificación del Sistema UI Core (Tailwind-First o CSS-First)
- Estandarizaremos un **único método de diseño**. Usaremos los colores originales (`#FAFAF7`, `#18181B`, `#4F46E5`) configurándolos como el tema central de Tailwind (`@theme` en Tailwind v4 o `theme.extend`).
- Crearemos la carpeta `/src/shared/ui/` y migraremos los elementos clave a **componentes reutilizables de React**:
  - `<Card>` (Para reemplazar el `.health-card` mezclado).
  - `<Button>` (Para estandarizar primary, outline, ghost e icon buttons).
  - `<Input>` y `<Select>` (Para unificar los `.edit-input` y los campos de Tailwind).

### FASE 2: Refactorización Tipográfica y Espacial
- Reemplazaremos todos los `text-[10px]` y micro-textos densos de los módulos de Gym, Shopping y Feed para que coincidan con los tamaños aireados de Fit Tracker (`text-sm`, `text-base`).
- Arreglaremos el ancho del `BottomNav` para que iguale el comportamiento responsivo responsivo de `.app-container` (hasta 900px en tablets).
- Unificaremos los paddings de todas las tarjetas para que no haya sobrescrituras. Todos usarán un espaciado base de `p-5` o `p-6` en toda la app.

### FASE 3: Correcciones Funcionales y de Accesibilidad (UX)
- Añadir **aria-labels** a todos los botones de iconos, especialmente en Shopping y Gym.
- Corregir el bug de borrado de `MarketManager` para avisar si el mercado tiene precios asociados.
- Unificar la estrategia de iconos (`size={18}` en todos lados).
- Mejorar los estados de carga con un `<Skeleton />` básico en lugar de solo desaparecer los datos.
