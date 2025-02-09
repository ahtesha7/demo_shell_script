#!/bin/bash

<<info
install package with argument passing

e.g ./install_package.sh nginx

info


sudo apt-update
sudo apt-get install $1 -y

echo "Installed"
