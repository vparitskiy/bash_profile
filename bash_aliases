#!/usr/bin/env bash

PATH="$HOME/bin:$PATH"

# ccache
if [ -d /usr/lib/ccache ] ; then
   PATH="/usr/lib/ccache:${PATH}"
fi

# Python
export PYTHONSTARTUP="${HOME}/.pyrc"
export PYTHONIOENCODING="UTF-8"
export WORKON_HOME=${HOME}/.virtualenvs/
alias pyclean='find . -name "*.pyc" -exec rm {} \;'
alias server='python -m SimpleHTTPServer'

# History
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
type hh >/dev/null 2>&1 && bind '"\C-r": "\C-a hh \C-j"'  # bind hh to Ctrl-r

# Navigation
alias ..="cd .."
alias ...="cd ../.."

# Colors
alias ls="ls -lah --color=auto"
alias grep='grep --color=auto'
alias diff='diff --color=auto'
export LESS_TERMCAP_mb=$'\e'"[1;31m"
export LESS_TERMCAP_md=$'\e'"[1;31m"
export LESS_TERMCAP_me=$'\e'"[0m"
export LESS_TERMCAP_se=$'\e'"[0m"
export LESS_TERMCAP_so=$'\e'"[1;44;33m"
export LESS_TERMCAP_ue=$'\e'"[0m"
export LESS_TERMCAP_us=$'\e'"[1;32m"

# Django
alias runserver='python manage.py runserver 127.0.0.1:8000'
alias djshell='python manage.py shell'

# Node version manager
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Dmesg for humans
alias dmesh="sudo dmesg -wH"

# Free for humans
alias freeh="free -w -h -t"

# tty colors
if [ "${TERM}" = "linux" ]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi

# Enable virtualenv when entering dir
source "${HOME}/.auto_virtualenv.sh"
# Enable Django bash completion
source "${HOME}/.django_bash_completion.sh"

# Export modified PATH
export PATH

echo "Fired up, ready to go."
