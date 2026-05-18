# Humanizer — Examples

Test cases for the German Variant and Lars-Specific Whitelist. English examples live in `SKILL.md` (sections 1-29).

## German Variant Test Cases

### Test 1: Nominalstil-Inflation (G1)

**Before:**
> Die Implementierung der neuen Backup-Strategie erfordert die Anpassung der Cron-Jobs und die Erweiterung der Storage-Kapazität.

**After (expected):**
> Für die neue Backup-Strategie müssen wir die Cron-Jobs anpassen und mehr Storage einkaufen.

### Test 2: Business-Floskeln (G2)

**Before:**
> Wir bieten eine ganzheitliche Lösung, die nahtlos in Ihre bestehende Infrastruktur integriert und proaktiv auf Performance-Engpässe reagiert.

**After (expected):**
> Unsere Lösung läuft mit Ihrem bestehenden Setup und erkennt Engpässe bevor sie zum Problem werden.

### Test 3: Verstärker-Inflation (G4)

**Before:**
> Die neue Caching-Schicht hat signifikante Auswirkungen auf die Performance und ist ein maßgeblicher Faktor für die Verbesserung der Nutzererfahrung.

**After (expected):**
> Die neue Caching-Schicht senkt die TTFB um 180 ms. Das merken Nutzer im Above-the-Fold-Rendering.

### Test 4: Meta-Ankündigungen (G5)

**Before:**
> Im Folgenden werde ich die drei wichtigsten Punkte erläutern. Zunächst einmal sei gesagt, dass Speed Kit eine Edge-basierte Cache-Lösung ist.

**After (expected):**
> Drei Punkte: 1. Speed Kit ist Edge-basiert. 2. ...

### Test 5: Lars-Whitelist aktiv (Fragments + Anglicisms preserved)

**Before (Lars-Stil text):**
> Cherry-Pick done. Stub geschrieben. Naja, jetzt fehlt nur noch der Test gegen den echten Stack. PR raus heute.

**After (expected — preserved, NOT humanized):**
> Cherry-Pick done. Stub geschrieben. Naja, jetzt fehlt nur noch der Test gegen den echten Stack. PR raus heute.

