#!/bin/bash
xrandr --output HDMI-0 --primary
killall -q polybar

if type "xrandr"; then
	PRIMARY_MONITOR=$(xrandr --query | grep " primary" | cut -d" " -f1)
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		i3-msg "workspace 1:$m"	
		if [[ $m == "$PRIMARY_MONITOR" ]]; then
			MONITOR=$m polybar --reload --config=/etc/nixos/config/polybar/config.ini example &
		else
			MONITOR=$m polybar --reload --config=/etc/nixos/config/polybar/config.ini secondary &
		fi
	done
fi
