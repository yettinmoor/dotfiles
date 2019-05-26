stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

export PS1="\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 11)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 15)\]\\$ \[$(tput sgr0)\]"
#export PS1="\[$(tput bold)$(tput setaf 4)\]\w \[$(tput setaf 15)\]\\$ \[$(tput sgr0)\]"

{ . "$HOME/.config/shortcutrc"; . "$HOME/.config/aliasrc"; } 2>/dev/null
