# Compass: Verhaltensentwurf und Umsetzungsplan

Stand: 2026-09-13. Status: lokal umgesetzt; abschließende Abnahme siehe RESULTS.md.
Baseline: `c5d8cb062093d33c1f3473467b8d75dfb6b9f371`.

## Ziel und Umfang

Compass hält Erkenntnisse mit wenig Reibung fest und unterscheidet belegte
Zielabweichungen von unzureichend geprüften Situationen. Bestehende Projektregeln,
adoptierte Planungsdateien und bewusste lokale Ausnahmen bleiben erhalten.

Diese Überarbeitung härtet Stufe 1: Markdown-Anweisungen, vier vorhandene Modi,
kompatible Artefakte und Verhaltenstests. Hooks, automatische Transcript-Auswertung,
eine Datenbank und ein neues Ausführungsframework sind kein Bestandteil.

## Geprüfte Grundlagen

- `skills/compass/SKILL.md` und alle drei Referenzen; `origin.yaml`.
- `docs/skill-learnings.md`, `CONTRIBUTING.md`, `docs/deployment.md`.
- Ursprüngliches Design: `/Users/lars/Desktop/claude/compass/PROPOSAL.md`
  und `HANDOFF.md`. Historische Vorgaben werden gegen spätere Learnings gelesen.
- Reuse-Router: `~/Documents/second-brain/Resources/START-HERE.md`, Capability-Index,
  `~/Desktop/claude/PROJEKTE.md`, `brain/research-log.md`.
- Geldwerk: `.compass/config.md`, `BACKLOG.md`, `HANDOFF.md`, relevante Abschnitte
  der adoptierten `DECISIONS.md`.
- Leadclearing: tatsächlicher `.compass`-Symlink und seine Dateien im benachbarten
  Audit-Repo. Explizite lokale Ausnahme: private Ablage, GitLab, bestehender FOLLOWUP.
- Installationsregister: globale und projektbezogene Installation zeigen auf denselben
  Cache. Skill und Referenzen sind bytegleich mit der Baseline im Quellrepo.

Dies sind statische Befunde. Es wurden noch keine Modell-Verhaltenstests durchgeführt.
Historische fehlgeschlagene Trigger-Evals sind wegen Authentifizierungsfehlern kein
Beleg für schlechte Trigger-Qualität.

## Präzisierungen gegenüber dem ersten Review

1. Der Governor ist eine bewusste Anti-Nag-Entscheidung. Er bleibt für eigene
   Vorschläge bestehen; explizite Nutzeraufträge werden nicht begrenzt.
2. Geldwerks Architektur-Dokument enthält heute ausdrücklich bereits entschiedene
   Prinzipien und Nicht-Ziele. Ein Ausschluss allein wegen fehlender Log-Struktur
   wäre falsch. Entscheidungsquelle und append-only Schreibformat sind zu trennen.
3. Ein älterer Handoff beweist keine Session ohne `wrap`: Er kann durch aktuelle
   Arbeit, spätere Synchronisierung oder fremde Commits überholt sein.
4. Ohne Hooks ist Capture weiterhin best effort. Dieses Limit wird nicht durch
   stärkere Formulierungen oder einen stillen Erfolgs-Token behoben.

## Gewünschter Verhaltensvertrag

### 1. Capture und Autorisierung

- Ein klarer Nutzerauftrag zum lokalen Festhalten ist bereits die Autorisierung.
  Compass liest für den Dublettenabgleich, schreibt den sinngetreuen Eintrag und
  bestätigt ihn in einer Zeile. Kein zusätzliches Ja zum bloßen Wortlaut.
- Nur wenn Inhalt oder Ziel tatsächlich unklar sind, eine gezielte Frage stellen.
- Unaufgeforderte Ideen einmal pro Thema anbieten. Erst nach Annahme speichern.
- Drei offene eigene Vorschläge begrenzen weitere Angebote. Ein Nutzerauftrag
  bleibt ausführbar; der Zähler darf nicht als Datenerfassungsgrenze dienen.
- Speichern ist keine Zustimmung zur Umsetzung. Standardstatus bleibt `proposed`.
  Eine ausdrücklich angenommene Idee darf als `agreed` dokumentiert werden.
- Externe Issue-Erstellung braucht passende bestehende Autorisierung. „Lokal merken“
  ist keine Issue-Freigabe; „Erstelle dafür ein Issue in Repo X“ braucht kein zweites Ja.
