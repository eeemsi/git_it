# Save 4000 lines of history
HISTSIZE=4000
HISTFILE=~/.zsh_history
SAVEHIST=4000

# History settings
setopt append_history extended_history hist_no_store hist_reduce_blanks hist_ignore_all_dups hist_ignore_space

# Unbelievable but it sets the editor and other stuff
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export VTYSH_PAGER='cat'

# Long date format in ls(1)
export TIME_STYLE=long-iso

# Don't send HUP signal to background jobs when exiting zsh
# Show that "did you mean message also use colors in completion menu
setopt no_HUP correct_all 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
eval `dircolors`
export COLORTERM="yes"

# Starts selection via menu when >selected elements appear
zstyle ':completion:*' menu select=3

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Set defaults for Xless-login (no xsession loaded)
export DISPLAY=${DISPLAY:-:0}

# NO BEEPING!
setopt no_BEEP

# Don't display an error if there are no matches, I know what I am doing
setopt no_NOMATCH

# We need to catch some strange behaviour from input keys  
if [[ "$TERM" != emacs ]] ; then
    [[ -z "$terminfo[kdch1]" ]] || bindkey -M emacs "$terminfo[kdch1]" delete-char
    [[ -z "$terminfo[khome]" ]] || bindkey -M emacs "$terminfo[khome]" beginning-of-line
    [[ -z "$terminfo[kend]"  ]] || bindkey -M emacs "$terminfo[kend]"  end-of-line
    [[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
    [[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
    [[ -z "$terminfo[kend]"  ]] || bindkey -M vicmd "$terminfo[kend]"  vi-end-of-line
    [[ -z "$terminfo[cuu1]"  ]] || bindkey -M viins "$terminfo[cuu1]"  vi-up-line-or-history
    [[ -z "$terminfo[cuf1]"  ]] || bindkey -M viins "$terminfo[cuf1]"  vi-forward-char
    [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
    [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history
    [[ -z "$terminfo[kcuf1]" ]] || bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
    [[ -z "$terminfo[kcub1]" ]] || bindkey -M viins "$terminfo[kcub1]" vi-backward-char
    # ncurses stuff:
    [[ "$terminfo[kcuu1]" == $'\eO'* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" vi-up-line-or-history
    [[ "$terminfo[kcud1]" == $'\eO'* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" vi-down-line-or-history
    [[ "$terminfo[kcuf1]" == $'\eO'* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
    [[ "$terminfo[kcub1]" == $'\eO'* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
    [[ "$terminfo[khome]" == $'\eO'* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]"  == $'\eO'* ]] && bindkey -M viins "${terminfo[kend]/O/[}"  end-of-line
    [[ "$terminfo[khome]" == $'\eO'* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]"  == $'\eO'* ]] && bindkey -M emacs "${terminfo[kend]/O/[}"  end-of-line
fi

# But we use emacs style for input keys by default
bindkey -e
bindkey '\e[1~' beginning-of-line       # home
bindkey '\e[4~' end-of-line             # end
bindkey '\e[A'  up-line-or-search       # cursor up
bindkey '\e[B'  down-line-or-search     # cursor down
bindkey '\e[7~' beginning-of-line       # home
bindkey '\e[8~' end-of-line             # end

# Report about cpu-/system-/user-time of command if running longer than 5 seconds
REPORTTIME=5    

# Watch for everyone but me and root
watch=(notme root) 

# Automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Skip .o-files when completing for vi
fignore=(.o)

# Do we have GNU ls with color-support?
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

# Show the git branch in prompt
export __CURRENT_GIT_BRANCH=
parse_git_branch() {
    [ -f .git/HEAD ] && sed 's/ref: refs\/heads\///g' .git/HEAD
}

get_git_prompt_info() {
    fg_dark_blue=$'%{\e[0;36m%}'
    fg_no_colour=$'%{\e[0m%}'

    if [ ! -z "$__CURRENT_GIT_BRANCH" ]
    then
        echo "${fg_dark_blue}$__CURRENT_GIT_BRANCH${fg_no_colour} "
    else
        echo ""
    fi
}

function set_termtitle() {
    # escape '%' chars in $1, make nonprintables visible
    a=${(V)1//\%/\%\%}

    # Truncate command, and join lines.
    a=$(print -rPn -- "$a" | tr -d "\n\r")

    [ "$a" = "zsh" ] && { a=$(print -Pn "%~") }

    case $TERM in
    tmux)
        # plain xterm title
        print -Pn -- "\e]2;$2: "
        print -rn -- "$a"
        print -n -- "\a"

        # screen title (in ^A")
        print -n -- "\ek"
        print -rn -- "$a"
        print -n -- "\e\\"

        # screen location
        print -Pn -- "\e_$2: "
        print -rn -- "$a"
        print -n -- "\e\\"
    ;;
    xterm*|*rxvt*)
        # plain xterm title
        print -Pn -- "\e]2;$2: "
        print -rn -- "$a"
        print -n -- "\a"
    ;;
    esac
}

function precmd() {
    export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
    set_termtitle "zsh" "%m"
}

function preexec() {
    set_termtitle "$1" "%m"
}

function chpwd() {
    export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
}

# Nicer output of grep
alias grep='grep --color=always --line-number --initial-tab'
alias egrep='egrep --color=always --line-number --initial-tab'

# If we want to pipe colors to less, we need this
alias less='less -R'

# URL-Escaping-magic to paste URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

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

# Use the cache 
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path /tmp/zsh-cache

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
export LC_TIME=en_US.UTF-8
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
export PATH=~/.bin:$PATH:/usr/sbin:/sbin

# Initialize completion
autoload compinit
compinit -C

# Set title, if supported by terminal
if [[ "$TERM" =~ rxvt ]]
then
    chpwd () { print -Pn "\e]0;%n %~ » \a" }
    chpwd
fi

# Define prompt colors
fg_green=$'%{\e[1;32m%}'
fg_white=$'%{\e[0;37m%}'
fg_red=$'%{\e[1;31m%}'
fg_no_colour=$'%{\e[0m%}'

# Enable substitution in prompt, necessary for $(get_git_prompt_info)
setopt prompt_subst

# SSH completion using the .ssh/config
#[ -e "$HOME/.ssh/config" ] && zstyle ':completion:*:complete:ssh:*:hosts' hosts $(sed -n "s/^[ \\t]*Host\(name\|\) \(.*\)/\\2/p" $HOME/.ssh/config | uniq)
zstyle ':completion:*:complete:ssh:*:*' hosts $(perl -ne "print '$1 ' if /^Host (.+)$/" ~/.ssh/config)

# Should look whether an ssh session is being used or not 
# FIXME
if [ ! -z "$SSH_CONNECTION" ]; then
  PROMPT="%(!.${fg_red}.${fg_green})%n${fg_white}@${fg_white}%m${fg_white} %~${fg_no_colour} \$(get_git_prompt_info)» "
else
  PROMPT="%(!.${fg_red}.${fg_green})%n${fg_white} %~${fg_no_colour} \$(get_git_prompt_info)» "
fi

