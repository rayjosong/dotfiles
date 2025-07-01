local plugins = {
  {
    "APZelos/blamer.nvim",
    event = "VeryLazy",
    keys = "<leader>gb",
    setup = function ()
      vim.g.blamer_enabled = 1
      vim.g.blamer_delay = 500
      vim.g.blamer_template = " %s | %s "
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "typescript-language-server",
        "eslint-lsp",
        "eslint",
        "prettier",
        "python-lsp-server",
        "reoder-python-imports",
        "prisma-language-server",
        "lua-language-server",
        "markdown-toc",
        "mdformat",
        "markdownlint",
      }
    }
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function ()
      return require "custom.configs.formatter"
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
    end,
  },
  {
    "mfussenegger/nvim-dap"
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    ft = "go, js, ts",
    opts = function ()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function (_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function ()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
      "kdheepak/lazygit.nvim",
      event = { "BufReadPost", "BufWritePost", "BufNewFile" },
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
      config = function ()
        require("core.utils").load_mappings("lazygit")
        -- vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
        -- vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
        -- vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
        -- vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
        -- vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
        --
        -- vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
      end
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function ()
      require "custom.configs.lint"
    end
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function ()
      vim.opt.termguicolors = true
      vim.notify = require("notify").setup({
        opacity = 20
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    ops = {},
    config = function ()
      require("custom.configs.noice").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    }
  },
  {
    "ruifm/gitlinker.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function ()
      require "custom.configs.gitlinker"
    end
  },
  {
    "szw/vim-maximizer",
    lazy = false,
    config = function()
      require("core.utils").load_mappings("vim_maximizer")
    end
  },
  {
    "nvim-neotest/neotest-go",
    ft = "*_test.go",
    config = function()
      require("custom.configs.neotest_go").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    name = "neotest",
    event = "BufEnter *_test.go",
    dependencies = {
        "nvim-neotest/neotest-go",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/nvim-nio",
    },
    config = function()
      require("custom.configs.neotest").setup()
      require("core.utils").load_mappings("neotest")
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function ()
      require("todo-comments").setup()
      require("core.utils").load_mappings("todo_comments")
      return true
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = require("custom.configs.dashboard")
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  -- FIX: has some issues in codeshot/options:22. to await fix
  -- {
  --   "SergioRibera/codeshot.nvim",
  --   event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  --   config = function ()
  --     require("codeshot").setup({ })
  --     require("core.utils").load_mappings("codeshot")
  --   end
  -- },



  -- TODO: refactor these!!!!!
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      delay = 50,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    config = function ()
      require("custom.configs.obsidian")
      require("core.utils").load_mappings("obsidian")
    end,
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    config = function ()
      require("core.utils").load_mappings("vim_tmux_navigator")
    end
  },
  {
    -- "vim-test/vim-test",
  },
  {
    "bullets-vim/bullets.vim",
    ft = "markdown",
  },
  {
    "richardbizik/nvim-toc",
    ft = "markdown",
    config = function ()
      require('nvim-toc').setup({
        toc_header = "Table of Contents"
      })
      require("core.utils").load_mappings("nvim_toc")
    end
  },
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
  },
  -- NOTE: favour octo.nvim over gh.nvim
  -- {
  --   "pwntester/octo.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   event = "BufReadPost",
  --   config = function ()
  --     require("custom.configs.octo")
  --
  --     -- require("core.utils").load_mappings("octo")
  --   end
  -- },
  -- {
  --   "ldelossa/gh.nvim",
  --   event = "BufReadPost",
  --   dependencies = {
  --     {
  --       "ldelossa/litee.nvim",
  --       config = function()
  --         require("litee.lib").setup()
  --       end,
  --     },
  --   },
  --   config = function()
  --     require("custom.configs.gh")
  --   end,
  -- }
  --
  --


}

return plugins
