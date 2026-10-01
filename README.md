# side-inbox

**English** · [中文](README.zh-CN.md)

Keep what your AI **side chat** writes — without polluting your main conversation.

Claude Code's side chat and Codex's `/side` are great for asking a quick question about one part of an answer while the main agent keeps working. But they are read-only and ephemeral: they can't save files, and once closed they're gone. If the side chat produces something worth keeping (a plan, a summary, a 400-line write-up), today the only way out is to paste it into the main conversation — where it then sits in context forever.

side-inbox gives that output a place to go:

```
side chat  ──⌘C──►  ⌃⌥I (hotkey)  ──►  ~/inbox/2026-09-26-1530-Data mix plan.md
                                              │
main agent (any project)  ──  /merge  ◄───────┘   read it, file it, or delete it — when *you* need it
```

- **One keystroke to save.** Copy, press the hotkey, a notification tells you what was saved. The main agent is not involved and its context doesn't grow.
- **Verbatim.** The text is written to disk exactly as copied. No model touches it on the way in.
- **Guards against saving the wrong thing.** If you haven't copied anything new since the last save, or the same text is already in the inbox, nothing is saved.
- **Works with any app.** It saves the clipboard, so it doesn't care where the text came from: Claude Code, Codex, ChatGPT on the web, a PDF.
- **Retrieve on your terms.** In any project, ask your agent what's in the inbox, read an item, or move it into the project with the `merge` skill.

## Install (macOS)

```bash
git clone https://github.com/zaozhiyi/side-inbox.git
cd side-inbox
./install.sh
```

The installer:

1. puts the `side-inbox` command in `~/.local/bin` and creates `~/inbox`;
2. installs two skills, `inbox` and `merge`, for **Claude Code** (`~/.claude/skills`) and **Codex** (`~/.codex/skills`) — whichever you have. Both use the same `SKILL.md` format;
3. builds and signs a Shortcut on your Mac and opens it. Click **Add Shortcut**, then:
   - open it, click **ⓘ → Add Keyboard Shortcut**, press e.g. **⌃⌥I**;
   - in Shortcuts → Settings → Advanced, tick **Allow Running Scripts**.

Run `./install.sh --no-shortcut` to skip step 3. `./uninstall.sh` removes everything except your `~/inbox`.

<details>
<summary>Setting up the hotkey by hand</summary>

In the Shortcuts app create a new shortcut, add the action **Run Shell Script**, set its text to

```
"$HOME/.local/bin/side-inbox" quick
```

then give it a keyboard shortcut from ⓘ.
</details>

**Keyboard mapping and conflicts.** `⌃` means Control, `⌥` means Option, and `⌘` means Command. On external keyboards, Ctrl, Alt, and Windows/Start may map differently depending on keyboard mode or macOS settings; use the modifiers macOS actually recognizes. `⌃⌥I` is an example, not a requirement. Choose another combination in Shortcuts if it conflicts with a tool such as Typeless; you do not need to change that tool's settings.

## Use

| You want to… | Do this |
|---|---|
| Save something from a side chat (or anywhere) | Copy it, press **⌃⌥I** |
| Save, but see a preview first | In the agent: `/inbox` (Claude Code) — it shows the first lines and asks before saving |
| See what's waiting | Ask *"what's in my inbox?"* or `/merge` |
| Use an item in your current work | *"read inbox #2"* — only now does its content enter the conversation |
| File an item into this project | *"move #2 to notes/plan.md"* |
| Clean up | *"#3 and #4 can go"* |

In Codex the skills are picked up by name or by description; you can also mention them explicitly (`$inbox`, `$merge`).

Everything is plain files: items are `~/inbox/*.md`, and `~/inbox/.log` records what was saved and where it went.

## Why side chats can't just save

This isn't an oversight — both tools make side chats read-only and temporary on purpose, so a side conversation can't change your workspace while the main agent is running.

- **Claude Code desktop** (observed in the app bundle, Sep 2026): the side chat is a fork of the main session started with `persistSession: false` (no transcript on disk) and a permission callback that denies every tool call; it also loads no settings, hooks or MCP servers. Closing it deletes it.
- **Codex**: `/side` forks the thread with `ephemeral = true` (`codex-rs/tui/src/app/side.rs`), so it has no rollout file and disappears on close, restart or after a while. See [openai/codex#26227](https://github.com/openai/codex/issues/26227).

Neither accepts third-party extensions inside the side chat, so side-inbox works at the one boundary the user already crosses: the clipboard. The real fix belongs upstream: a single, narrow "save to inbox" capability for side chats — write-only, into one folder — would remove the copy step without letting side chats touch the workspace.

## Limitations

- macOS only (uses `pbpaste`, Shortcuts and system notifications).
- You still copy by hand; side-inbox can't see inside the side chat.
- It saves what's on the clipboard. The notification shows the title and line count so a wrong copy is easy to spot; delete it with `merge`.

## License

MIT
