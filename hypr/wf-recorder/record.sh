#!/usr/bin/env bash

# Check if a recording is already in progress
if pgrep -x wf-recorder > /dev/null
then
    # If recording, stop it
    notify-send -h string:wf-recorder:record -t 1000 "Recording Stopped" && pkill wf-recorder
else
    # If not recording, start it
    mkdir -p ~/Videos
    mkdir -p ~/Videos/Screencasts/
    notify-send -h string:wf-recorder:record -t 1000 "Recording Started" && wf-recorder -f ~/Videos/Screencasts/$(date '+%H%M%S-%d-%m-%Y').mp4
fi
