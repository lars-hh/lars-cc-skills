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

## Real-Vault Test Pool

For Lars to run after the skill is installed:

1. **Recent daily-sync output** — `Daily/2026-05/` (look for over-formatted Tagesrückblick sections)
2. **Pitch text from Speed Kit context** — `Notes/baqend/pitch-*` files
3. **Mail draft from sales-coach** — `Inbox/braindump.md` recent entries
4. **Strategiepapier** — `Notes/strategie-*` files
5. **Slack-Antwort-Draft** — any captured response that feels "too clean"

After running humanizer against each, paste the before/after pairs here as Test 6-10. Document which German Patterns (G1-G12) fired and which Lars-Whitelist entries preserved fragments / Anglicisms.

## Validation Checklist

- [ ] At least 3 of G1-G12 fired on real-world texts
- [ ] Lars-Whitelist preserved at least one fragment and one Anglicism that would have been removed in default mode
- [ ] No German Pattern incorrectly fired on a legitimate Lars-Stil text
- [ ] English examples from upstream still work (test one of sections 1-29 too)
