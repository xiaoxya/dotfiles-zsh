#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# --- helpers ---
backup() {
  local target="$1"
  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -a "$target" "$BACKUP_DIR/"
    echo "  backed up: $target -> $BACKUP_DIR/"
    rm -rf "$target"
  fi
}

link() {
  local src="$1" dst="$2"
  backup "$dst"
  ln -sf "$src" "$dst"
  echo "  linked: $dst -> $src"
}

need_cmd() { command -v "$1" &>/dev/null; }

# --- detect package manager ---
detect_pkg_mgr() {
  if need_cmd apt; then
    echo "apt"
  elif need_cmd dnf; then
    echo "dnf"
  elif need_cmd yum; then
    echo "yum"
  elif need_cmd pacman; then
    echo "pacman"
  elif need_cmd apk; then
    echo "apk"
  elif need_cmd zypper; then
    echo "zypper"
  else
    echo "unknown"
  fi
}

pkg_install() {
  local pkgs=("$@")
  local mgr
  mgr=$(detect_pkg_mgr)
  case "$mgr" in
    apt)    sudo apt-get update -qq && sudo apt-get install -y -qq "${pkgs[@]}" ;;
    dnf)    sudo dnf install -y -q "${pkgs[@]}" ;;
    yum)    sudo yum install -y -q "${pkgs[@]}" ;;
    pacman) sudo pacman -S --noconfirm --needed "${pkgs[@]}" ;;
    apk)    sudo apk add --no-cache "${pkgs[@]}" ;;
    zypper) sudo zypper install -ny "${pkgs[@]}" ;;
    *)      echo "  unsupported distro, install manually: ${pkgs[*]}"; return 1 ;;
  esac
}

install_if_missing() {
  local cmd="$1"; shift
  local pkgs=("$@")
  if need_cmd "$cmd"; then
    echo "  $cmd: already installed"
  else
    echo "  installing $cmd..."
    pkg_install "${pkgs[@]}"
  fi
}

# --- start ---
echo "=== Zsh Dotfiles Installer ==="
echo ""

# 1. Symlink files
echo "[1/4] Linking config files..."
mkdir -p "$HOME/.zsh.d"
link "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"
for f in "$DOTFILES_DIR"/zsh.d/*.zsh; do
  link "$f" "$HOME/.zsh.d/$(basename "$f")"
done
echo ""

# 2. Install system dependencies
echo "[2/4] Installing dependencies..."
echo "  detected: $(detect_pkg_mgr)"

# 先安装 zsh（必须在 Oh My Zsh 之前）
install_if_missing zsh zsh

# 核心工具 — 包名映射 (arch / others)
if need_cmd pacman; then
  install_if_missing vim    vim
  install_if_missing eza    eza
  install_if_missing bat    bat
  install_if_missing fzf    fzf
  install_if_missing zoxide zoxide
else
  install_if_missing vim    vim
  install_if_missing eza    eza
  install_if_missing bat    bat 2>/dev/null || install_if_missing bat batcat
  install_if_missing fzf    fzf
  install_if_missing zoxide zoxide
fi

# fnm (curl 通用安装)
if ! need_cmd fnm; then
  echo "  installing fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
fi

# autojump
if ! need_cmd autojump; then
  echo "  installing autojump..."
  pkg_install autojump 2>/dev/null || true
fi

echo ""

# 3. Install Oh My Zsh + plugins
echo "[3/4] Installing Oh My Zsh & plugins..."

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "  installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
  echo "  installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  if [[ ! -d "$PLUGINS_DIR/$plugin" ]]; then
    echo "  installing $plugin..."
    git clone --depth=1 "https://github.com/zsh-users/$plugin" "$PLUGINS_DIR/$plugin"
  fi
done

# 4. Switch default shell to zsh
echo ""
echo "[4/4] Switching default shell to zsh..."
ZSH_PATH="$(command -v zsh)"
if [[ "$SHELL" == "$ZSH_PATH" ]]; then
  echo "  already using zsh"
else
  # 确保 zsh 在 /etc/shells 中
  if ! grep -qx "$ZSH_PATH" /etc/shells 2>/dev/null; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  fi
  if command -v chsh &>/dev/null; then
    sudo chsh -s "$ZSH_PATH" "$USER" && echo "  default shell changed to $ZSH_PATH"
  else
    echo "  chsh not found, please run manually: chsh -s $ZSH_PATH"
  fi
fi

echo ""
echo "=== Done! Restart your terminal or run: exec zsh ==="
