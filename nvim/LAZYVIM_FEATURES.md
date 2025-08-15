# 🚀 LazyVim New Features Quick Reference

## 🔥 Must-Try Features (Start Here!)

### **Flash Navigation** 
- `s` + two chars → Jump anywhere instantly
- `S` → Jump to line starts  
- Try it now: `s` + `fu` to jump to "function"

### **Mini.ai Text Objects**
- `vii` → Select inside indent (game changer!)
- `via` → Select around indent
- `val` → Select around last object
- Try it now: `vii` on any indented code

### **Trouble Diagnostics** 
- `<leader>xx` → View all diagnostics
- `<leader>cs` → Symbol overview
- `]d` / `[d` → Navigate diagnostics

### **Enhanced Git**
- `]h` / `[h` → Next/prev git hunk
- `<leader>hp` → Preview hunk
- `<leader>hs` → Stage hunk

## 🎯 Key Discoveries

### **Buffer Management** 
- `<Tab>` → Next buffer ✅ FIXED!
- `<S-Tab>` → Previous buffer ✅ FIXED!
- `<leader>,` → Buffer picker (fuzzy search) - Press and type to search!
- `<leader>fr` → Recent files (NEW!)
- `H` → Previous buffer (LazyVim default)
- `L` → Next buffer (LazyVim default)

### **File Explorer Navigation**
- `<leader>e` → Toggle file explorer
- `<leader>E` → File explorer (root dir)
- `<C-w>w` → Switch between editor and explorer
- `<C-w>h` → Move to left window (explorer)
- `<C-w>l` → Move to right window (editor)

### **Tmux Integration** 
- `<C-h>` → Navigate left (tmux/vim)
- `<C-j>` → Navigate down (tmux/vim)  
- `<C-k>` → Navigate up (tmux/vim)
- `<C-l>` → Navigate right (tmux/vim)
- **Note**: Requires tmux plugin and proper config

### **Session Management** 
- `<leader>qs` → Save session (NEW!)
- `<leader>ql` → Load session (NEW!)

### **UI Toggles**
- `<leader>ur` → Toggle relative numbers
- `<leader>uw` → Toggle word wrap
- `<leader>us` → Toggle spelling

## 🧹 Cleaned Up

### Removed (LazyVim provides better):
- ❌ nvim-surround → ✅ mini.surround 
- ❌ todo-comments → ✅ Built-in
- ❌ nvim-notify → ✅ Built-in
- ❌ noice.nvim → ✅ Built-in
- ❌ which-key → ✅ Built-in
- ❌ lualine → ✅ Built-in

### Kept (unique to your workflow):
- ✅ tmux-navigator
- ✅ vim-maximizer  
- ✅ vim-visual-multi
- ✅ Go development stack
- ✅ Git workflow tools
- ✅ Obsidian integration

## 🎓 Learning Plan

### Week 1: Master Flash + Mini.ai
### Week 2: Git workflow + Sessions  
### Week 3: Replace old habits with mini.nvim

**Start with**: Try `s` for navigation and `vii` for text selection!

## 🔧 Common Issues & Solutions

### **Tmux Navigation Fixed!** ✅
Fixed the "E492: Not an editor command: TmuxNavigateRight" error by properly configuring lazy loading:

1. **Issue**: Plugin commands weren't loaded due to conflicting keymaps
2. **Fix**: Added `cmd` lazy loading triggers + removed duplicate keymaps
3. **Result**: ✅ Commands now load properly when needed

**How to use**:
- `<C-h/j/k/l>` → Navigate between tmux panes AND vim windows seamlessly
- Works in both directions (tmux → vim, vim → tmux)
- Commands: TmuxNavigateLeft, TmuxNavigateDown, TmuxNavigateUp, TmuxNavigateRight

### **Performance Issues COMPLETELY FIXED!** ⚡
Aggressive performance optimization - eliminated ALL lag sources:

1. **Markdown Linting**: COMPLETELY DISABLED (was causing hundreds of warnings) ✅
2. **Animation Lag**: Disabled `mini-animate` causing GG/gg movement lag ✅
3. **Vim Options**: Aggressive tuning (timeoutlen=200, ttimeoutlen=0) ✅
4. **Disabled Features**: Relative numbers, indent scope, word illumination ✅
5. **LSP Optimization**: Reduced gopls analysis, disabled signatures/hover ✅
6. **Treesitter**: Disabled for large files, removed vim regex highlighting ✅
7. **Plugin Performance**: Debounced gitsigns, optimized which-key ✅
8. **Completion**: Added debouncing and throttling to nvim-cmp ✅
9. **Result**: ✅ ZERO lag - instant responsiveness achieved!

