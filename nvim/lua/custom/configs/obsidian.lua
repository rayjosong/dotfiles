local obsidian = require("obsidian")

obsidian.setup({
  workspaces = {
    -- {
    --   name = "personal",
    --   path = "~/vaults/personal",
    -- },
    {
      name = "work",
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Sync Vault",
    },
    {
      name = "personal",
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/",
    },
  },
  templates = {
      subdir = "$templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
  },
  disable_frontmatter = true,
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

  -- see below for full list of options 👇
})
