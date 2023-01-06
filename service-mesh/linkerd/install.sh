#!/usr/bin/env bash
set -e

source "${BASH_SOURCE%/*}/../util/utils"

check-minikube-installed

if [ "$(does-command-exist "linkerd")" ]; then
  echo "[+] Linkerd CLI already installed, Skipping..."
else
  echo "[*] Installing linkerd CLI tool"
  brew install linkerd
  curl -sL https://linkerd.github.io/linkerd-smi/install | sh
  echo "[+] Linkerd CLI tool installed"
fi

ensure-minikube-context

linkerd check --pre
linkerd install --crds | kubectl apply -f -
linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -
linkerd check

echo "[+] Linkerd installed"

echo "[*] Installing Linkerd dashboard"
linkerd viz install | kubectl apply -f -
linkerd jaeger install | kubectl apply -f -
linkerd smi install | kubectl apply -f -
linkerd check
echo "[+] Linkerd dashbord installed.

Run 'linkerd viz dashboard &' to view."


echo "[*] Installing flagger"
kubectl apply -k github.com/fluxcd/flagger/kustomize/linkerd
echo "[+] Flagger installed"
