local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scope)
      end,
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go tests",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

-- ERROR: not sure why it doesn't work but ok
-- M.octo = {
--   plugin = true,
--   n = {
--     ["<leader>gpr"] = { ":Octo pr list<CR>", "Open PR in browser" },
--   },
-- }

M.nvim_toc = {
  plugin = true,
  n = {
    ["<leader>toc"] = {
      function()
        require("nvim-toc").generate_md_toc "list"
      end,
      "Create table of content (lists)",
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gie"] = {
      "<cmd> GoIfErr <CR>",
      "Generate go if err block",
    },
  },
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = {
      "<cmd>LazyGit<cr>",
      "Open LazyGit",
    },
  },
}

M.vim_maximizer = {
  plugin = true,
  n = {
    ["<leader>sm"] = {
      "<cmd>MaximizerToggle<CR>",
      "Maximize Window",
    },
  },
}

M.todo_comments = {
  plugin = true,
  n = {
    ["]t"] = {
      function()
        require("todo-comments").jump_next()
      end,
      "Next todo comment",
    },
    ["[t"] = {
      function()
        require("todo-comments").jump_prev()
      end,
      "Previous todo comment",
    },
    -- ["<leader>xt"] = {"<cmd>TodoTrouble<cr>", "Todo (Trouble)"},
    -- ["<leader>xT"] = {"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme (Trouble)"},
    ["<leader>st"] = { "<cmd>TodoTelescope<cr>", "Todo" },
    ["<leader>sT"] = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" },
  },
}

M.codeshot = {
  plugin = true,
  v = {
    ["<leader>ss"] = { "<cmd>SSSelected<cr>", "Take screenshot of selected lines" },
    ["<leader>sf"] = { "<cmd>SSFocused<cr>", "Take screenshot of file and highlight selected lines" },
  },
}

M.vim_tmux_navigator = {
  plugin = true,
  n = {
    ["<C-h>"] = { ":TmuxNavigateLeft<CR>", "Move to left pane tmux" },
    ["<C-j>"] = { ":TmuxNavigateDown<CR>", "Move to down pane tmux" },
    ["<C-k>"] = { ":TmuxNavigateUp<CR>", "Move to up pane tmux" },
    ["<C-l>"] = { ":TmuxNavigateRight<CR>", "Move to right pane tmux" },
  },
}

M.gitlinker = {
  plugin = true,
  n = {
    ["<leader>gy"] = {
      "",
      "copy gitlink",
    },
  },
}

M.neotest = {
  plugin = true,
  n = {
    ["<leader>tt"] = {
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "Run file",
    },
    ["<leader>tT"] = {
      function()
        require("neotest").run.run(vim.loop.cwd())
      end,
      "Run all test files",
    },
    ["<leader>tr"] = {
      function()
        require("neotest").run.run()
      end,
      "Run Nearest",
    },
    ["<leader>tl"] = {
      function()
        require("neotest").run.run_last()
      end,
      "Run Last",
    },
    ["<leader>ts"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "Toggle Summary",
    },
    ["<leader>to"] = {
      function()
        require("neotest").output.open { enter = true, auto_close = true }
      end,
      "Show Output",
    },
    ["<leader>tO"] = {
      function()
        require("neotest").output_panel.toggle()
      end,
      "Toggle Output Panel",
    },
    ["<leader>tS"] = {
      function()
        require("neotest").run.stop()
      end,
      "Stop",
    },
  },
}

M.obsidian = {
  plugin = true,
  n = {
    ["<leader>on"] = { ":ObsidianNew<CR>", "Creating new note" },
    ["<leader>ot"] = { ":ObsidianTemplate<CR>", "Insert template" },
    ["<leader>oo"] = { ":ObsidianOpen<CR>", "Open Obsidian in GUI" },
  },
}

return M
