#!/bin/bash

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi


if ! [[ -z "$(ls -A /home/schapin/Scripts/Dynamic-Wallpaper/Images/)" ]]; then
    python3 ksetwallpaper.py $(find /home/schapin/Scripts/Dynamic-Wallpaper/Images -type f | shuf | head -n 1)
else
    python3 ksetwallpaper.py $(find /home/schapin/Pictures/Wallpapers -type f | shuf | head -n 1)
    /bin/bash /home/schapin/Scripts/Dynamic-Wallpaper/initialize.sh
fi
