#!/bin/bash

#Setting up $HOME variable for the crontab to work
mkdir $HOME/.dbus 2> /dev/null
touch $HOME/.dbus/Xdbus
chmod 600 $HOME/.dbus/Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus


#Running the getImagesFromReddit.py script once at startup so images can be used later
if ! [[ -z "$ls -A /home/schapin/Scripts/Dynamic-Wallpaper/Images/)" ]]; then
    rm /home/schapin/Scripts/Dynamic-Wallpaper/Images/*
fi

sleep 15
pings=100
while [[ "$pings" -ne 0 ]] ; do
    ping -c 1 reddit.com
    rc=$?
    if [[ "$rc" -eq 0 ]] ; then
        ((pings = 1))
    fi
    ((pings = pings - 1))
done

if [[ "$rc" -eq 0 ]] ; then
    python3 getImagesFromReddit.py
    chmod 777 /home/schapin/Scripts/Dynamic-Wallpaper/Images/*
fi

exit 0
