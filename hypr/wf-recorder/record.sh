#!/bin/bash

notify-send "mkc"
# Check if a recording is already in progress
if pgrep -x wf-recorder > /dev/null
then
    # If recording, stop it
    notify-send -h string:wf-recorder:record -t 1000 "Recording Stopped" && pkill wf-recorder
else
    # If not recording, start it
    notify-send -h string:wf-recorder:record -t 1000 "Recording Started" && wf-recorder -a [audio_device] -f /path/to/your/video.mp4
fi
