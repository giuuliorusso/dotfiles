#!/usr/bin/env bash

os=$(uname)
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$script_dir"

function copy() {
  # Copy home files
  rsync --exclude ".DS_Store" \
    -avh --no-perms ../home/ ~

  # Copy vscode files
  local path
  case $os in
    Darwin ) path="$HOME/Library/Application Support/Code/User/";;
    * ) path="$HOME/.config/Code/User/";;
  esac

  mkdir -p "$path"

  rsync --exclude ".DS_Store" \
    -avh --no-perms ../vscode/ "$path"
}

git pull origin master &> /dev/null

echo "OS: $os"

read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " answer
case $answer in
  Yes | yes | Y | y ) echo -e "Ok :)\n"; copy;;
  * ) echo "Bye :(";;
esac
