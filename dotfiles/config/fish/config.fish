# Fish configuration

fish_vi_key_bindings
set -g pure_enable_single_line_prompt true
set -g async_prompt_functions _pure_prompt_git

# Homebrew

fish_add_path /opt/homebrew/bin

# Aliases

alias vim "nvim"
alias glog "git log --oneline --decorate --graph --all"
alias tar "gtar"

# Environment variables

set VISUAL "nvim"
set EDITOR $VISUAL
