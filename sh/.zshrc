# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="arrow"

# Если снова сломается определение типов
XDG_DATA_DIRS="/usr/share/i3:/home/nvx/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share:/var/lib/snapd/desktop"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# common for bash and zsh
. ~/.shrc

# Чтобы работал enter (необходимо для Guake и Gnome Terminal)
# 0 . Enter
# bindkey -s "^[Op" "0"
# bindkey -s "^[Ol" "."
# bindkey -s "^[OM" "^M"
# # 1 2 3
# bindkey -s "^[Oq" "1"
# bindkey -s "^[Or" "2"
# bindkey -s "^[Os" "3"
# # 4 5 6
# bindkey -s "^[Ot" "4"
# bindkey -s "^[Ou" "5"
# bindkey -s "^[Ov" "6"
# # 7 8 9
# bindkey -s "^[Ow" "7"
# bindkey -s "^[Ox" "8"
# bindkey -s "^[Oy" "9"
# # + -  * /
# bindkey -s "^[Ok" "+"
# bindkey -s "^[Om" "-"
# bindkey -s "^[Oj" "*"
# bindkey -s "^[Oo" "/"

source ~/.bash_aliases

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export TERM="screen-256color"
export PATH=.:$PATH
export PATH_TO_FX=/usr/share/openjfx/lib
export PATH_TO_FX_MODS=/usr/share/openjfx/jmods
export RUSTFLAGS="$RUSTFLAGS -A dead_code"

export work=~/work
export memo=~/.local/daw/memo
export daw=~/.local/daw
export lib=~/.local/daw/cpp/lib
export olp=~/.local/daw/cpp/olp
export bin=~/.bin
export vimrc=~/.config/nvim/init.vim
export vim=~/.config/nvim
export inp=~/.local/initproj

export fit='std@std-1416.ist.mospolytech.ru'
export sph='a0566996@a0566996.xsph.ru'
export sc21="$HOME/.local/daw/sc21/42"
export sirius=~/work/sirius/yandex_intensive
export coinmind=~/.local/android/coinmind

# clang
export CPATH='/usr/include:/usr/local/include:/usr/include/c++/9:/usr/include/c++/9/backward:/usr/include/x86_64-linux-gnu/c++/9'
export LIBRARY_PATH=/usr/local/lib:/usr/lib/x86_64-linux-gnu
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/x86_64-linux-gnu



# daw completion
_daw_completion() {
	COMPREPLY=()

	args=''
	if [ "$COMP_CWORD" -eq 1 ]
	then
		args="list push load mount turn move remove current"
	elif [ "$COMP_CWORD" -eq 2 ]
	then
		dir=`expr "${COMP_WORDS[COMP_CWORD]}" : '\(.*\)\/.*$'`
		if [ -n "$dir" ]
		then
			targs=`find "$HOME/.local/daw/$dir" -maxdepth 1 -mindepth 1 -type d`
			for arg in $targs
			do
				dir=`expr $arg : "$HOME\/\.local\/daw\/\(.*\)$"`
				args+="$dir/ "
			done
		else
			targs=`find "$HOME/.local/daw/" -maxdepth 1 -mindepth 1 -type d`
			for arg in $targs
			do
				dir=`expr $arg : '^.*\/\.local\/daw\/\(.*\)$'`
				args+="$dir/ "
			done
		fi
		# echo $args
	fi

	COMPREPLY=( $(compgen -W "${args}" -- ${COMP_WORDS[COMP_CWORD]}) )
	return 0
}

# complete -o bashdefault -o default -F _fzf_path_completion *
complete -F _daw_completion daw



# END
