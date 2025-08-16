# 🚀 Neovim LazyVim Setup Guide

## Quick Setup (New Machine)

Run this single command to install everything:

```bash
# From the nvim directory
./setup.sh
```

Or manual setup if you prefer:

## 📋 Dependencies Required

### **System Tools** (Essential)
- **Homebrew** (macOS) / **apt** (Ubuntu) / **yum** (RHEL/CentOS)
- **Git** 
- **Node.js** (for LSP servers)
- **Python 3** (for some plugins)

### **Search & Navigation Tools** (Critical for functionality)
- **fd** - Fast file finder (telescope, neo-tree search)
- **ripgrep (rg)** - Fast text search (telescope live grep)

### **Go Development** (If using Go)
- **Go** - Go language runtime
- **golangci-lint** - Go linter
- **goimports** - Go import formatter
- **gofumpt** - Go code formatter

### **Optional Tools** (Nice to have)
- **lazygit** - Git TUI (for `<leader>gg`)
- **gh** - GitHub CLI (for GitHub integration)

## 🔧 Installation Commands

### **macOS (Homebrew)**
```bash
# Essential tools
brew install fd ripgrep neovim git node

# Go development (if needed)
brew install go
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

# Optional tools
brew install lazygit gh
```

### **Ubuntu/Debian**
```bash
# Essential tools
sudo apt update
sudo apt install fd-find ripgrep neovim git nodejs npm

# Create fd symlink (Ubuntu uses fd-find)
sudo ln -s $(which fdfind) /usr/local/bin/fd

# Go development (if needed)
sudo apt install golang-go
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

# Optional tools
sudo apt install lazygit gh
```

### **RHEL/CentOS/Fedora**
```bash
# Essential tools (Fedora)
sudo dnf install fd-find ripgrep neovim git nodejs npm

# Or for RHEL/CentOS (with EPEL)
sudo yum install epel-release
sudo yum install fd-find ripgrep neovim git nodejs npm

# Go development (if needed)
sudo dnf install golang  # or: sudo yum install golang
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
```

## 📁 Config Installation

### **Method 1: Direct Clone**
```bash
# Clone to nvim config directory
git clone <your-repo-url> ~/.config/nvim
cd ~/.config/nvim
./setup.sh
```

### **Method 2: Manual Copy**
```bash
# Copy your config files
cp -r /path/to/your/nvim/config ~/.config/nvim
cd ~/.config/nvim
./setup.sh
```

## ✅ Verification

After installation, verify everything works:

```bash
# Check core tools
fd --version
rg --version
nvim --version

# Check Go tools (if using Go)
go version
golangci-lint version
goimports -h
gofumpt -h

# Check optional tools
lazygit --version
gh --version
```

## 🔍 Testing Key Features

Launch nvim and test:

1. **Global Search**: `<leader>fg` (should work without errors)
2. **File Finding**: `<leader>ff` (should be fast with fd)
3. **Word Search**: Put cursor on word → `<leader>fw` (should work)
4. **Neo-tree Search**: `<leader>e` then `/` (should work)
5. **Go Development**: Open `.go` file (should have LSP, no lint errors)

## 🚨 Troubleshooting

### **"No supported finder found: fd" Error**
```bash
# Check if fd is installed and in PATH
which fd
fd --version

# If not found, install fd:
brew install fd  # macOS
sudo apt install fd-find  # Ubuntu
```

### **"rg command not found" Error**
```bash
# Check ripgrep installation
which rg
rg --version

# If not found:
brew install ripgrep  # macOS
sudo apt install ripgrep  # Ubuntu
```

### **Go LSP Not Working**
```bash
# Check Go installation
go version

# Ensure Go tools are in PATH
echo $GOPATH/bin
ls $GOPATH/bin

# Add to ~/.zshrc or ~/.bashrc if missing:
export PATH=$PATH:$(go env GOPATH)/bin
```

### **Mason Tools Missing**
```bash
# In nvim, run:
:checkhealth mason
:Mason

# Install missing tools via Mason UI
```

## 🎯 What Each Tool Does

- **fd**: Fast file finder (replaces `find`) - Used by telescope and neo-tree
- **ripgrep**: Fast text search (replaces `grep`) - Used by telescope live grep
- **golangci-lint**: Go linting - Provides code quality checks
- **goimports**: Go import management - Auto-adds/removes imports
- **gofumpt**: Go formatting - Stricter than `go fmt`
- **lazygit**: Git TUI - Visual git interface (`<leader>gg`)
- **gh**: GitHub CLI - GitHub integration features

## 📦 Mason-Managed vs System Tools

**System Tools** (install manually):
- fd, ripgrep - Core search functionality
- Go, golangci-lint - Go development

**Mason-Managed** (auto-installed):
- Language servers (gopls, tsserver, etc.)
- Formatters (prettier, stylua, etc.)
- Some linters and tools

## 🦕 Optional: Deno Installation (for Advanced Markdown Preview)

If you want to use the advanced `peek.nvim` plugin for mermaid viewing:

### **Quick Installation**
```bash
# macOS (Homebrew)
brew install deno

# Linux/macOS (Universal)
curl -fsSL https://deno.land/install.sh | sh
```

### **Manual PATH Setup** (if needed)
Add to your `~/.zshrc` or `~/.bashrc`:
```bash
export PATH="$HOME/.deno/bin:$PATH"
```

### **Automated Installation**
The setup script option 3 includes Deno automatically.

### **Verification**
```bash
deno --version
```

### **Usage**
- `<leader>mP` - Advanced peek preview (requires Deno)
- `<leader>mp` - Standard markdown preview (works without Deno)

**Note**: Deno is optional - markdown preview works fine without it using the standard preview plugin.

## 🔄 Updating Dependencies

```bash
# Update system tools
brew upgrade fd ripgrep  # macOS
sudo apt update && sudo apt upgrade fd-find ripgrep  # Ubuntu

# Update Go tools
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

# Update Mason tools (in nvim)
:Mason
# Select tools and press 'U' to update
```

---

## 🚀 Quick Start Summary

**New Machine Setup:**
1. Install Homebrew/package manager
2. Run `./setup.sh` in nvim config directory
3. Launch nvim - plugins auto-install
4. Test key features listed above
5. You're ready to code!

The setup script handles platform detection and installs everything automatically.