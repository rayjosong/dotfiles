#!/bin/bash

# 🤖 Claude Launcher Script
# Automatically sets up environment and launches Claude with a selected API provider

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
  command -v "$1" &>/dev/null
}

# Fancy header using gum or fallback
show_header() {
  local provider_name=$1
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
      "$provider_name API Integration"
  else
    echo -e "${PURPLE}"
    echo "╔════════════════════════════════════════════════╗"
    echo "║              🤖 Claude Launcher                ║"
    echo "║                                                ║"
    echo "║         $provider_name API Integration         ║"
    echo "╚════════════════════════════════════════════════╝"
    echo -e "${NC}"
  fi
}

# Load environment variables from .env file
load_env() {
  # Use the global $DOTFILES_DIR variable provided by the user's environment
  local env_file="$DOTFILES_DIR/.env"

  if [[ -n "$DOTFILES_DIR" && -f "$env_file" ]]; then
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
      gum style --foreground 196 "⚠ .env file not found."
      gum style --foreground 214 "Checked for \$DOTFILES_DIR/.env"
    else
      echo -e "${YELLOW}⚠ .env file not found.${NC}"
      echo -e "${YELLOW}Checked for \$DOTFILES_DIR/.env${NC}"
    fi
  fi
}

# Set up Claude environment based on provider
setup_claude_env() {
  local provider=$1
  if command_exists gum; then
    gum spin --spinner dot --title "Setting up $provider environment..." -- sleep 1
  else
    echo -e "${CYAN}[INFO]${NC} Setting up $provider environment..."
  fi

  if [[ "$provider" == "DeepSeek" ]]; then
    # Map DeepSeek configuration to Anthropic variables for runtime
    if [[ -n "$DEEPSEEK_BASE_URL" ]]; then
      export ANTHROPIC_BASE_URL="$DEEPSEEK_BASE_URL"
    else
      export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
    fi

    if [[ -n "$DEEPSEEK_API_KEY" && "$DEEPSEEK_API_KEY" != "your_deepseek_api_key_here" ]]; then
      export ANTHROPIC_AUTH_TOKEN="$DEEPSEEK_API_KEY"
    elif [[ -z "$ANTHROPIC_AUTH_TOKEN" ]]; then
      if command_exists gum; then
        ANTHROPIC_AUTH_TOKEN=$(gum input --password --placeholder "Enter your DeepSeek API key...")
      else
        echo -e "${YELLOW}Enter your DeepSeek API key:${NC}"
        read -s ANTHROPIC_AUTH_TOKEN
      fi
      export ANTHROPIC_AUTH_TOKEN
    fi
    
    export ANTHROPIC_MODEL="${DEEPSEEK_MODEL:-deepseek-chat}"
    export ANTHROPIC_SMALL_FAST_MODEL="${DEEPSEEK_SMALL_FAST_MODEL:-deepseek-chat}"

  elif [[ "$provider" == "GLM" ]]; then
    export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
    
    if [[ -n "$GLM_API_KEY" && "$GLM_API_KEY" != "YOUR_API_KEY" ]]; then
      export ANTHROPIC_AUTH_TOKEN="$GLM_API_KEY"
    elif [[ -n "$YOUR_API_KEY" && "$YOUR_API_KEY" != "YOUR_API_KEY" ]]; then
        # Fallback for user's request
        export ANTHROPIC_AUTH_TOKEN="$YOUR_API_KEY"
    elif [[ -z "$ANTHROPIC_AUTH_TOKEN" ]]; then
      if command_exists gum; then
        ANTHROPIC_AUTH_TOKEN=$(gum input --password --placeholder "Enter your GLM API key...")
      else
        echo -e "${YELLOW}Enter your GLM API key:${NC}"
        read -s ANTHROPIC_AUTH_TOKEN
      fi
      export ANTHROPIC_AUTH_TOKEN
    fi
    # You might want to set specific models for GLM if they differ
    export ANTHROPIC_MODEL="${GLM_MODEL:-glm-4.6}"
    export ANTHROPIC_SMALL_FAST_MODEL="${GLM_SMALL_FAST_MODEL:-glm-4.6}"
  fi

  if [[ -n "$API_TIMEOUT_MS" ]]; then
    export API_TIMEOUT_MS="$API_TIMEOUT_MS"
  else
    export API_TIMEOUT_MS="600000"
  fi

  if command_exists gum; then
    gum style --foreground 46 "✓ Environment configured for $provider"
  else
    echo -e "${GREEN}✓ Environment configured for $provider${NC}"
  fi
}

