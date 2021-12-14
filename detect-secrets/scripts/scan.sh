#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)
PARENT_PATH=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)

source $PARENT_PATH/activate.sh

check_python
ensure_env

if which detect-secrets >/dev/null 2>&1; then
    VERSION=$(detect-secrets --version 2>&1 | awk '{print $2}')
    BASELINE_PATH="$CURRENT_PATH/.secrets.baseline"

    echo "Found 'detect-secrets' version $VERSION"

    detect-secrets scan \
        --baseline .secrets.baseline \
        --word-list secrets-wordlist.txt

    echo "Secrets baseline has been updated @ '$BASELINE_PATH' when any detected changes."
    echo "Please review all baseline updates before committing changes."
else
    echo "detect-secrets not found. Run setup script and try again"
fi
