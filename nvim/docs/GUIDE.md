# 📖 Daily Usage Guide

Essential workflows and keybindings for your LazyVim configuration.

## 🎯 Getting Started

### **First Steps**
1. **Help System**: `<leader>ch` - Interactive cheatsheet (main help) 
2. **Flash Navigation**: `s` + two chars - Jump anywhere instantly
3. **File Explorer**: `<leader>e` - Toggle file tree

### **Core Navigation**
- `<leader>ff` - Find files (fuzzy search)
- `<leader>fg` - Global text search (ripgrep)
- `<leader>fb` - Find buffers
- `<leader>fr` - Recent files
- `<leader>,` - Buffer picker (fuzzy search)

## 🚀 Essential Workflows

### **Flash Navigation** (Game Changer!)
- `s` + two chars → Jump anywhere on screen instantly
- `S` → Jump to line starts
- `/` → Enhanced search with flash highlighting
- Replace traditional scrolling with flash jumps

### **Buffer Management**
- `<Tab>` / `<S-Tab>` - Next/previous buffer
- `H` / `L` - Previous/next buffer (LazyVim style) 
- `<leader>,` - Buffer picker (type to filter)
- `<leader>bd` - Delete current buffer

### **Window Management**
- `<leader>z` - **Toggle maximize window** (press again to restore)
- `<C-w>w` - Cycle between windows
- `<C-w>h/j/k/l` - Navigate to specific window direction

## 🔧 Go Development

### **Essential Go Keybindings**
- `<leader>gtj` - Add JSON struct tags
- `<leader>gte` - Generate if err block
- `<leader>dgt` - Debug Go test
- `<leader>dgl` - Debug last Go test

### **Testing Workflow**
- `<leader>tt` - Run current test file
- `<leader>tr` - Run nearest test
- `<leader>ts` - Toggle test summary
- `<leader>to` - Show test output

