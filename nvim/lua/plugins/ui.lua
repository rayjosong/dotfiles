-- UI and UX Enhancement Plugins
-- Only custom plugins not provided by LazyVim defaults

return {
  -- Custom nvim-notify configuration (LazyVim includes it, but we override for opacity)
  {
    "rcarriga/nvim-notify",
    opts = {
      opacity = 20, -- Your custom opacity setting
      timeout = 3000,
    },
  },

  -- Custom noice configuration (LazyVim includes it, but we override for your layout)
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
    },
  },

  -- Add nvim-navic for breadcrumbs/hierarchy display
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
    end,
    opts = {
      separator = " > ",
      highlight = true,
      depth_limit = 5,
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘",
        Interface = "󰕘",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
    },
  },

  -- Configure LSP to attach navic
  {
    "neovim/nvim-lspconfig",
    dependencies = { "SmiteshP/nvim-navic" },
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- Ensure navic attaches to all LSP servers
      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, bufnr)
        end
      end
      
      -- Apply to all servers
      opts.servers = opts.servers or {}
      local servers = { "gopls", "tsserver", "pyright", "lua_ls", "marksman", "bashls" }
      for _, server in ipairs(servers) do
        opts.servers[server] = opts.servers[server] or {}
        local original_on_attach = opts.servers[server].on_attach
        opts.servers[server].on_attach = function(client, bufnr)
          if original_on_attach then
            original_on_attach(client, bufnr)
          end
          on_attach(client, bufnr)
        end
      end
      
      return opts
    end,
  },

  -- Custom lualine configuration with proper spacing and multi-line support
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Only set catppuccin theme if it's loaded
      if pcall(require, "catppuccin") then
        opts.options = opts.options or {}
        opts.options.theme = "catppuccin"
      end
      
      -- Configure sections for better spacing and avoid overlap
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { 
          { "branch", max_length = 20 }, -- Limit branch name length
          "diff" 
        },
        lualine_c = { 
          { 
            "filename", 
            path = 1, -- Show relative path
            shorting_target = 60, -- Shorten if too long
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
            }
          } 
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      }
      
      -- Enable winbar for second line with hierarchy/breadcrumbs
      opts.winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1, -- Relative path
            color = { fg = "#7aa2f7" }
          },
          {
            -- LSP breadcrumbs/hierarchy (navic integration)
            function()
              local ok, navic = pcall(require, "nvim-navic")
              if ok and navic.is_available() then
                local location = navic.get_location()
                if location and location ~= "" then
                  return " > " .. location
                end
              end
              return ""
            end,
            cond = function()
              local ok, navic = pcall(require, "nvim-navic")
              return ok and navic.is_available()
            end,
            color = { fg = "#a9b1d6" },
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
      
      opts.inactive_winbar = {
        lualine_c = {
          {
            "filename",
            path = 1,
            color = { fg = "#565f89" }
          }
        }
      }
    end,
  },
}