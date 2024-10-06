#!/usr/bin/bash
pulseaudio -k && pactl load-module module-detect && pacmd set-default-sink "alsa_output.0.hdmi-stereo"