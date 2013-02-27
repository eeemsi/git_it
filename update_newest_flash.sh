#!/bin/bash

make_tmp_dir() {
    if [ ! -d /tmp/flash_"$target" ]; then
        mkdir /tmp/flash_"$target"
    fi

    cd /tmp/flash_"$target"

    get_chrome_package
}


get_chrome_package() {
    if [ ! -f google-chrome-stable_current_"$target".deb ]; then
        wget -c https://dl-ssl.google.com/linux/direct/google-chrome-stable_current_"$target".deb
    fi

    extract_and_copy_version
}

extract_and_copy_version() {
    if [ ! -f data.tar.lzma ]; then
         ar vx google-chrome-stable_current_"$target".deb && tar xJf data.tar.lzma
    fi

    version=`strings ./opt/google/chrome/PepperFlash/libpepflashplayer.so | grep LNX | cut -d' ' -f2 | tr , .`

    sudo sh -c "cp ./opt/google/chrome/PepperFlash/libpepflashplayer.so /opt && chmod 644 /opt/libpepflashplayer.so"

    remove_created_temp_dir
}

remove_created_temp_dir() {
    if [ -d /tmp/flash_"$target" ]; then
        rm -rf /tmp/flash_"$target"
    fi

    create_alias
}

create_alias() {
    if [ ! -f "${HOME}/.zsh/chromium" ]; then
        touch "${HOME}"/.zsh/chromium
        echo "source \""'${HOME}'"/.zsh/chromium\"" >> "${HOME}"/.zshrc
    fi

    echo alias chromium=\"chromium --disk-cache-dir='/tmpfs' --incognito --ppapi-flash-path=/opt/libpepflashplayer.so --ppapi-flash-version="$version"\" > "${HOME}/.zsh/chromium"
}

# There are two possible targets -> i386 OR amd64, mention this if no argument
# is provided
if [ ! -z "${1}" ]; then
    case "${1}" in
        "amd64")
            target="${1}"
            ;;

        "i386")
            target="${1}"
            ;;

        *)
            echo "wrong target supplied"
            exit
            ;;
    esac

    make_tmp_dir

else
    echo "no argument given - use i386 or amd64"
    exit
fi
