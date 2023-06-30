#!/bin/sh

DOOM="$HOME/.emacs.d"

if [ ! -d "$DOOM" ]; then
  git clone --depth 1 https://github.com/doomemacs/doomemacs $DOOM
  alacritty -e $DOOM/bin/doom -y install & disown
else
  alacritty -e $DOOM/bin/doom sync
fi
