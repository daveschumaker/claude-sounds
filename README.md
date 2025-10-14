# Claude Sounds

![Claude Sounds](claude-sounds.png)

A simple CLI tool that plays random sound effects from a collection of audio files. Perfect as a notification hook for Claude Code or for general terminal fun!

### 🔊 Example Sound
*[Click here to download and listen to an example sound file](sounds/ElevenLabs_2025-07-04T22_19_12_Archer%20-%20Conversational_pvc_sp100_s50_sb75_v3.mp3)*

## Project Structure

```
claude-sounds/
├── claude-sounds          # Main CLI script that selects and plays sounds
├── sounds/                # Directory containing MP3 audio files
│   └── *.mp3             # Collection of ElevenLabs-generated audio files
└── README.md             # This file
```

## How It Works

The `claude-sounds` CLI tool provides several commands:
- **random**: Locates all MP3 files in the `sounds/` directory, randomly selects one, and plays it
- **list**: Shows all available sound files
- **play**: Plays a specific sound file by name
- **help**: Displays usage information

All sounds are played using macOS's built-in `afplay` command.

## Usage

### Commands

```bash
# Play a random sound (default command)
claude-sounds
claude-sounds random

# List all available sounds
claude-sounds list

# Play a specific sound
claude-sounds play mysound.mp3

# Show help
claude-sounds help
```

### Installation

#### Local Usage
```bash
# Make sure the script is executable (should be preserved from Git)
chmod +x claude-sounds

# Run from the project directory
./claude-sounds random
```

#### Global Access via PATH
To run `claude-sounds` from anywhere on your system, add the project directory to your PATH:

**For Zsh (macOS default):**
```bash
echo 'export PATH="$PATH:/path/to/claude-sounds"' >> ~/.zshrc
source ~/.zshrc
```

**For Bash:**
```bash
echo 'export PATH="$PATH:/path/to/claude-sounds"' >> ~/.bashrc
source ~/.bashrc
```

After adding to PATH, you can run from anywhere:
```bash
claude-sounds random
```

### As a Claude Code Hook
You can configure `claude-sounds` as a notification hook in Claude Code to automatically play sounds when certain events occur.

#### Setting up Claude Code Hooks
To configure this as a hook in Claude Code:

1. Open your Claude Code settings file (usually `~/.config/claude-code/settings.json`)
2. Add a hook configuration:

```json
{
  "hooks": {
    "user-prompt-submit": "claude-sounds random",
    "assistant-response-complete": "claude-sounds random"
  }
}
```

**Note:** Make sure `claude-sounds` is in your PATH before setting up hooks.

Available hook events include:
- `user-prompt-submit`: Triggered when you submit a prompt
- `assistant-response-complete`: Triggered when Claude finishes responding
- `tool-call-start`: Triggered when Claude starts using a tool
- `tool-call-complete`: Triggered when Claude finishes using a tool

## Requirements

- macOS (uses `afplay` for audio playback)
- Bash shell
- MP3 audio files in the `sounds/` directory

## Adding New Sounds

Simply add MP3 files to the `sounds/` directory. The script will automatically include them in the random selection pool.

## Notes

- The audio files appear to be generated using [ElevenLabs](https://elevenlabs.io/) with an "Archer - Conversational" voice profile
- The script uses proper error handling to check for the existence of the sounds directory and MP3 files