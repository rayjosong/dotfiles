# LazyVim Migration Guide: From NvChad to LazyVim

## Executive Summary

This guide provides a comprehensive roadmap for migrating from your current **NvChad-based** Neovim configuration to a **LazyVim-from-scratch** setup while preserving all your essential workflows. Your current setup is highly sophisticated with deep Go development integration, extensive GitHub tooling, and advanced testing capabilities.

## Current Configuration Analysis

### What You Have (NvChad-based)
- **Framework**: NvChad v2.0 with base46 theming system
- **Primary Focus**: Go development with extensive tooling
- **Key Workflows**: GitHub integration, advanced testing, tmux navigation
- **Plugin Count**: ~40+ plugins including many specialized tools
- **Theme**: Catppuccin with custom UI components

### What You're Moving To (LazyVim-based)
- **Framework**: LazyVim with modular extras system
- **Philosophy**: More opinionated defaults, less customization needed
- **Plugin Management**: Lazy.nvim (same as current)
- **Extensibility**: Clean override system with extras

---

## Migration Strategy

### Phase 1: LazyVim Starter Setup

#### 1.1 Initial LazyVim Installation
```bash
# Backup current config
mv ~/.config/nvim ~/.config/nvim-nvchad-backup

# Clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
cd ~/.config/nvim
rm -rf .git
```

#### 1.2 Core LazyVim Structure Understanding
```
~/.config/nvim/
├── init.lua                 # LazyVim bootstrap
├── lazy-lock.json          # Plugin versions (similar to current)
├── lua/
│   ├── config/
│   │   ├── autocmds.lua    # Auto commands
│   │   ├── keymaps.lua     # Global keymaps
│   │   ├── lazy.lua        # Lazy.nvim setup
│   │   └── options.lua     # Vim options
│   └── plugins/            # Plugin specifications
│       ├── example.lua     # Example plugin config
│       └── ...
```

### Phase 2: Core LazyVim Extras Setup

