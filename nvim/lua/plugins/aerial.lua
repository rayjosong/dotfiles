-- Aerial.nvim - Code outline and symbol navigation
-- Enhanced Go integration with intelligent symbol filtering and navigation

return {
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    keys = {
      { "<leader>ao", "<cmd>AerialToggle<cr>", desc = "Aerial: Toggle Outline" },
      { "<leader>ax", "<cmd>AerialNavToggle<cr>", desc = "Aerial: Toggle Navigation" },
      { "<leader>al", "<cmd>AerialOpen float<cr>", desc = "Aerial: Float Outline" },
      { "]]", "<cmd>AerialNext<cr>", desc = "Aerial: Next Symbol" },
      { "[[", "<cmd>AerialPrev<cr>", desc = "Aerial: Previous Symbol" },
      { "]f", "<cmd>AerialNext Function<cr>", desc = "Aerial: Next Function" },
      { "[f", "<cmd>AerialPrev Function<cr>", desc = "Aerial: Previous Function" },
      { "]c", "<cmd>AerialNext Class<cr>", desc = "Aerial: Next Class/Struct" },
      { "[c", "<cmd>AerialPrev Class<cr>", desc = "Aerial: Previous Class/Struct" },
      { "]m", "<cmd>AerialNext Method<cr>", desc = "Aerial: Next Method" },
      { "[m", "<cmd>AerialPrev Method<cr>", desc = "Aerial: Previous Method" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- Layout configuration to integrate with your existing UI
      layout = {
        max_width = { 60, 0.25 }, -- 60 chars or 25% of window width
        width = nil,
        min_width = 30,
        win_opts = {
          winhl = "Normal:NormalFloat,FloatBorder:FloatBorder,SignColumn:SignColumnSB",
        },
        default_direction = "right", -- Matches your neo-tree on left, avante on right
        placement = "edge", -- Place at window edge for better space usage
        preserve_equality = false, -- Don't force equal window sizes
      },

      -- Attach to LSP automatically for better symbol detection
      attach_mode = "global",
      
      -- Backend configuration - prioritize LSP for accuracy, fallback to Treesitter
      backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

      -- Symbol filtering and display - optimized for Go development
      filter_kind = {
        "Class",
        "Constructor", 
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
        "TypeAlias",
        "Variable", -- Include variables for Go constants and vars
      },

      -- Highlight configuration to match Catppuccin theme
      highlight_mode = "split_width",
      highlight_closest = true,
      highlight_on_hover = true,
      highlight_on_jump = 300, -- ms to highlight after jump

      -- Symbol icons - enhanced set for Go development
      icons = {
        Array = "󰅪 ",
        Boolean = "◩ ",
        Class = "󰌗 ",
        Constant = "󰏿 ",
        Constructor = " ",
        Enum = "󰕘 ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "󰈙 ",
        Function = "󰊕 ",
        Interface = "󰕘 ",
        Key = "󰌋 ",
        Method = "󰆧 ",
        Module = " ",
        Namespace = "󰌗 ",
        Null = "󰟢 ",
        Number = "󰎠 ",
        Object = "󰅩 ",
        Operator = "󰆕 ",
        Package = " ",
        Property = " ",
        String = "󰀬 ",
        Struct = "󰌗 ",
        TypeAlias = "󰊄 ",
        TypeParameter = "󰊄 ",
        Variable = "󰆧 ",
      },

      -- Navigation configuration for better UX
      nav = {
        border = "rounded",
        max_width = 0.6,
        max_height = 0.8,
        min_width = 50,
        min_height = 10,
        win_opts = {
          cursorline = true,
          winblend = 10,
        },
        -- Keymaps for navigation window
        keymaps = {
          ["<CR>"] = "actions.jump",
          ["<2-LeftMouse>"] = "actions.jump",
          ["<C-v>"] = "actions.jump_vsplit",
          ["<C-s>"] = "actions.jump_split",
          ["<C-t>"] = "actions.jump_tab",
          ["h"] = "actions.tree_close",
          ["l"] = "actions.tree_open",
          ["za"] = "actions.tree_toggle",
          ["O"] = "actions.tree_toggle_recursive",
          ["q"] = "actions.close",
          ["o"] = "actions.tree_open",
          ["zh"] = "actions.tree_close_all",
          ["zr"] = "actions.tree_open_all",
          ["zx"] = "actions.tree_sync_folds",
          ["zm"] = "actions.tree_increase_fold_level",
          ["zk"] = "actions.tree_decrease_fold_level",
        },
      },

      -- Language-specific configurations
      treesitter = {
        -- Go-specific optimizations
        go = {
          -- Only show meaningful symbols for Go
          filter = {
            "function",
            "method",
            "struct",
            "interface", 
            "type",
            "const",
            "var",
            "package",
          },
        },
        -- Other languages you work with
        lua = {
          filter = {
            "function",
            "method",
            "table",
            "field",
          },
        },
        typescript = {
          filter = {
            "function",
            "method",
            "class",
            "interface",
            "type",
            "variable",
          },
        },
        python = {
          filter = {
            "function",
            "method", 
            "class",
            "variable",
          },
        },
      },

      -- Integration with existing LSP setup
      lsp = {
        -- Diagnostics integration
        diagnostics_trigger_update = true,
        -- Update on LSP changes
        update_when_errors = true,
        -- Priority for symbol resolution
        priority = {
          "gopls", -- Your primary Go LSP
          "tsserver",
          "pyright",
          "lua_ls",
        },
      },

      -- Show fold information in aerial window
      show_guides = true,
      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
      },

      -- Floating window options for better integration
      float = {
        border = "rounded",
        relative = "editor",
        max_height = 0.9,
        height = nil,
        min_height = 8,
        override = function(conf, source_winid)
          -- Position floating window intelligently
          conf.anchor = "NE"
          conf.col = vim.o.columns
          conf.row = 1
          return conf
        end,
      },

      -- Close aerial automatically on buffer change for cleaner workflow
      close_automatic_events = {},
      
      -- Open aerial automatically for supported file types (disabled by default for performance)
      open_automatic = false,
      
      -- Update aerial when entering a buffer
      update_events = "TextChanged,InsertLeave,BufEnter,WinEnter",

      -- Post-parse callback for custom symbol processing
      post_parse_symbol = function(bufnr, item, ctx)
        -- Add custom processing for Go symbols
        if vim.bo[bufnr].filetype == "go" then
          -- Enhance function names to show receivers for methods
          if item.kind == "Method" and item.parent then
            local parent_name = item.parent.name
            if parent_name then
              item.name = "(" .. parent_name .. ") " .. item.name
            end
          end
          
          -- Add type information to variables and constants
          if item.kind == "Variable" or item.kind == "Constant" then
            -- Extract type information from the symbol if available
            local text = vim.api.nvim_buf_get_lines(bufnr, item.lnum - 1, item.lnum, false)[1]
            if text then
              local type_match = text:match("%w+%s+([%w%[%]%*]+)")
              if type_match then
                item.name = item.name .. " : " .. type_match
              end
            end
          end
        end
        
        return true
      end,

      -- Integration with your existing folding setup (nvim-ufo)
      manage_folds = false, -- Let nvim-ufo handle folding
      link_folds_to_tree = false,
      link_tree_to_folds = true, -- Update aerial when folds change
    },

    config = function(_, opts)
      require("aerial").setup(opts)

      -- Set up autocommands for better Go integration
      local group = vim.api.nvim_create_augroup("AerialGo", { clear = true })
      
      -- Auto-update aerial when Go files change significantly
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = group,
        pattern = "*.go",
        callback = function()
          if require("aerial").is_open() then
            vim.schedule(function()
              require("aerial").refetch_symbols()
            end)
          end
        end,
        desc = "Refresh aerial symbols after saving Go files",
      })

      -- Integration with telescope for symbol search
      local has_telescope, telescope = pcall(require, "telescope")
      if has_telescope then
        telescope.load_extension("aerial")
        
        -- Add telescope keybinding for aerial search
        vim.keymap.set("n", "<leader>ay", "<cmd>Telescope aerial<cr>", 
          { desc = "Aerial: Search Symbols" })
      end

      -- Integration with your existing Git workflow
      -- Auto-refresh aerial when switching git branches (common in Go projects)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyGitBranchChanged", -- Custom event you can trigger from lazygit
        callback = function()
          if require("aerial").is_open() then
            vim.schedule(function()
              require("aerial").refetch_symbols()
            end)
          end
        end,
        desc = "Refresh aerial symbols after git branch changes",
      })
    end,
  },

  -- Telescope integration for aerial (optional but recommended)
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      return {
        extensions = {
          aerial = {
            -- Display symbols in a hierarchical format
            show_nesting = {
              ["_"] = false, -- This key will be the default
              json = true,   -- You can set the option for specific filetypes
              yaml = true,
              go = true,     -- Show nesting for Go structs and interfaces
            },
            -- Show symbol columns
            col1_width = 60,
            col2_width = 30,
            format_symbol = function(symbol_path, symbol, bufnr, bufname)
              -- Custom symbol formatting for better readability
              return symbol.name .. " (" .. symbol.kind .. ")"
            end,
          },
        },
      }
    end,
  },
}