#!/bin/bash
folder='cloned_git'
ARRAY=`ls $HOME/$folder/`

for i in $ARRAY; do
	if [ -d "$HOME/$folder/$i" ]; then
        echo 'currently working in' $i;
	    cd $HOME/$folder/$i && git pull;
	    case $argv
            in "clean")
                echo 'cleaning up' $i;
                cd $HOME/$folder/$i && make distclean;
                cd $HOME/$folder/$i && git clean -f && git gc;
            ;;
        esac
	fi
done
