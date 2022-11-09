#!/usr/bin/env bash
set -e

source "${BASH_SOURCE%/*}/../util/utils"

check-minikube-installed

if [ "$(does-command-exist "cilium")" ]; then
  echo "[+] Cilium CLI already installed, Skipping..."
else
  echo "[*] Installing Cilium CLI tool"
  brew install cilium-cli
  echo "[+] Cilium CLI tool installed"
fi

ensure-minikube-context

echo "[*] Installing Cilium"
cilium install
echo "[+] Cilium installed"
