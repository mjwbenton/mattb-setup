#!/bin/zsh
# Download GGUF models for llama.cpp
# - Gemma 3 4B for chat
# - Qwen2.5-Coder 7B for code autocompletion

set -e

MODELS_DIR="${HOME}/models"
mkdir -p "$MODELS_DIR"

echo "Downloading models to $MODELS_DIR..."

# Gemma 3 4B Instruct (Q4_K_M quantization)
GEMMA_FILE="gemma-3-4b-it-Q4_K_M.gguf"
GEMMA_URL="https://huggingface.co/unsloth/gemma-3-4b-it-GGUF/resolve/main/${GEMMA_FILE}"

if [[ -f "$MODELS_DIR/$GEMMA_FILE" ]]; then
    echo "✓ $GEMMA_FILE already exists, skipping"
else
    echo "Downloading $GEMMA_FILE..."
    curl -L -o "$MODELS_DIR/$GEMMA_FILE" "$GEMMA_URL"
fi

# Qwen2.5-Coder 7B Instruct (Q4_K_M quantization)
QWEN_FILE="qwen2.5-coder-7b-instruct-q4_k_m.gguf"
QWEN_URL="https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/${QWEN_FILE}"

if [[ -f "$MODELS_DIR/$QWEN_FILE" ]]; then
    echo "✓ $QWEN_FILE already exists, skipping"
else
    echo "Downloading $QWEN_FILE..."
    curl -L -o "$MODELS_DIR/$QWEN_FILE" "$QWEN_URL"
fi

echo ""
echo "Done! Models downloaded to $MODELS_DIR"
echo ""
echo "Usage:"
echo "  Chat:        llama-cli -m $MODELS_DIR/$GEMMA_FILE -c 4096 -ngl 99 -cnv"
echo "  Server:      llama-server -m $MODELS_DIR/$QWEN_FILE -c 4096 -ngl 99"
