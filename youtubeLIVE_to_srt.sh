#!/bin/bash

# YouTube Live URL
YOUTUBE_URL="youtube link here"

# SRT destination
SRT_DEST="SRT destination here"

# Check if yt-dlp is installed
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp not found. Installing it..."
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
fi

# Extract direct media URL
echo "Extracting direct media URL..."
MEDIA_URL=$(yt-dlp -g "$YOUTUBE_URL")

if [ -z "$MEDIA_URL" ]; then
  echo "Error: Failed to extract media URL from YouTube."
  exit 1
fi

# Start FFmpeg
echo "Starting FFmpeg with forced AAC audio and video PID 260, audio PID 250..."

ffmpeg -re -i "$MEDIA_URL" \
-vf "scale=1920:1080,interlace" \
-c:v libx264 -b:v 5M -maxrate 5M -bufsize 10M -x264opts nal-hrd=cbr -r 25 -pix_fmt yuv420p -profile:v high -level 4.1 -flags +ilme+ildct \
-c:a aac -b:a 192k -ac 2 -ar 48000 \
-map 0:v:0 -map 0:a:0 \
-streamid 0:260 -streamid 1:250 \
-mpegts_service_type digital_tv \
-metadata:s:v:0 title="Video Stream" \
-metadata:s:a:0 title="Audio Stream" \
-mpegts_pmt_start_pid 32 \
-mpegts_start_pid 260 \
-f mpegts -loglevel info "$SRT_DEST"

