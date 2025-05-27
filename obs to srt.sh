#!/bin/bash
ffmpeg -i "srt://127.0.0.1:9999?mode=caller" \
  # set fps and resolution
  -vf "fps=59.94,scale=1920:1080" \
  # set bitrate
  -c:v libx264 -b:v 10M -minrate 5M -maxrate 5M -bufsize 20M -x264opts nal-hrd=cbr -r 59.94 -pix_fmt yuv420p -profile:v high -level 4.1 \
  -c:a aac -b:a 192k -ac 2 -ar 48000 -sample_fmt fltp \
  # set pids
  -map 0:v:0 -map 0:a:0 \
  -streamid 0:260 -streamid 1:250 \
  -mpegts_service_type digital_tv \
  -metadata:s:v:0 title="Video Stream" \
  -metadata:s:a:0 title="Audio Stream" \
  -mpegts_pmt_start_pid 32 \
  -mpegts_start_pid 260 \
  -mpegts_copyts 1 \
  # set srt endpoints
  -f mpegts \
  "srt://ip_address:port_number?pkt_size=1316&mode=caller"
