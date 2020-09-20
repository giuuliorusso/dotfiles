#!/usr/bin/env bash

# Setup
brew analytics off
brew up
brew upgrade
brew cleanup

# Install
brew bundle install --no-lock

# Cleanup
brew cleanup
