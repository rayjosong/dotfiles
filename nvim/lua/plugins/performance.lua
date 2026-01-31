-- Aggressive performance optimizations - disable laggy features
return {
  -- Disable problematic LazyVim features
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = {
          enabled = false, -- Disable LSP progress (can cause lag)
        },
        hover = {
          enabled = false, -- Disable hover (use K for manual hover)
        },
        signature = {
          enabled = false, -- Disable signature help (can cause lag)
        },
      },
      presets = {
        bottom_search = false, -- Disable bottom search
        command_palette = false, -- Disable command palette
        long_message_to_split = false, -- Don't split long messages
        inc_rename = false, -- Disable incremental rename
        lsp_doc_border = false, -- Disable LSP doc border
      },
    },
  },

  -- Disable indent-blankline (can cause performance issues)
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },

  -- Optimize which-key for performance
  {
    "folke/which-key.nvim",
    opts = {
      delay = 200, -- Faster than default
      plugins = {
        marks = false, -- Disable marks (can be slow)
        registers = false, -- Disable registers (can be slow)
        spelling = {
          enabled = false, -- Disable spelling suggestions
        },
        presets = {
          operators = false, -- Disable operators
          motions = false, -- Disable motions
          text_objects = false, -- Disable text objects
          windows = false, -- Disable window commands
          nav = false, -- Disable navigation commands
          z = false, -- Disable z commands
          g = false, -- Disable g commands
        },
      },
    },
  },

  -- Optimize treesitter for performance
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- Disable vim regex highlighting
        disable = function(lang, buf)
          -- Disable treesitter for large files
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      incremental_selection = { enable = false }, -- Disable incremental selection
      indent = { enable = false }, -- Disable treesitter indent (can be slow)
    },
  },

  -- Optimize gitsigns for performance
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      update_debounce = 300, -- Increased debounce for better performance
      max_file_length = 40000, -- Don't process very large files
      preview_config = {
        border = "none", -- Remove borders for performance
      },
      -- Additional performance optimizations
      watch_gitdir = {
        follow_files = false, -- Don't follow file moves for performance
      },
      attach_to_untracked = false, -- Don't attach to untracked files
      current_line_blame = false, -- Ensure blame is disabled (using blamer.nvim instead)
      current_line_blame_formatter = false, -- Disable formatter
      sign_priority = 1, -- Lower priority to reduce conflicts
    },
  },

  -- Disable some LazyVim default plugins that can cause lag
  {
    "echasnovski/mini.indentscope",
    enabled = false, -- Disable indent scope animation
  },

  {
    "RRethy/vim-illuminate",
    enabled = false, -- Disable word highlighting under cursor
  },

  -- Git blame performance optimization
  -- Note: blamer.nvim is configured in git.lua to be disabled by default
  -- Use <leader>gb to toggle git blame when needed, avoiding constant git operations
}