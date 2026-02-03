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
-- TABLE OF CONTENTS (nvim-toc)
-- ============================================================================
-- Note: <leader>mt is handled by plugins/markdown.lua

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
-- Note: Window maximizer keybindings are handled by vim-maximizer plugin
-- in plugins/editor.lua: <leader>z and <C-w>z

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
-- Note: <leader>gb (Git Blame) is handled by git.lua plugin
-- Note: <leader>gy keymap is handled by gitlinker.nvim plugin in git.lua

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

-- Live grep (interactive global search)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep (Global Search)" })

-- Live grep (interactive search) - also available as <leader>fG
map("n", "<leader>fG", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep (Interactive Search)" })

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
-- Note: Obsidian keymaps are handled by plugins/markdown.lua:
-- <leader>on - New note, <leader>ot - Template, <leader>oo - Open in GUI
-- <leader>os - Search, <leader>oq - Quick Switch

-- ============================================================================
-- BUFFER NAVIGATION (Enhanced for easier tab-like behavior)
-- ============================================================================
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- ============================================================================
-- SMART CURSOR MOVEMENT
-- ============================================================================

-- Smart vertical movement: if cursor is at column 0-1, move to first non-whitespace
-- Otherwise, maintain column position (Vim's default behavior)
map("n", "j", function()
  local col = vim.fn.col(".")
  if col <= 2 then -- At beginning of line (accounting for potential space)
    return "j^" -- Move down and go to first non-whitespace
  else
    return "j" -- Normal down movement
  end
end, { expr = true, desc = "Smart down movement" })

map("n", "k", function()
  local col = vim.fn.col(".")
  if col <= 2 then -- At beginning of line
    return "k^" -- Move up and go to first non-whitespace
  else
    return "k" -- Normal up movement
  end
end, { expr = true, desc = "Smart up movement" })

-- Alternative: use gj/gk for display line movement (useful with wrapping)
map("n", "gj", "j", { desc = "Move down by actual line" })
map("n", "gk", "k", { desc = "Move up by actual line" })

-- Enhanced arrow key movement (respect wrapping and indentation)
map("n", "<Down>", function()
  local col = vim.fn.col(".")
  if col <= 2 then
    return "gj^" -- Move down by display line and go to first non-whitespace
  else
    return "gj" -- Move down by display line
  end
end, { expr = true, desc = "Smart down (display line)" })

map("n", "<Up>", function()
  local col = vim.fn.col(".")
  if col <= 2 then
    return "gk^" -- Move up by display line and go to first non-whitespace
  else
    return "gk" -- Move up by display line
  end
end, { expr = true, desc = "Smart up (display line)" })

-- ============================================================================
-- RESPONSIVE DISPLAY CONTROLS
-- ============================================================================

-- Enhanced wrap toggle with smart behavior (uses LazyVim's <leader>uw but enhanced)
map("n", "<leader>uw", function()
  local current_wrap = vim.opt_local.wrap:get()
  local new_wrap = not current_wrap
  
  vim.opt_local.wrap = new_wrap
  vim.opt_local.linebreak = new_wrap -- Enable smart line breaking when wrap is on
  
  local status = new_wrap and "enabled" or "disabled"
  vim.notify("Text wrap " .. status .. " (smart)", vim.log.levels.INFO)
end, { desc = "Toggle text wrap (smart enhanced)" })

-- Toggle column guide based on current window width (avoiding LazyVim's <leader>uc)
map("n", "<leader>vg", function()
  local current_col = vim.opt_local.colorcolumn:get()
  
  if current_col == "" then
    -- Enable column guide based on window width
    local win_width = vim.api.nvim_win_get_width(0)
    local guide_col = "80"
    if win_width > 120 then
      guide_col = "100"
    elseif win_width > 80 then
      guide_col = "80"
    else
      guide_col = "70"
    end
    vim.opt_local.colorcolumn = guide_col
    vim.notify("Column guide enabled at " .. guide_col, vim.log.levels.INFO)
  else
    -- Disable column guide
    vim.opt_local.colorcolumn = ""
    vim.notify("Column guide disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle column guide (responsive)" })

-- Quick scroll offset adjustment (avoiding LazyVim's <leader>us)
map("n", "<leader>vo", function()
  local current_scrolloff = vim.opt.scrolloff:get()
  local new_scrolloff = current_scrolloff == 8 and 3 or 8
  
  vim.opt.scrolloff = new_scrolloff
  vim.opt.sidescrolloff = new_scrolloff
  
  vim.notify("Scroll offset set to " .. new_scrolloff, vim.log.levels.INFO)
end, { desc = "Toggle scroll offset (3/8)" })

-- Force responsive adjustment for current window (avoiding LazyVim's <leader>ur)
map("n", "<leader>vr", function()
  local win_width = vim.api.nvim_win_get_width(0)
  local filetype = vim.bo.filetype
  
  -- Adjust column guide
  if win_width > 120 then
    vim.opt_local.colorcolumn = "100"
  elseif win_width > 80 then
    vim.opt_local.colorcolumn = "80"
  else
    vim.opt_local.colorcolumn = ""
  end
  
  -- Apply smart wrap for text files
  local text_filetypes = { "markdown", "text", "gitcommit" }
  local is_text_file = false
  for _, ft in ipairs(text_filetypes) do
    if filetype == ft then
      is_text_file = true
      break
    end
  end
  
  if is_text_file then
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end
  
  vim.notify("Display refreshed for " .. win_width .. " columns", vim.log.levels.INFO)
end, { desc = "Force responsive display refresh" })

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

-- ============================================================================
-- COMPLETION DEBUGGING (if needed)
-- ============================================================================
map("n", "<leader>cd", function()
  local cmp = require("cmp")
  if cmp.visible() then
    vim.notify("CMP is visible", vim.log.levels.INFO)
  else
    vim.notify("CMP is not visible", vim.log.levels.INFO)
  end

  -- Show completion info
  vim.notify("completeopt: " .. table.concat(vim.opt.completeopt:get(), ","), vim.log.levels.INFO)
end, { desc = "Debug completion state" })

-- Note: File operations (telescope), buffer management, and other core keybindings
-- are explicitly configured in plugins/telescope.lua and keymaps.lua:
-- <leader>ff - Find files (fuzzy finder)
-- <leader>fg - Live grep (global search) 🔥
-- <leader>fG - Live grep (interactive search)
-- <leader>fb - Find buffers
-- <leader>fr - Recent files
-- <leader>, - Buffer picker (fuzzy search)
-- <leader>e  - Focus file tree
-- H/L - Previous/Next buffer (LazyVim default)
