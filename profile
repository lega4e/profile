# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add to PATH ~/.bin directory
if [ -d "$HOME/.bin" ] ; then
	PATH="$HOME/.bin:$PATH"
fi

export SHELL="/bin/zsh"



# my
# 96 — код клавиши ENTER
# 1  — код клавиши Escape
sudo setkeycodes 0x3a 96 0xb8 1
xset r rate 200 50


# touchpad
synclient MinSpeed=1.1
synclient MaxSpeed=1.1
synclient CoastingSpeed=0
synclient VertScrollDelta=-76
synclient HorizScrollDelta=-76
synclient CircularPad=1
synclient PalmDetect=1
synclient PalmMinWidth=5
synclient PalmMinZ=50

feh --bg-scale '/home/lis/imgs/Рабочий стол/Революция, тёмное.jpg'
light `light`

mkdir -p ~/d
sudo mount /dev/sda6 ~/d


. "$HOME/.cargo/env"



# END
