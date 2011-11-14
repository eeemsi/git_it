# Enable touchpad on eeepc
xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Tap Action" 0 0 0 0 1 2 3

# Turn off that none existing LVDS as the machine is not a laptop
xrandr --output LVDS1 --off --output VGA1 --mode 1440x900

# Disable DPMS turning off the screen
xset -dpms
xset s off

# Turn off the bell
xset -b

# Enable old style zapping
setxkbmap -option terminate:ctrl_alt_bksp

# Enforce correct locales from the beginning
unset LC_COLLATE
export LC_CTYPE=de_DE.UTF-8
export LC_TIME=de_DE.UTF-8
export LC_NUMERIC=de_DE.UTF-8
export LC_MONETARY=de_DE.UTF-8
export LC_MESSAGES=C
export LC_PAPER=de_DE.UTF-8
export LC_NAME=de_DE.UTF-8
export LC_ADDRESS=de_DE.UTF-8
export LC_TELEPHONE=de_DE.UTF-8
export LC_MEASUREMENT=de_DE.UTF-8
export LC_IDENTIFICATION=de_DE.UTF-8


# Start urxvtd
urxvtd -q -f -o -m &

# Finally start i3 having coredumps enabled and some debugging for it ... if needed
ulimit -c unlimited
#exec /usr/bin/i3 -V -d all >~/i3log-$(date +'%F-%k-%M-%S') 2>&1
i3
