---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'tokyodark',
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "atom",
    selected_item_bg = "colored"
  },
  telescope = { style = "bordered" },
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
