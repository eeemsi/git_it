#!/bin/bash

version="${1}"

make_tmp_dir() {
    if [ ! -d /tmp/nodejs_"$version" ]; then
        mkdir /tmp/nodejs_"$version"
    fi

    cd /tmp/nodejs_"$version"

    get_nodejs_version
}

get_nodejs_version() {
    if [ ! -f node-v"$version".tar.gz ]; then
        wget -c http://nodejs.org/dist/v"$version"/node-v"$version".tar.gz
    fi

    extract_build_install
}

extract_build_install() {
    if [ ! -d node-v"$version" ]; then
        tar xf node-v"$version".tar.gz
    fi

    cd node-v"$version"

    if [ -x "$(which clang)" ]; then
        export CC=clang
        export CXX=clang++
    fi

    ./configure --prefix=/opt/node --openssl-includes=/usr/include/openssl

    make && sudo make install clean

    remove_created_temp_dir
}

remove_created_temp_dir() {
    rm -rf /tmp/nodejs_"$version"
}

make_tmp_dir
