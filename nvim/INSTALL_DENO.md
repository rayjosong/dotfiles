# Installing Deno for Peek.nvim

If you want to use the advanced `peek.nvim` plugin for mermaid viewing, you need to install Deno.

## Quick Installation

### macOS (Homebrew)
```bash
brew install deno
```

### Linux/macOS (Universal)
```bash
curl -fsSL https://deno.land/install.sh | sh
```

### Manual PATH Setup (if needed)
Add to your `~/.zshrc` or `~/.bashrc`:
```bash
export PATH="$HOME/.deno/bin:$PATH"
```

## Automated Installation
Run the setup script with option 3:
```bash
cd nvim
./setup.sh
# Choose option 3 (Everything)
```

## Verification
Check if Deno is installed:
```bash
deno --version
```

## After Installation
1. Restart Neovim
2. Run `:Lazy` to see if peek.nvim loads successfully
3. Use `<leader>mP` to test peek preview
4. If issues persist, use `<leader>mp` (markdown-preview.nvim) which works without Deno

## Troubleshooting
- If Deno command not found after installation, restart your terminal
- Check that PATH includes `$HOME/.deno/bin` (Linux/macOS) or Homebrew path (macOS)
- peek.nvim will automatically be disabled if Deno is not available