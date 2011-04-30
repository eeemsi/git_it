# Save 2000 lines of history
HISTSIZE=2000
HISTFILE=~/.zsh_history
SAVEHIST=2000
# Do not save duplicate entries
setopt HIST_IGNORE_DUPS

export PATH="$PATH:/home/msi/bin"
export EDITOR='vim'

# Set defaults for Xless-login (no xsession loaded)
export DISPLAY=${DISPLAY:-:0}

# NO BEEPING!
setopt no_BEEP

# Don't display an error if there are no matches, I know what I am doing
setopt no_NOMATCH

# We want to be able to use the home- and end-keys
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line

# Skip .o-files when completing for vi
fignore=(.o)

# do we have GNU ls with color-support?
if ls --help 2>/dev/null | grep -- --color= >/dev/null && [[ "$TERM" != dumb ]] ; then
    alias ls='ls -b -CF --color=auto'                                                
    alias la='ls -la --color=auto'
    alias ll='ls -l --color=auto'
    alias lh='ls -hAl --color=auto'
    alias l='ls -lF --color=auto'
else
    alias ls='ls -b -CF'
    alias la='ls -la'
    alias ll='ls -l'
    alias lh='ls -hAl'
    alias l='ls -lF'
fi

# Nicer output of grep
alias grep='grep -i --color=auto'
alias grep='grep --color=always --line-number --initial-tab'
alias egrep='egrep --color=always --line-number --initial-tab'

# If we want to pipe colors to less, we need this
alias less='less -R'

# URL-Escaping-magic to paste URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Change the colors for ls
eval $(dircolors -b)

# Show all processes when completing kill/killall and enable menu mode
zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:processes-names' command 'ps -aeo comm='
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*' menu yes select

# A nicer ps-output
alias p='ps -A f -o user,pid,priority,ni,pcpu,pmem,args'

# Replacement for ps uax | grep $foo
function psof
{
	PIDS=$(pidof ${1})
	[ -z "${PIDS}" ] && { echo "No such process"; return }
	ps -p "$PIDS" u
}

# Define prompt
fg_green=$'%{\e[1;32m%}'
fg_white=$'%{\e[0;37m%}'
fg_red=$'%{\e[1;31m%}'
fg_no_colour=$'%{\e[0m%}'
PROMPT="%(!.${fg_red}.${fg_green})%n${fg_white}@${fg_white}%m ${fg_white}%~${fg_no_colour} $ "
# use this line on machines where you have to be careful 
#PROMPT="%(!.${fg_red}.${fg_green})%n${fg_white}@${fg_white}%m %(!.${fg_red}.${fg_green})%~${fg_no_colour} $ "
# Have a bell-character put out, everytime a command finishes. This will set the urgent-hint,
# if the terminal is configured accordingly
bellchar=''
setterm -blength 0 # Don't REALLY beep
zle-line-init () { echo -n "$bellchar" }
zle -N zle-line-init

# Export language
export LANG=en_US.utf8
export LC_CTYPE=de_DE.UTF-8
export LC_COLLATE=de_DE.UTF-8
export LC_TIME=en_DK.UTF-8
export LC_NUMERIC=de_DE.UTF-8
export LC_MONETARY=de_DE.UTF-8
export LC_MESSAGES=C
export LC_PAPER=de_DE.UTF-8
export LC_NAME=de_DE.UTF-8
export LC_ADDRESS=de_DE.UTF-8
export LC_TELEPHONE=de_DE.UTF-8
export LC_MEASUREMENT=de_DE.UTF-8
export LC_IDENTIFICATION=de_DE.UTF-8

# Expand path to /usr/sbin and /sbin
export PATH=$PATH:/usr/sbin:/sbin

# Initialize completion
autoload compinit
compinit -C

# Leave processes open when closing a shell with background processes
setopt no_HUP

# Set title, if supported by terminal
if [[ "$TERM" =~ rxvt ]]
then
    chpwd () { print -Pn "\e]0;%n@%m: %~\a" }
    chpwd
fi;
