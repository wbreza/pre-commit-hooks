#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)
PARENT_PATH=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)

cd "$PARENT_PATH"

source ./activate.sh

check_python
ensure_env

detect-secrets scan \
    --baseline "$CURRENT_PATH/.secrets.baseline" \
    --word-list "$CURRENT_PATH/secrets-wordlist.txt"

cd "$CURRENT_PATH"