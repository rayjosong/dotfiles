vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- focus stays on half the page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- yank stuff into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", {})

vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.scrolloff = 10
vim.opt.inccommand = "split"
vim.opt.smarttab = true
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.wrap = false
vim.opt.backspace = {"start", "eol", "indent"}
vim.opt.path:append({"**"})
vim.opt.wildignore:append({"*/node_modules/*"})
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"

vim.opt.formatoptions:append({"r"})

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive 

vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

vim.opt.clipboard:append("unnamedplus") -- use system clipboard as defualt register
