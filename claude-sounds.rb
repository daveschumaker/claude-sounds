class ClaudeSounds < Formula
  desc "CLI tool that plays random sound effects from a collection of audio files"
  homepage "https://github.com/daveschumaker/claude-sounds"
  url "https://github.com/daveschumaker/claude-sounds/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "YOUR_SHA256_HASH_HERE"
  license "MIT"

  depends_on :macos

  def install
    # Install the main script
    bin.install "claude-sounds"

    # Install the sounds directory
    prefix.install "sounds"

    # Create a wrapper script that references the installed sounds directory
    (bin/"claude-sounds").unlink
    (bin/"claude-sounds").write <<~EOS
      #!/bin/bash
      SCRIPT_DIR="#{prefix}"
      SOUNDS_DIR="$SCRIPT_DIR/sounds"
      DISABLE_FLAG="$HOME/.claude-sounds-disabled"

      # Function to show help
      show_help() {
          cat << EOF
      claude-sounds - Play random sound effects from the command line

      Usage:
        claude-sounds [command] [arguments]

      Commands:
        random              Play a random sound (default if no command given)
        list                List all available sound files
        play <filename>     Play a specific sound file
        enable              Enable sound playback globally
        disable             Disable sound playback globally
        status              Show current enable/disable status
        help                Show this help message

      Examples:
        claude-sounds                    # Play a random sound
        claude-sounds random             # Play a random sound
        claude-sounds list               # List all available sounds
        claude-sounds play mysound.mp3   # Play a specific sound
        claude-sounds disable            # Disable all sounds globally
        claude-sounds enable             # Re-enable sounds globally
        claude-sounds status             # Check if sounds are enabled

      EOF
      }

      # Function to check if sounds are enabled
      check_if_enabled() {
          if [ -f "$DISABLE_FLAG" ]; then
              # Sounds are disabled, exit silently
              exit 0
          fi
      }

      # Function to enable sounds globally
      enable_sounds() {
          if [ -f "$DISABLE_FLAG" ]; then
              rm "$DISABLE_FLAG"
              echo "✓ Sounds enabled globally"
          else
              echo "✓ Sounds are already enabled"
          fi
      }

      # Function to disable sounds globally
      disable_sounds() {
          if [ ! -f "$DISABLE_FLAG" ]; then
              touch "$DISABLE_FLAG"
              echo "✓ Sounds disabled globally"
          else
              echo "✓ Sounds are already disabled"
          fi
      }

      # Function to show current status
      show_status() {
          if [ -f "$DISABLE_FLAG" ]; then
              echo "Status: disabled"
              echo "Run 'claude-sounds enable' to enable sounds"
          else
              echo "Status: enabled"
              echo "Run 'claude-sounds disable' to disable sounds"
          fi
      }

      # Function to check if sounds directory exists and has files
      check_sounds() {
          if [ ! -d "$SOUNDS_DIR" ]; then
              echo "Error: sounds directory not found at $SOUNDS_DIR"
              exit 1
          fi

          # Find all mp3 files in the sounds directory and store in array
          SOUND_FILES=()
          while IFS= read -r -d '' file; do
              SOUND_FILES+=("$file")
          done < <(find "$SOUNDS_DIR" -name "*.mp3" -type f -print0)

          # Check if any sound files were found
          if [ ${#SOUND_FILES[@]} -eq 0 ]; then
              echo "Error: No MP3 files found in $SOUNDS_DIR"
              exit 1
          fi
      }

      # Function to play a random sound
      play_random() {
          check_if_enabled
          check_sounds

          # Select a random sound file
          RANDOM_INDEX=$((RANDOM % ${#SOUND_FILES[@]}))
          RANDOM_SOUND="${SOUND_FILES[$RANDOM_INDEX]}"

          # Display which file is being played
          echo "Playing: $(basename "$RANDOM_SOUND")"

          # Play the sound using afplay (macOS default audio player)
          afplay "$RANDOM_SOUND"
      }

      # Function to list all sounds
      list_sounds() {
          check_sounds

          echo "Available sounds (${#SOUND_FILES[@]} total):"
          echo ""
          for sound in "${SOUND_FILES[@]}"; do
              echo "  $(basename "$sound")"
          done
      }

      # Function to play a specific sound
      play_specific() {
          check_if_enabled
          local filename="$1"

          if [ -z "$filename" ]; then
              echo "Error: No filename provided"
              echo "Usage: claude-sounds play <filename>"
              exit 1
          fi

          # Check if the file exists in the sounds directory
          local sound_path="$SOUNDS_DIR/$filename"

          if [ ! -f "$sound_path" ]; then
              echo "Error: Sound file '$filename' not found in $SOUNDS_DIR"
              echo ""
              echo "Use 'claude-sounds list' to see available sounds"
              exit 1
          fi

          echo "Playing: $filename"
          afplay "$sound_path"
      }

      # Parse command line arguments
      COMMAND="${1:-random}"

      case "$COMMAND" in
          random)
              play_random
              ;;
          list)
              list_sounds
              ;;
          play)
              play_specific "$2"
              ;;
          enable)
              enable_sounds
              ;;
          disable)
              disable_sounds
              ;;
          status)
              show_status
              ;;
          help|--help|-h)
              show_help
              ;;
          *)
              echo "Error: Unknown command '$COMMAND'"
              echo ""
              show_help
              exit 1
              ;;
      esac
    EOS

    chmod 0755, bin/"claude-sounds"
  end

  test do
    assert_match "claude-sounds - Play random sound effects", shell_output("#{bin}/claude-sounds help")
  end
end
