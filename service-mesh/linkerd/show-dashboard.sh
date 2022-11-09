#!/usr/bin/env bash
set -e

source "${BASH_SOURCE%/*}/../util/utils"

if [ ! "$(does-command-exist "linkerd")" ]; then
  echo "[-] Linkerd CLI not installed. Use the linkerd/install.sh script first"
  exit 1
fi

linkerd viz dashboard
