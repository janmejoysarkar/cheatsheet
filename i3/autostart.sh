#!/bin/bash
$HOME/.config/i3/i3_monitor.sh
dunst &
dropbox start $
nitrogen --restore &
picom --experimental-backends  --config $HOME/.config/i3/picom/picom.conf &
xautolock -time 10 -locker "systemctl suspend" -corners 0-00 -cornersize 20 -detectsleep &
sleep 1 && notify-send "Welcome back, $USER"
