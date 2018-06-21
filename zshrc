# Check if the shell is is not interactive and return if true
[[ $- != *i* ]] && return

source "${HOME}"/.zsh/aliases
source "${HOME}"/.zsh/autoload
source "${HOME}"/.zsh/completion
source "${HOME}"/.zsh/environment
source "${HOME}"/.zsh/history
source "${HOME}"/.zsh/keybindings
source "${HOME}"/.zsh/prompt
source "${HOME}"/.zsh/term_title
source "${HOME}"/.zsh/vcs_info
