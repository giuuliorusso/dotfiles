#!/usr/bin/env bash

function doIt() {
  rsync --exclude ".DS_Store" \
    -avh --no-perms ./home/ ~;
}

cd "$(dirname "$BASH_SOURCE")";
git pull origin master &> /dev/null;

read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " answer;
case $answer in
  Yes | yes | Y | y ) echo -e "Ok :)\n"; doIt;;
  * ) echo "Bye :(";;
esac

unset doIt;
