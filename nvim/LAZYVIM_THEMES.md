# 🎨 LazyVim Themes Guide

## Current Theme Setup
You're currently using **Catppuccin** which is an excellent choice! It's modern, well-maintained, and has great LazyVim integration.

**Current Configuration** (in `lua/config/options.lua`):
```lua
vim.g.lazyvim_colorscheme = "catppuccin"
```

## 🔥 Popular Theme Recommendations

### **Tier 1: Premium Themes** ⭐⭐⭐
**Best overall themes with excellent LazyVim support**

#### **1. Catppuccin** (Your Current Choice) ✅
- **Flavors**: Latte (light), Frappé, Macchiato, Mocha (dark)
- **Pros**: Excellent LazyVim integration, modern design, great plugin support
- **Best For**: Professional development, long coding sessions
- **Colors**: Warm pastels, easy on the eyes

#### **2. Tokyo Night** 🌃
- **Variants**: Night, Storm, Day
- **Pros**: Very popular, excellent contrast, vibrant but not overwhelming
- **Best For**: Dark theme lovers, VS Code migrants
- **Colors**: Purple/blue accent, great syntax highlighting

#### **3. Rose Pine** 🌹
- **Variants**: Main, Moon, Dawn
- **Pros**: Unique aesthetic, low contrast, very elegant
- **Best For**: Minimal aesthetic lovers, reduced eye strain
- **Colors**: Muted pastels, rose gold accents

### **Tier 2: Solid Choices** ⭐⭐
**Great themes with good LazyVim support**

#### **4. Gruvbox** 🏕️
- **Variants**: Dark, Light
- **Pros**: Classic, retro feel, excellent readability
- **Best For**: Traditional vim users, warm color preference
- **Colors**: Brown/orange base, vintage terminal feel

#### **5. Nord** ❄️
- **Style**: Arctic, minimal
- **Pros**: Clean, professional, blue-based
- **Best For**: Cool color lovers, minimal distraction
- **Colors**: Arctic blue palette

#### **6. Dracula** 🧛
- **Style**: Dark with purple accents
- **Pros**: High contrast, vibrant, fun
- **Best For**: Dark theme enthusiasts, bold colors
- **Colors**: Purple, pink, cyan highlights

### **Tier 3: Specialized Themes** ⭐
**Good themes for specific use cases**

#### **7. Solarized** ☀️
- **Variants**: Dark, Light
- **Pros**: Scientific color selection, balanced contrast
- **Best For**: Light/dark switching, academic work
- **Colors**: Carefully selected scientific palette

#### **8. Kanagawa** 🌊
- **Style**: Japanese-inspired
- **Pros**: Unique aesthetic, warm earth tones
- **Best For**: Aesthetic enthusiasts, warm colors
- **Colors**: Traditional Japanese ink painting inspired

## 🔧 How to Change Themes

### **Method 1: Quick Test (Temporary)**
```vim
:colorscheme tokyo-night
:colorscheme rose-pine
:colorscheme gruvbox
```

### **Method 2: Permanent Change**
Edit `lua/config/options.lua`:
```lua
-- Change this line:
vim.g.lazyvim_colorscheme = "tokyo-night"
-- or
vim.g.lazyvim_colorscheme = "rose-pine"
-- or
vim.g.lazyvim_colorscheme = "gruvbox"
```

### **Method 3: Add New Themes**
Create or edit `lua/plugins/colorscheme.lua`:

```lua
return {
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- night, storm, day
      transparent = false,
      terminal_colors = true,
    },
  },
  
  -- Rose Pine theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "main", -- main, moon, dawn
      dark_variant = "main",
    },
  },
  
  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
    },
  },
  
  -- Configure LazyVim to use your theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyo-night", -- Change this to your preference
    },
  },
}
```

## 🎨 Theme Comparison

### **For Go Development** (Your Main Use Case)
1. **Catppuccin** ✅ - Your current choice, excellent for Go syntax
2. **Tokyo Night** - Great Go syntax highlighting, popular choice
3. **Rose Pine** - Easy on eyes for long Go coding sessions

### **For Professional Work**
1. **Catppuccin** - Professional, not distracting
2. **Nord** - Clean, corporate-friendly
3. **Solarized** - Academic, professional standard

### **For Eye Comfort**
1. **Rose Pine** - Low contrast, gentle on eyes
2. **Catppuccin** - Balanced, not too bright
3. **Gruvbox** - Warm, retro comfort

### **For Dark Theme Lovers**
1. **Tokyo Night** - Vibrant dark theme
2. **Dracula** - High contrast dark
3. **Catppuccin Mocha** - Modern dark elegance

## 🔄 Theme Switcher Setup

Add this to your `lua/config/keymaps.lua` for quick theme switching:

```lua
-- Theme switching
map("n", "<leader>ct", function()
  vim.ui.select({
    "catppuccin",
    "tokyonight",
    "rose-pine",
    "gruvbox",
    "nord",
    "dracula",
  }, {
    prompt = "Select colorscheme:",
  }, function(choice)
    if choice then
      vim.cmd("colorscheme " .. choice)
    end
  end)
end, { desc = "Change colorscheme" })
```

## 📊 My Recommendations

### **Stick with Catppuccin** ✅
**Why your current choice is excellent:**
- Perfect LazyVim integration (already configured)
- Excellent Go syntax highlighting
- Professional appearance
- Great plugin support (git, LSP, etc.)
- Multiple variants (try Catppuccin Latte for light mode)

### **If You Want to Try Something New:**
1. **Tokyo Night** - Most popular alternative, similar vibe
2. **Rose Pine** - If you want something unique and gentle
3. **Gruvbox** - If you want classic vim aesthetics

### **Testing Strategy:**
1. Keep Catppuccin as default
2. Install Tokyo Night and Rose Pine
3. Use `<leader>ct` to switch quickly
4. Test for a week each
5. Keep what feels best for your workflow

## 🚀 Advanced Theme Features

### **Catppuccin Variants** (Your Current Theme)
```lua
-- In your catppuccin config
{
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    },
  },
}
```

### **Light/Dark Mode Switching**
```lua
-- Add to keymaps for quick light/dark toggle
map("n", "<leader>bg", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { desc = "Toggle background" })
```

## 💡 Pro Tips

1. **Stick with well-maintained themes** - They have better LazyVim integration
2. **Test themes during different times** - Morning vs evening preferences differ
3. **Consider your monitor setup** - OLED vs LCD affects theme choice
4. **Match your terminal theme** - Keep consistency across your setup
5. **Don't change too often** - Let your eyes adjust for at least a week

## 🎯 My Final Recommendation

**Keep Catppuccin!** 🎉

Your current setup is excellent because:
- ✅ Already perfectly configured with LazyVim
- ✅ Great for Go development (your main use case)
- ✅ Professional and modern
- ✅ Excellent plugin integration
- ✅ Multiple variants to experiment with

**If you want variety:** Try the Catppuccin variants first:
- `catppuccin-latte` - Beautiful light theme
- `catppuccin-macchiato` - Warmer dark theme
- `catppuccin-frappe` - Balanced middle option

This gives you variety while keeping the excellent integration you already have!

---

**Quick Start:** Use `:colorscheme catppuccin-latte` to try the light version right now!