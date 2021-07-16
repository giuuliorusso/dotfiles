#!/usr/bin/env bash

extensions=(
  "james-yu.latex-workshop" # LaTeX
  "llvm-vs-code-extensions.vscode-clangd" # C++
  "ms-python.python" # Python
  "redhat.vscode-xml" # XML
  "redhat.vscode-yaml" # YAML
  "rust-lang.rust" # Rust
  "tamasfe.even-better-toml" # TOML
  # Other
  "eamodio.gitlens"
  "editorconfig.editorconfig"
  "ms-vscode.live-server"
  "streetsidesoftware.code-spell-checker-italian"
  "streetsidesoftware.code-spell-checker"
  "visualstudioexptteam.vscodeintellicode"
  "vscode-icons-team.vscode-icons"
)

# Install
for e in ${extensions[@]}; do
  code --install-extension "$e"
  echo -e "\n"
done
