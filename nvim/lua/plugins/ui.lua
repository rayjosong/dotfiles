-- UI and UX Enhancement Plugins
-- Only custom plugins not provided by LazyVim defaults

return {
  -- Custom nvim-notify configuration (LazyVim includes it, but we override for opacity)
  {
    "rcarriga/nvim-notify",
    opts = {
      opacity = 20, -- Your custom opacity setting
      timeout = 3000,
    },
  },

  -- Custom noice configuration (LazyVim includes it, but we override for your layout)
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
    },
  },

  -- Custom lualine theme configuration (LazyVim includes it, but we set catppuccin theme)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Only set catppuccin theme if it's loaded
      if pcall(require, "catppuccin") then
        opts.options = opts.options or {}
        opts.options.theme = "catppuccin"
      end
    end,
  },
}