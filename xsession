# Disable audio bell in volume, pitch and duration
xset b 0 0 0

# Disable the screen saver
xset s off

# Define values for the modes standby, suspend and off
xset dpms 0 0 0

# Load e.g. settings for colors for terminals
xrdb "${HOME}"/.Xresources

# Simple black background
xsetroot -solid black

# Start urxvtd
urxvtd -q -f -o &

# Start redshift
redshift &

# Automatically lock the screen on certain hooks
xss-lock --transfer-sleep-lock -- i3lock -e -f -c '#000000' --nofork &

# Start window manager
i3
