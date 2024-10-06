#!/bin/bash
echo 'Limpando apt cache'
sudo apt-get clean
echo 'Limpando kernels antigos'
sudo apt-get autoremove
echo 'Limpando kernels antigos'
sudo apt-get autoremove
echo 'Removendo tumbnails'
sudo rm -rf ~/.cache/thumbnails/*