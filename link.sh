#!/usr/bin/env sh

cd ~ || exit 1

ln -sf repos/dotfiles/config .config
ln -sf .config/xorg/xinitrc .xinitrc
ln -sf .config/shell/profile .zprofile

mkdir -p .local/share
ln -sf ~/.config/applications .local/share
