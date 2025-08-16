-- Telescope configuration with fallback support for missing tools
local function get_fd_command()
  -- Check for fd in common locations
  local fd_paths = {
    "/opt/homebrew/bin/fd",  -- Homebrew (Apple Silicon)
    "/usr/local/bin/fd",     -- Homebrew (Intel)
    "/usr/bin/fd",           -- System package
    "fd",                    -- In PATH
  }
  
  for _, path in ipairs(fd_paths) do
    if vim.fn.executable(path) == 1 then
      return { path, "--type", "f", "--strip-cwd-prefix" }
    end
  end
  
  -- Fallback to find command
  return { "find", ".", "-type", "f" }
end

local function get_rg_command()
  -- Check for ripgrep in common locations
  local rg_paths = {
    "/opt/homebrew/bin/rg",  -- Homebrew (Apple Silicon)
    "/usr/local/bin/rg",     -- Homebrew (Intel)
    "/usr/bin/rg",           -- System package
    "rg",                    -- In PATH
  }
  
  for _, path in ipairs(rg_paths) do
    if vim.fn.executable(path) == 1 then
      return {
        path,
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
        "--glob=!node_modules/",
      }
    end
  end
  
  -- Fallback to grep command
  return { "grep", "-r", "-n", "-H" }
end

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Override LazyVim defaults to ensure they work
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Global Search)" },
    { "<leader>fw", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") }) end, desc = "Search Word Under Cursor" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Current Buffer" },
  },
  opts = function()
    local fd_command = get_fd_command()
    local rg_command = get_rg_command()
    
    return {
      defaults = {
        -- Use detected fd command or fallback
        find_command = fd_command,
        -- Use detected ripgrep command or fallback
        vimgrep_arguments = rg_command,
      },
      pickers = {
        find_files = {
          find_command = fd_command,
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            -- Only add args if using ripgrep
            if rg_command[1]:match("rg") then
              return { "--hidden", "--glob=!.git/", "--glob=!node_modules/" }
            end
            return {}
          end,
        },
      },
    }
  end,
}