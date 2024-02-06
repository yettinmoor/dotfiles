#!/usr/bin/env sh

cd ~

ln -sf repos/dotfiles/config .config
ln -sf repos/dotfiles/local  .local
ln -sf .config/xorg/xinitrc  .xinitrc
ln -sf .config/profile       .zprofile
