autoload -Uz compinit vcs_info
compinit

for f in $( find ~/.zsh/ -type f ); do
  source "$f"
done
