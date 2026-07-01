#!/bin/bash

MODE="$1"

CONFIG="$HOME/.config/waybar/scripts/waybar-light-controls/default_values/default_temperature.conf"
temperature=$(<"$CONFIG")


if [ "$MODE" == "up" ]; then

	temperature=$((temperature + 50))
        if [ "$temperature" -gt 7500 ]; then
                temperature=7500
        fi

elif [ "$MODE" == "down" ]; then

        temperature=$((temperature - 50))
        if [ "$temperature" -lt 4500 ]; then
                temperature=4500
        fi

elif [ "$MODE" == "reset" ]; then

        temperature=6500

fi
echo "$temperature" > "$CONFIG"
echo "$temperature"

hyprctl hyprsunset temperature "$temperature" > /dev/null 2>&1
