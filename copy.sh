#!/usr/bin/env bash

function copy() {
  # Copy home files
  rsync --exclude ".DS_Store" \
    -avh --no-perms ./home/ ~;

  # Copy vscode files
  case $os in
    Darwin ) p="$HOME/Library/Application Support/Code/User/";;
    * ) p="$HOME/.config/Code/User/";;
  esac

  mkdir -p "$p";

  rsync --exclude ".DS_Store" \
    -avh --no-perms ./vscode/ "$p";

  unset p;
}

cd "$(dirname "$BASH_SOURCE")";
git pull origin master &> /dev/null;

os=$(uname);
echo "OS: $os";

read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " answer;
case $answer in
  Yes | yes | Y | y ) echo -e "Ok :)\n"; copy;;
  * ) echo "Bye :(";;
esac

unset copy;
unset os;
