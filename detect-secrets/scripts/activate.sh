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

activate() {
    echo 'Creating environment for pre-commit...'
    $PYTHON_REF -m venv "$CURRENT_PATH/.venv"

    if [ "$(uname)" == "Darwin" ]; then
        . .venv/bin/activate
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        . .venv/bin/activate
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
        . .venv/scripts/activate
    elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
        . .venv/scripts/activate
    fi
}

install() {
    echo 'Installing pre-commit framework...'
    pip install pre-commit detect-secrets pyahocorasick

    echo 'Installing pre-commit hooks from configuration...'
    pre-commit install
    pre-commit run --all-files
}

ensure_env() {
    if [[ -z $VENV_PATH ]]; then
        activate
        VENV_PATH=${VIRTUAL_ENV:-}
    fi
}
