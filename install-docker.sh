#!/bin/bash
# install docker on an ubuntu system
TARGET_USER=$1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y docker-ce python3-pip git ipython3 build-essential docker-compose python-pip
sudo pip install toml kombu redis web.py
sudo pip3 install toml kombu redis git+https://github.com/webpy/webpy#egg=web.py

if [ -n "$TARGET_USER" ]
then
    echo "Adding ${TARGET_USER} to docker group"
    sudo usermod -aG docker ${TARGET_USER}
fi
