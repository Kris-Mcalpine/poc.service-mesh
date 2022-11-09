#!/usr/bin/env bash
set -e

source "${BASH_SOURCE%/*}/../util/utils"

check-minikube-installed

if [ "$(does-command-exist "istioctl")" ]; then
  echo "[+] Istioctl already installed, skipping installation"
else
  echo "[*] Istioctl not found, installing..."
  brew install istioctl
fi

ensure-minikube-context

istioctl install --set profile=demo -y
