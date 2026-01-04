#!/bin/bash

set -e

# Utilities and misc
echo "Utilities"
sudo add-apt-repository universe
sudo apt install -y fish python3-pip \
curl zathura clang xclip \
fzf git pkg-config libssl-dev libfuse2
sudo apt-get install lld

# brave
echo "Brave"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser

# python3
echo "python3"
sudo apt install python3 

# newest nvim
# get the image
echo "nvim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

# put it into opt
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
sudo chmod +x /opt/nvim/nvim

# add to bashpath
export PATH="$PATH:/opt/nvim/"

# use fish as default editor
echo "fish as default"
sudo chsh -s $(which fish)

# Rust
echo "Rust"
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH=$PATH:~/.cargo/env
source ~/.cargo/env
rustup update
sudo apt install cargo
rustup component add clippy
rustup component add rustfmt
cargo install cargo-audit

echo "lua"
sudo apt install luarocks
sudo luarocks install lua-toml

echo "git"
git config --global core.editor "nvim"
git config --global diff.tool nvimdiff
git config --global difftool.prompt false
git config --global merge.tool nvimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global push.autoSetupRemote true

# Take the stuff from this dotfiles folder (that I care about) and symlink it
echo "linking"
mkdir -p ~/.config/zathura || true
ln -s ~/dotfiles/zathurarc ~/.config/zathura/zathurarc || true
sudo rm ~/.config/nvim/nvim || true
ln -s ~/dotfiles/nvim ~/.config/nvim || true
mkdir -p ~/.config || true
sudo rm -rf ~/.config/fish || true
ln -s ~/dotfiles/fish ~/.config/fish || true
sudo rm ~/.cargo/config.toml || true
ln -s ~/dotfiles/config.toml ~/.cargo/config.toml || true
sudo rm ~/.zshrc || true
ln -s ~/dotfiles/.bashrc ~/.zshrc || true
# Copy instead of link to prevent private info from getting into git
# cp ~/dotfiles/rclone.conf ~/.config/rclone/rclone.conf

source ~/.bashrc
source ~/.config/fish/config.fish
chsh -s /usr/bin/fish
fish
