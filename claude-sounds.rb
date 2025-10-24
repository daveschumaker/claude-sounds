class ClaudeSounds < Formula
  desc "CLI tool that plays random sound effects from a collection of audio files"
  homepage "https://github.com/daveschumaker/homebrew-claude-sounds"
  url "https://github.com/daveschumaker/homebrew-claude-sounds/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "176cebf36a0e351c986f2f075116f08c9807ff9fb7b3a1a49bb062fa9a7319e4"
  license "MIT"

  depends_on :macos

  def install
    # Install the sounds to pkgshare (idiomatic Homebrew location for package data)
    pkgshare.install Dir["sounds/*"]

    # Install the main script and patch it to use the Homebrew paths
    bin.install "claude-sounds"
    inreplace bin/"claude-sounds", 'SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"', "SCRIPT_DIR=\"#{pkgshare}\""
    inreplace bin/"claude-sounds", 'SOUNDS_DIR="$SCRIPT_DIR/sounds"', "SOUNDS_DIR=\"#{pkgshare}\""
  end

  test do
    assert_match "claude-sounds - Play random sound effects", shell_output("#{bin}/claude-sounds help")
  end
end
