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

## 🚨 Quick Troubleshooting

### **Common Issues**
- **Flash not working**: Make sure you're pressing `s` followed by exactly 2 characters
- **Tmux nav broken**: Check that tmux plugin is installed and configured
- **Buffer picker empty**: Use `<leader>ff` for file finder instead
- **AI not responding**: Check Avante plugin status with `:Lazy`

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