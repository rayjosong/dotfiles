-- Markdown and Documentation Tools
-- Markdown utilities

return {
  -- Markdown bullets for enhanced list editing
  {
    "bullets-vim/bullets.vim",
    ft = "markdown",
    config = function()
      -- Enable bullets for markdown files
      vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
      vim.g.bullets_outline_levels = { "ROM", "ABC", "num", "abc", "rom", "i)", "a)", "I)", "A)" }
    end,
  },

  -- Table of contents generation
  {
    "richardbizik/nvim-toc",
    ft = "markdown",
    config = function()
      require("nvim-toc").setup({
        toc_header = "Table of Contents",
      })
    end,
    keys = {
      { "<leader>mt", function() require("nvim-toc").generate_md_toc("list") end, desc = "Markdown: Generate TOC" },
    },
  },

  -- Enhanced markdown support (builds on LazyVim markdown extras)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },

  -- Mason tools for markdown
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "markdownlint",
        "markdown-toc",
        "mdformat",
      })
    end,
  },
}