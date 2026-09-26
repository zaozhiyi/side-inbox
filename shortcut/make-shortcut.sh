#!/bin/bash
# Build a macOS Shortcut that runs `side-inbox quick`, sign it on THIS Mac,
# and open it so Shortcuts shows the "Add Shortcut" dialog.
# The shortcut is generated locally instead of shipped pre-signed, so no one
# else's signing identity is embedded in the file you import.
set -euo pipefail
if defaults read -g AppleLanguages 2>/dev/null | grep -q '"zh'; then NAME="存到收件箱"; else NAME="Save to Inbox"; fi
OUT="${1:-$(mktemp -d)}"
unsigned="$OUT/$NAME.unsigned.shortcut"
signed="$OUT/$NAME.shortcut"
/usr/bin/python3 - "$unsigned" <<'PY'
import plistlib, sys
script = '"$HOME/.local/bin/side-inbox" quick'
wf = {
    "WFWorkflowClientVersion": "2605.0.5",
    "WFWorkflowMinimumClientVersion": 900,
    "WFWorkflowMinimumClientVersionString": "900",
    "WFWorkflowIcon": {"WFWorkflowIconStartColor": 4292093695, "WFWorkflowIconGlyphNumber": 59511},
    "WFWorkflowTypes": [],
    "WFWorkflowInputContentItemClasses": [],
    "WFWorkflowImportQuestions": [],
    "WFWorkflowActions": [{
        "WFWorkflowActionIdentifier": "is.workflow.actions.runshellscript",
        "WFWorkflowActionParameters": {"Script": script, "Shell": "/bin/zsh", "InputMode": "to stdin"},
    }],
}
plistlib.dump(wf, open(sys.argv[1], "wb"), fmt=plistlib.FMT_BINARY)
PY
shortcuts sign --mode anyone --input "$unsigned" --output "$signed"
rm -f "$unsigned"
echo "$signed"
