#!/bin/bash

# 🔍 Dependency Checker for LazyVim Config
# Checks if all required tools are installed and provides installation hints

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 Checking LazyVim Dependencies${NC}\n"

# Function to check if command exists
check_tool() {
    local tool=$1
    local description=$2
    local install_hint=$3
    
    if command -v "$tool" &> /dev/null; then
        echo -e "✅ ${GREEN}$tool${NC} - $description"
        return 0
    else
        echo -e "❌ ${RED}$tool${NC} - $description"
        if [[ -n "$install_hint" ]]; then
            echo -e "   ${YELLOW}Install:${NC} $install_hint"
        fi
        return 1
    fi
}

# Check core tools
echo -e "${BLUE}Core Tools:${NC}"
check_tool "nvim" "Neovim editor" "brew install neovim"
check_tool "git" "Version control" "brew install git"
check_tool "node" "JavaScript runtime" "brew install node"

echo

# Check search tools
echo -e "${BLUE}Search Tools (Critical):${NC}"
check_tool "fd" "Fast file finder" "brew install fd"
check_tool "rg" "Fast text search (ripgrep)" "brew install ripgrep"

echo

# Check Go tools
echo -e "${BLUE}Go Development:${NC}"
go_installed=false
if check_tool "go" "Go language runtime" "brew install go"; then
    go_installed=true
fi

if [[ "$go_installed" == true ]]; then
    # Check if GOPATH/bin is in PATH
    if [[ ":$PATH:" == *":$(go env GOPATH)/bin:"* ]]; then
        echo -e "✅ ${GREEN}GOPATH/bin${NC} in PATH"
    else
        echo -e "⚠️  ${YELLOW}GOPATH/bin${NC} not in PATH"
        echo -e "   ${YELLOW}Add to shell:${NC} export PATH=\$PATH:\$(go env GOPATH)/bin"
    fi
    
    check_tool "golangci-lint" "Go linter" "go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest"
    check_tool "goimports" "Go import formatter" "go install golang.org/x/tools/cmd/goimports@latest"
    check_tool "gofumpt" "Go code formatter" "go install mvdan.cc/gofumpt@latest"
else
    echo -e "❌ ${RED}golangci-lint${NC} - Go linter (requires Go)"
    echo -e "❌ ${RED}goimports${NC} - Go import formatter (requires Go)"
    echo -e "❌ ${RED}gofumpt${NC} - Go code formatter (requires Go)"
fi

echo

# Check optional tools
echo -e "${BLUE}Optional Tools:${NC}"
check_tool "lazygit" "Git TUI interface" "brew install lazygit"
check_tool "gh" "GitHub CLI" "brew install gh"

echo

# Summary
echo -e "${BLUE}📋 Summary:${NC}"

# Count missing critical tools
missing_critical=0
critical_tools=("nvim" "fd" "rg")

for tool in "${critical_tools[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        ((missing_critical++))
    fi
done

if [[ $missing_critical -eq 0 ]]; then
    echo -e "🎉 ${GREEN}All critical tools are installed!${NC}"
    echo -e "   Your LazyVim config should work perfectly."
else
    echo -e "⚠️  ${YELLOW}Missing $missing_critical critical tools.${NC}"
    echo -e "   Run ${BLUE}./setup.sh${NC} to install everything automatically."
fi

echo
echo -e "${BLUE}Quick Setup:${NC}"
echo -e "• Full setup: ${YELLOW}./setup.sh${NC}"
echo -e "• Core only:  ${YELLOW}brew install fd ripgrep neovim${NC}"
echo -e "• With Go:    ${YELLOW}brew install fd ripgrep neovim go && go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest${NC}"

echo