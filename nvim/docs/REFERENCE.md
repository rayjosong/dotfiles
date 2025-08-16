# 📚 Advanced Reference

Technical details, architecture, and advanced features for your LazyVim configuration.

## 🏗️ Architecture Overview

### **LazyVim Structure**
```
nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/             # Core configuration
│   │   ├── options.lua     # Vim options & theme preference
│   │   ├── keymaps.lua     # Global keybindings
│   │   ├── lazy.lua        # Plugin manager + language extras
│   │   └── autocmds.lua    # Autocommands
│   └── plugins/            # Plugin definitions
│       ├── catppuccin.lua  # Theme configuration
│       ├── go.lua          # Go development stack
│       ├── git.lua         # Git/GitHub integration
│       ├── aerial.lua      # Code outline & symbol navigation
│       ├── diffview.lua    # Enhanced git diff & merge tools
│       ├── editor.lua      # Editor enhancements
│       ├── ui.lua          # UI/UX improvements
│       ├── markdown.lua    # Markdown/Obsidian tools
│       └── avante.lua      # AI assistant (Cursor-like)
└── stylua.toml             # Lua formatting
```

### **Plugin Loading Strategy**
- **Priority 1000**: Themes and critical plugins (load first)
- **Priority 500**: Important plugins
- **Default priority**: Most plugins
- **Lazy = true**: Load on demand (keys, cmd, ft, event)

### **LazyVim Language Extras**
- `lazyvim.plugins.extras.lang.go` - Go development
- `lazyvim.plugins.extras.lang.typescript` - TypeScript/JavaScript
- `lazyvim.plugins.extras.lang.python` - Python support
- `lazyvim.plugins.extras.lang.markdown` - Markdown support
- `lazyvim.plugins.extras.test.core` - Testing framework
- `lazyvim.plugins.extras.dap.core` - Debug adapter protocol

## 🔧 Advanced Configuration

### **Plugin Configuration Patterns**

#### **Simple Configuration** (uses `opts`):
```lua
{
  "plugin/name",
  opts = {
    option1 = "value",
    option2 = true,
  }
}
```

#### **Complex Configuration** (uses `config`):
```lua
{
  "plugin/name",
  config = function()
    require("plugin").setup({
      -- configuration
    })
    -- additional setup
  end
}
```

#### **Lazy Loading with Keys**:
```lua
{
  "plugin/name",
  keys = {
    { "<leader>x", "<cmd>PluginCommand<cr>", desc = "Description" },
  },
  config = function()
    -- Plugin loads only when <leader>x is pressed
  end
}
```

### **Performance Optimizations Applied**

#### **Aggressive Performance Tuning**:
- ✅ Markdown linting completely disabled (was causing lag)
- ✅ Mini-animate disabled (was causing GG/gg movement lag)
- ✅ Vim options optimized (timeoutlen=200, ttimeoutlen=0)
- ✅ Relative numbers, indent scope, word illumination disabled
- ✅ LSP optimized (reduced gopls analysis, disabled signatures/hover)
- ✅ Treesitter disabled for large files
- ✅ Gitsigns debounced, which-key optimized
- ✅ Completion debounced and throttled

#### **Disabled Plugins** (for performance):
```lua
disabled_plugins = {
  "gzip", "matchit", "matchparen", "netrwPlugin",
  "tarPlugin", "tohtml", "tutor", "zipPlugin",
}
```

## 🎨 Theme System

### **Catppuccin Configuration**
Current theme with multiple variants:
- **Mocha** (dark) - Default
- **Latte** (light) - `:colorscheme catppuccin-latte`
- **Frappé** (dark warm) - `:colorscheme catppuccin-frappe`
- **Macchiato** (dark balanced) - `:colorscheme catppuccin-macchiato`

### **Theme Switcher**
- `<leader>ct` - Quick theme switcher (if configured)
- `:colorscheme catppuccin-latte` - Quick test light mode

