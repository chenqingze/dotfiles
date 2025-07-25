#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

OS="$(uname)"

case "$OS" in
  Darwin)
    echo "🖥  Detected macOS"
    exec "$SCRIPT_DIR/scripts/darwin.sh"
    ;;
  Linux)
    echo "🐧 Detected Linux"
    exec "$SCRIPT_DIR/scripts/linux.sh"
    ;;
  *)
    echo "❌ Unsupported OS: $OS" >&2
    exit 1
    ;;
esac
