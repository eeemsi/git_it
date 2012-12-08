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
unset LC_ALL
export LANG=en_US.UTF-8
export LC_MESSAGES=C
export LC_TIME=en_DK.UTF-8

# Start urxvtd
urxvtd -q -f -o &

# Fire up the windowmanager
i3
