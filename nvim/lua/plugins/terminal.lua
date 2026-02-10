-- Terminal Integration with ToggleTerm
-- Provides floating, horizontal, and vertical terminal options
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = 20,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      local status_ok, toggleterm = pcall(require, "toggleterm")
      if not status_ok then
        vim.notify("Failed to load toggleterm", vim.log.levels.ERROR)
        return
      end
      toggleterm.setup(opts)

      -- Custom terminal functions
      local Terminal = require("toggleterm.terminal").Terminal

      -- Floating terminal
      local float_term = Terminal:new({
        direction = "float",
        id = 1,
        float_opts = {
          border = "double",
        },
        hidden = true,
      })

      -- Horizontal split terminal
      local horizontal_term = Terminal:new({
        direction = "horizontal",
        id = 2,
        size = 15,
        hidden = true,
      })

      -- Vertical split terminal
      local vertical_term = Terminal:new({
        direction = "vertical",
        id = 3,
        size = vim.o.columns * 0.4,
        hidden = true,
      })

      -- LazyGit integration
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "none",
          width = vim.o.columns,
          height = vim.o.lines,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Create global functions for terminal access
      _G.set_terminal_keymaps = function()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Create toggle functions
      _G._FLOAT_TERM_TOGGLE = function()
        float_term:toggle()
      end

      _G._HORIZONTAL_TERM_TOGGLE = function()
        horizontal_term:toggle()
      end

      _G._VERTICAL_TERM_TOGGLE = function()
        vertical_term:toggle()
      end

      _G._LAZYGIT_TOGGLE = function()
        lazygit:toggle()
      end

      -- Set up autocommand for terminal keymaps
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      -- Key mappings
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Terminal toggles - <leader>te prefix (tErminal)
      -- Work in normal mode and terminal mode for easy toggling
      keymap({ "n", "t" }, "<leader>tef", "<cmd>lua _FLOAT_TERM_TOGGLE()<CR>", opts)
      keymap({ "n", "t" }, "<leader>tev", "<cmd>lua _VERTICAL_TERM_TOGGLE()<CR>", opts)
      keymap({ "n", "t" }, "<leader>teh", "<cmd>lua _HORIZONTAL_TERM_TOGGLE()<CR>", opts)

      -- Override the existing lazygit keybinding to use our enhanced version
      keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
    end,
  },
}