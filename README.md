# Claude Sounds

![Claude Sounds](claude-sounds.png)

A simple bash script that plays random sound effects from a collection of audio files. This project appears to be set up as a notification hook for Claude Code, playing a random sound when certain events occur.

### 🔊 Example Sound
*[Click here to download and listen to an example sound file](sounds/ElevenLabs_2025-07-04T22_19_12_Archer%20-%20Conversational_pvc_sp100_s50_sb75_v3.mp3)*

## Project Structure

```
claude-sounds/
├── play_random_sound.sh    # Main script that selects and plays random sounds
├── sounds/                 # Directory containing MP3 audio files
│   └── *.mp3              # Collection of ElevenLabs-generated audio files
└── README.md              # This file
```

## How It Works

The `play_random_sound.sh` script:
1. Locates all MP3 files in the `sounds/` directory
2. Randomly selects one of the available sound files
3. Plays the selected sound using macOS's built-in `afplay` command

## Usage

### Direct Usage
```bash
# Make sure the script is executable (should be preserved from Git)
chmod +x play_random_sound.sh

# Run the script
./play_random_sound.sh
```

### Global Access via PATH
To run the script from anywhere on your system, add the project directory to your PATH:

#### For Zsh (macOS default):
```bash
echo 'export PATH="$PATH:/Users/dave/projects/personal/claude-sounds"' >> ~/.zshrc
source ~/.zshrc
```

#### For Bash:
```bash
echo 'export PATH="$PATH:/Users/dave/projects/personal/claude-sounds"' >> ~/.bashrc
source ~/.bashrc
```

After adding to PATH, you can run the script from anywhere:
```bash
play_random_sound.sh
```

### As a Claude Code Hook
This script is configured as a notification hook in Claude Code, automatically playing a sound when certain events occur.

#### Setting up Claude Code Hooks
To configure this as a hook in Claude Code, add the following to your Claude Code settings:

1. Open your Claude Code settings file (usually `~/.config/claude-code/settings.json`)
2. Add a hook configuration:

```json
{
  "hooks": {
    "user-prompt-submit": "play_random_sound.sh",
    "assistant-response-complete": "play_random_sound.sh"
  }
}
```

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