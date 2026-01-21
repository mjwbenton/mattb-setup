# Fish configuration

set fish_greeting
fish_vi_key_bindings
set -g pure_enable_single_line_prompt true
set -g async_prompt_functions _pure_prompt_git

# Homebrew

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/openjdk/bin

# Aliases

alias vim "nvim"
alias glog "git log --oneline --decorate --graph --all"
alias tar "gtar"
alias llama-chat "llama-cli -m ~/models/gemma-3-4b-it-Q4_K_M.gguf -c 4096 -ngl 99 -cnv"
alias llama-code "llama-server -m ~/models/qwen2.5-coder-3b-q8_0.gguf --port 8012 -ngl 99 -ub 1024 -b 1024 --ctx-size 0 --cache-reuse 256"

abbr -a gcb "git checkout -b \$(git log -1 --pretty=%s | awk -F': ' '{ print \"mjwbenton/\" \$1 \"/\" \$2 }' | tr ' ' '-')"

# Environment variables

set VISUAL "nvim"
set EDITOR $VISUAL
