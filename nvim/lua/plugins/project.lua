-- Project.nvim configuration for LazyVim
-- Auto-discovers projects when you open files in them

return {
  "ahmedkhalf/project.nvim",
  opts = {
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "Makefile", "package.json", "go.mod", "pyproject.toml" },
    silent_chdir = true,
    scope_chdir = "global",
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require("telescope").load_extension("projects")
  end,
  keys = {
    { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
  },
}
