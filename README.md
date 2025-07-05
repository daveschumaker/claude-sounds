# Claude Sounds

A simple bash script that plays random sound effects from a collection of audio files. This project appears to be set up as a notification hook for Claude Code, playing a random sound when certain events occur.

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
./play_random_sound.sh
```

### As a Claude Code Hook
This script is configured as a notification hook in Claude Code, automatically playing a sound when certain events occur.

## Requirements

- macOS (uses `afplay` for audio playback)
- Bash shell
- MP3 audio files in the `sounds/` directory

## Adding New Sounds

Simply add MP3 files to the `sounds/` directory. The script will automatically include them in the random selection pool.

## Notes

- The audio files appear to be generated using ElevenLabs with an "Archer - Conversational" voice profile
- The script uses proper error handling to check for the existence of the sounds directory and MP3 files