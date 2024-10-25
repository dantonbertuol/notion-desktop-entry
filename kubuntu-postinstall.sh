#!/usr/bin/bash
#
# kubuntu-postinstall.sh - Install and configure softwares in Kubuntu
#
# Autor:         dantonbertuol
#
# ------------------------------------------------------------------------ #
#
# How to Use?
#   $ ./kubuntu-postinstall.sh
#
# ----------------------------- VARIABLES ----------------------------- #

# URLs
URL_NOISETORCH="https://api.github.com/repos/noisetorch/NoiseTorch/releases/latest"
URL_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_GITKRAKEN="https://release.gitkraken.com/linux/gitkraken-amd64.deb"
URL_EDRAWMIND="https://download.edrawsoft.com/archives/edrawmind-x86_64.deb"
URL_MAILSPRING="https://api.github.com/repos/Foundry376/Mailspring/releases/latest"
URL_PYMODORO="https://github.com/dantonbertuol/pymodoro.git"
URL_LINUXCONFIG="https://github.com/dantonbertuol/linux-config.git"
URL_KORAICONS="https://github.com/bikass/kora.git"


# Directorys and Archives
DOWNLOADS_PATH="$HOME/Downloads/programas"

# Ubuntu Codename
DISTRO_CODENAME=$(lsb_release -c | awk '{print $2}')

# Colors
RED='\e[1;91m'
GREEN='\e[1;92m'
YELLOW='\e[1;93m'
NO_COLOR='\e[0m'

# Functions #

# Update repository and system
apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# Install essential packages for installation
install_essential(){
  sudo apt-get install curl git apt-transport-https libgcrypt20-dev libgpg-error-dev libsecret-1-dev fonts-liberation -y
}

# Update repository
just_apt_update(){
  sudo apt update -y
}

# Add apps repositorys
add_repository(){
  if ! grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep "https://packages.microsoft.com/repos/edge"; then
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"
  else
    echo -e "${YELLOW}[REPOSITORY EXISTS] - Microsoft Edge${NO_COLOR}"
  fi

  if ! grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep "https://download.sublimetext.com/"; then
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null && echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  else
    echo -e "${YELLOW}[REPOSITORY EXISTS] - Sublime Text${NO_COLOR}"
  fi

  if ! grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep "https://packages.microsoft.com/repos/vscode"; then
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/ms-vscode-keyring.gpg && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ms-vscode-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
  else
    echo -e "${YELLOW}[REPOSITORY EXISTS] - Visual Studio Code${NO_COLOR}"
  fi

  if ! grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep "http://apt.insync.io/"; then
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C && sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C && sudo add-apt-repository "deb http://apt.insync.io/ubuntu $DISTRO_CODENAME non-free contrib"
  else
    echo -e "${YELLOW}[REPOSITORY EXISTS] - InSync${NO_COLOR}"
  fi
}

# DEB Softwares to Install
PROGRAMS_TO_INSTALL=(
  qdbus
  openconnect
  rclone
  bleachbit
  boomaga
  kwin-addons
  remmina
  smplayer
  openjdk-17-jdk
  obs-studio
  vlc
  zsh
  software-properties-common
  wget
  microsoft-edge-stable
  sublime-text
  code
  flameshot
  fonts-takao-gothic
  python3
  python-is-python3
  python3-pip
  simplescreenrecorder
  flatpak
  baobab
  gimp
  cheese
  net-tools
  python3-pyqt5
  insync
  insync-emblem-icons
  insync-dolphin
  libglib2.0-dev
  neofetch
  gparted
  stacer
  xclip
  kdenlive
  appmenu-gtk3-module
  appmenu-gtk2-module
  power-profiles-daemon
  cmake
  x11-xserver-utils
  xorg-dev
  libxnvctrl-dev
  libx11-dev
  libpq-dev
  bat
  ttf-mscorefonts-installer
)

