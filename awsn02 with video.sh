#!/bin/bash
ffmpeg -re -stream_loop -1 -i "C:\Users\khang\OneDrive\Desktop\test.mp4" \
  -vf "fps=59.94,scale=1920:1080" \
  -c:v libx264 -b:v 10M -minrate 5M -maxrate 5M -bufsize 20M -x264opts nal-hrd=cbr -r 59.94 -pix_fmt yuv420p -profile:v high -level 4.1 \
  -c:a aac -b:a 192k -ac 2 -ar 48000 -sample_fmt fltp \
  -map 0:v:0 -map 0:a:0 \
  -streamid 0:260 -streamid 1:250 \
  -mpegts_service_type digital_tv \
  -metadata:s:v:0 title="Video Stream" \
  -metadata:s:a:0 title="Audio Stream" \
  -mpegts_pmt_start_pid 32 \
  -mpegts_start_pid 260 \
  -mpegts_copyts 1 \
  -f mpegts \
  "srt://52.4.214.70:20024?pkt_size=1316&mode=caller"
