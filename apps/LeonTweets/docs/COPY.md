# LeonTweets — Copy

All user-facing strings. Language: Spanish (es).

## Main screens

| Location | Element | String |
|----------|---------|--------|
| LyricsInputView | TextEditor placeholder | "Pega aquí la letra de Leon Larregui…" |
| LyricsInputView | Interpret button | "Interpretar" |
| LyricsInputView | Loading indicator | "Interpretando…" |
| InterpretationView | Navigation title | "Tu Tweet" |
| InterpretationView | Back button | "← Volver" |
| InterpretationView | Post button | "Publicar" |
| InterpretationView | Posting indicator | "Publicando…" |
| InterpretationView | Success HUD | "¡Tweet publicado!" |
| SettingsView | Navigation title | "Configuración de APIs" |
| SettingsView | OpenAI section header | "OpenAI" |
| SettingsView | Twitter section header | "X (Twitter) — OAuth 1.0a" |
| SettingsView | Save button | "Guardar" |
| SettingsView | Saved confirmation | "Configuración guardada" |
| App | Navigation title (root) | "LeonTweets" |

## Error messages

| APIError case | Spanish message |
|---------------|----------------|
| `.missingCredential(key)` | "Credencial faltante: [key]. Ve a Configuración para agregarla." |
| `.unauthorized` | "Credenciales inválidas. Revisa tu configuración." |
| `.rateLimited` | "Límite de solicitudes alcanzado. Espera un momento." |
| `.networkFailure(msg)` | "Error de red: [msg]" |
| `.invalidResponse` | "Respuesta inválida del servidor." |
| `.decodingFailure(msg)` | "Error al procesar la respuesta: [msg]" |
| Validation (empty field) | "[Field name] es requerido." |

## OpenAI system prompt

```
Eres un poeta que interpreta letras de canciones de Leon Larregui.
Dado un fragmento de letra, escribe una interpretación poética y significativa en español,
en un párrafo corto (máximo 250 caracteres), como si fuera un tweet reflexivo.
Responde solo con el texto, sin explicaciones.
```
