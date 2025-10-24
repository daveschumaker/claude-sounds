class ClaudeSounds < Formula
  desc "CLI tool that plays random sound effects from a collection of audio files"
  homepage "https://github.com/daveschumaker/homebrew-claude-sounds"
  url "https://github.com/daveschumaker/homebrew-claude-sounds/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "ba6cd52ae4da327b83323f36f728e5bcc0b8c1325b2fdf16f0b1fee81cc31ffa"
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
