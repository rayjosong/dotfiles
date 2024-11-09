return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "json",
        "yaml",
        "prisma",
        "markdown",
        "markdown_inline",
        "bash",
        "graphql",
        "dockerfile",
        "gitignore",
        "lua",
        "tsx",
        "javascript",
        "typescript",
        "http",
        "json",
        "scss",
        "css",
        "sql",
        "vim",
        "go",
        "python",
        "ruby",
        "terraform",
      },
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
