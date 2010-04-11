#!/bin/bash
ARRAY=`cd /home/msi/cloned_git/ && ls`
echo "$ARRAY"

for i in $ARRAY; do
	if [ -d $i]; then
	cd $i && git pull && sleep 500
	fi
done
