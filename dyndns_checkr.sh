#!/bin/sh

# hint: put this into crontab
# */15 * * * * /bin/dyndns_checkr.sh > /dev/null
# 0 1 * * 1 /bin/update_dns.sh > /dev/null

cip=`ifconfig eth0.1 | sed -n '/dr:/{;s/.*dr:\([0-9.]\+\) .*/\1/;p;}'`
lip=`nslookup bl4.dyndns.org | tail -2 | grep Address | awk '{print $3}'`

if [ $cip != $lip ]; then
    /bin/update_dyndns.sh
fi
