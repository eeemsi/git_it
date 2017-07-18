# export TZ
export TZ=:/etc/localtime

# Disable audio bell, screensaver and dpms
xset b off s off -dpms

# Enable old style zapping
setxkbmap -option terminate:ctrl_alt_bksp

# Disable autorepeat for un/mute
xset -r 121

# Enforce correct locales from the beginning
unset LC_ALL
export LANG=en_US.UTF-8
export LC_MESSAGES=C

# Set the short date to YYYY-MM-DD
export LC_TIME=en_DK.UTF-8

# Load e.g. settings for colors for terminals
xrdb -load ${HOME}/.Xresources

# Simple black background
xsetroot -solid black

# Start urxvtd
urxvtd -q -f -o &

# Start redshift
redshift -c ${HOME}/.config/redshift/config &

# Start window manager
i3 --shmlog-size=0

#
# DEBUG
# echo "---" >> ~/.i3/logfile
# i3 -V -d all >> ~/.i3/logfile
# Enable core dumps in case something goes wrong
# ulimit -c unlimited

