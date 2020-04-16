#!/bin/bash
set -ex

#
# ./download_iso.sh <dir>
#

if [[ ! -f $1/image.json ]]; then
    echo "image.json not found, exiting"
    exit 1
fi

export ISO_FILENAME=$(cat $1/image.json | jq -r ".iso_name")
export ISO_CHECKSUM=$(cat $1/image.json | jq -r ".iso_checksum" | awk '{print tolower($0)}')
export ISO_URL=$(cat $1/image.json | jq -r ".iso_url")

if [[ ! -d isos ]]; then
    mkdir isos
fi

if [[ ! -f isos/$ISO_FILENAME ]]; then
    wget $ISO_URL -O isos/$ISO_FILENAME
fi

CUR_CHECKSUM=$(sha256sum isos/$ISO_FILENAME | awk '{printf $1}')

if [ "$CUR_CHECKSUM" == "$ISO_CHECKSUM" ]; then
    echo "OK!"
else
    echo "Checksum fail"
    exit 1
fi
