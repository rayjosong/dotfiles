-- GUI-specific font configuration
if vim.g.neovide then
  vim.o.guifont = "Karben 105 W00 Bold:h14"
  vim.g.neovide_scale_factor = 1.0
end

-- For other GUI clients
if vim.g.fvim_loaded then
  vim.cmd("FVimFontFamily 'Karben 105 W00 Bold'")
  vim.cmd("FVimFontSize 14")
end

-- For nvim-qt
if vim.g.GuiLoaded then
  vim.cmd("GuiFont! Karben 105 W00 Bold:h14")
end