---
name: merge
description: Triage the user's local inbox (~/inbox) — list saved clips, read one on request, move chosen files into the current project, or delete them. Use when the user types /merge or $merge, or says "what's in my inbox", "收件箱里有什么", "取收件箱", "读收件箱里的 N 号", "把收件箱的东西合进来".
---

# merge — file items out of ~/inbox

`~/inbox` is a global drop zone: anything the user copied and saved (by hotkey or the `inbox` skill) lands there, from any app.
This skill moves items into **the project this conversation is working in**. The inbox is meant to be emptied over time.

Reply in the user's language.

## Steps

1. Run: `"$HOME/.local/bin/side-inbox" list`
2. If the user did not already say what to do: show the list as is and ask **which item, and where to put it** (or whether to read, delete, or keep it).
   Relative destinations are relative to the current working directory.
3. Default action is a **whole-file move**, without reading or rewriting:
   - create the destination folder if needed (`mkdir -p`)
   - if the destination file exists, stop and ask (overwrite / rename / cancel)
   - `mv "$HOME/inbox/<file>" "<destination>"`
4. Log it: `"$HOME/.local/bin/side-inbox" merged "<file>" "<absolute destination>"`
5. Reply in one line (`Filed to <destination>.`), run `list` again and say how many items remain.

## Only when the user asks

- **Read** an item ("read #2"): read `~/inbox/<file>` — this is the moment content enters the conversation, on purpose.
- **Rewrite / split / merge into an existing document**: needs reading; say so first.
- **Delete** ("don't need #3"): `rm` it and log `merged "<file>" "(discarded)"`.
- **Keep all**: do nothing.
