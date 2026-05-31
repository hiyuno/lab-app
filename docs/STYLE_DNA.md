# Style DNA — Lab App Reference

> Documento vivo. Actualizado por `jonny-ui-ux` con cada screenshot de referencia nuevo.  
> Última actualización: 2026-05-31  
> Referencias analizadas: 7 (iOS: 7, macOS: 0)  
> **Versión target:** sin definir ← *actualizar al crear cada proyecto*

---

## Sistema de color

| Token | Light mode | Dark mode | Estado |
|-------|-----------|-----------|--------|
| Background | `#F5F0EB` — crema cálida custom | `#000000` puro | **confirmado** |
| Surface / cards | `#FFFFFF` | `#1C1C1E` charcoal | **confirmado** |
| Surface elevada | — | `#2C2C2E` (un nivel sobre cards) | **confirmado** |
| Acento primario | `#3399FF` azul | `#FFFFFF` | tendencia |
| Acento secundario | `#9B8FF5` lavanda | — | tendencia |
| Acento terciario | `#FF6830` naranja | — | tendencia |
| Texto primario | `#000000` / `#1C1C1E` | `#FFFFFF` | **confirmado** |
| Texto secundario | `#8E8E93` | `#8E8E93` | **confirmado** |
| Borde / divisor | ninguno o `#3C3C3C` sutil | `#3C3C3C` sutil | **confirmado** |
| CTA Button bg (primario) | `#000000` | `#FFFFFF` | **confirmado** |
| CTA Button bg (secundario) | — | `#2C2C2E` fill | **confirmado** |
| CTA Button text | `#FFFFFF` | `#000000` / `#FFFFFF` | **confirmado** |

**Modo:** adaptivo light/dark — **confirmado**

### Gradiente de fondo (pantallas premium / resumen)

Alternativa al fondo sólido para pantallas tipo Summary/Dashboard:
- Gradiente naranja-coral (`#C04A1A`) → púrpura-índigo (`#3730A3`) vertical
- Cards `#1C1C1E` encima del gradiente (content layer opaco)
- **Estado:** tendencia (Health app)

---

## Tipografía

| Rol | Peso | Tamaño (pt) | Estado |
|-----|------|-------------|--------|
| Large Title | Bold / Black | ~34pt | **confirmado** |
| Display numeral | Black / Heavy | ~60–70pt | **confirmado** |
| Title / Headline | Semibold | ~22–24pt | **confirmado** |
| Body | Regular | ~15–17pt | **confirmado** |
| Caption / metadata | Regular | ~12–13pt | **confirmado** |
| Tab bar labels | Regular | ~10pt | **confirmado** |

**Densidad:** balanceada-generosa — **confirmado**  
**Sistema de fuente:** SF Pro — **confirmado**

---

## Espaciado

| Contexto | Valor (pt) | Estado |
|----------|-----------|--------|
| Padding de cards | ~20pt | **confirmado** |
| Margen de página | ~20pt | **confirmado** |
| Gap entre cards | ~14–16pt | **confirmado** |
| Gap entre secciones | ~24–28pt | **confirmado** |

---

## Forma — Continuous Corners + Nested Radius

### Regla 1: Continuous Corners universales

> **TODOS los bordes redondeados usan Continuous Corners.**  
> SwiftUI: `RoundedRectangle(cornerRadius: x, style: .continuous)`  
> UIKit/AppKit: `layer.cornerCurve = .continuous`  
> NUNCA `style: .circular`.

### Regla 2: Radio anidado — r_inner = r_outer − padding

> **Todo elemento dentro de un contenedor redondeado debe usar:**  
> `r_inner = r_outer − padding`

iOS 26: usar `ConcentricRectangle()` + `.containerShape(.rect(cornerRadius: x, style: .continuous))` para cálculo automático.

**Sistema de radios de este estilo:**

| Componente | r_outer | padding interno | r_inner | Curva |
|------------|---------|----------------|---------|-------|
| Card grande (feature) | ~24pt | ~20pt (contenido) | ~4pt | Continuous |
| Card grid | ~20pt | ~16pt | ~4pt | Continuous |
| Card con section chip | ~20pt | ~8pt (chip margin) | ~12pt | Continuous |
| Sheet / modal | ~28pt | ~20pt | ~8pt | Continuous |
| Botón CTA primario (pill) | pill 999pt | — | — (pill siempre) | Continuous |
| Botón CTA secundario | ~14pt | — | — | Continuous |
| Tab bar pill container | pill 999pt | ~10pt vertical, ~8pt horizontal | — (pill) | Continuous |
| Tab activo inner bubble | pill 999pt | ~8pt (tab padding) | ~991pt (pill) | Continuous |
| Section chips | pill ~20pt | — | — | Continuous |
| Inputs | ~12–14pt | — | — | Continuous |
| Mini stat cards | ~16pt | ~12pt | ~4pt | Continuous |
| Settings-style grouped list | ~16pt | — | — | Continuous |
| Icon badge (settings row) | ~12pt | — | — | Continuous |

