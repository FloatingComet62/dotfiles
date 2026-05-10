#!/usr/bin/env bash

connected="$(bluetoothctl devices Connected)"

if [ -z "$connected" ]; then
    echo "Offline"
else
    echo "$connected"
fi
