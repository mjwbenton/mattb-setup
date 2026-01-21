#!/bin/zsh
# Download GGUF models for llama.cpp
# - Gemma 3 4B for chat
# - Qwen2.5-Coder 3B for code autocompletion

set -e

MODELS_DIR="${HOME}/models"
mkdir -p "$MODELS_DIR"

echo "Downloading models to $MODELS_DIR..."

# Gemma 3 4B Instruct
GEMMA_FILE="gemma-3-4b-it-Q4_K_M.gguf"
GEMMA_URL="https://huggingface.co/unsloth/gemma-3-4b-it-GGUF/resolve/main/${GEMMA_FILE}"

if [[ -f "$MODELS_DIR/$GEMMA_FILE" ]]; then
    echo "✓ $GEMMA_FILE already exists, skipping"
else
    echo "Downloading $GEMMA_FILE..."
    curl -L -o "$MODELS_DIR/$GEMMA_FILE" "$GEMMA_URL"
fi

# Qwen2.5-Coder 3B
QWEN_FILE="qwen2.5-coder-3b-q8_0.gguf"
QWEN_URL="https://huggingface.co/ggml-org/Qwen2.5-Coder-3B-Q8_0-GGUF/resolve/main/${QWEN_FILE}"

if [[ -f "$MODELS_DIR/$QWEN_FILE" ]]; then
    echo "✓ $QWEN_FILE already exists, skipping"
else
    echo "Downloading $QWEN_FILE..."
    curl -L -o "$MODELS_DIR/$QWEN_FILE" "$QWEN_URL"
fi

echo ""
echo "Done! Models downloaded to $MODELS_DIR"
