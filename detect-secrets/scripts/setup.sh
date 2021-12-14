#!/bin/bash
set -euxo pipefail

CURRENT_PATH=$(pwd -P)
BASE_PATH="https://raw.githubusercontent.com/wbreza/pre-commit-hooks/dev/detect-secrets"

copy() {
    name=$1[@]
    DIR_PATH=$2
    FILES=("${!name}")

    for asset in ${FILES[@]}; do
        FILE_NAME=$(basename $asset)
        COPY_PATH="$DIR_PATH/$FILE_NAME"

        if [[ -f $COPY_PATH ]]; then
            echo "$asset already exists. Skipping..."
        else
            curl -# -o $COPY_PATH $BASE_PATH/$asset
        fi
    done
}

download() {
    echo "Downloading assets..."

    mkdir -p scripts/detect-secrets

    SCRIPTS=(
        "scripts/activate.sh"
        "scripts/setup.sh"
        "scripts/uninstall.sh"
    )

    # Passes array by name
    copy SCRIPTS "$CURRENT_PATH/scripts/detect-secrets"

    ASSETS=(
        ".secrets.baseline"
        "secrets-wordlist.txt"
        ".pre-commit-config.yaml"
    )

    # Passes array by name
    copy ASSETS "$CURRENT_PATH"
}

install() {
    echo 'Installing pre-commit framework...'
    pip install pre-commit

    echo 'Installing pre-commit hooks from configuration...'
    pre-commit install
    pre-commit run --all-files
}

download
source scripts/detect-secrets/activate.sh
check_python
activate
install
