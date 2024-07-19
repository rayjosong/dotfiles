# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search zsh-autosuggestions)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

ZSH_COLOURIZE_STYLE="colorful"

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  if nvm -v &> /dev/null; then
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
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=nvim
export EDITOR=nvim

source ~/code/rayjosong/dotfiles/.env
# # github token

for file in $(find $K8CONFIGDIR -name 'config.*' -maxdepth 1); do
    f_name=$(echo $file | awk -F/ '{print $NF}')
    a_name=$(echo $f_name | awk -F. '{print $2}')
    # Create alias for each
    alias "pd-${a_name}"="kubectl --kubeconfig=$K8CONFIGDIR/$f_name \$*"
    # [Optional] Create function for each , for scripting use
    eval "$(
    cat <<EOF
    _pd-${a_name}(){
        kubectl --kubeconfig="${K8CONFIGDIR}/$f_name" \$@
    }
EOF
)"

done

# aliases
alias oo='cd $HOME/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Personal\ Vault/'
alias ofp='cd $HOME/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/foodpanda/'
alias ppg='cd $HOME/code/deliveryhero/pd-pablo-payment-gateway/'
alias pac='cd $HOME/code/deliveryhero/pd-app-config/'
alias df='cd $HOME/code/rayjosong/dotfiles/'

alias vim=nvim
alias tmxf=tmuxifier

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Ensure that CLI tools don't use public checksum for DH private modules
go env -w GOPRIVATE="github.com/deliveryhero/*"

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin


# Flutter
# export PATH="$PATH:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"


[[ -s "/Users/r.ong.4/.gvm/scripts/gvm" ]] && source "/Users/r.ong.4/.gvm/scripts/gvm"

[[ -s "/Users/raymondong/.gvm/scripts/gvm" ]] && source "/Users/raymondong/.gvm/scripts/gvm"
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# bun completions
[ -s "/Users/raymondong/.bun/_bun" ] && source "/Users/raymondong/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Created by `pipx` on 2024-06-15 03:50:49
export PATH="$PATH:/Users/raymondong/.local/bin"
