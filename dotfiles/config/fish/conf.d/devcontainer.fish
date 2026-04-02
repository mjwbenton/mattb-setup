# Devcontainer helpers:
# 1. Wraps `code` to auto-connect to running devcontainers
# 2. Warns before running non-allowlisted commands in devcontainer folders

# Allowlist of commands that are safe to run on the host in a devcontainer folder
set -g __devcontainer_allowlist \
    git ls cd cat less head tail grep rg fd find echo pwd \
    code vim nvim docker devcontainer tmux fish source \
    set export true false test which type man help history \
    bg fg jobs kill printf string math read mkdir cp mv rm ln \
    touch chmod chown date wc sort uniq tr cut diff comm tee \
    xargs seq basename dirname realpath popd pushd prevd nextd \
    dirh open pbcopy pbpaste ssh scp rsync curl wget

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
