# LeonTweets — Screens

Navigation model: single `WindowGroup` → `NavigationStack(path:)`.
State machine lives in `AppViewModel.navigationPath: [Destination]`.

---

## Screen 1 — LyricsInputView (root)

**Purpose:** User pastes or types Leon Larregui lyrics and triggers interpretation.

**Layout:**
```
┌─────────────────────────────────┐
│ [Nav title: LeonTweets]         │
├─────────────────────────────────┤
│                                 │
│  TextEditor (min height 220pt)  │
│  Placeholder: "Pega aquí la…"   │
│  (shown only when empty)        │
│                                 │
├─────────────────────────────────┤
│ [ErrorBannerView — conditional] │
├─────────────────────────────────┤
│                    [Interpretar]│
└─────────────────────────────────┘
```

**States:**
- **Empty**: placeholder visible, "Interpretar" disabled.
- **Has text**: placeholder hidden, "Interpretar" enabled.
- **Loading**: full-width semi-transparent overlay + `ProgressView("Interpretando…")`, button disabled.
- **Error**: `ErrorBannerView` visible with Spanish error message and dismiss (×) button.

**Keyboard shortcut:** ⌘↩ → "Interpretar".

---

## Screen 2 — InterpretationView

**Purpose:** Review GPT interpretation, edit the tweet draft, and post.

**Layout:**
```
┌─────────────────────────────────┐
│ [← Volver]    [Nav: Tu Tweet]   │
├─────────────────────────────────┤
│  ScrollView — GPT interpretation│
│  (read-only, secondary bg)      │
│  min height: 110pt              │
├─────────────────────────────────┤
│  TextEditor — tweet draft       │
│  (editable, min height: 100pt)  │
│                    [N / 280]    │
├─────────────────────────────────┤
│ [ErrorBannerView — conditional] │
├─────────────────────────────────┤
│ [← Volver]          [Publicar] │
└─────────────────────────────────┘
```

**States:**
- **Editing**: counter secondary color, "Publicar" enabled (when ≤280 and non-empty).
- **Over limit**: `N / 280` counter is red, "Publicar" disabled.
- **Posting**: full-width overlay + `ProgressView("Publicando…")`.
- **Success**: `successHUD` overlay (green checkmark + "¡Tweet publicado!"), auto-dismisses after 2s → resets to Screen 1.
- **Error**: `ErrorBannerView` with Spanish error message.

---

## Screen 3 — SettingsView (Settings scene, ⌘,)

**Purpose:** Enter and persist API credentials.

**Layout (Form, grouped style):**
```
┌─────────────────────────────────┐
│ Configuración de APIs  [Guardar]│
├─────────────────────────────────┤
│ OpenAI                          │
│   API Key: ••••••••             │
├─────────────────────────────────┤
│ X (Twitter) — OAuth 1.0a        │
│   API Key: ••••••••             │
│   API Secret: ••••••••          │
│   Access Token: ••••••••        │
│   Access Token Secret: ••••••   │
├─────────────────────────────────┤
│ [validation error — conditional]│
│ [saved confirmation — conditional]│
└─────────────────────────────────┘
```

**States:**
- **Loaded**: all fields pre-populated from Keychain (masked). "Guardar" disabled.
- **Changed**: "Guardar" enabled when any field differs from saved value.
- **Validation error**: red label + SF Symbol `exclamationmark.circle` below form sections.
- **Saved**: green label "Configuración guardada" auto-dismisses after 2s.

---

## Screen 4 — Success HUD (transient overlay on InterpretationView)

```
┌─────────────────────────────┐
│                             │
│    ✅  (52pt, green)        │
│  ¡Tweet publicado!          │
│                             │
└─────────────────────────────┘
```

- Appears as an overlay on `InterpretationView`.
- `.regularMaterial` background, `RoundedRectangle(cornerRadius: 18)`.
- Auto-dismisses after 2 seconds via `Task.sleep(for: .seconds(2))`.
- Triggers `appViewModel.reset()` → navigation returns to LyricsInputView.
