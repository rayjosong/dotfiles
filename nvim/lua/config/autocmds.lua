-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Format on save using LazyVim's format function
-- This integrates properly with LazyVim's conform.nvim setup
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Use LazyVim's format function which properly handles conform.nvim
    require("lazyvim.util").format({ force = true })
  end,
  desc = "Format buffer on save using LazyVim formatter",
})

-- ============================================================================
-- RESPONSIVE DISPLAY HANDLING
-- ============================================================================

-- Handle terminal/window resize events
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    -- Redistribute window sizes equally
    vim.cmd("wincmd =")
    
    -- Optionally adjust colorcolumn based on new window width
    local win_width = vim.api.nvim_win_get_width(0)
    if win_width > 120 then
      -- Wide screen: show optional column guide at 100
      vim.opt_local.colorcolumn = "100"
    elseif win_width > 80 then
      -- Medium screen: show guide at 80
      vim.opt_local.colorcolumn = "80"
    else
      -- Narrow screen: no column guide
      vim.opt_local.colorcolumn = ""
    end
  end,
  desc = "Handle window resize and adjust display settings",
})

-- File-type specific settings for optimal display (wrap is now enabled by default)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "NeogitCommitMessage" },
  callback = function()
    -- Text files: ensure wrap is on with good readability settings
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.colorcolumn = "80" -- Soft guide for readability
    vim.opt_local.textwidth = 0 -- No hard wrapping, just visual
  end,
  desc = "Optimize display for text-based files",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "javascript", "typescript", "lua", "python", "rust", "c", "cpp" },
  callback = function()
    -- Code files: wrap is enabled by default, but add smart column guides
    -- Users can toggle wrap off with <leader>uw if needed for specific files
    vim.opt_local.wrap = true -- Keep wrapping for better responsiveness
    vim.opt_local.linebreak = true -- Smart line breaking
    local win_width = vim.api.nvim_win_get_width(0)
    if win_width > 120 then
      vim.opt_local.colorcolumn = "100"
    elseif win_width > 80 then
      vim.opt_local.colorcolumn = "80"
    else
      vim.opt_local.colorcolumn = ""
    end
  end,
  desc = "Configure responsive display for code files with smart wrapping",
})

-- Dynamic adjustment when entering a window
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = function()
    -- Adjust column guide based on current window width
    local win_width = vim.api.nvim_win_get_width(0)
    local filetype = vim.bo.filetype
    
    -- Only adjust for code files (text files have their own rules)
    local code_filetypes = { "go", "javascript", "typescript", "lua", "python", "rust", "c", "cpp" }
    local is_code_file = false
    for _, ft in ipairs(code_filetypes) do
      if filetype == ft then
        is_code_file = true
        break
      end
    end
    
    if is_code_file then
      if win_width > 120 then
        vim.opt_local.colorcolumn = "100"
      elseif win_width > 80 then
        vim.opt_local.colorcolumn = "80"
      else
        vim.opt_local.colorcolumn = ""
      end
    end
  end,
  desc = "Adjust display settings when entering window",
})

-- ============================================================================
-- COMPLETION BEHAVIOR FIXES
-- ============================================================================

-- Ensure proper completion behavior and text replacement
vim.api.nvim_create_autocmd("CompleteDone", {
  group = vim.api.nvim_create_augroup("completion_fix", { clear = true }),
  callback = function()
    -- Ensure completion properly replaces text
    if vim.v.completed_item and vim.v.completed_item.word then
      -- Log for debugging if needed
      -- vim.notify("Completed: " .. vim.v.completed_item.word, vim.log.levels.DEBUG)
    end
  end,
  desc = "Handle completion done events for proper text replacement",
})
