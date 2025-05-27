#!/bin/bash
ffmpeg -i "rtmp://live.restream.io/live/your_stream_key" \
  -c:v copy -c:a copy \
  -mpegts_service_type digital_tv \
  -streamid 0:260 -streamid 1:250 \
  -f mpegts "srt_destination"
