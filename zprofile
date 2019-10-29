# Start or reattach a tmux session when a ssh connection is established
if [[ ! -z "${SSH_CONNECTION}" ]] && [[ "${TERM}" != "screen" ]]; then
  tmux attach-session -d || tmux new-session
  exit
fi
