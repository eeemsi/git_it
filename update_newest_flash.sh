#!/usr/bin/env bash

make_tmp_dir() {
	if [ ! -d /tmp/flash_"$target" ]; then
		mkdir /tmp/flash_"$target"
	fi

	cd /tmp/flash_"$target"

	get_chrome_package
}


get_chrome_package() {
	if [ ! -f google-chrome-stable_current_"$target".deb ]; then
		wget -c https://dl.google.com/linux/direct/google-chrome-"$version"_current_"$target".deb
	fi

	extract_version
}

extract_version() {
	if [ ! -f data.tar.lzma ]; then
		 ar vx google-chrome-"$version"_current_"$target".deb && tar xJf data.tar.lzma
	fi

	downloaded_version=$(strings ./opt/google/chrome/PepperFlash/libpepflashplayer.so | grep LNX | cut -d' ' -f2 | tr , .)

	echo "-> extracted flash version "$downloaded_version""

	if [ -f /opt/libpepflashplayer.so ]; then
		installed_version=$(strings /opt/libpepflashplayer.so | grep LNX | cut -d' ' -f2 | tr , .)

		if [ "$downloaded_version" != "$installed_version" ]; then
			echo "-> updating $installed_version to  $downloaded_version\n"
			copy_version
		else
			echo "-> installed version ($installed_version) seems to be up to date\n"
		fi
	else
		echo "-> initially copied $downloaded_version\n"
		copy_version
	fi

	remove_created_temp_dir
}

copy_version() {
	sudo sh -c "cp ./opt/google/chrome/PepperFlash/libpepflashplayer.so /opt && chmod 644 /opt/libpepflashplayer.so"
}

remove_created_temp_dir() {
	if [ -d /tmp/flash_"$target" ]; then
		rm -rf /tmp/flash_"$target"
	fi
}

create_alias() {
	if [ ! -f "${HOME}/.zsh/chromium" ]; then
		touch "${HOME}"/.zsh/chromium
		echo "source \""'${HOME}'"/.zsh/chromium\"" >> "${HOME}"/.zshrc
	fi

	echo alias chromium=\"chromium --disk-cache-dir='/tmp' --incognito --ppapi-flash-path=/opt/libpepflashplayer.so --ppapi-flash-version="$downloaded_version" --audio-buffer-size=2048\" !> "${HOME}/.zsh/chromium"
}

# Automagically find out the architecture
case "$(uname -m)" in
	"x86_64")
		target="amd64"
		;;

	"i686")
		target="i386"
		;;

	*)
		echo ""$(uname -m)" - not support in this script"
		exit 1
		;;
esac

if [ ! -z ${1} ]; then
	case ${1} in
		"stable")
			version="stable"
			;;

		"beta")
			version="beta"
			;;

		*)
			echo ""${1}" isn't a known version"
			exit 1
			;;
	esac
fi

make_tmp_dir
create_alias
