#!/bin/bash
state=$(xrandr --verbose | grep -i gamma | head -n1 | cut -d':' -f4)
if [ $state == "1.0" ]
then
	xrandr --output eDP-1 --gamma 1:0.7:0.5
	xrandr --output HDMI-1 --gamma 1:0.7:0.5 --brightness 0.7
	echo "❨"
else
	xrandr --output eDP-1 --gamma 1:1:1
        xrandr --output HDMI-1 --gamma 1:1:1 --brightness 1
	echo "⦿"
fi