- Ein Remote ist nicht automatisch GitHub. Zielhost und Zielrepo bestimmen; bei
  Mehrdeutigkeit keinen geratenen Write durchführen. GitLab wird nicht an `gh` gegeben.
  Ohne unterstütztes Issue-Tool lokal erfassen und die Grenze knapp nennen.
- Ein begrenztes oder fehlgeschlagenes Issue-Listing ist kein vollständiger
  Dublettenausschluss. Für den Kandidaten gezielt suchen, Begrenzungen offenlegen.

Beispiel: „Halt fest: CSV-Export braucht einen Abbruchknopf“ → ein lokaler harter
Eintrag mit Herkunft und Begründung, keine Rückfrage, keine Umsetzung, kein Issue.

### 2. Vom Eintrag zur Roadmap

Vier Modi beibehalten; keinen zusätzlichen Planungsmodus einführen.

- `capture --hard <milestone>` erfasst einen Vorschlag im Backlog. Bootstrap
  verspricht ausdrücklich nicht mehr, damit die Roadmap direkt zu füllen.
- „Übernimm c7k2 als Meilenstein in unsere Roadmap“ ist eine gezielte Pflegeaktion
  innerhalb von `capture`: Eintrag identifizieren, bereits erteilte Zustimmung
  dokumentieren, bei eigener Roadmap den minimalen passenden Meilenstein ergänzen.
- Bei adoptierter Roadmap einen direkt anwendbaren Änderungsvorschlag liefern;
  niemals die fremde Datei schreiben. Solange er nicht übernommen ist, keinen
  erfolgreichen Roadmap-Transfer behaupten.
- Die Backlog-ID bleibt stabil. Aufnahme in die Roadmap bedeutet `agreed`, nicht
  `done`; der eigentliche Inhalt ist noch nicht umgesetzt. Referenz auf Zielabschnitt
  optional als Attribut ergänzen, ohne ein neues Pflichtformat für Altbestände.
- `wrap` darf eindeutige, im Gespräch bereits autorisierte Statusänderungen in eigenen
  Dateien nachziehen. Unentschiedene Priorisierung und Zieländerungen nur vorschlagen.
- Entscheidungen werden in eigenen DECISIONS angehängt; bestehende Umkehrungen
  referenzieren die abgelöste Entscheidung. Adoptierte Quellen bleiben read-only.

### 3. Drift braucht eine geltende Regel und eine nachgewiesene Abweichung

Commit-Betreff, Dateistreuung und Meilensteinreihenfolge sind Suchhinweise.
Ein Befund braucht zwei Seiten: geltende Ziel-/Scope-/Abhängigkeitsregel und
konkrete Arbeit, die diese Regel verletzt. Dafür gezielt den relevanten Diff lesen.

- Spätere Phase bei offener früherer Phase: nur Drift, wenn eine ausdrückliche
  Voraussetzung verletzt wird. Die reine Nummerierung genügt nicht.
- Bugfix in abgeschlossenem Bereich: reguläre Wartung, außer die konkrete Arbeit
  verletzt eine belegte Scope-Regel. Commit-Anzahl allein ist kein Gold-Plating.
- Nicht zuordenbare Arbeit: „Zuordnung ungeklärt“, falls der Kontext nicht reicht;
  nicht automatisch „off-plan“.
- Widersprüche zwischen Anweisungen und Projektunterlagen: weiterhin beide Seiten
  mit Kontext belegen. Vorrangige Anweisungen beachten, keine Dokumente heimlich reparieren.
- Ein aktueller Commit nach dem Handoff heißt „Arbeit seit Handoff“, nicht
  „letzte Session ohne wrap“. Mit dem Handoff selbst muss erst eine tatsächliche
  inhaltliche Veraltung belegt werden.

### 4. Datenbasis und ehrliches Ergebnis

Neuer Handoff behält das alte Datum und ergänzt optionale Felder:

```yaml
handoff: 2026-09-13
captured_at: 2026-09-13T14:20:00+02:00
head: <full commit SHA, or null for an unborn repository>
branch: <branch name, or null for detached HEAD>
```

- Neue Felder werden beim nächsten autorisierten `wrap` ergänzt, nicht per
  Migration aller Projekte. Altdateien bleiben lesbar.
- Exakte Git-Abgrenzung über gespeicherten HEAD nur bei vorhandenem Commit und
  geprüfter Erreichbarkeit von aktuellem HEAD. Ein zweckgebundener
  `git merge-base --is-ancestor`-Read gehört dann ins Werkzeugset.
