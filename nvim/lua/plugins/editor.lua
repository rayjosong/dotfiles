-- Editor Enhancement and Productivity Tools
-- Only custom plugins not provided by LazyVim defaults

return {
  -- Tmux navigation integration (unique to your workflow)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown", 
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left pane" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to lower pane" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to upper pane" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right pane" },
    },
  },

  -- Window maximizer for focus mode (unique to your workflow)
  {
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    keys = {
      { "<leader>z", "<cmd>MaximizerToggle<cr>", desc = "Zoom/Maximize Window (Toggle)" },
      { "<C-w>z", "<cmd>MaximizerToggle<cr>", desc = "Zoom/Maximize Window (Toggle)" },
    },
    config = function()
      -- Ensure the command is available
      vim.g.maximizer_set_default_mapping = 0 -- Disable default mappings
      vim.g.maximizer_restore_on_winleave = 1 -- Auto-restore when leaving window
    end,
  },

  -- Multi-cursor editing (unique to your workflow)
  {
    "mg979/vim-visual-multi",
    keys = {
      { "<C-n>", mode = { "n", "x" }, desc = "Multi-cursor next" },
      { "<C-Down>", mode = { "n", "x" }, desc = "Multi-cursor down" },
      { "<C-Up>", mode = { "n", "x" }, desc = "Multi-cursor up" },
    },
  },

  -- Custom formatting/linting configuration (LazyVim includes these, but we add your tools)
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Add your custom formatters to LazyVim's defaults
      local custom_formatters = {
        go = { "goimports", "gofumpt" },
        markdown = { "prettier", "mdformat" },
        json = { "prettier" },
        yaml = { "prettier" },
      }
      
      for ft, formatters in pairs(custom_formatters) do
        opts.formatters_by_ft[ft] = formatters
      end
      
      -- LazyVim handles format_on_save automatically via its formatting system
      -- No need to set opts.format_on_save as it conflicts with LazyVim defaults
    end,
  },

  -- Custom linting configuration - DISABLE MARKDOWN LINTING COMPLETELY
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- COMPLETELY DISABLE markdown linting to eliminate noise and improve performance
      opts.linters_by_ft = opts.linters_by_ft or {}
      
      -- Disable all markdown linting
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft.md = {}
      
      -- Add only essential custom linters
      local custom_linters = {
        -- Disable golangci-lint to avoid exit code 3 errors - use gopls LSP instead
        -- go = { "golangcilint" },
        python = { "flake8" },
      }
      
      for ft, linters in pairs(custom_linters) do
        opts.linters_by_ft[ft] = linters
      end
      
      -- Completely remove markdownlint from available linters
      if opts.linters then
        opts.linters.markdownlint = nil
        opts.linters["markdownlint-cli2"] = nil
      end
    end,
  },

  -- Mason tool configuration (LazyVim includes Mason, but we ensure your tools are installed)
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Your custom tools
        "goimports",
        "gofumpt", 
        "mdformat",
        "golangci-lint",
        "markdownlint",
        "flake8",
        "markdown-toc",
        "prettier",
        -- Note: fd and ripgrep are installed via Homebrew, not Mason
      })
    end,
  },
}