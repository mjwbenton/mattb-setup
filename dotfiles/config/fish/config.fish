# Fish configuration

set fish_greeting
fish_vi_key_bindings
set -g pure_enable_single_line_prompt true
set -g async_prompt_functions _pure_prompt_git

# Homebrew

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk/bin

# uv

fish_add_path "/Users/mattb/.local/bin"

# Aliases

alias vim "nvim"
alias glog "git log --oneline --decorate --graph --all"
alias tar "gtar"

abbr -a gcb "git checkout -b \$(git log -1 --pretty=%s | awk -F': ' '{ print \"mjwbenton/\" \$1 \"/\" \$2 }' | tr ' ' '-')"

# Environment variables

set VISUAL "nvim"
set EDITOR $VISUAL

