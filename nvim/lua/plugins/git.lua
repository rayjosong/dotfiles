-- Git and GitHub Integration Stack
-- Comprehensive Git workflow tools matching your NvChad setup

return {
  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      -- Removed <leader>gg - handled by terminal.lua for enhanced integration
    },
    config = function()
      -- Preserve your commented configuration options for future use
      -- vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      -- vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      -- vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
      -- vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      -- vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
      -- vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
    end,
  },

  -- Git blame with exact NvChad configuration
  {
    "APZelos/blamer.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.blamer_enabled = 1
      vim.g.blamer_delay = 500
      vim.g.blamer_template = " %s | %s "
    end,
    keys = {
      { "<leader>gb", "<cmd>BlamerToggle<cr>", desc = "Git Blame" },
    },
  },

  -- GitHub permalinks
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy", -- Load eagerly to ensure keymaps are available
    config = function()
      require("gitlinker").setup({
        opts = {
          mappings = nil, -- Don't use default mappings, we'll define our own
        },
      })
      
      -- Custom function that copies git link and shows notification
      local function copy_git_link()
        require("gitlinker").get_buf_range_url("n", {
          action_callback = function(url)
            -- Copy to clipboard
            vim.fn.setreg("+", url)
            vim.fn.setreg("*", url)
            
            -- Show notification using noice/notify
            local has_notify, notify = pcall(require, "notify")
            if has_notify then
              notify("Git link copied to clipboard", "info", {
                title = "GitLinker",
                icon = "🔗",
                timeout = 2000,
              })
            else
              vim.notify("Git link copied: " .. url, vim.log.levels.INFO)
            end
          end,
        })
      end
      
      -- Set the keymap directly in config to ensure it's loaded
      vim.keymap.set("n", "<leader>gy", copy_git_link, { desc = "Copy Git Link" })
    end,
  },

  -- GitHub integration with Octo (issues, PRs, reviews)
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = "BufReadPost",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
    keys = {
      { "<leader>gpr", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gpl", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gir", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>gic", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
    },
  },

  -- GitHub CLI integration with litee UI
  {
    "ldelossa/gh.nvim",
    event = "BufReadPost",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup()
        end,
      },
    },
    config = function()
      require("litee.gh").setup()
    end,
    keys = {
      { "<leader>ghc", "<cmd>GHCloseCommit<cr>", desc = "Close Commit" },
      { "<leader>ghe", "<cmd>GHExpandCommit<cr>", desc = "Expand Commit" },
      { "<leader>gho", "<cmd>GHOpenPR<cr>", desc = "Open PR" },
      { "<leader>ghp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out Commit" },
      { "<leader>ghr", "<cmd>GHRefreshCommit<cr>", desc = "Refresh Commit" },
      { "<leader>ght", "<cmd>GHOpenToCommit<cr>", desc = "Open To Commit" },
    },
  },

  -- Enhanced gitsigns configuration (builds on LazyVim default)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = false, -- Using blamer.nvim instead
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
}