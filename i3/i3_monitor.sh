#!/bin/bash
xrandr --auto
mon=$(xrandr --listmonitors | grep Monitors | cut -d ":" -f 2)
if [ $mon -gt 1 ]
then
	xrandr --output eDP-1 --off
else
	xrandr --output eDP-1 --auto
fi
