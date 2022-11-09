#!/usr/bin/env bash
set -e

if [ ! -x "$(command -v minikube)" ]; then
  echo "[-] Minikube not installed. Please use the minikube/install.sh script to install first."
  exit 1
elif [ -z "$(minikube status | grep "apiserver: Running")" ]; then
  echo "[-] Minikube is installed but the cluster is not running.
Please use the minikube/install.sh script to install first."
  exit 1
fi

if [ -x "$(command -v linkerd)" ]; then
  echo "[+] Linkerd CLI already installed, Skipping..."
else
  echo "[*] Installing linkerd CLI tool"
  brew install linkerd
  echo "[+] Linkerd CLI tool installed"
fi

# Ensure kubectl is pointing to local minikube
if [ "$(kubectl config current-context)" != "minikube" ]; then
  echo "[!] kubectl is currently pointing to '$(kubectl config current-context)'"
  echo "[*] Switching context to 'minikube'"
  kubectl config use-context minikube
  echo "[+] Now using 'minikube' kubectl context"
fi

linkerd check --pre
linkerd install --crds | kubectl apply -f -
linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -
linkerd check

echo "[+] Linkerd installed"
