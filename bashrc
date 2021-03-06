# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
mkdir -p ~/.local/share
HISTFILE=~/.local/share/bash_history
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

STARTCOLOR="\[\e[32m\]";
ENDCOLOR="\[\e[m\]";
if [ -n "$SSH_CLIENT" -a -z "$TMUX" ]; then
    PS1="$STARTCOLOR[\h] \W \$$ENDCOLOR "
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\w [\h]\a\]$PS1"
        ;;
    *)
        ;;
    esac
else
    PS1="$STARTCOLOR\W \$$ENDCOLOR "
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\w\a\]$PS1"
        ;;
    *)
        ;;
    esac
fi

set -o vi
export EDITOR=vi
export GPG_TTY=$(tty)

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
