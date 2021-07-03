#!/bin/bash



cp ./init.vim        ~/.config/nvim/
cp ./bashrc          ~/.bashrc
cp ./bashrc_custom   ~/.bashrc_custom
cp ./bash_aliases    ~/.bash_aliases
cp ./profile         ~/.profile
cp ./zshrc           ~/.zshrc
cp ./zshrc_custom    ~/.zshrc_custom
cp ./i3config        ~/.config/i3/config
cp ./i3status_config ~/.config/i3status/config

sudo cp ru                 /usr/share/X11/xkb/symbols
sudo cp russian-dictor.vim /usr/share/vim/vim81/keymap



# END
