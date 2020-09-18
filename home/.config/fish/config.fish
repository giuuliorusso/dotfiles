# ____
# Main
set fish_greeting

# Text editor
set -U EDITOR (which nvim)
set -U VISUAL $EDITOR

if not set -q fish_user_paths
  # Rust
  set -U fish_user_paths ~/.cargo/bin $fish_user_paths

  # Haskell
  set -U fish_user_paths ~/.ghcup/bin $fish_user_paths
  set -U fish_user_paths ~/.cabal/bin $fish_user_paths

  # Flutter
  set -U fish_user_paths ~/.flutter/bin $fish_user_paths
end

# GPG
export GPG_TTY=(tty)

# _______
# Aliases
alias vi 'nvim'
alias vim 'nvim'

alias :q 'exit'
alias :Q 'exit'

alias sl 'ls'
alias lss 'ls -lahF'

alias cat 'bat'

# macOS
alias copy 'pbcopy'
alias paste 'pbpaste'
alias rmdsstore 'find . -name ".DS_Store" -type f -print -delete'
alias upbrew 'brew up && brew upgrade'


# ______
# Prompt
starship init fish | source