**Anidamiento múltiple:**
```
r_level_1 = r_outer − padding_1
r_level_2 = r_level_1 − padding_2
// Nunca resultado negativo: max(r, 0)
```

---

## Profundidad y elevación

**Sistema:** plano — **confirmado** (CERO sombras. Jerarquía por contraste background/card)

**Niveles de elevación en dark:**
- Nivel 0: `#000000` fondo
- Nivel 1: `#1C1C1E` cards
- Nivel 2: `#2C2C2E` elementos elevados (CTA secundario, rows activos, tab bar container)
- Nivel 3: `#3A3A3C` estados pressed / separadores

---

## Componentes distintivos

### Tab bar — Dos variantes confirmadas

#### Variante A — Pill flotante con inner bubble activo
Floating pill glass. Tab activo con inner bubble más claro. Ejemplo: GitHub iOS, nuestro estilo base.

**Especificaciones:**
- Container: Capsule pill, ~72pt alto, padding ~10pt / ~8pt
- Tab activo: inner Capsule, `r_inner = 999 − 8 = 991pt` (aún pill)
- Ícono activo: SF Symbol fill, `accentColor`
- Ícono inactivo: SF Symbol regular, blanco 80%

```swift
struct LiquidTabBar: View {
    @Binding var selection: Int
    let items: [(icon: String, selectedIcon: String, label: String)]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { i, item in
                tabItem(index: i, item: item)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 8)
        .modifier(GlassCapsule())
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }

    @ViewBuilder
    private func tabItem(
        index: Int,
        item: (icon: String, selectedIcon: String, label: String)
    ) -> some View {
        let selected = selection == index
        Button {
            withAnimation(.spring(duration: 0.25)) { selection = index }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: selected ? item.selectedIcon : item.icon)
                    .font(.system(size: 22))
                Text(item.label)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundStyle(selected ? Color.accentColor : .white.opacity(0.8))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .modifier(GlassActiveTab(isSelected: selected))
        }
        .buttonStyle(.plain)
    }
}

struct GlassCapsule: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, macOS 26, *) {
            content.background { Capsule().glassEffect(.regular) }
        } else {
            content.background(.ultraThinMaterial, in: Capsule())
        }
    }
}

struct GlassActiveTab: ViewModifier {
    let isSelected: Bool
    func body(content: Content) -> some View {
        content.background {
            if isSelected {
                if #available(iOS 26, macOS 26, *) {
                    ConcentricRectangle().glassEffect()
                } else {
                    Capsule().fill(.white.opacity(0.15))
                }
            }
        }
    }
}
```

#### Variante B — Pill flotante activo-por-color (sin bubble)
Floating pill opaco. Tab activo solo cambia color de ícono+label. Ejemplo: Watch app, Health app.

**Especificaciones:**
- Container: Capsule pill, ~56pt alto, padding ~8pt / ~6pt
- Tab activo: sin bubble — solo icon+label en `accentColor`
- Container: `#2C2C2E` opaco o `.thinMaterial`

```swift
struct CompactTabBar: View {
    @Binding var selection: Int
    let items: [(icon: String, selectedIcon: String, label: String, accent: Color)]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { i, item in
                let selected = selection == i
                Button {
                    withAnimation(.spring(duration: 0.2)) { selection = i }
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: selected ? item.selectedIcon : item.icon)
                            .font(.system(size: 20))
                        Text(item.label)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(selected ? item.accent : .white.opacity(0.8))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 8)
        .background(.thinMaterial, in: Capsule())
    }
}
```

**Estado:** **confirmado** (ambas variantes)

---

### Botón CTA — Primario vs Secundario

| Tipo | Forma | Fill | Uso |
|------|-------|------|-----|
| **Primario** | Pill Capsule 999pt | `#000000` (light) / `#FFFFFF` (dark) | Acción principal, anchored bottom |
| **Secundario** | `~14pt` Continuous Corners | `#2C2C2E` fill | Acción de apoyo, inline (e.g. "Start Pairing") |
| **Glass** (iOS 26+) | cualquier forma | `.glassProminent` / `.glass` | Acciones en nav layer |

**Estado:** **confirmado**

---

### Section chips / labels
Pill labels de color (Continuous Corners) en esquina superior izquierda de cards.
- Summary: bg `#EAE8FD`, texto `#9B8FF5`
- Calories/Meals: bg `#E3F2FF`, texto `#3399FF`
- Daily goal: bg `#FFF0E8`, texto `#FF6830`

**Estado:** **confirmado**

### Display numeral
Black/Heavy ~60–70pt. Sin contenedor. Domina la card.  
**Estado:** **confirmado**

### FAB search / acción flotante junto a tab bar
Botón círculo flotante al lado del tab bar pill. Diámetro ~52pt. Fill `.thinMaterial` o `#2C2C2E`.  
**Estado:** tendencia (Health app)

### Settings-style grouped list
Lista agrupada: `#1C1C1E` card ~16pt Continuous Corners, separadores `#3C3C3C`, icon badge + título + chevron.  
**Estado:** tendencia (Settings app)

