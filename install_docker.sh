#!/bin/bash

# Saia imediatamente se ocorrer algum erro
set -e

echo "Atualizando o sistema e instalando pacotes necessários..."
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Adiciona a chave GPG oficial do Docker
echo "Adicionando chave GPG do Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Adiciona o repositório Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala Docker Engine, Docker CLI e o Docker Compose
echo "Instalando Docker Engine, Docker CLI e Docker Compose..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verifica a instalação
echo "Verificando instalação do Docker..."
sudo docker --version
sudo docker-compose --version

# Test com hello-world
sudo docker hello-world
