#!/bin/sh
GITHOME="/home/msi/cloned_git"

for REPO in "${ARRAY[@]}"; do
 if [ -d $GITHOME/$REPO ]; then
  cd $GITHOME/$REPO && git pull
 echo "updated $REPO"
 fi 
done

