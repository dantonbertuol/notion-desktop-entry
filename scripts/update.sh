#!/bin/bash
echo 'Atualizando pacotes'
sudo apt-get update
echo 'Atualizando SO'
sudo apt-get dist-upgrade -y
sudo pkcon update -y
echo 'Atualizando flatpaks'
flatpak update -y
