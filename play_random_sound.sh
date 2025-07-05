#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOUNDS_DIR="$SCRIPT_DIR/sounds"

# Check if sounds directory exists
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

# Select a random sound file
RANDOM_INDEX=$((RANDOM % ${#SOUND_FILES[@]}))
RANDOM_SOUND="${SOUND_FILES[$RANDOM_INDEX]}"

# Display which file is being played
echo "Playing: $(basename "$RANDOM_SOUND")"

# Play the sound using afplay (macOS default audio player)
afplay "$RANDOM_SOUND"