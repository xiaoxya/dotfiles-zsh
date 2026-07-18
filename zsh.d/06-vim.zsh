# Vim
export EDITOR='vim'
export VISUAL='vim'

# Vi mode in zsh
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line