#### 2.1 Enable Essential LazyVim Extras
Edit `lua/config/lazy.lua` to include these extras:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    
    -- Essential extras for your workflow
    { import = "lazyvim.plugins.extras.lang.go" },           -- Go support
    { import = "lazyvim.plugins.extras.lang.typescript" },  -- TS/JS support  
    { import = "lazyvim.plugins.extras.lang.python" },      -- Python support
    { import = "lazyvim.plugins.extras.lang.markdown" },    -- Markdown support
    { import = "lazyvim.plugins.extras.test.core" },        -- Testing framework
    { import = "lazyvim.plugins.extras.dap.core" },         -- Debug support
    { import = "lazyvim.plugins.extras.coding.copilot" },   -- If you use Copilot
    { import = "lazyvim.plugins.extras.ui.mini-animate" },  -- Animations
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" }, -- Better highlighting
    
    -- Your custom plugins
    { import = "plugins" },
  },
})
```

#### 2.2 What LazyVim Gives You Out of the Box
**Already Included** (no custom config needed):
- ✅ **LSP**: nvim-lspconfig with mason
- ✅ **Completion**: nvim-cmp with good defaults
- ✅ **File Explorer**: neo-tree (similar to nvim-tree)
- ✅ **Fuzzy Finder**: telescope with good presets
- ✅ **Git Integration**: gitsigns, LazyGit integration
- ✅ **Syntax Highlighting**: treesitter with good defaults
- ✅ **Terminal**: toggleterm
- ✅ **Notifications**: nvim-notify
- ✅ **Which-key**: keybinding help
- ✅ **Auto-pairs**: mini.pairs
- ✅ **Commenting**: mini.comment
- ✅ **Surround**: mini.surround (replaces nvim-surround)

---

## Phase 3: Replicating Your Custom Plugins

### 3.1 Essential Custom Plugins to Add

Create `lua/plugins/go-development.lua`:
```lua
return {
  -- Go debugging (LazyVim's go extra includes nvim-dap-go)
  {
    "leoluz/nvim-dap-go",
    opts = {},
  },
  
  -- Go utilities - your current favorite
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    opts = {},
    keys = {
      { "<leader>gsj", "<cmd>GoTagAdd json<cr>", desc = "Add JSON struct tags" },
      { "<leader>gie", "<cmd>GoIfErr<cr>", desc = "Generate if err block" },
    },
  },
  
  -- Enhanced testing (beyond LazyVim's test extra)
  {
    "nvim-neotest/neotest-go",
    dependencies = { "nvim-neotest/neotest" },
    opts = {},
  },
}
```

Create `lua/plugins/github-integration.lua`:
```lua
return {
  -- Git blame inline
  {
    "f-person/git-blame.nvim",  -- More maintained than APZelos/blamer.nvim
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = " <summary> • <date> • <author>",
      date_format = "%m-%d-%Y %H:%M:%S",
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame" },
    },
  },
  
  -- GitHub integration - choose one or both
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      { "<leader>gpr", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gis", "<cmd>Octo issue list<cr>", desc = "List issues" },
    },
  },
  
  -- Git link generation
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", desc = "Copy git link" },
      { "<leader>gy", "<cmd>lua require('gitlinker').get_buf_range_url('v')<cr>", mode = "v", desc = "Copy git link" },
    },
  },
}
```

Create `lua/plugins/productivity.lua`:
```lua
return {
  -- Tmux navigation (essential for your workflow)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown", 
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  
  -- Window maximizer
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<cr>", desc = "Maximize window" },
    },
  },
  
  -- Multi-cursor support
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
  
  -- Todo comments (LazyVim might include this)
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },
}
```

Create `lua/plugins/markdown-obsidian.lua`:
```lua
return {
  -- Obsidian integration
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/obsidian-vault",  -- Adjust to your vault path
        },
      },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert template" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
    },
  },
  
  -- Better markdown bullets
  {
    "bullets-vim/bullets.vim",
    ft = "markdown",
  },
  
  -- Table of contents generation
  {
    "richardbizik/nvim-toc",
    ft = "markdown",
    opts = {
      toc_header = "Table of Contents",
    },
    keys = {
      { "<leader>toc", function() require("nvim-toc").generate_md_toc("list") end, desc = "Generate TOC" },
    },
  },
}
```

### 3.2 Snacks.nvim Integration (Optional but Recommended)

Create `lua/plugins/snacks-integration.lua`:
```lua
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable specific snacks features that enhance your workflow
      bigfile = { enabled = true },        -- Handle large files better
      notifier = { enabled = true },       -- Better notifications
      quickfile = { enabled = true },      -- Fast file operations
      statuscolumn = { enabled = true },   -- Enhanced status column
      words = { enabled = true },          -- Highlight word under cursor
      styles = {
        notification = {
          wo = { wrap = true },
          border = "rounded",
        },
      },
    },
    keys = {
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git blame line" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit current file history" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit log (cwd)" },
      { "<leader>cR", function() Snacks.rename() end, desc = "Rename file" },
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle terminal" },
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference" },
    },
  },
}
```

---

## Phase 4: Customization and Theming

### 4.1 Catppuccin Theme Setup

Create `lua/plugins/theme.lua`:
```lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { 
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true,
        -- Add other integrations as needed
      },
    },
  },
  
  -- Configure LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
```

### 4.2 Custom Options and Keymaps

Edit `lua/config/options.lua` to add your preferences:
```lua
-- LazyVim provides good defaults, add your customizations here
local opt = vim.opt

-- Your custom options
opt.clipboard = "unnamedplus"  -- System clipboard integration
opt.relativenumber = true      -- Relative line numbers
opt.wrap = false               -- No line wrapping
opt.scrolloff = 8              -- Keep 8 lines above/below cursor

-- Go-specific options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    opt.tabstop = 4
    opt.shiftwidth = 4
    opt.softtabstop = 4
    opt.expandtab = false
  end,
})
```

Edit `lua/config/keymaps.lua` for custom keybindings:
```lua
-- LazyVim provides good defaults, add your custom ones here
local map = vim.keymap.set

