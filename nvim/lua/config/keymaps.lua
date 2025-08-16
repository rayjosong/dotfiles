-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ============================================================================
-- DEBUGGING (DAP) - Reorganized to avoid conflicts with LazyVim defaults
-- ============================================================================
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Debug: Toggle breakpoint" })
map("n", "<leader>dw", function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scope)
  sidebar.open()
end, { desc = "Debug: Widgets sidebar" })

-- Go debugging - moved to <leader>dg for "debug go" to avoid conflicts
map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "Debug: Go test" })
map("n", "<leader>dgl", function()
  require("dap-go").debug_last()
end, { desc = "Debug: Last Go test" })

-- ============================================================================
-- TABLE OF CONTENTS (nvim-toc) - Changed from <leader>toc to avoid conflict
-- ============================================================================
map("n", "<leader>mt", function()
  require("nvim-toc").generate_md_toc("list")
end, { desc = "Markdown: Generate TOC" })

-- ============================================================================
-- GOPHER (Go utilities) - Reorganized to avoid conflicts
-- ============================================================================
map("n", "<leader>gtj", "<cmd>GoTagAdd json<CR>", { desc = "Go: Add JSON tags" })
map("n", "<leader>gte", "<cmd>GoIfErr<CR>", { desc = "Go: Generate if err" })

-- ============================================================================
-- LAZYGIT - Terminal configuration handles this mapping
-- ============================================================================
-- Note: <leader>gg is handled by terminal.lua for enhanced lazygit integration

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
-- Note: Window maximizer keybindings are now handled by vim-maximizer plugin
-- in plugins/editor.lua: <leader>z and <C-w>z

-- Fallback window zoom function (if vim-maximizer doesn't work)
local function toggle_zoom()
  if vim.t.zoomed then
    -- Restore: equalize all windows
    vim.cmd("wincmd =")
    vim.t.zoomed = false
    print("Window restored")
  else
    -- Maximize: make current window full size
    vim.cmd("wincmd |")
    vim.cmd("wincmd _")
    vim.t.zoomed = true
    print("Window maximized")
  end
end

-- Alternative zoom keymap (fallback) - same key as main but capitalized
map("n", "<leader>Z", toggle_zoom, { desc = "Zoom Window (Toggle Fallback)" })

-- Additional restore keymap for clarity
map("n", "<leader>zr", function()
  vim.cmd("wincmd =")
  vim.t.zoomed = false
  print("All windows restored to equal size")
end, { desc = "Restore All Windows" })

-- ============================================================================
-- MARKS MANAGEMENT - Intuitive mark removal
-- ============================================================================
-- Set marks: ma, mb, mA, etc. (built-in vim)
-- Jump to marks: 'a, 'b, 'A, etc. (built-in vim)
-- Remove marks: dm + letter (custom, intuitive)

-- Delete single mark function
local function delete_mark()
  local char = vim.fn.getcharstr()
  if char and char ~= "" then
    vim.cmd("delmarks " .. char)
    print("Deleted mark '" .. char .. "'")
  end
end

-- Delete mark keybinding (dm + letter pattern)
map("n", "dm", delete_mark, { desc = "Delete mark (dm + letter)" })

-- Delete all marks in current buffer
map("n", "<leader>dm", "<cmd>delmarks!<cr>", { desc = "Delete all marks" })

-- Show all marks
map("n", "<leader>sm", "<cmd>marks<cr>", { desc = "Show all marks" })

-- ============================================================================
-- TODO COMMENTS (LazyVim includes these by default, but keeping custom ones)
-- ============================================================================
-- Note: LazyVim already provides ]t, [t, <leader>st, <leader>sT
-- Keeping these for explicit documentation

-- ============================================================================
-- TMUX NAVIGATION
-- ============================================================================
-- Note: Tmux navigation keybindings are now handled by vim-tmux-navigator plugin
-- in plugins/editor.lua to ensure proper lazy loading


-- ============================================================================
-- GIT UTILITIES
-- ============================================================================
map("n", "<leader>gb", "<cmd>BlamerToggle<cr>", { desc = "Git Blame" })
map("n", "<leader>gy", function()
  require("gitlinker").get_buf_range_url("n")
end, { desc = "Copy git link" })

-- ============================================================================
-- CODE FOLDING - Intuitive shortcuts for nvim-ufo
-- ============================================================================
-- Use default vim folding commands (za, zc, zo) with UFO enhancements
-- UFO automatically enhances these when loaded

-- Advanced folding operations
map("n", "<leader>zf", function() require("ufo").closeAllFolds() end, { desc = "Close ALL folds" })
map("n", "<leader>zo", function() require("ufo").openAllFolds() end, { desc = "Open ALL folds" })

-- UFO-specific features
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })

-- Go-specific folding shortcuts
map("n", "<leader>gf", function()
  -- Close all Go function folds
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    if line:match("^%s*func%s+") then
      vim.cmd("normal! " .. i .. "Gzc")
    end
  end
end, { desc = "Fold all Go functions" })

map("n", "<leader>gs", function()
  -- Close all Go struct folds  
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    if line:match("^%s*type%s+%w+%s+struct") then
      vim.cmd("normal! " .. i .. "Gzc")
    end
  end
end, { desc = "Fold all Go structs" })

