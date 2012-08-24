#!/bin/zsh

# There are two possible targets -> i386 OR amd64
target="amd64"

# Create temporary directory and cd to it
cdt () {
    local t
    t=$(mktemp -d)
    echo "using the following directory to download: $t\n" && cd "$t"
}

cdt && wget https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_$target.deb && ar vx google-chrome-stable_current_$target.deb && tar xJf data.tar.lzma

echo "\n\n=====================\nsteps left up to you:\nplease cp -r <the given directory>opt/google/chrome/PepperFlash /usr/lib"
echo "ready to chmod 644 /usr/lib/PepperFlash/libpepflashplayer.so"
