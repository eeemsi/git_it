#!/usr/bin/env bash

version="${1}"

check_version() {
	if [ -f "/opt/node/bin/node" ]; then
		installed_version="$(node -v | sed 's/^.//')"
	else
		installed_version=""
	fi

	if [ "$installed_version" != "$version" ]; then
		make_tmp_dir
	else
		echo "requested version equals installed version"
		exit 0
	fi
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
	if [ -d /tmp/nodejs_"$version" ]; then
		rm -rf /tmp/nodejs_"$version"
	fi
}

echo_path() {
	if [ ! -f ${HOME}/.zsh/nodejs ]; then
		echo "# Set PATHs for node.js\nexport PATH="'$PATH'":/opt/node/bin" > ${HOME}/.zsh/nodejs
	fi

	exit 0
}

if [ ! -z "${1}" ]; then
	check_version
	echo_path
else
	return 1
fi
