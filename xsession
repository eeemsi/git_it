# X settings: disable audio bell, screensaver and dpms
xset b off s off -dpms

# Define one output to be the primary one
xrandr --output LVDS1 --primary

# Enable old style zapping
setxkbmap -option terminate:ctrl_alt_bksp

# Define intensity of the backlight
#xbacklight -set 15

# Turn off repeating for un/mute
xset -r 121

# Enforce correct locales from the beginning
unset LC_ALL
export LANG=en_US.UTF-8
export LC_MESSAGES=C

# Set the short date to YYYY-MM-DD
export LC_TIME=en_DK.UTF-8

# Start urxvtd
urxvtd -q -f -o &

# Fire up the windowmanager
i3
