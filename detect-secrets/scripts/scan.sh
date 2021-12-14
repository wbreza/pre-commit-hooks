#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)

source ./scripts/detect-secrets/activate.sh

check_python
ensure_env

if which detect-secrets >/dev/null 2>&1; then
    detect-secrets scan \
        --baseline .secrets.baseline \
        --word-list secrets-wordlist.txt
else
    echo "detect-secrets not found. Run setup script and try again"
fi