### **How to Use Buffer Picker** 🔍
**`<leader>,` → Opens fuzzy search buffer picker**

**How it works**:
1. Press `<leader>,` (space + comma)
2. A popup shows all open buffers
3. Type part of filename to filter (e.g., "read" finds "README.md")
4. Use `↑↓` arrows or `<C-j>/<C-k>` to navigate
5. Press `<Enter>` to switch to selected buffer
6. Press `<Esc>` to cancel

**Example**: `<leader>,` → type "conf" → finds "config.lua" → Enter

### **All Buffer Navigation Options** ✅
- `<Tab>` → Next buffer (FIXED!)
- `<S-Tab>` → Previous buffer (FIXED!)
- `H` / `L` → Previous/Next buffer (LazyVim default)
- `<leader>,` → Buffer picker (fuzzy search) 
- `<C-w>w` → Cycle between windows
- `<C-w>h/j/k/l` → Navigate to specific window direction

### **Buffer Management (Close/Delete)** 🗑️
- `<leader>bd` → Delete current buffer (LazyVim default) 🔥
- `<leader>bD` → Delete current buffer (force)
- `<leader>bo` → Close all other buffers (only keep current)
- `<leader>bA` → Close all buffers
- `<leader>bl` → Close buffers to the left
- `<leader>br` → Close buffers to the right
- `:bd` → Close current buffer (vim command)
- `:bw` → Wipe buffer completely

### **Global Word Search** 🔍 ✅ FIXED & WORKING
- `<leader>fg` → Live grep (search content across all files) 🔥 **MAIN GLOBAL SEARCH**
- `<leader>fw` → Search current word under cursor globally ✅ **FIXED!**
- `<leader>ff` → Find files by name (fuzzy finder)
- `<leader>fb` → Find open buffers
- `<leader>fr` → Recent files
- `<leader>fc` → Search commands
- `<leader>fh` → Search help tags  
- `<leader>fk` → Search keymaps
- `<leader>fs` → Document symbols (current file)
- `<leader>fS` → Workspace symbols (all files)

**How to use `<leader>fw`**: Put cursor on any word → Press `<leader>fw` → Search globally

### **File Explorer (Neo-tree)** 📁
- `<leader>e` → Toggle neo-tree on left
- `<leader>E` → Neo-tree in root directory
- **Search functionality working** ✅ (fd and ripgrep installed & configured)
- **Visual search bar hidden** ✅ (no header input field cluttering the view)
- **Clean minimal interface** ✅ (functionality preserved, visual noise removed)
- **Search commands**: `/` fuzzy find files, `#` fuzzy find directories, `<C-x>` clear filter
- **Dependencies**: fd (file finder) and ripgrep (text search) installed via Homebrew
- **Inside neo-tree**: `?` to see all commands
- **Quick switch**: `<C-w>w` or `<C-w>h/l` to move between explorer and editor
- **Key mappings**: `a` add file, `A` add directory, `d` delete, `r` rename

### **Window Management** 🪟 ✨ FIXED!
- `<leader>z` → **TOGGLE** Zoom/Maximize window (press once=maximize, press again=restore) 🔥
- `<C-w>z` → Same toggle function (alternative key)
- `<leader>Z` → Toggle zoom (fallback if vim-maximizer fails, shows messages)
- `<leader>zr` → Force restore all windows to equal size 🔧
- `<C-w>w` → Cycle between windows
- `<C-w>h/j/k/l` → Navigate to specific window direction
- `<C-w>=` → Equalize window sizes manually

**How Zoom Toggle Works:**
1. **First press** `<leader>z` → Maximizes current window (fills entire screen)
2. **Second press** `<leader>z` → Restores original layout (all windows visible)
3. **If stuck**: Use `<leader>zr` to force restore all windows

### **Theme Management** 🎨
- `<leader>ct` → Quick theme switcher (Catppuccin variants) ✨ NEW!
- **Current**: Catppuccin (excellent choice for Go development)
- **Variants**: Latte (light), Frappé, Macchiato, Mocha (dark)
- **Guide**: See `LAZYVIM_THEMES.md` for comprehensive theme information
- **Quick test**: `:colorscheme catppuccin-latte` for light mode

### **Portable Setup** 📦 ✨ NEW!
- `./setup.sh` → Automated dependency installation for new machines
- `./check-deps.sh` → Check what dependencies are missing
- **Fallback support**: Config works even with missing tools (degrades gracefully)
- **Cross-platform**: Supports macOS (Homebrew), Ubuntu, Fedora, RHEL
- **Documentation**: See `SETUP.md` for comprehensive setup guide
- **Dependencies**: fd, ripgrep, Go tools, optional tools auto-detected and installed