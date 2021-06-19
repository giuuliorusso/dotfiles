#!/usr/bin/env bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$script_dir"

# Setup
brew analytics off
brew up
brew upgrade
brew cleanup

# Install
brew bundle install --no-lock

# Cleanup
brew cleanup