### **Alternative Themes**
Recommended alternatives if you want to try something new:
1. **Tokyo Night** - Popular dark theme with purple/blue accents
2. **Rose Pine** - Elegant low-contrast theme
3. **Gruvbox** - Classic retro terminal feel
4. **Nord** - Arctic blue minimal theme

## 📍 Advanced Marks System

### **Mark Types & Usage**
- **Local marks** (a-z): Current buffer only
- **Global marks** (A-Z): Work across all files
- **Numbered marks** (0-9): Special positions

### **Intuitive Mark Management**
```
SET MARKS:           JUMP TO MARKS:       DELETE MARKS:
ma, mb, mc...        'a, 'b, 'c...       dma, dmb, dmc...
mA, mB, mC...        'A, 'B, 'C...       dmA, dmB, dmC...
m1, m2, m3...        '1, '2, '3...       dm1, dm2, dm3...

UTILITIES:
<leader>sm  → Show all marks
<leader>dm  → Delete all marks
:marks      → Show marks (vim command)
```

### **Advanced Mark Operations**
- `d'a` → Delete from current position to mark 'a'
- `y'a` → Yank from current position to mark 'a'
- `='a` → Auto-indent from current position to mark 'a'

## 🧭 Code Navigation Deep Dive

### **Aerial.nvim Symbol Navigation**
- **LSP-powered**: Accurate symbol detection via language servers
- **Go optimizations**: Enhanced symbol display with type information
- **Multi-language**: Go, TypeScript, Python, Lua support
- **Telescope integration**: Fuzzy search through code symbols

### **Enhanced Navigation Patterns**
- `]]` / `[[` - Navigate between any symbols
- `]f` / `[f` - Navigate between functions (optimized for Go)
- `]c` / `[c` - Navigate between structs/classes
- `]m` / `[m` - Navigate between methods

## 📊 Git Workflow Advanced

### **Diffview.nvim Features**
- **3-way merges**: Visual merge conflict resolution with base comparison
- **File history**: Browse complete git history with visual diffs
- **Branch comparison**: Compare any branches or commits visually
- **LazyGit integration**: Seamless workflow between diffview and lazygit

### **Merge Conflict Resolution**
- `<leader>co` - Choose OURS (current branch)
- `<leader>ct` - Choose THEIRS (incoming)
- `<leader>cb` - Choose BASE (merge base)
- `<leader>ca` - Choose ALL (keep both)
- `]x` / `[x` - Navigate between conflicts

### **Advanced Git Commands**
- `<leader>gdo` - Open visual diff for current changes
- `<leader>gdm` - Compare with any branch/commit
- `<leader>ghf` - Visual git history for current file
- `<leader>gxo` - Visual merge conflict resolution
- `<leader>gx3` - Three-way merge for current file
- `<leader>ghl` - Visual git log with diffs

## 🤖 AI Assistant Deep Dive

### **Avante.nvim (Cursor-like Integration)**
- **Claude Integration**: Direct integration with Anthropic's Claude
- **Context-aware**: Add files to AI context for better assistance
- **Code generation**: AI-powered suggestions and modifications

### **Advanced AI Workflows**
- `<leader>aa` - Ask AI about current code or selection
- `<leader>ae` - Edit current code with AI assistance
- `<leader>ac` - Add current buffer to AI context
- `<leader>aB` - Add all open buffers to AI context
- `<leader>a+` - Add files from neo-tree to AI context
- `<leader>an` - Start new AI conversation
- `<leader>a?` - Switch between AI models

## 🔧 Go Development Advanced

### **Complete Go Stack**
- **Language Server**: gopls with goimports, gofumpt
- **Debugging**: nvim-dap-go for test debugging
- **Utilities**: gopher.nvim for struct tags, error handling
- **Testing**: neotest-go integration for advanced test running

### **Go-Specific Optimizations**
- Enhanced symbol navigation for Go structs and methods
- Optimized LSP settings for large Go codebases
- Custom keybindings for Go-specific operations