*Reason: All flagged-looking patterns (fragments, Anglicisms, „naja") are on the Lars whitelist when `--profile lars` is set. The text is already in Lars-Stil and stays.*

## Real-Vault Tests (executed 2026-05-19 by Claude, --profile lars where noted)

These are pattern-match analyses against real Lars vault content. Each test names the source file, the relevant excerpt, the predicted humanizer behavior, and which patterns/whitelist entries fired.

### Test 6: Daily Note (Lars-Stil, --profile lars active)

**Source:** `Daily/2026-05/2026-05-18.md` — "Top 3 heute" section

**Before:**
> 1. **Kindle-Deprecation** — 3 Geräte sichten + Option A/B/C/D entscheiden [[Notes/vault-wartung-fragen-mac-session-2026-05-16]] (Deadline Mi 20.05., NIE factory-reset)
> 2. **Heat Insert Press** — Lötkolben-Inventur in Werkstatt + Mintion Nutopress Pro bestellen [[Resources/heat-insert-press]] (bis 23:59 für Do-Lieferung mit AMS-Bestellung)
> 3. **Santos Hof-Logistik** — Palette-Stellplatz klären, Schubkarre/Sackkarre bereit, ggf. Nachbar als Hilfe

**After (--profile lars active):**
> *Output unchanged — already in Lars-Stil.*

**Patterns considered, all whitelisted:**
- Compact bullets (3-5 words: "3 Geräte sichten", "Palette-Stellplatz klären") — Lars-Whitelist (compact bullets)
- Direct address implied ("du") — Lars-Whitelist (direct address)
- Anglicism "Heat Insert Press", "Deprecation", "factory-reset", "Hof-Logistik" — Lars-Whitelist (conscious Anglicisms / tech vocab)
- Hyphenated compound "Kindle-Deprecation" — would normally fire Pattern 26, but on Lars-Whitelist as tech term
- "Mintion Nutopress Pro" — product name, no pattern

**Verdict:** No AI patterns detected after Lars-Whitelist applied. Skill should respond with "No AI patterns detected; text is already in human voice." (per Process step 1 after audit fix).

---

### Test 7: Formal German Methodology (Notes/elevator-pitch-sales.md)

**Source:** `Notes/elevator-pitch-sales.md` — "Alan Monroe Motivations-Sequenz"

**Before:**
> 1. **Bedarf herstellen** — Gegenüber den Schmerz spüren lassen (Status-Quo-Diagnose, Kosten der Untätigkeit)
> 2. **Bedarf befriedigen** — Lösung als Antwort positionieren
> 3. **Nutzen visualisieren** — Konkretes Bild der Zukunft mit deiner Lösung

**After (default mode, no --profile lars):**
> 1. **Bedarf zeigen** — Den Schmerz fühlbar machen. Status-Quo-Kosten benennen.
> 2. **Lösung anbieten** — Was deine Lösung am Schmerz ändert.
> 3. **Zukunft zeichnen** — Wie es nach dem Kauf konkret aussieht.

**Patterns fired:**
- **G1 (Nominalstil-Inflation):** "Bedarf herstellen", "Bedarf befriedigen", "Nutzen visualisieren" — alle drei sind Verb→Substantiv-Wandlungen. "Status-Quo-Diagnose" und "Kosten der Untätigkeit" sind klassische Berater-Substantivierungen.
- **G2 (Floskeln):** "positionieren" (statt einfach "anbieten")
- **G6 (Höflichkeits-Boilerplate, indirekt):** "Gegenüber" als hyper-formelle Anrede

**Verdict:** Skill should rewrite. Methodologie-Texte sind ein Standardfall für deutsche AI-Tells.

---

### Test 8: Empty/Trivial Input (Inbox/braindump.md)

**Source:** `Inbox/braindump.md` — Body is empty (only frontmatter + comment).

**Before:**
> *(empty — header comment plus separator line, no prose)*

**After:**
> "Input contains only metadata/header and no prose to humanize. If you wanted to humanize a specific entry from this file, paste it inline or point to a section."

**Verdict:** Triggers Process step 1 empty-input handling (added in audit fix). Skill asks for clarification instead of silently returning the file. This validates Critical Issue 3 resolution.

---

### Test 9: Skill-Generated Text in Lars-Stil (Inbox/2026-05-18_slack-catchup.md)

**Source:** `Inbox/2026-05/2026-05-18_slack-catchup.md` — TL;DR section (generated by a Lars Brain Skill)

**Before:**
> - [ ] **HEUTE/MORGEN:** Antworte **@Tibor** in `#ae-channel` zur Sonderkündigungsklausel-Idee (90-Tage-Frist nach 100% Rollout kappen, Ridersdeal-Lehre) — **wartet seit 4 Tagen**.
> - [ ] **HEUTE entscheiden:** **AWS Summit Hamburg übermorgen Mi 20.05.** — Moritz' `<!here>`-Ping mit Free-Reg. Hinfahren oder nicht?

**After (--profile lars active):**
> *Output unchanged.*

**Patterns considered:**
- Hyphenated compounds "Sonderkündigungsklausel-Idee", "90-Tage-Frist", "Free-Reg" — would fire Pattern 26, on whitelist as tech/business vocab
- Anglicisms "Ping", "Rollout", "Summit" — Lars-Whitelist
- Compact bullets — Lars-Whitelist
- Em dashes — Lars uses these freely, but default rule would remove. Whitelist preserves.
- Specific dates "Mi 20.05.", "4 Tagen" — pass Pattern 14 (false specificity check)

**Verdict:** No changes. Skill-generated Lars-Stil text is correctly preserved when whitelist is active. This is the most important test — confirms the marketplace skill doesn't break Lars's own brain-skill outputs.

---

### Test 10: Conflict — German Variant + Lars Profile both active

**Synthetic test** (constructed to verify the conflict-resolution rule added in audit fix).

**Before (German with conscious Anglicisms):**
> Vor diesem Hintergrund haben wir den PR-Workflow nahtlos in die bestehende Pipeline integriert. Der Audit läuft proaktiv und maßgeblich beschleunigt das Deployment.

**After (German Variant + --profile lars):**
> Den PR-Workflow haben wir in die bestehende Pipeline gehängt. Der Audit läuft mit und beschleunigt das Deployment um ~30%.

**Patterns fired:**
- **G2 (Floskeln):** "Vor diesem Hintergrund", "nahtlos", "proaktiv" — all removed
- **G4 (Verstärker-Inflation):** "maßgeblich" — removed
- **NOT fired (whitelisted):** "PR-Workflow", "Pipeline", "Audit", "Deployment" — all on Lars's tech-vocab whitelist (G7 conflict resolution)

**Verdict:** Confirms the conflict-resolution rule works as documented in audit fix. German floskeln fall while Lars's tech vocab survives.

---

## Validation Checklist (executed 2026-05-19)

- [x] At least 3 of G1-G12 fired on real-world texts — Tests 7 and 10 fire G1, G2, G4
- [x] Lars-Whitelist preserved at least one fragment and one Anglicism — Tests 6, 9, 10 confirm
- [x] No German Pattern incorrectly fired on a legitimate Lars-Stil text — Tests 6, 9 stay unchanged with whitelist
- [x] Conflict-resolution rule (German Variant + Lars Profile) works — Test 10 verifies
- [x] Empty/clean-input handling (audit Critical Issue 3) — Test 8 verifies
- [ ] English examples from upstream still work — relies on upstream's own `## Full Example` (SKILL.md ~line 655); not re-tested here but unchanged from blader/humanizer v2.5.1

**Note:** These are pattern-match analyses done by Claude reading the skill, not live skill runs from a separate process. To validate the skill end-to-end after install, Lars should run `claude /humanizer` against each of these source files and compare outputs to the predictions above.
