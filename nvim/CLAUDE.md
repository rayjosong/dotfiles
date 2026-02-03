# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **LazyVim-based Neovim configuration** optimized for **Go development**, **GitHub integration**, and **productivity workflows**. The configuration follows a modular plugin architecture with performance optimizations.

### Directory Structure

- `lua/config/` - Core LazyVim configuration (options, keymaps, autocmds)
- `lua/plugins/` - Plugin specifications and configurations
- `docs/` - User documentation (SETUP.md, GUIDE.md, REFERENCE.md)
- `setup.sh` - Automated dependency installation script
- `check-deps.sh` - Dependency validation script

### Plugin Architecture

**Base Framework**: LazyVim with carefully selected extras:
- `lazyvim.plugins.extras.lang.go` - Go development stack
- `lazyvim.plugins.extras.lang.typescript` - TypeScript/JavaScript support
- `lazyvim.plugins.extras.lang.python` - Python support
- `lazyvim.plugins.extras.lang.markdown` - Markdown support
- `lazyvim.plugins.extras.test.core` - Testing framework
- `lazyvim.plugins.extras.dap.core` - Debug adapter protocol

**Performance Optimizations**:
- Aggressive lazy loading (`lazy = true` by default)
- Disabled expensive features (animations, automatic update checking)
- Optimized runtime path with disabled built-in plugins
- Tuned update times and timeouts for responsiveness

## Development Commands

### Setup and Dependencies

```bash
# Full automated setup (recommended)
./setup.sh

# Check dependencies status
./check-deps.sh

# Manual core tools installation (macOS)
brew install fd ripgrep neovim git node

# Go development tools
brew install go
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
```

### Code Formatting and Linting

**Lua formatting**: Uses StyLua with configuration in `stylua.toml`
```bash
stylua lua/ --check    # Check formatting
stylua lua/           # Format code
```

**Go formatting**: Automatically handled by `gofumpt` via LSP and conform.nvim

### Testing

Uses **Neotest** framework for all languages:
- Go: `neotest-go` adapter
- Python: `neotest-python` adapter  
- Test discovery and execution through LSP integration

## Key Workflows and Keymaps

### Essential Navigation
- `<leader>ch` - Interactive cheatsheet (main help system)
- `s` + two chars - Flash jump navigation (replaces traditional scrolling)
- `<leader>ff` - Find files (Telescope with fd fallback)
- `<leader>fg` - **Global text search** (ripgrep/grep fallback)
- `<leader>e` - File explorer (Neo-tree)

### Go Development Workflow
- `<leader>gtj` - Add JSON struct tags
- `<leader>gte` - Generate if err block
- `<leader>tt` - Run current test file
- `<leader>tr` - Run nearest test
- `<leader>dgt` - Debug Go test

### Git Integration
- `<leader>gg` - LazyGit TUI
- `<leader>gb` - Git blame toggle
- `<leader>gy` - Copy Git permalink
- GitHub PR/Issue management via Octo.nvim

### Window Management
- `<leader>z` - Toggle maximize window (using vim-maximizer)
- `<leader>Z` - Fallback maximize toggle
- `<C-h/j/k/l>` - Tmux-aware navigation

## Critical Dependencies

**Essential Tools** (config will fail without these):
- `fd` - File finding (Telescope)
- `ripgrep` - Text search (live grep)
- `neovim` (>=0.8)
- `git`
- `node.js`

**Go Development**:
- `go` compiler
- `gopls` LSP server (auto-installed via Mason)
- `golangci-lint`, `goimports`, `gofumpt` (for linting/formatting)

**Optional but Recommended**:
- `lazygit` - Git TUI integration
- `gh` - GitHub CLI for PR/issue workflows

## Performance Considerations

This configuration is **optimized for zero-lag responsiveness**:

- **Startup time**: ~50ms (lazy loading + disabled built-ins)
- **Update times**: 100ms updatetime, 200ms timeoutlen
- **Search**: Fallback system ensures Telescope works even without fd/rg
- **Memory**: Limited syntax highlighting on long lines (160 chars)

## Common Issues and Solutions

**Missing search tools**: Telescope has built-in fallbacks to `find` and `grep`
**Slow performance**: All optimizations applied - check `:checkhealth` for issues
**Keymap conflicts**: Thoroughly organized to avoid LazyVim default conflicts
**Go tools missing**: Run `./setup.sh` option 2 or 3 for Go development

## Keymap Conflict Avoidance

When integrating new plugins, check existing keymaps in:
- `lua/config/keymaps.lua` - Custom keymaps with conflict documentation
- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
- Plugin-specific configs in `lua/plugins/`

Always find the most intuitive keymaps and document conflicts to avoid.