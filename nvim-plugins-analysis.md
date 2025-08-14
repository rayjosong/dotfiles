# Neovim Plugins Analysis - Non-LazyVim Plugins

This document lists special plugins in your nvim configuration that don't come in a standard LazyVim distribution.

## Git/GitHub Integration
- **blamer.nvim** (`APZelos/blamer.nvim`) - Git blame annotations inline
- **lazygit.nvim** (`kdheepak/lazygit.nvim`) - LazyGit integration for git operations
- **gitlinker.nvim** (`ruifm/gitlinker.nvim`) - Generate permalinks to GitHub/GitLab
- **octo.nvim** (`pwntester/octo.nvim`) - Full GitHub integration (issues, PRs, reviews)
- **gh.nvim** (`ldelossa/gh.nvim`) - GitHub CLI integration with litee.nvim

## Go Development
- **nvim-dap** (`mfussenegger/nvim-dap`) - Debug Adapter Protocol
- **nvim-dap-go** (`leoluz/nvim-dap-go`) - Go debugging support
- **gopher.nvim** (`olexsmir/gopher.nvim`) - Go utilities (struct tags, tests, impl generation)

## Testing
- **neotest** (`nvim-neotest/neotest`) - Advanced test runner with UI
- **neotest-go** (`nvim-neotest/neotest-go`) - Go adapter for neotest

## Productivity/Workflow
- **noice.nvim** (`folke/noice.nvim`) - Better UI for messages/cmdline/popups
- **nvim-notify** (`rcarriga/nvim-notify`) - Enhanced notification system
- **vim-maximizer** (`szw/vim-maximizer`) - Window maximization toggle
- **nvim-surround** (`kylechui/nvim-surround`) - Text surrounding operations (quotes, brackets, etc.)
- **vim-visual-multi** (`mg979/vim-visual-multi`) - Multiple cursors support
- **todo-comments.nvim** (`folke/todo-comments.nvim`) - Highlight and search TODO/FIXME comments

## Markdown/Note-taking
- **obsidian.nvim** (`epwalsh/obsidian.nvim`) - Obsidian vault integration
- **bullets.vim** (`bullets-vim/bullets.vim`) - Better bullet points in markdown
- **nvim-toc** (`richardbizik/nvim-toc`) - Table of contents generation for markdown

## Terminal/Navigation
- **vim-tmux-navigator** (`christoomey/vim-tmux-navigator`) - Seamless vim/tmux pane navigation

## Code Quality & Formatting
- **nvim-lint** (`mfussenegger/nvim-lint`) - Asynchronous linting
- **none-ls.nvim** (`nvimtools/none-ls.nvim`) - Code formatting/diagnostics (null-ls successor)
- **nvim-ts-autotag** (`windwp/nvim-ts-autotag`) - Auto-close HTML/JSX tags

## Framework Base
This configuration is built on **NvChad v2.0**, not LazyVim, which provides:
- Custom UI components
- Base46 theming system
- NvTerm terminal integration
- Custom colorizer and devicons

## Key Observations
- Heavy focus on **Go development** workflow
- Extensive **GitHub integration** tools
- Advanced **testing capabilities** with neotest
- **Markdown/note-taking** optimizations for Obsidian
- **Productivity enhancements** for professional development workflow

For a more stock vim approach, consider removing the specialized workflow tools and keeping only core editing functionality.