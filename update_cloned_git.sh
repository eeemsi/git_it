#!/bin/bash
ARRAY=`ls $HOME/cloned_git/`

for i in $ARRAY; do
	if [ -d "$HOME/cloned_git/$i" ]; then
	cd $HOME/cloned_git/$i && make distclean;
    cd $HOME/cloned_git/$i && git clean -f && git gc;
	cd $HOME/cloned_git/$i && git pull;
	fi
done
