# Style DNA — Lab App Reference

> Documento vivo. Actualizado por `steve-ui` con cada screenshot de referencia nuevo.  
> Última actualización: 2026-05-31  
> Referencias analizadas: 2 (iOS: 2, macOS: 0)

---

## Sistema de color

| Token | Light mode | Dark mode | Estado |
|-------|-----------|-----------|--------|
| Background | `#F5F0EB` — crema cálida custom (NO systemGroupedBackground) | `#000000` puro | **confirmado** (2 refs) |
| Surface / cards | `#FFFFFF` blanco puro | `#1C1C1E` charcoal (systemGray6 dark) | **confirmado** (2 refs) |
| Acento primario | `#3399FF` azul vivo | `#FFFFFF` blanco | tendencia (1 ref Nutrie) |
| Acento secundario | `#9B8FF5` lavanda | — | tendencia (1 ref Nutrie) |
| Acento terciario | `#FF6830` naranja/fuego | — | tendencia (1 ref Nutrie) |
| Texto primario | `#000000` / `#1C1C1E` | `#FFFFFF` | **confirmado** |
| Texto secundario | `#8E8E93` gris medio | `#8E8E93` | **confirmado** |
| Destructivo | — | — | sin definir |
| Borde / divisor | ninguno visible — contraste background/card crea jerarquía | ninguno visible | **confirmado** |
| CTA Button bg | `#000000` negro puro | `#FFFFFF` blanco | **confirmado** |
| CTA Button text | `#FFFFFF` blanco | `#000000` negro | **confirmado** |

**Modo:** adaptivo light/dark — **confirmado**

> **Nota clave:** El fondo crema `#F5F0EB` es una elección deliberada sobre `systemGroupedBackground`. Crea calidez y diferencia la app de apps genéricas iOS. Las cards blancas sobre crema crean jerarquía sin sombras.

---

## Tipografía

| Rol | Peso | Tamaño (pt) | Estado |
|-----|------|-------------|--------|
| Large Title (pantallas principales) | Bold / Black | ~34pt | **confirmado** |
| Display numeral (datos prominentes) | Black / Heavy | ~60–70pt | **confirmado** (cards de Calories) |
| Title / Headline de pantalla | Semibold | ~22–24pt | **confirmado** |
| Card section header | Semibold | ~17–18pt | tendencia |
| Body | Regular | ~15–17pt | **confirmado** |
| Caption / metadata | Regular | ~12–13pt | **confirmado** |
| All-caps label | Regular | ~11–12pt | tendencia (dark app) |
| Tab bar labels | Regular | ~10pt | **confirmado** |

**Densidad:** balanceada-generosa — **confirmado** (mucho espacio en blanco, sin hacinamiento)
**Sistema de fuente:** SF Pro (sistema) — **confirmado**

---

## Espaciado

| Contexto | Valor (pt) | Estado |
|----------|-----------|--------|
| Padding de cards | ~20pt | **confirmado** |
| Margen de página | ~20pt | **confirmado** |
| Gap entre cards | ~14–16pt | **confirmado** |
| Gap entre secciones | ~24–28pt | **confirmado** |
| Altura de tab bar area | ~80–90pt | tendencia |

---

## Forma

| Componente | Light mode | Dark mode | Estado |
|------------|-----------|-----------|--------|
| Cards grandes (feature) | ~20–24pt radius | ~20pt radius | **confirmado** |
| Cards grid (pequeñas) | ~16–18pt radius | ~16–18pt radius | **confirmado** |
| Botón CTA primario | pill (~999pt), full-width, 56pt height | pill (~999pt), full-width | **confirmado** |
| Botones de acción secundarios (Back, Skip) | pill pequeño ~14pt | — | tendencia |
| Section chips / labels | pill ~20pt+ | — | **confirmado** |
| Tab bar pills | pill flotante agrupado | plano sin pill visible | **confirmado** |
| Slider thumb | pill enorme (~50% ancho del track) | — | tendencia |
| Botones pill inversos (dark app) | — | pill ~999pt, blanco | tendencia |

**Sensación de forma:** redondeada a pill — **confirmado** (preferencia consistente por esquinas generosas y pills)

---

## Profundidad y elevación

**Sistema:** plano — **confirmado** (CERO sombras visibles. La jerarquía viene de contraste background/card)

| Nivel | Tratamiento | Cuándo usar |
|-------|-------------|-------------|
| Background | Crema #F5F0EB | Fondo de pantalla |
| Cards | Blanco #FFFFFF | Contenido agrupado |
| Sheets / modales | — | sin definir |
| Overlays | — | sin definir |

> **Decisión de diseño:** Este estilo evita sombras completamente. La diferencia crema ↔ blanco hace el trabajo que en otras apps hacen los `drop shadow`. Mantener esta decisión — las sombras romperían la limpieza.

---

## Componentes distintivos — Mejoras sobre HIG estándar

Estos son los patrones que definen este estilo y lo diferencian del HIG genérico. El UX designer debe priorizarlos sobre los componentes estándar equivalentes.

### Tab bar — Pill flotante agrupado
**Descripción:** NO es el `TabBar` estándar de iOS. Es un grupo de pills flotantes en el bottom. Las tabs de navegación van agrupadas en un pill izquierdo (ej. "Me" + "Friends"), y la acción principal (+) en un pill derecho separado. Fondo del pill: gris claro / blanco. Sin glass.

**Estado:** **confirmado** — es uno de los sellos visuales más claros del estilo.

**Nota iOS 26:** Candidato para adoptar Liquid Glass en el pill container. Usar `.glassEffect(.regular)` en el contenedor pill si se actualiza a iOS 26.

