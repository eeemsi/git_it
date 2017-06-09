# Start or reattach a tmux session when a ssh connection is established
if [ ! -z "$SSH_CONNECTION" ] && [ "$TERM" != "screen" ]; then
    tmux attach-session -d || tmux new-session
    exit
fi

# Execute startx when the session is on tty1 and there is a display
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx
fi
