# dotfiles

## Table of Contents
* [General](#general)
  - [Setup and development](#setup-and-development)
  - [Contents to ignore](#contents-to-ignore)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
  - [Neovim](#neovim)
  - [Tmux](#tmux)

## General

### Setup and development
This repo has embedded submodules, i.e. repositories maintained by others that I'm merely re-using.
This means cloning and updating is slightly different than normal

- Clone this repo with -`git clone --recurse-submodules <this-repo-url>`
- Update it with - `git pull --recurse-submodules`
- Init submodules (_optional_, needed if repo was cloned without them) - `git submodule update --init --recursive`

### Contents to ignore
These files are related to configuration or documentation of the repo and are not files you should need to concern yourself with
- submodules/
- .gitignore
- .gitmodules
- README.md

The remaining files/folders should be the actual dot files, i.e. files actually used in the configuration of various apps

## Prerequisites
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [NodeJS](https://github.com/nodesource/distributions#installation-instructions)
- [snapd](https://snapcraft.io/docs/installing-snap-on-ubuntu) (_Optional_) - Can be used to install NeoVim via `snap install nvim --stable --classic`
- [bat](https://github.com/sharkdp/bat?tab=readme-ov-file#installation) - Modern cat
- [thefuck](https://github.com/nvbn/thefuck?tab=readme-ov-file#installation) (_Optional_) - auto-correct for commands
- [zoxide](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation) - better cd

## Installation

### Aliases
`ln -s <this-repo-path>/.bash_aliases ~/`

### Neovim
- Install version >= 0.9.0
- Setup config - `ln -s <this-repo-path>/.config/nvim ~/.config/`

### Tmux
Config based on https://github.com/gpakosz/.tmux which is included as a submodule
- Install Tmux
- Setup config - `ln -s <this-repo-path>/.config/tmux ~/.config/`
