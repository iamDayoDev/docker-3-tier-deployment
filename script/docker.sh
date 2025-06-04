#!/bin/bash
# Log everything to a file
exec > >(tee /var/log/docker-install.log|logger -t user-data -s) 2>&1

echo "Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor | sudo tee /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null

echo "Adding Docker repository..."
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing Docker..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "Enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Adding ubuntu user to docker group..."
sudo usermod -aG docker ubuntu

echo "Docker version:"
docker --version

echo "Docker installation complete."
