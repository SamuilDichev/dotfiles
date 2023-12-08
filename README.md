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
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) - e.g. `sudo apt install ripgrep`
- NodeJS - e.g. `curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs`
- snapd (_Optional_) - e.g. `sudo apt install snapd`. Can be used to install NeoVim via `snap install nvim --stable --classic`

## NeoVim
- Install version >= 0.9.0
- Setup config - `ln -s <this-repo-path>/.config/nvim ~/.config/`

## Tmux
Config based on https://github.com/gpakosz/.tmux which is included as a submodule
- Install Tmux
- Setup config - `ln -s <this-repo-path>/.config/tmux ~/.config/`
