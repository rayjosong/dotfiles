-- Python Development Configuration
-- Adds project-specific virtual environment detection and debug keymaps to LazyVim's Python extra

-- Helper: Detect project venv from common locations
local function detect_python_venv()
  -- Priority order: .venv > venv > env > global fallback
  local venv_paths = {
    vim.fn.getcwd() .. "/.venv/bin/python",
    vim.fn.getcwd() .. "/venv/bin/python",
    vim.fn.getcwd() .. "/env/bin/python",
    vim.fn.expand("~/.venvs/neovim/bin/python"),
  }

  for _, path in ipairs(venv_paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  -- Fallback to system python
  return "python3"
end

return {
  -- Configure Python LSP with project venv detection
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              -- Detect venv at config time (serializable string, not function)
              pythonPath = detect_python_venv(),
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },

  -- Configure Python debugging with project venv detection
  {
    "mfussenegger/nvim-dap-python",
    opts = function(_, opts)
      local debugpy_path = detect_python_venv()

      if vim.fn.executable(debugpy_path) == 1 then
        opts.test_runner = "pytest"
        opts.python = debugpy_path
      end

      return opts
    end,
    -- Debug keymaps matching Go pattern (<leader>dg*)
    keys = {
      {
        "<leader>dpt",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug: Python Test (Nearest)",
      },
      {
        "<leader>dps",
        function()
          require("dap-python").test_class()
        end,
        desc = "Debug: Python Test Suite",
      },
      {
        "<leader>dpc",
        function()
          -- Debug closest test class (same as test_suite for neotest-python)
          require("dap-python").test_class()
        end,
        desc = "Debug: Python Class",
      },
    },
  },

  -- Set up Neovim's Python provider with fallback
  {
    "folke/lazy.nvim",
    opts = function()
      local venv_python = vim.fn.expand("~/.venvs/neovim/bin/python")

      if vim.fn.executable(venv_python) == 1 then
        vim.g.python3_host_prog = venv_python
        vim.g.loaded_python_provider = 1
      end
    end,
  },

  -- Black formatter options
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters.black = {
        prepend_args = { "--fast", "--line-length=88" },
      }
    end,
  },

  -- Configure pytest for neotest
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      -- Configure neotest-python adapter
      for _, adapter in ipairs(opts.adapters) do
        if adapter.name == "neotest-python" or (type(adapter) == "table" and adapter[1] and adapter[1]:find("python")) then
          adapter.args = {
            "--ignore=tests/external",
            "--ignore=tests/integration",
            "-v",
          }
          adapter.python = nil -- Let neotest-python auto-detect from venv
        end
      end
    end,
  },
}
