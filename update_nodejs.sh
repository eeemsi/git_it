#!/usr/bin/env bash

version="${1}"

check_version() {
    if [ ! -f "/opt/node/bin/node" ]; then
        installed_version=""
    else
        installed_version="$(node -v | sed 's/^.//')"
    fi

    if [ -z "$installed_version" ]; then
        echo_path
    fi

    if [ "$installed_version" != "$version" ]; then
        make_tmp_dir
    else
        echo "requested version equals installed version"
        exit
    fi
}

echo_path() {
    echo "# Set PATHs for node.js
    export NODE_PATH=/opt/node:/opt/node/lib/node_modules
    export PATH=$PATH:/opt/node/bin" > ${HOME}/.zsh/nodejs
}

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

if [ ! -z "${1}" ]; then
    check_version
else
    return 1
fi
