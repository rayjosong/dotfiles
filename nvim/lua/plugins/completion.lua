-- Enhanced completion configuration to fix text replacement issues
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Ensure proper text replacement behavior
      return vim.tbl_deep_extend("force", opts, {
        completion = {
          completeopt = "menu,menuone,noselect",
          keyword_length = 1, -- Start completion after 1 character
        },

        -- Experimental features for better completion
        experimental = {
          ghost_text = false, -- Disable to avoid conflicts
        },

        -- Snippet configuration
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Enhanced mapping with proper text replacement
        mapping = vim.tbl_extend("force", opts.mapping or {}, {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),

          -- Enter key with proper replacement behavior
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
            s = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true
            }),
            c = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true
            }),
          }),

          -- Tab key with proper replacement behavior
          ["<Tab>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                })
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end,
            s = function(fallback)
              if luasnip.jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end,
          }),

          -- Shift-Tab for snippet navigation
          ["<S-Tab>"] = cmp.mapping({
            i = function(fallback)
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
            s = function(fallback)
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
          }),
        }),

        -- Sources configuration
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "path", priority = 500 },
        }, {
          { name = "buffer", priority = 250, keyword_length = 3 },
        }),

        -- Formatting
        formatting = {
          format = function(entry, vim_item)
            -- Add source names for debugging
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
              cmdline = "[Cmd]",
            })[entry.source.name]

            return vim_item
          end,
        },

        -- Window configuration
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}