# homebrew-claude-code-notify

Homebrew tap for [claude-code-notify](https://github.com/sudoBrandino/claude-code-notify) — a desktop notification hook for Claude Code.

## Install

```bash
brew tap sudoBrandino/claude-code-notify
brew install claude-code-notify
```

After install, add the hook to `~/.claude/settings.json` using the path printed in the caveats:

```json
{
  "hooks": {
    "Notification": [{"hooks":[{"type":"command","command":"/opt/homebrew/bin/claude-code-notify","timeout":3}]}],
    "Stop":         [{"hooks":[{"type":"command","command":"/opt/homebrew/bin/claude-code-notify","timeout":3}]}]
  }
}
```

(On Intel Macs and Linux, the path is `/usr/local/bin/claude-code-notify` or `$(brew --prefix)/bin/claude-code-notify`.)

## Optional: custom-icon bundle (macOS)

```bash
$(brew --prefix)/share/claude-code-notify/bundle/build.sh
```

See the [main repo README](https://github.com/sudoBrandino/claude-code-notify#optional-custom-icon--click-to-focus-bundle) for icon setup.
