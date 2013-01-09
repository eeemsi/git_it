#!/bin/bash

# There are two possible targets -> i386 OR amd64, mention this if no argument
# is provided
if [ ! -z "$@" ]; then
    target="$@"
else
    echo "no argument given - use i386 or amd64"
    exit
fi

# Create temporary directory and cd to it
cdt () {
    local t
    t=$(mktemp -d)
    cd "$t"
}

cdt &&
folder=`pwd`
wget https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_"$target".deb &&
ar vx google-chrome-stable_current_"$target".deb &&
tar xJf data.tar.lzma &&
cd "$folder"/opt/google/chrome/PepperFlash &&
version=`strings libpepflashplayer.so | grep LNX | cut -d' ' -f2 | tr , .`

echo "executing:"
echo "sudo sh -c \"cp -r "$folder"/opt/google/chrome/PepperFlash/libpepflashplayer.so /opt && chmod 644 /opt/libpepflashplayer.so\""
sudo sh -c "cp -r "$folder"/opt/google/chrome/PepperFlash/libpepflashplayer.so /opt && chmod 644 /opt/libpepflashplayer.so"
rm -rf "$folder"
echo "\n\n -> chromium --ppapi-flash-path=/opt/libpepflashplayer.so --ppapi-flash-version="$version"\n\n"

