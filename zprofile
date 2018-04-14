# Start or reattach a tmux session when a ssh connection is established
if [ ! -z "$SSH_CONNECTION" ] && [ "$TERM" != "screen" ]; then
    tmux attach-session -d || tmux new-session
    exit
fi

# Execute startx if the session is on the first tty and $DISPLAY is set
if [ "$XDG_VTNR" -eq 1 ] && [ -z "$DISPLAY" ]; then
    exec startx
fi
