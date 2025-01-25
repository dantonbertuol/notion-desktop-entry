#!/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# tap
brew tap hashicorp/tap

# install brew packages
brew install --cask iterm2
brew install --cask trex
brew install ansible
brew install hashicorp/tap/terraform
brew install hashicorp/tap/hashicorp-vagrant
brew install --cask dbeaver-community
brew install docker
brew install --cask insomnia
brew install --cask flameshot
brew install --cask localsend
brew install --cask microsoft-edge
brew install --cask simplenote
brew install --cask spotify
brew install --cask sublime-text
brew install --cask virtualbox
brew install --cask visual-studio-code
brew install git
brew install bat
brew install micro
brew install wget
brew install astro
brew install fd
brew install openjdk@21
brew install --cask obs
brew install zsh zsh-completions
brew install htop
brew install --cask google-chrome
brew install lazydocker
brew install --cask onlyoffice
brew install --cask pinta

# other packages
python3 -m ensurepip
cp -r micro/colorschemes $HOME/.config/micro/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# https://clipy-app.com/
# https://app.prntscr.com/pt-br/download.html
# https://www.logitech.com/pt-br/software/logi-options-plus.html
# Office 365
# Microsoft To Do
# Onedrive
# Maple Font NF - Ligature Hinted - https://github.com/subframe7536/maple-font/releases
# Configurar o iTerm2
# Instalar tema e plugins do Oh My ZSH
# Ao abrir o micro, basta pressionar CTRL+E e inserir o comando 'set colorscheme catppuccin-macchiato-transparent'

# Configure Oh My Zsh Plugins and Themes
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
curl https://raw.githubusercontent.com/kaplanelad/shellfirm/main/shell-plugins/shellfirm.plugin.oh-my-zsh.zsh --create-dirs -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm/shellfirm.plugin.zsh

cp -r /zsh/.zshrc "$HOME/.zshrc"
