#!/usr/bin/env bash
set -e

if [ -x "$(command -v minikube)" ]; then
  echo "[+] Minikube already installed."
else
  echo "[*] Downloading minikube"
  curl -L -o /tmp/minikube-darwin-amd64 https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
  echo "[*] Installing minikube"
  sudo install /tmp/minikube-darwin-amd64 /usr/local/bin/minikube
  rm -f /tmp/minikube-darwin-amd64
  echo "[+] Minikube installed"
fi

if [ -z "$(minikube status | grep "apiserver: Running")" ]; then
  echo "[*] Starting minikube cluster"
  # Note: Can't currently go for a version > 1.24.0 due to removal of docker-shim
  # Haven't found a way to install cri-dockerd on mac yet.
  minikube start --kubernetes-version=v1.23.13

  echo "[+] Minikube running"
else
  echo "[+] Minikube cluster is already running.
    Note: If you wish to evaluate one of the service mesh technologies in this repo,
    You may want to delete your current minikube cluster using the following command
    and rerunning this script.
    
    $ minikube delete"
fi
