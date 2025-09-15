#!/usr/bin/env sh

cd ~

ln -sf repos/dotfiles/config      .config
ln -sf .config/xorg/xinitrc       .xinitrc
ln -sf .config/profile            .zprofile

mkdir -p .local/share
ln -sf ~/.config/applications .local/share
