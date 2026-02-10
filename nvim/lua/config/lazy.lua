local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Language support extras (matching your NvChad setup)
    { import = "lazyvim.plugins.extras.lang.go" },        -- Go development
    { import = "lazyvim.plugins.extras.lang.typescript" }, -- TypeScript/JavaScript
    { import = "lazyvim.plugins.extras.lang.python" },     -- Python support
    { import = "lazyvim.plugins.extras.lang.markdown" },   -- Markdown support
    { import = "lazyvim.plugins.extras.test.core" },       -- Testing framework
    { import = "lazyvim.plugins.extras.dap.core" },        -- Debug adapter protocol
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" }, -- UI enhancements - DISABLED for performance
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- Enable lazy loading for custom plugins to improve startup performance
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin", "cyberdream", "habamax" } },
  checker = {
    enabled = false, -- disable automatic plugin update checking for performance
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to improve startup time
      paths = {}, -- add any custom paths here that you need
      disabled_plugins = {
        "gzip",
        "matchit", 
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