- Fehlender Commit, fremder Branch, umgeschriebene Geschichte oder reines Datum:
  eingeschränkte Abdeckung ausweisen; kein geratenes „N Commits seit Handoff“.
- Shallow liest Datumsangaben, Status und bis zu 30 Commits plus einen weiteren
  zur Erkennung von Überlauf. Falls der relevante Bereich größer ist, ausdrücklich
  Teilprüfung melden. Nicht heimlich den gesamten Verlauf laden.
- Deep untersucht den relevanten Bereich seitenweise, mit Arbeitslimit von 200
  Commits pro Aufruf. Restbestand bleibt im Ergebnis sichtbar; kein endloser Scan.
- Uncommitted Änderungen berücksichtigen; nur `--stat` beweist ihren Inhalt nicht.
  Fehlende Milestones, fehlendes Git oder unerreichbare Quellen separat ausweisen.

Ergebnis immer auf den tatsächlich geprüften Umfang beziehen:

| Ergebnis | Voraussetzung |
|---|---|
| `Drift: found.` | Mindestens eine belegte Abweichung; Lücken zusätzlich nennen |
| `Drift: none.` | Keine Abweichung im angegebenen Umfang, keine relevanten Prüflücken |
| `Drift: unknown.` | Keine belegte Abweichung, aber relevante Daten oder Regeln fehlen |

Im Kurzbericht eine Abdeckungszeile führen: Git-Bereich, Roadmap, aktuelle
Unterhaltung, gegebenenfalls eingeschränkte Issue-Suche. Capture-Abdeckung meint
immer nur die sichtbare Unterhaltung, niemals frühere Sessions oder Subagenten.
Höchstens drei Befunde und drei nächste Schritte bleiben erhalten.

### 5. Closed und Wiederaufnahme

- `start` zeigt geschlossene Einträge nicht an.
- `capture` und der Capture-Teil von `check` lesen Closed gezielt für Kandidaten:
  Ist dieses Thema bereits erledigt oder bewusst verworfen?
- Geschlossene Einträge nicht als Vorschläge neu präsentieren. Ein wiederholter
  beiläufiger Gedanke öffnet nichts erneut.
- Ausdrückliches „Nimm c7k2 wieder auf“ erlaubt Wiederaufnahme mit gleicher ID
  und datierter Begründung. Eine abweichende neue Aufgabe erhält eine neue ID.
- Kein automatisches Archivierungsverfahren in dieser Stufe. Die Behauptung,
  BACKLOG wachse nicht, entfällt: Closed begrenzt die Anzeige, nicht die Dateigröße.

### 6. Konfiguration, fremde Planung und lokale Ausnahmen

- Vorhandene Konfiguration lesen und referenzierte Dateien auf Existenz prüfen.
  Bereits entschiedene Rollen nicht jedes Mal neu verhandeln.
- Adoptierte Entscheidungsquellen dürfen auch konsolidierte verbindliche Regeln
  enthalten. Für die Übernahme zählt ihre Funktion, nicht ein vorgeschriebenes Format.
- `check`: fehlende/defekte Konfiguration melden und vorhandene Dateien vorläufig
  read-only auflösen. Keine Dateien erstellen, kein Bootstrap-Interview.
- `start`: fehlende Teile ergänzen, auch wenn ein früheres `capture` bereits den
  Ordner angelegt hat. Existierende Einträge und Ausnahmen erhalten.
- `capture` ohne Setup: nur nötigen Backlog anlegen. `wrap` ohne Setup: nur Handoff.
- Bekannte Symlinks und dokumentierte Ablageausnahmen respektieren; keine
  automatische Verschiebung, kein Umschreiben von `.gitignore` oder Exclude-Dateien.
  Ohne bekannte Zuordnung einen unerwarteten externen Schreibpfad erst klären.
- Git-Tracking ist Standardempfehlung, keine universelle Pflicht. Private Ablage
  kann korrekt sein; Synchronisierungsgrenze benennen, Entscheidung nicht aufheben.
- Bei etablierter fremder Übergabe enthält Compass einen kurzen Verweis und nur
  Compass-spezifische offene Entscheidungen. Kein zweiter vollständiger Projektstatus.
- Plattformabhängige Behauptungen wie „CLAUDE.md ist ohnehin geladen“ entfernen.
  Tatsächlich verfügbare Tools/Anweisungen nutzen. Eine Skill-Allowlist nicht als
  plattformübergreifenden technischen Sicherheitsbeweis verkaufen.

