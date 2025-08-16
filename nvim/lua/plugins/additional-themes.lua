-- Additional Theme Configurations
-- Cyberdream and Rose Pine themes

return {
  -- Cyberdream theme - Modern cyberpunk theme
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Enable transparent background
        transparent = false,
        
        -- Enable italics comments
        italic_comments = true,
        
        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = false,
        
        -- Modern borderless telescope theme - also applies to fzf-lua
        borderless_telescope = true,
        
        -- Set terminal colors used in `:terminal`
        terminal_colors = true,
        
        -- Improve performance by caching highlights. Generate cache with ':CyberdreamBuildCache' and clear it with ':CyberdreamClearCache'
        cache = false,
        
        theme = {
          variant = "default", -- use "light" for the light variant. Also accepts "auto" to set it based on vim.o.background
          highlights = {
            -- Highlight groups to override, adding new groups is also possible
            -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values
            
            -- Example:
            -- Comment = { fg = "#696969", bg = "NONE", italic = true },
            
            -- Complete list can be found in `lua/cyberdream/theme.lua`
          },
          
          -- Override a highlight group entirely using the color palette
          overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
            -- Example:
            return {
              Comment = { fg = colors.green, bg = "NONE", italic = true },
              ["@property"] = { fg = colors.magenta, bold = true },
            }
          end,
          
          -- Override a color entirely
          colors = {
            -- For a list of colors see `lua/cyberdream/colours.lua`
            -- Example:
            -- bg = "#000000",
            -- green = "#00ff00",
          },
        },
        
        -- Minimal extensions configuration for compatibility
        extensions = {
          telescope = true, -- Keep telescope as it's widely compatible
          -- Disable all other extensions to prevent module loading errors
        },
      })
    end,
  },
  
  -- Rose Pine theme - Soho vibes for Neovim
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, 
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, dawn
        dark_variant = "main", -- main, moon, dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        
        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
        
        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },
        
        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",
          
          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",
          
          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",
          
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
        
        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },
        
        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      })
    end,
  },
}