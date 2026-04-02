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

# Rust/Cargo

fish_add_path "/Users/mattb/.cargo/bin"
fish_add_path (brew --prefix rustup)/bin

# Aliases

alias vim "nvim"
alias tar "gtar"

abbr -a glog "git log --oneline --decorate --graph --all"
abbr -a gcb "git checkout -b \$(git log -1 --pretty=%s | awk -F': ' '{ print \"mjwbenton/\" \$1 \"/\" \$2 }' | tr ' ' '-')"

# Environment variables

set VISUAL "nvim"
set EDITOR $VISUAL


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
