#!/usr/bin/env bash
set -e

source "${BASH_SOURCE%/*}/../util/utils"

check-minikube-installed

if [ "$(does-command-exist "osm")" ]; then
  echo "[+] Osm CLI already installed, skipping installation"
else
  echo "[*] Osm Cli not found, installing..."
  brew install osm
fi

ensure-minikube-context

echo "[*] Installing Open service mesh"
osm install
echo "[+] Installation complete"
