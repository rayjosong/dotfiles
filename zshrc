# ============================================================================
# ZSH CONFIGURATION
# ============================================================================

# ----------------------------------------------------------------------------
# Powerlevel10k Instant Prompt (must be at top)
# ----------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------------------------------------------
# Oh My Zsh Configuration
# ----------------------------------------------------------------------------
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_COLOURIZE_STYLE="colorful"
ZSH_DISABLE_COMPFIX=true

# Oh My Zsh plugins
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search zsh-autosuggestions zsh-vi-mode)

# Load Oh My Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load Powerlevel10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# ----------------------------------------------------------------------------
# System Settings
# ----------------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export BUNDLER_EDITOR=nvim
export HOMEBREW_NO_ANALYTICS=1

# Dotfiles directory - adjust per machine
export DOTFILES_DIR="$HOME/code/rayjosong/dotfiles"

# ----------------------------------------------------------------------------
# Development Tools
# ----------------------------------------------------------------------------
# Go configuration
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
go env -w GOPRIVATE="github.com/deliveryhero/*"

# Bun setup
if [[ -d "$HOME/.bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# ============================================================================
# PATH CONFIGURATION
# ============================================================================
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"
[[ -d "$HOME/.local/bin" ]] && export PATH="$PATH:$HOME/.local/bin"

# Dotfiles scripts - portable across machines
[[ -d "$DOTFILES_DIR/scripts" ]] && export PATH="$PATH:$DOTFILES_DIR/scripts"

# tmuxifier - only load if available
if [[ -x "$HOME/.tmuxifier/bin/tmuxifier" ]]; then
  export PATH="$HOME/.tmuxifier/bin:$PATH"
  eval "$(tmuxifier init -)"
fi

# ============================================================================
# DEVELOPMENT TOOLS SETUP
# ============================================================================

# ----------------------------------------------------------------------------
# Node.js / NVM (Lazy Loading)
# ----------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

# Auto-load .nvmrc when entering directory (only if nvm is loaded)
autoload -U add-zsh-hook
load-nvmrc() {
  # Load nvm if not already loaded
  if ! typeset -f nvm_find_nvmrc > /dev/null 2>&1; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi
  
  if typeset -f nvm_find_nvmrc > /dev/null 2>&1; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc

# ----------------------------------------------------------------------------
# Other Development Tools
# ----------------------------------------------------------------------------
# Load GVM if available
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Bun completions
if [[ -d "$HOME/.bun" ]]; then
  [[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
fi

# Zoxide - load if available
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# Load history substring search if available
if command -v brew &> /dev/null; then
  local hist_search="$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
  [[ -f "$hist_search" ]] && source "$hist_search"
fi

# ============================================================================
# EXTERNAL CONFIGURATIONS
# ============================================================================
# Load environment variables if file exists (contains sensitive credentials)
[[ -f "$DOTFILES_DIR/.env" ]] && source "$DOTFILES_DIR/.env"

# Load custom aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# ============================================================================
# KUBERNETES CONFIGURATION
# ============================================================================
# Create kubectl aliases more efficiently - only if K8CONFIGDIR is set
if [[ -n "$K8CONFIGDIR" && -d "$K8CONFIGDIR" ]]; then
  for file in "$K8CONFIGDIR"/config.*; do
    [[ -f "$file" ]] || continue
    f_name="${file##*/}"
    a_name="${f_name#*.}"
    alias "pd-${a_name}"="kubectl --kubeconfig=$file"
    eval "_pd-${a_name}() { kubectl --kubeconfig=\"$file\" \"\$@\"; }"
  done
fi

# ============================================================================
# ALIASES
# ============================================================================

# ----------------------------------------------------------------------------
# Navigation Aliases
# ----------------------------------------------------------------------------
alias oo='cd $HOME/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Personal\ Vault/'
alias ofp='cd $HOME/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/foodpanda/'
alias ppg='cd $HOME/code/deliveryhero/pd-pablo-payment-gateway/'
alias pac='cd $HOME/code/deliveryhero/pd-app-config/'
alias df='cd $HOME/code/rayjosong/dotfiles/'

# ----------------------------------------------------------------------------
# Tool Aliases
# ----------------------------------------------------------------------------
alias vim=nvim
alias lg='lazygit'
alias tmxf=tmuxifier
alias dhclaude='$HOME/code/rayjosong/dotfiles/setup_claude_code.sh'
alias myclaude='claude-launcher.sh'

# ----------------------------------------------------------------------------
# Navigation with fzf/zoxide
# ----------------------------------------------------------------------------
alias zf='cd "$(zoxide query -l | fzf)"'
alias sd="cd ~ && cd \$(find * -type d | fzf)"

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================
cz() {
    dir=$(dirname "$(fzf)") && [[ -n "$dir" ]] && z "$dir"
}
