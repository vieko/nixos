#! /usr/bin/env bash

set +x

USER=vieko
HOST=pandemonium
HOME=/home/$USER
NIXOS_VERSION=20.09
DOTFILES=$HOME/dotfiles

sudo ln -sfn $DOTFILES /etc/dotfiles
chown -R $USER:users $HOME $DOTFILES

sudo nix-channel --add "https://nixos.org/channels/nixos-${NIXOS_VERSION}" nixos
sudo nix-channel --add "https://nixos.org/channels/nixos-unstable" nixos-unstable
sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/master.tar.gz" home-manager
sudo nix-channel --add "https://nixos.org/channels/nixpkgs-unstable" nixpkgs-unstable
sudo nix-channel --update

sudo nixos-generate-config --force
echo "import /etc/dotfiles" | sudo tee /etc/nixos/configuration.nix

sudo nixos-rebuild switch --show-trace




