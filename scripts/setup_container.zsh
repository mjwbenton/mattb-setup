#!/bin/zsh -e

# mattb-setup root directory is always the directory above this script
SCRIPT_DIR=${0:a:h}

# Apt
export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get -y install --no-install-recommends \
  chromium \
  fonts-liberation \
apt-get clean
rm -rf /var/lib/apt/lists/*

# Install Claude Code
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# Install Pi
echo "Installing Pi..."
curl -fsSL https://pi.dev/install.sh | sh
pi install git:github.com/1broseidon/ketch
npm install -g agent-browser
npx skills add vercel-labs/agent-browser --agent pi -y

# Configure agent-browser
if ! grep -q "AGENT_BROWSER_EXECUTABLE_PATH" ~/.bashrc 2>/dev/null; then
  cat >> ~/.bashrc <<'EOF'

# agent-browser
export AGENT_BROWSER_EXECUTABLE_PATH="/usr/bin/chromium"
export AGENT_BROWSER_ARGS="--no-sandbox,--disable-dev-shm-usage"
EOF
fi

# Install dotfiles
echo "Installing dotfiles..."
$SCRIPT_DIR/install_dotfiles.zsh
