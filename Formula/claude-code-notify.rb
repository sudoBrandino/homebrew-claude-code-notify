class ClaudeCodeNotify < Formula
  desc "Notification hook for Claude Code — quiet when your terminal is already frontmost"
  homepage "https://github.com/sudoBrandino/claude-code-notify"
  url "https://github.com/sudoBrandino/claude-code-notify/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "12651147623cef6ea6dc40ce819a2ef5a37fe37805839349e8003250021d9e4f"
  license "MIT"

  # jq is required on both platforms: Linux uses it for JSON parsing at runtime;
  # macOS uses it for the --install-hooks / --uninstall-hooks subcommands.
  depends_on "jq"

  def install
    bin.install "notify.sh" => "claude-code-notify"
    pkgshare.install "bundle", "settings.example.json", "tests"
  end

  def caveats
    <<~EOS
      Finish setup with:

        claude-code-notify --install-hooks

      That wires this binary into ~/.claude/settings.json for the Notification
      and Stop events. Idempotent; preserves any existing hooks.

      To undo: claude-code-notify --uninstall-hooks

      Optional (macOS): build the custom-icon .app wrapper with click-to-focus:
        #{opt_pkgshare}/bundle/build.sh

      Drop an AppIcon.icns into #{opt_pkgshare}/bundle/ beforehand for a custom icon.
    EOS
  end

  test do
    # Dry-run mode prints fields instead of posting a notification.
    ENV["CLAUDE_NOTIFY_DRY_RUN"] = "1"
    ENV["CLAUDE_NOTIFY_SKIP_IF_FRONTMOST"] = ""
    output = pipe_output(
      "#{bin}/claude-code-notify",
      '{"hook_event_name":"Stop","stop_reason":"end_turn","last_assistant_message":"hi"}',
      0,
    )
    assert_match "subtitle=Done", output
    assert_match "message=hi", output
  end
end
