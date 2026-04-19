class ClaudeCodeNotify < Formula
  desc "Notification hook for Claude Code — quiet when your terminal is already frontmost"
  homepage "https://github.com/sudoBrandino/claude-code-notify"
  url "https://github.com/sudoBrandino/claude-code-notify/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5276fbb6af53467a5f282e6acd813479a50aeb28f9a900015e84de71c1f6ffa0"
  license "MIT"

  on_linux do
    depends_on "jq"
  end

  def install
    bin.install "notify.sh" => "claude-code-notify"
    pkgshare.install "bundle", "settings.example.json", "tests"
  end

  def caveats
    <<~EOS
      Wire the hook into ~/.claude/settings.json under "hooks":

        "Notification": [{"hooks":[{"type":"command","command":"#{opt_bin}/claude-code-notify","timeout":3}]}],
        "Stop":         [{"hooks":[{"type":"command","command":"#{opt_bin}/claude-code-notify","timeout":3}]}]

      Example config: #{opt_pkgshare}/settings.example.json

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
