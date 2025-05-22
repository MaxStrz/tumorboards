@echo off
:: Schaltet die Anzeige der auszuführenden Befehle im Terminal aus,
:: damit die Ausgabe übersichtlicher bleibt.

:: =========================================================================
:: === Schritt 1: Projektverzeichnis festlegen ===
:: ERKLÄRUNG: %~dp0
::
:: %0      → der Name der Batch-Datei selbst (z. B. setup_git_repo.bat)
:: %~d0    → nur das Laufwerk, z. B. "C:"
:: %~p0    → nur der Pfad, z. B. "\Projekte\Tumorboard\"
:: %~dp0   → vollständiger Pfad zur Batch-Datei inkl. Laufwerk, z. B.:
::           "C:\Projekte\Tumorboard\"
::
:: %~dp0 zeigt also IMMER den Ordner an, in dem dieses Script liegt,
:: egal, von wo aus das Script aufgerufen wird.
::
:: Achtung: Immer mit abschließendem \ !

:: Setzt das Projektverzeichnis auf den Ordner, in dem dieses Skript liegt
set PROJECT_DIR=%~dp0

:: Wechselt in das definierte Projektverzeichnis (auch bei Wechsel des Laufwerks).
:: Dies stellt sicher, dass alle Befehle im richtigen Pfad ausgeführt werden.
cd /d %PROJECT_DIR%

:: =========================================================================
:: === Schritt 2: Git-Repository initialisieren ===
:: Erstellt ein neues Git-Repository im aktuellen Ordner.
:: Dadurch entsteht ein versteckter Ordner ".git", in dem Git alle Änderungen verfolgt.
git init

:: =========================================================================
:: === Schritt 3: Lokale Git-Konfiguration setzen ===
:: KONFIGURATION AUS .env-DATEI EINLESEN
:: BATCH-VARIABLEN DEFINIEREN
::
:: Diese Schleife lädt Zeile für Zeile eine Konfigurationsdatei ein
:: (z. B. git_config.env), in der jede Zeile wie folgt aussieht:
::
::     GIT_USERNAME=MaxMustermann
::     GIT_EMAIL=max@example.com
::
:: Die eingelesenen Werte werden in Batch-Variablen gespeichert,
:: z. B.:
::     set GIT_USERNAME=MaxMustermann
::
:: DER BEFEHL:
:: for /f "tokens=1,* delims==" %%A in (git_config.env) do (
::     set %%A=%%B
:: )
::
:: === ERKLÄRUNG SCHRITT FÜR SCHRITT ===
::
:: for        → Startet eine Schleife
:: /f         → Bedeutet: lies den Inhalt einer Datei oder Textzeile(n)
::
:: "tokens=1,* delims=="
::     - tokens=1,* → teile jede Zeile in Felder
::         - 1. Feld landet in %%A  (der Schlüssel z. B. GIT_USERNAME)
::         - *       → alles weitere (der Rest der Zeile) landet in %%B (der Wert)
::     - delims==   → verwendet "=" als Trenner zwischen Key und Value
::
:: %%A → Platzhalter für den Variablennamen (z. B. GIT_USERNAME)
:: %%B → Platzhalter für den zugehörigen Wert    (z. B. Max Strzelecki)
::
:: set %%A=%%B
::     → Setzt eine Umgebungsvariable zur Laufzeit:
::         z. B. set GIT_USERNAME=Max Strzelecki
::
:: in (%PROJECT_DIR%git_config.env)
::     → Quelle der Daten: unsere .env-Datei im Projektverzeichnis
::
:: do (...) → Führt diesen Befehl für jede gelesene Zeile aus

for /f "tokens=1,* delims==" %%A in (%PROJECT_DIR%git_config.env) do (
    set %%A=%%B
)

:: =========================================================================
:: Schritt 3.5
:: Lokale Git-Benutzerinformationen aus externer Config setzen
:: Jetzt können die gesetzten Variablen direkt verwendet werden
:: z. B. um Git zu konfigurieren mit den eingelesenen Werten
git config user.name "%GIT_USERNAME%"
git config user.email "%GIT_EMAIL%"

:: =========================================================================
:: === Schritt 4: Eine einfache README.md-Datei anlegen ===
:: Diese Datei beschreibt das Projekt und wird automatisch auf GitHub angezeigt.
:: Hier schreibst du später mehr Informationen zu Zweck und Nutzung des Projekts rein.
echo # Tumorboards > README.md

:: =========================================================================
:: === Schritt 5: .gitignore-Datei erstellen ===
::
:: Die .gitignore-Datei legt fest, welche Dateien und Ordner Git ignorieren soll.
:: Diese Dateien werden also nicht versioniert oder in Commits aufgenommen.
::
:: Typische Beispiele:
:: - __pycache__/  → Python-Cache-Ordner
:: - *.pyc         → Kompilierte Python-Dateien
:: - *.log         → Logdateien
:: - git_config.env → Eigene Konfigurationsdatei mit Benutzerinformationen
::                    (soll NICHT ins Repository gelangen!)
:: - .ipynb_checkpoints/    → Automatisch erzeugte Jupyter-Notebook-Snapshots
:: - tbvenv/                → Virtuelle Python-Umgebung für dieses Projekt
::
:: ACHTUNG: Die erste echo-Zeile (mit ">") überschreibt die Datei oder legt sie neu an.
:: Alle weiteren Zeilen (mit ">>") hängen an.

echo __pycache__/ > .gitignore
echo *.pyc >> .gitignore
echo *.log >> .gitignore
echo git_config.env >> .gitignore
echo .ipynb_checkpoints/ >> .gitignore
echo tbvenv/ >> .gitignore
echo cmd_log.txt >> .gitignore

:: === Schritt 6: Dateien zum Commit vormerken ===
:: Git verfolgt nur Dateien, die explizit hinzugefügt wurden.
:: Hier fügen wir die README.md und .gitignore zur Staging-Area hinzu.
git add README.md .gitignore

:: === Schritt 7: Ersten Commit durchführen ===
:: Mit diesem Commit wird der aktuelle Stand in das Repository übernommen.
:: Das ist der „Startpunkt“ der Projektversionierung.
git commit -m "Initial commit: Struktur + Git-Konfiguration"

:: =========================================================================
:: === Schritt 8: Remote-Repository auf GitHub verknüpfen (aus .env) ===
::
:: Verwendet die URL aus der Konfigurationsdatei (GIT_REMOTE_URL)
:: und verbindet das lokale Git-Repo mit GitHub
::
:: Beispiel:
::   GIT_REMOTE_URL=https://github.com/deinuser/tumorboard-hl7.git
::
:: Der Branch wird standardmäßig in "main" umbenannt,
:: und der erste Push erfolgt mit Upstream-Verknüpfung.
:: =========================================================================

git remote add origin "%GIT_REMOTE_URL%"
git branch -M main
git push -u origin main

:: === Schritt 9: Abschlussmeldung ausgeben ===
:: Zeigt eine einfache Bestätigung im Terminal an.
echo Git-Repository erfolgreich eingerichtet und zur Remote-Repo verknüpft!

:: === Schritt 10: Terminal offen halten ===
:: Wartet auf Tasteneingabe, damit sich das Fenster nicht sofort schließt
:: (z. B. wenn das Script durch Doppelklick gestartet wurde).
pause
