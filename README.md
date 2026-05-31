# DJI Media Importer

## One-Click-Installation

```bash
curl -fsSL https://raw.githubusercontent.com/staubi82/dji-media-importer/main/install.sh | bash
```

Danach kannst du den Import von ueberall starten:

```bash
dji
```

## Was macht das Script?

`dji` sucht automatisch nach angeschlossenen USB-/Kamera-Speichern, findet typische Video- und Bilddateien und kopiert sie nach `~/Videos`.

Vor dem Kopieren zeigt es:

- Anzahl aller Medien
- Anzahl und Groesse der Videos
- Anzahl und Groesse der Bilder
- Zielordner
- laufenden Fortschritt inklusive aktueller Kopiergeschwindigkeit
- wie viele Dateien neu kopiert, uebersprungen oder wegen Namenskonflikt separat abgelegt wurden

## Zielstruktur

Die Dateien werden nach Aufnahmedatum einsortiert. Das Datum wird zuerst aus dem Dateinamen gelesen, z.B. `DJI_20260530203106_0001_D.MP4`. Wenn kein Datum im Namen gefunden wird, nutzt das Script den Datei-Zeitstempel.

```text
~/Videos/
├── DJI 26/
│   └── Mai/
│       └── 30/
│           ├── Videos/
│           │   ├── DJI_20260529190348_0001_D.MP4
│           │   └── DJI_20260530094240_0002_D.MP4
│           └── Bilder/
│               ├── DJI_20260530203106_0010_D.JPG
│               └── DJI_20260530203111_0011_D.JPG
└── Action 26/
    └── Mai/
        └── 30/
            ├── Videos/
            └── Bilder/
```

Kamera-Unterordner wie `DCIM/DJI_001` werden nicht uebernommen. Dateien landen direkt in `Videos/` oder `Bilder/`.

Du kannst `dji` mehrfach ausfuehren:

- vorhandene Datei mit gleichem Namen und gleicher Groesse: wird uebersprungen
- gleicher Name, aber andere Groesse: wird als `_konflikt_1`, `_konflikt_2` usw. kopiert
- neue Datei vom selben Aufnahmetag: wird in den bestehenden Tagesordner ergaenzt

## Unterstuetzte Dateitypen

Videos:

```text
mp4, mov, m4v, insv, lrv
```

Bilder:

```text
jpg, jpeg, png, dng, heic
```

## Geraetenamen anpassen

Die Zuordnung liegt hier:

```text
~/.config/copy-drone-media/device-names.conf
```

Beispiel:

```text
InternalSto = dji
File-Stor Gadget = dji
Action = action
Osmo = action
```

Alles links vom `=` wird gegen Mount-Name, USB-Modell, Label und ein paar Dateipfade geprueft. Rechts steht der Ordnername, der unter `~/Videos` verwendet wird.

## Manuelle Installation

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/staubi82/dji-media-importer/main/dji -o ~/.local/bin/dji
chmod +x ~/.local/bin/dji
```

Falls `~/.local/bin` nicht in deinem `PATH` ist:

```bash
export PATH="$HOME/.local/bin:$PATH"
```
