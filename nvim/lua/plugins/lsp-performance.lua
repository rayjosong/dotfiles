-- LSP Performance optimizations
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Merge with LazyVim defaults instead of overriding
      return vim.tbl_deep_extend("force", opts, {
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
              -- Better completion behavior
              usePlaceholders = true, -- Enable for better completion
              completeUnimported = true, -- Enable for better completion
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
      -- Override inlay hints to disable for performance (merges with LazyVim defaults)
      inlay_hints = {
        enabled = false, -- Disable for performance (can be toggled with <leader>uh)
        exclude = { "vue", "markdown" }, -- Merge with LazyVim's exclude list
      },
      -- Reduce LSP log level
      log_level = vim.log.levels.WARN,
      })
    end,
  },
  
  -- Optimize completion for performance and fix text replacement
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      return vim.tbl_deep_extend("force", opts, {
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
          completeopt = "menu,menuone,noselect",
        },
        -- Fix the text replacement behavior
        confirmation = {
          default_behavior = cmp.ConfirmBehavior.Replace,
        },
        mapping = vim.tbl_extend("force", opts.mapping or {}, {
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          }),
          ["<Tab>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                })
              else
                fallback()
              end
            end,
            s = function(fallback)
              if cmp.visible() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                })
              else
                fallback()
              end
            end,
          }),
        }),
      })
    end,
  },
}