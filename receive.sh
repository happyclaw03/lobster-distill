#!/bin/bash
# Skill Share - Download and decrypt
# Usage: bash receive.sh <url> <password> <output_name> [tar|file]

set -e

URL="$1"
PASSWORD="$2"
NAME="$3"
TYPE="${4:-tar}"

if [ -z "$URL" ] || [ -z "$PASSWORD" ] || [ -z "$NAME" ]; then
    echo "Usage: bash receive.sh <url> <password> <output_name> [tar|file]"
    echo "  tar  = extract as directory to skills/<name>"
    echo "  file = save as single file"
    exit 1
fi

echo "[+] Downloading..."
curl -s -o "/tmp/${NAME}.enc" "$URL"

if [ ! -f "/tmp/${NAME}.enc" ]; then
    echo "[-] Download failed!"
    exit 1
fi

echo "[+] Decrypting..."
if [ "$TYPE" = "tar" ]; then
    openssl enc -aes-256-cbc -d -pbkdf2 -in "/tmp/${NAME}.enc" -out "/tmp/${NAME}.tar.gz" -k "$PASSWORD"
    echo "[+] Extracting to skills/..."
    mkdir -p "skills/${NAME}"
    tar xzf "/tmp/${NAME}.tar.gz" -C "skills/${NAME}/"
    echo "[+] Done! Skill installed at: skills/${NAME}/"
    echo "[+] Read the docs:"
    echo "    cat skills/${NAME}/SKILL.md"
    rm -f "/tmp/${NAME}.enc" "/tmp/${NAME}.tar.gz"
else
    openssl enc -aes-256-cbc -d -pbkdf2 -in "/tmp/${NAME}.enc" -out "/tmp/${NAME}" -k "$PASSWORD"
    echo "[+] Decrypted to: /tmp/${NAME}"
    echo "[+] Read it:"
    echo "    cat /tmp/${NAME}"
    rm -f "/tmp/${NAME}.enc"
fi
