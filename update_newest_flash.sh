#!/bin/zsh

# There are two possible targets -> i386 OR amd64
target="amd64"

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
version=`strings libpepflashplayer.so | grep LNX | cut -d' ' -f2`

echo "\n\n=====================\nsteps left up to you:"
echo "cp -r "$folder"/opt/google/chrome/PepperFlash /usr/lib && chmod 644 /usr/lib/PepperFlash/libpepflashplayer.so"
echo "\n=======================\nplease start chromium the following way:"
echo "--ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version="$version""

