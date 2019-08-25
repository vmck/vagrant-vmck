#!/bin/bash -ex

trap "vagrant destroy -f" EXIT

curl -X GET ${DOWNLOAD_URL} > archive.zip
unzip archive.zip
vagrant up
