-- Markdown and Documentation Tools
-- Obsidian integration, markdown utilities from your NvChad setup

return {
  -- Obsidian integration with exact workspace configuration
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian").setup({
        follow_url_func = function(url)
          -- Open the URL in the default web browser (Mac OS)
          vim.fn.jobstart({"open", url})
          -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
        
        -- Exact workspace configuration from your NvChad setup
        workspaces = {
          {
            name = "work",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/foodpanda/",
          },
          {
            name = "personal",
            path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/",
          },
        },
        
        -- Template configuration
        templates = {
          subdir = "$templates",
          date_format = "%Y-%m-%d-%a",
          time_format = "%H:%M",
        },
        
        -- Daily notes configuration
        daily_notes = {
          -- Optional, if you keep daily notes in a separate directory
          folder = "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/foodpanda/$dailies",
          -- Optional, if you want to change the date format for the ID of daily notes
          date_format = "%Y-%m-%d",
          -- Optional, if you want to change the date format of the default alias of daily notes
          alias_format = "%B %-d, %Y",
          -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
          template = "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/foodpanda/$templates/daily-note.md"
        },
        
        disable_frontmatter = true,
        
        -- UI configuration with exact colors from your setup
        ui = {
          enable = true,
          checkboxes = {
            [" "] = { char = "☐", hl_group = "ObsidianTodo" },
            ["x"] = { char = "✔", hl_group = "ObsidianDone" },
          },
          bullets = { char = "•", hl_group = "ObsidianBullet" },
          reference_text = { hl_group = "ObsidianRefText" },
          highlight_text = { hl_group = "ObsidianHighlightText" },
          tags = { hl_group = "ObsidianTag" },
          block_ids = { hl_group = "ObsidianBlockID" },
          hl_groups = {
            -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
          },
        }
      })
    end,
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian Note" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Insert Template" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch" },
    },
  },

  -- Markdown bullets for enhanced list editing
  {
    "bullets-vim/bullets.vim",
    ft = "markdown",
    config = function()
      -- Enable bullets for markdown files
      vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
      vim.g.bullets_outline_levels = { "ROM", "ABC", "num", "abc", "rom", "i)", "a)", "I)", "A)" }
    end,
  },

  -- Table of contents generation
  {
    "richardbizik/nvim-toc",
    ft = "markdown",
    config = function()
      require("nvim-toc").setup({
        toc_header = "Table of Contents",
      })
    end,
    keys = {
      { "<leader>mt", function() require("nvim-toc").generate_md_toc("list") end, desc = "Markdown: Generate TOC" },
    },
  },

  -- Enhanced markdown support (builds on LazyVim markdown extras)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },

  -- Mason tools for markdown
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "markdownlint",
        "markdown-toc",
        "mdformat",
      })
    end,
  },
}