#!/bin/bash

# Define NAS location and local directory
NAS_LOCATION="//192.168.10.10/NAS/Ax2NAS/ai/tts/voices"
LOCAL_SPEAKERS_DIR="/home/sewa/installed/xtts-api-server/speakers"

# Check if the local speakers directory exists, if not, create it
if [ ! -d "$LOCAL_SPEAKERS_DIR" ]; then
    mkdir -p "$LOCAL_SPEAKERS_DIR"
fi

# Check if already mounted
if mountpoint -q "$LOCAL_SPEAKERS_DIR"; then
    echo "NAS voices are already mounted to $LOCAL_SPEAKERS_DIR"
    exit 0
fi

# Mount the NAS voices to the local speakers directory. Script must be run with sudo.
mount -t cifs "$NAS_LOCATION" "$LOCAL_SPEAKERS_DIR" -o guest

# Check if mount was successful
if [ $? -eq 0 ]; then
    echo "NAS voices are now mounted to $LOCAL_SPEAKERS_DIR"
    echo "Available voices:"
    ls -la "$LOCAL_SPEAKERS_DIR"
else
    echo "Error: Failed to mount NAS voices." >&2
    exit 1
fi