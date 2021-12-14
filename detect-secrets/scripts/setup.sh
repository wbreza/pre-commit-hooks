#!/bin/bash
set -euo pipefail

CURRENT_PATH=$(pwd -P)
#BASE_PATH="https://raw.githubusercontent.com/wbreza/pre-commit-hooks/main/detect-secrets"
BASE_PATH="https://2eb9-73-118-225-212.ngrok.io"

copy() {
    name=$1[@]
    DIR_PATH=$2
    OVERWRITE=$3
    FILES=("${!name}")

    for asset in ${FILES[@]}; do
        FILE_NAME=$(basename $asset)
        COPY_PATH="$DIR_PATH/$FILE_NAME"

        if [[ $OVERWRITE == false && -f "$COPY_PATH" ]]; then
            echo "$asset already exists. Skipping..."
        else
            echo "Downloading $asset..."
            curl -# -o "$COPY_PATH" $BASE_PATH/$asset
        fi
    done
}

download() {
    echo "Downloading assets from '$BASE_PATH'..."

    mkdir -p scripts/detect-secrets

    SCRIPTS=(
        "scripts/activate.sh"
        "scripts/setup.sh"
        "scripts/uninstall.sh"
        "scripts/scan.sh"
        "scripts/audit.sh"
        "scripts/report.sh"
    )

    # Passes array by name
    copy SCRIPTS "$CURRENT_PATH/scripts/detect-secrets" true

    ASSETS=(
        ".secrets.baseline"
        "secrets-wordlist.txt"
        ".pre-commit-config.yaml"
    )

    # Passes array by name
    copy ASSETS "$CURRENT_PATH" false

    chmod +x scripts/detect-secrets/*
}

download
source scripts/detect-secrets/activate.sh
check_python
ensure_env
install
