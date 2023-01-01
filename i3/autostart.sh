#!/bin/bash
dunst &
dropbox start $
nitrogen --restore &
picom --experimental-backends  --config $HOME/.config/i3/picom/picom.conf &
notify-send "Welcome $USER"
