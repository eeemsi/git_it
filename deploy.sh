#!/usr/bin/env zsh

cp=/bin/cp

if [ ! -z "${1}" ]; then
	case "${1}" in
		i3)
			if [ ! -d "${HOME}"/.i3 ]; then
				mkdir "${HOME}"/.i3 && cp ./i3/config "${HOME}"/.i3/config
			else
				cp ./i3/config "${HOME}"/.i3/config
			fi
			;;

		i3status)
			cp ./i3/i3status.conf "${HOME}"/.i3/i3status.conf
			;;

		vim)
			cp ./vimrc "${HOME}"/.vimrc

			if [ ! -d "${HOME}"/.vim ]; then
				cp -r ./vim "${HOME}"/.vim
			fi
			;;

		xresources)
			cp ./Xresources "${HOME}"/.Xresources
			;;

		zsh)
			cp ./zshenv "${HOME}"/.zshenv
			cp ./zprofile "${HOME}"/.zprofile

			if [ -d "${HOME}"/.zsh ]; then
				cp ./zsh/* "${HOME}"/.zsh/
			else
				cp -r ./zsh "${HOME}"/.zsh
			fi

			if [ -f "${HOME}"/.zshrc ]; then
				rm "${HOME}"/.zshrc
			fi

			for i in `ls "${HOME}"/.zsh`; do
				echo "source \""'${HOME}'/.zsh/"${i}""\"" >> "${HOME}"/.zshrc
			done
			;;

		zsh-browsers)
			browsers=("chromium" "firefox")

			for ((i=1; i<=${#browsers}; i++)); do
				if [ -x "$(which "${browsers[i]}")" ] && [ ! -f "${HOME}"/.zsh/"${browsers[i]}" ]; then
					cp ./zsh_browsers/"${browsers[i]}" "${HOME}"/.zsh/"${browsers[i]}"
					echo "source \""'${HOME}'/.zsh/"${browsers[i]}""\"" >> "${HOME}"/.zshrc
				fi
			done
			;;

		zsh-debian)
			if [ ! -f "${HOME}"/.zsh/debian ]; then
				cp zsh_debian/debian "${HOME}"/.zsh/debian
			fi

			echo "source \""'${HOME}'/.zsh/debian"\"" >> "${HOME}"/.zshrc
			;;

		zsh-candy)
			if [ ! -f "${HOME}"/.zsh/candy ]; then
				cp zsh_candy/candy "${HOME}"/.zsh/candy
			fi

			echo "source \""'${HOME}'/.zsh/candy"\"" >> "${HOME}"/.zshrc
			;;

		zsh-golang)
			if [ -x "$(which go)" ] && [ ! -f "${HOME}"/.zsh/golang ]; then
				if [ ! -d "${HOME}"/golang ]; then
					mkdir "${HOME}"/golang
				fi

				echo "# Set gopath \nexport GOPATH="${HOME}"/golang" > "${HOME}"/.zsh/golang
			fi

			echo "source \""'${HOME}'/.zsh/golang"\"" >> "${HOME}"/.zshrc
			;;
		*)
			echo "wrong argument"
			exit 1
			;;
	esac
else
	echo "nothing specified"
	exit 1
fi
