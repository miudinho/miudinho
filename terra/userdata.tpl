# to run "script" put user_date to main.tf 
# user_date = file("userdata.tpl")


#!/bin/bash
sudo apt update -y &&
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" &&
apt-cache policy docker-ce &&
sudo apt install docker-ce -y &&
# sudo systemctl status docker &&
sudo usermod -aG docker ubuntu &&
sudo chmod 666 /var/run/docker.sock