-- ============================================================================
-- TESTING (Neotest)
-- ============================================================================
map("n", "<leader>tt", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run file" })
map("n", "<leader>tT", function()
  require("neotest").run.run(vim.loop.cwd())
end, { desc = "Run all test files" })
map("n", "<leader>tr", function()
  require("neotest").run.run()
end, { desc = "Run Nearest" })
map("n", "<leader>tl", function()
  require("neotest").run.run_last()
end, { desc = "Run Last" })
map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle Summary" })
map("n", "<leader>to", function()
  require("neotest").output.open({ enter = true, auto_close = true })
end, { desc = "Show Output" })
map("n", "<leader>tO", function()
  require("neotest").output_panel.toggle()
end, { desc = "Toggle Output Panel" })
map("n", "<leader>tS", function()
  require("neotest").run.stop()
end, { desc = "Stop" })

-- ============================================================================
-- OBSIDIAN
-- ============================================================================
map("n", "<leader>on", ":ObsidianNew<CR>", { desc = "Creating new note" })
map("n", "<leader>ot", ":ObsidianTemplate<CR>", { desc = "Insert template" })
map("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "Open Obsidian in GUI" })

-- ============================================================================
-- BUFFER NAVIGATION (Enhanced for easier tab-like behavior)
-- ============================================================================
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- ============================================================================
-- DYNAMIC THEME SWITCHING
-- ============================================================================
map("n", "<leader>ct", function()
  -- Function to get all available colorschemes
  local function get_colorschemes()
    local colorschemes = {}
    
    -- Get all available colorschemes from runtime path
    local colors_dirs = vim.api.nvim_get_runtime_file("colors/*.vim", true)
    local colors_lua_dirs = vim.api.nvim_get_runtime_file("colors/*.lua", true)
    
    -- Process .vim colorscheme files
    for _, file in ipairs(colors_dirs) do
      local name = vim.fn.fnamemodify(file, ":t:r")
      if name ~= "" then
        table.insert(colorschemes, name)
      end
    end
    
    -- Process .lua colorscheme files
    for _, file in ipairs(colors_lua_dirs) do
      local name = vim.fn.fnamemodify(file, ":t:r")
      if name ~= "" then
        table.insert(colorschemes, name)
      end
    end
    
    -- Add plugin-specific colorschemes that might not be in colors/ directory
    local plugin_themes = {
      "catppuccin",
      "catppuccin-latte",
      "catppuccin-frappe", 
      "catppuccin-macchiato",
      "catppuccin-mocha",
      "cyberdream",
      "rose-pine",
      "rose-pine-main",
      "rose-pine-moon", 
      "rose-pine-dawn",
      "tokyonight",
      "tokyonight-night",
      "tokyonight-storm",
      "tokyonight-day",
      "tokyonight-moon",
    }
    
    -- Add plugin themes if they're not already in the list
    for _, theme in ipairs(plugin_themes) do
      local exists = false
      for _, existing in ipairs(colorschemes) do
        if existing == theme then
          exists = true
          break
        end
      end
      if not exists then
        -- Test if the colorscheme actually exists by trying to load it silently
        local ok = pcall(vim.cmd.colorscheme, theme)
        if ok then
          table.insert(colorschemes, theme)
          -- Restore current colorscheme
          pcall(vim.cmd.colorscheme, vim.g.colors_name or "default")
        end
      end
    end
    
    -- Remove duplicates and sort
    local unique_colorschemes = {}
    local seen = {}
    for _, name in ipairs(colorschemes) do
      if not seen[name] then
        seen[name] = true
        table.insert(unique_colorschemes, name)
      end
    end
    
    table.sort(unique_colorschemes)
    return unique_colorschemes
  end
  
  -- Get current colorscheme for highlighting
  local current_colorscheme = vim.g.colors_name or "default"
  
  -- Get all available colorschemes
  local colorschemes = get_colorschemes()
  
  -- Create formatted list with current scheme highlighted
  local formatted_schemes = {}
  for _, scheme in ipairs(colorschemes) do
    if scheme == current_colorscheme then
      table.insert(formatted_schemes, "● " .. scheme .. " (current)")
    else
      table.insert(formatted_schemes, "  " .. scheme)
    end
  end
  
  vim.ui.select(formatted_schemes, {
    prompt = "Select colorscheme (" .. #colorschemes .. " available):",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice then
      -- Extract the actual colorscheme name (remove formatting)
      local scheme_name = choice:gsub("^[● ]*", ""):gsub(" %(current%)$", "")
      
      -- Apply the colorscheme
      local ok, err = pcall(vim.cmd.colorscheme, scheme_name)
      if ok then
        vim.notify("Applied colorscheme: " .. scheme_name, vim.log.levels.INFO)
      else
        vim.notify("Failed to apply colorscheme: " .. scheme_name .. "\nError: " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end)
end, { desc = "Change colorscheme (dynamic)" })

-- Note: File operations (telescope), buffer management, and other core keybindings
-- are explicitly configured in plugins/telescope.lua and should work:
-- <leader>ff - Find files (fuzzy finder)
-- <leader>fg - Live grep (MAIN GLOBAL SEARCH) 🔥
-- <leader>fw - Search word under cursor globally
-- <leader>fb - Find buffers  
-- <leader>fr - Recent files
-- <leader>, - Buffer picker (fuzzy search)
-- <leader>e  - Focus file tree
-- H/L - Previous/Next buffer (LazyVim default)
