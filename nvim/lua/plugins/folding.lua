-- Modern Code Folding with nvim-ufo
-- Provides intuitive folding for Go functions, structs, and other symbols
return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter", -- For treesitter folding
    },
    event = "BufRead", -- Load when reading files
    keys = {
      -- Intuitive folding keybindings
      { "<leader>zf", function() require("ufo").closeAllFolds() end, desc = "Close ALL folds" },
      { "<leader>zo", function() require("ufo").openAllFolds() end, desc = "Open ALL folds" },
      
      -- Preview fold content without opening
      { "K", function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          -- fallback to LSP hover if no fold
          vim.lsp.buf.hover()
        end
      end, desc = "Peek folded lines or LSP hover" },
    },
    config = function()
      -- nvim-ufo requires foldmethod = "expr" to work
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldcolumn = '1' -- Show fold column
      vim.o.foldlevel = 99   -- High fold level (don't auto-fold on open)
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Configure nvim-ufo
      require("ufo").setup({
        -- Use LSP with intelligent fallback handling
        provider_selector = function(bufnr, filetype, buftype)
          -- Exclude special buffers that don't need folding
          local excluded_filetypes = {
            "nvcheatsheet",
            "help", 
            "alpha",
            "dashboard", 
            "neo-tree",
            "Trouble", 
            "trouble",
            "lazy", 
            "mason",
            "notify",
            "toggleterm",
            "lazyterm"
          }
          
          local excluded_buftypes = {
            "nofile",
            "terminal", 
            "help",
            "quickfix",
            "prompt"
          }
          
          -- Skip folding for excluded buffer types or filetypes
          if vim.tbl_contains(excluded_buftypes, buftype) or 
             vim.tbl_contains(excluded_filetypes, filetype) then
            return ""
          end
          
          -- For normal files, use LSP first, then treesitter, then indent as final fallback
          return { "lsp", "indent" }
        end,
        
        -- Fold text customization (shows function signatures)
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (' 󰁂 %d lines'):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0

          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, {chunkText, hlGroup})
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          
          table.insert(newVirtText, {suffix, 'MoreMsg'})
          return newVirtText
        end,

        -- Preview configuration
        preview = {
          win_config = {
            border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
            winhighlight = 'Normal:Folded',
            winblend = 0
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
          }
        },

        -- Language-specific fold configuration
        enable_get_fold_virt_text = true,
      })
    end,
  },

  -- Enhanced treesitter folding support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      fold = {
        enable = true,
        disable = {}, -- No disabled languages
      },
    },
  },

  -- Better fold indicators in the status column
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      })
    end,
  },
}