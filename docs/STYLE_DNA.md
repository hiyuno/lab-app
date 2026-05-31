# Style DNA — Lab App Reference

> Documento vivo. Actualizado por `steve-ui` con cada screenshot de referencia nuevo.  
> Última actualización: 2026-05-31  
> Referencias analizadas: 2 (iOS: 2, macOS: 0)

---

## Sistema de color

| Token | Light mode | Dark mode | Estado |
|-------|-----------|-----------|--------|
| Background | `#F5F0EB` — crema cálida custom (NO systemGroupedBackground) | `#000000` puro | **confirmado** |
| Surface / cards | `#FFFFFF` blanco puro | `#1C1C1E` charcoal (systemGray6 dark) | **confirmado** |
| Acento primario | `#3399FF` azul vivo | `#FFFFFF` blanco | tendencia |
| Acento secundario | `#9B8FF5` lavanda | — | tendencia |
| Acento terciario | `#FF6830` naranja/fuego | — | tendencia |
| Texto primario | `#000000` / `#1C1C1E` | `#FFFFFF` | **confirmado** |
| Texto secundario | `#8E8E93` gris medio | `#8E8E93` | **confirmado** |
| Borde / divisor | ninguno — contraste background/card crea jerarquía | ninguno | **confirmado** |
| CTA Button bg | `#000000` negro puro | `#FFFFFF` blanco | **confirmado** |
| CTA Button text | `#FFFFFF` blanco | `#000000` negro | **confirmado** |

**Modo:** adaptivo light/dark — **confirmado**

> **Nota clave:** El fondo crema `#F5F0EB` es deliberado. Las cards blancas sobre crema crean jerarquía sin sombras.

---

## Tipografía

| Rol | Peso | Tamaño (pt) | Estado |
|-----|------|-------------|--------|
| Large Title | Bold / Black | ~34pt | **confirmado** |
| Display numeral (datos prominentes) | Black / Heavy | ~60–70pt | **confirmado** |
| Title / Headline de pantalla | Semibold | ~22–24pt | **confirmado** |
| Body | Regular | ~15–17pt | **confirmado** |
| Caption / metadata | Regular | ~12–13pt | **confirmado** |
| Tab bar labels | Regular | ~10pt | **confirmado** |

**Densidad:** balanceada-generosa — **confirmado**  
**Sistema de fuente:** SF Pro (sistema) — **confirmado**

---

## Espaciado

| Contexto | Valor (pt) | Estado |
|----------|-----------|--------|
| Padding de cards | ~20pt | **confirmado** |
| Margen de página | ~20pt | **confirmado** |
| Gap entre cards | ~14–16pt | **confirmado** |
| Gap entre secciones | ~24–28pt | **confirmado** |

---

## Forma — Continuous Corners

> **Regla universal: TODOS los bordes redondeados usan Continuous Corners, sin excepciones.**  
> SwiftUI: `RoundedRectangle(cornerRadius: x, style: .continuous)`  
> UIKit / AppKit: `layer.cornerRadius = x` + `layer.cornerCurve = .continuous`  
> **NUNCA** usar `style: .circular`. Continuous Corners en cards, botones, chips, pills, tabs, inputs, imágenes, sliders, sheets — absolutamente todo.

| Componente | Corner radius | Curva | Estado |
|------------|--------------|-------|--------|
| Cards grandes (feature) | ~20–24pt | Continuous Corners | **confirmado** |
| Cards grid (pequeñas) | ~16–18pt | Continuous Corners | **confirmado** |
| Botón CTA primario | pill ~999pt | Continuous Corners | **confirmado** |
| Botones pill secundarios (Back, Skip) | ~14pt | Continuous Corners | **confirmado** |
| Section chips / labels | ~20pt+ (pill) | Continuous Corners | **confirmado** |
| Tab bar pill container | ~999pt (pill) | Continuous Corners | **confirmado** |
| Input fields | ~12–14pt | Continuous Corners | sin definir radio |
| Slider thumb | pill grande | Continuous Corners | tendencia |
| Mini stat cards | ~14–16pt | Continuous Corners | **confirmado** |
| Sheets / modales | ~20–24pt (top) | Continuous Corners | sin definir radio |

**Sensación de forma:** Continuous Corners uniforme en todo el sistema — **confirmado (regla absoluta)**

