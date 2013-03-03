#!/bin/bash

version="${1}"

make_tmp_dir() {
    if [ ! -d /tmp/"$version"_nodejs ]; then
        mkdir /tmp/"$version"_nodejs
    fi

    cd /tmp/"$version"_nodejs

    get_nodejs_version
}

get_nodejs_version() {
    if [ ! -f /tmp/"$version"_nodejs/node-v"$version".tar.gz ]; then
        wget -c http://nodejs.org/dist/v"$version"/node-v"$version".tar.gz
    fi

    extract_build_install
}

extract_build_install() {
    tar xf node-v"$version".tar.gz && cd node-v"$version"
    ./configure --prefix=/opt/node --openssl-includes=/usr/include/openss

    if [ -x "$(which clang)" ]; then
        CC=clang make
    else
        make
    fi

    sudo make install clean

    remove_created_temp_dir
}

remove_created_temp_dir() {
    rm -rf /tmp/"$version"_nodejs
}

make_tmp_dir
