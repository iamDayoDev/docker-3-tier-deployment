#!/bin/bash
echo "Updating packages..."
apt update && apt upgrade -y

echo "Installing dependencies..."
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor | tee /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null

echo "Adding Docker repository..."
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing Docker..."
apt update
apt install -y docker-ce docker-ce-cli containerd.io

echo "Enabling Docker service..."
systemctl start docker
systemctl enable docker

usermod -aG docker ubuntu



