# Style DNA — [App Name]

> Documento vivo. Actualizado por `steve-ui` con cada screenshot de referencia nuevo.  
> Última actualización: —  
> Referencias analizadas: 0 (iOS: 0, macOS: 0)

---

## Sistema de color

| Token | iOS | macOS | Estado |
|-------|-----|-------|--------|
| Background | — | — | sin definir |
| Surface / cards | — | — | sin definir |
| Acento primario | — | — | sin definir |
| Acento secundario | — | — | sin definir |
| Texto primario | — | — | sin definir |
| Texto secundario | — | — | sin definir |
| Destructivo | — | — | sin definir |
| Borde / divisor | — | — | sin definir |

**Modo:** light / dark / adaptivo — *sin definir*

---

## Tipografía

| Rol | Peso | Tamaño (pt) | Estado |
|-----|------|-------------|--------|
| Large Title | — | — | sin definir |
| Title | — | — | sin definir |
| Headline | — | — | sin definir |
| Body | — | — | sin definir |
| Callout | — | — | sin definir |
| Caption | — | — | sin definir |

**Densidad:** *sin definir* | **Sistema de fuente:** SF Pro / custom — *sin definir*

---

## Espaciado

| Contexto | Valor (pt) | Estado |
|----------|-----------|--------|
| Padding de cards | — | sin definir |
| Margen de página | — | sin definir |
| Gap entre secciones | — | sin definir |
| Altura de list row | — | sin definir |

---

## Forma — Continuous Corners + Nested Radius

### Regla 1: Continuous Corners universales (absoluta, sin excepciones)

```
SwiftUI:      RoundedRectangle(cornerRadius: x, style: .continuous)
UIKit/AppKit: layer.cornerRadius = x + layer.cornerCurve = .continuous
NUNCA:        style: .circular
```

### Regla 2: Radio anidado — r_inner = r_outer − padding

```
r_inner = r_outer − padding          // siempre
r_inner = max(r_outer − padding, 0)  // nunca negativo

// Anidamiento múltiple:
r_level_1 = r_outer − padding_1
r_level_2 = r_level_1 − padding_2

// iOS 26 — automático:
ZStack { ConcentricRectangle().padding(padding) }
    .containerShape(.rect(cornerRadius: r_outer, style: .continuous))
```

**Sistema de radios:**

| Componente | r_outer | padding | r_inner | Estado |
|------------|---------|---------|---------|--------|
| Card grande | — | — | r_outer − padding | sin definir |
| Card grid | — | — | r_outer − padding | sin definir |
| Botón CTA | pill 999pt | — | — | sin definir |
| Section chips | pill | — | — | sin definir |
| Tab bar container | pill | — | — | sin definir |
| Inputs | — | — | — | sin definir |
| Sheets | — | — | r_outer − padding | sin definir |

---

## Profundidad y elevación

**Sistema:** plano / sombras sutiles / blur·glass — *sin definir*

---

## Liquid Glass

> Regla: SOLO en navigation layer. NUNCA en content layer.

**Adopción:** *sin definir*

| Componente | Variante | Estado |
|------------|----------|--------|
| Tab bar | Regular / Clear | sin definir |
| NavigationBar / Toolbar | Regular / Clear | sin definir |
| Sidebar (macOS/iPad) | Regular / Clear | sin definir |
| Botones CTA | .glassProminent | sin definir |
| Botones secundarios | .glass | sin definir |

**Nested glass:** `ConcentricRectangle().glassEffect()` — r_inner automático iOS 26.

---

## Componentes — iOS

Botones / Listas / Cards / Navegación / Tab bar: *sin definir*

---

## Componentes — macOS

Material / Título bar / Sidebar / Toolbar / Inspector / Vibrancy: *sin definir*

---

## Iconografía

**Estilo:** *sin definir* | **Presencia:** *sin definir*

---

## Sensación general

**Palabras clave:** *sin definir — añadir después del primer análisis*

---

## Decisiones de estilo

*Sin decisiones todavía.*

---

## Preguntas abiertas

- [ ] *Ninguna todavía — comparte tu primer screenshot de referencia para empezar*

---

## Log de referencias

| Fecha | Fuente / App | Plataforma | Liquid Glass | Aportación principal |
|-------|-------------|------------|--------------|---------------------|
| — | — | — | — | — |
