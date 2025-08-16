#!/bin/bash

# Enhanced Claude Code Setup Script
# Features: Interactive model selection, visual styling with gum, model persistence

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/.claude_model_config"
AVAILABLE_MODELS=(
    "claude-sonnet-4.0"
    "claude-sonnet-3.7" 
    "gemini-2-5-pro-exp"
)

# Colors and styling - Modern blue/purple theme
export GUM_CHOOSE_CURSOR_FOREGROUND="#8B5CF6"
export GUM_CHOOSE_SELECTED_FOREGROUND="#06B6D4"
export GUM_SPIN_SPINNER="dot"
export GUM_SPIN_TITLE_FOREGROUND="#3B82F6"

# Check dependencies
check_dependencies() {
    local missing_deps=()
    
    if ! command -v gum &> /dev/null; then
        missing_deps+=("gum")
    fi
    
    if ! command -v claude &> /dev/null; then
        missing_deps+=("claude")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "❌ Missing dependencies: ${missing_deps[*]}"
        echo "Install with: brew install gum && pip install claude-cli"
        exit 1
    fi
}

# Load last used model from config
load_last_model() {
    if [ -f "$CONFIG_FILE" ]; then
        cat "$CONFIG_FILE"
    else
        echo "${AVAILABLE_MODELS[0]}"
    fi
}

# Save selected model to config
save_model_choice() {
    echo "$1" > "$CONFIG_FILE"
}

# Model selection interface
select_model() {
    local last_model
    last_model=$(load_last_model)
    
    # Redirect UI output to standard error (>&2) to avoid capturing it
    gum style \
        --foreground="#8B5CF6" \
        --border="rounded" \
        --margin="1" \
        --padding="1 2" \
        "🤖 Claude Code Model Selector" >&2
    
    echo >&2
    gum style --foreground="#64748B" "Last used: $last_model" >&2
    echo >&2
    
    local selected_model
    # The gum choose prompt is interactive and thus writes to stderr by default
    selected_model=$(printf '%s\n' "${AVAILABLE_MODELS[@]}" | \
        gum choose \
            --header="Select a model:" \
            --header.foreground="#06B6D4" \
            --selected="$last_model")
    
    # This final echo to standard output is what gets assigned to the variable
    if [ -n "$selected_model" ]; then
        save_model_choice "$selected_model"
        echo "$selected_model"
    else
        # If the user cancels, fall back to the last used model
        echo "$last_model"
    fi
}

# Setup environment variables
setup_environment() {
    # Load environment variables from .env file
    if [ -f "$SCRIPT_DIR/.env" ]; then
        gum style --foreground="#F59E0B" "📁 Loading environment from .env file..."
        set -a
        # shellcheck source=/dev/null
        source "$SCRIPT_DIR/.env"
        set +a
    fi

    # If the token is still not set, exit with an error
    if [ -z "$ANTHROPIC_AUTH_TOKEN" ]; then
        gum style \
            --foreground="#EF4444" \
            --border="rounded" \
            --margin="1" \
            --padding="1 2" \
            "❌ Error: ANTHROPIC_AUTH_TOKEN is not set."
        
        echo
        gum style --foreground="#64748B" "Please set it as an environment variable or create a .env file with:"
        gum style --foreground="#06B6D4" "ANTHROPIC_AUTH_TOKEN=sk-..."
        exit 1
    fi
}

# Main execution
main() {
    # Check if help is requested
    if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
        gum style \
            --foreground="#06B6D4" \
            --border="rounded" \
            --margin="1" \
            --padding="1 2" \
            "🚀 Claude Code Enhanced Setup Script

Usage: $0 [claude-cli-options]

Features:
• Interactive model selection with gum
• Remembers your last used model
• Beautiful terminal interface
• Supports: claude-sonnet-4.0, claude-sonnet-3.7, gemini-2-5-pro-exp

Options:
  -h, --help      Show this help message
  --model MODEL   Skip selection and use specified model
 
All other arguments are passed directly to claude CLI."
        exit 0
    fi
    
    check_dependencies
    setup_environment
    
    local selected_model
    
    # Check if model is specified via command line
    if [[ "${1:-}" == "--model" ]] && [[ -n "${2:-}" ]]; then
        selected_model="$2"
        shift 2 # Remove --model and its argument from the list
        save_model_choice "$selected_model"
    else
        selected_model=$(select_model)
    fi
    
    echo
    gum style \
        --foreground="#10B981" \
        --border="rounded" \
        --margin="1" \
        --padding="1 2" \
        "🚀 Launching Claude with model: $selected_model"
    
    # Show a brief loading animation
    gum spin --title="Starting Claude..." --show-output -- sleep 1
    
    # Run claude with the selected model
    claude --model "$selected_model" "$@"
}

# Run main function with all arguments
main "$@"
