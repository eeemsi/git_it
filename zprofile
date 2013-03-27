# Start or reattach a tmux session when a ssh connection is established
if [ -z "$TMUX" ] && [ "$TERM" != "screen" ]; then
    tmux attach-session -d || tmux new
    exit
fi
