-- Diffview.nvim - Enhanced git diff, merge conflict resolution, and file history
-- Integrated with your existing LazyGit and git workflow

return {
  {
    "sindrets/diffview.nvim",
    cmd = { 
      "DiffviewOpen", 
      "DiffviewClose", 
      "DiffviewToggleFiles", 
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
      "DiffviewLog",
    },
    keys = {
      -- Main diff operations (using <leader>gd prefix for "git diff")
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Git Diff: Open diff view" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Git Diff: Close diff view" },
      { "<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", desc = "Git Diff: Toggle file panel" },
      { "<leader>gdf", "<cmd>DiffviewFocusFiles<cr>", desc = "Git Diff: Focus file panel" },
      { "<leader>gdr", "<cmd>DiffviewRefresh<cr>", desc = "Git Diff: Refresh" },
      
      -- File history operations (using <leader>gh prefix for "git history")
      { "<leader>ghf", "<cmd>DiffviewFileHistory<cr>", desc = "Git History: Current file" },
      { "<leader>gha", "<cmd>DiffviewFileHistory %<cr>", desc = "Git History: All files" },
      { "<leader>ghl", "<cmd>DiffviewLog<cr>", desc = "Git History: Git log" },
      
      -- Branch and commit comparisons
      { "<leader>gdm", function()
          local branch = vim.fn.input("Compare with branch/commit: ", "main")
          if branch ~= "" then
            vim.cmd("DiffviewOpen " .. branch)
          end
        end, desc = "Git Diff: Compare with branch/commit" },
      
      -- Visual mode - diff selection
      { "<leader>gds", ":DiffviewFileHistory<cr>", mode = "v", desc = "Git History: Selection" },
      
      -- Merge conflict resolution
      { "<leader>gxo", "<cmd>DiffviewOpen --merge-conflict<cr>", desc = "Git: Resolve merge conflicts" },
      { "<leader>gx3", function()
          -- Three-way merge for current file
          vim.cmd("DiffviewOpen HEAD~1 HEAD -- " .. vim.fn.expand("%"))
        end, desc = "Git: 3-way merge current file" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- Enhanced diff options for better readability
      diff_binaries = false,    -- Don't show diff for binary files
      enhanced_diff_hl = true,  -- Use enhanced diff highlighting
      
      -- Use external git for better performance with large repos
      use_icons = true,
      
      -- File panel configuration to match your UI style
      file_panel = {
        listing_style = "tree",       -- tree | list (tree is more visual)
        tree_options = {
          flatten_dirs = true,        -- Flatten single-child directories
          folder_statuses = "only_folded", -- Show status only for folded dirs
        },
        win_config = {
          position = "left",          -- Match your neo-tree position
          width = 35,                 -- Good width for file names
          win_opts = {
            winhl = {
              "Normal:DiffviewNormal",
              "CursorLine:DiffviewCursorLine",
              "WinSeparator:DiffviewWinSeparator",
              "StatusLine:DiffviewStatusline",
              "StatusLineNC:DiffviewStatuslineNC",
              "VertSplit:DiffviewVertSplit",
            },
          },
        },
      },

      -- File history panel configuration
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined", -- Show combined diffs for merges
              follow = true,            -- Follow file renames
            },
            multi_file = {
              diff_merges = "first-parent", -- Cleaner multi-file history
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {
            winhl = {
              "Normal:DiffviewNormal",
              "CursorLine:DiffviewCursorLine", 
              "WinSeparator:DiffviewWinSeparator",
            },
          },
        },
      },

      -- Commit log configuration for better Go project workflow
      commit_log_panel = {
        win_config = {
          position = "bottom",
          height = 16,
        },
      },

      -- Default arguments for different commands
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = { "--follow" }, -- Follow file renames in Go refactoring
      },

      -- Hooks for integration with your existing workflow
      hooks = {
        diff_buf_read = function(bufnr)
          -- Integration with your existing Git workflow
          -- Set up buffer-local options for diff buffers
          vim.api.nvim_buf_set_option(bufnr, "wrap", false)
          vim.api.nvim_buf_set_option(bufnr, "list", false)
          vim.api.nvim_buf_set_option(bufnr, "colorcolumn", "0")
        end,
        diff_buf_win_enter = function(bufnr, winid)
          -- Auto-focus relevant sections in Go files
          if vim.bo[bufnr].filetype == "go" then
            -- Try to find function declarations or type definitions
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
            for i, line in ipairs(lines) do
              if line:match("^[%+%-].*func ") or line:match("^[%+%-].*type ") then
                vim.api.nvim_win_set_cursor(winid, {i, 0})
                break
              end
            end
          end
        end,
        view_opened = function(view)
          -- Integration with your cheatsheet - show relevant keybindings
          print("Diffview opened - Use 'g?' for help, '<tab>' to cycle files")
        end,
      },

      -- Use default keymaps (they're very good) and just add a few custom ones
      keymaps = {
        disable_defaults = false, -- Keep the excellent default keymaps
        view = {
          -- Custom integration with your workflow
          { "n", "<leader>gg", function() 
              vim.cmd("DiffviewClose")
              vim.schedule(function()
                _G._LAZYGIT_TOGGLE()
              end)
            end, { desc = "Close diffview and open LazyGit" } },
        },
      },
    },

    config = function(_, opts)
      local diffview = require("diffview")
      local actions = require("diffview.actions")
      
      diffview.setup(opts)

      -- Create autocommands for better integration with your Go workflow
      local group = vim.api.nvim_create_augroup("DiffviewGo", { clear = true })
      
      -- Auto-highlight Go-specific patterns in diffs
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "diff",
        callback = function()
          -- Enhanced syntax highlighting for Go in diffs
          vim.cmd([[
            syntax match DiffGoFunc /^[+-].*func\s\+\w\+/
            syntax match DiffGoType /^[+-].*type\s\+\w\+/
            syntax match DiffGoStruct /^[+-].*struct\s*{/
            syntax match DiffGoInterface /^[+-].*interface\s*{/
            highlight DiffGoFunc ctermfg=Blue guifg=#89b4fa
            highlight DiffGoType ctermfg=Cyan guifg=#94e2d5  
            highlight DiffGoStruct ctermfg=Green guifg=#a6e3a1
            highlight DiffGoInterface ctermfg=Magenta guifg=#f5c2e7
          ]])
        end,
        desc = "Enhanced Go syntax highlighting in diffs",
      })

      -- Integration with your existing terminal workflow
      -- Add command to open diffview from lazygit
      vim.api.nvim_create_user_command("LazyGitDiff", function()
        vim.cmd("DiffviewClose") -- Close any existing diffview
        vim.cmd("DiffviewOpen")
      end, { desc = "Open diffview from LazyGit context" })

      -- Integration with your Obsidian workflow for documentation
      vim.api.nvim_create_user_command("DiffviewNote", function()
        local current_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
        local note_content = string.format([[
# Git Diff Review - %s

Date: %s
Branch: %s

## Changes Overview
<!-- Use :DiffviewOpen to review changes -->

## Review Notes
- [ ] TODO: Add review notes here

## Action Items
- [ ] TODO: Add any follow-up tasks

]], current_branch, os.date("%Y-%m-%d"), current_branch)
        
        -- Create a new buffer with the note content
        vim.cmd("new")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(note_content, "\n"))
        vim.bo.filetype = "markdown"
      end, { desc = "Create diff review note" })

      -- Add command aliases for common diffview operations
      vim.api.nvim_create_user_command("DiffMain", function()
        vim.cmd("DiffviewOpen main")
      end, { desc = "Compare current branch with main" })

      vim.api.nvim_create_user_command("DiffOrigin", function()
        local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
        vim.cmd("DiffviewOpen origin/" .. branch)
      end, { desc = "Compare with origin branch" })
    end,
  },
  
  -- Optional: Integration with telescope for better diffview file navigation
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      return {
        extensions = {
          -- Add any diffview-specific telescope extensions here if they exist
        },
      }
    end,
  },
}