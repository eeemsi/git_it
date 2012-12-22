#!/bin/bash

cp=/bin/cp

if [ ! -z "$1" ]; then
    case "$1" in
        i3)
            if [ ! -z ${HOME}/git_it/i3-tree-config ]; then
                cp -r ${HOME}/git_it/i3-tree-config ${HOME}/.i3/config
            fi

            if [ ! -z ${HOME}/git_it/i3status.conf ]; then
                cp -r ${HOME}/git_it/i3status.conf ${HOME}/.i3status.conf
            fi
            ;;

        vim)
            cp ${HOME}/git_it/vimrc ${HOME}/.vimrc

            if [ -d ${HOME}/git_it/vim ]; then
                cp -r ${HOME}/git_it/vim ${HOME}/.vim
            fi
            ;;

        xdefaults)
            cp ${HOME}/git_it/Xdefaults ${HOME}/.Xdefaults
            ;;

        zsh)
            if [ -d ${HOME}/git_it/zsh ]; then
                cp -r ${HOME}/git_it/zsh ${HOME}/.zsh
            fi

            for i in `ls ${HOME}/.zsh`; do
                echo "source \""'${HOME}'/.zsh/"${i}""\"" >> ${HOME}/.zshrc_new
            done
            ;;
    esac
else
    echo "noting specified"
fi
