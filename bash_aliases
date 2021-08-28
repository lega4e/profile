# ls
alias please=sudo
alias pls=sudo

alias l="ls   -v --group-directories-first --color=always"
alias ls="ls  -v --group-directories-first --color=always"
alias sl="ls  -v --group-directories-first --color=always"
alias ll="ls  -v --group-directories-first --color=always -l"
alias la="ls  -v --group-directories-first --color=always -a"

alias lla="ls -v --group-directories-first --color=always -la"
alias tree='tree --dirsfirst'

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
alias gs="git status"
alias gp="git push"
alias ga="git add"
alias gpl="git pull"


# web
alias github="firefox https://github.com/clever411?tab=repositories"
alias habr="firefox https://habr.com/"
alias vk="firefox https://vk.com/feed"
alias graph="firefox https://www.desmos.com/calculator"

# ru
alias св="cd";
alias ьм="mv";

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
