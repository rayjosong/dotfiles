-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Leader keys (matching your NvChad setup)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Theme preference (matching your catppuccin setup)
vim.g.lazyvim_colorscheme = "catppuccin"

-- Custom vim options (preserving your NvChad preferences)
local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Indentation
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- UI and Display Responsiveness
opt.wrap = true -- Enable wrapping by default for better screen responsiveness
opt.linebreak = true -- Break lines at word boundaries when wrap is enabled
opt.breakindent = true -- Maintain indentation for wrapped lines
opt.showbreak = "↪ " -- Visual indicator for wrapped lines
opt.cursorline = true
opt.termguicolors = true

-- Smart cursor movement and navigation
opt.startofline = false -- Keep cursor column when moving between lines
opt.whichwrap = "b,s,<,>,[,]" -- Allow cursor to wrap between lines with arrow keys

-- Viewport Management for Better Screen Responsiveness
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
opt.sidescroll = 1 -- Smooth horizontal scrolling

-- Optional: Visual line length guides (can be toggled)
opt.textwidth = 0 -- No automatic line breaking (manual control)
opt.colorcolumn = "" -- No column guide by default (can be toggled)

-- System clipboard integration (from your NvChad core/init.lua)
opt.clipboard = "unnamedplus"

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Completion - fix text replacement behavior
opt.completeopt = { "menu", "menuone", "noselect" }

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Aggressive performance optimizations to eliminate lag
opt.updatetime = 100 -- Faster completion (was 50, increase slightly for stability)
opt.timeoutlen = 200 -- Even faster which-key popup
opt.ttimeoutlen = 0 -- Instant escape sequences
opt.redrawtime = 1000 -- Faster syntax highlighting timeout
opt.lazyredraw = false -- Keep disabled for responsiveness
opt.ttyfast = true -- Fast terminal connection

-- Text rendering performance
opt.synmaxcol = 160 -- Limit syntax highlighting on long lines
opt.regexpengine = 1 -- Use faster regex engine
opt.scrolljump = 8 -- Scroll more lines at once
opt.maxmempattern = 1000 -- Limit pattern memory

-- Disable expensive features for performance
opt.cursorcolumn = false -- Disable cursor column highlighting
-- Note: relativenumber is already set to true above (line 16) for productivity
opt.foldmethod = "manual" -- Disable automatic folding

-- File handling performance
opt.swapfile = false -- Already disabled, but ensuring
opt.backup = false -- Already disabled
opt.writebackup = false -- Already disabled
opt.undofile = true -- Keep undo history but ensure it's enabled

-- Search performance
opt.hlsearch = true -- Keep search highlighting
opt.incsearch = true -- Show search results as you type
