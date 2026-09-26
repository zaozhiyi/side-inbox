#!/bin/bash
# side-inbox installer (macOS).
#   ./install.sh                 install CLI + skills for every agent found, then import the hotkey shortcut
#   ./install.sh --no-shortcut   skip the Shortcuts step
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
[ "$(uname)" = "Darwin" ] || { echo "side-inbox currently supports macOS only."; exit 1; }
if defaults read -g AppleLanguages 2>/dev/null | grep -q '"zh'; then ZH=1; else ZH=0; fi
say() { if [ "$ZH" = 1 ]; then echo "$2"; else echo "$1"; fi; }

# 1. CLI
mkdir -p "$HOME/.local/bin" "$HOME/inbox"
install -m 755 "$HERE/bin/side-inbox" "$HOME/.local/bin/side-inbox"
say "✓ CLI       ~/.local/bin/side-inbox" "✓ 命令行    ~/.local/bin/side-inbox"
say "✓ Inbox     ~/inbox" "✓ 收件箱    ~/inbox"

# 2. Skills, for each agent that is installed. Same SKILL.md works in all of them.
installed_any=0
for target in "$HOME/.claude/skills:Claude Code" "$HOME/.codex/skills:Codex"; do
  dir="${target%%:*}"; label="${target#*:}"
  [ -d "$(dirname "$dir")" ] || continue
  mkdir -p "$dir"
  for s in inbox merge; do
    if [ -e "$dir/$s" ] && [ ! -e "$dir/$s/.side-inbox" ]; then
      say "! $label: $dir/$s already exists and is not from side-inbox — skipped" "! $label：$dir/$s 已存在且不是 side-inbox 装的，跳过"
      continue
    fi
    rm -rf "$dir/$s"; mkdir -p "$dir/$s"
    cp "$HERE/skills/$s/SKILL.md" "$dir/$s/SKILL.md"
    touch "$dir/$s/.side-inbox"
  done
  say "✓ Skills    $label  ($dir)" "✓ 命令      $label（$dir）"
  installed_any=1
done
[ "$installed_any" = 1 ] || say "! No Claude Code (~/.claude) or Codex (~/.codex) found; skills not installed. The hotkey still works." "! 没找到 Claude Code（~/.claude）或 Codex（~/.codex），未安装命令；快捷键照样能用。"

# 3. Hotkey shortcut
if [ "${1:-}" != "--no-shortcut" ]; then
  f=$("$HERE/shortcut/make-shortcut.sh") && open "$f" && {
    say "" ""
    say "Shortcuts is asking to add the shortcut — click \"Add Shortcut\", then:" "快捷指令 App 正在询问是否添加——点「添加快捷指令」，然后："
    say "  1. Open it, click ⓘ (Details) → Add Keyboard Shortcut → press e.g. ⌃⌥I" "  1. 双击打开它，点右上角 ⓘ → 添加键盘快捷键 → 按下比如 ⌃⌥I"
    say "  2. Shortcuts → Settings → Advanced → tick \"Allow Running Scripts\"" "  2. 快捷指令 → 设置 → 高级 → 勾选「允许运行脚本」"
  } || say "! Could not build the shortcut; see README for the manual steps." "! 快捷指令生成失败，按 README 里的手动步骤设置。"
fi
say "" ""
say "Done. Copy something, press your hotkey, and check ~/inbox." "完成。复制一段文字，按快捷键，然后看 ~/inbox。"
