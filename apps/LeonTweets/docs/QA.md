# LeonTweets — QA Checklist

Run `swift test` first, then validate each P0 flow manually with real API keys.

## Prerequisites
- [ ] `swift build` passes with zero errors from `apps/LeonTweets/`.
- [ ] `swift test` passes (all TweetFormatter tests green).
- [ ] Valid OpenAI API key and X (Twitter) OAuth 1.0a credentials on hand.

## P0-1 — Keychain
- [ ] Open Settings (⌘,) and enter credentials. Save. Quit app. Reopen → fields pre-populate masked.
- [ ] No credential appears in `~/Library/Preferences/`, Console logs, or crash reports.

## P0-2 — Settings
- [ ] ⌘, opens the Settings sheet.
- [ ] All 5 secure fields are present and display masked text after load.
- [ ] "Guardar" is disabled when no field has changed.
- [ ] Clear a field and try to save → validation message appears, nothing saved.

## P0-3 — OpenAI interpretation
- [ ] Paste 2–4 lines of Leon Larregui lyrics → press "Interpretar" → spinner appears.
- [ ] Result appears in Spanish as a short poetic paragraph.
- [ ] Use a deliberately wrong API key → error banner shows Spanish message.
- [ ] Clear the OpenAI key from Settings → error banner shows "Credencial faltante".

## P0-4 — TweetFormatter
- [ ] `swift test` runs and all 7 TweetFormatterTests pass.
- [ ] Paste very long lyrics (500+ chars) → tweet draft preview is ≤280 chars with `…`.
- [ ] Paste a short lyric (under 280) → draft equals the full interpretation.

## P0-5 — LyricsInputView
- [ ] App opens to blank state with placeholder text in the editor.
- [ ] "Interpretar" button is disabled when the field is empty.
- [ ] Type something → "Interpretar" enables.
- [ ] ⌘↩ triggers interpretation (same as clicking "Interpretar").
- [ ] During loading, the spinner overlay is visible and the button is disabled.

## P0-6 — InterpretationView
- [ ] After interpretation, the screen shows read-only GPT text (top) and editable draft (bottom).
- [ ] Character counter shows `N / 280`.
- [ ] Edit draft to exceed 280 chars → counter turns red and "Publicar" disables.
- [ ] Bring back under 280 → counter returns to secondary color and "Publicar" re-enables.
- [ ] "← Volver" returns to LyricsInputView; draft is not preserved (new session).

## P0-7 — Twitter post
- [ ] With valid credentials, press "Publicar" → spinner appears briefly.
- [ ] Check your X account — the tweet has been posted with the correct text.
- [ ] "¡Tweet publicado!" HUD appears, then app returns to LyricsInputView after ~2s.
- [ ] Use wrong credentials → error banner shows "Credenciales inválidas. Revisa tu configuración."
- [ ] Disconnect from network and post → error banner shows network failure message.
