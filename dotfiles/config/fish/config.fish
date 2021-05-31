# Basic setup

fish_vi_key_bindings
set -g pure_enable_single_line_prompt true
set -g async_prompt_functions _pure_prompt_git

# Aliases

alias vim "nvim"
alias glog "git log --oneline --decorate --graph --all"

