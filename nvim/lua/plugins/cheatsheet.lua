-- NvCheatsheet - Clean grid-based cheatsheet like the image you showed
return {
  {
    "smartinellimarco/nvcheatsheet.nvim",
    keys = {
      { 
        "<leader>ch", 
        function() 
          require("nvcheatsheet").toggle() 
        end, 
        desc = "Toggle Cheatsheet" 
      },
    },
    config = function()
      -- Define the required highlight groups for nvcheatsheet colors
      -- These must exist for the plugin to show colors
      local colors = {
        NvCheatsheetWhite = { bg = "#cdd6f4", fg = "#1e1e2e", bold = true },   -- Catppuccin text
        NvCheatsheetGray = { bg = "#6c7086", fg = "#1e1e2e", bold = true },    -- Catppuccin overlay1
        NvCheatsheetBlue = { bg = "#89b4fa", fg = "#1e1e2e", bold = true },    -- Catppuccin blue
        NvCheatsheetCyan = { bg = "#94e2d5", fg = "#1e1e2e", bold = true },    -- Catppuccin teal
        NvCheatsheetRed = { bg = "#f38ba8", fg = "#1e1e2e", bold = true },     -- Catppuccin red
        NvCheatsheetGreen = { bg = "#a6e3a1", fg = "#1e1e2e", bold = true },   -- Catppuccin green
        NvCheatsheetYellow = { bg = "#f9e2af", fg = "#1e1e2e", bold = true },  -- Catppuccin yellow
        NvCheatsheetOrange = { bg = "#fab387", fg = "#1e1e2e", bold = true },  -- Catppuccin peach
        NvCheatsheetPurple = { bg = "#cba6f7", fg = "#1e1e2e", bold = true },  -- Catppuccin mauve
        NvCheatsheetMagenta = { bg = "#f5c2e7", fg = "#1e1e2e", bold = true }, -- Catppuccin pink
      }
      
      -- Apply the highlight groups
      for group_name, colors_def in pairs(colors) do
        vim.api.nvim_set_hl(0, group_name, colors_def)
      end
      
      -- Also define the section background
      vim.api.nvim_set_hl(0, "NvChSection", { 
        bg = "#313244", -- Catppuccin surface0
        fg = "#cdd6f4"  -- Catppuccin text
      })
      
      -- Header highlight
      vim.api.nvim_set_hl(0, "NvChAsciiHeader", { 
        bg = "#1e1e2e", -- Catppuccin base
        fg = "#89b4fa", -- Catppuccin blue
        bold = true 
      })
      
      require("nvcheatsheet").setup({
        header = {
          "                                      ",
          "█░░ ▄▀█ ▀█ █▄█ █░█ █ █▀▄▀█   █▀▀ █░█ █▀▀ ▄▀█ ▀█▀ █▀ █░█ █▀▀ █▀▀ ▀█▀",
          "█▄▄ █▀█ █▄ ░█░ ▀▄▀ █ █░▀░█   █▄▄ █▀█ ██▄ █▀█ ░█░ ▄█ █▀█ ██▄ ██▄ ░█░",
          "                                      ",
        },
        keymaps = {
          -- Navigation & Core LazyVim Features
          ['Navigation'] = {
            { 'Jump anywhere instantly (Flash)', 's + two chars' },
            { 'Jump to line starts (Flash)', 'S' },
            { 'Select inside indent (Mini.ai)', 'vii' },
            { 'Select around indent (Mini.ai)', 'via' },
            { 'Select around last object (Mini.ai)', 'val' },
            { 'Jump to marks', "'a / 'b / 'c" },
            { 'Jump to exact mark position', '`a / `b / `c' },
          },
          
          -- Buffer Management
          ['Buffers'] = {
            { 'Next buffer', '<Tab>' },
            { 'Previous buffer', '<S-Tab>' },
            { 'Buffer picker (fuzzy search)', '<leader>,' },
            { 'Previous/Next buffer (LazyVim)', 'H / L' },
            { 'Delete current buffer', '<leader>bd' },
            { 'Close all other buffers', '<leader>bo' },
            { 'Close all buffers', '<leader>bA' },
            { 'Close buffers to left', '<leader>bl' },
            { 'Close buffers to right', '<leader>br' },
          },

          -- Search & Files  
          ['Search & Files'] = {
            { 'Live grep (MAIN GLOBAL SEARCH)', '<leader>fg' },
            { 'Search word under cursor', '<leader>gf' },
            { 'Find files by name', '<leader>ff' },
            { 'Find open buffers', '<leader>fb' },
            { 'Recent files', '<leader>fr' },
            { 'Search commands', '<leader>fc' },
            { 'Search help tags', '<leader>fh' },
            { 'Search keymaps', '<leader>fk' },
            { 'Document symbols', '<leader>fs' },
            { 'Workspace symbols', '<leader>fS' },
          },

          -- Window Management
          ['Windows'] = {
            { 'TOGGLE Zoom/Maximize window', '<leader>z' },
            { 'Same toggle function', '<C-w>z' },
            { 'Force restore all windows', '<leader>zr' },
            { 'Cycle between windows', '<C-w>w' },
            { 'Navigate to window direction', '<C-w>h/j/k/l' },
            { 'Equalize window sizes', '<C-w>=' },
            { 'Tmux/Vim navigation', '<C-h/j/k/l>' },
          },

          -- File Explorer
          ['File Explorer'] = {
            { 'Toggle neo-tree', '<leader>e' },
            { 'Neo-tree (root dir)', '<leader>E' },
            { 'Fuzzy find files (in neo-tree)', '/' },
            { 'Fuzzy find directories (in neo-tree)', '#' },
            { 'Clear filter (in neo-tree)', '<C-x>' },
            { 'Add file (in neo-tree)', 'a' },
            { 'Add directory (in neo-tree)', 'A' },
            { 'Delete (in neo-tree)', 'd' },
            { 'Rename (in neo-tree)', 'r' },
          },

          -- Marks System
          ['Marks (NEW!)'] = {
            { "Set mark 'a'/'b'/'c'", 'ma / mb / mc' },
            { 'Set global mark (across files)', 'mA / mB / mC' },
            { "Delete mark 'a'/'b'/'c' (CUSTOM!)", 'dma / dmb / dmc' },
            { 'Delete ALL marks', '<leader>dm' },
            { 'Show all marks', '<leader>sm' },
          },

          -- Git Integration
          ['Git'] = {
            { 'Open LazyGit', '<leader>gg' },
            { 'Git blame', '<leader>gb' },
            { 'Copy git permalink', '<leader>gy' },
            { 'Next/prev git hunk', ']h / [h' },
            { 'Preview hunk', '<leader>hp' },
            { 'Stage hunk', '<leader>hs' },
            { 'Reset hunk', '<leader>hr' },
          },

          -- Code Folding (NEW!)
          ['Code Folding'] = {
            { 'Toggle fold under cursor', 'za' },
            { 'Close fold under cursor', 'zc' },
            { 'Open fold under cursor', 'zo' },
            { 'Close ALL folds', 'zM or <leader>zf' },
            { 'Open ALL folds', 'zR or <leader>zo' },
            { 'Global word search (word under cursor)', '<leader>gf' },
            { 'Fold all Go structs', '<leader>gs' },
            { 'Peek folded content', 'K' },
          },

          -- Go Development
          ['Go Development'] = {
            { 'Add JSON struct tags', '<leader>gtj' },
            { 'Generate if err block', '<leader>gte' },
            { 'Debug Go test', '<leader>dgt' },
            { 'Debug last Go test', '<leader>dgl' },
            { 'Run test file', '<leader>tt' },
            { 'Run nearest test', '<leader>tr' },
            { 'Toggle test summary', '<leader>ts' },
            { 'Run last test', '<leader>tl' },
          },

          -- Debugging & Testing
          ['Debug & Test'] = {
            { 'Toggle breakpoint', '<leader>db' },
            { 'Continue debugging', '<leader>dc' },
            { 'Step over', '<leader>ds' },
            { 'Step into', '<leader>di' },
            { 'Run test file', '<leader>tt' },
            { 'Run all tests', '<leader>tT' },
            { 'Run nearest test', '<leader>tr' },
            { 'Show test output', '<leader>to' },
          },

          -- Diagnostics & Trouble
          ['Diagnostics'] = {
            { 'View all diagnostics', '<leader>xx' },
            { 'Symbol overview', '<leader>cs' },
            { 'Navigate diagnostics', ']d / [d' },
            { 'Line diagnostics', '<leader>cd' },
            { 'Format buffer', '<leader>cf' },
            { 'Code actions', '<leader>ca' },
            { 'Rename symbol', '<leader>cr' },
          },

          -- Obsidian & Markdown
          ['Obsidian/Markdown'] = {
            { 'New Obsidian note', '<leader>on' },
            { 'Insert template', '<leader>ot' },
            { 'Open in Obsidian', '<leader>oo' },
            { 'Search Obsidian', '<leader>os' },
            { 'Quick switch', '<leader>oq' },
            { 'Generate TOC', '<leader>mt' },
            { 'Markdown preview', '<leader>mp' },
          },

          -- Theme & UI
          ['Theme & UI'] = {
            { 'Dynamic theme switcher (All themes)', '<leader>ct' },
            { 'Available themes: Catppuccin, Cyberdream, Rose Pine + more', 'ℹ️' },
            { 'Toggle relative numbers', '<leader>ur' },
            { 'Toggle word wrap', '<leader>uw' },
            { 'Toggle spelling', '<leader>us' },
            { 'Toggle conceallevel', '<leader>uc' },
            { 'Toggle inlay hints', '<leader>uh' },
          },

          -- Session Management  
          ['Sessions'] = {
            { 'Save session', '<leader>qs' },
            { 'Load session', '<leader>ql' },
            { 'Delete session', '<leader>qd' },
          },

          -- Terminal Integration (NEW!)
          ['Terminal'] = {
            { 'Quick toggle terminal', '<C-\\>' },
            { 'Float terminal', '<leader>tf' },
            { 'Horizontal terminal', '<leader>th' },
            { 'Vertical terminal', '<leader>tv' },
            { 'Enhanced LazyGit', '<leader>gg' },
            { 'Toggle main terminal', '<leader>tm' },
            { 'Toggle all terminals', '<leader>ta' },
            { 'Send selection to terminal', '<leader>tx (visual)' },
            { 'Terminal: Exit insert mode', '<Esc> or jk' },
            { 'Terminal: Navigate panes', '<C-h/j/k/l>' },
          },

          -- Code Navigation & Structure (NEW!)
          ['Code Navigation (Aerial)'] = {
            { 'Toggle code outline sidebar', '<leader>ao' },
            { 'Toggle navigation window', '<leader>ax' },
            { 'Floating symbol outline', '<leader>al' },
            { 'Search symbols (Telescope)', '<leader>ay' },
            { 'Next/prev symbol', ']] / [[' },
            { 'Next/prev function', ']f / [f' },
            { 'Next/prev struct/class', ']c / [c' },
            { 'Next/prev method', ']m / [m' },
          },

          -- Enhanced Git Diff & Merge (NEW!)
          ['Git Diff & Merge (Diffview)'] = {
            { 'Open diff view', '<leader>gdo' },
            { 'Close diff view', '<leader>gdc' },
            { 'Toggle file panel', '<leader>gdt' },
            { 'Focus file panel', '<leader>gdf' },
            { 'Compare with branch/commit', '<leader>gdm' },
            { 'File history (git log)', '<leader>ghf' },
            { 'All files history', '<leader>gha' },
            { 'Git log with diffs', '<leader>ghl' },
            { 'Resolve merge conflicts', '<leader>gxo' },
            { '3-way merge current file', '<leader>gx3' },
          },

          -- Merge Conflict Resolution
          ['Merge Conflicts'] = {
            { 'Choose OURS (current branch)', '<leader>co' },
            { 'Choose THEIRS (incoming)', '<leader>ct' },
            { 'Choose BASE (merge base)', '<leader>cb' },
            { 'Choose ALL (keep both)', '<leader>ca' },
            { 'Navigate conflicts', ']x / [x' },
            { 'Delete conflict region', 'dx' },
          },

          -- AI Assistant (Avante.nvim)
          ['AI Assistant (Avante)'] = {
            { 'Ask AI about code', '<leader>aa' },
            { 'New AI conversation', '<leader>an' },
            { 'Edit with AI', '<leader>ae' },
            { 'Focus AI sidebar', '<leader>af' },
            { 'Toggle AI sidebar', '<leader>at' },
            { 'Refresh AI response', '<leader>ar' },
            { 'Add current file to context', '<leader>ac' },
            { 'Add all buffers to context', '<leader>aB' },
            { 'Select AI model', '<leader>a?' },
            { 'AI history', '<leader>aH' },
            { 'Stop AI generation', '<leader>aS' },
          },

          -- Help & Utility
          ['Help & Utility'] = {
            { 'Open this cheatsheet!', '<leader>ch' },
            { 'Search keymaps', '<leader>fk' },
            { 'Check Neovim health', ':checkhealth' },
            { 'Multi-cursor next', '<C-n>' },
            { 'Multi-cursor down/up', '<C-Down/Up>' },
          },
        },
      })
    end,
  },
}