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

if which detect-secrets >/dev/null 2>&1; then
    detect-secrets audit "$CURRENT_PATH/.secrets.baseline"
else
    echo "detect-secrets not found. Run setup script and try again"
fi

cd "$CURRENT_PATH"
