# Disable audio bell
xset b off

# Disable the screen saver
xset s off

# Define values for the modes standby, suspend and off
xset dpms 0 0 0

# Enforce correct locales from the beginning
unset LC_ALL
export LANG=en_US.UTF-8
export LC_MESSAGES=C

# Load e.g. settings for colors for terminals
xrdb ${HOME}/.Xresources

# Simple black background
xsetroot -solid black

# Start urxvtd
urxvtd -q -f -o &

# Automatically lock the screen on certain hooks
xss-lock -- i3lock -e -f -c '#000000' &

# Start window manager
i3
