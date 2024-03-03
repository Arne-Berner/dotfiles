#!/bin/bash

set -e

# Utilities and misc
sudo apt install -y fish python3-pip \
curl zathura clangd\
fzf git pkg-config libssl-dev \

# brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser


# newest nvim
# get the image
sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo ./nvim.appimage

# put it into opt
sudo mkdir -p /opt/nvim
sudo mv nvim.appimage /opt/nvim/nvim

# add to bashpath
export PATH="$PATH:/opt/nvim/"

# get tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# use fish as default editor
sudo chsh -s $(which fish)

# Use Kanata instead of kmonad, so that this will be easier

# Rust
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo rustup update
sudo apt install cargo
rustup component add clippy
rustup component add rustfmt
cargo install cargo-audit
cargo install cargo-watch


# Take the stuff from this dotfiles folder (that I care about) and symlink it
ln -s ~/dotfiles/nvim ~/.config/nvim
mkdir -p ~/.config/fish
ln -s ~/dotfiles/fish ~/.config/fish/
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/config.toml ~/.cargo/config.toml
# Copy instead of link to prevent private info from getting into git
# cp ~/dotfiles/rclone.conf ~/.config/rclone/rclone.conf

fish
source .config/fish/config.fish


