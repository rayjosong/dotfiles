#!/bin/bash

# 🔗 Dotfiles Symlink Setup Script
# Automatically creates symlinks for all dotfiles configuration

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
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

log_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

# Get the directory where this script is located (dotfiles directory)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log_info "🔗 Dotfiles Symlink Setup"
log_info "Dotfiles directory: $DOTFILES_DIR"
echo

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    # Create target directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
        log_info "Created directory: $target_dir"
    fi
    
    # Handle existing files/symlinks
    if [[ -L "$target" ]]; then
        local current_target=$(readlink "$target")
        if [[ "$current_target" == "$source" ]]; then
            log_success "✓ $description (already linked correctly)"
            return 0
        else
            log_warning "Existing symlink points to different location: $current_target"
            read -p "Replace with correct symlink? (y/n): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$target"
            else
                log_warning "Skipped: $description"
                return 0
            fi
        fi
    elif [[ -f "$target" || -d "$target" ]]; then
        log_warning "File/directory exists: $target"
        read -p "Backup and replace? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$target" "$backup"
            log_info "Backed up to: $backup"
        else
            log_warning "Skipped: $description"
            return 0
        fi
    fi
    
    # Create the symlink
    ln -s "$source" "$target"
    log_success "✓ $description"
}

# Function to verify symlink
verify_symlink() {
    local target="$1"
    local description="$2"
    
    if [[ -L "$target" ]]; then
        local source=$(readlink "$target")
        if [[ -e "$source" ]]; then
            log_success "✓ $description → $source"
        else
            log_error "✗ $description → $source (target missing)"
        fi
    else
        log_warning "○ $description (not symlinked)"
    fi
}

echo "==================================================================="
log_step "Setting up shell configuration symlinks"
echo "==================================================================="

# Shell configuration files
create_symlink "$DOTFILES_DIR/zshrc" "$HOME/.zshrc" "Zsh configuration"
create_symlink "$DOTFILES_DIR/zprofile" "$HOME/.zprofile" "Zsh profile"
create_symlink "$DOTFILES_DIR/aliases" "$HOME/.aliases" "Shell aliases"

echo
echo "==================================================================="
log_step "Setting up development tool symlinks"
echo "==================================================================="

# Git configuration
create_symlink "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig" "Git configuration"

# SSH configuration
create_symlink "$DOTFILES_DIR/config" "$HOME/.ssh/config" "SSH configuration"

echo
echo "==================================================================="
log_step "Setting up application configuration symlinks"
echo "==================================================================="

# Application configs in ~/.config/
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim" "Neovim configuration"
create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty" "Kitty terminal configuration"
create_symlink "$DOTFILES_DIR/karabiner" "$HOME/.config/karabiner" "Karabiner keyboard configuration"

# Tmux configuration
if [[ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]]; then
    create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf" "Tmux configuration"
else
    log_warning "Tmux config not found at $DOTFILES_DIR/tmux/.tmux.conf"
fi

echo
echo "==================================================================="
log_step "Setting up additional configurations"
echo "==================================================================="

# Claude Code settings (if exists)
if [[ -d "$DOTFILES_DIR/.claude" ]]; then
    create_symlink "$DOTFILES_DIR/.claude" "$HOME/.claude" "Claude Code settings"
fi

echo
echo "==================================================================="
log_step "Verification Summary"
echo "==================================================================="

echo
log_info "Verifying all symlinks..."
echo

# Verify all symlinks
verify_symlink "$HOME/.zshrc" "Zsh configuration"
verify_symlink "$HOME/.zprofile" "Zsh profile" 
verify_symlink "$HOME/.aliases" "Shell aliases"
verify_symlink "$HOME/.gitconfig" "Git configuration"
verify_symlink "$HOME/.ssh/config" "SSH configuration"
verify_symlink "$HOME/.config/nvim" "Neovim configuration"
verify_symlink "$HOME/.config/kitty" "Kitty terminal configuration"
verify_symlink "$HOME/.config/karabiner" "Karabiner keyboard configuration"
verify_symlink "$HOME/.tmux.conf" "Tmux configuration"
verify_symlink "$HOME/.claude" "Claude Code settings"

echo
echo "==================================================================="
log_step "Post-Setup Instructions"
echo "==================================================================="

echo
log_info "📋 Next Steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Test that 'myclaude' command works"
echo "3. Open nvim to ensure configuration loads correctly"
echo "4. Check that git config is working: git config --list"
echo
log_info "🛠️  Optional:"
echo "• Run nvim setup script: ./nvim/setup.sh"
echo "• Install tmux plugins if using tmux"
echo
log_success "🎉 Dotfiles symlink setup complete!"
echo

# Check if we need to set up DOTFILES_DIR in current session
if [[ -z "$DOTFILES_DIR_SET" ]]; then
    echo "💡 For immediate effect in this session, run:"
    echo "   export DOTFILES_DIR=\"$DOTFILES_DIR\""
    echo "   source ~/.zshrc"
fi