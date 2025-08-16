# Tmux Continuum and Resurrect Setup

This document contains the setup instructions for tmux continuum and resurrect plugins to automatically save and restore tmux sessions.

## Installation Steps

### 1. Install TPM (Tmux Plugin Manager)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Configure ~/.tmux.conf
Add the following to your `~/.tmux.conf` file:

```bash
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# Continuum settings
set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'

# Resurrect settings
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-vim 'session'
set -g @resurrect-strategy-nvim 'session'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

### 3. Reload tmux configuration
```bash
tmux source ~/.tmux.conf
```

### 4. Install plugins
In tmux, press `prefix + I` (capital i) to install the plugins.

## Usage

- **Auto-save**: Sessions are automatically saved every 15 minutes
- **Auto-restore**: Sessions are automatically restored when tmux starts
- **Manual save**: `prefix + Ctrl-s`
- **Manual restore**: `prefix + Ctrl-r`

## Key Bindings

- `prefix + Ctrl-s` - Save current session
- `prefix + Ctrl-r` - Restore saved session
- `prefix + I` - Install new plugins
- `prefix + U` - Update plugins
- `prefix + alt + u` - Uninstall plugins not in plugin list

## Notes

- Sessions are saved to `~/.tmux/resurrect/`
- Continuum automatically saves and restores sessions
- Works with vim/nvim sessions when configured properly
- Captures pane contents for full restoration