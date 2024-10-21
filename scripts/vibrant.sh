#!/usr/bin/bash
~/Documents/dev/libvibrant/build/cli/vibrant-cli eDP-1 1.5
~/Documents/dev/libvibrant/build/cli/vibrant-cli HDMI-1 1.25
xrandr --output eDP-1 --gamma .65:.65:.65
