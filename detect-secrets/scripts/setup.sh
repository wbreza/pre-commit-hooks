#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)
PYTHON_REF=null
BASE_PATH="https://raw.githubusercontent.com/wbreza/pre-commit-hooks/main/detect-secrets"
ASSETS=(
    "setup.sh"
    ".secrets.baseline"
    "secrets-wordlist.txt"
    ".pre-commit-config.yaml"
)

download() {
    echo "Downloading assets..."

    for asset in ${ASSETS[@]}; do
        DEST_PATH="$CURRENT_PATH/$asset"
        if [[ -f $DEST_PATH ]]; then
            echo "$asset already exists. Skipping..."
        else
            curl -# -o $CURRENT_PATH/$asset $BASE_PATH/$asset
        fi
    done
}

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
}

install() {
    echo 'Installing pre-commit framework...'
    pip install pre-commit

    echo 'Installing pre-commit hooks from configuration...'
    pre-commit install
    pre-commit run --all-files
}

check_python
setup_env
download
install
