#!/bin/bash

cp=/bin/cp

if [ ! -z "${1}" ]; then
    case "${1}" in
        i3)
            if [ ! -d "${HOME}"/.i3 ]; then
                mkdir "${HOME}"/.i3 && cp ./i3-tree_config "${HOME}"/.i3/config
            else
                cp ./i3-tree_config "${HOME}"/.i3/config
            fi
            ;;

        i3status)
            cp ./i3status.conf "${HOME}"/.i3status.conf
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
            if [ ! -d "${HOME}"/.zsh ]; then
                cp -r ./zsh "${HOME}"/.zsh
                file=".zshrc"
            else
                for file in ./zsh; do
                    cp "$file" "${HOME}"/.zsh
                done
                file=".zshrc_new"
            fi

            for i in `ls "${HOME}"/.zsh`; do
                echo "source \""'${HOME}'/.zsh/"${i}""\"" >> "${HOME}"/"$file"
            done
            ;;

        zsh-compile)
            if [ ! -f "${HOME}"/.zshrc ]; then
                file=".zshrc"
            else
                if [ -f "${HOME}"/.zshrc_new ]; then
                    rm "${HOME}"/.zshrc_new
                fi

                file=".zshrc_new"
            fi

            for i in `ls ./zsh`; do
                cat ./zsh/"${i}" >> "${HOME}"/"$file"
            done

            zcompile "${HOME}"/"$file"
            ;;

        *)
            echo "wrong argument"
            ;;
    esac
else
    echo "nothing specified"
fi
