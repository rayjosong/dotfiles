-- Go Development Stack
-- Comprehensive Go development tools matching your NvChad setup

return {
  -- Go debugging with nvim-dap-go
  {
    "leoluz/nvim-dap-go",
    dependencies = "mfussenegger/nvim-dap",
    ft = "go",
    config = function()
      require("dap-go").setup()
    end,
    keys = {
      { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug: Go Test" },
      { "<leader>dgl", function() require("dap-go").debug_last() end, desc = "Debug: Last Go Test" },
    },
  },

  -- Go utilities with gopher.nvim
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function()
      require("gopher").setup()
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    keys = {
      { "<leader>gtj", "<cmd>GoTagAdd json<cr>", desc = "Go: Add JSON tags" },
      { "<leader>gte", "<cmd>GoIfErr<cr>", desc = "Go: Generate if err" },
    },
  },

  -- Go testing with neotest-go
  {
    "nvim-neotest/neotest-go",
    ft = "go",
    dependencies = {
      "nvim-neotest/neotest",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
    },
  },

  -- Enhanced neotest configuration for Go
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-go"] = {
        -- Preserve your custom configuration
        -- experimental = {
        --   test_table = true, -- Note: disabled per your comment
        -- },
        -- args = { "-count=1", "-timeout=60s" }, -- Note: unnecessary per your comment
      }
    end,
  },

  -- Mason tool configuration for Go
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "gopls",           -- Go language server
        "goimports",       -- Go imports formatter
        "gofumpt",         -- Go formatter (stricter than gofmt)
      })
    end,
  },

  -- Enhanced LSP configuration for Go
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
  },
}