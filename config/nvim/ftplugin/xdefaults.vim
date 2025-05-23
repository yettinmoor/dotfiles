au BufWritePost <buffer> !touch $XDG_CONFIG_HOME/xorg/Xresources.private
au BufWritePost <buffer> !xrdb -I{$XDG_CONFIG_HOME}/xorg $XDG_CONFIG_HOME/xorg/Xresources