-- Your current favorite keybindings that aren't covered by plugins
map("n", "<tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Custom go keybindings (if not covered by gopher.nvim)
map("n", "<leader>gor", ":GoRun<CR>", { desc = "Go run" })

-- Additional custom mappings as needed
```

---

## Phase 5: Migration Workflow

### 5.1 Step-by-Step Migration Process

1. **Week 1: Setup and Core Features**
   - Install LazyVim starter
   - Enable core extras (Go, TypeScript, Testing, DAP)
   - Test basic functionality
   - Add essential productivity plugins (tmux-navigator, maximizer)

2. **Week 2: Development Workflow**
   - Add Go-specific plugins (gopher.nvim)
   - Configure testing with neotest
   - Setup debugging workflow
   - Verify LSP and completion work correctly

3. **Week 3: GitHub Integration**
   - Add GitHub plugins (octo.nvim, gitlinker)
   - Configure git blame and workflow
   - Test PR/issue management
   - Setup custom keybindings

4. **Week 4: Polish and Obsidian**
   - Add Obsidian integration
   - Configure markdown workflow
   - Add any missing productivity features
   - Fine-tune theming and UI

5. **Week 5: Advanced Features**
   - Add snacks.nvim if desired
   - Configure advanced testing features
   - Add any specialized plugins you miss
   - Optimize performance

### 5.2 Testing Your Migration

Create a test checklist:

#### Core Development
- [ ] Go LSP working (gopls)
- [ ] Code completion functional
- [ ] File navigation with telescope
- [ ] Git integration working
- [ ] Debugging with DAP

#### Go Workflow
- [ ] `<leader>gsj` adds JSON tags
- [ ] `<leader>gie` generates if err blocks
- [ ] Go debugging works
- [ ] Test running with neotest

#### GitHub Workflow  
- [ ] `<leader>gg` opens LazyGit
- [ ] `<leader>gb` shows git blame
- [ ] `<leader>gy` copies git links
- [ ] octo.nvim commands work

#### Productivity
- [ ] `<C-h/j/k/l>` tmux navigation
- [ ] `<leader>sm` window maximizing
- [ ] Multi-cursor functionality
- [ ] Todo comment navigation

#### Obsidian/Markdown
- [ ] Obsidian note creation
- [ ] Markdown TOC generation
- [ ] Better bullet handling

---

## Phase 6: Advanced Optimizations

### 6.1 Performance Considerations

LazyVim is already optimized, but you can enhance:

```lua
-- In lua/config/lazy.lua
require("lazy").setup({
  -- ... your config
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin", 
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
```

### 6.2 Custom Extras Creation

If you want to bundle your Go workflow, create `lua/plugins/extras/lang/go-advanced.lua`:

```lua
return {
  -- Your complete Go setup as a reusable extra
  {
    "olexsmir/gopher.nvim",
    -- ... config
  },
  {
    "leoluz/nvim-dap-go", 
    -- ... config
  },
  -- etc.
}
```

---

## Comparison: NvChad vs LazyVim

| Aspect | NvChad (Current) | LazyVim (Target) |
|--------|------------------|------------------|
| **Philosophy** | Customizable base with overrides | Opinionated defaults with extras |
| **Configuration** | More manual setup required | More automated with sensible defaults |
| **UI** | Custom base46 theming system | Standard plugin-based theming |
| **Plugin Management** | Manual plugin declarations | Extras system + custom plugins |
| **Learning Curve** | Steeper, more config needed | Gentler, works out of the box |
| **Flexibility** | Very flexible, requires more work | Flexible where it matters, opinionated elsewhere |
| **Community** | NvChad-specific patterns | Broader Neovim community patterns |
| **Maintenance** | More manual updates | More automated with extras |

---

## Conclusion and Recommendations

### Recommended Approach: Gradual Migration

1. **Start Simple**: Use LazyVim starter with essential extras
2. **Add Gradually**: Migrate one workflow at a time (Go → GitHub → Obsidian)
3. **Test Thoroughly**: Ensure each workflow works before adding the next
4. **Leverage LazyVim**: Use built-in extras where possible, custom plugins where needed
5. **Consider Snacks**: Add snacks.nvim for enhanced productivity features

### Key Benefits of Migration

- **Less Configuration**: LazyVim provides better defaults
- **Better Maintenance**: Extras system handles updates automatically
- **Broader Community**: More standard patterns, easier to get help
- **Modern Architecture**: Built around lazy.nvim best practices
- **Extensibility**: Easy to add/remove functionality

### What You'll Miss from NvChad

- **Custom UI Components**: LazyVim uses standard plugins for UI
- **Base46 Theming**: Need to configure themes manually
- **NvTerm**: LazyVim uses toggleterm (similar functionality)
- **Some Convenience Features**: May need to add manually

### Final Migration Timeline

- **Total Time**: 3-4 weeks for complete migration
- **Usable After**: 1 week (basic functionality)
- **Full Workflow**: 2-3 weeks (all custom features)
- **Polish**: 4 weeks (optimization and fine-tuning)

This migration will result in a more maintainable, community-standard setup while preserving all your essential workflows and productivity features.