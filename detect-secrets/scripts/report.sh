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
    VERSION=$(detect-secrets --version)
    BASELINE_PATH="$CURRENT_PATH/.secrets.baseline"

    echo "Found detect-secrets with version $VERSION"
    detect-secrets audit --report --only-real .secrets.baseline
else
    echo "detect-secrets not found. Run setup script and try again"
fi
