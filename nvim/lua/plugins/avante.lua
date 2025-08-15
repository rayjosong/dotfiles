return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  opts = {
    -- Provider configuration - using Claude as default
    provider = "claude", -- recommend using Claude
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.7,
          max_tokens = 4096,
        },
      },
    },
    -- Behavior configuration optimized for your workflow
    behaviour = {
      auto_suggestions = false, -- Keep false for now, still experimental
      auto_set_keymaps = true, -- Let avante set safe keymaps
      auto_set_highlight_group = true,
      auto_apply_diff_after_generation = false, -- Keep manual control
      auto_focus_sidebar = true,
      support_paste_from_clipboard = false,
    },
    -- Window configuration to match your UI preferences
    windows = {
      position = "right", -- Matches your neo-tree on left
      wrap = true,
      width = 30, -- 30% of screen width
      sidebar_header = {
        align = "center",
        rounded = true,
      },
    },
    -- Integrations with your existing LazyVim setup
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
    },
    -- File selector integration with telescope (you already have)
    file_selector = {
      provider = "telescope",
    },
    -- Enhanced diff mappings for code review workflow
    mappings = {
      diff = {
        ours = "co",     -- keep our changes
        theirs = "ct",   -- accept their changes  
        all_theirs = "ca", -- accept all their changes
        both = "cb",     -- keep both changes
        cursor = "cc",   -- cursor position
        next = "]x",     -- next conflict
        prev = "[x",     -- previous conflict
      },
      suggestion = {
        accept = "<M-l>",    -- Alt+l to accept suggestion
        next = "<M-]>",      -- Alt+] next suggestion
        prev = "<M-[>",      -- Alt+[ previous suggestion
        dismiss = "<C-]>",   -- Ctrl+] dismiss suggestion
      },
      -- Main avante keybindings (avoiding conflicts with your setup)
      ask = "<leader>aa",        -- Ask avante
      new_ask = "<leader>an",    -- New ask
      edit = "<leader>ae",       -- Edit with avante
      refresh = "<leader>ar",    -- Refresh
      focus = "<leader>af",      -- Focus sidebar
      toggle = {
        default = "<leader>at",    -- Toggle avante
        debug = "<leader>ad",      -- Toggle debug
        hint = "<leader>ah",       -- Toggle hints
        suggestion = "<leader>as", -- Toggle suggestions
        repomap = "<leader>aR",    -- Toggle repository map
      },
      files = {
        add_current = "<leader>ac",  -- Add current buffer
        add_all_buffers = "<leader>aB", -- Add all buffers
      },
      select_model = "<leader>a?",   -- Select AI model
      select_history = "<leader>aH", -- Select history (avoiding conflict with hint)
      -- Sidebar navigation
      sidebar = {
        apply_all = "A",           -- Apply all suggestions
        apply_cursor = "a",        -- Apply at cursor
        switch_windows = "<Tab>",  -- Switch between windows
        reverse_switch_windows = "<S-Tab>",
        close = { "q" },          -- Close sidebar
      },
    },
  },
  -- Dependencies required for avante to work
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- Optional dependencies that integrate with your LazyVim setup
    "nvim-telescope/telescope.nvim", -- You already have this - for file_selector
    "hrsh7th/nvim-cmp", -- You already have this - for autocompletion
    "stevearc/dressing.nvim", -- You already have this - for input UI
    "nvim-tree/nvim-web-devicons", -- You already have this - for icons
    {
      -- Make sure we have a compatible image support (optional)
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings for markdown files
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure avante has Catppuccin theme support
      "MeanderingProgrammer/render-markdown.nvim",
      optional = true, -- optional dependency for enhanced markdown rendering
      ft = { "markdown", "Avante" },
    },
  },
  -- Integration with your existing file explorers
  config = function(_, opts)
    require("avante").setup(opts)
    
    -- Neo-tree integration (since you use neo-tree)
    -- Add shortcut to add files from neo-tree to avante
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.keymap.set("n", "<leader>a+", function()
          local node = require("neo-tree.sources.filesystem").get_node()
          if node then
            local filepath = node:get_id()
            local relative_path = require("avante.utils").relative_path(filepath)
            local sidebar = require("avante").get()
            
            -- Ensure avante sidebar is open
            if not sidebar:is_open() then
              require("avante.api").ask()
              sidebar = require("avante").get()
            end
            
            sidebar.file_selector:add_selected_file(relative_path)
          end
        end, { desc = "Add file to Avante context", buffer = true })
      end,
    })
  end,
}