---

## Liquid Glass (iOS 26 readiness)

**En referencias:** ninguna (todas pre-iOS 26)

| Componente | Acción | Variante |
|------------|--------|----------|
| Tab bar pill (A y B) | `Capsule().glassEffect(.regular)` | Regular |
| NavBar custom | `RoundedRectangle(…, .continuous).glassEffect(.regular)` si flota | Regular |
| Section chips | Mantener tintado opaco (content layer) | Sin glass |
| Cards | Opaco (content layer) | Sin glass |
| Botón CTA primario | `.buttonStyle(.glassProminent)` | Regular |
| Botón CTA secundario | `.buttonStyle(.glass)` | Regular |
| FAB search | `Circle().glassEffect(.regular)` | Regular |

**Fallback Reduce Transparency:** diseño base ya es 100% opaco.

---

## Glass fallback por versión

| Componente | iOS 26+ (Liquid Glass) | iOS 15–25 (Material) | iOS 13–14 (UIKit) |
|---|---|---|---|
| Tab bar pill | `Capsule().glassEffect(.regular)` | `.background(.ultraThinMaterial, in: Capsule())` | `UIVisualEffectView(UIBlurEffect(style: .systemUltraThinMaterial))` |
| Tab activo bubble | `ConcentricRectangle().glassEffect()` | `Capsule().fill(.white.opacity(0.15))` | `UIVisualEffectView` + vibrancy |
| NavBar flotante | `RoundedRectangle(…, .continuous).glassEffect(.regular)` | `.background(.ultraThinMaterial)` + clip | `UINavigationBarAppearance` + blur |
| Botón CTA primario | `.buttonStyle(.glassProminent)` | Fill `#000000` / `#FFFFFF` | Fill sólido |
| Botón CTA secundario | `.buttonStyle(.glass)` | `.background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))` | `UIVisualEffectView` + clip |
| FAB search | `Circle().glassEffect(.regular)` | `.background(.thinMaterial, in: Circle())` | `UIVisualEffectView` circular |
| Section chips | Opaco tintado (content layer) | Opaco tintado | Opaco tintado |
| Cards | Opaco (content layer) | Opaco | Opaco |

**ViewModifiers reutilizables:** `GlassCapsule`, `GlassActiveTab`, `GlassCompat` — ver `.cursor/skills/jonny-ui-ux/SKILL.md`.

---

## Iconografía

**Estilo:** mix SF Symbols + custom — tendencia | **Presencia:** moderada — **confirmado**

---

## Sensación general

**Palabras clave:** cálido, limpio, expresivo, datos-primero, Continuous Corners everywhere

---

## Decisiones de estilo

1. **Continuous Corners universales** — `style: .continuous` en absolutamente todo.
2. **r_inner = r_outer − padding** — regla obligatoria en todos los contenedores anidados. iOS 26: `ConcentricRectangle`.
3. **Fondo crema** `#F5F0EB` en lugar de systemGroupedBackground.
4. **Tab bar pill flotante** — dos variantes: A (inner bubble) o B (activo-por-color). No UITabBar estándar.
5. **Section chips** como etiquetas de card.
6. **Sin sombras** — jerarquía por contraste de color.
7. **CTA secundario** — `#2C2C2E` fill + ~14pt Continuous Corners (no pill).

---

## Preguntas abiertas

- [ ] ¿Versión target mínima para el primer proyecto?
- [ ] ¿Tab bar Variante A (bubble) o Variante B (activo-por-color) como default?
- [ ] ¿Gradiente de fondo (Health-style) para pantallas Summary/Dashboard?
- [ ] ¿FAB search junto al tab bar o búsqueda inline?
- [ ] ¿Fondo crema aplica también en macOS?
- [ ] Verificar WCAG: crema `#F5F0EB` vs texto secundario `#8E8E93`

---

## Log de referencias

| Fecha | Fuente / App | Plataforma | Liquid Glass | Aportación principal |
|-------|-------------|------------|--------------|---------------------|
| 2026-05-31 | App experimentos/hábitos (dark) | iOS | No | Dark mode negro + charcoal cards, pill CTA blanco |
| 2026-05-31 | Nutrie (nutrition tracker) | iOS | No | Crema bg, section chips, display numerals, CTA negro |
| 2026-05-31 | GitHub iOS — tab bar liquid | iOS | Parcial (simulado) | Floating pill glass + inner active bubble (r_inner confirmado) |
| 2026-05-31 | iOS Settings.app | iOS | No | Grouped list ~16pt, icon badges, `#1C1C1E` cards, separadores sutiles |
| 2026-05-31 | Apple Watch.app — Face Gallery | iOS | No | Compact 3-tab pill, activo-por-color (naranja), Variante B confirmada |
| 2026-05-31 | Apple Watch.app — My Watch | iOS | No | CTA secundario `#2C2C2E` ~14pt Continuous Corners (no pill) |
| 2026-05-31 | Health.app — Summary | iOS | No | Gradiente bg naranja→púrpura, FAB search junto a tab bar, activo-por-color azul |
