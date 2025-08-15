#!/bin/bash

# 🚀 LazyVim Config Setup Script
# Automatically installs all dependencies for the nvim config

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &> /dev/null; then
            OS="ubuntu"
        elif command -v dnf &> /dev/null; then
            OS="fedora"
        elif command -v yum &> /dev/null; then
            OS="rhel"
        else
            OS="linux"
        fi
    else
        OS="unknown"
    fi
    log_info "Detected OS: $OS"
}

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Install package manager if needed
install_package_manager() {
    case $OS in
        macos)
            if ! command_exists brew; then
                log_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                
                # Add Homebrew to PATH for Apple Silicon Macs
                if [[ $(uname -m) == "arm64" ]]; then
                    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
                    eval "$(/opt/homebrew/bin/brew shellenv)"
                fi
                log_success "Homebrew installed"
            else
                log_success "Homebrew already installed"
            fi
            ;;
        ubuntu)
            log_info "Updating apt package list..."
            sudo apt update
            ;;
        fedora)
            log_info "Updating dnf package list..."
            sudo dnf update -y
            ;;
        rhel)
            log_info "Installing EPEL repository..."
            sudo yum install -y epel-release
            sudo yum update -y
            ;;
    esac
}

# Install core system tools
install_core_tools() {
    log_info "Installing core tools (fd, ripgrep, git, node)..."
    
    case $OS in
        macos)
            brew install fd ripgrep git node neovim
            ;;
        ubuntu)
            sudo apt install -y fd-find ripgrep git nodejs npm neovim
            # Ubuntu uses fd-find, create symlink
            if [[ ! -L /usr/local/bin/fd ]]; then
                sudo ln -sf $(which fdfind) /usr/local/bin/fd
            fi
            ;;
        fedora)
            sudo dnf install -y fd-find ripgrep git nodejs npm neovim
            ;;
        rhel)
            sudo yum install -y fd-find ripgrep git nodejs npm neovim
            ;;
        *)
            log_error "Unsupported OS: $OS"
            log_info "Please install manually: fd, ripgrep, git, nodejs, neovim"
            return 1
            ;;
    esac
    
    log_success "Core tools installed"
}

# Install Go and Go tools
install_go_tools() {
    log_info "Installing Go development tools..."
    
    # Install Go if not present
    if ! command_exists go; then
        case $OS in
            macos)
                brew install go
                ;;
            ubuntu)
                sudo apt install -y golang-go
                ;;
            fedora)
                sudo dnf install -y golang
                ;;
            rhel)
                sudo yum install -y golang
                ;;
        esac
        log_success "Go installed"
    else
        log_success "Go already installed: $(go version)"
    fi
    
    # Install Go tools
    log_info "Installing Go tools (golangci-lint, goimports, gofumpt)..."
    
    # Ensure GOPATH/bin is in PATH
    export PATH=$PATH:$(go env GOPATH)/bin
    
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    go install golang.org/x/tools/cmd/goimports@latest  
    go install mvdan.cc/gofumpt@latest
    
    log_success "Go tools installed"
}

# Install optional tools
install_optional_tools() {
    log_info "Installing optional tools (lazygit, gh)..."
    
    case $OS in
        macos)
            brew install lazygit gh
            ;;
        ubuntu)
            sudo apt install -y lazygit gh
            ;;
        fedora)
            sudo dnf install -y lazygit gh
            ;;
        rhel)
            sudo yum install -y lazygit gh
            ;;
    esac
    
    log_success "Optional tools installed"
}

# Verify installations
verify_installation() {
    log_info "Verifying installations..."
    
    local tools=("fd" "rg" "git" "node" "nvim")
    local go_tools=("go" "golangci-lint" "goimports" "gofumpt")
    local optional_tools=("lazygit" "gh")
    
    # Check core tools
    for tool in "${tools[@]}"; do
        if command_exists "$tool"; then
            log_success "✓ $tool: $(command -v $tool)"
        else
            log_error "✗ $tool: not found"
        fi
    done
    
    # Check Go tools
    export PATH=$PATH:$(go env GOPATH)/bin 2>/dev/null || true
    for tool in "${go_tools[@]}"; do
        if command_exists "$tool"; then
            log_success "✓ $tool: $(command -v $tool)"
        else
            log_warning "✗ $tool: not found (install Go tools if needed)"
        fi
    done
    
    # Check optional tools
    for tool in "${optional_tools[@]}"; do
        if command_exists "$tool"; then
            log_success "✓ $tool: $(command -v $tool)"
        else
            log_warning "○ $tool: not found (optional)"
        fi
    done
}

# Update shell configuration
update_shell_config() {
    log_info "Updating shell configuration..."
    
    # Add Go PATH to shell config
    local shell_config=""
    if [[ $SHELL == *"zsh"* ]]; then
        shell_config="$HOME/.zshrc"
    elif [[ $SHELL == *"bash"* ]]; then
        shell_config="$HOME/.bashrc"
    fi
    
    if [[ -n "$shell_config" ]] && command_exists go; then
        local go_path_export='export PATH=$PATH:$(go env GOPATH)/bin'
        if ! grep -q "go env GOPATH" "$shell_config" 2>/dev/null; then
            echo "" >> "$shell_config"
            echo "# Go tools PATH" >> "$shell_config"
            echo "$go_path_export" >> "$shell_config"
            log_success "Added Go PATH to $shell_config"
        fi
    fi
}

# Main installation function
main() {
    log_info "🚀 Starting LazyVim dependency installation..."
    echo
    
    detect_os
    
    # Ask user what to install
    echo
    log_info "What would you like to install?"
    echo "1. Core tools only (fd, ripgrep, git, node, neovim)"
    echo "2. Core + Go development tools"
    echo "3. Everything (core + Go + optional tools)"
    echo "4. Verify current installation"
    echo
    read -p "Choose option (1-4): " choice
    
    case $choice in
        1)
            install_package_manager
            install_core_tools
            ;;
        2)
            install_package_manager
            install_core_tools
            install_go_tools
            update_shell_config
            ;;
        3)
            install_package_manager
            install_core_tools
            install_go_tools
            install_optional_tools
            update_shell_config
            ;;
        4)
            # Just verify
            ;;
        *)
            log_error "Invalid choice. Exiting."
            exit 1
            ;;
    esac
    
    echo
    verify_installation
    
    echo
    log_success "🎉 Setup complete!"
    echo
    log_info "Next steps:"
    echo "1. Start nvim - plugins will auto-install"
    echo "2. Test global search: <leader>fg"
    echo "3. Test file finding: <leader>ff"
    echo "4. Check :checkhealth for any issues"
    echo
    
    if [[ $choice == "2" || $choice == "3" ]]; then
        log_info "⚠️  Restart your terminal to load Go tools PATH"
    fi
}

# Run main function
main "$@"