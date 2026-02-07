#!/bin/sh

# Get the volume level and convert it to a percentage
#volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
#volume=$(echo "$volume" | awk '{print $2}')
#volume=$(echo "( $volume * 100 ) / 1" | bc)

#notify-send -t 1000 -a 'wp-vol' -h int:value:$volume "Volume: ${volume}%"

#bindel = ,XF86MonBrightnessUp, exec, brightnessctl s -e 8%+

# Get the brightness
brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
# Calculate the brightness percentage
brightness_percentage=$(echo "scale=2; ($brightness / $max_brightness) * 100" | bc)
# Send a notification with the brightness percentage
notify-send -t 1000 -a 'volbrightness' -h int:value:$brightness_percentage "Brightness: ${brightness_percentage}%"