---

## Profundidad y elevación

**Sistema:** plano — **confirmado** (CERO sombras. Jerarquía únicamente por contraste background/card)

| Nivel | Tratamiento |
|-------|-------------|
| Background | Crema `#F5F0EB` |
| Cards | Blanco `#FFFFFF` |
| Sheets / modales | sin definir |
| Overlays | sin definir |

---

## Componentes distintivos — Mejoras sobre HIG estándar

### Tab bar — Pill flotante agrupado (Continuous Corners)
NO es el `TabBar` estándar de iOS. Pills flotantes en el bottom: tabs de navegación en pill izquierdo agrupado, acción principal (+) en pill derecho. Todos con `style: .continuous`.  
**Estado:** **confirmado**

**Nota iOS 26:** Candidato para `.glassEffect(.regular)` en el pill container.

### Section chips / labels (Continuous Corners)
Pequeños pill labels de color que identifican la sección de cada card. Fondo tintado + icóno + texto Semibold ~13pt. Esquina superior izquierda de la card.

**Colores:**
- Summary: bg `#EAE8FD`, texto/icóno `#9B8FF5`
- Calories / Meals: bg `#E3F2FF`, texto/icóno `#3399FF`
- Daily goal: bg `#FFF0E8`, texto/icóno `#FF6830`

**Estado:** **confirmado**

### Display numeral
Números de datos en Black/Heavy ~60–70pt. `%` en ~22pt. Sin contenedor.  
**Estado:** **confirmado**

### Botón CTA primario full-width
Negro `#000000`, pill full-width con Continuous Corners, ~56pt alto, texto blanco Semibold ~17pt.  
**Estado:** **confirmado**

### Custom NavBar
Logo/nombre en Bold izquierda, contexto en gris. Botones de acción en pills Continuous Corners a la derecha.  
**Estado:** tendencia

---

## Liquid Glass (iOS 26 readiness)

**En referencias:** ninguna (pre-iOS 26)

| Componente | Acción | Variante |
|------------|--------|----------|
| Tab bar pill flotante | `.glassEffect(.regular)` + `style: .continuous` | Regular |
| NavBar custom | `.glassEffect(.regular)` si flota sobre contenido | Regular |
| Sheets / popovers | Glass automático del sistema | Regular |
| Section chips en cards | Mantener tintado opaco (content layer) | Sin glass |
| Cards | Blanco opaco (content layer) | Sin glass |
| Botón CTA | `.buttonStyle(.glassProminent)` | Regular |
| Botones secundarios | `.buttonStyle(.glass)` | Regular |

**Fallback Reduce Transparency:** diseño base ya es 100% opaco — degrada perfectamente.

---

## Iconografía

**Estilo:** mix SF Symbols + custom illustrations — tendencia  
**Presencia:** moderada — **confirmado**

---

## Sensación general

**Palabras clave:** cálido, limpio, expresivo, datos-primero, Continuous Corners everywhere

---

## Decisiones de estilo

1. **Continuous Corners universales** — `RoundedRectangle(cornerRadius:, style: .continuous)` en TODO. Sin excepciones. Es la decisión más transversal del sistema.
2. **Fondo crema** en lugar de systemGroupedBackground — aporta calidez.
3. **Tab bar pill flotante** en lugar de UITabBar estándar.
4. **Section chips** como etiquetas de card — usar en todas las apps.
5. **Sin sombras** — toda la jerarquía por contraste de color.

---

## Preguntas abiertas

- [ ] ¿Glass en tab bar pill al adoptar iOS 26, o mantener opaco?
- [ ] ¿El fondo crema aplica también en macOS?
- [ ] ¿Los section chips van en todas las apps o solo en apps de datos?
- [ ] Verificar ratio WCAG: crema `#F5F0EB` vs texto secundario `#8E8E93`

---

## Log de referencias

| Fecha | Fuente / App | Plataforma | Liquid Glass | Aportación principal |
|-------|-------------|------------|--------------|---------------------|
| 2026-05-31 | App de experimentos/hábitos (dark) | iOS | No | Dark mode negro puro + charcoal cards, pill Continuous Corners, iconografía custom |
| 2026-05-31 | Nutrie (nutrition tracker) | iOS | No | Crema background, tab bar pill flotante, section chips, display numerals, CTA full-width negro |
