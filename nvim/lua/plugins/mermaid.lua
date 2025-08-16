-- Mermaid diagram viewer plugin
-- Provides live preview of mermaid diagrams in markdown files

return {
  -- Primary option: markdown-preview.nvim (reliable, auto-installs dependencies)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      -- Basic configuration
      vim.g.mkdp_filetypes = { "markdown" }
      -- Don't open browser automatically
      vim.g.mkdp_auto_start = 0
    end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview with Mermaid (Primary)",
      },
      {
        "<leader>mm", 
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown Preview Open",
      },
      {
        "<leader>ms",
        "<cmd>MarkdownPreviewStop<cr>", 
        desc = "Markdown Preview Stop",
      },
    },
    config = function()
      -- Simple, working configuration
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "Neovim Preview"
      vim.g.mkdp_theme = "dark"
      
      -- Essential settings for mermaid support
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_combine_preview = 0
      vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
  },
  
  -- Alternative option: peek.nvim (requires deno - only load if available)
  {
    "toppair/peek.nvim", 
    enabled = function()
      -- Only enable if deno is available
      return vim.fn.executable("deno") == 1
    end,
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>mP",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek Preview (Advanced - requires Deno)",
      },
    },
    opts = {
      auto_load = false,       -- disabled to avoid conflicts
      close_on_bdelete = true,
      syntax = true,
      theme = "dark",
      update_on_change = true,
      app = "webview",
      filetype = { "markdown" },
      throttle_at = 200000,
      throttle_time = "auto",
    },
  },
}