## Umsetzung in vier Arbeitspaketen

1. **Baseline und isolierte Testdaten sichern.** Alten Skill außerhalb des
   distributierten `skills/`-Baums kopieren. Synthetische Fixtures für die beiden
   realen Projektformen erstellen; keine privaten Geschäftsdaten in Tests kopieren.
2. **Anweisungen konsistent überarbeiten.** `skills/compass/SKILL.md`,
   `references/bootstrap.md`, `references/drift.md`, `references/artifacts.md`.
   Zuerst Konfiguration/Autorisierung, dann Lifecycle, dann Drift und Bericht.
   Beschreibung nur anpassen, soweit der Vertrag sich ändert; Trigger-Optimierung separat.
3. **Alt gegen Neu testen und korrigieren.** Szenarien aus `SCENARIOS.md` in isolierten
   temporären Repos ausführen, inklusive tatsächlicher Git-Historien. Kein Live-Issue
   als Testnebenwirkung. Datei-Diffs, Ausgaben und Fragen erfassen. Skill-Creator-
   Vergleich mit alter Version, gleiche Eingaben und gleiches Modell je Paar.
4. **Metadaten, Prüfung, konkrete Verteilung vorbereiten.** `origin.yaml` und
   `docs/skill-learnings.md` um bestätigte Änderungen ergänzen. Lizenz- und
   Attribution-Audits, `git diff --check`, Frontmatter-/Referenzprüfung und lokaler
   Installations-Smoke-Test. SHA-basierte Versionierung beibehalten. Quellen nur im
   kanonischen Repo editieren; Caches niemals direkt patchen.

Design- und Testdokumente bleiben außerhalb von `skills/compass/`, weil
`sync-skills.sh` dessen gesamten Inhalt in andere Projekte kopiert.
Für temporäre Modellläufe einen Workspace außerhalb von `skills/` verwenden.

## Testauswertung und Abnahme

- Zunächst drei Szenariogruppen Alt/Neu ausführen: Capture/Lifecycle,
  Drift/Abdeckung, Konfiguration/Koexistenz. Fälle mit sichtbaren Fehlentscheidungen
  einzeln isolieren und nach Korrektur wiederholen.
- Programmatisch prüfen: erlaubte Dateipfade, unveränderte adoptierte Dateien,
  IDs, Status, erwartete Felder, keine Commits oder externen Writes.
- Inhaltlich prüfen: Begründung beider Drift-Seiten, sinngetreuer Capture-Text,
  zutreffende Einschränkungen. Eine hübsche Antwort allein ist kein bestandener Test.
- Für Skill-Creator-Auswertung Grading und Review-Viewer verwenden. Fehlende
  Zeit-/Tokenmetriken als fehlend markieren, nicht schätzen.
- Authentifizierungsfehler eines Modellrunners sofort als Infrastrukturfehler
  behandeln. Nicht den historischen kaputten `claude -p`-Loop wiederholt starten.
- Release-Grenze: alle kritischen Szenarien bestehen; keine neue Schreibverletzung,
  kein erneutes Bestätigungsritual bei klaren lokalen Aufträgen, kein falscher
  Drift-Befund in den Wartungs-/Parallelitätsfällen.
- Frische Trigger-Qualität ist ein eigener Test. Subagenten, denen der Skill
  ausdrücklich gegeben wurde, belegen keine automatische Aktivierung im Hauptchat.

## Verteilung und noch offene Informationen

Planung und lokale Überarbeitung sind ohne weitere Angaben möglich. Superpowers
wird dafür nicht benötigt; Skill Creator liefert das passende Vergleichsverfahren.

Vor einer Verteilung den dann aktuellen Installationsbestand erneut prüfen.
Bekannt sind ein zentraler Claude-Cache und Marketplace-Kopien; eine vollständige
Liste aller Cloud-/Windows-Installationen ist lokal nicht belegt. Projektkopien
nur an nachgewiesene Zielorte synchronisieren. Keine pauschale Installation in
jedes Projekt. Ein repräsentativer Pilot prüft den neuen Skill mit bestehender
Konfiguration, ohne deren private Ablage- und Handoff-Entscheidungen zu ändern.

Umsetzung und Prüfstand werden in RESULTS.md dokumentiert. Die ursprünglichen
Designentscheidungen oben bleiben als Planungsgrundlage nachvollziehbar.
