# Git config
git config --global user.name "mo" 2>/dev/null || true
git config --global user.email "mo@users.noreply.github.com" 2>/dev/null || true
git config --global init.defaultBranch main
git config --global core.autocrlf input
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global diff.colorMoved zebra

# Aliases
git config --global alias.st 'status -sb'
git config --global alias.co 'checkout'
git config --global alias.br 'branch'
git config --global alias.cm 'commit -m'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD --stat'
git config --global alias.visual '!gitk'
