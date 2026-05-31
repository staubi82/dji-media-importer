#!/usr/bin/env bash
set -euo pipefail

REPO="staubi82/dji-media-importer"
BRANCH="${BRANCH:-main}"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/copy-drone-media"
TARGET="$INSTALL_DIR/dji"
SCRIPT_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/dji"

need_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'Fehlt: %s\n' "$1" >&2
    return 1
  fi
}

missing=0
for cmd in bash curl find findmnt grep lsblk numfmt rsync sed stat tr wc; do
  need_command "$cmd" || missing=1
done

if [[ "$missing" -ne 0 ]]; then
  printf '\nBitte die fehlenden Pakete installieren und den Installer erneut starten.\n' >&2
  exit 1
fi

mkdir -p "$INSTALL_DIR" "$CONFIG_DIR"
curl -fsSL "$SCRIPT_URL" -o "$TARGET"
chmod +x "$TARGET"

if [[ ! -f "$CONFIG_DIR/device-names.conf" ]]; then
  cat > "$CONFIG_DIR/device-names.conf" <<'EOF'
# Friendly device names.
# Format: search text = folder name
#
# Common DJI USB storage identifiers:
InternalSto = dji
File-Stor Gadget = dji

# Examples for future devices:
# Action = action
# Osmo = action
EOF
fi

printf 'Installiert: %s\n' "$TARGET"

case ":$PATH:" in
  *":$INSTALL_DIR:"*)
    printf 'Starten mit: dji\n'
    ;;
  *)
    printf '\n%s ist noch nicht in PATH.\n' "$INSTALL_DIR"
    printf 'Fuege diese Zeile zu deiner Shell-Konfiguration hinzu:\n'
    printf 'export PATH="$HOME/.local/bin:$PATH"\n'
    printf 'Danach neues Terminal oeffnen und starten mit: dji\n'
    ;;
esac
