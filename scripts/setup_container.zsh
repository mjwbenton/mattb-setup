#!/bin/zsh -e

# mattb-setup root directory is always the directory above this script
SCRIPT_DIR=${0:a:h}

# Install Claude Code
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# Install Pi
echo "Installing Pi..."
curl -fsSL https://pi.dev/install.sh | sh

# Install dotfiles
echo "Installing dotfiles..."
$SCRIPT_DIR/install_dotfiles.zsh
