# spotify
# google-chrome
# arc-browser
# kitty terminal
# neovim
# slack
# todoist
# raycast
# rectangle
# vscode
# scroll reverser
# warp
# zoom
# telegram
# discord
# neovim/nvim-lspconfig


# -- no brew install --
# thinkorswim
#

#!/bin/bash
# Check for existing Homebrew installation
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)"
else
  echo "Homebrew already installed. Skipping installation."
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# install nerd fonts
brew tap homebrew/cask-fonts
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true

# Install core development tools (needed for some installations)
echo "Installing development tools..."
brew install openssl readline sqlite3 xz

# Install Python3
echo "Installing Python3..."
brew install python@3.11

# Install Node.js (includes npm)
echo "Installing Node.js..."
brew install node

# Install Yarn (package manager for Node.js)
echo "Installing Yarn..."
curl -sS https://dl.yarnpkg.com/stable-install.sh | sh

# Install Go
echo "Installing Go..."
brew install go

brew install gofumpt
brew install lazygit
brew install ripgrep
brew install fzf
brew install tmux

# Install Docker and Docker Compose plugin
echo "Installing Docker..."
brew install docker docker-compose

# Install Colima (container runtime for Docker)
echo "Installing Colima..."
brew install colima

# Install Oh My Zsh and configure Powerlevel10k theme
echo "Installing Oh My Zsh and Powerlevel10k..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ~/.zshrc
p10k configure  # Consider customizing the theme with `p10k configure`

# Install Git version control system
echo "Installing Git..."
brew install git

# Install GitHub CLI
echo "Installing GitHub CLI..."
brew install gh

# Install applications (formulae and casks)
echo "Installing applications..."
brew install --cask spotify google-chrome arc-browser kitty neovim slack todoist raycast rectangle visual-studio-code
brew install scroll-reverser warp zoom

# Install casks from external taps (not in core Homebrew)
brew tap caskroom/versions
brew cask install discord

# Install neovim plugin using pip (assuming Python is installed)
if [ $(command -v pip3) ]; then
  echo "Installing neovim/nvim-lspconfig..."
  pip3 install neovim/nvim-lspconfig
else
  echo "Warning: pip3 not found. Skipping neovim/nvim-lspconfig installation."
fi

# Switch to Zsh shell (optional)
# chsh -s /bin/zsh

echo "Installation complete! Consider restarting your terminal for changes to take effect."
