# Wraps the `code` command to automatically detect devcontainers.
# If the target folder has a devcontainer definition and the container is running,
# opens VSCode connected to the container. Otherwise falls back to normal `code`.
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
