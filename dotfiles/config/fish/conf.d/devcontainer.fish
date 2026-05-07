# Devcontainer helpers:
# 1. Wraps `devcontainer` to auto-inject dotfiles, Claude Code feature
# 2. Wraps `code` to auto-connect to running devcontainers
# 3. Wraps important commands in a confirmation if you try and run it directly on host
# 4. Warns before running non-allowlisted commands in devcontainer folders

abbr -a c devcontainer
abbr -a ce devcontainer exec
abbr -a cclaude devcontainer exec claude --dangerously-skip-permissions

# Allowlist of commands that are safe to run on the host in a devcontainer folder
set -g __devcontainer_allowlist \
    git ls cd cat less head tail grep rg fd find echo pwd \
    code vim nvim docker devcontainer tmux fish source \
    set export true false test which type man help history \
    bg fg jobs kill printf string math read mkdir cp mv rm ln \
    touch chmod chown date wc sort uniq tr cut diff comm tee \
    xargs seq basename dirname realpath popd pushd prevd nextd \
    dirh open pbcopy pbpaste ssh scp rsync curl wget

# Custom aliases and abbreviations
set -ga __devcontainer_allowlist \
    c glog gcb

function __devcontainer_check
    test -d "$PWD/.devcontainer"; or test -f "$PWD/.devcontainer.json"
end

function __devcontainer_preexec --on-event fish_preexec
    __devcontainer_check; or return

    # Extract the first word (command name) from the command line
    set -l cmd (string split -m1 ' ' -- $argv[1])[1]
    # Strip any leading path
    set -l cmd (basename -- "$cmd" 2>/dev/null; or echo "$cmd")

    if not contains -- "$cmd" $__devcontainer_allowlist
        set_color yellow
        echo "⚠ Running on host — this folder has a devcontainer"
        set_color normal
    end
end

# Commands that require confirmation before running on host in devcontainer folders
set -g __devcontainer_confirm_commands \
    npm npx yarn pnpm node bun \
    python python3 pip pip3 uv \
    make cargo go

function __devcontainer_run_with_confirm
    set -l cmd $argv[1]
    if not __devcontainer_check; or not status is-interactive
        command $cmd $argv[2..]
        return $status
    end
    read -l -P (set_color yellow)"⚠ $cmd: this folder has a devcontainer — run on host anyway? (y/N) "(set_color normal) response
    if test "$response" = y; or test "$response" = Y
        command $cmd $argv[2..]
    else
        return 1
    end
end

for cmd in $__devcontainer_confirm_commands
    echo "function $cmd --wraps $cmd; __devcontainer_run_with_confirm $cmd \$argv; end" | source
end

# Add to allowlist so preexec doesn't double-warn
set -ga __devcontainer_allowlist $__devcontainer_confirm_commands


function devcontainer --wraps devcontainer
    if test "$argv[1]" = "up"
        command devcontainer up \
            --dotfiles-repository https://github.com/mjwbenton/mattb-setup \
            --dotfiles-install-command scripts/setup_container.zsh \
            $argv[2..]
    else
        command devcontainer $argv
    end
end

function code --wraps code
    # Resolve the target folder from the first argument (or cwd)
    set -l folder (cd "$argv[1]" 2>/dev/null && pwd; or pwd)

    # If no devcontainer definition, just run code normally
    if not test -d "$folder/.devcontainer"; and not test -f "$folder/.devcontainer.json"
        command code $argv
        return
    end

    # Check if the devcontainer is running
    set -l container_id (docker ps --filter "label=devcontainer.local_folder=$folder" --format "{{.ID}}" 2>/dev/null)

    if test -z "$container_id"
        echo "Devcontainer for $folder is not running" >&2
        return 1
    end

    # Open VSCode connected to the running devcontainer
    set -l hex (printf '%s' "$folder" | xxd -p -c 256)
    set -l workspace_name (basename "$folder")
    command code --folder-uri "vscode-remote://dev-container+$hex/workspaces/$workspace_name"
end
