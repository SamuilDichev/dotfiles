# dotfiles
## General
Clone this repo with
```
git clone --recurse-submodules <this-repo-url>
```

Update it with
```
git pull --recurse-submodules
```

If the repo was already cloned without submodules, you might need to init the modules before you can pull them
```
git submodule update --init --recursive
```

## Prerequisites
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [NodeJS](https://github.com/nodesource/distributions#installation-instructions)
- [snapd](https://snapcraft.io/docs/installing-snap-on-ubuntu) (_Optional_) - Can be used to install NeoVim via `snap install nvim --stable --classic`

## NeoVim
- Install version >= 0.9.0
- Setup config - `ln -s <this-repo-path>/.config/nvim ~/.config/`

## Tmux
Config based on https://github.com/gpakosz/.tmux which is included as a submodule
- Install Tmux
- Setup config - `ln -s <this-repo-path>/.config/tmux ~/.config/`
