#!/usr/bin/env bash

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

            if [ -x "$(which go)" ] && [ ! -f "${HOME}"/.zsh/golang ]; then
                if [ ! -d "${HOME}"/golang ]; then
                    mkdir "${HOME}"/golang
                fi

                echo "# Set gopath \nexport GOPATH="${HOME}"/golang" > "${HOME}"/.zsh/golang
            fi

            for i in `ls "${HOME}"/.zsh`; do
                echo "source \""'${HOME}'/.zsh/"${i}""\"" >> "${HOME}"/.zshrc
            done
            ;;
        *)
            echo "wrong argument"
            ;;
    esac
else
    echo "nothing specified"
fi
