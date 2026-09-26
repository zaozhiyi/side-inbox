---
name: inbox
description: Save what the user just copied into their local inbox (~/inbox) verbatim, without the content entering this conversation. Use when the user types /inbox or $inbox, or says "save to inbox", "存到收件箱", "把我刚复制的存下来". Typical source is a read-only side chat (Claude Code side chat, Codex /side) or a web chat.
---

# inbox — clipboard → ~/inbox

The user copied something (usually from a side chat that cannot write files) and wants it kept on disk.
**Hard rule: the content must not enter this conversation's context.** Only a short preview may.

Reply in the user's language.

## Steps

1. Run: `"$HOME/.local/bin/side-inbox" stage`
   It saves the clipboard to a staging file and prints line count, char count, an auto title, the first 5 and last 2 lines.
   Do **not** read the staged file yourself (no `pbpaste`, `cat`, or file-read tools).
2. Tell the user the line count, the title and the first lines, and ask: **save it? change the title?**
   - If the user gave text along with the command, treat it as the title (still confirm).
   - If it is under 3 lines, or the first line looks like a URL or a single word, warn that it may not be what they meant to copy.
3. Yes → `"$HOME/.local/bin/side-inbox" commit "<STAGED path>" "<title>"`, then reply in one line: saved as `~/inbox/<file>`, N lines.
   No → `"$HOME/.local/bin/side-inbox" discard "<STAGED path>"`.
4. Stop there. Do not open, summarize or tidy the saved file. The user will use the `merge` skill when they need it.

Tip for the user (mention once if they seem to save often): the macOS hotkey installed with side-inbox saves without going through the conversation at all.
