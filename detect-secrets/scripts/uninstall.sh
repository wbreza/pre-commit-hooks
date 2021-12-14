#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)
PARENT_PATH=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)

source $PARENT_PATH/activate.sh

VENV_PATH=${VIRTUAL_ENV:-}

uninstall() {
    echo "Uninstalling pre-commit framework..."
    if which pre-commit >/dev/null 2>&1; then
        pre-commit uninstall
    fi
}

cleanup() {
    echo "Cleaning up environment for pre-commit..."
    deactivate
    rm -rf $VENV_PATH
    rm -rf $PARENT_PATH
}

check_python
ensure_env
uninstall
cleanup
