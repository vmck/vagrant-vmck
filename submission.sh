#!/bin/bash -ex

trap "vagrant destroy -f" EXIT

curl -X GET ${DOWNLOAD_ARCHIVE_URL} > submission.zip
curl -X GET ${DOWNLOAD_SCRIPT_URL} > checker.sh
vagrant up
vagrant ssh -- < checker.sh > result.out
data="$(base64 result.out)"
curl -X POST "http://${INTERFACE_ADDRESS}/done/" -d "{\"token\": \"${DOWNLOAD_ARCHIVE_URL}\", \"output\": \"${data}\"}"
