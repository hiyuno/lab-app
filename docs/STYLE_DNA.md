# Style DNA — Lab App Reference

> Documento vivo. Actualizado por `steve-ui` con cada screenshot de referencia nuevo.  
> Última actualización: 2026-05-31  
> Referencias analizadas: 3 (iOS: 3, macOS: 0)  
> **Versión target:** sin definir ← *actualizar al crear cada proyecto*

---

## Sistema de color

| Token | Light mode | Dark mode | Estado |
|-------|-----------|-----------|--------|
| Background | `#F5F0EB` — crema cálida custom | `#000000` puro | **confirmado** |
| Surface / cards | `#FFFFFF` | `#1C1C1E` charcoal | **confirmado** |
| Acento primario | `#3399FF` azul | `#FFFFFF` | tendencia |
| Acento secundario | `#9B8FF5` lavanda | — | tendencia |
| Acento terciario | `#FF6830` naranja | — | tendencia |
| Texto primario | `#000000` / `#1C1C1E` | `#FFFFFF` | **confirmado** |
| Texto secundario | `#8E8E93` | `#8E8E93` | **confirmado** |
| Borde / divisor | ninguno — contraste crea jerarquía | ninguno | **confirmado** |
| CTA Button bg | `#000000` | `#FFFFFF` | **confirmado** |
| CTA Button text | `#FFFFFF` | `#000000` | **confirmado** |

**Modo:** adaptivo light/dark — **confirmado**

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
| Botón CTA full-width | pill 999pt | — | — (pill siempre) | Continuous |
| Tab bar pill container | pill 999pt | ~10pt vertical, ~8pt horizontal | — (pill) | Continuous |
| Tab activo inner bubble | pill 999pt | ~8pt (tab padding) | ~991pt (pill) | Continuous |
| Section chips | pill ~20pt | — | — | Continuous |
| Inputs | ~12–14pt | — | — | Continuous |
| Mini stat cards | ~16pt | ~12pt | ~4pt | Continuous |

**Anidamiento múltiple:**
```
r_level_1 = r_outer − padding_1
r_level_2 = r_level_1 − padding_2
// Nunca resultado negativo: max(r, 0)
```

---

## Profundidad y elevación

**Sistema:** plano — **confirmado** (CERO sombras. Jerarquía por contraste background/card)

---

## Componentes distintivos — Mejoras sobre HIG estándar

### Tab bar — Pill flotante con inner bubble

Floating pill con material translucido (Liquid Glass en iOS 26+, `ultraThinMaterial` en iOS 15–25). Tab activo tiene un inner bubble más claro — ejemplo perfecto de `r_inner = r_outer − padding`.

**Especificaciones (confirmado):**
- Container: Capsule pill, ~72pt alto, padding ~10pt vertical / ~8pt horizontal
- Tab activo: inner Capsule pill, `r_inner = 999 − 8 ≈ 991pt` (aún pill)
- Ícono activo: SF Symbol fill, color `accentColor` (azul)
- Ícono inactivo: SF Symbol regular, blanco opacity ~80%
- Label: ~10pt Regular, mismo color que ícono
- Gap icon→label: ~4pt
- No es UITabBar — es custom floating, flotante sobre el contenido

**Implementación SwiftUI:**

```swift
// LiquidTabBar — iOS 26+ Liquid Glass + iOS 15–25 Material fallback
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
        .modifier(GlassCapsule())       // outer pill glass
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
            .modifier(GlassActiveTab(isSelected: selected))  // inner bubble
        }
        .buttonStyle(.plain)
    }
}

// Outer pill: Liquid Glass iOS 26+ / ultraThinMaterial iOS 15–25
struct GlassCapsule: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 26, macOS 26, *) {
            content.background { Capsule().glassEffect(.regular) }
        } else {
            content.background(.ultraThinMaterial, in: Capsule())
        }
    }
}

// Inner bubble activo: ConcentricRectangle iOS 26 / white opacity iOS 15–25
// r_inner = r_outer − padding — calculado automáticamente por ConcentricRectangle
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

### Botón CTA full-width
Negro `#000000`, pill Continuous Corners, ~56pt alto. Anclado al bottom.  
**Estado:** **confirmado**

