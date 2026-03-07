-- Display marks in the sign column (gutter)
-- https://github.com/chentau/marks.nvim

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    -- builtin_marks = { ".", "<", ">", "^" }, -- show builtin marks
    -- cyclic = true, -- next/prev mark wraps around
    -- force_write_shada = false, -- update shada on write
    -- refresh_interval = 250, -- update marks display interval
    sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 }, -- sign priority
    -- mark符号
    builtin_marks = { ".", "<", ">", "^" },
    bookmark_1 = "🔖",
    bookmark_2 = "💡",
    bookmark_3 = "⭐",
    bookmark_4 = "⚠️",
    bookmark_5 = "❗",
    bookmark_6 = "📌",
    bookmark_7 = "📍",
    bookmark_8 = "🎯",
    bookmark_9 = "🔥",
    bookmark_0 = "💎",

    -- mappings that aren't set (custom overrides handled in keymaps.lua)
    -- delete mark: dm handled in keymaps.lua
  },
}
