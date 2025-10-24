# Claude Sounds

![Claude Sounds](claude-sounds.png)

A simple CLI tool that plays random sound effects from a collection of audio files. Perfect as a notification hook for Claude Code or for general terminal fun!

## 🔊 Example Sound

*[Click here to download and listen to an example sound file](sounds/ElevenLabs_2025-07-04T22_19_12_Archer%20-%20Conversational_pvc_sp100_s50_sb75_v3.mp3)*

## Project Structure

```md
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

# Enable/disable sounds globally
claude-sounds disable    # Disable all sound playback
claude-sounds enable     # Re-enable sound playback
claude-sounds status     # Check current status

# Show help
claude-sounds help
```

### Global Enable/Disable

The `enable` and `disable` commands allow you to toggle sound playback globally (across all terminal windows and sessions). This is particularly useful when you have `claude-sounds` configured as a hook but want to temporarily silence it without changing your configuration.

When sounds are disabled:

- All playback commands exit silently without playing sounds
- The disabled state persists across terminal sessions
- Hooks using `claude-sounds` won't fail, they'll just skip playback

```bash
# Disable sounds before a meeting
claude-sounds disable

# Check status
claude-sounds status
# Output: Status: disabled

# Re-enable when ready
claude-sounds enable

# Check status again
claude-sounds status
# Output: Status: enabled
```

The enable/disable state is stored in `~/.claude-sounds-disabled` and works globally across all terminal windows.

### Installation

#### Homebrew (Recommended)

Install via Homebrew:

```bash
brew install daveschumaker/claude-sounds/claude-sounds
```

Or tap the repository first:

```bash
brew tap daveschumaker/claude-sounds
brew install claude-sounds
```

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

### Using with Claude Code

You can configure `claude-sounds` as a notification hook in Claude Code to automatically play sounds when certain events occur.

#### Setting up Notification Hooks

Inside Claude Code:

1. Run `/hooks`
2. Select "Notification" hook
3. Select "+ Add new hook..."
4. Enter `claude-sounds`
5. Save settings

Now, whenever Claude would trigger a user notification, it will play a sound!

#### Temporarily Disable/Enable Sounds

Want to silence the sounds temporarily (like during a meeting)? You can use Claude Code's bash mode:

```bash
# Disable sounds
! claude-sounds disable

# Re-enable sounds
! claude-sounds enable

# Check current status
! claude-sounds status
```

#### Manual Configuration (Alternative)

You can also manually configure hooks by editing your Claude Code settings file (usually `~/.config/claude-code/settings.json`):

```json
{
  "hooks": {
    "user-prompt-submit": "claude-sounds random",
    "assistant-response-complete": "claude-sounds random"
  }
}
```

**Note:** If you installed via Homebrew, `claude-sounds` is automatically in your PATH. Otherwise, make sure `claude-sounds` is in your PATH before setting up hooks.

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

### Generating New Sounds with ElevenLabs

The included audio files were generated using [ElevenLabs](https://elevenlabs.io/) with the following settings:

- **Voice**: Archer - Conversational
- **Voice Settings**:
  - Stability: 50 (`s50`)
  - Similarity Boost: 75 (`sb75`)
  - Style Exaggeration: 14 (`se14`)
  - Speaker Boost: enabled (`b_m2`)

To generate new sounds with consistent quality:

1. Go to [ElevenLabs](https://elevenlabs.io/)
2. Select the "Archer" voice with "Conversational" style
3. Use the voice settings above
4. Export as MP3 and add to the `sounds/` directory

## Notes

- The script uses proper error handling to check for the existence of the sounds directory and MP3 files
