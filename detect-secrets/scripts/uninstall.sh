#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)
PYTHON_REF=null
VENV_PATH=${VIRTUAL_ENV:-}

check_python() {
    echo "Checking python version..."

    if which python3 >/dev/null 2>&1; then
        PYTHON_REF="python3"
    else
        if which python >/dev/null 2>&1; then
            PYTHON_REF="python"
        else
            echo "Python is not installed.  Install Python 3.8 and try again"
            exit 1
        fi
    fi

    PYTHON_VERSION=$($PYTHON_REF --version 2>&1 | awk '{print $2}')
    echo "Found Python with version $PYTHON_VERSION"
}

setup_env() {
    echo 'Creating environment for pre-commit...'
    $PYTHON_REF -m venv .venv

    if [ "$(uname)" == "Darwin" ]; then
        . .venv/bin/activate
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        . .venv/bin/activate
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        . .venv/scripts/activate
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
        . .venv/scripts/activate
    fi

    VENV_PATH=${VIRTUAL_ENV:-}
}

ensure_env() {
    if [[ -z $VENV_PATH ]]; then
        setup_env
    fi
}

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
}

check_python
ensure_env
uninstall
cleanup

cd "$CURRENT_PATH"
