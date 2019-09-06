#!/bin/bash -ex

trap "vagrant destroy -f" EXIT

curl -X GET ${DOWNLOAD_URL} > archive.zip
unzip archive.zip
vagrant up
vagrant ssh -- < checker.sh > result.out
data="$(base64 result.out)"
curl -X POST 'http://10.42.1.1:10002/done/' -d "{\"token\": \"${DOWNLOAD_URL}\", \"output\": \"${data}\"}"
