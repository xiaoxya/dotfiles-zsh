# Powerlevel10k instant prompt — keep near top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
  plugins=(git sudo docker docker-compose extract colored-man-pages command-not-found z zsh-autosuggestions zsh-syntax-highlighting fzf)
  source $ZSH/oh-my-zsh.sh
else
  echo "Oh My Zsh not installed. Run: bash install.sh"
fi

# Load modular config
for f in ~/.zsh.d/*.zsh; do [[ -f "$f" ]] && source "$f"; done

# Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