# External programs download and installation 
install_debs(){

  echo -e "${GREEN}[INFO] - Baixando pacotes .deb${NO_COLOR}"

  mkdir "$DOWNLOADS_PATH"

  echo -e "${GREEN}[INFO] - NOISETORCH${NO_COLOR}"
  curl -s "$URL_NOISETORCH" | grep browser_download_url | grep '\.tgz"' | cut -d '"' -f 4 | wget -i - -P "$DOWNLOADS_PATH"

  echo -e "${GREEN}[INFO] - MAILSPRING${NO_COLOR}"
  curl -s "$URL_MAILSPRING" | grep browser_download_url | grep '\amd64.deb"' | cut -d '"' -f 4 | wget -i - -P "$DOWNLOADS_PATH"

  echo -e "${GREEN}[INFO] - CHROME${NO_COLOR}"
  wget -c "$URL_CHROME"       -P "$DOWNLOADS_PATH"

  echo -e "${GREEN}[INFO] - EDRAWMIND${NO_COLOR}"
  wget -c "$URL_EDRAWMIND"       -P "$DOWNLOADS_PATH"

  echo -e "${GREEN}[INFO] - GIT KRAKEN${NO_COLOR}"
  wget -c "$URL_GITKRAKEN"    -P "$DOWNLOADS_PATH"

  echo -e "${GREEN}[INFO] - PYMODORO${NO_COLOR}"
  git clone "$URL_PYMODORO"  "$DOWNLOADS_PATH/pymodoro" && cd "$DOWNLOADS_PATH/pymodoro/linux_install" && ./install.sh

  echo -e "${GREEN}[INFO] - LINUX CONFIG${NO_COLOR}"
  git clone "$URL_LINUXCONFIG" "$DOWNLOADS_PATH/linux-config" 
  
  echo -e "${GREEN}[INFO] - KORA ICONS${NO_COLOR}"
  git clone "$URL_KORAICONS" "$DOWNLOADS_PATH/kora"

  # Installation .deb packages
  echo -e "${GREEN}[INFO] - Instalando pacotes .deb baixados${NO_COLOR}"

  tar -C $HOME -h -xzf $DOWNLOADS_PATH/*.tgz && sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch

  sudo dpkg -i $DOWNLOADS_PATH/*.deb

  # Installation programs with apt
  echo -e "${GREEN}[INFO] - Instalando pacotes apt do repositório${NO_COLOR}"

  for nome_do_programa in ${PROGRAMS_TO_INSTALL[@]}; do
    sudo apt install "$nome_do_programa" -y
  done

  sudo ln -s /usr/bin/batcat /usr/bin/bat

}

# Installating Others Packages
install_others(){

  echo -e "${GREEN}[INFO] - Instalando pacotes${NO_COLOR}"

  curl -fsSL https://get.docker.com | bash && sudo groupadd docker && sudo usermod -aG docker $USER && newgrp docker

  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
}

# List of Flatpaks to Install
FLATPAK_TO_INSTALL=(
  org.localsend.localsend_app
  org.gnome.meld
  org.onlyoffice.desktopeditors
  com.spotify.Client
  com.jgraph.drawio.desktop
  com.github.PintaProject.Pinta
  org.kde.CrowTranslate
  io.github.zyedidia.micro
)

# Install Flatpaks
install_flatpaks(){
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  for nome_do_programa in ${FLATPAK_TO_INSTALL[@]}; do
    if ! flatpak list | grep -q $nome_do_programa; then # install only if not installed
      flatpak install flathub "$nome_do_programa" -y
    else
      echo -e "${YELLOW}[INSTALADO] - $nome_do_programa${NO_COLOR}"
    fi
  done
}

# ----------------------------- After Installation ----------------------------- #

# Finishing, update and clean##
system_clean(){
  apt_update -y
  sudo apt autoclean -y
  sudo apt autoremove -y
}

desktop_entries(){
  wget https://raw.githubusercontent.com/dantonbertuol/linux-config/commons/entries/notion.desktop -P $HOME/.local/share/applications
  wget https://raw.githubusercontent.com/dantonbertuol/linux-config/commons/entries/lazydocker.desktop -P $HOME/.local/share/applications
  wget https://raw.githubusercontent.com/dantonbertuol/linux-config/commons/icons/notion.svg -P $HOME/.local/share/icons
  wget https://raw.githubusercontent.com/dantonbertuol/linux-config/commons/icons/lazydocker.png -P $HOME/.local/share/icons
}

# Configure RClone (OneDrive)
config_rclone(){
  rclone config
}

konsole_config(){
  # cd "$DOWNLOADS_PATH/linux-config" && cp -r konsole/flatpak/* $HOME/.var/app/org.kde.konsole/data/konsole/
  cd "$DOWNLOADS_PATH/linux-config" && cp -r konsole/deb/* $HOME/.local/share/konsole/
}

colors_config(){
  cd "$DOWNLOADS_PATH/linux-config" && cp -r colors/* $HOME/.local/share/color-schemes
}

icons_config(){
  cd "$DOWNLOADS_PATH/kora" && cp -r kora $HOME/.local/share/icons
}

scripts(){
  mkdir $HOME/Documents/scripts
  cd "$DOWNLOADS_PATH/linux-config" && git checkout commons && cp -r scripts/* $HOME/Documents/scripts
}


# -------------------------------Execution----------------------------------------- #

apt_update
install_essential
add_repository
just_apt_update
install_debs
install_flatpaks
# # config_rclone
system_clean
desktop_entries
konsole_config
colors_config
icons_config
scripts
install_others
# Finish

echo -e "${GREEN}[INFO] - Script finalizado, instalação concluída! :)${NO_COLOR}"

echo -e "${GREEN}[NEXT]${RED}
- Instalar nerd fonts (JetBrainsMono Nerd Font) e Ubuntu Fonts
- Instalar dbeaver-ee
- Configurar rclone
- Configurar o Konsole - Aplicar colors e profile
- Configurar os atalhos e OCR Crow Translate
- Criar atalhos de Apps do Edge
- Instalar tema e plugins do Oh My ZSH
- Configurar Startup Applications
- Configurar atalhos personalizados
- Configurar o InSync
- Montar automaticamente partição de Backup
- Vibrant-linux https://github.com/libvibrant/libvibrant?tab=readme-ov-file#building
${NO_COLOR}"
