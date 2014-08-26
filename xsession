# Enable touchpad on eeepc
#xinput set-prop "ETPS/2 Elantech Touchpad" "Synaptics Tap Action" 0 0 0 0 1 2 3

# X settings: disable DPMS, disable audible bell
xset dpms force on s off -b

# Define one output to be the primary one
xrandr --output LVDS1 --primary

# Enable old style zapping
setxkbmap -option terminate:ctrl_alt_bksp

# Define intensity of the backlight
#xbacklight -set 80

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

# Change default Input Method
export GTK_IM_MODULE=xim

# Fire up the windowmanager
i3
