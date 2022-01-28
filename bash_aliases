# ls
alias please=sudo
alias pls=sudo

alias l='ls   -v --group-directories-first --color=auto'
alias ls='ls  -v --group-directories-first --color=auto'
alias ll='ls  -v --group-directories-first --color=auto -l'
alias la='ls  -v --group-directories-first --color=auto -a'

alias lla='ls -v --group-directories-first --color=always -la'
alias tree='tree --dirsfirst -v'
alias sort='sort -V'
alias mmeta='mmeta -v'

alias pud='pushd'
alias pd='pushd'
alias pod='popd'
alias xcc='xclip -sel clip'
alias ncal='ncal -b'

alias mysql='sudo mysql'
alias docker='sudo docker'
alias lof='libreoffice'
alias brightness='xrandr --output eDP-1 --brightness'

alias pip='pip3'

# system
# alias sus="systemctl suspend"
alias lo="libreoffice"
alias sysmon="gnome-system-monitor &"

# applications
alias nem="nemo . 2>/dev/null &"
alias py="python3"
alias disk="yandex-disk"
alias d="dishead < main.cpp > dmain.cpp"
alias ds="dishead -s < main.cpp > dmain.cpp"
alias lndepends='ln `cat target/*.d | tr " \t" "\n\n" | grep nvx | sort -u` ./src/lib/nvx'
alias jc="jupyter-console"
alias jn="jupyter-notebook ~/.local/daw/py/jupyter"
alias ci="cargo init --vcs=none --name 'work'"
alias cn="cargo init --vcs=none --name"

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# git
alias gs="git status -s"
alias gp="git push"
alias ga="git add"
alias gc="git commit"
alias gl="git log -3"
alias gln="git log"
alias gpl="git pull"


# web
alias github="firefox https://github.com/clever411?tab=repositories"
alias habr="firefox https://habr.com/"
alias vk="firefox https://vk.com/feed"
alias graph="firefox https://www.desmos.com/calculator"

# vim
alias vim='nvim'
alias v='nvim'
alias vc="nvim main.cpp"
alias vp="nvim main.py"
alias vj="nvim main.java"
alias vr="nvim main.rs"
alias vh="nvim index.html"
alias vm="nvim makefile"
alias inp="initproj"

# other
alias ssh_fit='ssh std@std-1416.ist.mospolytech.ru -p 22'
alias sprinthost='ssh a0566996@a0566996.xsph.ru'
