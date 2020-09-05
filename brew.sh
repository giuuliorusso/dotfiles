#!/usr/bin/env bash

# Setup
brew analytics off
brew up
brew upgrade
brew cask upgrade
brew cleanup

# Fonts
brew tap homebrew/cask-fonts
brew cask install \
  font-cascadia \
  font-cascadia-pl \
  font-fira-code \
  font-iosevka \
  font-jetbrains-mono

# Dev
brew install \
  bat \
  cmake \
  fish \
  git \
  gnupg \
  llvm \
  neovim \
  starship \
  tmux

brew cask install \
  alacritty \
  gitkraken \
  visual-studio-code

# Other apps
brew cask install \
  notion \
  protonvpn \
  spotify
