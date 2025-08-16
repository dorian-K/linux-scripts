#!/bin/bash

HOSTNAME=$(hostname)

if [[ "$HOSTNAME" == "DORK-FRAME" ]]; then
    hyprctl keyword input:sensitivity -0.2
    hyprctl keyword input:accel_profile adaptive
    hyprctl keyword input:scroll_factor 0.5
else
    hyprctl keyword input:sensitivity -0.6
    hyprctl keyword input:accel_profile flat
fi

#echo $HOSTNAME > ~/lol
