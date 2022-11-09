#!/usr/bin/env bash
set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <version_number>"
  exit 1
fi

# check we are using the minikube docker deamon
if [ "$MINIKUBE_ACTIVE_DOCKERD" != "minikube" ]; then
  echo "[*] Setting docker deamon to minikube"
  eval "$(minikube -p minikube docker-env)"
  echo "[+] Docker daemon now set to minikube"
fi

export APP_VERSION="$1"
echo "[*] Building time-service version ${APP_VERSION}"
docker build -t "time-service:${APP_VERSION}" ${BASH_SOURCE%/*}/.
echo "[+] Build successful"

echo "[*] Generating deployment yaml"
envsubst <"${BASH_SOURCE%/*}/deploy/base/kustomization-template.yaml" >"${BASH_SOURCE%/*}/deploy/base/kustomization.yaml"

echo "[*] Deploying time-service version ${APP_VERSION}"
kubectl apply -k "${BASH_SOURCE%/*}/deploy/base"
echo "[+] time-service version ${APP_VERSION} deployed successfully"
