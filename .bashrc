# If not running interactively, don't do anything
# [[ $- != *i* ]] && return  # as found in Arch
# As found in Ubuntu
case $- in
    *i*) ;;
      *) return;;
esac


color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='[\u@\h \W]\$ '
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export PROMPT_COMMAND='history -a'
export HISTIGNORE="ls:ll:history"
export HISTCONTROL=ignoreboth

export EDITOR='nvim'
export VISUAL='nvim'

shopt -s histappend  # append to the history file, don't overwrite it
shopt -s checkwinsize  # check window size after each command and, if needed, update the values of LINES and COLUMNS.