### **Go Debugging Workflow**
- `<leader>dgt` - Debug Go test
- `<leader>dgl` - Debug last Go test
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue debugging
- `<leader>ds` - Step over
- `<leader>di` - Step into

## 📝 Markdown Advanced Features

### **Obsidian Integration**
- Complete workspace configuration preserved
- iCloud integration for cross-device sync
- Template system for note creation
- Seamless vault navigation

### **Mermaid Diagram Support**
- **Primary**: `<leader>mp` - markdown-preview.nvim (reliable)
- **Advanced**: `<leader>mP` - peek.nvim (requires Deno)
- **External**: View on GitHub for native rendering

### **Advanced Markdown Tools**
- `bullets.vim` - Enhanced bullet point handling
- `nvim-toc` - Automatic table of contents generation
- Enhanced folding and navigation

## 🛠️ Maintenance & Troubleshooting

### **Plugin Management**
- `:Lazy` - Plugin manager interface
- `:LazyExtras` - Available language extras
- `:Lazy update` - Update all plugins
- `:Lazy restore` - Revert to locked versions

### **System Health**
- `:checkhealth` - Comprehensive health check
- `:checkhealth mason` - Check language server installations
- `:LspInfo` - LSP server status
- `:Mason` - Language server installer

### **Performance Monitoring**
- `:Lazy profile` - Plugin loading performance
- Check startup time improvements
- Monitor memory usage

### **Configuration Validation**
Before making changes:
1. Run `:checkhealth` to verify no broken dependencies
2. Test all new keybindings in relevant file types
3. Verify LSP functionality with `:LspInfo`
4. Update cheatsheet with new features
5. Document breaking changes

## 📦 Dependencies & Setup

### **System Dependencies**
- **fd** - Fast file finder (telescope, neo-tree search)
- **ripgrep** - Fast text search (telescope live grep)
- **Git** - Version control
- **Node.js** - TypeScript/JavaScript LSP servers

### **Go Development Tools**
- **Go** - Language runtime
- **golangci-lint** - Go linter
- **goimports** - Import formatter
- **gofumpt** - Code formatter

### **Optional Tools**
- **lazygit** - Git TUI interface
- **gh** - GitHub CLI integration
- **deno** - For advanced markdown preview

### **Automated Installation**
- `./setup.sh` - Handles all dependencies automatically
- Cross-platform support (macOS, Ubuntu, Fedora, RHEL)
- Graceful degradation if tools are missing

## 🔄 Migration Benefits

### **LazyVim vs NvChad**
- **Performance**: 2-3x faster startup with optimized lazy loading
- **Maintainability**: Better organized plugin architecture
- **Community**: Larger LazyVim ecosystem and support
- **Features**: Modern tooling (conform.nvim, enhanced Trouble)
- **Updates**: Easier to stay current with developments

### **Preserved from Migration**
- ✅ All 40+ custom plugins with exact configurations
- ✅ Complete keybinding mappings (50+ custom shortcuts)
- ✅ Complex Obsidian workspace setup with iCloud integration
- ✅ Go development stack (debugging, testing, utilities)
- ✅ GitHub workflow integration (lazygit, octo, gh.nvim)
- ✅ Catppuccin theme with UI customizations

## 📚 Additional Resources

### **Documentation Strategy**
- **README.md** - Overview and navigation
- **SETUP.md** - Installation and dependencies
- **GUIDE.md** - Daily workflows and essential keybindings
- **REFERENCE.md** - This file - advanced features and technical details

### **Learning Resources**
- LazyVim documentation: https://lazyvim.github.io/
- Plugin-specific documentation in `:help` system
- Interactive cheatsheet: `<leader>ch`
- Keybinding discovery: `<leader>fk`

---

**💡 Advanced Tips:**
- Use `:LazyExtras` to discover new language support
- Profile performance with `:Lazy profile` if anything feels slow
- Leverage the extras system before adding custom plugins
- Keep configurations in version control with locked plugin versions