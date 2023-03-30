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
<<<<<<< HEAD

#!/bin/bash
sudo apt-add-repository ppa:ansible/ansible &&
sudo apt install ansible
=======
>>>>>>> 8add16423149f4623f7dd214fb3a8aa278371b46
