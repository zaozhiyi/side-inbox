# Setup and troubleshooting

[Back to README](../README.md) · [中文](troubleshooting.zh-CN.md)

## No notification after pressing the hotkey

First distinguish **saving failed** from **saved, but no notification appeared**.

1. Open `~/inbox` with Finder’s Go to Folder and look for the new file. You can also run this in Terminal:

   ```bash
   "$HOME/.local/bin/side-inbox" list
   ```

2. If the file exists, saving worked. Check notification permissions and Focus settings for the app actually presenting the notification.
3. If no file appeared, copy different sample text and click the play button on “Save to Inbox” in Shortcuts. Quick save skips unchanged clipboard contents, text already in the inbox, and empty or non-text clipboard contents.
4. If manual execution works but the hotkey does not, check modifier mappings, shortcut conflicts, and whether the current app triggers the shortcut. Compare with another app. A working Command+C does not establish that Control and Option match the keycap labels.
5. If manual execution also fails, check Allow Running Scripts, the script path, and the displayed error. Test the command below separately. **It saves the current clipboard, so copy a harmless sample first.**

   ```bash
   "$HOME/.local/bin/side-inbox" quick
   ```

Shortcuts keyboard shortcuts may not trigger in every app. Manual execution is a temporary alternative that does not send a message to the main conversation. A native global hotkey approach is being explored; a successful personal setup is not a general release.

## Automatic shortcut creation failed

The generator uses `/usr/bin/python3` and macOS `shortcuts sign`. The CLI and detected agent skills may already be installed even if shortcut generation fails.

Create a shortcut manually in Shortcuts, add **Run Shell Script**, and enter:

```bash
"$HOME/.local/bin/side-inbox" quick
```

Name it “Save to Inbox,” assign a keyboard shortcut in Details, and enable Allow Running Scripts. Test with the play button first.

To install only the CLI and skills, skipping shortcut generation, run from the repository:

```bash
./install.sh --no-shortcut
```

## Claude Code or Codex cannot find merge

The installer installs skills when it detects `~/.claude` or `~/.codex`. Initialize your agent first, rerun the installer, then reopen the conversation or app so it can discover the skills.

| Agent | Skill directory | Invocation |
|---|---|---|
| Claude Code | `~/.claude/skills/merge/` | `/merge` |
| Codex | `~/.codex/skills/merge/` | `$merge` |

The installer skips existing skills with the same names that are not marked as belonging to side-inbox. Check for that warning. A remote or cloud agent also needs access to this Mac’s inbox; a skill name does not provide cross-machine file access.

## The wrong text, or an older clip, was saved

Clipboard checks reduce duplicate saves; they cannot verify your intended selection. Check the file or notification title. Use `/inbox` or `$inbox` for preview and confirmation, understanding that the preview and confirmation enter the current conversation.

Quick save compares the clipboard counter and the contents of files currently in the inbox. It is not a complete clipboard history manager. Filed or deleted items no longer participate in content deduplication. Do not rely on strong guarantees across counter resets after restarting, rapid repeated triggers, or concurrent saves.

## Can I change the inbox directory?

The CLI supports `SIDE_INBOX_DIR`, but the installer and skills default to `~/inbox`. Changing only the shortcut means saving to one directory and looking in another. Keep the default unless you need a custom setup.

For a custom setup, update the shortcut environment and the directory references in both agents’ `inbox` and `merge` skills. This is not a single global setting. Automatic per-project routing, source tags, and cross-machine sync are not built in.

## Update or uninstall

In an unmodified checkout, pull updates and reinstall the CLI and skills. Your existing shortcut can keep calling the same path:

```bash
git pull --ff-only
```

```bash
./install.sh --no-shortcut
```

Back up customized skills before updating: the installer replaces skills marked as belonging to this project.

To uninstall:

```bash
./uninstall.sh
```

This removes the CLI and this project’s installed skills, **preserving the contents and records in `~/inbox`**. Delete “Save to Inbox” and its key binding manually in Shortcuts. Remove any separately installed experimental helper using that helper’s instructions.

Still stuck? [Open an issue](https://github.com/zaozhiyi/side-inbox/issues/new/choose) with macOS/app versions, keyboard type, actual keys pressed, and whether manual execution worked. Use a harmless sample.
