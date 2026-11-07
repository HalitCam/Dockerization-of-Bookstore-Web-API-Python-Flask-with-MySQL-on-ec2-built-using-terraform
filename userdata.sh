#!/bin/bash
dnf update -y 
dnf install -y git 
dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl start docker
 sudo systemctl enable --now docker
cd /
git clone https://${TOKEN}@github.com/${GIT_USER}/dockerization-bookstore-app.git
cd /dockerization-bookstore-app
docker compose up -d --build