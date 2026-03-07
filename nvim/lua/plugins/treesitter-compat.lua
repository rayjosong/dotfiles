-- Fix nvim-treesitter-textobjects compatibility issue
-- The plugin expects nvim-treesitter.utils (plural) but nvim-treesitter has util.lua (singular)
return {
  -- Load treesitter first with priority to create the alias
  {
    "nvim-treesitter/nvim-treesitter",
    priority = 1000,
    build = ":TSUpdate",
    init = function()
      -- Create the utils alias as early as possible
      -- This runs when lazy.nvim starts loading the plugin
      pcall(function()
        package.loaded["nvim-treesitter.utils"] = require("nvim-treesitter.util")
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      -- Double-check the alias exists before textobjects loads
      if not package.loaded["nvim-treesitter.utils"] then
        local ok, util = pcall(require, "nvim-treesitter.util")
        if ok then
          package.loaded["nvim-treesitter.utils"] = util
        end
      end
    end,
  },
}
