#!/bin/bash
ffmpeg -i "$1" -crf 27 -preset veryfast -movflags +faststart -r 30 -vcodec libx264 -acodec aac "$2"

# ./prepare-video.sh video-de-entrada.avi video-de-saida.mp4