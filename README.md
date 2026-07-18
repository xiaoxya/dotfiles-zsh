# dotfiles-zsh

模块化 zsh 配置，支持一键部署。基于 Oh My Zsh + Powerlevel10k。

## 项目结构

```
dotfiles-zsh/
├── zshrc              # 主入口
├── p10k.zsh           # Powerlevel10k 主题配置
├── install.sh         # 一键安装脚本
└── zsh.d/             # 模块化配置
    ├── 00-env.zsh     # 环境变量、PATH、历史记录
    ├── 01-aliases.zsh  # 别名 (eza, bat, git)
    ├── 02-functions.zsh # 自定义函数
    ├── 03-tools.zsh   # fzf, zoxide, autojump
    ├── 04-node-fnm.zsh # fnm Node 版本管理
    ├── 05-git.zsh     # git 全局配置和别名
    ├── 06-vim.zsh     # vim 配置 + vi 模式
    ├── 07-proxy.zsh   # 代理配置
    └── 08-local.zsh   # 机器特定配置 (gitignore)
```

## 快速安装

```bash
git clone https://github.com/xiaoxya/dotfiles-zsh.git
cd dotfiles-zsh
bash install.sh
```

安装脚本会自动：
1. 备份现有 `~/.zshrc` 和 `~/.p10k.zsh`
2. 创建 symlink 到 home 目录
3. 安装系统依赖 (vim, eza, bat, fzf, zoxide, fnm)
4. 安装 Oh My Zsh + Powerlevel10k + 插件

## 支持的发行版

| 发行版 | 包管理器 |
|--------|----------|
| Debian/Ubuntu | apt |
| Fedora | dnf |
| CentOS/RHEL | yum |
| Arch/Manjaro | pacman |
| Alpine | apk |
| openSUSE | zypper |

## 模块说明

| 模块 | 功能 |
|------|------|
| `00-env.zsh` | 语言、PATH、历史记录优化 |
| `01-aliases.zsh` | eza 替代 ls、bat 替代 cat、git 快捷命令 |
| `03-tools.zsh` | fzf 模糊搜索、zoxide 智能跳转、autojump |
| `04-node-fnm.zsh` | fnm 管理 Node.js 版本 |
| `05-git.zsh` | git 全局配置和常用 alias |
| `06-vim.zsh` | vim 默认编辑器 + zsh vi 模式 |
| `07-proxy.zsh` | 代理配置（默认关闭） |
| `08-local.zsh` | 机器特定配置（不纳入 git） |

## 添加新模块

创建 `zsh.d/09-xxx.zsh`，重启终端自动加载。

## 更新

```bash
cd dotfiles-zsh
git pull
source ~/.zshrc
```

## License

MIT
