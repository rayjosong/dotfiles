-- LSP Performance optimizations
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Disable certain LSP features that can cause lag
      setup = {
        gopls = function(_, opts)
          -- Optimize gopls for better performance
          opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
            gopls = {
              -- Reduce analysis scope for better performance
              analyses = {
                unusedparams = false, -- Disable to improve performance
                shadow = false,
                fieldalignment = false,
                nilness = false,
              },
              -- Faster completion
              usePlaceholders = false,
              completeUnimported = false, -- Disable to improve performance
              staticcheck = false, -- Disable to improve performance
              gofumpt = true,
              -- Reduce memory usage
              experimentalWorkspaceModule = false,
              experimentalUseInvalidMetadata = false,
            },
          })
          return false
        end,
      },
      -- Global LSP settings for performance
      diagnostics = {
        update_in_insert = false, -- Don't update diagnostics in insert mode
        virtual_text = {
          spacing = 4,
          severity = { min = vim.diagnostic.severity.WARN }, -- Only show warnings and errors
        },
      },
      -- Reduce LSP log level
      log_level = vim.log.levels.WARN,
    },
  },
  
  -- Optimize completion for performance
  {
    "hrsh7th/nvim-cmp",
    opts = {
      performance = {
        debounce = 150, -- Add debounce to reduce lag
        throttle = 100,
        fetching_timeout = 200,
        max_abbr_width = 60,
        max_kind_width = 60,
        max_menu_width = 60,
      },
      completion = {
        keyword_length = 2, -- Require 2 characters before completion
      },
    },
  },
}