# Check account balance (DeepSeek specific)
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
    # Parse JSON response
    local total_balance=$(echo "$response" | grep -o '"total_balance":"[^"]*"' | cut -d'"' -f4)
    local currency=$(echo "$response" | grep -o '"currency":"[^"]*"' | cut -d'"' -f4)
    local granted_balance=$(echo "$response" | grep -o '"granted_balance":"[^"]*"' | cut -d'"' -f4)
    local topped_up_balance=$(echo "$response" | grep -o '"topped_up_balance":"[^"]*"' | cut -d'"' -f4)

    if [[ -n "$total_balance" && -n "$currency" ]]; then
      if command_exists gum; then
        gum style --foreground 220 --bold "💰 Balance: $currency $total_balance"
        gum style --foreground 245 "   (Granted: $currency $granted_balance, Topped up: $currency $topped_up_balance)"
      else
        echo -e "${YELLOW}💰 Balance: $currency $total_balance${NC}"
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
  local provider_name=$1
  shift # remove provider name from arguments
  if command_exists gum; then
    gum spin --spinner dot --title "Launching Claude..." -- sleep 1
    gum style \
      --foreground 212 \
      --bold \
      "🚀 Starting Claude with $provider_name API..."
  else
    echo -e "${PURPLE}🚀 Starting Claude with $provider_name API...${NC}"
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
  
  local provider
  if command_exists gum; then
    gum style --padding "1 0" --border normal --border-foreground 212 "🤖 Welcome to Claude Launcher"
    echo "" # Add a newline for spacing
    provider=$(gum choose --header "Please select your API provider" --item.foreground 240 --selected.foreground 212 "DeepSeek" "GLM")
  else
    echo "Choose your API provider:"
    echo "1) DeepSeek"
    echo "2) GLM"
    read -p "Enter choice [1-2]: " choice
    case $choice in
      1) provider="DeepSeek" ;;
      2) provider="GLM" ;;
      *) echo "Invalid choice"; exit 1 ;;
    esac
  fi

  # If user presses Esc or Ctrl+C in gum choose, provider will be empty
  if [ -z "$provider" ]; then
    echo "No provider selected. Exiting."
    exit 0
  fi

  show_header "$provider"
  load_env
  setup_claude_env "$provider"
  
  if [[ "$provider" == "DeepSeek" ]]; then
    check_balance
  fi
  
  show_config

  # Pass all arguments to claude
  launch_claude "$provider" "$@"
}

# Check for help flag
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  show_header "Multi-Provider"
  echo "Usage: claude-launcher [claude options]"
  echo ""
  echo "This script automatically:
  • Prompts you to choose an API provider (DeepSeek or GLM)
  • Loads API keys from .env file (DEEPSEEK_API_KEY or GLM_API_KEY)
  • Maps them to ANTHROPIC_* variables at runtime
  • Launches Claude with the proper environment"
  echo ""
  echo "Required .env variables:
  DEEPSEEK_API_KEY=your_deepseek_api_key_here
  GLM_API_KEY=your_glm_api_key_here"
  echo ""
  echo "Optional: Install 'gum' for beautiful UI
  brew install gum"
  exit 0
fi

# Run main function with all arguments
main "$@"