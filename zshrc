autoload -Uz compinit vcs_info; compinit

for f in "${HOME}"/.zsh/*; do
    source "$f"
done

unset f
