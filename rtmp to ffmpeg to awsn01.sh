#!/bin/bash
ffmpeg -i "rtmp://live.restream.io/live/re_9729728_0384e9c2cb10a22d2bbb" \
  -c:v copy -c:a copy \
  -mpegts_service_type digital_tv \
  -streamid 0:260 -streamid 1:250 \
  -f mpegts "srt://52.86.243.31:20020?mode=caller&latency=200000"