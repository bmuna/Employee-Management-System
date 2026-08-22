#!/usr/bin/env bash
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
git -C "$ROOT" config core.hooksPath .githooks
chmod +x "$ROOT/.githooks/pre-push" "$ROOT/scripts/scan-malware.sh" "$ROOT/scripts/scan-implant.sh"
echo "hooksPath=.githooks (pre-push will block malware)"
