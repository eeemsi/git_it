# Check if the shell is not interactive and return if true
[[ $- != *i* ]] && return

. "${HOME}"/.zsh/aliases
. "${HOME}"/.zsh/autoload
. "${HOME}"/.zsh/completion
. "${HOME}"/.zsh/environment
. "${HOME}"/.zsh/history
. "${HOME}"/.zsh/keybindings
. "${HOME}"/.zsh/prompt
. "${HOME}"/.zsh/term_title
. "${HOME}"/.zsh/vcs_info
