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

            for i in `ls "${HOME}"/.zsh`; do
                echo "source \""'${HOME}'/.zsh/"${i}""\"" >> "${HOME}"/.zshrc
            done
            ;;

        zsh-compile)
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
                cat "${HOME}"/.zsh/"${i}" >> "${HOME}"/.zshrc
            done

            zcompile "${HOME}"/.zshrc
            ;;

        *)
            echo "wrong argument"
            ;;
    esac
else
    echo "nothing specified"
fi