### **LSP & Code Actions**
- `gd` - Go to definition
- `gr` - References (Trouble)
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>cr` - Rename symbol

## 🐙 Git Workflow

### **Core Git Commands**
- `<leader>gg` - Open LazyGit (main git interface)
- `<leader>gb` - Git blame line
- `<leader>gy` - Copy git permalink
- `]h` / `[h` - Next/previous git hunk
- `<leader>ph` - Preview hunk

### **Enhanced Git Features**
- `<leader>gdo` - Open diff view for current changes
- `<leader>ghf` - File history (visual git log)
- `<leader>gxo` - Resolve merge conflicts

## 🧭 Code Navigation & Structure

### **Symbol Navigation (Aerial.nvim)**
- `<leader>ao` - Toggle code outline sidebar
- `<leader>ay` - Search symbols with Telescope
- `]]` / `[[` - Navigate between any symbols
- `]f` / `[f` - Navigate between functions
- `]m` / `[m` - Navigate between methods

### **Mini.ai Text Objects** (Powerful!)
- `vii` - Select inside indent (incredibly useful!)
- `via` - Select around indent
- `val` - Select around last text object
- `van` - Select around next text object

## 🤖 AI Assistant (Avante.nvim)

### **Core AI Commands**
- `<leader>aa` - Ask AI about current code/selection
- `<leader>ae` - Edit code with AI assistance
- `<leader>ac` - Add current buffer to AI context
- `<leader>at` - Toggle AI sidebar
- `<leader>af` - Focus AI sidebar

### **Context Management**
- `<leader>aB` - Add all open buffers to AI context
- `<leader>a+` - Add files from neo-tree to AI context
- `<leader>an` - Start new AI conversation

## 📝 Markdown & Obsidian

### **Obsidian Integration**
- `<leader>on` - New Obsidian note
- `<leader>ot` - Insert template
- `<leader>oo` - Open in Obsidian
- `<leader>mt` - Generate TOC

### **Markdown Preview**
- `<leader>mp` - Toggle markdown preview (mermaid support)
- `<leader>mm` - Open preview in browser
- `<leader>ms` - Stop markdown preview

## 🔍 Search & Discovery

### **Advanced Search**
- `<leader>fw` - Search current word globally
- `<leader>fs` - Document symbols (current file)
- `<leader>fS` - Workspace symbols (all files)
- `<leader>fc` - Search commands
- `<leader>fk` - Search keymaps

### **Diagnostics & Issues**
- `<leader>xx` - Diagnostics (Trouble)
- `<leader>xX` - Buffer diagnostics
- `]d` / `[d` - Next/previous diagnostic
- `<leader>cd` - Line diagnostics

## 🛠️ Productivity Features

### **Tmux Integration**
- `<C-h/j/k/l>` - Navigate between vim windows AND tmux panes
- Seamless navigation between terminal and editor

### **Multi-cursor Editing**
- Use vim-visual-multi for multiple cursor support
- Select text and create additional cursors

### **Marks System**
- `ma` - Set mark 'a' at current line
- `'a` - Jump to line with mark 'a'
- `dma` - Delete mark 'a' (intuitive!)
- `<leader>sm` - Show all marks

### **TODO Comments**
- `]t` / `[t` - Next/previous TODO comment
- `<leader>st` - Search TODOs with Telescope

## 🎨 UI Toggles

### **Quick Toggles**
- `<leader>ur` - Toggle relative numbers
- `<leader>uw` - Toggle word wrap
- `<leader>us` - Toggle spelling
- `<leader>uc` - Toggle conceallevel

### **Session Management**
- `<leader>qs` - Save session
- `<leader>ql` - Load last session
- `<leader>qd` - Delete session

## 🔧 Terminal Integration

### **Built-in Terminal**
- `<C-\>` - Quick toggle terminal
- `<leader>tf` - Float terminal
- `<leader>th` - Horizontal terminal
- `<leader>tv` - Vertical terminal

## 📚 Learning Tips

### **Discovery Tools**
- `<leader>ch` - **Main cheatsheet** (searchable, organized)
- `<leader>fk` - Search all keybindings
- Press `<leader>` and wait - See all leader key options
- `:Telescope keymaps` - Search all keybindings

### **Must-Try New Features**
1. **Flash Navigation**: `s` + two characters
2. **Mini.ai**: `vii` to select current indentation
3. **Buffer Picker**: `<leader>,` for quick buffer switching
4. **Code Outline**: `<leader>ao` for symbol navigation
5. **AI Assistant**: `<leader>aa` for code help

### **Performance Notes**
- Everything should be **instant** - zero lag optimizations applied
- If anything feels slow, it's likely a configuration issue
- Use `:checkhealth` to verify setup

## 🔌 Installing New Plugins

### **Method 1: Create New Plugin File (Recommended)**
Create a new `.lua` file in `lua/plugins/`:

```lua
-- lua/plugins/my-new-plugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",     -- Load after startup
    dependencies = {
      "required/dependency",
    },
    keys = {
      { "<leader>mp", "<cmd>MyPluginCommand<cr>", desc = "My Plugin" },
    },
    opts = {
      -- plugin configuration
    },
  },
}
```

### **Method 2: Add to Existing Plugin File**
Edit existing file like `lua/plugins/editor.lua`:

```lua
return {
  -- existing plugins...
  {
    "new/plugin-repo",
    config = function()
      require("plugin").setup({
        -- configuration here
      })
    end,
  },
}
```

### **Plugin Loading Strategies**
```lua
{
  "author/plugin",
  lazy = false,           -- Load immediately on startup
  event = "VeryLazy",     -- Load after UI is ready
  cmd = "PluginCommand",  -- Load when command is run
  keys = "<leader>p",     -- Load when key is pressed
  ft = { "go", "lua" },   -- Load for specific filetypes
  dependencies = {},      -- Required plugins
  priority = 1000,        -- Load order (higher = first)
}
```

### **Real Examples from This Config**

**UI Plugin with Keybindings:**
```lua
-- lua/plugins/aerial.lua (code outline)
return {
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    keys = {
      { "<leader>ao", "<cmd>AerialToggle<cr>", desc = "Toggle Outline" },
      { "<leader>ay", "<cmd>Telescope aerial<cr>", desc = "Search Symbols" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      layout = { default_direction = "right" },
      backends = { "lsp", "treesitter" },
    },
  },
}
```

**Theme Plugin:**
```lua
-- lua/plugins/catppuccin.lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,        -- Load immediately
    priority = 1000,     -- Load before other plugins
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = { telescope = true, mason = true },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
```

### **Plugin Management Commands**
```bash
# Check all plugins status:
:Lazy

# Update all plugins:
:Lazy update

# Install new plugins (after adding to config):
:Lazy install

# Remove unused plugins:
:Lazy clean

# View plugin startup performance:
:Lazy profile

# Debug plugin issues:
:Lazy log
```

### **Adding Keybindings**
When adding plugins, check for keymap conflicts:

```lua
-- In your plugin config
keys = {
  { "<leader>mp", "<cmd>PluginCommand<cr>", desc = "My Plugin Command" },
  { "<leader>mt", "<cmd>PluginToggle<cr>", desc = "Toggle Plugin" },
  -- Use descriptive names for which-key integration
},
```

**Check existing keymaps:**
- `<leader>fk` - Search all keybindings
- `<leader>ch` - Interactive cheatsheet

### **Installation Workflow**
1. **Research plugin** - Check GitHub, requirements, dependencies
2. **Create config file** in `lua/plugins/plugin-name.lua`
3. **Add keybindings** (check for conflicts with `<leader>fk`)
4. **Restart nvim** or run `:Lazy reload`
5. **Test functionality** and run `:checkhealth` if needed
6. **Update setup.sh** if manual installation is required

## ⚙️ Formatting & Auto-Save

This configuration uses `conform.nvim` to automatically format your code every time you save. The necessary formatting tools are managed by `mason.nvim`.

### **How It Works**
- **`conform.nvim`**: Runs the formatters on your code. Configured in `lua/plugins/editor.lua`.
- **`mason.nvim`**: Installs the command-line tools that do the actual formatting. Also configured in `lua/plugins/editor.lua`.

Format-on-save is **enabled by default** for all configured languages.

### **How to Add a New Formatter**

Here’s how to enable auto-formatting for a new language, using `stylua` for Lua as an example.

**Step 1: Find the Formatter Name**
First, identify the correct name for the formatter tool (e.g., `stylua`). You can search for supported formatters on the [`conform.nvim` docs](https://github.com/stevearc/conform.nvim/blob/master/doc/formatters.md) or see what's available in `:Mason`.

**Step 2: Add Formatter to Mason**
Open `lua/plugins/editor.lua` and add the formatter's name to the `ensure_installed` list inside the `mason.nvim` configuration.

```lua
-- lua/plugins/editor.lua
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- ... other tools
        "prettier",
        "black",
        "terraform_fmt",
        "stylua", -- <-- Add the new formatter here
      })
    end,
  },
```

**Step 3: Configure the Formatter**
In the same file (`lua/plugins/editor.lua`), add an entry for the new filetype in the `custom_formatters` table inside the `conform.nvim` configuration.

```lua
-- lua/plugins/editor.lua
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local custom_formatters = {
        -- ... other formatters
        typescript = { "prettier" },
        lua = { "stylua" }, -- <-- Add the new filetype and formatter here
      }
      
      for ft, formatters in pairs(custom_formatters) do
        opts.formatters_by_ft[ft] = formatters
      end
    end,
  },
```

**Step 4: Restart and Verify**
1. **Restart Neovim**.
2. Mason will automatically install `stylua`. You can check the status with `:Mason`.
3. Open a Lua file (`.lua`), make a change, and save it (`:w`). The code should auto-format.

This process works for any language. Just find the right tool and update these two sections!

## 🚨 Quick Troubleshooting

### **Common Issues**
- **Flash not working**: Make sure you're pressing `s` followed by exactly 2 characters
- **Tmux nav broken**: Check that tmux plugin is installed and configured
- **Buffer picker empty**: Use `<leader>ff` for file finder instead
- **AI not responding**: Check Avante plugin status with `:Lazy`
- **Plugin not loading**: Check `:Lazy` for errors, verify config syntax

### **Getting Help**
- `<leader>ch` - Interactive cheatsheet (main help system)
- `:checkhealth` - Verify installation health
- `:Lazy` - Check plugin status
- See [REFERENCE.md](./REFERENCE.md) for advanced troubleshooting

---

**💡 Pro Tips:**
- Master `s` for navigation and `vii` for text selection first
- Use `<leader>ch` whenever you forget a keybinding
- Try `<leader>,` for quick buffer switching - it's faster than Tab
- The AI assistant (`<leader>aa`) is incredibly helpful for understanding code