### Custom .bashrc ###
export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTIGNORE="ls:history"

export EDITOR='nvim'
export VISUAL='nvim'

### Aliases ####
# dev
alias vim="nvim"
alias gcd='cd `git rev-parse --show-toplevel`'
alias greload='cd `git rev-parse --show-toplevel` && git checkout master && git pull'
alias greloadf="git stash && git stash drop && greload"
alias glog="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias devutil=". ~/repos/devutil/venv/bin/activate"
alias dva="deactivate"
alias prune="git branch --merged >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches"

alias gate="ssh -A samuild@ssh-hex.mustardsystems.com -p 2221 -D 8080 -L10002:maltose:22 -L10008:maltose:80"
alias office="ssh -qAp 10002 samuild@localhost -D 8081"

# tmux
alias tls="tmux list-sessions"
alias ta="tmux attach"
alias ta0="tmux attach -t 0"
alias ta1="tmux attach -t 1"
alias ta2="tmux attach -t 2"
alias ta3="tmux attach -t 3"
alias ta4="tmux attach -t 4"
alias ta5="tmux attach -t 5"

# ops
alias fuck='if ! declare -f fuck &>/dev/null; then eval -- "$(thefuck -a)"; fi && fuck'
alias ch="cat ~/.bash_aliases | grep -P '#|alias|function'"
alias fhere="find . -name "
alias df="df -Th --total"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias du="ncdu"
alias h="history"
alias iptlist="sudo iptables -L --line-numbers"
alias fw="iptlist"
alias ..="cdl .."
alias reload=". ~/.bashrc"

function cl {
    cd "$@";
    ll;
}

function va {
    if [ -d "venv" ]; then
        . venv/bin/activate && echo "venv";
    elif [ -d "env" ]; then
        . env/bin/activate && echo "env";
    else
        devutil && echo "devutil";
    fi
}

function extract {
    if [ -z "$1" ]; then
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    else
        for n in $@; do
            if [ -f "$n" ] ; then
                case "${n%,}" in
                    *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                                 tar xvf "$n"       ;;
                    *.lzma)      unlzma ./"$n"      ;;
                    *.bz2)       bunzip2 ./"$n"     ;;
                    *.rar)       unrar x -ad ./"$n" ;;
                    *.gz)        gunzip ./"$n"      ;;
                    *.zip)       unzip ./"$n"       ;;
                    *.z)         uncompress ./"$n"  ;;
                    *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                                 7z x ./"$n"        ;;
                    *.xz)        unxz ./"$n"        ;;
                    *.exe)       cabextract ./"$n"  ;;
                    *)
                                 echo "extract: '$n' - unknown archive method"
                                 return 1
                                 ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}
