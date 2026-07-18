# ls -> eza
if command -v eza &>/dev/null; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -alh --group-directories-first --icons=auto'
  alias la='eza -a --group-directories-first --icons=auto'
fi

# cat -> bat
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
elif command -v batcat &>/dev/null; then
  alias cat='batcat --paging=never'
fi

# git shortcuts
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gco='git checkout'

# misc
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
