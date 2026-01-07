# dev
alias vim="nvim"
alias gcd='cd `git rev-parse --show-toplevel`'
alias greload='cd `git rev-parse --show-toplevel` && git checkout master && git pull'
alias greloadf="git stash && git stash drop && greload"
alias hawk="git stash"
alias tuah="git stash drop"
alias glog="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias devutil=". ~/repos/devutil/venv/bin/activate"
alias dva="deactivate"
alias prune="git branch --merged >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches"
alias open="explorer.exe"

# tmux
alias tls="tmux list-sessions"

# ops
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias ll="ls -halF"
alias bat="batcat -pp"

alias ch="cat ~/.bash_aliases | grep -P '#|alias|function'"
alias fhere="find . -name "
alias df="df -Th --total"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias du="ncdu"
alias h="history"
alias iptlist="sudo iptables -L --line-numbers"
alias fw="iptlist"
alias ..="cl .."
alias reload=". ~/.bashrc"

function cl {
    cd "$@";
    ll;
}

function ta {
    if tmux ls &>/dev/null; then
        tmux attach
    else
        ~/repos/dotfiles/tmux-setup.sh && tmux attach
    fi
}

function va {
    for dir in venv env .venv .env; do
        if [ -d "$dir" ]; then
            . "$dir/bin/activate" && echo "$dir"
            return
        fi
    done
    . $(poetry env info --path)/bin/activate
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
