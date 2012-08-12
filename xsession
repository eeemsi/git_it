# Enable touchpad on eeepc
#xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Tap Action" 0 0 0 0 1 2 3

# Disable DPMS turning off the screen
xset -dpms
xset s off

# Turn off the bell
xset -b

# Enable old style zapping
setxkbmap -option terminate:ctrl_alt_bksp

# Define intensity of the backlight
xbacklight -set 80

# Turn off repeating for un/mute
xset -r 121

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

# Fire up the windowmanager
i3