---

## Liquid Glass (iOS 26 readiness)

**En referencias:** ninguna (pre-iOS 26)

| Componente | Acción | Variante |
|------------|--------|----------|
| Tab bar pill | `Capsule().glassEffect(.regular)` | Regular |
| NavBar custom | `RoundedRectangle(…, .continuous).glassEffect(.regular)` si flota | Regular |
| Section chips | Mantener tintado opaco (content layer) | Sin glass |
| Cards | Blanco opaco (content layer) | Sin glass |
| Botón CTA | `.buttonStyle(.glassProminent)` | Regular |
| Botones secundarios | `.buttonStyle(.glass)` | Regular |

**Nested glass:** `ConcentricRectangle().glassEffect()` — r_inner calculado automáticamente.  
**Fallback Reduce Transparency:** diseño base ya es 100% opaco.

---

## Glass fallback por versión

| Componente | iOS 26+ (Liquid Glass) | iOS 15–25 (Material) | iOS 13–14 (UIKit) |
|---|---|---|---|
| Tab bar pill | `Capsule().glassEffect(.regular)` | `.background(.ultraThinMaterial, in: Capsule())` | `UIVisualEffectView(UIBlurEffect(style: .systemUltraThinMaterial))` + `cornerCurve = .continuous` |
| Tab activo bubble | `ConcentricRectangle().glassEffect()` | `Capsule().fill(.white.opacity(0.15))` | `UIVisualEffectView` + `UIVibrancyEffect(.fill)` |
| NavBar flotante | `RoundedRectangle(…, .continuous).glassEffect(.regular)` | `.background(.ultraThinMaterial)` + clip | `UINavigationBarAppearance` + blur |
| Botón CTA | `.buttonStyle(.glassProminent)` | Fill `#000000` (ya es el default) | Fill `#000000` |
| Botones secundarios | `.buttonStyle(.glass)` | `.background(.thinMaterial, in: Capsule())` | `UIVisualEffectView` + vibrancy |
| Section chips | Opaco tintado (content layer — sin cambio) | Opaco tintado | Opaco tintado |
| Cards | Blanco opaco (content layer — sin cambio) | Blanco opaco | Blanco opaco |

**ViewModifiers reutilizables:** `GlassCapsule`, `GlassActiveTab`, `GlassCompat` — ver `.cursor/skills/steve-ui/SKILL.md`.

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
4. **Tab bar pill flotante con inner bubble** — floating Capsule glass, tab activo con `ConcentricRectangle().glassEffect()` (iOS 26+) o `white.opacity(0.15)` (iOS 15–25). No UITabBar.
5. **Section chips** como etiquetas de card — usar en todas las apps.
6. **Sin sombras** — jerarquía por contraste de color.

---

## Preguntas abiertas

- [ ] ¿Versión target mínima para el primer proyecto?
- [ ] ¿Glass en tab bar pill al adoptar iOS 26, o mantener opaco?
- [ ] ¿Fondo crema aplica también en macOS?
- [ ] ¿Section chips en todas las apps o solo apps de datos?
- [ ] Verificar WCAG: crema `#F5F0EB` vs texto secundario `#8E8E93`

---

## Log de referencias

| Fecha | Fuente / App | Plataforma | Liquid Glass | Aportación principal |
|-------|-------------|------------|--------------|---------------------|
| 2026-05-31 | App experimentos/hábitos (dark) | iOS | No | Dark mode negro + charcoal cards, pill CTA blanco |
| 2026-05-31 | Nutrie (nutrition tracker) | iOS | No | Crema bg, section chips, display numerals, CTA negro |
| 2026-05-31 | GitHub iOS — tab bar liquid | iOS | Parcial (simulado) | Floating pill glass + inner active bubble (r_inner = r_outer − padding confirmado) |
