# fzf
if command -v fzf &>/dev/null; then
  [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
  [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
fi

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# autojump
if [[ -f /usr/share/autojump/autojump.zsh ]]; then
  source /usr/share/autojump/autojump.zsh
elif [[ -f /usr/share/autojump/autojump.sh ]]; then
  source /usr/share/autojump/autojump.sh
fi
