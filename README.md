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

## Zielstruktur

Bei jedem Lauf wird ein neuer Ordner mit Zeitstempel erstellt:

```text
~/Videos/
└── dji 2026-05-31_10-10-00/
    ├── Videos/
    │   ├── DJI_20260529190348_0001_D.MP4
    │   └── DJI_20260530094240_0002_D.MP4
    └── Bilder/
        ├── DJI_20260530203106_0010_D.JPG
        └── DJI_20260530203111_0011_D.JPG
```

Kamera-Unterordner wie `DCIM/DJI_001` werden nicht uebernommen. Dateien landen direkt in `Videos/` oder `Bilder/`.

Falls zwei Dateien denselben Namen haben, wird automatisch ein Suffix wie `_2` angehaengt, damit nichts ueberschrieben wird.

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
