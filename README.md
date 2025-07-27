# dotfiles

## Table of Contents
* [Prerequisites](#prerequisites)
* [Installation](#installation)
  - [Neovim](#neovim)
  - [Tmux](#tmux)

## Prerequisites
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [NodeJS](https://github.com/nodesource/distributions#installation-instructions)
- [snapd](https://snapcraft.io/docs/installing-snap-on-ubuntu) (_Optional_) - Can be used to install NeoVim via `snap install nvim --stable --classic`
- [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation) - Modern cat

## Installation

### Aliases
- for bash - `ln -s <this-repo-path>/.bash_aliases ~/`
- for zsh - `ln -s <this-repo-path>/.bash_aliases $ZSH_CUSTOM/aliases.zsh`

### Ruff config
`ln -s <this-repo-path>/.config/ruff ~/.config/`

### Neovim
- Install version >= 0.9.0
- Setup config - `ln -s <this-repo-path>/.config/nvim ~/.config/`

### Tmux
- Install version >= 3.2
- Setup config - `ln -s <this-repo-path>/.config/tmux ~/.config/`
