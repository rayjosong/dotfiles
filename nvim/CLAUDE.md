# Neovim Configuration - NvChad Based Setup

## Overview
This is a professional Neovim configuration built on **NvChad v2.0** framework, heavily customized for **Go development**, **GitHub integration**, and **productivity workflows**. It's designed for developers who work extensively with Go, need advanced testing capabilities, and require seamless Git/GitHub workflows.

## Architecture

### Core Structure
```
nvim/
├── init.lua                 # Entry point, bootstraps NvChad
├── lua/
│   ├── core/               # NvChad core files
│   │   ├── init.lua        # Main configuration & options
│   │   ├── mappings.lua    # Default keybindings
│   │   ├── bootstrap.lua   # Lazy.nvim setup
│   │   ├── default_config.lua
│   │   └── utils.lua
│   ├── plugins/            # Default NvChad plugins
│   │   ├── init.lua        # Plugin loading logic
│   │   ├── configs/        # Plugin configurations
│   │   └── theme-catppuccin.lua
│   └── custom/             # User customizations
│       ├── chadrc.lua      # Main NvChad config override
│       ├── plugins.lua     # Custom plugin definitions
│       ├── mappings.lua    # Custom keybindings
│       └── configs/        # Custom plugin configurations
└── lazy-lock.json          # Plugin version lockfile
```

## Key Features

### 1. Development Focus
- **Primary Language**: Go (with extensive tooling)
- **Secondary**: TypeScript/JavaScript, Python, Lua, Markdown
- **LSP Integration**: Full language server support with nvim-lspconfig
- **Debugging**: DAP integration for Go debugging
- **Testing**: Advanced test runner with neotest

### 2. Git/GitHub Workflow
- **LazyGit Integration**: Full-screen git interface (`<leader>gg`)
- **GitHub Integration**: Two complementary tools:
  - `octo.nvim`: Issues, PRs, reviews
  - `gh.nvim`: GitHub CLI integration
- **Git Utilities**:
  - `gitlinker.nvim`: Generate GitHub permalinks
  - `blamer.nvim`: Inline git blame
  - Enhanced gitsigns for hunk navigation

### 3. UI/UX Enhancements
- **Theme**: Catppuccin with NvChad's base46 theming system
- **Notifications**: nvim-notify with opacity settings
- **Enhanced UI**: noice.nvim for better command line/messages
- **Status Line**: NvChad's custom statusline
- **File Explorer**: nvim-tree with custom configurations

## Core Workflows

### Go Development
- **Language Server**: gopls with goimports, gofumpt
- **Debugging**: nvim-dap-go for test debugging
- **Utilities**: gopher.nvim for struct tags, error handling
- **Testing**: neotest-go integration for advanced test running

#### Key Go Mappings:
- `<leader>gsj`: Add JSON struct tags
- `<leader>gie`: Generate if err block
- `<leader>dgt`: Debug Go test
- `<leader>tt`: Run test file
- `<leader>tr`: Run nearest test

### Git Workflow
- `<leader>gg`: Open LazyGit
- `<leader>gb`: Git blame line
- `<leader>gy`: Copy git permalink
- `]c` / `[c`: Navigate git hunks
- `<leader>ph`: Preview hunk

### Testing Workflow
- `<leader>tt`: Run current test file
- `<leader>tT`: Run all tests
- `<leader>tr`: Run nearest test
- `<leader>ts`: Toggle test summary
- `<leader>to`: Show test output

### Navigation & Productivity
- **Tmux Integration**: Seamless pane navigation with vim-tmux-navigator
- **Window Management**: vim-maximizer for focus mode
- **Multi-cursor**: vim-visual-multi for efficient editing
- **Surround**: nvim-surround for text object manipulation

## Custom Keybindings

### Leader Key: `<Space>`

#### File Operations
- `<leader>ff`: Find files (Telescope)
- `<leader>fw`: Live grep
- `<leader>fb`: Find buffers
- `<leader>e`: Focus file tree

#### Development
- `<leader>fm`: Format buffer (LSP)
- `<leader>ca`: Code actions
- `<leader>ra`: Rename symbol

#### Git
- `<leader>gg`: LazyGit
- `<leader>gb`: Git blame
- `<leader>cm`: Git commits (Telescope)
- `<leader>gt`: Git status (Telescope)

#### Testing
- `<leader>t*`: Various test operations (see Testing Workflow above)

#### Window/Buffer Management
- `<C-h/j/k/l>`: Navigate panes (works with tmux)
- `<leader>sm`: Maximize window toggle
- `<Tab>` / `<S-Tab>`: Next/prev buffer
- `<leader>x`: Close buffer

## Plugin Categories

### Core NvChad Plugins
- **Base46**: Theming system
- **NvChad UI**: Custom UI components
- **nvterm**: Terminal integration
- **Telescope**: Fuzzy finder
- **nvim-tree**: File explorer
- **Treesitter**: Syntax highlighting
- **LSP Config**: Language server integration

### Development Tools
- **Mason**: LSP/tool installer
- **nvim-cmp**: Autocompletion
- **LuaSnip**: Snippet engine
- **nvim-autopairs**: Auto-pairing brackets
- **Comment.nvim**: Smart commenting

### Custom Additions
See `nvim-plugins-analysis.md` for detailed breakdown of non-standard plugins.

## Configuration Philosophy

### Design Principles
1. **Workflow-Centric**: Built around actual development workflows
2. **Go-First**: Optimized for Go development but supports multiple languages
3. **Git-Integrated**: Deep GitHub/Git integration for modern development
4. **Productivity-Focused**: Tools that enhance daily productivity
5. **Consistent**: Follows NvChad conventions and patterns

### Customization Strategy
- **Override, Don't Replace**: Uses NvChad's override system
- **Modular**: Custom configs separated by functionality
- **Documented**: Keybindings are self-documenting via which-key

## File Locations

### Key Configuration Files
- `lua/custom/chadrc.lua:5` - Main theme configuration (Catppuccin)
- `lua/custom/plugins.lua` - All custom plugin definitions
- `lua/custom/mappings.lua` - Custom keybinding definitions
- `lua/core/init.lua:26-28` - System clipboard integration
- `lua/core/init.lua:51-53` - Line number configuration

### Custom Plugin Configs
- `lua/custom/configs/obsidian.lua` - Obsidian vault integration
- `lua/custom/configs/neotest.lua` - Test runner configuration  
- `lua/custom/configs/lspconfig.lua` - Language server overrides
- `lua/custom/configs/noice.lua` - UI enhancement settings

## Usage Notes

### Getting Started
1. **Dependencies**: Requires recent Neovim (>= 0.9.0)
2. **External Tools**: LazyGit, Go tools, GitHub CLI recommended
3. **First Run**: Run `:MasonInstallAll` to install language servers

### Maintenance
- **Updates**: Use `:NvChadUpdate` for framework updates
- **Plugin Management**: Lazy.nvim handles plugin management
- **Lock File**: `lazy-lock.json` ensures reproducible installs

### Customization
- Add plugins in `lua/custom/plugins.lua`
- Add keybindings in `lua/custom/mappings.lua`
- Override UI settings in `lua/custom/chadrc.lua`

## Performance Considerations
- **Lazy Loading**: Most plugins are lazy-loaded for fast startup
- **File Type Specific**: Many plugins only load for relevant file types
- **Conditional Loading**: Go tools only load for Go files
- **Optimized**: NvChad's optimizations for fast performance

This configuration represents a mature, production-ready Neovim setup optimized for professional Go development with excellent Git integration and productivity enhancements.