#!/usr/bin/env bash
# Thin wrapper kept for older docs / CI references.
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
exec "$ROOT/scripts/scan-malware.sh" "$@"
