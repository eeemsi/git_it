# Start or reattach a tmux session when a ssh connection is established
if [[ -n "${SSH_CONNECTION}" ]] && [[ "${TERM}" != "tmux-256color" ]]; then
  tmux attach-session -d || tmux new-session
  exit
fi
