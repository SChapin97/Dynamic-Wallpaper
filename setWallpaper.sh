#!/bin/bash

if [ -r "$HOME/.dbus/Xdbus" ]; then
  . "$HOME/.dbus/Xdbus"
fi

rm image*
python3 getImagesFromReddit.py
success=$?

if [[ "$success" -eq 0 ]]; then
    chmod 777 image*
    python3 ksetwallpaper.py /home/schapin/Scripts/Dynamic-Wallpaper/image*
else
    python3 ksetwallpaper.py $(find /home/schapin/Pictures/Wallpapers -type f | shuf | head -n 1)
fi
