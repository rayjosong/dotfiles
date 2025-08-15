require('lint').linters_by_ft = {
  javascript = {'eslint-lsp'},
  typescript = {'eslint-lsp'},
}

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  callback = function()
    require("lint").try_lint()
  end,
})
