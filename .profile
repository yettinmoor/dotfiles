#!/bin/sh
# Profile file. Runs on login.

export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="surf"
export READER="zathura"
export FILE="vifmrun"

export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export INPUTRC="$HOME/.config/inputrc"
export PYTHONSTARTUP="$HOME/.config/pythonrc"
export LESSHIST="-"

export LOCATION="Ljungsbro"
export HOMEPAGE="$HOME/repos/homepage/home.html"
export GIT="https://github.com/yettinmoor"

# colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

eval `dircolors -b ~/.config/dircolors`
export TREE_COLORS=$LS_COLORS

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

echo "$0" | grep -q "bash$" && [ -f ~/.bashrc ] && . "$HOME/.bashrc"

# Switch escape and caps if tty:
sudo -n loadkeys ~/.local/share/ttymaps.kmap 2>/dev/null
