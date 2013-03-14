#!/usr/bin/env sh

IP=`ifconfig eth0.1 | sed -n '/dr:/{;s/.*dr:\([0-9.]\+\) .*/\1/;p;}'`
URL="http://username:passwd@members.dyndns.org/nic/update?hostname=bl4.dyndns.org&myip=$cip&wildcard=NOCHG"

curl "$URL" > /dev/null
