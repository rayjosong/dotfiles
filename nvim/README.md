# 💤 Neovim Configuration

A professional LazyVim-based setup optimized for **Go development**, **GitHub integration**, and **productivity workflows**.

## 📚 Documentation

| File | Purpose | When to Use |
| ---------------------------------- | ------------------------------------- | -------------------------------------- |
| **[SETUP.md](./SETUP.md)** | Installation & Dependencies | Setting up on a new machine |
| **[GUIDE.md](./GUIDE.md)** | Daily Usage & Workflows | Learning keybindings and features |
| **[REFERENCE.md](./REFERENCE.md)** | Advanced Features & Technical Details | Deep customization and troubleshooting |

## 🚀 Quick Start

1. **Install dependencies**: `./setup.sh` (handles everything automatically)
1. **Launch Neovim**: Plugins auto-install on first run
1. **Learn essentials**: See [GUIDE.md](.docs/GUIDE.md) for key workflows
1. **Get help**: Press `<leader>ch` for interactive cheatsheet

## 🎯 Key Features

- **🔧 Go Development**: Complete toolchain with LSP, debugging, testing
- **🐙 GitHub Integration**: Issues, PRs, git workflows, permalink generation
- **🤖 AI Assistant**: Cursor-like AI integration with Avante.nvim
- **🧭 Code Navigation**: Intelligent symbol browsing with Aerial.nvim
- **📊 Git Visualization**: Professional diff viewing with Diffview.nvim
- **📝 Markdown**: Obsidian integration with mermaid diagram support
- **⚡ Performance**: Optimized for zero lag and instant responsiveness

## 🔧 Current Status

- **Migration**: ✅ Successfully migrated from NvChad to LazyVim (2025-08-15)
- **Workflows**: ✅ All custom keybindings and workflows preserved
- **Dependencies**: ✅ Automated setup script for new machines

## 📋 Quick Reference

### Essential Keybindings

- `<leader>ch` - Open cheatsheet (main help)
- `<leader>ff` - Find files
- `<leader>fg` - Global search
- `<leader>gg` - LazyGit
- `<leader>aa` - Ask AI assistant

### Navigation

- `s` + two chars - Flash jump to any text
- `<leader>e` - File explorer
- `<C-h/j/k/l>` - Navigate vim/tmux panes

### Go Development

- `<leader>gtj` - Add JSON struct tags
- `<leader>gte` - Generate if err block
- `<leader>tt` - Run tests

## 🛠️ Troubleshooting

- **Performance issues**: All optimizations applied - should be instant
- **Missing dependencies**: Run `./setup.sh` or see [SETUP.md](.docs/SETUP.md)
- **Keybinding conflicts**: See [GUIDE.md](./docs/GUIDE.md) for full reference
- **Plugin issues**: Use `:checkhealth` and `:Lazy`

______________________________________________________________________

**💡 Pro Tip**: Start with `<leader>ch` (cheatsheet) and `s` + two characters for navigation - these alone will transform your workflow!

