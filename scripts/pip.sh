#!/usr/bin/env bash

packages=(
  "jupyter"
  "matplotlib"
  "numpy"
  "pandas"
  "scipy"
  # Other
  "autopep8"
  "pylint"
  "python-lsp-server[all]"
  "rope"
)

# Install
for e in ${packages[@]}; do
  pip3 install --user "$e"
  echo -e "\n"
done
