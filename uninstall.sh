#!/bin/bash
# Removes the CLI and the skills side-inbox installed. Leaves ~/inbox (your data) alone.
set -euo pipefail
rm -f "$HOME/.local/bin/side-inbox"
for dir in "$HOME/.claude/skills" "$HOME/.codex/skills"; do
  for s in inbox merge; do
    [ -e "$dir/$s/.side-inbox" ] && rm -rf "$dir/$s"
  done
done
echo "Removed side-inbox. Your saved items are still in ~/inbox. Delete the shortcut in the Shortcuts app if you no longer need it."
