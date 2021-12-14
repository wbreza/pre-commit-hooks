#!/bin/bash
set -euxo pipefail

PYTHON_REF=null

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
