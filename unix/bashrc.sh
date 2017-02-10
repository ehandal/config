# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=4000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

STARTCOLOR="\[\e[1;32m\]";
ENDCOLOR="\[\e[m\]";
if [ -n "$SSH_CLIENT" ]; then
    export PS1="$STARTCOLOR[\h] \W\$$ENDCOLOR "
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\w [\h]\a\]$PS1"
        ;;
    *)
        ;;
    esac
else
    export PS1="$STARTCOLOR\W\$$ENDCOLOR "
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\w\a\]$PS1"
        ;;
    *)
        ;;
    esac
fi

set -o vi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
