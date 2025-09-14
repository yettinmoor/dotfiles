#!/usr/bin/env sh

cd ~

ln -sf repos/dotfiles/config              .config
ln -sf repos/dotfiles/config/applications ~/.local/share
ln -sf .config/xorg/xinitrc               .xinitrc
ln -sf .config/profile                    .zprofile