### Section chips / labels
**Descripción:** Pequeños pill labels de color que identifican la sección de cada card. Tienen fondo tintado (lavanda, azul claro, naranja claro) + icóno + texto Semibold ~13pt. Aparecen en la esquina superior izquierda de la card.

**Colores de chips:**
- Summary: lavanda `#EAE8FD` bg, texto/icóno `#9B8FF5`
- Calories / Meals: azul claro `#E3F2FF` bg, texto/icóno `#3399FF`
- Daily goal: naranja claro `#FFF0E8` bg, texto/icóno `#FF6830`

**Estado:** **confirmado** — uno de los elementos más originales y reconocibles del estilo.

### Display numeral
**Descripción:** Números de datos prominentes (calorías, porcentajes) en peso Black/Heavy ~60–70pt. El porcentaje `%` va en tamaño menor (~22pt) junto al número. Sin contenedor — el número domina la card visualmente.

**Estado:** **confirmado** — crea impacto visual y claridad en datos.

### Botón CTA primario full-width
**Descripción:** Negro `#000000`, pill full-width con ~56pt de alto, texto blanco Semibold ~17pt. Sin iconos. Muy prominente. Anclado al bottom de la pantalla (o de la sección).

**Estado:** **confirmado** (aparece en múiltiples pantallas de onboarding y main).

### Custom NavBar
**Descripción:** NO es la `UINavigationBar` estándar. Logo/nombre de app a la izquierda en Bold, contexto (fecha, subtitulo) en gris junto al nombre. Botones de acción a la derecha en pills pequeños. Sin borde inferior.

**Estado:** tendencia (solo Nutrie).

### Slider custom pill
**Descripción:** Track pill ancho, thumb que es un pill grande (~50% del track de ancho), iconos ilustrativos en los extremos (tortuga/conejo, lento/rápido). Muy expresivo y diferente al system slider.

**Estado:** tendencia (1 referencia).

---

## Componentes estándar iOS

### Listas / rows
- Estilo: no visible en estas referencias — sin definir

### Sheets / modales
- Estilo: sin definir

---

## Liquid Glass (iOS 26 readiness)

**Adopción en referencias:** ninguna (ambas apps son pre-iOS 26)

**Estrategia recomendada para apps nuevas:**

| Componente | Acción | Variante |
|------------|--------|----------|
| Tab bar pill flotante | Aplicar `.glassEffect(.regular)` al container | Regular |
| NavBar custom | Aplicar `.glassEffect(.regular)` si flota sobre contenido | Regular |
| Sheets / popovers | Usar Liquid Glass automático del sistema | Regular |
| Section chips en cards | Mantener tintado opaco — NO glass (content layer) | Sin glass |
| Cards | Mantener blanco opaco — NO glass (content layer) | Sin glass |
| Display numerals | Mantener opaco — NO glass | Sin glass |
| Botón CTA negro full-width | Evaluar `.buttonStyle(.glassProminent)` para iOS 26 | Regular |
| Botones secundarios (Back, Skip) | `.buttonStyle(.glass)` | Regular |

**Fallback (Reduce Transparency ON):** el diseño base ya es opaco (crema + blanco), por lo que degrada perfectamente sin cambios adicionales.

### Accesibilidad confirmada
- Fallback opaco diseñado: **sí** (las referencias ya son 100% opacas)
- Contraste verificado: pendiente (verificar crema #F5F0EB vs texto secundario #8E8E93)

---

## Iconografía

**Estilo:** mix — SF Symbols-adjacent + custom illustrations — *tendencia*  
**Presencia:** moderada — **confirmado**  
**Uso:** pequeños dentro de chips, items de tab bar, iconos en cards de grid

---

## Sensación general

**Palabras clave:** cálido, limpio, expresivo, datos-primero

**Descripción:** Un estilo que respeta la plataforma Apple pero agrega personalidad propia. Usa el vocabulario de iOS (pills, SF-ish icons, spacing generoso) y lo eleva con un fondo crema que aporta calor, chips de sección con color que aportan estructura, y números display que aportan impacto. La ausencia total de sombras hace todo flotar limpiamente.

---

## Decisiones de estilo

1. **Fondo crema en lugar de systemGroupedBackground** — decisión consciente. Aporta calidez y diferenciación. Mantener en light mode.
2. **Tab bar pill flotante en lugar de UITabBar estándar** — preferencia explícita del usuario. Es un "Apple improvement".
3. **Section chips como etiquetas de card** — patrón original, no HIG. Usar en todas las apps.
4. **Sin sombras** — toda la jerarquía por contraste de color. No introducir sombras.

---

## Preguntas abiertas

- [ ] ¿Cuando se adopte iOS 26, se quiere glass en el tab bar pill o se mantiene opaco?
- [ ] ¿El fondo crema aplica también en macOS (sidebar background) o solo en iOS?
- [ ] ¿Los section chips van en todas las apps o solo en apps de datos/salud?
- [ ] ¿Contrastar #F5F0EB vs texto secundario #8E8E93 — verificar ratio WCAG?

---

## Log de referencias

| Fecha | Fuente / App | Plataforma | Liquid Glass | Aportación principal |
|-------|-------------|------------|--------------|---------------------|
| 2026-05-31 | App de experimentos/hábitos (dark) | iOS | No | Dark mode: negro puro + charcoal cards, pill button blanco, iconografía custom |
| 2026-05-31 | Nutrie (nutrition tracker) | iOS | No | Crema background, tab bar pill flotante, section chips, display numerals, CTA full-width negro |
