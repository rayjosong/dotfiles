#!/bin/bash

# 🤖 Claude Launcher Script
# Automatically sets up environment and launches Claude with DeepSeek API

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if gum is installed
command_exists() {
    command -v "$1" &> /dev/null
}

# Fancy header using gum or fallback
show_header() {
    if command_exists gum; then
        gum style \
            --foreground 212 \
            --border-foreground 212 \
            --border double \
            --align center \
            --width 50 \
            --margin "1 2" \
            --padding "2 4" \
            "🤖 Claude Launcher" \
            "" \
            "DeepSeek API Integration"
    else
        echo -e "${PURPLE}"
        echo "╔════════════════════════════════════════════════╗"
        echo "║              🤖 Claude Launcher                ║"
        echo "║                                                ║"
        echo "║            DeepSeek API Integration            ║"
        echo "╚════════════════════════════════════════════════╝"
        echo -e "${NC}"
    fi
}

# Find .env file in current directory or home directory
find_env_file() {
    local env_file=""
    
    # Check current directory first
    if [[ -f ".env" ]]; then
        env_file=".env"
    # Check home directory
    elif [[ -f "$HOME/.env" ]]; then
        env_file="$HOME/.env"
    # Check dotfiles directory
    elif [[ -f "$HOME/.config/claude/.env" ]]; then
        env_file="$HOME/.config/claude/.env"
    fi
    
    echo "$env_file"
}

# Load environment variables from .env file
load_env() {
    local env_file=$(find_env_file)
    
    if [[ -n "$env_file" ]]; then
        if command_exists gum; then
            gum spin --spinner dot --title "Loading environment from $env_file..." -- sleep 1
        else
            echo -e "${CYAN}[INFO]${NC} Loading environment from $env_file..."
        fi
        
        # Load .env file
        set -a
        source "$env_file"
        set +a
        
        if command_exists gum; then
            gum style --foreground 46 "✓ Environment loaded successfully"
        else
            echo -e "${GREEN}✓ Environment loaded successfully${NC}"
        fi
    else
        if command_exists gum; then
            gum style --foreground 196 "⚠ No .env file found"
            gum style --foreground 214 "Looked in: ./env, ~/.env, ~/.config/claude/.env"
        else
            echo -e "${YELLOW}⚠ No .env file found${NC}"
            echo -e "${YELLOW}Looked in: ./.env, ~/.env, ~/.config/claude/.env${NC}"
        fi
    fi
}

# Set up Claude environment
setup_claude_env() {
    if command_exists gum; then
        gum spin --spinner dot --title "Setting up Claude environment..." -- sleep 1
    else
        echo -e "${CYAN}[INFO]${NC} Setting up Claude environment..."
    fi
    
    # Set DeepSeek API configuration
    export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
    export API_TIMEOUT_MS="600000"
    export ANTHROPIC_MODEL="deepseek-chat"
    export ANTHROPIC_SMALL_FAST_MODEL="deepseek-chat"
    
    # Set API token from environment or prompt
    if [[ -z "$ANTHROPIC_AUTH_TOKEN" && -z "$YOUR_API_KEY" ]]; then
        if command_exists gum; then
            ANTHROPIC_AUTH_TOKEN=$(gum input --password --placeholder "Enter your DeepSeek API key...")
        else
            echo -e "${YELLOW}Enter your DeepSeek API key:${NC}"
            read -s ANTHROPIC_AUTH_TOKEN
        fi
        export ANTHROPIC_AUTH_TOKEN
    elif [[ -n "$YOUR_API_KEY" ]]; then
        export ANTHROPIC_AUTH_TOKEN="$YOUR_API_KEY"
    fi
    
    if command_exists gum; then
        gum style --foreground 46 "✓ Environment configured"
    else
        echo -e "${GREEN}✓ Environment configured${NC}"
    fi
}

