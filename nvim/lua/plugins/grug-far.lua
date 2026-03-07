-- Grug-far.nvim - Modern search and replace with live preview
-- https://github.com/MagicDuck/grug-far.nvim
--
-- Provides interactive search and replace with:
-- - Live preview of changes before applying
-- - Support for multiple files (project-wide)
-- - Regex support with syntax highlighting
-- - Diff visualization
-- - History of previous searches
--
-- Keymaps:
--   <leader>sr - Search and Replace (word under cursor)
--   <leader>sR - Search and Replace (empty)
--
-- Complements existing search tools:
--   <leader>fg - Telescope live grep (quick search)
--   s + 2chars - Flash jump (jump within buffer)
--   <leader>sr - Grug-far (search AND replace)

return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  ---@type GrugFarOptions
  opts = {
    -- Keymaps within the grug-far interface
    keymaps = {
      replace = { n = "<cr>" },      -- Confirm replace
      qflist = "q",                   -- Open quickfix list
      sync = "<leader>s",             -- Sync flags
      syncHistory = "<C-h>",          -- Search history
      close = "<Esc>"                 -- Close interface
    },
    -- Additional options
    searchMaxLineLength = 500,        -- Don't search very long lines
    icons = {
      enabled = true,                 -- Enable icons
    },
    -- Performance optimization
    debouncing = {
      enabled = true,                 -- Enable debouncing
      debounceTimeoutMs = 300,        -- Wait 300ms before searching
    },
  },
  config = function(_, opts)
    require("grug-far").setup(opts)

    -- Keymap for search with word under cursor
    vim.keymap.set("n", "<leader>sr", function()
      local word = vim.fn.expand("<cword>")
      vim.cmd("GrugFar " .. word)
    end, { desc = "Search and Replace (Grug-Far)" })

    -- Keymap for empty search
    vim.keymap.set("n", "<leader>sR", function()
      vim.cmd("GrugFar")
    end, { desc = "Search and Replace (Empty)" })

    -- Visual mode: search for selected text
    vim.keymap.set("v", "<leader>sr", function()
      vim.cmd('[[ "<,">GrugFar ]]')
    end, { desc = "Search and Replace (Grug-Far)" })

    vim.keymap.set("v", "<leader>sR", function()
      vim.cmd('[[ "<,">GrugFar ]]')
    end, { desc = "Search and Replace (Empty)" })
  end,
}
