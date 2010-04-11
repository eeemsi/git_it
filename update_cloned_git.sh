#!/bin/bash
ARRAY=`ls /home/msi/cloned_git/`
echo "$ARRAY"

for i in $ARRAY; do
	if [ -d "/home/msi/cloned_git/$i"]; then
	cd /home/msi/cloned_git/$i && git pull;
	fi
done
