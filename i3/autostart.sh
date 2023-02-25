#!/bin/bash
dunst &
dropbox start $
nitrogen --restore &
picom --experimental-backends  --config $HOME/.config/i3/picom/picom.conf &
$HOME/.config/i3/i3_monitor.sh
sleep 1 && notify-send "Welcome back, $USER"
