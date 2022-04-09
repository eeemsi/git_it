# skip sourcing configs for non-interactive shells
if [[ ! -o interactive ]]; then
  return
fi

. "${HOME}"/.zsh/aliases
. "${HOME}"/.zsh/autoload
. "${HOME}"/.zsh/completion
. "${HOME}"/.zsh/environment
. "${HOME}"/.zsh/history
. "${HOME}"/.zsh/keybindings
. "${HOME}"/.zsh/prompt
. "${HOME}"/.zsh/term_title
. "${HOME}"/.zsh/vcs_info
