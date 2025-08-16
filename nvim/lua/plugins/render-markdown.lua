-- Alternative markdown rendering plugin that works reliably
-- Renders markdown and mermaid directly in the buffer

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ft = { "markdown" },
    keys = {
      {
        "<leader>mr",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Toggle Render Markdown (In-Buffer)",
      },
    },
    opts = {
      -- Configuration for rendering
      heading = {
        -- Turn on / off heading icon & background rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = true,
        -- Replaces '#+' of headings
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- Added to the sign column if enabled
        signs = { "󰫎 " },
        -- Width of the heading background:
        --  block: width of the heading text
        --  full: full width of the window
        width = "full",
        -- Amount of margin to add to the left of headings
        left_margin = 0,
        -- Amount of padding to add to the left of headings
        left_pad = 0,
        -- Amount of padding to add to the right of headings
        right_pad = 0,
        -- Minimum width to use for headings
        min_width = 0,
        -- Determins if a border is added above and below headings
        border = false,
        -- Highlight the start of the border using the foreground highlight
        border_prefix = false,
        -- Used above and below the heading for a border
        above = "▄",
        below = "▀",
      },
      code = {
        -- Turn on / off code block & inline code rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = true,
        -- Determines how code blocks & inline code are rendered:
        --  none: disables all rendering
        --  normal: adds highlight group to code blocks & inline code
        --  language: adds language icon to sign column if enabled and icon + name above code blocks
        --  full: normal + language
        style = "full",
        -- Amount of padding to add to the left of code blocks
        left_pad = 0,
        -- Amount of padding to add to the right of code blocks
        right_pad = 0,
        -- Width of the code block background:
        --  block: width of the code block
        --  full: full width of the window
        width = "full",
        -- Determins how the top / bottom of code block are rendered:
        --  thick: use the same highlight as the code body
        --  thin: when lines are empty overlay the above & below icons
        border = "thin",
        -- Used above and below the code block for a border
        above = "▄",
        below = "▀",
        -- Highlight for the border
        highlight = "RenderMarkdownCode",
      },
      -- Configuration for mermaid diagrams
      pipe_table = {
        -- Turn on / off pipe table rendering
        enabled = true,
        -- Determines how the table as a whole is rendered:
        --  none: disables all rendering
        --  normal: applies the 'cell' style rendering to each part of the table
        --  full: normal + a top & bottom line that fill out the table when lengths
        --        are not the same
        style = "full",
        -- Determines how individual cells of a table are rendered:
        --  overlay: writes completely over the table, removing conceal behavior
        --  raw: replaces only the '|' characters in each row, leaving the cell
        --       data completely unmodified, this is the 'safest' option
        --  padded: raw + cells are padded with whitespace to make the table appear to
        --          be properly aligned
        --  trimmed: padded + cells are trimmed according to the alignment information
        cell = "padded",
        -- Characters used to replace table border
        -- Correspond to top, right, bottom, left, and intersection
        -- stylua: ignore
        border = {
          "┌", "┐", "└", "┘", "│", "─", "├", "┤", "┬", "┴", "┼",
        },
        -- Highlight for table heading, body, and border
        head = "RenderMarkdownTableHead",
        row = "RenderMarkdownTableRow",
        filler = "RenderMarkdownTableFill",
      },
    },
  },
}