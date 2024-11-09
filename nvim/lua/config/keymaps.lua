local keymap = vim.keymap
local opts = { noremap = true, silent = true}

keymap.set("n", "x", "_x") -- to avoid saving individual keys that i delete

-- Tabs
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Move window
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-l>", "<C-w>l")

-- Resize window
-- keymap.set("n", "<C-S-h>", "<C-w><")
-- keymap.set("n", "<C-S-l>", "<C-w>>")
-- keymap.set("n", "<C-S-k>", "<C-w>+")
-- keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics 
keymap.set("n", "<C-j>", function ()
  vim.diagnostic.goto_next()
end, opts)
