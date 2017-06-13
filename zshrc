if [[ ! -o interactive ]]; then
    source  "${HOME}"/.zsh/environment
    return
fi

autoload -Uz compinit vcs_info; compinit

for f in "${HOME}"/.zsh/*; do
    source "$f"
done