# Check account balance
check_balance() {
    if [[ -z "$ANTHROPIC_AUTH_TOKEN" ]]; then
        if command_exists gum; then
            gum style --foreground 196 "⚠ No API key available for balance check"
        else
            echo -e "${YELLOW}⚠ No API key available for balance check${NC}"
        fi
        return
    fi
    
    if command_exists gum; then
        gum spin --spinner dot --title "Checking account balance..." -- sleep 1
    else
        echo -e "${CYAN}[INFO]${NC} Checking account balance..."
    fi
    
    # Make API call to check balance
    local response=$(curl -s -X GET "https://api.deepseek.com/user/balance" \
        -H "Authorization: Bearer $ANTHROPIC_AUTH_TOKEN" 2>/dev/null)
    
    if [[ $? -eq 0 && -n "$response" ]]; then
        # Parse JSON response using built-in tools
        local total_balance=$(echo "$response" | grep -o '"total_balance":"[^"]*"' | cut -d'"' -f4)
        local currency=$(echo "$response" | grep -o '"currency":"[^"]*"' | cut -d'"' -f4)
        local granted_balance=$(echo "$response" | grep -o '"granted_balance":"[^"]*"' | cut -d'"' -f4)
        local topped_up_balance=$(echo "$response" | grep -o '"topped_up_balance":"[^"]*"' | cut -d'"' -f4)
        
        if [[ -n "$total_balance" && -n "$currency" ]]; then
            if command_exists gum; then
                gum style --foreground 220 --bold "💰 Balance: $currency $total_balance"
                gum style --foreground 245 "   (Granted: $currency $granted_balance, Topped up: $currency $topped_up_balance)"
            else
                echo -e "${YELLOW}💰 Balance: ${BOLD}$currency $total_balance${NC}"
                echo -e "${CYAN}   (Granted: $currency $granted_balance, Topped up: $currency $topped_up_balance)${NC}"
            fi
        else
            if command_exists gum; then
                gum style --foreground 214 "⚠ Could not parse balance"
            else
                echo -e "${YELLOW}⚠ Could not parse balance information${NC}"
            fi
        fi
    else
        if command_exists gum; then
            gum style --foreground 196 "❌ Failed to check balance"
        else
            echo -e "${RED}❌ Failed to check balance${NC}"
        fi
    fi
    echo ""
}

# Show current configuration
show_config() {
    if command_exists gum; then
        gum style --foreground 75 --bold "Current Configuration:"
        echo ""
        gum style --foreground 245 "Base URL: $ANTHROPIC_BASE_URL"
        gum style --foreground 245 "Model: $ANTHROPIC_MODEL"
        gum style --foreground 245 "Timeout: ${API_TIMEOUT_MS}ms"
        gum style --foreground 245 "API Key: ${ANTHROPIC_AUTH_TOKEN:0:8}..."
    else
        echo -e "${BLUE}Current Configuration:${NC}"
        echo -e "${CYAN}Base URL:${NC} $ANTHROPIC_BASE_URL"
        echo -e "${CYAN}Model:${NC} $ANTHROPIC_MODEL"
        echo -e "${CYAN}Timeout:${NC} ${API_TIMEOUT_MS}ms"
        echo -e "${CYAN}API Key:${NC} ${ANTHROPIC_AUTH_TOKEN:0:8}..."
    fi
    echo ""
}

# Launch Claude
launch_claude() {
    if command_exists gum; then
        gum spin --spinner dot --title "Launching Claude..." -- sleep 1
        gum style \
            --foreground 212 \
            --bold \
            "🚀 Starting Claude with DeepSeek API..."
    else
        echo -e "${PURPLE}🚀 Starting Claude with DeepSeek API...${NC}"
    fi
    
    echo ""
    
    # Launch claude command
    if command_exists claude; then
        claude "$@"
    else
        echo -e "${RED}Error: 'claude' command not found${NC}"
        echo -e "${YELLOW}Please install Claude CLI first${NC}"
        exit 1
    fi
}

# Main function
main() {
    clear
    show_header
    
    load_env
    setup_claude_env
    check_balance
    show_config
    
    # Pass all arguments to claude
    launch_claude "$@"
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_header
    echo "Usage: claude-launcher [claude options]"
    echo ""
    echo "This script automatically:"
    echo "  • Loads API key from .env file"
    echo "  • Sets up DeepSeek API configuration"
    echo "  • Launches Claude with proper environment"
    echo ""
    echo "Environment file locations (in order):"
    echo "  • ./.env (current directory)"
    echo "  • ~/.env (home directory)"  
    echo "  • ~/.config/claude/.env"
    echo ""
    echo "Required .env variable:"
    echo "  YOUR_API_KEY=your_deepseek_api_key_here"
    echo ""
    echo "Optional: Install 'gum' for beautiful UI"
    echo "  brew install gum"
    exit 0
fi

# Run main function with all arguments
main "$@"