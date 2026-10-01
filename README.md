# side-inbox

**English** · [中文](README.zh-CN.md) · [Troubleshooting](docs/troubleshooting.md)

**Keep the useful parts of a side conversation. Bring them back when you need them.**

A local text inbox for macOS, with retrieval skills for Claude Code and Codex. Collect text from other apps too. MIT licensed.

## The problem: a useful detour, at the wrong time

Your main agent is working. You select part of an answer, open a side chat, and ask a few follow-up questions. The detour produces a plan, revision notes, or a long document worth keeping.

What you want is simple: **save the result, keep working, and use it later.**

Pasting it straight into the main chat adds a message and material that may not be relevant yet. Leaving it in its window means remembering where to find it and which part mattered. Moving between Quick Chat, a browser, and another AI tool adds more places to manage.

side-inbox separates saving from using. You choose when a clip becomes part of a working conversation.

## The workflow: copy → save → retrieve later

```mermaid
flowchart LR
    A[Text in Side Chat / Quick Chat / a browser] -->|Select and copy| B[Press your save hotkey]
    B --> C[Local inbox ~/inbox]
    C -->|Choose later with merge| D[Read / file / delete / keep]
```

1. **Collect:** select text, copy it, and press your configured hotkey. It becomes a local file without sending a message to the main chat.
2. **Keep working:** continue the side conversation or return to the main task. No need to invoke `merge` now.
3. **Retrieve when needed:** list your inbox in Claude Code or Codex, then choose what to read and how to use it.

For example: while the main agent writes code, a side chat helps you draft a test plan. Save it now. When the code is ready, ask: “Read the test plan in my inbox and use it to check these changes.”

**Only the copied text is saved.** This does not capture the entire session, unselected history, model settings, or relationships between chats.

## Install on macOS

You need Git, macOS Shortcuts, and `/usr/bin/python3` to generate the shortcut. Install Claude Code, Codex, or both for retrieval skills. Collecting text does not require an AI session.

```bash
git clone https://github.com/zaozhiyi/side-inbox.git
```

```bash
cd side-inbox
```

```bash
./install.sh
```

The installer puts the command at `~/.local/bin/side-inbox`, creates `~/inbox`, and installs the `inbox` and `merge` skills for each detected Claude Code or Codex installation.

In the Shortcuts window that opens:

1. Click **Add Shortcut**.
2. Open it and choose **ⓘ → Add Keyboard Shortcut**. Pick a combination, for example **⌃⌥I** (Control + Option + I).
3. Enable **Allow Running Scripts** in **Shortcuts → Settings → Advanced**.

**Check your setup:** copy a harmless sample, press the hotkey in your usual app, then use Finder’s Go to Folder with `~/inbox` to confirm a file appeared. A save notification should appear, but a missing notification does not necessarily mean saving failed.

`⌃` means Control, `⌥` Option, and `⌘` Command. External keyboard labels such as Start/Windows and Alt may map differently; use the modifiers macOS recognizes. The example is optional. If it conflicts with Typeless or another tool, choose another combination, such as `⌘⇧9` (Command + Shift + 9), after checking for conflicts.

**A Shortcuts keyboard shortcut may not trigger in every app.** First run it using the play button in Shortcuts to check saving itself, then follow the [troubleshooting guide](docs/troubleshooting.md). The published installer uses macOS Shortcuts; it does not guarantee global key delivery in every app.

## Everyday use

| What you want | Action | What enters this conversation |
|---|---|---|
| Save text and keep working | Copy → save hotkey | No message |
| See what is waiting | Claude Code: `/merge`; Codex: `$merge`; or “What’s in my inbox?” | Filenames, line counts, and first-line previews |
| Use an item | “Read inbox #2 and use it to revise the plan” | The selected file’s full text |
| File it into a project | “Move #2 to notes/plan.md without reading the body” | The move result |
| Leave items for later | “Keep all” | Files remain in the inbox |
| Remove an item | “Delete #3” | The deletion result |

Numbers refer to the **latest listing** and may change when files are added or removed. You can also name a file. `merge` does not automatically read everything or merge content into the main chat or code.

The `inbox` skill still exists: `/inbox` in Claude Code, `$inbox` in Codex. It is an optional preview-and-confirm route that adds messages and a short preview to the current conversation. **Use the hotkey to save without involving the main chat.**

Retrieval requires the skill and an agent allowed to read files on this Mac. Installing the local tool does not automatically give browser chats, remote agents, or cloud sessions access to the inbox.

## Where does the inbox live?

The default is **`~/inbox` in your Mac user’s home directory**, independent of any project or chat. Claude Code and Codex running as that user share it.

```text
~/inbox/
  2026-10-02-100000-Test plan.md
  2026-10-02-110000-API design.md

some-project/notes/plan.md   ← move a chosen file here when ready to file it
```

Each successful save leaves a text file; duplicate content may be skipped. Later copies do not replace saved files, and closing a chat does not delete them. Reading leaves the file in place; filing moves it; deletion requires your instruction. There is no automatic expiry or mandatory cleanup.

## Does this work across Codex Side Chat and Quick Chat?

Both can be sources of text. Even if you open Side Chat from the main conversation and then open Quick Chat, collection stays the same: **select what matters → copy → press your save hotkey.** Check that the shortcut actually triggers in your app using the setup steps below.

Two distinctions matter:

- **Layered windows do not establish a parent–child conversation hierarchy.** Quick Chat opens an ordinary ChatGPT chat; do not assume it inherits the side chat’s full context or model. [Official documentation](https://learn.chatgpt.com/docs/projects)
- **Native handoff and an inbox can coexist.** Use “Add to Codex” when your interface offers it and it suits the task. side-inbox is useful for selected text, deferred processing, or handoff to another project or Claude Code.

Desktop Side Chat and terminal `/side` should also be distinguished. Codex’s official CLI documentation describes `/side` as ephemeral and unavailable inside another `/side`. That does not establish the same restrictions for every desktop window. [CLI documentation](https://learn.chatgpt.com/docs/developer-commands)

The tool does not depend on side chats being read-only or disappearing on close. Persistence, permissions, and recovery vary by product and version. Product notes above were checked on **2026-10-02**.

## Data and limits

- **Local collection, no model call.** The tool reads clipboard text on demand, not every time you copy. Saving does not send the body to an AI. Asking an agent to read it later brings the body into that conversation under that product’s data rules.
- **No rewriting.** Clipboard plain text is stored in a `.md` file, with a trailing newline added if missing. Images, attachments, and rich-text styling are not preserved. Markdown missing from the source app’s copy output cannot be reconstructed.
- **Duplicate checks, not intent detection.** Quick save checks whether the clipboard changed and whether matching text already exists in the inbox. It cannot know that you copied the wrong thing. Check the notification or file and delete mistaken clips.
- **An ordinary folder.** It is not encrypted or automatically synced, and it does not isolate files from other programs with access. Filenames, notifications, listings, and the local `.log` may contain content titles.

## More information and feedback

- [Hotkeys, notifications, manual setup, updates, and uninstalling](docs/troubleshooting.md)
- [Changelog / 更新记录](CHANGELOG.md)
- [Contributing / 参与贡献](CONTRIBUTING.md)
- [Report a problem or suggest an improvement](https://github.com/zaozhiyi/side-inbox/issues)
- Related upstream discussions: [Codex side-chat persistence](https://github.com/openai/codex/issues/26227), [Claude Code feature request](https://github.com/anthropics/claude-code/issues/97377). These overlap with selected-text handoff but do not mean this tool restores entire sessions.

Independent community project, not affiliated with Anthropic or OpenAI. [MIT license](LICENSE).
